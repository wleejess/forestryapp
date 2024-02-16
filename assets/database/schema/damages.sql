CREATE TABLE if NOT EXISTS damages(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  -- https://stackoverflow.com/a/17203007: Use `CHECK` as an "enum" of sorts.
  category TEXT CHECK(category IN (
    'insects',
    'diseases',
    'invasives'
  )) NOT NULL
);
