using Uno;
using Uno.UX;
using Uno.Text;
using Uno.Threading;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;
using Fuse.Scripting;

namespace Fuse.MediaQuery
{
    extern(!MOBILE)
    class TrackQuery : TrackPromise
    {
        public TrackQuery(string artist)
        {
            Resolve();
        }
    }

    extern(!MOBILE)
    class ArtistQuery : ArtistPromise
    {
        public ArtistQuery(string artist)
        {
            Resolve();
        }
    }
}
