# Fuse.MediaQuery

This is a simple library for querying your device's media library.

Right now only querying for Music (Artists/Albums/Tracks) is supported. But it's a trivial to add more and to broaden what we already have.

## Including the library

To use this in your app you first add a reference to it from your `unoproj` file. For an example see `Examples/Basics/MediaQueryBasics.unoproj`[./Examples/Basics/MediaQueryBasics.unoproj]

Next you `require` it from your javascript code.

```
var MediaQuery = require("FuseJS/MediaQuery");
```

And now you are ready to go.

## How to query for albums

The `album` object looks like this:

```
{
    "name": "someAlbumName",
    "artist": "someArtistName"
}
```

By passing an 'incomplete' album object to the `albums` method you will be given a promise of album objects with the missing details filled. That sounds a bit odd right? This is how it looks like in practice:

```
MediaQuery.albums({"artist": "Alan Gogoll"}).then(function(albumArray) { .. });
```

Notice that by only supplying `"artist"` `MediaQuery` will return all the albums by 'Alan Gogoll'.

Now for the converse:

```
MediaQuery.albums({"album": "Moon"}).then(function(albumArray) { .. });
```

This will return all the albums named 'Moon' along with the names of the artists who made them.

## How to query for Tracks

A track object looks like this:

```
{
    "title": "someTrackName",
    "album": "someAlbumName",
    "artist": "someArtistName"
    "path": "theFileSystemPathToTheFile"
    "duration": 0.0 // length of track in seconds
}
```

And we query for tracks using the `tracks` method.

### Get every track in the library

```
MediaQuery.tracks({}).then(function(tracksArray) { .. });
```

This will give you an array containing every track in your library.

### How about every track by Alan Gogoll?

```
MediaQuery.tracks({"artist": "Alan Gogoll"}).then(function(tracksArray) { .. });
```

### And how about every track in an album by a specific artist

```
MediaQuery.tracks({"artist": "Eric Bibb", "album":"Booker's Guitar"}).then(function(tracksArray) { .. });
```

### And how about every track in an album by any artist?

As before if we want to query for something we simply make a track object with the thing we want to fill in missing.

```
MediaQuery.tracks({album":"Booker's Guitar"}).then(function(tracksArray) { .. });
```

### How about filtering by path or duration?

Sorry, but we don't support that. Duration would be cool, but we would want to be able to filter by a time range.

## How to query for Artists

As before here is the artist object

```
{
    "name": "someArtistName"
}
```

So we get an array of all artists we do this:

```
MediaQuery.artists({}).then(function(tracksArray) { .. });
```

### Why is there even an option for filtering by artist name?

For API consistency and because in future we want to allow searching with wildcards.

### Help! On iOS 10 I get a crash because I hadnt set NSAppleMusicUsageDescription in the plist

To fix this add something like the following in your unoproj:

    "iOS": {
        "PList": {
            "NSAppleMusicUsageDescription": "Your description goes here"
        }
    }

## That's all for now!

I hope you find this library useful. It's an open source project under the MIT license and pull requests are very welcome.

Please add issues for what you want added (but do check with the iOS & Android APIs to make sure it is possible!). Better yet, have a peek at the code! It's a really simple library and extending it is also simple, see [here for the commit](https://github.com/fuse-compound/Fuse.MediaQuery/commit/43af451052b44ab3b3bd828bb44ce1bcb37a3747) where we added `duration` to track.

I'm `baggers` on the Fuse Community slack so feel free to ping me if you need anything explained.

Peace
