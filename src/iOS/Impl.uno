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
                NSString* path = [match.assetURL absoluteString];
                NSString* title = match.title;
                NSString* artist = match.artist;
                NSString* album = match.albumTitle;
                @{TrackQuery:Of(_this).PushResult(string,string,string,string):Call(path, title, artist, album)};
            }
        @}
    }

    [ForeignInclude(Language.ObjC, "AVFoundation/AVFoundation.h")]
    [ForeignInclude(Language.ObjC, "MediaPlayer/MediaPlayer.h")]
    [Require("Xcode.Framework", "MediaPlayer")]
    [Require("Xcode.Framework", "CoreImage")]
    [ForeignInclude(Language.ObjC, "CoreImage/CoreImage.h")]
    extern(iOS)
    class ArtistQuery : ArtistPromise
    {
        public ArtistQuery(string name)
        {
            QueryInner(name);
            Resolve();
        }

        [Foreign(Language.ObjC)]
        public void QueryInner(string name)
        @{
            MPMediaQuery* matches = [MPMediaQuery artistsQuery];

            if (name!=NULL)
            {
                MPMediaPropertyPredicate* artistPred = [MPMediaPropertyPredicate predicateWithValue:name forProperty:MPMediaItemPropertyArtist];
                [matches addFilterPredicate: artistPred];
            }

            for (MPMediaItem* match in [matches items])
            {
                NSString* artist = match.artist;
                @{ArtistQuery:Of(_this).PushResult(string):Call(artist)};
            }
        @}
    }

    [ForeignInclude(Language.ObjC, "AVFoundation/AVFoundation.h")]
    [ForeignInclude(Language.ObjC, "MediaPlayer/MediaPlayer.h")]
    [Require("Xcode.Framework", "MediaPlayer")]
    [Require("Xcode.Framework", "CoreImage")]
    [ForeignInclude(Language.ObjC, "CoreImage/CoreImage.h")]
    extern(iOS)
    class AlbumQuery : AlbumPromise
    {
        public AlbumQuery(string name, string artist)
        {
            QueryInner(name, artist);
            Resolve();
        }

        [Foreign(Language.ObjC)]
        public void QueryInner(string r_name, string r_artist)
        @{
            MPMediaQuery* matches = [MPMediaQuery albumsQuery];

            if (r_name!=NULL)
            {
                MPMediaPropertyPredicate* albumPred = [MPMediaPropertyPredicate predicateWithValue:r_name forProperty:MPMediaItemPropertyAlbumTitle];
                [matches addFilterPredicate: albumPred];
            }
            if (r_artist!=NULL)
            {
                MPMediaPropertyPredicate* artistPred = [MPMediaPropertyPredicate predicateWithValue:r_artist forProperty:MPMediaItemPropertyArtist];
                [matches addFilterPredicate: artistPred];
            }

            for (MPMediaItem* match in [matches items])
            {
                NSString* album = match.albumTitle;
                NSString* artist = match.albumArtist;
                @{AlbumQuery:Of(_this).PushResult(string,string):Call(album, artist)};
            }
        @}
    }
}
