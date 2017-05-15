package com.fuse.MediaQuery;

import android.database.DatabaseUtils;
import android.provider.MediaStore;

public class MMQB //MiniMediaQueryBuilder
{
    private static String _isMusic = MediaStore.Audio.Media.IS_MUSIC + "!=0";

    private String wip;

    private MMQB(String base)
    {
        wip = base;
    }

    public static MMQB Music()
    {
        return new MMQB(_isMusic);
    }

    public static MMQB Albums()
    {
        return new MMQB("");
    }

    public MMQB And(String query, String val)
    {
        if (wip.equals(""))
            wip = query.replace("~", DatabaseUtils.sqlEscapeString(val));
        else
            wip += " AND " + query.replace("~", DatabaseUtils.sqlEscapeString(val));
        return this;
    }

    public MMQB AndArtist(final String artist)
    {
        return And(MediaStore.Audio.Media.ARTIST + "=~", artist);
    }

    public MMQB AndAlbum(final String artist)
    {
        return And(MediaStore.Audio.Albums.ALBUM + "=~", artist);
    }

    public String Build()
    {
        return wip;
    }
}
