urlShortener
--------------
* A small url shortener project written in Haskell

Instructions
------------
* Set up database

```sql
CREATE TABLE urls (longUrl TEXT NOT NULL, UNIQUE(longUrl));
```
