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
    public sealed class TrackItem
    {
        public string Path;

        public TrackItem(string path)
        {
            Path = path;
        }
    }

    class TrackPromise : Promise<List<TrackItem>>
    {
        List<TrackItem> _results = new List<TrackItem>();

        protected void Resolve()
        {
            Resolve(_results);
        }

        protected void Reject(string message)
        {
            Reject(new Exception(message));
        }

        protected void PushResult(string path)
        {
            _results.Add(new TrackItem(path));
        }
    }
}
