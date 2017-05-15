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
    class TrackQuery : TrackPromise
    {
        public TrackQuery(string artist)
        {
            QueryInner(artist);
            Resolve();
        }

        [Foreign(Language.ObjC)]
        public void QueryInner(string artist)
        @{
            MPMediaQuery* matches = [[MPMediaQuery alloc] init];

            if (artist!=NULL)
            {
                MPMediaPropertyPredicate* artistPred = [MPMediaPropertyPredicate predicateWithValue:artist forProperty:MPMediaItemPropertyArtist];
                [matches addFilterPredicate: artistPred];
            }

            for (MPMediaItem* match in [matches items])
            {
                @{TrackQuery:Of(_this).PushResult(string):Call([match.assetURL absoluteString])};
            }
        @}
    }
}
