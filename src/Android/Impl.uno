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
    //------------------------------------------------------------
    // Tracks

    [ForeignInclude(Language.Java, "android.content.ContentResolver")]
    [ForeignInclude(Language.Java, "android.database.Cursor")]
    [ForeignInclude(Language.Java, "android.provider.MediaStore")]
    [ForeignInclude(Language.Java, "com.fuse.MediaQuery.MMQB")]
    extern(Android)
    class TrackQuery : TrackPromise
    {
        string _path = "";
        string _title = "";
        string _artist = "";
        string _album = "";

        public TrackQuery(string artist)
        {
            _artist = artist;
            var permissionPromise = Permissions.Request(Permissions.Android.WRITE_EXTERNAL_STORAGE);
            permissionPromise.Then(OnPermitted, OnRejected);
        }

        [Foreign(Language.Java)]
        public void QueryInner(string requestedArtist)
        @{
            String selection = MMQB.Music().AndArtist(requestedArtist).Build();
            String sortOrder = MediaStore.Audio.Media.TITLE + " ASC";

            ContentResolver cr = com.fuse.Activity.getRootActivity().getContentResolver();
            Cursor cur = cr.query(MediaStore.Audio.Media.EXTERNAL_CONTENT_URI, null, selection, null, sortOrder);
            if(cur != null)
            {
                while(cur.moveToNext())
                {
                    String path = cur.getString(cur.getColumnIndex(MediaStore.Audio.Media.DATA));
                    String title = cur.getString(cur.getColumnIndex(MediaStore.Audio.Media.TITLE));
                    String artist = cur.getString(cur.getColumnIndex(MediaStore.Audio.Media.ARTIST));
                    String album = cur.getString(cur.getColumnIndex(MediaStore.Audio.Media.ALBUM));
                    @{TrackQuery:Of(_this).PushResult(string,string,string,string):Call(path,title,artist,album)};
                }
            }
            cur.close();
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

    //------------------------------------------------------------
    // Artists

    [ForeignInclude(Language.Java, "android.content.ContentResolver")]
    [ForeignInclude(Language.Java, "android.database.Cursor")]
    [ForeignInclude(Language.Java, "android.provider.MediaStore")]
    [ForeignInclude(Language.Java, "com.fuse.MediaQuery.MMQB")]
    extern(Android)
    class ArtistQuery : ArtistPromise
    {
        string _name = "";

        public ArtistQuery(string name)
        {
            _name = name;
            var permissionPromise = Permissions.Request(Permissions.Android.WRITE_EXTERNAL_STORAGE);
            permissionPromise.Then(OnPermitted, OnRejected);
        }

        [Foreign(Language.Java)]
        public void QueryInner(string name)
        @{
            String sortOrder = MediaStore.Audio.Media.ARTIST + " ASC";
            ContentResolver cr = com.fuse.Activity.getRootActivity().getContentResolver();
            Cursor cur = cr.query(MediaStore.Audio.Artists.EXTERNAL_CONTENT_URI, null, null, null, sortOrder);

            // {TODO} add restriction

            if(cur != null)
            {
                while(cur.moveToNext())
                {
                    String artistName = cur.getString(cur.getColumnIndex(MediaStore.Audio.Artists.ARTIST));
                    @{ArtistQuery:Of(_this).PushResult(string):Call(artistName)};
                }
            }
            cur.close();
        @}

        void OnPermitted(PlatformPermission permission)
        {
            QueryInner(_name);
            Resolve();
        }

        void OnRejected(Exception e)
        {
            Reject("StreamingPlayer was not given permissions to play local files: " + e.Message);
        }
    }

    //------------------------------------------------------------
    // Albums

    [ForeignInclude(Language.Java, "android.content.ContentResolver")]
    [ForeignInclude(Language.Java, "android.database.Cursor")]
    [ForeignInclude(Language.Java, "android.provider.MediaStore")]
    [ForeignInclude(Language.Java, "com.fuse.MediaQuery.MMQB")]
    extern(Android)
    class AlbumQuery : AlbumPromise
    {
        string _name = "";

        public AlbumQuery(string name)
        {
            _name = name;
            var permissionPromise = Permissions.Request(Permissions.Android.WRITE_EXTERNAL_STORAGE);
            permissionPromise.Then(OnPermitted, OnRejected);
        }

        [Foreign(Language.Java)]
        public void QueryInner(string name)
        @{
            String sortOrder = MediaStore.Audio.Media.ALBUM+ " ASC";
            ContentResolver cr = com.fuse.Activity.getRootActivity().getContentResolver();
            Cursor cur = cr.query(MediaStore.Audio.Albums.EXTERNAL_CONTENT_URI, null, null, null, sortOrder);

            // {TODO} add restriction

            if(cur != null)
            {
                while(cur.moveToNext())
                {
                    String albumName = cur.getString(cur.getColumnIndex(MediaStore.Audio.Albums.ALBUM));
                    @{AlbumQuery:Of(_this).PushResult(string):Call(albumName)};
                }
            }
            cur.close();
        @}

        void OnPermitted(PlatformPermission permission)
        {
            QueryInner(_name);
            Resolve();
        }

        void OnRejected(Exception e)
        {
            Reject("StreamingPlayer was not given permissions to play local files: " + e.Message);
        }
    }
}
