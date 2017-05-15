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
        public string Title;
        public string Artist;
        public string Album;
        public double Duration;

        public TrackItem(string path, string title, string artist, string album, double duration)
        {
            Path = path;
            Title = title;
            Artist = artist;
            Album = album;
            Duration = duration;
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

        protected void PushResult(string path, string title, string artist, string album, double duration)
        {
            _results.Add(new TrackItem(path, title, artist, album, duration));
        }
    }
}
