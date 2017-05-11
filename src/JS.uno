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

            MediaQuery.Initialize();

            AddMember(new NativeFunction("fetch", (NativeCallback)Fetch));
        }

        static object Fetch(Context c, object[] args)
        {
            var queryObj = (Scripting.Object)args[0];
            string kind = queryObj["kind"];

            if (kind == "music")
                return MediaQuery.Query(MusicQueryFromJS(queryObj));

            return null
        }

        static object MusicQueryFromJS(Scripting.Object query)
        {
            MediaQuery.MusicQuery(StrOrNull("artist"));
            return null
        }

        // {TODO} what's the correct method for this?
        static string StrOrNull(Scripting.Object obj, string key)
        {
            return query.ContainsKey(key) ? query[key] : null;
        }
    }
}
