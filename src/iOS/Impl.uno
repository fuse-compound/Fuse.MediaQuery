using Uno;
using Uno.UX;
using Uno.Text;
using Uno.Threading;
using Uno.Collections;
using Uno.Compiler.ExportTargetInterop;
using Fuse.Scripting;

namespace Fuse.MediaQuery
{
    public static extern(iOS) class MediaQuery
    {
        internal static void Initialize() {}

        public void MusicQuery(string artist)
        {
            QueryInner(artist);
        }

        public ObjC.Object[] QueryInner(string artist)
        @{
            MPMediaQuery *everything = [[MPMediaQuery alloc] init];
            NSArray* items = [everything items];
            return items;
        @}
    }
}
