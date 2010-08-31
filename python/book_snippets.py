# -*- coding: utf-8 -*-

import book_base as BookBase
import lilylib as ly
global _;_=ly._
import re
import os
import copy
# TODO: We are using os.popen3, which has been deprecated since python 2.6. The
# suggested replacement is the Popen function of the subprocess module.
# Unfortunately, on windows this needs the msvcrt module, which doesn't seem
# to be available in GUB?!?!?!
# from subprocess import Popen, PIPE

progress = ly.progress
warning = ly.warning
error = ly.error





####################################################################
# Snippet option handling
####################################################################


#
# Is this pythonic?  Personally, I find this rather #define-nesque. --hwn
#
# Global definitions:
ADDVERSION = 'addversion'
AFTER = 'after'
ALT = 'alt'
BEFORE = 'before'
DOCTITLE = 'doctitle'
EXAMPLEINDENT = 'exampleindent'
FILENAME = 'filename'
FILTER = 'filter'
FRAGMENT = 'fragment'
LANG = 'lang'    ## TODO: This is handled nowhere!
LAYOUT = 'layout'
LILYQUOTE = 'lilyquote'
LINE_WIDTH = 'line-width'
NOFRAGMENT = 'nofragment'
NOGETTEXT = 'nogettext'
NOINDENT = 'noindent'
NOQUOTE = 'noquote'
INDENT = 'indent'
NORAGGED_RIGHT = 'noragged-right'
NOTES = 'body'
NOTIME = 'notime'
OUTPUT = 'output'
OUTPUTIMAGE = 'outputimage'
PAPER = 'paper'
PREAMBLE = 'preamble'
PRINTFILENAME = 'printfilename'
QUOTE = 'quote'
RAGGED_RIGHT = 'ragged-right'
RELATIVE = 'relative'
STAFFSIZE = 'staffsize'
TEXIDOC = 'texidoc'
VERBATIM = 'verbatim'
VERSION = 'lilypondversion'



# NOTIME and NOGETTEXT have no opposite so they aren't part of this
# dictionary.
# NOQUOTE is used internally only.
no_options = {
    NOFRAGMENT: FRAGMENT,
    NOINDENT: INDENT,
}

# Options that have no impact on processing by lilypond (or --process
# argument)
PROCESSING_INDEPENDENT_OPTIONS = (
    ALT, NOGETTEXT, VERBATIM, ADDVERSION,
    TEXIDOC, DOCTITLE, VERSION, PRINTFILENAME)



# Options without a pattern in snippet_options.
simple_options = [
    EXAMPLEINDENT,
    FRAGMENT,
    NOFRAGMENT,
    NOGETTEXT,
    NOINDENT,
    PRINTFILENAME,
    DOCTITLE,
    TEXIDOC,
    LANG,
    VERBATIM,
    FILENAME,
    ALT,
    ADDVERSION
]



####################################################################
# LilyPond templates for the snippets
####################################################################

snippet_options = {
    ##
    NOTES: {
        RELATIVE: r'''\relative c%(relative_quotes)s''',
    },

    ##
    PAPER: {
        INDENT: r'''indent = %(indent)s''',
        LINE_WIDTH: r'''line-width = %(line-width)s''',
        QUOTE: r'''line-width = %(line-width)s - 2.0 * %(exampleindent)s''',
        LILYQUOTE: r'''line-width = %(line-width)s - 2.0 * %(exampleindent)s''',
        RAGGED_RIGHT: r'''ragged-right = ##t''',
        NORAGGED_RIGHT: r'''ragged-right = ##f''',
    },

    ##
    LAYOUT: {
        NOTIME: r'''
 \context {
   \Score
   timing = ##f
 }
 \context {
   \Staff
   \remove "Time_signature_engraver"
 }''',
    },

    ##
    PREAMBLE: {
        STAFFSIZE: r'''#(set-global-staff-size %(staffsize)s)''',
    },
}





FRAGMENT_LY = r'''
%(notes_string)s
{


%% ****************************************************************
%% ly snippet contents follows:
%% ****************************************************************
%(code)s


%% ****************************************************************
%% end ly snippet
%% ****************************************************************
}
'''

def classic_lilypond_book_compatibility (key, value):
    if key == 'singleline' and value == None:
        return (RAGGED_RIGHT, None)

    m = re.search ('relative\s*([-0-9])', key)
    if m:
        return ('relative', m.group (1))

    m = re.match ('([0-9]+)pt', key)
    if m:
        return ('staffsize', m.group (1))

    if key == 'indent' or key == 'line-width':
        m = re.match ('([-.0-9]+)(cm|in|mm|pt|staffspace)', value)
        if m:
            f = float (m.group (1))
            return (key, '%f\\%s' % (f, m.group (2)))

    return (None, None)


PREAMBLE_LY = '''%%%% Generated by %(program_name)s
%%%% Options: [%(option_string)s]
\\include "lilypond-book-preamble.ly"


%% ****************************************************************
%% Start cut-&-pastable-section
%% ****************************************************************

%(preamble_string)s

\paper {
  %(paper_string)s
  force-assignment = #""
  line-width = #(- line-width (* mm  %(padding_mm)f))
}

\layout {
  %(layout_string)s
}
'''


FULL_LY = '''


%% ****************************************************************
%% ly snippet:
%% ****************************************************************
%(code)s


%% ****************************************************************
%% end ly snippet
%% ****************************************************************
'''








####################################################################
# Helper functions
####################################################################

def ps_page_count (ps_name):
    header = file (ps_name).read (1024)
    m = re.search ('\n%%Pages: ([0-9]+)', header)
    if m:
        return int (m.group (1))
    return 0

ly_var_def_re = re.compile (r'^([a-zA-Z]+)[\t ]*=', re.M)
ly_comment_re = re.compile (r'(%+[\t ]*)(.*)$', re.M)
ly_context_id_re = re.compile ('\\\\(?:new|context)\\s+(?:[a-zA-Z]*?(?:Staff\
(?:Group)?|Voice|FiguredBass|FretBoards|Names|Devnull))\\s+=\\s+"?([a-zA-Z]+)"?\\s+')

def ly_comment_gettext (t, m):
    return m.group (1) + t (m.group (2))



class CompileError(Exception):
  pass



####################################################################
# Snippet classes
####################################################################

class Chunk:
    def replacement_text (self):
        return ''

    def filter_text (self):
        return self.replacement_text ()

    def is_plain (self):
        return False

class Substring (Chunk):
    """A string that does not require extra memory."""
    def __init__ (self, source, start, end, line_number):
        self.source = source
        self.start = start
        self.end = end
        self.line_number = line_number
        self.override_text = None

    def is_plain (self):
        return True

    def replacement_text (self):
        if self.override_text:
            return self.override_text
        else:
            return self.source[self.start:self.end]



class Snippet (Chunk):
    def __init__ (self, type, match, formatter, line_number, global_options):
        self.type = type
        self.match = match
        self.checksum = 0
        self.option_dict = {}
        self.formatter = formatter
        self.line_number = line_number
        self.global_options = global_options
        self.replacements = {'program_version': ly.program_version,
                             'program_name': ly.program_name}

    # return a shallow copy of the replacements, so the caller can modify
    # it locally without interfering with other snippet operations
    def get_replacements (self):
        return copy.copy (self.replacements)

    def replacement_text (self):
        return self.match.group ('match')

    def substring (self, s):
        return self.match.group (s)

    def __repr__ (self):
        return `self.__class__` + ' type = ' + self.type



class IncludeSnippet (Snippet):
    def processed_filename (self):
        f = self.substring ('filename')
        return os.path.splitext (f)[0] + self.formatter.default_extension

    def replacement_text (self):
        s = self.match.group ('match')
        f = self.substring ('filename')
        return re.sub (f, self.processed_filename (), s)



class LilypondSnippet (Snippet):
    def __init__ (self, type, match, formatter, line_number, global_options):
        Snippet.__init__ (self, type, match, formatter, line_number, global_options)
        os = match.group ('options')
        self.do_options (os, self.type)


    def snippet_options (self):
        return [];

    def verb_ly_gettext (self, s):
        lang = self.formatter.document_language
        if not lang:
            return s
        try:
            t = langdefs.translation[lang]
        except:
            return s

        s = ly_comment_re.sub (lambda m: ly_comment_gettext (t, m), s)

        if langdefs.LANGDICT[lang].enable_ly_identifier_l10n:
            for v in ly_var_def_re.findall (s):
                s = re.sub (r"(?m)(?<!\\clef)(^|[' \\#])%s([^a-zA-Z])" % v,
                            "\\1" + t (v) + "\\2",
                            s)
            for id in ly_context_id_re.findall (s):
                s = re.sub (r'(\s+|")%s(\s+|")' % id,
                            "\\1" + t (id) + "\\2",
                            s)
        return s

    def verb_ly (self):
        verb_text = self.substring ('code')
        if not NOGETTEXT in self.option_dict:
            verb_text = self.verb_ly_gettext (verb_text)
        if not verb_text.endswith ('\n'):
            verb_text += '\n'
        return verb_text

    def ly (self):
        contents = self.substring ('code')
        return ('\\sourcefileline %d\n%s'
                % (self.line_number - 1, contents))

    def full_ly (self):
        s = self.ly ()
        if s:
            return self.compose_ly (s)
        return ''

    def split_options (self, option_string):
        return self.formatter.split_snippet_options (option_string);

    def do_options (self, option_string, type):
        self.option_dict = {}

        options = self.split_options (option_string)

        for option in options:
            if '=' in option:
                (key, value) = re.split ('\s*=\s*', option)
                self.option_dict[key] = value
            else:
                if option in no_options:
                    if no_options[option] in self.option_dict:
                        del self.option_dict[no_options[option]]
                else:
                    self.option_dict[option] = None


        # If LINE_WIDTH is used without parameter, set it to default.
        has_line_width = self.option_dict.has_key (LINE_WIDTH)
        if has_line_width and self.option_dict[LINE_WIDTH] == None:
            has_line_width = False
            del self.option_dict[LINE_WIDTH]

        # TODO: Can't we do that more efficiently (built-in python func?)
        for k in self.formatter.default_snippet_options:
            if k not in self.option_dict:
                self.option_dict[k] = self.formatter.default_snippet_options[k]

        # RELATIVE does not work without FRAGMENT;
        # make RELATIVE imply FRAGMENT
        has_relative = self.option_dict.has_key (RELATIVE)
        if has_relative and not self.option_dict.has_key (FRAGMENT):
            self.option_dict[FRAGMENT] = None

        if not has_line_width:
            if type == 'lilypond' or FRAGMENT in self.option_dict:
                self.option_dict[RAGGED_RIGHT] = None

            if type == 'lilypond':
                if LINE_WIDTH in self.option_dict:
                    del self.option_dict[LINE_WIDTH]
            else:
                if RAGGED_RIGHT in self.option_dict:
                    if LINE_WIDTH in self.option_dict:
                        del self.option_dict[LINE_WIDTH]

            if QUOTE in self.option_dict or type == 'lilypond':
                if LINE_WIDTH in self.option_dict:
                    del self.option_dict[LINE_WIDTH]

        if not INDENT in self.option_dict:
            self.option_dict[INDENT] = '0\\mm'

        # Set a default line-width if there is none. We need this, because
        # lilypond-book has set left-padding by default and therefore does
        # #(define line-width (- line-width (* 3 mm)))
        # TODO: Junk this ugly hack if the code gets rewritten to concatenate
        # all settings before writing them in the \paper block.
        if not LINE_WIDTH in self.option_dict:
            if not QUOTE in self.option_dict:
                if not LILYQUOTE in self.option_dict:
                    self.option_dict[LINE_WIDTH] = "#(- paper-width \
left-margin-default right-margin-default)"

    def get_option_list (self):
        if not 'option_list' in self.__dict__:
            option_list = []
            for (key, value) in self.option_dict.items ():
                if value == None:
                    option_list.append (key)
                else:
                    option_list.append (key + '=' + value)
            option_list.sort ()
            self.option_list = option_list
        return self.option_list

    def compose_ly (self, code):
        if FRAGMENT in self.option_dict:
            body = FRAGMENT_LY
        else:
            body = FULL_LY

        # Defaults.
        relative = 1
        override = {}
        # The original concept of the `exampleindent' option is broken.
        # It is not possible to get a sane value for @exampleindent at all
        # without processing the document itself.  Saying
        #
        #   @exampleindent 0
        #   @example
        #   ...
        #   @end example
        #   @exampleindent 5
        #
        # causes ugly results with the DVI backend of texinfo since the
        # default value for @exampleindent isn't 5em but 0.4in (or a smaller
        # value).  Executing the above code changes the environment
        # indentation to an unknown value because we don't know the amount
        # of 1em in advance since it is font-dependent.  Modifying
        # @exampleindent in the middle of a document is simply not
        # supported within texinfo.
        #
        # As a consequence, the only function of @exampleindent is now to
        # specify the amount of indentation for the `quote' option.
        #
        # To set @exampleindent locally to zero, we use the @format
        # environment for non-quoted snippets.
        override[EXAMPLEINDENT] = r'0.4\in'
        override[LINE_WIDTH] = '5\\in' # = texinfo_line_widths['@smallbook']
        override.update (self.formatter.default_snippet_options)

        option_list = []
        for option in self.get_option_list ():
            for name in PROCESSING_INDEPENDENT_OPTIONS:
                if option.startswith (name):
                    break
            else:
                option_list.append (option)
        option_string = ','.join (option_list)
        compose_dict = {}
        compose_types = [NOTES, PREAMBLE, LAYOUT, PAPER]
        for a in compose_types:
            compose_dict[a] = []

        option_names = self.option_dict.keys ()
        option_names.sort ()
        for key in option_names:
            value = self.option_dict[key]
            (c_key, c_value) = classic_lilypond_book_compatibility (key, value)
            if c_key:
                if c_value:
                    warning (
                        _ ("deprecated ly-option used: %s=%s") % (key, value))
                    warning (
                        _ ("compatibility mode translation: %s=%s") % (c_key, c_value))
                else:
                    warning (
                        _ ("deprecated ly-option used: %s") % key)
                    warning (
                        _ ("compatibility mode translation: %s") % c_key)

                (key, value) = (c_key, c_value)

            if value:
                override[key] = value
            else:
                if not override.has_key (key):
                    override[key] = None

            found = 0
            for typ in compose_types:
                if snippet_options[typ].has_key (key):
                    compose_dict[typ].append (snippet_options[typ][key])
                    found = 1
                    break

            if not found and key not in simple_options and key not in self.snippet_options ():
                warning (_ ("ignoring unknown ly option: %s") % key)

        # URGS
        if RELATIVE in override and override[RELATIVE]:
            relative = int (override[RELATIVE])

        relative_quotes = ''

        # 1 = central C
        if relative < 0:
            relative_quotes += ',' * (- relative)
        elif relative > 0:
            relative_quotes += "'" * relative

        paper_string = '\n  '.join (compose_dict[PAPER]) % override
        layout_string = '\n  '.join (compose_dict[LAYOUT]) % override
        notes_string = '\n  '.join (compose_dict[NOTES]) % vars ()
        preamble_string = '\n  '.join (compose_dict[PREAMBLE]) % override
        padding_mm = self.global_options.padding_mm

        d = globals().copy()
        d.update (locals())
        d.update (self.global_options.information)
        return (PREAMBLE_LY + body) % d

    def get_checksum (self):
        if not self.checksum:
            # Work-around for md5 module deprecation warning in python 2.5+:
            try:
                from hashlib import md5
            except ImportError:
                from md5 import md5

            # We only want to calculate the hash based on the snippet
            # code plus fragment options relevant to processing by
            # lilypond, not the snippet + preamble
            hash = md5 (self.relevant_contents (self.ly ()))
            for option in self.get_option_list ():
                for name in PROCESSING_INDEPENDENT_OPTIONS:
                    if option.startswith (name):
                        break
                else:
                    hash.update (option)

            ## let's not create too long names.
            self.checksum = hash.hexdigest ()[:10]

        return self.checksum

    def basename (self):
        cs = self.get_checksum ()
        name = '%s/lily-%s' % (cs[:2], cs[2:])
        return name

    final_basename = basename

    def write_ly (self):
        base = self.basename ()
        path = os.path.join (self.global_options.lily_output_dir, base)
        directory = os.path.split(path)[0]
        if not os.path.isdir (directory):
            os.makedirs (directory)
        filename = path + '.ly'
        if os.path.exists (filename):
            existing = open (filename, 'r').read ()

            if self.relevant_contents (existing) != self.relevant_contents (self.full_ly ()):
                warning ("%s: duplicate filename but different contents of orginal file,\n\
printing diff against existing file." % filename)
                ly.stderr_write (self.filter_pipe (self.full_ly (), 'diff -u %s -' % filename))
        else:
            out = file (filename, 'w')
            out.write (self.full_ly ())
            file (path + '.txt', 'w').write ('image of music')

    def relevant_contents (self, ly):
        return re.sub (r'\\(version|sourcefileline|sourcefilename)[^\n]*\n', '', ly)

    def link_all_output_files (self, output_dir, output_dir_files, destination):
        existing, missing = self.all_output_files (output_dir, output_dir_files)
        if missing:
            print '\nMissing', missing
            raise CompileError(self.basename())
        for name in existing:
            if (self.global_options.use_source_file_names
                and isinstance (self, LilypondFileSnippet)):
                base, ext = os.path.splitext (name)
                components = base.split ('-')
                # ugh, assume filenames with prefix with one dash (lily-xxxx)
                if len (components) > 2:
                    base_suffix = '-' + components[-1]
                else:
                    base_suffix = ''
                final_name = self.final_basename () + base_suffix + ext
            else:
                final_name = name
            try:
                os.unlink (os.path.join (destination, final_name))
            except OSError:
                pass

            src = os.path.join (output_dir, name)
            dst = os.path.join (destination, final_name)
            dst_path = os.path.split(dst)[0]
            if not os.path.isdir (dst_path):
                os.makedirs (dst_path)
            os.link (src, dst)


    def all_output_files (self, output_dir, output_dir_files):
        """Return all files generated in lily_output_dir, a set.

        output_dir_files is the list of files in the output directory.
        """
        result = set ()
        missing = set ()
        base = self.basename()
        full = os.path.join (output_dir, base)
        def consider_file (name):
            if name in output_dir_files:
                result.add (name)

        def require_file (name):
            if name in output_dir_files:
                result.add (name)
            else:
                missing.add (name)

        # UGH - junk self.global_options
        skip_lily = self.global_options.skip_lilypond_run
        for required in [base + '.ly',
                         base + '.txt']:
            require_file (required)
        if not skip_lily:
            require_file (base + '-systems.count')

        if 'ddump-profile' in self.global_options.process_cmd:
            require_file (base + '.profile')
        if 'dseparate-log-file' in self.global_options.process_cmd:
            require_file (base + '.log')

        map (consider_file, [base + '.tex',
                             base + '.eps',
                             base + '.texidoc',
                             base + '.doctitle',
                             base + '-systems.texi',
                             base + '-systems.tex',
                             base + '-systems.pdftexi'])
        if self.formatter.document_language:
            map (consider_file,
                 [base + '.texidoc' + self.formatter.document_language,
                  base + '.doctitle' + self.formatter.document_language])

        required_files = self.formatter.required_files (self, base, full, result)
        for f in required_files:
            require_file (f)

        system_count = 0
        if not skip_lily and not missing:
            system_count = int(file (full + '-systems.count').read())

        for number in range(1, system_count + 1):
            systemfile = '%s-%d' % (base, number)
            require_file (systemfile + '.eps')
            consider_file (systemfile + '.pdf')

            # We can't require signatures, since books and toplevel
            # markups do not output a signature.
            if 'ddump-signature' in self.global_options.process_cmd:
                consider_file (systemfile + '.signature')


        return (result, missing)

    def is_outdated (self, output_dir, current_files):
        found, missing = self.all_output_files (output_dir, current_files)
        return missing

    def filter_pipe (self, input, cmd):
        """Pass input through cmd, and return the result."""

        if self.global_options.verbose:
            progress (_ ("Opening filter `%s'\n") % cmd)

        # TODO: Use Popen once we resolve the problem with msvcrt in Windows:
        (stdin, stdout, stderr) = os.popen3 (cmd)
        # p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=PIPE, close_fds=True)
        # (stdin, stdout, stderr) = (p.stdin, p.stdout, p.stderr)
        stdin.write (input)
        status = stdin.close ()

        if not status:
            status = 0
            output = stdout.read ()
            status = stdout.close ()
            error = stderr.read ()

        if not status:
            status = 0
        signal = 0x0f & status
        if status or (not output and error):
            exit_status = status >> 8
            ly.error (_ ("`%s' failed (%d)") % (cmd, exit_status))
            ly.error (_ ("The error log is as follows:"))
            ly.stderr_write (error)
            ly.stderr_write (stderr.read ())
            exit (status)

        if self.global_options.verbose:
            progress ('\n')

        return output

    def get_snippet_code (self):
        return self.substring ('code');

    def filter_text (self):
        """Run snippet bodies through a command (say: convert-ly).

        This functionality is rarely used, and this code must have bitrot.
        """
        code = self.get_snippet_code ();
        s = self.filter_pipe (code, self.global_options.filter_cmd)
        d = {
            'code': s,
            'options': self.match.group ('options')
        }
        return self.formatter.output_simple_replacements (FILTER, d)

    def replacement_text (self):
        base = self.final_basename ()
        return self.formatter.snippet_output (base, self)

    def get_images (self):
        rep = {'base': self.final_basename ()}

        single = '%(base)s.png' % rep
        multiple = '%(base)s-page1.png' % rep
        images = (single,)
        if (os.path.exists (multiple)
            and (not os.path.exists (single)
                 or (os.stat (multiple)[stat.ST_MTIME]
                     > os.stat (single)[stat.ST_MTIME]))):
            count = ps_page_count ('%(base)s.eps' % rep)
            images = ['%s-page%d.png' % (rep['base'], page) for page in range (1, count+1)]
            images = tuple (images)

        return images



re_begin_verbatim = re.compile (r'\s+%.*?begin verbatim.*\n*', re.M)
re_end_verbatim = re.compile (r'\s+%.*?end verbatim.*$', re.M)

class LilypondFileSnippet (LilypondSnippet):
    def __init__ (self, type, match, formatter, line_number, global_options):
        LilypondSnippet.__init__ (self, type, match, formatter, line_number, global_options)
        self.contents = file (BookBase.find_file (self.substring ('filename'), global_options.include_path)).read ()

    def get_snippet_code (self):
        return self.contents;

    def verb_ly (self):
        s = self.contents
        s = re_begin_verbatim.split (s)[-1]
        s = re_end_verbatim.split (s)[0]
        if not NOGETTEXT in self.option_dict:
            s = self.verb_ly_gettext (s)
        if not s.endswith ('\n'):
            s += '\n'
        return s

    def ly (self):
        name = self.substring ('filename')
        return ('\\sourcefilename \"%s\"\n\\sourcefileline 0\n%s'
                % (name, self.contents))

    def final_basename (self):
        if self.global_options.use_source_file_names:
            base = os.path.splitext (os.path.basename (self.substring ('filename')))[0]
            return base
        else:
            return self.basename ()


class LilyPondVersionString (Snippet):
    """A string that does not require extra memory."""
    def __init__ (self, type, match, formatter, line_number, global_options):
        Snippet.__init__ (self, type, match, formatter, line_number, global_options)

    def replacement_text (self):
        return self.formatter.output_simple (self.type, self)


snippet_type_to_class = {
    'lilypond_file': LilypondFileSnippet,
    'lilypond_block': LilypondSnippet,
    'lilypond': LilypondSnippet,
    'include': IncludeSnippet,
    'lilypondversion': LilyPondVersionString,
}
