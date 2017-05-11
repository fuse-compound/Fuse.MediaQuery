using Uno;
using Uno.UX;
using Uno.Text;
using Uno.Threading;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;
using Fuse.Scripting;

namespace Fuse.MediaQuery
{
    [ForeignInclude(Language.ObjC, "AVFoundation/AVFoundation.h")]
    [ForeignInclude(Language.ObjC, "MediaPlayer/MediaPlayer.h")]
    [Require("Xcode.Framework", "MediaPlayer")]
    [Require("Xcode.Framework", "CoreImage")]
    [ForeignInclude(Language.ObjC, "CoreImage/CoreImage.h")]
    extern(iOS)
    class MusicQuery : MusicPromise
    {
        public MusicQuery(string artist)
        {
            QueryInner(artist);
            Resolve(_results);
        }

        [Foreign(Language.ObjC)]
        public void QueryInner(string artist)
        @{
            MPMediaQuery *everything = [[MPMediaQuery alloc] init];
            NSArray* items = [everything items];
        @}
    }
}
