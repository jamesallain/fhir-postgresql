

begin;
drop schema if exists fhir CASCADE;
create schema fhir;

create type fhir.Address as (
  use text,
  type text,
  text text,
  line text,
  city text,
  district text,  
  postalCode text,
  country text,
  period text
);

create type fhir.Attachment as (
  contentType text,
  language text,
  data text,
  url text,
  size int,
  hash text,  
  title text,
  creation text
);

create type fhir.CodeableConcept as (
  coding text,
  text text
);

create type fhir.Coding as (
  system text,
  verison text,
  code text,
  display text,
  userSelected boolean
);

create type fhir.QuantityComparator as enum (
  '<',
  '<=',
  '>=',
  '>'
);

create type fhir.ContactPoint as (
  system text,
  value text,
  use text,
  rank text,  
  period text
);

create type fhir.HumanName as (
  use text,
  text text,
  given text[],
  prefix text[],
  suffix text[],
  Period text
);

create type fhir.High as (
  value decimal,
  unit text,
  system text,
  code text
);

create type fhir.Identifier as (
  use text,
  type text,
  system text,
  value text,
  Period text,
  assigner text
);
create type fhir.Low as (
  value decimal,
  unit text,
  system text,
  code text
);

create type fhir.Meta as (
  verionId text,
  lastUpdated text, --date
  profile text[],
  security text,
  tag text
);

create type fhir.Period as (
  start text, --date
  "end" text --date -- postgres reserved key word
);

create type fhir.Quantity as (
  value decimal,
  comparator text,
  unit text,
  system text,
  code text 
);

create type fhir.Range as (
  low text,
  high text
);

create type fhir.Ratio as (
  numerator text,
  demoninator text
);

create type fhir.SampleData as (
  origin text,
  Period decimal,
  factor decimal,
  lowerLimit decimal,
  upperLimit decimal,
  dimensions integer,
  data text
);

create type fhir.SimpleQuantity as (
  value decimal,
  unit text,
  system text,
  code text
);

create type fhir.Reference as (
  reference text,
  identifier text,
  display text
);

create type fhir.Use as enum (
  'usual',
  'official',
  'temp',
  'nickname',
  'anonymous',
  'old',
  'maiden'
);




ALTER TYPE fhir.Address ALTER ATTRIBUTE Period TYPE fhir.Period;

ALTER TYPE fhir.CodeableConcept ALTER ATTRIBUTE Coding TYPE fhir.Coding[];

ALTER TYPE fhir.ContactPoint ALTER ATTRIBUTE Period TYPE fhir.Period;

ALTER TYPE fhir.HumanName ALTER ATTRIBUTE Use TYPE fhir.Use;
ALTER TYPE fhir.HumanName ALTER ATTRIBUTE Period TYPE fhir.Period;

ALTER TYPE fhir.Identifier ALTER ATTRIBUTE Assigner TYPE fhir.Reference;
ALTER TYPE fhir.Identifier ALTER ATTRIBUTE Period TYPE fhir.Period;
ALTER TYPE fhir.Identifier ALTER ATTRIBUTE Type TYPE fhir.CodeableConcept;

ALTER TYPE fhir.Meta ALTER ATTRIBUTE Security TYPE fhir.Coding[];
ALTER TYPE fhir.Meta ALTER ATTRIBUTE Tag TYPE fhir.Coding[];

ALTER TYPE fhir.Quantity ALTER ATTRIBUTE Comparator TYPE fhir.QauntityComparator;

ALTER TYPE fhir.Range ALTER ATTRIBUTE Low TYPE fhir.Low;
ALTER TYPE fhir.Range ALTER ATTRIBUTE High TYPE fhir.High;

ALTER TYPE fhir.Ratio ALTER ATTRIBUTE Numerator TYPE fhir.Quantity;
ALTER TYPE fhir.Ratio ALTER ATTRIBUTE Demoninator TYPE fhir.Quantity;

--Problem with circular reference 
--Reference is in Idenifier and Idenifier is in Reference
--ALTER TYPE fhir.reference ALTER ATTRIBUTE identifier TYPE fhir.Identifier;

ALTER TYPE fhir.SampleData ALTER ATTRIBUTE Origin TYPE fhir.SimpleQuantity;


--Patient
create table fhir.Patient (
  patient_id           serial primary key, 

  identifier           text,
  active               boolean,
  name                 text,
  telecom              text,
  gender               text,
  birthDate            text,
  deceased             text,
  address              text,
  maritalStatus        text,
  multipleBirth        text, --either boolean or integer
  photo                text,
  contact              text,
  animal               text,
  communication        text,
  generalPractitioner  text,
  managingOrganization text,
  link                 text[],

  id                   text, --start
  fullUrl              text,
  resourceType         text,
  meta                 text
);

ALTER TABLE fhir.Patient ALTER COLUMN identifier TYPE fhir.Identifier[] USING identifier::fhir.identifier[];
ALTER TABLE fhir.Patient ALTER COLUMN name TYPE fhir.HumanName[] USING name::fhir.HumanName[];
ALTER TABLE fhir.Patient ALTER COLUMN telecom TYPE fhir.ContactPoint[] USING telecom::fhir.ContactPoint[];
ALTER TABLE fhir.Patient ALTER COLUMN address TYPE fhir.Address[] USING address::fhir.Address[];
ALTER TABLE fhir.Patient ALTER COLUMN maritalStatus TYPE fhir.CodeableConcept USING maritalStatus::fhir.CodeableConcept;
ALTER TABLE fhir.Patient ALTER COLUMN photo TYPE fhir.Attachment[] USING photo::fhir.Attachment[];
ALTER TABLE fhir.Patient ALTER COLUMN generalPractitioner TYPE fhir.Reference[] USING generalPractitioner::fhir.Reference[];
ALTER TABLE fhir.Patient ALTER COLUMN managingOrganization TYPE fhir.Reference USING managingOrganization::fhir.Reference;

ALTER TABLE fhir.Patient ALTER COLUMN meta TYPE fhir.Meta USING meta::fhir.Meta;

--Observation
create table fhir.Observation (
  observation_id           serial primary key, 

  identifier           text,
  basedOn              text,
  status               text, 
  category             text,
  code                 text,
  subject              text,
  content              text,
  effectiveDateTime    text, --date
  effectivePeriod      text,
  issued               text,
  performer            text,
  valueQuantity        text,
  valueCodeableConcept text,
  valuetext            text,
  valueBoolean         boolean,
  valueRange           text,
  valueRatio           text,
  valueSampleData      text,
  valueAttachment      text,
  valueTime            text,
  valueDateTime        text,
  valuePeriod          text,  
  dataAbsentReason     text,
  interpretation       text,
  comment              text,
  bodySite             text,
  method               text,
  specimen             text,
  device               text,
  referenceRange       text[],
  related              text[],
  component            text[],

  id                   text, --start
  fullUrl              text,
  resourceType         text,
  meta                 text
);


ALTER TABLE fhir.observation ALTER COLUMN identifier TYPE fhir.Identifier[] USING identifier::fhir.Identifier[];
ALTER TABLE fhir.observation ALTER COLUMN basedOn TYPE fhir.Reference[] USING basedOn::fhir.Reference[];
ALTER TABLE fhir.observation ALTER COLUMN category TYPE fhir.CodeableConcept[] USING category::fhir.CodeableConcept[];
ALTER TABLE fhir.observation ALTER COLUMN code TYPE fhir.CodeableConcept USING code::fhir.CodeableConcept;
ALTER TABLE fhir.observation ALTER COLUMN subject TYPE fhir.Reference USING subject::fhir.Reference;
ALTER TABLE fhir.observation ALTER COLUMN content TYPE fhir.Reference USING content::fhir.Reference;
ALTER TABLE fhir.observation ALTER COLUMN effectivePeriod TYPE fhir.Period USING effectivePeriod::fhir.Period;
ALTER TABLE fhir.observation ALTER COLUMN performer TYPE fhir.Reference[] USING performer::fhir.Reference[];
ALTER TABLE fhir.observation ALTER COLUMN valueQuantity TYPE fhir.Quantity USING valueQuantity::fhir.Quantity;
ALTER TABLE fhir.observation ALTER COLUMN valueCodeableConcept TYPE fhir.CodeableConcept USING valueCodeableConcept::fhir.CodeableConcept;
ALTER TABLE fhir.observation ALTER COLUMN valueAttachment TYPE fhir.Attachment USING valueAttachment::fhir.Attachment;
ALTER TABLE fhir.observation ALTER COLUMN valuePeriod TYPE fhir.Period USING valuePeriod::fhir.Period;
ALTER TABLE fhir.observation ALTER COLUMN dataAbsentReason TYPE fhir.CodeableConcept USING dataAbsentReason::fhir.CodeableConcept;
ALTER TABLE fhir.observation ALTER COLUMN interpretation TYPE fhir.CodeableConcept USING interpretation::fhir.CodeableConcept;
ALTER TABLE fhir.observation ALTER COLUMN bodySite TYPE fhir.CodeableConcept USING bodySite::fhir.CodeableConcept;
ALTER TABLE fhir.observation ALTER COLUMN method TYPE fhir.CodeableConcept USING method::fhir.CodeableConcept;
ALTER TABLE fhir.observation ALTER COLUMN specimen TYPE fhir.Reference USING specimen::fhir.Reference;
ALTER TABLE fhir.observation ALTER COLUMN device TYPE fhir.Reference USING device::fhir.Reference;

ALTER TABLE fhir.Patient ALTER COLUMN meta TYPE fhir.Meta USING meta::fhir.Meta;

--NutritionOrder
create table fhir.NutritionOrder (
  nutrition_order_id           serial primary key,

  identifier                   text,
  active                       boolean,
  name                         text
  telecom: [ContactPoint]
  gender: Gender
  birthDate: String
  decreased: Boolean
  address: [Address]
  maritalStatus: [CodeableConcept]
  multipleBirth: Int
  photo: [Attachment]
  contact: [Contact]
  animal: Animal
  communication: [Communication]
  generalPractitioner: [Reference]
  managingOrganization: [Reference]
  link: [Link]
  id                   text, --start
  fullUrl              text,
  resourceType         text,
  meta                 text
);

ALTER TABLE fhir.nutritionOrder ALTER COLUMN identifier TYPE fhir.Identifier[] USING identifier::fhir.Identifier[];
ALTER TABLE fhir.nutritionOrder ALTER COLUMN name TYPE fhir.HumanName[] USING name::fhir.HumanName[];



commit;
