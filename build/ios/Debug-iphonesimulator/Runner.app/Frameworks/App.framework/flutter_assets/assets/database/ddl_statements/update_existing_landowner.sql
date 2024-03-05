UPDATE landowners
   SET name = ?,
       email = ?,
       address = ?,
       city = ?,
       us_state = ?,
       zip = ?
 WHERE id = ?;
