using Uno;
using Uno.UX;
using Uno.Text;
using Uno.Threading;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;
using Fuse;
using Fuse.Scripting;

namespace Fuse.MediaQuery
{
    [UXGlobalModule]
    public sealed class MediaQueryModule : NativeEventEmitterModule
    {
        static readonly MediaQueryModule _instance;

        static T TryGet<T>(Scripting.Object obj, string key)
        {
            return obj.ContainsKey(key) ? Marshal.ToType<T>(obj[key]) : default(T);
        }

        public MediaQueryModule() : base(false)
        {
            if(_instance != null) return;
            Resource.SetGlobalKey(_instance = this, "FuseJS/MediaQuery");

            AddMember(new NativePromise<List<TrackItem>, Scripting.Array>("music", Music, TrackItemToJS));
            AddMember(new NativePromise<List<ArtistItem>, Scripting.Array>("artists", Artists, ArtistItemToJS));
            AddMember(new NativePromise<List<AlbumItem>, Scripting.Array>("albums", Albums, AlbumItemToJS));
        }

        static Future<List<TrackItem>> Music(object[] args)
        {
            var queryObj = (Scripting.Object)args[0];
            return TrackQueryFromJS(queryObj);
        }

        static Future<List<ArtistItem>> Artists(object[] args)
        {
            var queryObj = (Scripting.Object)args[0];
            return ArtistQueryFromJS(queryObj);
        }

        static Future<List<AlbumItem>> Albums(object[] args)
        {
            var queryObj = (Scripting.Object)args[0];
            return AlbumQueryFromJS(queryObj);
        }

        static Future<List<TrackItem>> TrackQueryFromJS(Scripting.Object query)
        {
            return new TrackQuery(TryGet<string>(query, "artist"));
        }

        static Future<List<ArtistItem>> ArtistQueryFromJS(Scripting.Object query)
        {
            return new ArtistQuery(TryGet<string>(query, "name"));
        }

        static Future<List<AlbumItem>> AlbumQueryFromJS(Scripting.Object query)
        {
            return new AlbumQuery(TryGet<string>(query, "name"), TryGet<string>(query, "artist"));
        }

        static Scripting.Array TrackItemToJS(Context c, List<TrackItem> cv)
        {
            var arr = new List<object>();
            foreach (var track in cv)
            {
                var jt = c.NewObject();
                jt["path"] = track.Path;
                jt["title"] = track.Title;
                jt["artist"] = track.Artist;
                jt["album"] = track.Album;
                arr.Add(jt);
            }
            return c.NewArray(arr.ToArray());
        }

        static Scripting.Array ArtistItemToJS(Context c, List<ArtistItem> cv)
        {
            var arr = new List<object>();
            foreach (var artist in cv)
            {
                var jt = c.NewObject();
                jt["name"] = artist.Name;
                arr.Add(jt);
            }
            return c.NewArray(arr.ToArray());
        }

        static Scripting.Array AlbumItemToJS(Context c, List<AlbumItem> cv)
        {
            var arr = new List<object>();
            foreach (var album in cv)
            {
                var jt = c.NewObject();
                jt["name"] = album.Name;
                jt["artist"] = album.Artist;
                arr.Add(jt);
            }
            return c.NewArray(arr.ToArray());
        }
    }
}
