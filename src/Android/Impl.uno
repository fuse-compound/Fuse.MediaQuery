using Uno;
using Uno.UX;
using Uno.Text;
using Uno.Threading;
using Uno.Collections;
using Uno.Permissions;
using Uno.Compiler.ExportTargetInterop;
using Fuse.Scripting;

namespace Fuse.MediaQuery
{
    extern(Android)
    class MusicQuery : MusicPromise
    {
        string _artist;
        public MusicQuery(string artist)
        {
            _artist = artist;
            var permissionPromise = Permissions.Request(Permissions.Android.WRITE_EXTERNAL_STORAGE);
            permissionPromise.Then(OnPermitted, OnRejected);
        }

        [Foreign(Language.Java)]
        public void QueryInner(string artist)
        @{

            //@-{MusicQuery:Of(_this).PushResult(string):Call("foo")};
        @}

        void OnPermitted(PlatformPermission permission)
        {
            QueryInner(_artist);
            Resolve();
        }

        void OnRejected(Exception e)
        {
            Reject("StreamingPlayer was not given permissions to play local files: " + e.Message);
        }
    }
}
