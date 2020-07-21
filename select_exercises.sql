SHOW databases;

use albums_db;

show tables;

describe albums;

SELECT * as 'Albums by Pink Floyd'
from albums
WHERE artist = 'Pink Floyd';

SELECT name
from albums
WHERE artist = 'Pink Floyd';

SELECT release_date 
from albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

SELECT genre 
from albums
WHERE name = 'Nevermind';


SELECT name
from albums
WHERE release_date between 1990 and 1999;

SELECT name
from albums
WHERE sales < 20.0;

SELECT name
from albums 
WHERE genre = 'Rock';

-- To be able to include albums with genre of 'Hard Rock', 'Progressive Rock' etc, must include "like" syntax

-- Example
SELECT name
from albums
WHERE genre like '%rock%';