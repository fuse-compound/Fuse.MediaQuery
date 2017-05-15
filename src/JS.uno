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
        static readonly string _trackQuery = "Music";

        public MediaQueryModule() : base(false)
        {
            if(_instance != null) return;
            Resource.SetGlobalKey(_instance = this, "FuseJS/MediaQuery");

            AddMember(new NativePromise<List<TrackItem>, Scripting.Array>("fetch", Fetch, TrackItemToJS));

            AddMember(new NativeProperty<string, string>("Music", _trackQuery));
        }

        static Future<List<TrackItem>> Fetch(object[] args)
        {
            var queryObj = (Scripting.Object)args[0];
            var kind = (string)queryObj["kind"];

            if (kind == _trackQuery)
                return TrackQueryFromJS(queryObj);

            debug_log "--- DIDNT MATCH ANY KIND ---";
            return null;
        }

        static Future<List<TrackItem>> TrackQueryFromJS(Scripting.Object query)
        {
            return new TrackQuery(TryGet<string>(query, "artist"));
        }

        static T TryGet<T>(Scripting.Object obj, string key)
        {
            return obj.ContainsKey(key) ? Marshal.ToType<T>(obj[key]) : default(T);
        }


        static Scripting.Array TrackItemToJS(Context c, List<TrackItem> cv)
        {
            var arr = new List<object>();
            foreach (var track in cv)
            {
                var jt = c.NewObject();
                jt["kind"] = "track";
                jt["path"] = track.Path;
                jt["title"] = track.Title;
                jt["artist"] = track.Artist;
                jt["album"] = track.Album;
                arr.Add(jt);
            }
            return c.NewArray(arr.ToArray());
        }
    }
}
