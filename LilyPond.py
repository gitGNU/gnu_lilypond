"""LilyPond.py -- A minimal Document-based Cocoa application."""


from PyObjCTools import NibClassBuilder, AppHelper
from Foundation import NSBundle, NSURL
from AppKit import NSWorkspace

NibClassBuilder.extractClasses("TinyTinyDocument")


import URLHandlerClass
import lilycall
import subprocess
import os
import glob
import string
import re
import urllib

from ProcessLog import ProcessLogWindowController

# utility functions
def open_url (url):
        workspace = NSWorkspace.sharedWorkspace ()

        nsurl = NSURL.URLWithString_ (url)
        workspace.openURL_ (nsurl)

def lily_version ():
        bundle =  NSBundle.mainBundle ()
        appdir = NSBundle.mainBundle().bundlePath()
        pattern = appdir + '/Contents/Resources/share/lilypond/[0-9]*'
        versions = glob.glob (pattern)
        version = '2.2.31' 
        if versions:
            version = versions[0]
        
        return tuple (string.split (version, '.'))

def google_lilypond (str):
        (maj,min,pat) = lily_version ()

        url = '%s site:lilypond.org v%s.%s' % (str, maj, min)
        url = re.sub (' ', '+', url)
        url = urllib.quote (url, safe='+')
        url = 'http://www.google.com/search?q=%s' % url
        open_url (url)


# class defined in TinyTinyDocument.nib
class TinyTinyDocument(NibClassBuilder.AutoBaseClass):
    # the actual base class is NSDocument
    # The following outlets are added to the class:
    # textView

    startupPath = None  # fallback if instance has no startupPath.
    
    def windowNibName(self):
        return "TinyTinyDocument"

    def readFromFile_ofType_(self, path, tp):
        if self.textView is None:
            # we're not yet fully loaded
            self.startupPath = path
        else:
            # "revert"
            self.readFromUTF8(path)
            
        return True

    def writeToFile_ofType_(self, path, tp):
        f = file(path, "w")
        text = self.textView.string()
        f.write(text.encode("utf8"))
        f.close()

        return True

    def windowControllerDidLoadNib_(self, controller):
        if self.startupPath:
            self.readFromUTF8 (self.startupPath)
        else:
            appdir = NSBundle.mainBundle().bundlePath()
            prefix = appdir + "/Contents/Resources"
            self.readFromUTF8 (prefix + '/Welcome-to-LilyPond-MacOS.ly')

    def readFromUTF8(self, path):
        f = file(path)
        text = unicode(f.read(), "utf8")
        f.close()
        self.textView.setString_(text)

    def compileFile_ (self, sender):
        if 0:
            self.saveDocumentWithDelegate_didSaveSelector_contextInfo_ (self,
                                                                        "compileDidSaveSelector:",
                                                                        None)
        if self.fileName():
            self.compileMe ()
        else:
            self.saveDocument_ (None)

    def updateSyntax_(self, sender):
        if self.fileName():
            self.updateMySyntax ()
        else:
            self.saveDocument_ (None)

    def createProcessLog (self):
        if not self.processLogWindowController:
            self.processLogWindowController = ProcessLogWindowController()
        else:
            self.processLogWindowController.showWindow_ (None)

    def compileDidSaveSelector_ (doc, didSave, info):
        print "I'm here"
        if didSave:
            doc.compileMe ()

    def revert_ (self, sender):
        self.readFromUTF8 (self.fileName ())

    def updateMySyntax (self):
        env = os.environ.copy()
        bundle =  NSBundle.mainBundle ()
        appdir = NSBundle.mainBundle().bundlePath()
        prefix = appdir + '/Contents/Resources'
        env['LILYPONDPREFIX'] = prefix + '/share/lilypond/current' 
            
        self.writeToFile_ofType_(self.fileName (), None)
        binary = prefix + '/bin/convert-ly'

        pyproc = subprocess.Popen ([binary, '-e', self.fileName ()],
                                   env = env,
                                   stderr = subprocess.STDOUT,
                                   stdout = subprocess.PIPE,
                                   )
        self.createProcessLog ()
        wc = self.processLogWindowController
        wc.setWindowTitle_ ('convert-ly -- ' + self.fileName())
        wc.runProcessWithCallback (pyproc, self.revert_)
        
    def compileMe (self):
        bundle =  NSBundle.mainBundle ()         
        appdir = NSBundle.mainBundle().bundlePath()
        process = call = lilycall.Call (appdir, [self.fileName()])
        call.reroute_output = 1
        
        self.createProcessLog ()
        pyproc = call.get_process()
        wc = self.processLogWindowController
        wc.setWindowTitle_ ('LilyPond -- ' + self.fileName())
        wc.runProcessWithCallback (pyproc, lambda y: call.open_pdfs ())


    def contextHelp_ (self, sender):
        tv = self.textView
        r = tv.selectedRange ()
        
        if r.length == 0:
            (maj,min,pat) = lily_version ()
            open_url ('http://lilypond.org/doc/v%s.%s' % (maj, min))
        else:
            print r.location, r.length
            substr = tv.string()[r.location:r.location + r.length]
            google_lilypond (substr)

        
#        subprocess.call (['/usr/bin/open', url])

if __name__ == "__main__":
    AppHelper.runEventLoop()
