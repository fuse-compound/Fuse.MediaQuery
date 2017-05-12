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

        public MediaQueryModule() : base(false)
        {
            if(_instance != null) return;
            Resource.SetGlobalKey(_instance = this, "FuseJS/MediaQuery");

            AddMember(new NativePromise<List<MusicItem>, Scripting.Array>("fetch", Fetch, MusicItemToJS));

            AddMember(new NativeProperty<string, string>("Music", "music"));
        }

        static Future<List<MusicItem>> Fetch(object[] args)
        {
            var queryObj = (Scripting.Object)args[0];
            var kind = (string)queryObj["kind"];

            if (kind == "music")
                return MusicQueryFromJS(queryObj);

            debug_log "--- DIDNT MATCH ANY KIND ---";
            return null;
        }

        static Future<List<MusicItem>> MusicQueryFromJS(Scripting.Object query)
        {
            return new MusicQuery(TryGet<string>(query, "artist"));
        }

        static T TryGet<T>(Scripting.Object obj, string key)
        {
            return obj.ContainsKey(key) ? Marshal.ToType<T>(obj[key]) : default(T);
        }


        static Scripting.Array MusicItemToJS(Context c, List<MusicItem> cv)
        {
            var arr = new List<object>();
            foreach (var track in cv)
            {
                var jt = c.NewObject();
                jt["path"] = track.Path;
                arr.Add(jt);
            }
            return c.NewArray(arr.ToArray());
        }
    }
}
