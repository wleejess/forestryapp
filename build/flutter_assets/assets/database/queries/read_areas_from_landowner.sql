SELECT *
  FROM areas
 WHERE landowner_id
       IN (SELECT id
             FROM landowners
            WHERE landowners.id = ?);
