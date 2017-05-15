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
    public sealed class ArtistItem
    {
        public string Name;

        public ArtistItem(string name)
        {
            Name = name;
        }
    }

    class ArtistPromise : Promise<List<ArtistItem>>
    {
        List<ArtistItem> _results = new List<ArtistItem>();

        protected void Resolve()
        {
            Resolve(_results);
        }

        protected void Reject(string message)
        {
            Reject(new Exception(message));
        }

        protected void PushResult(string name)
        {
            _results.Add(new ArtistItem(name));
        }
    }
}
