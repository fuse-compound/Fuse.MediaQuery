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
        public string Path;

        public MusicItem(string path)
        {
            Path = path;
        }
    }

    class MusicPromise : Promise<List<MusicItem>>
    {
        List<MusicItem> _results = new List<MusicItem>();

        protected void Resolve()
        {
            Resolve(_results);
        }

        protected void PushResult(string path)
        {
            _results.Add(new MusicItem(path));
        }
    }
}
