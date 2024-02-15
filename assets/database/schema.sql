-- Landowners -----------------------------------------------------------------
CREATE TABLE if NOT EXISTS landowners(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  -- Only single name instead of first and last since wireframe/forms for
  -- landowner only have single name field. May want to change this if we
  -- implement sorting by last name on Landowner Index screen.
  name TEXT NOT NULL,
  address TEXT NOT NULL,
  city TEXT NOT NULL,
  state TEXT NOT NULL,
  zip TEXT NOT NULL
);
