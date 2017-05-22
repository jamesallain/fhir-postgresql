

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

create type fhir.Age as (
  value decimal,
  comparator text, --code
  unit text,
  system text,
  code text
);

--Adminstration - element to EnteralFormula
create type fhir.Administration as (
  schedule text,
  quantity text,
  rateQuantity text,
  rateRatio text
);

create type fhir.Annotation as (
  authorReference text,
  authorString text,
  time text, --date
  text text
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

--ClassHistory - element for Encounter
create type fhir.ClassHistory as (
  class text,
  period text
);

create type fhir.ContactPoint as (
  system text,
  value text,
  use text,
  rank text,  
  period text
);

--Diagnosis - element for Encounter
create type fhir.Diagnosis as (
  condition text,
  role text,
  rank text
);

create type fhir.Duration as (
  value decimal,
  comparator text,
  unit text,
  system text,
  code text
);

create type fhir.EnteralFormula as (
  baseFormulaType text,
  baseFormalProductName text,
  additiveType text,
  caloricDensity text,
  routeOfAdministration text,
  administration text,
  maxVolumeToDeliver text,
  administrationInstruction text
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

--Hospitalization - element for Encounter
create type fhir.Hospitalization as (
  preAdmissionIdentifier text,
  origin text,
  admitScore text,
  reAdmission text
  dietPreference text,
  specialCourtesy text,
  specialArrangement text,
  destination text,
  dischargeDisposition text
);

create type fhir.Identifier as (
  use text,
  type text,
  system text,
  value text,
  Period text,
  assigner text
);

--Location - element for Encounter
create type fhir.Location as (
  location text,
  status text,
  period text
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

create type fhir.Nutrient as (
  modifier text,
  amount text
);

create type fhir.OralDiet as (
  type text,
  schedule text, 
  nutrient text[],
  texture text,
  fluidConsistencyType text,
  instruction text
);

--Participant - element for Encounter
create type fhir.Participant as (
  type text,
  period text,
  individual text
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

create type fhir.QuantityComparator as enum (
  '<',
  '<=',
  '>=',
  '>'
);

create type fhir.Range as (
  low text,
  high text
);

create type fhir.Ratio as (
  numerator text,
  demoninator text
);

--Repeat - element for Timing
create type fhir.Repeat as (
  boundsDuration text,
  boundsRange text,
  boundsPeriod text,
  count integer,
  countMax integer,
  duration decimal,
  durationMax decimal,
  durationUnit text, --code
  fequency integer,
  frequencyMax integer,
  period decimal,
  periodMax decimal,
  periodUnit text, --code
  dayOfWeek text[], --code
  timeOfDay time[], --code
  "when" text[], -- code --reserved word
  "offset" text --code --reserved word
);

create type fhir.SampleData as (
  origin text,
  period decimal,
  factor decimal,
  lowerLimit decimal,
  upperLimit decimal,
  dimensions integer,
  data text
);

--StatusHistory - element for Encounter
create type fhir.StatusHistory as (
  status text,
  period text
);

create type fhir.SimpleQuantity as (
  value decimal,
  unit text,
  system text,
  code text
);

create type fhir.Supplement as (
  type text,
  productName text,
  schedule text,
  quantity text,
  instruction text
);

create type fhir.Timing as (
  event text, --date
  repeat text,
  code text
);


create type fhir.Reaction as (
  substance text,
  manifestation text,
  description text,
  onset text, --date
  severity text,
  exposureRoute text,
  note text
);

create type fhir.Reference as (
  reference text,
  identifier text,
  display text
);

create type fhir.Texture as (
  modifier text,
  foodType text
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

ALTER TYPE fhir.Administration ALTER ATTRIBUTE schedule TYPE fhir.Timing;
ALTER TYPE fhir.Administration ALTER ATTRIBUTE quantity TYPE fhir.SimpleQuantity;
ALTER TYPE fhir.Administration ALTER ATTRIBUTE rateQuantity TYPE fhir.SimpleQuantity;
ALTER TYPE fhir.Administration ALTER ATTRIBUTE rateRatio TYPE fhir.Ratio;

ALTER TYPE fhir.Annotation ALTER ATTRIBUTE authorReference TYPE fhir.Reference;

ALTER TYPE fhir.CodeableConcept ALTER ATTRIBUTE Coding TYPE fhir.Coding[];

ALTER TYPE fhir.ContactPoint ALTER ATTRIBUTE Period TYPE fhir.Period;

ALTER TYPE fhir.EnteralFormula ALTER ATTRIBUTE baseFormulaType TYPE fhir.CodeableConcept;
ALTER TYPE fhir.EnteralFormula ALTER ATTRIBUTE additiveType TYPE fhir.CodeableConcept;
ALTER TYPE fhir.EnteralFormula ALTER ATTRIBUTE caloricDensity TYPE fhir.SimpleQuantity;
ALTER TYPE fhir.EnteralFormula ALTER ATTRIBUTE routeOfAdministration TYPE fhir.CodeableConcept;
ALTER TYPE fhir.EnteralFormula ALTER ATTRIBUTE administration TYPE fhir.Administration[];
ALTER TYPE fhir.EnteralFormula ALTER ATTRIBUTE maxVolumeToDeliver TYPE fhir.SimpleQuantity;

--ALTER TYPE fhir.Duration ALTER ATTRIBUTE Comparator TYPE fhir.Comparator;

--ALTER TYPE fhir.HumanName ALTER ATTRIBUTE Use TYPE fhir.Use;
ALTER TYPE fhir.HumanName ALTER ATTRIBUTE Period TYPE fhir.Period;

ALTER TYPE fhir.Identifier ALTER ATTRIBUTE Assigner TYPE fhir.Reference;
ALTER TYPE fhir.Identifier ALTER ATTRIBUTE Period TYPE fhir.Period;
ALTER TYPE fhir.Identifier ALTER ATTRIBUTE Type TYPE fhir.CodeableConcept;

ALTER TYPE fhir.Meta ALTER ATTRIBUTE Security TYPE fhir.Coding[];
ALTER TYPE fhir.Meta ALTER ATTRIBUTE Tag TYPE fhir.Coding[];

ALTER TYPE fhir.Nutrient ALTER ATTRIBUTE Modifier TYPE fhir.CodeableConcept;
ALTER TYPE fhir.Nutrient ALTER ATTRIBUTE Amount TYPE fhir.SimpleQuantity;

ALTER TYPE fhir.OralDiet ALTER ATTRIBUTE type TYPE fhir.CodeableConcept[];
ALTER TYPE fhir.OralDiet ALTER ATTRIBUTE schedule TYPE fhir.Timing[];
ALTER TYPE fhir.OralDiet ALTER ATTRIBUTE nutrient TYPE fhir.Nutrient[];
ALTER TYPE fhir.OralDiet ALTER ATTRIBUTE texture TYPE fhir.Texture[];
ALTER TYPE fhir.OralDiet ALTER ATTRIBUTE fluidConsistencyType TYPE fhir.CodeableConcept[];

--ALTER TYPE fhir.Quantity ALTER ATTRIBUTE Comparator TYPE fhir.QuantityComparator;

ALTER TYPE fhir.Range ALTER ATTRIBUTE Low TYPE fhir.Low;
ALTER TYPE fhir.Range ALTER ATTRIBUTE High TYPE fhir.High;

ALTER TYPE fhir.Ratio ALTER ATTRIBUTE Numerator TYPE fhir.Quantity;
ALTER TYPE fhir.Ratio ALTER ATTRIBUTE Demoninator TYPE fhir.Quantity;

--Reaction - element to AllergyIntolerance
ALTER TYPE fhir.Reaction ALTER ATTRIBUTE substance TYPE fhir.CodeableConcept;
ALTER TYPE fhir.Reaction ALTER ATTRIBUTE manifestation TYPE fhir.CodeableConcept;
ALTER TYPE fhir.Reaction ALTER ATTRIBUTE exposureRoute TYPE fhir.CodeableConcept;
ALTER TYPE fhir.Reaction ALTER ATTRIBUTE note TYPE fhir.Annotation;

--Repeat - element for Timing
ALTER TYPE fhir.Repeat ALTER ATTRIBUTE boundsDuration TYPE fhir.Duration;
ALTER TYPE fhir.Repeat ALTER ATTRIBUTE boundsRange TYPE fhir.Range;
ALTER TYPE fhir.Repeat ALTER ATTRIBUTE boundsRange TYPE fhir.Period;

--Problem with circular reference 
--Reference is in Idenifier and Idenifier is in Reference
--ALTER TYPE fhir.reference ALTER ATTRIBUTE identifier TYPE fhir.Identifier;

ALTER TYPE fhir.SampleData ALTER ATTRIBUTE Origin TYPE fhir.SimpleQuantity;

ALTER TYPE fhir.Supplement ALTER ATTRIBUTE type TYPE fhir.CodeableConcept[];
ALTER TYPE fhir.Supplement ALTER ATTRIBUTE schedule TYPE fhir.Timing[];
ALTER TYPE fhir.Supplement ALTER ATTRIBUTE quantity TYPE fhir.SimpleQuantity;

ALTER TYPE fhir.Texture ALTER ATTRIBUTE Modifier TYPE fhir.CodeableConcept;
ALTER TYPE fhir.Texture ALTER ATTRIBUTE FoodType TYPE fhir.CodeableConcept;

ALTER TYPE fhir.Timing ALTER ATTRIBUTE Repeat TYPE fhir.Repeat;



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
  observation_id       serial primary key, 

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




--AllergyIntolerance
create table fhir.AllergryIntolerance (
  allergy_intolerance_id  serial primary key, 

  identifier              text,
  clinicalStatus          text, --code
  verificationStatus      text, --code
  type                    text, --code
  category                text[], --code
  criticality             text, --code
  code                    text,
  patient                 text,
  onsetDateTime           text, --date
  onsetAge                text,
  onsetPeriod             text,
  onsetRange              text,
  onsetString             text,
  assertedDate            text,
  recorder                text,
  aserter                 text,
  lastOccurrence          text, --date
  note                    text,
  reaction                text,

  id                   text, --start
  fullUrl              text,
  resourceType         text,
  meta                 text
);

ALTER TABLE fhir.AllergryIntolerance ALTER COLUMN identifier TYPE fhir.Identifier[] USING identifier::fhir.identifier[];
ALTER TABLE fhir.AllergryIntolerance ALTER COLUMN code TYPE fhir.CodeableConcept USING code::fhir.CodeableConcept;
--ALTER TABLE fhir.AllergryIntolerance ALTER COLUMN patient TYPE fhir.Patient USING patient::fhir.Patient;

ALTER TABLE fhir.AllergryIntolerance ALTER COLUMN onsetAge TYPE fhir.Age USING onsetAge::fhir.Age;
ALTER TABLE fhir.AllergryIntolerance ALTER COLUMN onsetPeriod TYPE fhir.Period USING onsetPeriod::fhir.Period;
ALTER TABLE fhir.AllergryIntolerance ALTER COLUMN onsetRange TYPE fhir.Range USING onsetRange::fhir.Range;

ALTER TABLE fhir.AllergryIntolerance ALTER COLUMN recorder TYPE fhir.Reference USING recorder::fhir.Reference;
ALTER TABLE fhir.AllergryIntolerance ALTER COLUMN aserter TYPE fhir.Reference USING aserter::fhir.Reference;

ALTER TABLE fhir.AllergryIntolerance ALTER COLUMN note TYPE fhir.Annotation[] USING note::fhir.Annotation[];
ALTER TABLE fhir.AllergryIntolerance ALTER COLUMN reaction TYPE fhir.Reaction[] USING reaction::fhir.Reaction[];


--Encounter
create table fhir.Encounter (
  encounter_id            serial primary key, 

  identifier              text,
  status                  text, --code
  statusHistory           text, --statusHistory
  class                   text, --code
  classHistory            text, --classHistory
  type                    text, --code
  priority                text,
  subject                 text,
  episodeOfCare           text, 
  incomingReferral        text,
  participant             text, --participant
  appointment             text,
  period                  text,
  length                  text,
  reason                  text,
  diagnosis               text, --diagnosis
  account                 text, 
  hospitalization         text, --hospitalization
  location                text, --location
  serviceProvider         text,
  partOf                  text,

  id                   text, --start
  fullUrl              text,
  resourceType         text,
  meta                 text
);

ALTER TABLE fhir.Encounter ALTER COLUMN identifier TYPE fhir.Identifier[] USING identifier::fhir.identifier[];


ALTER TABLE fhir.Encounter ALTER COLUMN type TYPE fhir.CodeableConcept[] USING type::fhir.CodeableConcept[];
ALTER TABLE fhir.Encounter ALTER COLUMN priority TYPE fhir.CodeableConcept USING priority::fhir.CodeableConcept;

ALTER TABLE fhir.Encounter ALTER COLUMN subject TYPE fhir.Reference USING subject::fhir.Reference;
ALTER TABLE fhir.Encounter ALTER COLUMN episodeOfCare TYPE fhir.Reference[] USING episodeOfCare::fhir.Reference[];
ALTER TABLE fhir.Encounter ALTER COLUMN incomingReferral TYPE fhir.Reference[] USING incomingReferral::fhir.Reference[];
ALTER TABLE fhir.Encounter ALTER COLUMN appointment TYPE fhir.Reference USING appointment::fhir.Reference;
ALTER TABLE fhir.Encounter ALTER COLUMN period TYPE fhir.Period USING period::fhir.Period;
ALTER TABLE fhir.Encounter ALTER COLUMN length TYPE fhir.Duration USING length::fhir.Duration;
ALTER TABLE fhir.Encounter ALTER COLUMN reason TYPE fhir.CodeableConcept[] USING reason::fhir.CodeableConcept[];
ALTER TABLE fhir.Encounter ALTER COLUMN account TYPE fhir.Reference USING account::fhir.Reference;
ALTER TABLE fhir.Encounter ALTER COLUMN serviceProvider TYPE fhir.Reference USING serviceProvider::fhir.Reference;
ALTER TABLE fhir.Encounter ALTER COLUMN partOf TYPE fhir.Reference USING partOf::fhir.Reference;

--NutritionOrder
create table fhir.NutritionOrder (
  nutrition_order_id     serial primary key,
  
  identifier             text,
  status                 text,
  patient                text,
  --encounter              text,
  dateTime               text, --date
  orderer                text,
  allergyIntolerance     text,
  foodPreferenceModifier text,
  excludeFoodModifier    text,
  oralDiet               text,
  supplememt             text,
  enteralFormula         text,

  id                     text, --start
  fullUrl                text,
  resourceType           text,
  meta                   text
);

ALTER TABLE fhir.nutritionOrder ALTER COLUMN identifier TYPE fhir.Identifier[] USING identifier::fhir.Identifier[];
--ALTER TABLE fhir.nutritionOrder ALTER COLUMN patient TYPE fhir.Patient USING patient::fhir.Patient;
--ALTER TABLE fhir.nutritionOrder ALTER COLUMN encounter TYPE fhir.Encounter USING name::fhir.Encounter;
ALTER TABLE fhir.nutritionOrder ALTER COLUMN orderer TYPE fhir.Reference USING orderer::fhir.Reference;
--ALTER TABLE fhir.nutritionOrder ALTER COLUMN allergyIntolerance TYPE fhir.AllergryIntolerance USING allergyIntolerance::fhir.AllergryIntolerance;
ALTER TABLE fhir.nutritionOrder ALTER COLUMN foodPreferenceModifier TYPE fhir.CodeableConcept USING foodPreferenceModifier::fhir.CodeableConcept;
ALTER TABLE fhir.nutritionOrder ALTER COLUMN excludeFoodModifier TYPE fhir.CodeableConcept USING excludeFoodModifier::fhir.CodeableConcept;
ALTER TABLE fhir.nutritionOrder ALTER COLUMN oralDiet TYPE fhir.OralDiet USING oralDiet::fhir.OralDiet;
ALTER TABLE fhir.nutritionOrder ALTER COLUMN supplememt TYPE fhir.Supplement USING supplememt::fhir.Supplement;
ALTER TABLE fhir.nutritionOrder ALTER COLUMN enteralFormula TYPE fhir.EnteralFormula USING enteralFormula::fhir.EnteralFormula;

ALTER TABLE fhir.nutritionOrder ALTER COLUMN meta TYPE fhir.Meta USING meta::fhir.Meta;




commit;
