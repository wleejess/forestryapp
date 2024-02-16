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
