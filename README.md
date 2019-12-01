urlShortener
--------------
* A small url shortener project written in Haskell

Instructions
------------
* start the server

```
stack run
```

* Shorten a url

```
$ curl localhost:9000/minimize\?longUrl\="www.google.com"
{"shortUrlValue":"drew.io/gotrkjis"}%
```

* Expand a shortened URL

```
$ curl localhost:9000/expand\?shortUrl\=drew.io%2Fgotrkjis
{"longUrlValue":"www.facebook.com"}%
```

TODO
-------
* Right now `/expand` requests that aren't found return 500, this should be 4XX.
* Client
