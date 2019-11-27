urlShortener
--------------
* A small url shortener project written in Haskell

Instructions
------------
* Set up database

```sql
CREATE TABLE urls (longUrl TEXT NOT NULL, UNIQUE(longUrl));
```

* start the server

```
stack run
```

* Shorten a url

```
curl localhost:8081/minimize\?longUrl\="www.google.com"
```
