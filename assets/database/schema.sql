-- ASSUMES: foreign key support is turned on in sqflite as well. See
-- https://stackoverflow.com/a/58901851

PRAGMA foreign_keys = ON;

-- Landowners -----------------------------------------------------------------
CREATE TABLE if NOT EXISTS landowners(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  -- Only single name instead of first and last since wireframe/forms for
  -- landowner only have single name field. May want to change this if we
  -- implement sorting by last name on Landowner Index screen.
  name TEXT NOT NULL,
  address TEXT NOT NULL,
  city TEXT NOT NULL,
  -- Validate `us_state` off existing values in `lib/enums/us_state.dart`.
  us_state TEXT CHECK(us_state IN (
    'al',
    'ak',
    'as',
    'az',
    'ar',
    'ca',
    'co',
    'ct',
    'de',
    'dc',
    'fl',
    'ga',
    'gu',
    'hi',
    'id',
    'il',
    'in',
    'ia',
    'ks',
    'ky',
    'la',
    'me',
    'md',
    'ma',
    'mi',
    'mn',
    'ms',
    'mo',
    'mt',
    'ne',
    'nv',
    'nh',
    'nj',
    'nm',
    'ny',
    'nc',
    'nd',
    'mp',
    'oh',
    'ok',
    'or',
    'pa',
    'pr',
    'ri',
    'sc',
    'sd',
    'tn',
    'tx',
    'ut',
    'vt',
    'va',
    'vi',
    'wa',
    'wv',
    'wi',
    'wy'
  ))  NOT NULL,
  zip TEXT NOT NULL
);

-- Areas ----------------------------------------------------------------------
CREATE TABLE if NOT EXISTS areas(
  id INTEGER PRIMARY KEY AUTOINCREMENT,

  -- Many (areas) to one (landowner) relation.
  landowner_id INTEGER REFERENCES landowners(id)
  -- Update/delete areas when their associated landowner is updated/deleted.
  ON DELETE CASCADE
  DEFERRABLE INITIALLY IMMEDIATE,

  name TEXT NOT NULL,

  acres INTEGER CHECK(0 <= acres),

  goals TEXT,

  -- Elevation is measured in feet.
  elevation INTEGER CHECK(0 <= elevation),

  aspect TEXT CHECK(aspect IN (
    'North',
    'North East',
    'East',
    'South East',
    'South',
    'South West',
    'West',
    'North West'
  )),

  slope_percentage INTEGER CHECK(
    0 <= slope_percentage AND slope_percentage <= 100
  ),

  slope_position TEXT CHECK(slope_position IN (
    'lower',
    'middle',
    'upper',
    'ridgetop'
  )),

  soil_information TEXT,

  -- Cover type has no `CHECK` because although there are known cover types the
  -- app also allows users to input their own.
  cover_type TEXT,

  stand_structure TEXT CHECK(stand_structure IN (
    'Even-aged',
    'Two-aged',
    'Multi-aged'
  )),

  overstory_stand_density TEXT CHECK(overstory_stand_density IN (
    'low',
    'medium',
    'high'
  )),

  overstory_species_composition INTEGER CHECK(
    0 <= overstory_species_composition AND overstory_species_composition <= 100
  ),

  understory_stand_density TEXT CHECK(understory_stand_density IN (
    'low',
    'medium',
    'high'
  )),

  understory_species_composition INTEGER CHECK(
    0 <= understory_species_composition AND
    understory_species_composition <= 100
  ),

  history TEXT,

  wildlife_damage TEXT,

  mistletoe_uniformity TEXT CHECK(mistletoe_uniformity IN (
    'uniform',
    'spotty'
  )),

  mistletoe_location TEXT,

  hawksworth TEXT CHECK(hawksworth IN (
    'None (0)',
    'Low (1-2)',
    'Medium (3-4)',
    'High (5-6)'
  )),

  other_issues TEXT,

  water_issues TEXT,

  fire_risk TEXT,

  diagnosis TEXT
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

-- Many-to-Many Relationship: Areas to Damages --------------------------------
CREATE TABLE if NOT EXISTS areas_damages(
  area_id INTEGER REFERENCES areas(id)
  ON DELETE CASCADE
  DEFERRABLE INITIALLY IMMEDIATE
  NOT NULL,
  damage_id INTEGER REFERENCES damages(id)
  ON DELETE CASCADE
  DEFERRABLE INITIALLY IMMEDIATE
  NOT NULL,
  PRIMARY KEY (area_id, damage_id)
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

-- Known Invasives
INSERT INTO damages(category, name) VALUES(
  'invasives', 'False-brome'
);
INSERT INTO damages(category, name) VALUES(
  'invasives', 'Cheatgrass'
);
INSERT INTO damages(category, name) VALUES(
  'invasives', 'Scotch broom'
);
INSERT INTO damages(category, name) VALUES(
  'invasives', 'Gorse'
);
INSERT INTO damages(category, name) VALUES(
  'invasives', 'Holly'
);
INSERT INTO damages(category, name) VALUES(
  'invasives', 'Blackberries'
);
INSERT INTO damages(category, name) VALUES(
  'invasives', 'Honey suckle'
);
INSERT INTO damages(category, name) VALUES(
  'invasives', 'Ivy'
);
INSERT INTO damages(category, name) VALUES(
  'invasives', 'Knapweed'
);
INSERT INTO damages(category, name) VALUES(
  'invasives', 'Shiny-leaf gerannium'
);
