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
$ curl localhost:8081/minimize\?longUrl\="www.google.com"
{"fullUrl":"drew.io/gotrkjis"}%
```

* Expand a shortened URL

```
$ curl localhost:9000/expand\?shortUrl\=drew.io%2Fgotrkjis
{"longUrlText":"www.facebook.com"}%
```
