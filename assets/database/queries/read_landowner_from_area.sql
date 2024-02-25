SELECT *
  FROM landowners
 WHERE landowners.id IN
       (SELECT landowner_id
          FROM areas
         WHERE id = ?);
