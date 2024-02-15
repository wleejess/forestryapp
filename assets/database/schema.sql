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

-- Damages --------------------------------------------------------------------
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

-- Pre-populated Data ---------------------------------------------------------
-- Known Insects
INSERT INTO damages(category, name) VALUES(
  'insects', 'Douglas-fir beetle'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Mt pine Beetle'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Western pine beetle'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Pine engraver (Ips) beetle'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Turpentine beetle'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Spruce beetle'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Fir engraver beetle'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Flat-headed wood borer'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Long-horned wood borer'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Emerald ash borer (invasive)'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Mediterranean oak borer (invasive)'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Asian longhorned beetle (invasive)'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Western spruce budworm'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Tussock moth'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Pandora moth'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Pine butterfly'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Larch casebearer'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Oak Looper'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Spruce aphid'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Balsam woolly adelgid'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Pine needle SCALE'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Elongated hemlock scale (invasive)'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Western pine shoot borer'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Sequoia pitch moth'
);
INSERT INTO damages(category, name) VALUES(
  'insects', 'Oystershell scale'
);

-- Known Diseases
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Laminated root rot'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Armillaria root rot'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Annosus root rot'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Black stain'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Port-Orford-cedar root disease'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Schweinitzii root & butt rot'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Phellinus pini'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Indian paint fungus'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Swiss needle CAST'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Dothistroma needle blight (of pines)'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Elytroderma disease (of ponderosa pine)'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Diplodia'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Western gall rust'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'White pine blister rust'
);
INSERT INTO damages(category, name) VALUES(
  'diseases', 'Commandra rust'
);
