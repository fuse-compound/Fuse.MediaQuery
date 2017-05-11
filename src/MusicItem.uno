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
    public sealed class MusicItem
    {
    }

    class MusicPromise : Promise<List<MusicItem>>
    {
        protected List<MusicItem> _results = new List<MusicItem>();

        protected void PushResult()
        {
            _results.Add(new MusicItem());
        }
    }
}
