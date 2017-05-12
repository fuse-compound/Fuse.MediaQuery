using Uno;
using Uno.UX;
using Uno.Text;
using Uno.Threading;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;
using Fuse.Scripting;

namespace Fuse.MediaQuery
{
    extern(Android)
    class MusicQuery : MusicPromise
    {
        public MusicQuery(string artist)
        {
            Resolve();
        }
    }
}
