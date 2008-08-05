{ @abstract(PasDoc language definitions and translations.)
  @author(Johannes Berg <johannes AT sipsolutions.de>)
  @author(Ralf Junker <delphi AT zeitungsjunge.de>)
  @author(Alexander Lisnevsky <alisnevsky AT yandex.ru> (Russian translation))
  @author(Hendy Irawan <ceefour AT gauldong.net> (Indonesian and Javanese translation))
  @author(Ivan Montes Velencoso (Catalan and Spanish translations))
  @author(Javi (Spanish translation))
  @author(Jean Dit Bailleul (Frensh translation))
  @author(Marc Weustinks (Dutch translation))
  @author(Martin Hansen <mh AT geus.dk> (Danish translation))
  @author(Michele Bersini <michele.bersini AT smartit.it> (Italian translation))
  @author(Peter �imkovi� <simkovic_jr AT manal.sk> (Slovak translation))
  @author(Peter Th�rnqvist <pt AT timemetrics.se> (Swedish translation))
  @author(Rodrigo Urubatan Ferreira Jardim <rodrigo AT netscape.net> (Brasilian translation))
  @author(Alexandre da Silva <simpsomboy AT gmail.com> (Brasilian translation - Update))
  @author(Vitaly Kovalenko <v_l_kovalenko AT alsy.by> (Russian translation))
  @author(Grzegorz Skoczylas <gskoczylas AT rekord.pl> (corrected Polish translation))
  @author(J�n�s Gerg� <jonas.gergo AT ch...> (Hungarian translation))
  @author(Michalis Kamburelis)
  @author(Ascanio Pressato (Some Italian translation))
  @author(JBarbero Quiter (updated Spanish translation))
  @author(Liu Chuanjun <1000copy AT gmail.com> (Chinese gb2312 translation))


The whole unit has been redesigned by DoDi.
The interface should not be affected, but many internals have changed.

Define "old" to get the old version.
}

{-$DEFINE old}

unit PasDoc_Languages;

interface

type
  { An enumeration type of all supported languages }
  TLanguageID = (
    lgBosnian,
    lgBrasilian,
    lgCatalan,
    lgChinese_950,
    lgChinese_gb2312,
    lgDanish,
    lgDutch,
    lgEnglish,
    lgFrench,
    lgGerman,
    lgIndonesian,
    lgItalian,
    lgJavanese,
    lgPolish_CP1250,
    lgPolish_ISO_8859_2,
    lgRussian_1251,
    lgRussian_866,
    lgRussian_koi8,
    lgSlovak,
    lgSpanish,
    lgSwedish,
    lgHungarian_1250
   );

{$IFDEF old}
  { An enumeration type of all static output texts. }
  TTranslationID = (
    trAuthor,
    trAuthors,
    trAutomated,
    trCio,
    trClass,
    trClasses,
    trClassHierarchy,
    trConstants,
    trCreated,
    trDeclaration,
    trDescription,
    trParameters,
    trReturns,
    trExceptions,
    trExceptionsRaised,
    trEnum,
    trDispInterface,
    trFields,
    trFunctionsAndProcedures,
    trHelp,
    trHierarchy,
    trIdentifiers,
    trInterface,
    trLegend,
    trMarker,
    trVisibility,
    trMethods,
    trLastModified,
    trName,
    trNone,
    trObject,
    trObjects,
    trOverview,
    trPrivate,
    trStrictPrivate,
    trProperties,
    trProtected,
    trStrictProtected,
    trPublic,
    trPublished,
    trImplicit,
    trType,
    trTypes,
    trUnit,
    trUnits,
    trVariables,
    trGvUses,
    trGvClasses,

    trHeadlineCio,
    trHeadlineConstants,
    trHeadlineFunctionsAndProcedures,
    trHeadlineIdentifiers,
    trHeadlineTypes,
    trHeadlineUnits,
    trHeadlineVariables,

    trSummaryCio,

    trWarningOverwrite,
    trWarning,

    trGeneratedBy,
    trOnDateTime,

    trDeprecated,
    trPlatformSpecific,
    trLibrarySpecific,

    trIntroduction,
    trConclusion,

    trSearch,
    trSeeAlso,
    trValues,

    trNoCIOs,
    trNoCIOsForHierarchy,
    trNoTypes,
    trNoVariables,
    trNoConstants,
    trNoFunctions,
    trNoIdentifiers,
    trProgram,
    trLibrary,
    trUses);
{$ELSE}
  { An enumeration type of all static output texts.
    Warning: count and order changed!
  }
  TTranslationID = (
  //no translation ID assigned, so far
    trNoTrans,
  //the language name (English, ASCII), e.g. for file names.
    trLanguage,
  //map
    trUnits,
    trClassHierarchy,
    trCio,
    trIdentifiers,
    trGvUses,
    trGvClasses,
  //tables and members
    trClasses,
      trClass,
      trDispInterface,
      trInterface,
    trObjects,
      trObject,
      trRecord,
        trHierarchy,
        trFields,
        trMethods,
        trProperties,
    trLibrary,
    trPackage,
    trProgram,
    trUnit,
      trUses,
      trConstants,
      trFunctionsAndProcedures,
      trTypes,
        trType,
      trVariables,
      trAuthors,
        trAuthor,
      trCreated,
      trLastModified,
    trSubroutine,
      trParameters,
      trReturns,
      trExceptionsRaised,
    trExceptions,
      trException,
    trEnum,

  //visibilities
    trVisibility,
      trPrivate,
      trStrictPrivate,
      trProtected,
      trStrictProtected,
      trPublic,
      trPublished,
      trAutomated,
      trImplicit,
  //hints
    trDeprecated,
    trPlatformSpecific,
    trLibrarySpecific,

  //headings
    trOverview,
    trIntroduction,
    trConclusion,
    trHeadlineCio,
    trHeadlineConstants,
    trHeadlineFunctionsAndProcedures,
    trHeadlineIdentifiers,
    trHeadlineTypes,
    trHeadlineUnits,
    trHeadlineVariables,
    trSummaryCio,
  //column headings
    trDeclaration,
    trDescription,
    trName,
    trValues,

  //empty tables
    trNone,
    trNoCIOs,
    trNoCIOsForHierarchy,
    trNoTypes,
    trNoVariables,
    trNoConstants,
    trNoFunctions,
    trNoIdentifiers,

  //misc
    trHelp,
    trLegend,
    trMarker,

    trWarningOverwrite,
    trWarning,

    trGeneratedBy,
    trOnDateTime,

    trSearch,
    trSeeAlso,
  //add more here
    trDummy
  );

//array holding the translated strings, or empty for default (English) text.
  RTransTable = array[TTranslationID] of string;
  PTransTable = ^RTransTable;

{$ENDIF}

//language descriptor
  PLanguageRecord = ^TLanguageRecord;
  TLanguageRecord = record
    Table: PTransTable;
    Name: string;
    Syntax: string;
    CharSet: string;
  end;

const
  DEFAULT_LANGUAGE = lgEnglish;
  lgDefault = lgEnglish;

type
  { Language class to hold all translated strings }
  TPasDocLanguages = class
  private
    FLanguage: TLanguageID;
    procedure SetLanguage(const Value: TLanguageID);
  protected
  {$IFDEF old}
    FTranslation: array[TTranslationID] of string;
  {$ELSE}
  //the table of the selected language
    pTable: PTransTable;
  {$ENDIF}
    FCharSet: string;
    { @abstract(gets a translation token) }
    function GetTranslation(ATranslationID: TTranslationID): string;
  {$IFDEF old}
    { Defines translations for English (the default). }
    procedure SetLanguageEnglish;
    { Defines translations for Bosnian. }
    procedure SetLanguageBosnian;
    { Defines translations for Brasilian. }
    procedure SetLanguageBrasilian;
    { Defines translations for Catalan. }
    procedure SetLanguageCatalan;
    { Defines translations for Chinese (Codepage 950). }
    procedure SetLanguageChinese_950;
    { Defines translations for Danish. }
    procedure SetLanguageDanish;
    { Defines translations for Dutch. }
    procedure SetLanguageDutch;
    { Defines translations for French. }
    procedure SetLanguageFrench;
    { Defines translations for German }
    procedure SetLanguageGerman;
    { Defines translations for Indonesian. }
    procedure SetLanguageIndonesian;
    { Defines translations for Italian. }
    procedure SetLanguageItalian;
    { Defines translations for Javanese. }
    procedure SetLanguageJavanese;
    { Defines translations for Polish (Codepage 1250). }
    procedure SetLanguagePolish_CP1250;
    { Defines translations for Polish (Codepage ISO 8859-2). }
    procedure SetLanguagePolish_ISO_8859_2;
    { Defines translations for Russian (Codepage 1251). }
    procedure SetLanguageRussian_1251;
    { Defines translations for Slovak. }
    procedure SetLanguageSlovak;
    { Defines translations for Spanish. }
    procedure SetLanguageSpanish;
    { Defines translations for Swedish. }
    procedure SetLanguageSwedish;
    { Defines translations for Hungarian (Codepage 1250). }
    procedure SetLanguageHungarian_1250;
  {$ELSE}
    procedure SetTranslation(id: TTranslationID; const into: string);
    property FTranslation[id: TTranslationID]: string
      read GetTranslation write SetTranslation;
    //following languages/codepages need transformation into tables
  {$ENDIF}
    procedure SetLanguageChinese_gb2312;
    { Defines translations for Russian (Codepage 866). }
    procedure SetLanguageRussian_866;
    { Defines translations for Russian (KOI-8). }
    procedure SetLanguageRussian_koi8;


  public
    { Charset for current language }
    property CharSet: string read FCharSet;
    property Translation[ATranslationID: TTranslationID]: string read GetTranslation;
    constructor Create;
    property Language: TLanguageID read FLanguage write SetLanguage
      default DEFAULT_LANGUAGE;
  end;

//Some GUI helpers
{}

//Full language name
function LanguageFromIndex(i: integer): string;

//Language abbreviation
function SyntaxFromIndex(i: integer): string;

//Search for language by short or long name
function IDfromLanguage(const s: string): TLanguageID;

//Manual translation of id into lang
function Translation(id: TTranslationID; lang: TLanguageID): string;

{ Find a language with Syntax = S (case ignored).
  Returns @true and sets LanguageId if found, otherwise returns @false. }
function LanguageFromStr(S: string; out LanguageId: TLanguageID): boolean;

//access LANGUAGE_ARRAY
function LanguageDescriptor(id: TLanguageID): PLanguageRecord;

implementation

{$IFDEF fpc}
{$ELSE}
//Delphi
uses
  SysUtils;
{$ENDIF}

const
(* Translation markers
  For ease of finding missing translations, special markers can be used:
  strToDo should be obvious ;-)
  strKeep means to keep the English (default language) wording.
*)
{$IFDEF debug}
  strKeep = '='; //keep English wording
  strToDo = '?'; //to be translated
{$ELSE}
  strKeep = ''; //'='? keep English wording
  strToDo = ''; //'?'? to be translated
{$ENDIF}

(* New language template. To add a new language or encoding:

1)  Copy aNewLanguage into a const section and rename it to the new language name.

2)  Put a reference to the new const array into LANGUAGE_ARRAY[...].Table.

3)  Then replace all occurences of strToDo by your translation of the text in the comment,
  or rename them into strKeep for all strings that need no translation,
  or leave the strToDo in place, it will be replaced by the default (English) text.
*)
var //writeable, for old (explicit) setup
  aNewLanguage: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} strToDo, //<<<<<< replace with the name of the new language
  //map
    {trUnits} strToDo, //'Units',
    {trClassHierarchy} strToDo, //'Class Hierarchy',
    {trCio} strToDo, //'Classes, Interfaces, Objects and Records',
    {trIdentifiers} strToDo, //'Identifiers',
    {trGvUses} strToDo, //'Unit dependency graph',
    {trGvClasses} strToDo, //'Classes hierarchy graph',
  //tables and members
    {trClasses} strToDo, //'Classes',
      {trClass} strToDo, //'Class',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} strToDo, //'Interface',
    {trObjects} strToDo, //'Objects',
      {trObject} strToDo, //'Object',
      {trRecord} strToDo, //'Record',
        {trHierarchy} strToDo, //'Hierarchy',
        {trFields} strToDo, //'Fields',
        {trMethods} strToDo, //'Methods',
        {trProperties} strToDo, //'Properties',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} strToDo, //'Unit',
      {trUses} strToDo, //'Uses',
      {trConstants} strToDo, //'Constants',
      {trFunctionsAndProcedures} strToDo, //'Functions and Procedures',
      {trTypes} strToDo, //'Types',
        {trType} strToDo, //'Type',
      {trVariables} strToDo, //'Variables',
      {trAuthors} strToDo, //'Authors',
        {trAuthor} strToDo, //'Author',
      {trCreated} strToDo, //'Created',
      {trLastModified} strToDo, //'Last Modified',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} strToDo, //'Parameters',
      {trReturns} strToDo, //'Returns',
      {trExceptionsRaised} strToDo, //'Exceptions raised',
    {trExceptions} strToDo, //'Exceptions',
      {trException} strToDo, //'Exception',
    {trEnum} strToDo, //'Enumeration',
  //visibilities
    {trVisibility} strToDo, //'Visibility',
      {trPrivate} strToDo, //'Private',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} strToDo, //'Protected',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} strToDo, //'Public',
      {trPublished} strToDo, //'Published',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} strToDo, //'this symbol is deprecated',
    {trPlatformSpecific} strToDo, //'this symbol is specific to some platform',
    {trLibrarySpecific} strToDo, //'this symbol is specific to some library',
  //headings
    {trOverview} strToDo, //'Overview',
    {trIntroduction} strToDo, //'Introduction',
    {trConclusion} strToDo, //'Conclusion',
    {trHeadlineCio} strToDo, //'All Classes, Interfaces, Objects and Records',
    {trHeadlineConstants} strToDo, //'All Constants',
    {trHeadlineFunctionsAndProcedures} strToDo, //'All Functions and Procedures',
    {trHeadlineIdentifiers} strToDo, //'All Identifiers',
    {trHeadlineTypes} strToDo, //'All Types',
    {trHeadlineUnits} strToDo, //'All Units',
    {trHeadlineVariables} strToDo, //'All Variables',
    {trSummaryCio} strToDo, //'Summary of Classes, Interfaces, Objects and Records',
  //column headings
    {trDeclaration} strToDo, //'Declaration',
    {trDescription} strToDo, //'Description',
    {trName} strToDo, //'Name',
    {trValues} strToDo, //'Values',
  //empty
    {trNone} strToDo, //'None',
    {trNoCIOs} strToDo, //'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} strToDo, //'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} strToDo, //'The units do not contain any types.',
    {trNoVariables} strToDo, //'The units do not contain any variables.',
    {trNoConstants} strToDo, //'The units do not contain any constants.',
    {trNoFunctions} strToDo, //'The units do not contain any functions or procedures.',
    {trNoIdentifiers} strToDo, //'The units do not contain any identifiers.',
  //misc
    {trHelp} strToDo, //'Help',
    {trLegend} strToDo, //'Legend',
    {trMarker} strToDo, //'Marker',
    {trWarningOverwrite} strToDo, //'Warning: Do not edit - this file has been created automatically and is likely be overwritten',
    {trWarning} strToDo, //'Warning',
    {trGeneratedBy} strToDo, //'Generated by',
    {trOnDateTime} strToDo, //'on',
    {trSearch} strToDo, //'Search',
    {trSeeAlso} strToDo, //'See also',
    ''  //dummy
  );

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageEnglish;
begin
  FTranslation[trAuthor] := 'Author';
  FTranslation[trAuthors] := 'Authors';
  FTranslation[trAutomated] := 'Automated';
  FTranslation[trCio] := 'Classes, Interfaces, Objects and Records';
  FTranslation[trClass] := 'Class';
  FTranslation[trClasses] := 'Classes';
  FTranslation[trClassHierarchy] := 'Class Hierarchy';
  FTranslation[trConstants] := 'Constants';
  FTranslation[trCreated] := 'Created';
  FTranslation[trDeclaration] := 'Declaration';
  FTranslation[trDescription] := 'Description';
  FTranslation[trParameters] := 'Parameters';
  FTranslation[trReturns] := 'Returns';
  FTranslation[trExceptions] := 'Exceptions';
  FTranslation[trExceptionsRaised] := 'Exceptions raised';
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Fields';
  FTranslation[trFunctionsAndProcedures] := 'Functions and Procedures';
  FTranslation[trHelp] := 'Help';
  FTranslation[trHierarchy] := 'Hierarchy';
  FTranslation[trIdentifiers] := 'Identifiers';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'Legend';
  FTranslation[trMarker] := 'Marker';
  FTranslation[trVisibility] := 'Visibility';
  FTranslation[trMethods] := 'Methods';
  FTranslation[trLastModified] := 'Last Modified';
  FTranslation[trName] := 'Name';
  FTranslation[trNone] := 'None';
  FTranslation[trObject] := 'Object';
  FTranslation[trObjects] := 'Objects';
  FTranslation[trOverview] := 'Overview';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trStrictPrivate] := 'Strict Private';
  FTranslation[trProperties] := 'Properties';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trStrictProtected] := 'Strict Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Type';
  FTranslation[trTypes] := 'Types';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Units';
  FTranslation[trVariables] := 'Variables';
  FTranslation[trGvUses] := 'Unit dependency graph';
  FTranslation[trGvClasses] := 'Classes hierarchy graph';
  FTranslation[trHeadlineCio] := 'All Classes, Interfaces, Objects and Records';
  FTranslation[trHeadlineConstants] := 'All Constants';
  FTranslation[trHeadlineFunctionsAndProcedures] := 'All Functions and Procedures';
  FTranslation[trHeadlineIdentifiers] := 'All Identifiers';
  FTranslation[trHeadlineTypes] := 'All Types';
  FTranslation[trHeadlineUnits] := 'All Units';
  FTranslation[trHeadlineVariables] := 'All Variables';
  FTranslation[trSummaryCio] := 'Summary of Classes, Interfaces, Objects and Records';
  FTranslation[trWarningOverwrite] :=
    'Warning: Do not edit - this file has been created automatically and is likely be overwritten';
  FTranslation[trWarning] := 'Warning';
  FTranslation[trGeneratedBy] := 'Generated by';
  FTranslation[trOnDateTime] := 'on';
  FTranslation[trDeprecated] := 'this symbol is deprecated';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library';
  FTranslation[trIntroduction] := 'Introduction';
  FTranslation[trConclusion] := 'Conclusion';
  FTranslation[trSearch] := 'Search';
  FTranslation[trSeeAlso] := 'See also';
  FTranslation[trValues] := 'Values';
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.';
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.';
  FTranslation[trNoTypes] := 'The units do not contain any types.';
  FTranslation[trNoVariables] := 'The units do not contain any variables.';
  FTranslation[trNoConstants] := 'The units do not contain any constants.';
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.';
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.';
  FTranslation[trProgram] := 'Program';
  FTranslation[trLibrary] := 'Library';
  FTranslation[trUses] := 'Uses';
end;
{$ELSE}

const
  aEnglish: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'English',
  //map
    {trUnits} 'Units',
    {trClassHierarchy} 'Class Hierarchy',
    {trCio} 'Classes, Interfaces, Objects and Records',
    {trIdentifiers} 'Identifiers',
    {trGvUses} 'Unit dependency graph',
    {trGvClasses} 'Classes hierarchy graph',
  //tables and members
    {trClasses} 'Classes',
      {trClass} 'Class',
      {trDispInterface} 'DispInterface',
      {trInterface} 'Interface',
    {trObjects} 'Objects',
      {trObject} 'Object',
      {trRecord} 'Record',
        {trHierarchy} 'Hierarchy',
        {trFields} 'Fields',
        {trMethods} 'Methods',
        {trProperties} 'Properties',
    {trLibrary} 'Library',
    {trPackage} 'Package',
    {trProgram} 'Program',
    {trUnit} 'Unit',
      {trUses} 'Uses',
      {trConstants} 'Constants',
      {trFunctionsAndProcedures} 'Functions and Procedures',
      {trTypes} 'Types',
        {trType} 'Type',
      {trVariables} 'Variables',
      {trAuthors} 'Authors',
        {trAuthor} 'Author',
      {trCreated} 'Created',
      {trLastModified} 'Last Modified',
    {trSubroutine} 'Subroutine',
      {trParameters} 'Parameters',
      {trReturns} 'Returns',
      {trExceptionsRaised} 'Exceptions raised',
    {trExceptions} 'Exceptions',
      {trException} 'Exception',
    {trEnum} 'Enumeration',
  //visibilities
    {trVisibility} 'Visibility',
      {trPrivate} 'Private',
      {trStrictPrivate} 'Strict Private',
      {trProtected} 'Protected',
      {trStrictProtected} 'Strict Protected',
      {trPublic} 'Public',
      {trPublished} 'Published',
      {trAutomated} 'Automated',
      {trImplicit} 'Implicit',
  //hints
    {trDeprecated} 'this symbol is deprecated',
    {trPlatformSpecific} 'this symbol is specific to some platform',
    {trLibrarySpecific} 'this symbol is specific to some library',
  //headings
    {trOverview} 'Overview',
    {trIntroduction} 'Introduction',
    {trConclusion} 'Conclusion',
    {trHeadlineCio} 'All Classes, Interfaces, Objects and Records',
    {trHeadlineConstants} 'All Constants',
    {trHeadlineFunctionsAndProcedures} 'All Functions and Procedures',
    {trHeadlineIdentifiers} 'All Identifiers',
    {trHeadlineTypes} 'All Types',
    {trHeadlineUnits} 'All Units',
    {trHeadlineVariables} 'All Variables',
    {trSummaryCio} 'Summary of Classes, Interfaces, Objects and Records',
  //column headings
    {trDeclaration} 'Declaration',
    {trDescription} 'Description',
    {trName} 'Name',
    {trValues} 'Values',
  //empty
    {trNone} 'None',
    {trNoCIOs} 'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} 'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} 'The units do not contain any types.',
    {trNoVariables} 'The units do not contain any variables.',
    {trNoConstants} 'The units do not contain any constants.',
    {trNoFunctions} 'The units do not contain any functions or procedures.',
    {trNoIdentifiers} 'The units do not contain any identifiers.',
  //misc
    {trHelp} 'Help',
    {trLegend} 'Legend',
    {trMarker} 'Marker',
    {trWarningOverwrite} 'Warning: Do not edit - this file has been created automatically and is likely be overwritten',
    {trWarning} 'Warning',
    {trGeneratedBy} 'Generated by',
    {trOnDateTime} 'on',
    {trSearch} 'Search',
    {trSeeAlso} 'See also',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageBosnian;
begin
  FTranslation[trAuthor] := 'Autor';
  FTranslation[trAuthors] := 'Autori';
  FTranslation[trCio] := 'Klase, Interfejsi i Objekti';
  FTranslation[trClass] := 'Klasa';
  FTranslation[trClasses] := 'Klase';
  FTranslation[trClassHierarchy] := 'Klasna hijerarhija';
  FTranslation[trConstants] := 'Konstante';
  FTranslation[trCreated] := 'Kreirano';
  FTranslation[trDeclaration] := 'Deklaracija';
  FTranslation[trDescription] := 'Opis';
  FTranslation[trParameters] := 'Parameters';
  FTranslation[trReturns] := 'Returns';
  FTranslation[trExceptions] := 'Exceptions'; // TODO: translate
  FTranslation[trExceptionsRaised] := 'Exceptions raised'; // TODO: translate
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Polja';
  FTranslation[trFunctionsAndProcedures] := 'Funkcije i Procedure';
  FTranslation[trHelp] := 'Pomo�';
  FTranslation[trHierarchy] := 'Hijerarhija';
  FTranslation[trIdentifiers] := 'Identifikatori';
  FTranslation[trInterface] := 'Interfejs';
  FTranslation[trLegend] := 'Legenda';
  FTranslation[trMarker] := 'Marker'; // TODO: translate
  FTranslation[trVisibility] := 'Visibility'; // TODO: translate
  FTranslation[trMethods] := 'Metode';
  FTranslation[trLastModified] := 'Zadnja promjena';
  FTranslation[trName] := 'Ime';
  FTranslation[trNone] := 'Ni�ta';
  FTranslation[trObject] := 'Objekt';
  FTranslation[trObjects] := 'Objekti';
  FTranslation[trOverview] := 'Pregled';
  FTranslation[trPrivate] := 'Privatni';
  FTranslation[trProperties] := 'Osibine';
  FTranslation[trProtected] := 'Za�ti�en';
  FTranslation[trPublic] := 'Publikovan';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Javan';
  FTranslation[trType] := 'Tip';
  FTranslation[trTypes] := 'Tipovi';
  FTranslation[trUnit] := 'Fajl';
  FTranslation[trUnits] := 'Fajlovi';
  FTranslation[trVariables] := 'Promjenjive';
  FTranslation[trGvUses] := 'Unit dependency graph'; // TODO: translate
  FTranslation[trGvClasses] := 'Classes hierarchy graph'; // TODO: translate
  FTranslation[trHeadlineCio] := 'Sve Klase, Interfejsi i Objekti';
  FTranslation[trHeadlineConstants] := 'Sve Konstante';
  FTranslation[trHeadlineFunctionsAndProcedures] :=
    'Sve Funkcije i Procedure';
  FTranslation[trHeadlineIdentifiers] := 'Svi Identifikatoti';
  FTranslation[trHeadlineTypes] := 'Svi Tipovi';
  FTranslation[trHeadlineUnits] := 'Svi Fajlovi';
  FTranslation[trHeadlineVariables] := 'Sve Varijable';
  FTranslation[trSummaryCio] := 'Zbirno od Klasa, Interfejsa i Objekata';
  FTranslation[trWarningOverwrite] :=
    'Upozorenje: Ne mjenjajte fajl - ovaj fajl je kreiran automatski i velika je vjerovatno�a da �e biti prepisan';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trGeneratedBy] := 'Generated by'; // TODO: translate
  FTranslation[trOnDateTime] := 'on'; // TODO: translate
  FTranslation[trDeprecated] := 'this symbol is deprecated'; // TODO: translate
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform'; // TODO: translate
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library'; // TODO: translate
  FTranslation[trIntroduction] := 'Introduction'; // TODO: translate
  FTranslation[trConclusion] := 'Conclusion'; // TODO: translate
  FTranslation[trSearch] := 'Search'; // TODO: translate
  FTranslation[trSeeAlso] := 'See also'; // TODO: translate
  FTranslation[trValues] := 'Values'; // TODO: translate
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.'; // TODO: translate
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.'; // TODO: translate
  FTranslation[trNoTypes] := 'The units do not contain any types.'; // TODO: translate
  FTranslation[trNoVariables] := 'The units do not contain any variables.'; // TODO: translate
  FTranslation[trNoConstants] := 'The units do not contain any constants.'; // TODO: translate
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.'; // TODO: translate
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.'; // TODO: translate
  FTranslation[trProgram] := 'Program'; // TODO: translate
end;
{$ELSE}
const
  aBosnian: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Bosnian',
  //map
    {trUnits} 'Fajlovi',
    {trClassHierarchy} 'Klasna hijerarhija',
    {trCio} 'Klase, Interfejsi i Objekti',
    {trIdentifiers} 'Identifikatori',
    {trGvUses} strToDo, //'Unit dependency graph',
    {trGvClasses} strToDo, //'Classes hierarchy graph',
  //tables and members
    {trClasses} 'Klase',
      {trClass} 'Klasa',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} 'Interfejs',
    {trObjects} 'Objekti',
      {trObject} 'Objekt',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Hijerarhija',
        {trFields} 'Polja',
        {trMethods} 'Metode',
        {trProperties} 'Osibine',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} 'Fajl',
      {trUses} strToDo, //'Uses',
      {trConstants} 'Konstante',
      {trFunctionsAndProcedures} 'Funkcije i Procedure',
      {trTypes} 'Tipovi',
        {trType} 'Tip',
      {trVariables} 'Promjenjive',
      {trAuthors} 'Autori',
        {trAuthor} 'Autor',
      {trCreated} 'Kreirano',
      {trLastModified} 'Zadnja promjena',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} strToDo, //'Parameters',
      {trReturns} strToDo, //'Returns',
      {trExceptionsRaised} strToDo, //'Exceptions raised',
    {trExceptions} strToDo, //'Exceptions',
      {trException} strToDo, //'Exception',
    {trEnum} strToDo, //'Enumeration',
  //visibilities
    {trVisibility} strToDo, //'Visibility',
      {trPrivate} 'Privatni',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} 'Za�ti�en',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} 'Publikovan',
      {trPublished} 'Javan',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} strToDo, //'this symbol is deprecated',
    {trPlatformSpecific} strToDo, //'this symbol is specific to some platform',
    {trLibrarySpecific} strToDo, //'this symbol is specific to some library',
  //headings
    {trOverview} 'Pregled',
    {trIntroduction} strToDo, //'Introduction',
    {trConclusion} strToDo, //'Conclusion',
    {trHeadlineCio} 'Sve Klase, Interfejsi i Objekti',
    {trHeadlineConstants} 'Sve Konstante',
    {trHeadlineFunctionsAndProcedures} 'Sve Funkcije i Procedure',
    {trHeadlineIdentifiers} 'Svi Identifikatoti',
    {trHeadlineTypes} 'Svi Tipovi',
    {trHeadlineUnits} 'Svi Fajlovi',
    {trHeadlineVariables} 'Sve Varijable',
    {trSummaryCio} 'Zbirno od Klasa, Interfejsa i Objekata',
  //column headings
    {trDeclaration} 'Deklaracija',
    {trDescription} 'Opis',
    {trName} 'Ime',
    {trValues} strToDo, //'Values',
  //empty
    {trNone} 'Ni�ta',
    {trNoCIOs} strToDo, //'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} strToDo, //'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} strToDo, //'The units do not contain any types.',
    {trNoVariables} strToDo, //'The units do not contain any variables.',
    {trNoConstants} strToDo, //'The units do not contain any constants.',
    {trNoFunctions} strToDo, //'The units do not contain any functions or procedures.',
    {trNoIdentifiers} strToDo, //'The units do not contain any identifiers.',
  //misc
    {trHelp} 'Pomo�',
    {trLegend} 'Legenda',
    {trMarker} strToDo, //'Marker',
    {trWarningOverwrite} 'Upozorenje: Ne mjenjajte fajl - ovaj fajl je kreiran automatski i velika je vjerovatno�a da �e biti prepisan',
    {trWarning} strToDo, //'Warning',
    {trGeneratedBy} strToDo, //'Generated by',
    {trOnDateTime} strToDo, //'on',
    {trSearch} strToDo, //'Search',
    {trSeeAlso} strToDo, //'See also',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageBrasilian;
begin
  FTranslation[trAuthor] := 'Autor';
  FTranslation[trAuthors] := 'Autores';
  FTranslation[trAutomated] := 'Automated';
  FTranslation[trCio] := 'Classes, Interfaces, Objetos e Registros';
  FTranslation[trClass] := 'Classe';
  FTranslation[trClasses] := 'Classes';
  FTranslation[trClassHierarchy] := 'Hierarquia de Classes';
  FTranslation[trConstants] := 'Constantes';
  FTranslation[trCreated] := 'Criada';
  FTranslation[trDeclaration] := 'Declara��o';
  FTranslation[trDescription] := 'Descri��o';
  FTranslation[trParameters] := 'Par�metros';
  FTranslation[trReturns] := 'Retornos';
  FTranslation[trExceptions] := 'Exce��es';
  FTranslation[trExceptionsRaised] := 'Exce��es'; // TODO: translate as "Exceptions raised" instead of just "Exceptions"
  FTranslation[trEnum] := 'Enumera��es';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Campos';
  FTranslation[trFunctionsAndProcedures] := 'Fun��es e Procedimentos';
  FTranslation[trHelp] := 'Ajuda';
  FTranslation[trHierarchy] := 'Hierarquia';
  FTranslation[trIdentifiers] := 'Identificadores';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'Legenda';
  FTranslation[trMarker] := 'Marker'; // TODO: translate
  FTranslation[trVisibility] := 'Visibility'; // TODO: translate
  FTranslation[trMethods] := 'M�todos';
  FTranslation[trLastModified] := '�ltima modifica��o';
  FTranslation[trName] := 'Nome';
  FTranslation[trNone] := 'Nenhum';
  FTranslation[trObject] := 'Objeto';
  FTranslation[trObjects] := 'Objetos';
  FTranslation[trOverview] := 'Vis�o Geral';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trProperties] := 'Properties';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Tipo';
  FTranslation[trTypes] := 'Tipos';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Units';
  FTranslation[trVariables] := 'Vari�veis';
  FTranslation[trGvUses] := 'Diagrama de depend�ncias de units';
  FTranslation[trGvClasses] := 'Diagrama de hierarquia de Classes';
  FTranslation[trHeadlineCio] := 'Todas as Classes, Interfaces, Objetos e Registros';
  FTranslation[trHeadlineConstants] := 'Todas as Constantes';
  FTranslation[trHeadlineFunctionsAndProcedures] := 'Todas as fun��es e procedimentos';
  FTranslation[trHeadlineIdentifiers] := 'Todos os Identificadores';
  FTranslation[trHeadlineTypes] := 'Todos os Tipos';
  FTranslation[trHeadlineUnits] := 'Todas as Units';
  FTranslation[trHeadlineVariables] := 'Todas as Vari�veis';
  FTranslation[trSummaryCio] :=
    'Lista das Classes, Interfaces, Objetos e Registros';
  FTranslation[trWarningOverwrite] :=
    'Aviso, n�o altere - este arquivo foi gerado automaticamente e ser� sobrescrito';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trGeneratedBy] := 'Gerado por';
  FTranslation[trOnDateTime] := 'as';
  FTranslation[trDeprecated] := 'este s�mbolo est� depreciado';
  FTranslation[trPlatformSpecific] := 'este s�mbolo � espec�fico para alguma plataforma';
  FTranslation[trLibrarySpecific] := 'este s�mbolo � espec�fico para alguma biblioteca';
  FTranslation[trIntroduction] := 'Introduction'; // TODO: translate
  FTranslation[trConclusion] := 'Conclusion'; // TODO: translate
  FTranslation[trSearch] := 'Search'; // TODO: translate
  FTranslation[trSeeAlso] := 'See also'; // TODO: translate
  FTranslation[trValues] := 'Values'; // TODO: translate
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.'; // TODO: translate
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.'; // TODO: translate
  FTranslation[trNoTypes] := 'The units do not contain any types.'; // TODO: translate
  FTranslation[trNoVariables] := 'The units do not contain any variables.'; // TODO: translate
  FTranslation[trNoConstants] := 'The units do not contain any constants.'; // TODO: translate
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.'; // TODO: translate
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.'; // TODO: translate
  FTranslation[trProgram] := 'Program'; // TODO: translate
end;
{$ELSE}
const
  aBrasilian: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Brasilian',
  //map
    {trUnits} strToDo, //'Units',
    {trClassHierarchy} 'Hierarquia de Classes',
    {trCio} 'Classes, Interfaces, Objetos e Registros',
    {trIdentifiers} 'Identificadores',
    {trGvUses} 'Diagrama de depend�ncias de units',
    {trGvClasses} 'Diagrama de hierarquia de Classes',
  //tables and members
    {trClasses} strKeep, //'Classes',
      {trClass} 'Classe',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} strKeep, //'Interface',
    {trObjects} 'Objetos',
      {trObject} 'Objeto',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Hierarquia',
        {trFields} 'Campos',
        {trMethods} 'M�todos',
        {trProperties} strToDo, //'Properties',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} strToDo, //'Unit',
      {trUses} strToDo, //'Uses',
      {trConstants} 'Constantes',
      {trFunctionsAndProcedures} 'Fun��es e Procedimentos',
      {trTypes} 'Tipos',
        {trType} 'Tipo',
      {trVariables} 'Vari�veis',
      {trAuthors} 'Autores',
        {trAuthor} 'Autor',
      {trCreated} 'Criada',
      {trLastModified} '�ltima modifica��o',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} 'Par�metros',
      {trReturns} 'Retornos', //???
      {trExceptionsRaised} strToDo, //'Exceptions raised',
    {trExceptions} 'Exce��es',
      {trException} strToDo, //'Exception',
    {trEnum} 'Enumera��es', //???
  //visibilities
    {trVisibility} strToDo, //'Visibility',
      {trPrivate} strToDo, //'Private',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} strToDo, //'Protected',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} strToDo, //'Public',
      {trPublished} strToDo, //'Published',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} 'este s�mbolo est� depreciado',
    {trPlatformSpecific} 'este s�mbolo � espec�fico para alguma plataforma',
    {trLibrarySpecific} 'este s�mbolo � espec�fico para alguma biblioteca',
  //headings
    {trOverview} 'Vis�o Geral',
    {trIntroduction} strToDo, //'Introduction',
    {trConclusion} strToDo, //'Conclusion',
    {trHeadlineCio} 'Todas as Classes, Interfaces, Objetos e Registros',
    {trHeadlineConstants} 'Todas as Constantes',
    {trHeadlineFunctionsAndProcedures} 'Todas as fun��es e procedimentos',
    {trHeadlineIdentifiers} 'Todos os Identificadores',
    {trHeadlineTypes} 'Todos os Tipos',
    {trHeadlineUnits} 'Todas as Units',
    {trHeadlineVariables} 'Todas as Vari�veis',
    {trSummaryCio} 'Lista das Classes, Interfaces, Objetos e Registros',
  //column headings
    {trDeclaration} 'Declara��o',
    {trDescription} 'Descri��o',
    {trName} 'Nome',
    {trValues} strToDo, //'Values',
  //empty
    {trNone} 'Nenhum',
    {trNoCIOs} strToDo, //'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} strToDo, //'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} strToDo, //'The units do not contain any types.',
    {trNoVariables} strToDo, //'The units do not contain any variables.',
    {trNoConstants} strToDo, //'The units do not contain any constants.',
    {trNoFunctions} strToDo, //'The units do not contain any functions or procedures.',
    {trNoIdentifiers} strToDo, //'The units do not contain any identifiers.',
  //misc
    {trHelp} 'Ajuda',
    {trLegend} 'Legenda',
    {trMarker} strToDo, //'Marker',
    {trWarningOverwrite} 'Aviso, n�o altere - este arquivo foi gerado automaticamente e ser� sobrescrito',
    {trWarning} strToDo, //'Warning',
    {trGeneratedBy} 'Gerado por',
    {trOnDateTime} 'as',
    {trSearch} strToDo, //'Search',
    {trSeeAlso} strToDo, //'See also',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageCatalan;
begin
  FTranslation[trAuthor] := 'Autor';
  FTranslation[trAuthors] := 'Autors';
  FTranslation[trCio] := 'Clases, interfaces i objectes';
  FTranslation[trClass] := 'Clase';
  FTranslation[trClasses] := 'Clases';
  FTranslation[trConstants] := 'Constants';
  FTranslation[trCreated] := 'Creat';
  FTranslation[trDeclaration] := 'Declaraci�';
  FTranslation[trDescription] := 'Descripci�';
  FTranslation[trParameters] := 'Parameters';
  FTranslation[trReturns] := 'Returns';
  FTranslation[trExceptions] := 'Exceptions'; // TODO: translate
  FTranslation[trExceptionsRaised] := 'Exceptions raised'; // TODO: translate
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Camps';
  FTranslation[trFunctionsAndProcedures] := 'Funcions i procediments';
  FTranslation[trHelp] := 'Help';
  FTranslation[trHierarchy] := 'Hierarchy';
  FTranslation[trIdentifiers] := 'Identificadors';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLastModified] := '�ltima modificaci�';
  FTranslation[trLegend] := 'Legend';
  FTranslation[trMarker] := 'Marker'; // TODO: translate
  FTranslation[trVisibility] := 'Visibility'; // TODO: translate
  FTranslation[trMethods] := 'M�todes';
  FTranslation[trName] := 'Nom';
  FTranslation[trNone] := 'Ningu';
  FTranslation[trObject] := 'Objecte';
  FTranslation[trObjects] := 'Objectes';
  FTranslation[trOverview] := 'Resum';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trProperties] := 'Propietats';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Tipus';
  FTranslation[trTypes] := 'Tipus';
  FTranslation[trUnit] := 'Unitat';
  FTranslation[trUnits] := 'Unitats';
  FTranslation[trVariables] := 'Variables';
  FTranslation[trGvUses] := 'Unit dependency graph'; // TODO: translate
  FTranslation[trGvClasses] := 'Classes hierarchy graph'; // TODO: translate
  FTranslation[trWarningOverwrite] :=
    'Atenci�, no editar - aquest fitxer ha estat creat automaticament i ser� sobrescrit';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trHeadlineCio] := 'Totes les clases, interfaces i objectes';
  FTranslation[trHeadlineConstants] := 'Totes les constants';
  FTranslation[trHeadlineFunctionsAndProcedures] :=
    'Totes les funcions i procediments';
  FTranslation[trHeadlineIdentifiers] := 'Tot els indentificadors';
  FTranslation[trHeadlineTypes] := 'Tots els tipus';
  FTranslation[trHeadlineUnits] := 'Totes les unitats';
  FTranslation[trHeadlineVariables] := 'Totes les variables';
  FTranslation[trSummaryCio] := 'Llista de clases, interfaces i objectes';
  FTranslation[trGeneratedBy] := 'Generated by'; // TODO: translate
  FTranslation[trOnDateTime] := 'on'; // TODO: translate
  FTranslation[trDeprecated] := 'this symbol is deprecated'; // TODO: translate
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform'; // TODO: translate
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library'; // TODO: translate
  FTranslation[trIntroduction] := 'Introduction'; // TODO: translate
  FTranslation[trConclusion] := 'Conclusion'; // TODO: translate
  FTranslation[trSearch] := 'Search'; // TODO: translate
  FTranslation[trSeeAlso] := 'See also'; // TODO: translate
  FTranslation[trValues] := 'Values'; // TODO: translate
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.'; // TODO: translate
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.'; // TODO: translate
  FTranslation[trNoTypes] := 'The units do not contain any types.'; // TODO: translate
  FTranslation[trNoVariables] := 'The units do not contain any variables.'; // TODO: translate
  FTranslation[trNoConstants] := 'The units do not contain any constants.'; // TODO: translate
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.'; // TODO: translate
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.'; // TODO: translate
  FTranslation[trProgram] := 'Program'; // TODO: translate
end;
{$ELSE}
const
  aCatalan: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Catalan',
  //map
    {trUnits} 'Unitats',
    {trClassHierarchy} strToDo, //'Class Hierarchy',
    {trCio} 'Clases, interfaces i objectes',
    {trIdentifiers} 'Identificadors',
    {trGvUses} strToDo, //'Unit dependency graph',
    {trGvClasses} strToDo, //'Classes hierarchy graph',
  //tables and members
    {trClasses} 'Clases',
      {trClass} 'Clase',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} strToDo, //'Interface',
    {trObjects} 'Objectes',
      {trObject} 'Objecte',
      {trRecord} strToDo, //'Record',
        {trHierarchy} strToDo, //'Hierarchy',
        {trFields} 'Camps',
        {trMethods} 'M�todes',
        {trProperties} 'Propietats',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} 'Unitat',
      {trUses} strToDo, //'Uses',
      {trConstants} strToDo, //'Constants',
      {trFunctionsAndProcedures} 'Funcions i procediments',
      {trTypes} 'Tipus',
        {trType} 'Tipus',
      {trVariables} strToDo, //'Variables',
      {trAuthors} 'Autors',
        {trAuthor} 'Autor',
      {trCreated} 'Creat',
      {trLastModified} '�ltima modificaci�',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} strToDo, //'Parameters',
      {trReturns} strToDo, //'Returns',
      {trExceptionsRaised} strToDo, //'Exceptions raised',
    {trExceptions} strToDo, //'Exceptions',
      {trException} strToDo, //'Exception',
    {trEnum} strToDo, //'Enumeration',
  //visibilities
    {trVisibility} strToDo, //'Visibility',
      {trPrivate} strToDo, //'Private',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} strToDo, //'Protected',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} strToDo, //'Public',
      {trPublished} strToDo, //'Published',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} strToDo, //'this symbol is deprecated',
    {trPlatformSpecific} strToDo, //'this symbol is specific to some platform',
    {trLibrarySpecific} strToDo, //'this symbol is specific to some library',
  //headings
    {trOverview} 'Resum',
    {trIntroduction} strToDo, //'Introduction',
    {trConclusion} strToDo, //'Conclusion',
    {trHeadlineCio} 'Totes les clases, interfaces i objectes',
    {trHeadlineConstants} 'Totes les constants',
    {trHeadlineFunctionsAndProcedures} 'Totes les funcions i procediments',
    {trHeadlineIdentifiers} 'Tot els indentificadors',
    {trHeadlineTypes} 'Tots els tipus',
    {trHeadlineUnits} 'Totes les unitats',
    {trHeadlineVariables} 'Totes les variables',
    {trSummaryCio} 'Llista de clases, interfaces i objectes',
  //column headings
    {trDeclaration} 'Declaraci�',
    {trDescription} 'Descripci�',
    {trName} strToDo, //'Nom',
    {trValues} strToDo, //'Values',
  //empty
    {trNone} 'Ningu',
    {trNoCIOs} strToDo, //'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} strToDo, //'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} strToDo, //'The units do not contain any types.',
    {trNoVariables} strToDo, //'The units do not contain any variables.',
    {trNoConstants} strToDo, //'The units do not contain any constants.',
    {trNoFunctions} strToDo, //'The units do not contain any functions or procedures.',
    {trNoIdentifiers} strToDo, //'The units do not contain any identifiers.',
  //misc
    {trHelp} strToDo, //'Help',
    {trLegend} strToDo, //'Legend',
    {trMarker} strToDo, //'Marker',
    {trWarningOverwrite} 'Atenci�, no editar - aquest fitxer ha estat creat automaticament i ser� sobrescrit',
    {trWarning} 'Atenci�',
    {trGeneratedBy} strToDo, //'Generated by',
    {trOnDateTime} strToDo, //'on',
    {trSearch} strToDo, //'Search',
    {trSeeAlso} strToDo, //'See also',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageChinese_950;
begin
  FTranslation[trAuthor] := '�@��';
  FTranslation[trAuthors] := '�@�̸s';
  FTranslation[trGeneratedBy] := 'Generated by'; // TODO: translate
  FTranslation[trOnDateTime] := 'on'; // TODO: translate
  FTranslation[trDeprecated] := 'this symbol is deprecated'; // TODO: translate
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform'; // TODO: translate
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library'; // TODO: translate
  FTranslation[trIntroduction] := 'Introduction'; // TODO: translate
  FTranslation[trConclusion] := 'Conclusion'; // TODO: translate
  FTranslation[trSearch] := 'Search'; // TODO: translate
  FTranslation[trSeeAlso] := 'See also'; // TODO: translate
  FTranslation[trValues] := 'Values'; // TODO: translate
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.'; // TODO: translate
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.'; // TODO: translate
  FTranslation[trNoTypes] := 'The units do not contain any types.'; // TODO: translate
  FTranslation[trNoVariables] := 'The units do not contain any variables.'; // TODO: translate
  FTranslation[trNoConstants] := 'The units do not contain any constants.'; // TODO: translate
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.'; // TODO: translate
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.'; // TODO: translate
  FTranslation[trProgram] := 'Program'; // TODO: translate
end;
{$ELSE}
const
  aChinese_950: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Chinese',
  //map
    {trUnits} strToDo, //'Units',
    {trClassHierarchy} strToDo, //'Class Hierarchy',
    {trCio} strToDo, //'Classes, Interfaces, Objects and Records',
    {trIdentifiers} strToDo, //'Identifiers',
    {trGvUses} strToDo, //'Unit dependency graph',
    {trGvClasses} strToDo, //'Classes hierarchy graph',
  //tables and members
    {trClasses} strToDo, //'Classes',
      {trClass} strToDo, //'Class',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} strToDo, //'Interface',
    {trObjects} strToDo, //'Objects',
      {trObject} strToDo, //'Object',
      {trRecord} strToDo, //'Record',
        {trHierarchy} strToDo, //'Hierarchy',
        {trFields} strToDo, //'Fields',
        {trMethods} strToDo, //'Methods',
        {trProperties} strToDo, //'Properties',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} strToDo, //'Unit',
      {trUses} strToDo, //'Uses',
      {trConstants} strToDo, //'Constants',
      {trFunctionsAndProcedures} strToDo, //'Functions and Procedures',
      {trTypes} strToDo, //'Types',
        {trType} strToDo, //'Type',
      {trVariables} strToDo, //'Variables',
      {trAuthors} '�@�̸s',
        {trAuthor} '�@��',
      {trCreated} strToDo, //'Created',
      {trLastModified} strToDo, //'Last Modified',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} strToDo, //'Parameters',
      {trReturns} strToDo, //'Returns',
      {trExceptionsRaised} strToDo, //'Exceptions raised',
    {trExceptions} strToDo, //'Exceptions',
      {trException} strToDo, //'Exception',
    {trEnum} strToDo, //'Enumeration',
  //visibilities
    {trVisibility} strToDo, //'Visibility',
      {trPrivate} strToDo, //'Private',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} strToDo, //'Protected',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} strToDo, //'Public',
      {trPublished} strToDo, //'Published',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} strToDo, //'this symbol is deprecated',
    {trPlatformSpecific} strToDo, //'this symbol is specific to some platform',
    {trLibrarySpecific} strToDo, //'this symbol is specific to some library',
  //headings
    {trOverview} strToDo, //'Overview',
    {trIntroduction} strToDo, //'Introduction',
    {trConclusion} strToDo, //'Conclusion',
    {trHeadlineCio} strToDo, //'All Classes, Interfaces, Objects and Records',
    {trHeadlineConstants} strToDo, //'All Constants',
    {trHeadlineFunctionsAndProcedures} strToDo, //'All Functions and Procedures',
    {trHeadlineIdentifiers} strToDo, //'All Identifiers',
    {trHeadlineTypes} strToDo, //'All Types',
    {trHeadlineUnits} strToDo, //'All Units',
    {trHeadlineVariables} strToDo, //'All Variables',
    {trSummaryCio} strToDo, //'Summary of Classes, Interfaces, Objects and Records',
  //column headings
    {trDeclaration} strToDo, //'Declaration',
    {trDescription} strToDo, //'Description',
    {trName} strToDo, //'Name',
    {trValues} strToDo, //'Values',
  //empty
    {trNone} strToDo, //'None',
    {trNoCIOs} strToDo, //'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} strToDo, //'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} strToDo, //'The units do not contain any types.',
    {trNoVariables} strToDo, //'The units do not contain any variables.',
    {trNoConstants} strToDo, //'The units do not contain any constants.',
    {trNoFunctions} strToDo, //'The units do not contain any functions or procedures.',
    {trNoIdentifiers} strToDo, //'The units do not contain any identifiers.',
  //misc
    {trHelp} strToDo, //'Help',
    {trLegend} strToDo, //'Legend',
    {trMarker} strToDo, //'Marker',
    {trWarningOverwrite} strToDo, //'Warning: Do not edit - this file has been created automatically and is likely be overwritten',
    {trWarning} strToDo, //'Warning',
    {trGeneratedBy} strToDo, //'Generated by',
    {trOnDateTime} strToDo, //'on',
    {trSearch} strToDo, //'Search',
    {trSeeAlso} strToDo, //'See also',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$I PasDoc_Languages_Chinese_gb2312.inc}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageDanish;
begin
  FTranslation[trAuthor] := 'Forfatter';
  FTranslation[trAuthors] := 'Forfatre';
  FTranslation[trCio] := 'Klasser, interfaces og objekter';
  FTranslation[trClass] := 'Klasse';
  FTranslation[trClasses] := 'Klasser';
  FTranslation[trConstants] := 'Konstanter';
  FTranslation[trCreated] := 'Udf�rt';
  FTranslation[trDeclaration] := 'Declaration';
  FTranslation[trDescription] := 'Beskrivelse';
  FTranslation[trParameters] := 'Parameters';
  FTranslation[trReturns] := 'Returns';
  FTranslation[trExceptions] := 'Exceptions'; // TODO: translate
  FTranslation[trExceptionsRaised] := 'Exceptions raised'; // TODO: translate
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Felter';
  FTranslation[trFunctionsAndProcedures] := 'Funktioner og prosedurer';
  FTranslation[trHelp] := 'Hj�lp';
  FTranslation[trHierarchy] := 'Herarki';
  FTranslation[trIdentifiers] := 'Identifiers';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'Legende';
  FTranslation[trMarker] := 'Marker'; // TODO: translate
  FTranslation[trVisibility] := 'Visibility'; // TODO: translate
  FTranslation[trLastModified] := 'Sidst Modificieret';
  FTranslation[trMethods] := 'Metoder';
  FTranslation[trName] := 'Navn';
  FTranslation[trNone] := 'Ingen';
  FTranslation[trObject] := 'Objekt';
  FTranslation[trObjects] := 'Objekter';
  FTranslation[trOverview] := 'Sammendrag';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trProperties] := 'Egenskaber';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Type';
  FTranslation[trTypes] := 'Typer';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Units';
  FTranslation[trVariables] := 'Variable';
  FTranslation[trGvUses] := 'Unit dependency graph'; // TODO: translate
  FTranslation[trGvClasses] := 'Classes hierarchy graph'; // TODO: translate
  FTranslation[trWarningOverwrite] :=
    'Advarsel: Editer ikke denne fil, den er autogeneret og vil sansylgvis blive overskret';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trHeadlineCio] := 'Alle Klasesr, Interfaces og Objekter';
  FTranslation[trHeadlineConstants] := 'Alle Konstanter';
  FTranslation[trHeadlineFunctionsAndProcedures] :=
    'Alle Functioner and Procedurer';
  FTranslation[trHeadlineIdentifiers] := 'Alle Identifiers';
  FTranslation[trHeadlineTypes] := 'Alle Typer';
  FTranslation[trHeadlineUnits] := 'Alle Units';
  FTranslation[trHeadlineVariables] := 'Alle Variable';
  FTranslation[trSummaryCio] :=
    'Oversigt over klasser, interfaces & objekter';
  FTranslation[trGeneratedBy] := 'Generated by'; // TODO: translate
  FTranslation[trOnDateTime] := 'on'; // TODO: translate
  FTranslation[trDeprecated] := 'this symbol is deprecated'; // TODO: translate
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform'; // TODO: translate
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library'; // TODO: translate
  FTranslation[trIntroduction] := 'Introduction'; // TODO: translate
  FTranslation[trConclusion] := 'Conclusion'; // TODO: translate
  FTranslation[trSearch] := 'Search'; // TODO: translate
  FTranslation[trSeeAlso] := 'See also'; // TODO: translate
  FTranslation[trValues] := 'Values'; // TODO: translate
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.'; // TODO: translate
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.'; // TODO: translate
  FTranslation[trNoTypes] := 'The units do not contain any types.'; // TODO: translate
  FTranslation[trNoVariables] := 'The units do not contain any variables.'; // TODO: translate
  FTranslation[trNoConstants] := 'The units do not contain any constants.'; // TODO: translate
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.'; // TODO: translate
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.'; // TODO: translate
  FTranslation[trProgram] := 'Program'; // TODO: translate
end;
{$ELSE}
const
  aDanish: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Danish',
  //map
    {trUnits} strToDo, //'Units',
    {trClassHierarchy} strToDo, //'Class Hierarchy',
    {trCio} 'Klasser, interfaces og objekter',
    {trIdentifiers} strToDo, //'Identifiers',
    {trGvUses} strToDo, //'Unit dependency graph',
    {trGvClasses} strToDo, //'Classes hierarchy graph',
  //tables and members
    {trClasses} 'Klasser',
      {trClass} 'Klasse',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} strToDo, //'Interface',
    {trObjects} 'Objekter',
      {trObject} 'Objekt',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Herarki',
        {trFields} 'Felter',
        {trMethods} 'Metoder',
        {trProperties} 'Egenskaber',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} strToDo, //'Unit',
      {trUses} strToDo, //'Uses',
      {trConstants} 'Konstanter',
      {trFunctionsAndProcedures} 'Funktioner og prosedurer',
      {trTypes} 'Typer',
        {trType} strToDo, //'Type',
      {trVariables} 'Variable',
      {trAuthors} 'Forfatre',
        {trAuthor} 'Forfatter',
      {trCreated} 'Udf�rt',
      {trLastModified} 'Sidst Modificieret',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} strToDo, //'Parameters',
      {trReturns} strToDo, //'Returns',
      {trExceptionsRaised} strToDo, //'Exceptions raised',
    {trExceptions} strToDo, //'Exceptions',
      {trException} strToDo, //'Exception',
    {trEnum} strToDo, //'Enumeration',
  //visibilities
    {trVisibility} strToDo, //'Visibility',
      {trPrivate} strToDo, //'Private',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} strToDo, //'Protected',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} strToDo, //'Public',
      {trPublished} strToDo, //'Published',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} strToDo, //'this symbol is deprecated',
    {trPlatformSpecific} strToDo, //'this symbol is specific to some platform',
    {trLibrarySpecific} strToDo, //'this symbol is specific to some library',
  //headings
    {trOverview} 'Sammendrag',
    {trIntroduction} strToDo, //'Introduction',
    {trConclusion} strToDo, //'Conclusion',
    {trHeadlineCio} 'Alle Klasesr, Interfaces og Objekter',
    {trHeadlineConstants} 'Alle Konstanter',
    {trHeadlineFunctionsAndProcedures} 'Alle Functioner and Procedurer',
    {trHeadlineIdentifiers} 'Alle Identifiers',
    {trHeadlineTypes} 'Alle Typer',
    {trHeadlineUnits} 'Alle Units',
    {trHeadlineVariables} 'Alle Variable',
    {trSummaryCio} 'Oversigt over klasser, interfaces & objekter',
  //column headings
    {trDeclaration} strToDo, //'Declaration',
    {trDescription} 'Beskrivelse',
    {trName} 'Navn',
    {trValues} strToDo, //'Values',
  //empty
    {trNone} 'Ingen',
    {trNoCIOs} strToDo, //'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} strToDo, //'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} strToDo, //'The units do not contain any types.',
    {trNoVariables} strToDo, //'The units do not contain any variables.',
    {trNoConstants} strToDo, //'The units do not contain any constants.',
    {trNoFunctions} strToDo, //'The units do not contain any functions or procedures.',
    {trNoIdentifiers} strToDo, //'The units do not contain any identifiers.',
  //misc
    {trHelp} 'Hj�lp',
    {trLegend} 'Legende',
    {trMarker} strToDo, //'Marker',
    {trWarningOverwrite} 'Advarsel: Editer ikke denne fil, den er autogeneret og vil sansylgvis blive overskret',
    {trWarning} strToDo, //'Warning',
    {trGeneratedBy} strToDo, //'Generated by',
    {trOnDateTime} strToDo, //'on',
    {trSearch} strToDo, //'Search',
    {trSeeAlso} strToDo, //'See also',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageDutch;
begin
  FTranslation[trAuthor] := 'Auteur';
  FTranslation[trAuthors] := 'Auteurs';
  FTranslation[trCio] := 'Classes, interfaces and objecten';
  FTranslation[trClass] := 'Class';
  FTranslation[trClasses] := 'Classes';
  FTranslation[trConstants] := 'Constanten';
  FTranslation[trCreated] := 'Gemaakt';
  FTranslation[trDeclaration] := 'Declaratie';
  FTranslation[trDescription] := 'Omschrijving';
  FTranslation[trParameters] := 'Parameters';
  FTranslation[trReturns] := 'Returns';
  FTranslation[trExceptions] := 'Exceptions'; // TODO: translate
  FTranslation[trExceptionsRaised] := 'Exceptions raised'; // TODO: translate
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Velden';
  FTranslation[trFunctionsAndProcedures] := 'Functies en procedures';
  FTranslation[trHelp] := 'Help';
  FTranslation[trHierarchy] := 'Hierarchie';
  FTranslation[trIdentifiers] := 'Identifiers';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLastModified] := 'Laatste wijziging';
  FTranslation[trLegend] := 'Legend';
  FTranslation[trMarker] := 'Marker'; // TODO: translate
  FTranslation[trVisibility] := 'Visibility'; // TODO: translate
  FTranslation[trMethods] := 'Methods';
  FTranslation[trName] := 'Naam';
  FTranslation[trNone] := 'Geen';
  FTranslation[trObject] := 'Object';
  FTranslation[trObjects] := 'Objecten';
  FTranslation[trOverview] := 'Overzicht';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trProperties] := 'Eigenschappen';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Type';
  FTranslation[trTypes] := 'Typen';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Units';
  FTranslation[trVariables] := 'Variabelen';
  FTranslation[trGvUses] := 'Unit dependency graph'; // TODO: translate
  FTranslation[trGvClasses] := 'Classes hierarchy graph'; // TODO: translate
  FTranslation[trWarningOverwrite] :=
    'Waarschuwing, wijzig niets - dit bestand is automatisch gegenereerd en zal worden overschreven';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trHeadlineCio] := 'Alle classes, interfaces en objecten';
  FTranslation[trHeadlineConstants] := 'Alle constanten';
  FTranslation[trHeadlineFunctionsAndProcedures] :=
    'Alle functies en procedures';
  FTranslation[trHeadlineIdentifiers] := 'Alle identifiers';
  FTranslation[trHeadlineTypes] := 'Alle typen';
  FTranslation[trHeadlineUnits] := 'Alle units';
  FTranslation[trHeadlineVariables] := 'Alle variabelen';
  FTranslation[trSummaryCio] :=
    'Overzicht van classes, interfaces & objecten';
  FTranslation[trGeneratedBy] := 'Generated by'; // TODO: translate
  FTranslation[trOnDateTime] := 'on'; // TODO: translate
  FTranslation[trDeprecated] := 'this symbol is deprecated'; // TODO: translate
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform'; // TODO: translate
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library'; // TODO: translate
  FTranslation[trIntroduction] := 'Introduction'; // TODO: translate
  FTranslation[trConclusion] := 'Conclusion'; // TODO: translate
  FTranslation[trSearch] := 'Search'; // TODO: translate
  FTranslation[trSeeAlso] := 'See also'; // TODO: translate
  FTranslation[trValues] := 'Values'; // TODO: translate
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.'; // TODO: translate
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.'; // TODO: translate
  FTranslation[trNoTypes] := 'The units do not contain any types.'; // TODO: translate
  FTranslation[trNoVariables] := 'The units do not contain any variables.'; // TODO: translate
  FTranslation[trNoConstants] := 'The units do not contain any constants.'; // TODO: translate
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.'; // TODO: translate
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.'; // TODO: translate
  FTranslation[trProgram] := 'Programma';
end;
{$ELSE}
const
  aDutch: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Dutch',
  //map
    {trUnits} strToDo, //'Units',
    {trClassHierarchy} strToDo, //'Class Hierarchy',
    {trCio} 'Classes, interfaces and objecten',
    {trIdentifiers} strToDo, //'Identifiers',
    {trGvUses} strToDo, //'Unit dependency graph',
    {trGvClasses} strToDo, //'Classes hierarchy graph',
  //tables and members
    {trClasses} strToDo, //'Classes',
      {trClass} strToDo, //'Class',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} strToDo, //'Interface',
    {trObjects} 'Objecten',
      {trObject} strToDo, //'Object',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Hierarchie',
        {trFields} 'Velden',
        {trMethods} strToDo, //'Methods',
        {trProperties} 'Eigenschappen',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} 'Programma',
    {trUnit} strToDo, //'Unit',
      {trUses} strToDo, //'Uses',
      {trConstants} 'Constanten',
      {trFunctionsAndProcedures} 'Functies en procedures',
      {trTypes} 'Typen',
        {trType} strToDo, //'Type',
      {trVariables} 'Variabelen',
      {trAuthors} 'Auteurs',
        {trAuthor} 'Auteur',
      {trCreated} 'Gemaakt',
      {trLastModified} 'Laatste wijziging',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} strToDo, //'Parameters',
      {trReturns} strToDo, //'Returns',
      {trExceptionsRaised} strToDo, //'Exceptions raised',
    {trExceptions} strToDo, //'Exceptions',
      {trException} strToDo, //'Exception',
    {trEnum} strToDo, //'Enumeration',
  //visibilities
    {trVisibility} strToDo, //'Visibility',
      {trPrivate} strToDo, //'Private',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} strToDo, //'Protected',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} strToDo, //'Public',
      {trPublished} strToDo, //'Published',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} strToDo, //'this symbol is deprecated',
    {trPlatformSpecific} strToDo, //'this symbol is specific to some platform',
    {trLibrarySpecific} strToDo, //'this symbol is specific to some library',
  //headings
    {trOverview} 'Overzicht',
    {trIntroduction} strToDo, //'Introduction',
    {trConclusion} strToDo, //'Conclusion',
    {trHeadlineCio} 'Alle classes, interfaces en objecten',
    {trHeadlineConstants} 'Alle constanten',
    {trHeadlineFunctionsAndProcedures} 'Alle functies en procedures',
    {trHeadlineIdentifiers} 'Alle identifiers',
    {trHeadlineTypes} 'Alle typen',
    {trHeadlineUnits} 'Alle units',
    {trHeadlineVariables} 'Alle variabelen',
    {trSummaryCio} 'Overzicht van classes, interfaces & objecten',
  //column headings
    {trDeclaration} 'Declaratie',
    {trDescription} 'Omschrijving',
    {trName} 'Naam',
    {trValues} strToDo, //'Values',
  //empty
    {trNone} 'Geen',
    {trNoCIOs} strToDo, //'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} strToDo, //'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} strToDo, //'The units do not contain any types.',
    {trNoVariables} strToDo, //'The units do not contain any variables.',
    {trNoConstants} strToDo, //'The units do not contain any constants.',
    {trNoFunctions} strToDo, //'The units do not contain any functions or procedures.',
    {trNoIdentifiers} strToDo, //'The units do not contain any identifiers.',
  //misc
    {trHelp} strToDo, //'Help',
    {trLegend} strToDo, //'Legend',
    {trMarker} strToDo, //'Marker',
    {trWarningOverwrite} 'Waarschuwing, wijzig niets - dit bestand is automatisch gegenereerd en zal worden overschreven',
    {trWarning} 'Waarschuwing',
    {trGeneratedBy} strToDo, //'Generated by',
    {trOnDateTime} strToDo, //'on',
    {trSearch} strToDo, //'Search',
    {trSeeAlso} strToDo, //'See also',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageFrench;
begin
  FTranslation[trAuthor] := 'Auteur';
  FTranslation[trAuthors] := 'Auteurs';
  FTranslation[trAutomated] := 'Automatis�';
  FTranslation[trCio] := 'Classes, interfaces, structures et objets';
  FTranslation[trClass] := 'Classe';
  FTranslation[trClasses] := 'Classes';
  FTranslation[trClassHierarchy] := 'Hi�rarchie des classes';
  FTranslation[trConstants] := 'Constantes';
  FTranslation[trCreated] := 'Cr�e';
  FTranslation[trDeclaration] := 'D�claration';
  FTranslation[trDescription] := 'Description';
  FTranslation[trParameters] := 'Param�tres';
  FTranslation[trReturns] := 'Retourne';
  FTranslation[trExceptions] := 'Exceptions'; // TODO: translate
  FTranslation[trExceptionsRaised] := 'Exceptions raised'; // TODO: translate
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Champs';
  FTranslation[trFunctionsAndProcedures] := 'Fonctions et proc�dures';
  FTranslation[trHelp] := 'Aide';
  FTranslation[trHierarchy] := 'Hi�rarchie';
  FTranslation[trIdentifiers] := 'Identificateurs';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'L�gende';
  FTranslation[trMarker] := 'Marquage';
  FTranslation[trVisibility] := 'Visibilit�';
  FTranslation[trMethods] := 'M�thodes';
  FTranslation[trLastModified] := 'Derni�re modification';
  FTranslation[trName] := 'Nom';
  FTranslation[trNone] := 'Aucun(e)(s)';
  FTranslation[trObject] := 'Objet';
  FTranslation[trObjects] := 'Objets';
  FTranslation[trOverview] := 'Aper�u';
  FTranslation[trPrivate] := 'Priv�';
  FTranslation[trProperties] := 'Propri�t�s';
  FTranslation[trProtected] := 'Prot�g�';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Publi�s';
  FTranslation[trType] := 'Type';
  FTranslation[trTypes] := 'Types';
  FTranslation[trUnit] := 'Unit�';
  FTranslation[trUnits] := 'Unit�s';
  FTranslation[trVariables] := 'Variables';
  FTranslation[trGvUses] := 'Graphique de d�pendance d''unit�s';
  FTranslation[trGvClasses] := 'Graphique de hi�rarchie des classes';
  FTranslation[trHeadlineCio] := 'Toutes les classes, interfaces, objets et enregistrements';
  FTranslation[trHeadlineConstants] := 'Toutes les constants';
  FTranslation[trHeadlineFunctionsAndProcedures] := 'Toutes les fonctions et proc�dures';
  FTranslation[trHeadlineIdentifiers] := 'Tous les identificateurs';
  FTranslation[trHeadlineTypes] := 'Tous les types';
  FTranslation[trHeadlineUnits] := 'Toutes les unit�s';
  FTranslation[trHeadlineVariables] := 'Toutes les variables';
  FTranslation[trSummaryCio] := 'Classes, interfaces, objets et enregistrements';
  FTranslation[trWarningOverwrite] :=
    'Attention, ne pas �dtier - ce fichier est cr�� automatiquement et va �tre �cras�';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trGeneratedBy] := 'Produit par';
  FTranslation[trOnDateTime] := 'le';
  FTranslation[trDeprecated] := 'ce symbole est d�sapprouv�';
  FTranslation[trPlatformSpecific] := 'ce symbole est sp�cifique � une plateforme d''ex�cution';
  FTranslation[trLibrarySpecific] := 'ce symbole est sp�cifique � une certaine biblioth�que';
  FTranslation[trIntroduction] := 'Introduction'; // TODO: translate
  FTranslation[trConclusion] := 'Conclusion'; // TODO: translate
  FTranslation[trSearch] := 'Recherce';
  FTranslation[trSeeAlso] := 'See also'; // TODO: translate
  FTranslation[trValues] := 'Values'; // TODO: translate
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.'; // TODO: translate
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.'; // TODO: translate
  FTranslation[trNoTypes] := 'The units do not contain any types.'; // TODO: translate
  FTranslation[trNoVariables] := 'The units do not contain any variables.'; // TODO: translate
  FTranslation[trNoConstants] := 'The units do not contain any constants.'; // TODO: translate
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.'; // TODO: translate
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.'; // TODO: translate
  FTranslation[trProgram] := 'Program'; // TODO: translate
end;
{$ELSE}
const
  aFrench: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'French',
  //map
    {trUnits} 'Unit�s',
    {trClassHierarchy} 'Hi�rarchie des classes',
    {trCio} 'Classes, interfaces, structures et objets',
    {trIdentifiers} 'Identificateurs',
    {trGvUses} 'Graphique de d�pendance d''unit�s',
    {trGvClasses} 'Graphique de hi�rarchie des classes',
  //tables and members
    {trClasses} strKeep, //'Classes',
      {trClass} 'Classe',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} strToDo, //'Interface',
    {trObjects} 'Objets',
      {trObject} 'Objet',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Hi�rarchie',
        {trFields} 'Champs',
        {trMethods} 'M�thodes',
        {trProperties} 'Propri�t�s',
    {trLibrary} 'Biblioth�que', //?
    {trPackage} strToDo,  //'Package',
    {trProgram} 'Logiciel', //? 'Program',
    {trUnit} 'Unit�',
      {trUses} strToDo, //'Uses',
      {trConstants} 'Constantes',
      {trFunctionsAndProcedures} 'Fonctions et proc�dures',
      {trTypes} strKeep, //'Types',
        {trType} strKeep, //'Type',
      {trVariables} strKeep, //'Variables',
      {trAuthors} 'Auteurs',
        {trAuthor} 'Auteur',
      {trCreated} 'Cr�e',
      {trLastModified} 'Derni�re modification',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} 'Param�tres',
      {trReturns} 'Retourne',
      {trExceptionsRaised} strToDo, //'Exceptions raised',
    {trExceptions} strToDo, //'Exceptions',
      {trException} strToDo, //'Exception',
    {trEnum} strToDo, //'Enumeration',
  //visibilities
    {trVisibility} 'Visibilit�',
      {trPrivate} 'Priv�',
      {trStrictPrivate} 'Strictement Priv�', //?
      {trProtected} 'Prot�g�',
      {trStrictProtected} 'Strictement Prot�g�', //?
      {trPublic} strKeep, //'Public',
      {trPublished} 'Publi�s',
      {trAutomated} 'Automatis�',
      {trImplicit} strKeep, //'Implicit',
  //hints
    {trDeprecated} 'ce symbole est d�sapprouv�',
    {trPlatformSpecific} 'ce symbole est sp�cifique � une plateforme d''ex�cution',
    {trLibrarySpecific} 'ce symbole est sp�cifique � une certaine biblioth�que',
  //headings
    {trOverview} 'Aper�u',
    {trIntroduction} strToDo, //'Introduction',
    {trConclusion} strToDo, //'Conclusion',
    {trHeadlineCio} 'Toutes les classes, interfaces, objets et enregistrements',
    {trHeadlineConstants} 'Toutes les constants',
    {trHeadlineFunctionsAndProcedures} 'Toutes les fonctions et proc�dures',
    {trHeadlineIdentifiers} 'Tous les identificateurs',
    {trHeadlineTypes} 'Tous les types',
    {trHeadlineUnits} 'Toutes les unit�s',
    {trHeadlineVariables} 'Toutes les variables',
    {trSummaryCio} 'Classes, interfaces, objets et enregistrements',
  //column headings
    {trDeclaration} 'D�claration',
    {trDescription} strKeep, //'Description',
    {trName} 'Nom',
    {trValues} 'Valeurs', //?
  //empty
    {trNone} 'Aucun(e)(s)', //'Rien'?
    {trNoCIOs} strToDo, //'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} strToDo, //'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} strToDo, //'The units do not contain any types.',
    {trNoVariables} strToDo, //'The units do not contain any variables.',
    {trNoConstants} strToDo, //'The units do not contain any constants.',
    {trNoFunctions} strToDo, //'The units do not contain any functions or procedures.',
    {trNoIdentifiers} strToDo, //'The units do not contain any identifiers.',
  //misc
    {trHelp} 'Aide',
    {trLegend} 'L�gende',
    {trMarker} 'Marquage',
    {trWarningOverwrite} 'Attention, ne pas �dtier - ce fichier est cr�� automatiquement et va �tre �cras�',
    {trWarning} 'Attention',
    {trGeneratedBy} 'Produit par',
    {trOnDateTime} 'le',
    {trSearch} 'Cherche', //? 'Recherche'
    {trSeeAlso} 'Voir aussi', //?
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageGerman;
begin
  FTranslation[trAuthor] := 'Autor';
  FTranslation[trAuthors] := 'Autoren';
  FTranslation[trAutomated] := 'Automated';
  FTranslation[trCio] := 'Klassen, Schnittstellen und Objekte';
  FTranslation[trClass] := 'Klasse';
  FTranslation[trClasses] := 'Klassen';
  FTranslation[trClassHierarchy] := 'Klassenhierarchie';
  FTranslation[trConstants] := 'Konstanten';
  FTranslation[trCreated] := 'Erstellt';
  FTranslation[trDeclaration] := 'Deklaration';
  FTranslation[trDescription] := 'Beschreibung';
  FTranslation[trParameters] := 'Parameters';
  FTranslation[trReturns] := 'Returns';
  FTranslation[trExceptions] := 'Exceptions'; // TODO: translate
  FTranslation[trExceptionsRaised] := 'Exceptions raised'; // TODO: translate
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Felder';
  FTranslation[trFunctionsAndProcedures] := 'Funktionen und Prozeduren';
  FTranslation[trHelp] := 'Hilfe';
  FTranslation[trHierarchy] := 'Hierarchie';
  FTranslation[trIdentifiers] := 'Bezeichner';
  FTranslation[trInterface] := 'Schnittstelle';
  FTranslation[trLegend] := 'Legende';
  FTranslation[trMarker] := 'Markierung';
  FTranslation[trVisibility] := 'Sichtbarkeit';
  FTranslation[trMethods] := 'Methoden';
  FTranslation[trLastModified] := 'Letzte �nderung';
  FTranslation[trName] := 'Name';
  FTranslation[trNone] := 'Keine';
  FTranslation[trObject] := 'Objekt';
  FTranslation[trObjects] := 'Objekte';
  FTranslation[trOverview] := '�bersicht';
  FTranslation[trPrivate] := 'Privat';
  FTranslation[trProperties] := 'Eigenschaften';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Type';
  FTranslation[trTypes] := 'Typen';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Units';
  FTranslation[trVariables] := 'Variablen';
  FTranslation[trGvUses] := 'Unit Abh�ngigkeitsgraph';
  FTranslation[trGvClasses] := 'Klassenhierarchie Graph';
  FTranslation[trHeadlineCio] := 'Alle Klassen, Schnittstellen, Objekte und Records';
  FTranslation[trHeadlineConstants] := 'Alle Konstanten';
  FTranslation[trHeadlineFunctionsAndProcedures] :=  'Alle Funktionen und Prozeduren';
  FTranslation[trHeadlineIdentifiers] := 'Alle Bezeichner';
  FTranslation[trHeadlineTypes] := 'Alle Typen';
  FTranslation[trHeadlineUnits] := 'Alle Units';
  FTranslation[trHeadlineVariables] := 'Alle Variablen';
  FTranslation[trSummaryCio] := 'Zusammenfassung aller Klassen, Schnittstellen, Objekte und Records';
  FTranslation[trWarningOverwrite] :=
    'Achtung: Nicht �ndern - diese Datei wurde automatisch erstellt und wird m�glicherweise �berschrieben';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trGeneratedBy] := 'Erstellt mit';
  FTranslation[trOnDateTime] := 'am';
  FTranslation[trDeprecated] := 'Dieses Symbol sollte nicht (mehr) verwendet werden.';
  FTranslation[trPlatformSpecific] := 'Dieses Symbol ist plattformspezifisch.';
  FTranslation[trLibrarySpecific] := 'Dieses Symbol ist spezifisch f�r eine bestimmte Bibliothek.';
  FTranslation[trIntroduction] := 'Einf�hrung';
  FTranslation[trConclusion] := 'Fazit';
  FTranslation[trSearch] := 'Suchen';
  FTranslation[trSeeAlso] := 'See also'; // TODO: translate
  FTranslation[trValues] := 'Values'; // TODO: translate
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.'; // TODO: translate
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.'; // TODO: translate
  FTranslation[trNoTypes] := 'The units do not contain any types.'; // TODO: translate
  FTranslation[trNoVariables] := 'The units do not contain any variables.'; // TODO: translate
  FTranslation[trNoConstants] := 'The units do not contain any constants.'; // TODO: translate
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.'; // TODO: translate
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.'; // TODO: translate
  FTranslation[trProgram] := 'Programm';
end;
{$ELSE}
const
  aGerman: RTransTable = (
    {trNoTrans} '<h�h?>', //no ID assigned, so far
    {trLanguage} 'German',
  //map
    {trUnits} strKeep, //'Units',
    {trClassHierarchy} 'Klassenhierarchie',
    {trCio} 'Klassen, Interfaces und Objects',
    {trIdentifiers} 'Bezeichner',
    {trGvUses} 'Graph der Unit-Abh�ngigkeiten',
    {trGvClasses} 'Graph der Klassenhierarchie',
  //tables and members
    {trClasses} 'Klassen',
      {trClass} 'Klasse',
      {trDispInterface} strKeep, //'DispInterface',
      {trInterface} strKeep, //'Interface', 'Schnittstelle'?
    {trObjects} strKeep, //'Objects',
      {trObject} strKeep, //'Object',
      {trRecord} strKeep, //'Record',
        {trHierarchy} 'Hierarchie',
        {trFields} 'Felder',
        {trMethods} 'Methoden',
        {trProperties} 'Eigenschaften',
    {trLibrary} 'Bibliothek',
    {trPackage} strKeep, //'Package',
    {trProgram} 'Programm',
    {trUnit} strKeep, //'Unit',
      {trUses} strKeep, //'Uses',
      {trConstants} 'Konstanten',
      {trFunctionsAndProcedures} 'Funktionen und Prozeduren',
      {trTypes} 'Datentypen',
        {trType} strKeep, //'Type', 'Typ'?
      {trVariables} 'Variablen',
      {trAuthors} 'Autoren',
        {trAuthor} 'Autor',
      {trCreated} 'Erstellt',
      {trLastModified} 'Letzte �nderung',
    {trSubroutine} 'Unterprogramm',
      {trParameters} 'Parameter',
      {trReturns} 'Result',
      {trExceptionsRaised} 'Wirft Ausnahmen', //'Exceptions raised',
    {trExceptions} 'Ausnahmen',
      {trException} strKeep, //'Exception',
    {trEnum} strKeep, //'Enumeration',
  //visibilities
    {trVisibility} 'Sichtbarkeit',
      {trPrivate} strKeep, //'Private',
      {trStrictPrivate} strKeep, //'Strict Private',
      {trProtected} strKeep, //'Protected',
      {trStrictProtected} strKeep, //'Strict Protected',
      {trPublic} strKeep, //'Public',
      {trPublished} strKeep, //'Published',
      {trAutomated} strKeep, //'Automated',
      {trImplicit} strKeep, //'Implicit',
  //hints
    {trDeprecated} 'Dieses Symbol sollte nicht (mehr) verwendet werden.',
    {trPlatformSpecific} 'Dieses Symbol ist plattformspezifisch.',
    {trLibrarySpecific} 'Dieses Symbol ist spezifisch f�r eine bestimmte Bibliothek.',
  //headings
    {trOverview} '�bersicht',
    {trIntroduction} 'Einf�hrung',
    {trConclusion} 'Fazit',
    {trHeadlineCio} 'Alle Klassen, Schnittstellen, Objekte und Records',
    {trHeadlineConstants} 'Alle Konstanten',
    {trHeadlineFunctionsAndProcedures} 'Alle Funktionen und Prozeduren',
    {trHeadlineIdentifiers} 'Alle Bezeichner',
    {trHeadlineTypes} 'Alle Typen',
    {trHeadlineUnits} 'Alle Units',
    {trHeadlineVariables} 'Alle Variablen',
    {trSummaryCio} 'Zusammenfassung aller Klassen, Schnittstellen, Objekte und Records',
  //column headings
    {trDeclaration} 'Deklaration',
    {trDescription} 'Beschreibung',
    {trName} strKeep, //'Name',
    {trValues} 'Werte',
  //empty
    {trNone} 'Keine',
    {trNoCIOs} 'Die Units enthalten keine Klassen, Interfaces, Objects oder Records.',
    {trNoCIOsForHierarchy} 'Die Units enthalten keine Klassen, Interfaces oder Objects.',
    {trNoTypes} 'Die Units enthalten keine Typen.',
    {trNoVariables} 'Die Units enthalten keine Variablen.',
    {trNoConstants} 'Die Units enthalten keine Konstanten.',
    {trNoFunctions} 'Die Units enthalten keine Funktionen oder Prozeduren.',
    {trNoIdentifiers} 'Die Units enthalten keine Bezeichner.',
  //misc
    {trHelp} 'Hilfe',
    {trLegend} 'Legende',
    {trMarker} 'Markierung',
    {trWarningOverwrite} 'Achtung: Nicht �ndern - diese Datei wurde automatisch erstellt und wird m�glicherweise �berschrieben',
    {trWarning} 'Warnung',
    {trGeneratedBy} 'Erstellt mit',
    {trOnDateTime} 'am',
    {trSearch} 'Suchen',
    {trSeeAlso} 'Siehe auch',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageIndonesian;
begin
  FTranslation[trAuthor] := 'Pembuat';
  FTranslation[trAuthors] := 'Pembuat';
  FTranslation[trCio] := 'Kelas, Interface, dan Objek';
  FTranslation[trClass] := 'Kelas';
  FTranslation[trClasses] := 'Kelas';
  FTranslation[trConstants] := 'Konstanta';
  FTranslation[trCreated] := 'Dibuat';
  FTranslation[trDeclaration] := 'Deklarasi';
  FTranslation[trDescription] := 'Definisi';
  FTranslation[trParameters] := 'Parameters';
  FTranslation[trReturns] := 'Returns';
  FTranslation[trExceptions] := 'Exceptions'; // TODO: translate
  FTranslation[trExceptionsRaised] := 'Exceptions raised'; // TODO: translate
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Field';
  FTranslation[trFunctionsAndProcedures] := 'Fungsi dan Prosedur';
  FTranslation[trHelp] := 'Bantuan';
  FTranslation[trHierarchy] := 'Hirarki';
  FTranslation[trIdentifiers] := 'Identifier';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'Legenda';
  FTranslation[trMarker] := 'Marker'; // TODO: translate
  FTranslation[trVisibility] := 'Visibility'; // TODO: translate
  FTranslation[trMethods] := 'Method';
  FTranslation[trLastModified] := 'Terakhir Dimodifikasi';
  FTranslation[trName] := 'Nama';
  FTranslation[trNone] := 'Tidak Ada';
  FTranslation[trObject] := 'Objek';
  FTranslation[trObjects] := 'Objek';
  FTranslation[trOverview] := 'Sekilas';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trProperties] := 'Property';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Tipe Bentukan';
  FTranslation[trTypes] := 'Tipe Bentukan';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Unit';
  FTranslation[trVariables] := 'Variabel';
  FTranslation[trGvUses] := 'Unit dependency graph'; // TODO: translate
  FTranslation[trGvClasses] := 'Classes hierarchy graph'; // TODO: translate
  FTranslation[trHeadlineCio] := 'Semua Kelas, Interface, dan Objek';
  FTranslation[trHeadlineConstants] := 'Semua Konstanta';
  FTranslation[trHeadlineFunctionsAndProcedures] :=
    'Semua Fungsi dan Prosedur';
  FTranslation[trHeadlineIdentifiers] := 'Semua Identifier';
  FTranslation[trHeadlineTypes] := 'Semua Tipe Bentukan';
  FTranslation[trHeadlineUnits] := 'Semua Unit';
  FTranslation[trHeadlineVariables] := 'Semua Variabel';
  FTranslation[trSummaryCio] := 'Ringkasan Kelas, Interface, dan Objek';
  FTranslation[trWarningOverwrite] := 'Perhatian: Jangan dimodifikasi - '
    + 'file ini dihasilkan secara otomatis dan mungkin saja ditimpa ulang';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trGeneratedBy] := 'Dihasilkan oleh';
  FTranslation[trOnDateTime] := 'pada';
  FTranslation[trDeprecated] := 'this symbol is deprecated'; // TODO: translate
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform'; // TODO: translate
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library';  // TODO: translate
  FTranslation[trIntroduction] := 'Introduction'; // TODO: translate
  FTranslation[trConclusion] := 'Conclusion'; // TODO: translate
  FTranslation[trSearch] := 'Search'; // TODO: translate
  FTranslation[trSeeAlso] := 'See also'; // TODO: translate
  FTranslation[trValues] := 'Values'; // TODO: translate
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.'; // TODO: translate
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.'; // TODO: translate
  FTranslation[trNoTypes] := 'The units do not contain any types.'; // TODO: translate
  FTranslation[trNoVariables] := 'The units do not contain any variables.'; // TODO: translate
  FTranslation[trNoConstants] := 'The units do not contain any constants.'; // TODO: translate
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.'; // TODO: translate
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.'; // TODO: translate
  FTranslation[trProgram] := 'Program'; // TODO: translate
end;
{$ELSE}
const
  aIndonesian: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Indonesian',
  //map
    {trUnits} 'Unit',
    {trClassHierarchy} strToDo, //'Class Hierarchy',
    {trCio} 'Kelas, Interface, dan Objek',
    {trIdentifiers} strToDo, //'Identifiers',
    {trGvUses} strToDo, //'Unit dependency graph',
    {trGvClasses} strToDo, //'Classes hierarchy graph',
  //tables and members
    {trClasses} 'Kelas',
      {trClass} 'Kelas',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} strToDo, //'Interface',
    {trObjects} 'Objek',
      {trObject} 'Objek',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Hirarki',
        {trFields} strToDo, //'Fields',
        {trMethods} strToDo, //'Methods',
        {trProperties} strToDo, //'Properties',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} strKeep, //'Unit',
      {trUses} strToDo, //'Uses',
      {trConstants} 'Konstanta',
      {trFunctionsAndProcedures} 'Fungsi dan Prosedur',
      {trTypes} 'Tipe Bentukan',
        {trType} 'Tipe Bentukan',
      {trVariables} 'Variabel',
      {trAuthors} 'Pembuat',
        {trAuthor} 'Pembuat',
      {trCreated} 'Dibuat',
      {trLastModified} 'Terakhir Dimodifikasi',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} strToDo, //'Parameters',
      {trReturns} strToDo, //'Returns',
      {trExceptionsRaised} strToDo, //'Exceptions raised',
    {trExceptions} strToDo, //'Exceptions',
      {trException} strToDo, //'Exception',
    {trEnum} strToDo, //'Enumeration',
  //visibilities
    {trVisibility} strToDo, //'Visibility',
      {trPrivate} strToDo, //'Private',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} strToDo, //'Protected',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} strToDo, //'Public',
      {trPublished} strToDo, //'Published',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} strToDo, //'this symbol is deprecated',
    {trPlatformSpecific} strToDo, //'this symbol is specific to some platform',
    {trLibrarySpecific} strToDo, //'this symbol is specific to some library',
  //headings
    {trOverview} 'Sekilas',
    {trIntroduction} strToDo, //'Introduction',
    {trConclusion} strToDo, //'Conclusion',
    {trHeadlineCio} 'Semua Kelas, Interface, dan Objek',
    {trHeadlineConstants} 'Semua Konstanta',
    {trHeadlineFunctionsAndProcedures} 'Semua Fungsi dan Prosedur',
    {trHeadlineIdentifiers} 'Semua Identifier',
    {trHeadlineTypes} 'Semua Tipe Bentukan',
    {trHeadlineUnits} 'Semua Unit',
    {trHeadlineVariables} 'Semua Variabel',
    {trSummaryCio} 'Ringkasan Kelas, Interface, dan Objek',
  //column headings
    {trDeclaration} 'Deklarasi',
    {trDescription} 'Definisi',
    {trName} 'Nama',
    {trValues} strToDo, //'Values',
  //empty
    {trNone} 'Tidak Ada',
    {trNoCIOs} strToDo, //'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} strToDo, //'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} strToDo, //'The units do not contain any types.',
    {trNoVariables} strToDo, //'The units do not contain any variables.',
    {trNoConstants} strToDo, //'The units do not contain any constants.',
    {trNoFunctions} strToDo, //'The units do not contain any functions or procedures.',
    {trNoIdentifiers} strToDo, //'The units do not contain any identifiers.',
  //misc
    {trHelp} 'Bantuan',
    {trLegend} 'Legenda',
    {trMarker} strToDo, //'Marker',
    {trWarningOverwrite} 'Perhatian: Jangan dimodifikasi - '
      + 'file ini dihasilkan secara otomatis dan mungkin saja ditimpa ulang',
    {trWarning} 'Perhatian', //?
    {trGeneratedBy} 'Dihasilkan oleh',
    {trOnDateTime} 'pada',
    {trSearch} strToDo, //'Search',
    {trSeeAlso} strToDo, //'See also',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageItalian;
begin
  FTranslation[trAuthor] := 'Autore';
  FTranslation[trAuthors] := 'Autori';
  FTranslation[trCio] := 'Classi, Interfacce ed Oggetti';
  FTranslation[trClass] := 'Classe';
  FTranslation[trClasses] := 'Classi';
  FTranslation[trConstants] := 'Costanti';
  FTranslation[trCreated] := 'Creato';
  FTranslation[trDeclaration] := 'Dichiarazione';
  FTranslation[trDescription] := 'Descrizione';
  FTranslation[trParameters] := 'Parametri';
  FTranslation[trReturns] := 'Ritorni';
  FTranslation[trExceptions] := 'Eccezione';
  FTranslation[trExceptionsRaised] := 'Eccezioni sollevate';
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Campi';
  FTranslation[trFunctionsAndProcedures] := 'Funzioni e Procedure';
  FTranslation[trHelp] := 'Help';
  FTranslation[trHierarchy] := 'Gerarchia';
  FTranslation[trIdentifiers] := 'Identificatori';
  FTranslation[trInterface] := 'Interfacce';
  FTranslation[trLegend] := 'Legenda';
  FTranslation[trMarker] := 'Marker'; // TODO: translate
  FTranslation[trVisibility] := 'Visibility'; // TODO: translate
  FTranslation[trMethods] := 'Metodi';
  FTranslation[trLastModified] := 'Ultima Variazione';
  FTranslation[trName] := 'Nome';
  FTranslation[trNone] := 'Nessuno';
  FTranslation[trObject] := 'Oggetto';
  FTranslation[trObjects] := 'Oggetti';
  FTranslation[trOverview] := 'Sommario';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trProperties] := 'Propriet�';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Tipo';
  FTranslation[trTypes] := 'Tipi';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Units';
  FTranslation[trVariables] := 'Variabili';
  FTranslation[trGvUses] := 'Grafico dipendenze Unit';
  FTranslation[trGvClasses] := 'Grafico gerarchia Classi';
  FTranslation[trHeadlineCio] := 'Tutte le Classi, Interfacce ed Oggetti';
  FTranslation[trHeadlineConstants] := 'Tutte le Costanti';
  FTranslation[trHeadlineFunctionsAndProcedures] :=
    'Tutte le Funzioni e Procedure';
  FTranslation[trHeadlineIdentifiers] := 'Tutti gli Identificatori';
  FTranslation[trHeadlineTypes] := 'Tutti i Tipi';
  FTranslation[trHeadlineUnits] := 'Tutte le Units';
  FTranslation[trHeadlineVariables] := 'Tutte le Variabili';
  FTranslation[trSummaryCio] := 'Sommario di Classi, Interfacce ed Oggetti';
  FTranslation[trWarningOverwrite] :=
    'Attenzione: Non modificare - questo file � stato generato automaticamente e verr� probabilmente sovrascritto';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trGeneratedBy] := 'Generated by'; // TODO: translate
  FTranslation[trOnDateTime] := 'on'; // TODO: translate
  FTranslation[trDeprecated] := 'this symbol is deprecated'; // TODO: translate
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform'; // TODO: translate
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library'; // TODO: translate
  FTranslation[trIntroduction] := 'Introduczione';
  FTranslation[trConclusion] := 'Conclusion'; // TODO: translate
  FTranslation[trSearch] := 'Cerca';
  FTranslation[trSeeAlso] := 'Vedere Anche';
  FTranslation[trValues] := 'Valori';
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.'; // TODO: translate
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.'; // TODO: translate
  FTranslation[trNoTypes] := 'The units do not contain any types.'; // TODO: translate
  FTranslation[trNoVariables] := 'The units do not contain any variables.'; // TODO: translate
  FTranslation[trNoConstants] := 'The units do not contain any constants.'; // TODO: translate
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.'; // TODO: translate
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.'; // TODO: translate
  FTranslation[trProgram] := 'Program'; // TODO: translate
end;
{$ELSE}
const
  aItalian: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Italian',
  //map
    {trUnits} strToDo, //'Units',
    {trClassHierarchy} strToDo, //'Class Hierarchy',
    {trCio} 'Classi, Interfacce ed Oggetti',
    {trIdentifiers} 'Identificatori',
    {trGvUses} 'Grafico dipendenze Unit',
    {trGvClasses} 'Grafico gerarchia Classi',
  //tables and members
    {trClasses} 'Classi',
      {trClass} 'Classe',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} 'Interfacce',
    {trObjects} 'Oggetti',
      {trObject} 'Oggetto',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Gerarchia',
        {trFields} 'Campi',
        {trMethods} 'Metodi',
        {trProperties} 'Propriet�',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} strToDo, //'Unit',
      {trUses} strToDo, //'Uses',
      {trConstants} 'Costanti',
      {trFunctionsAndProcedures} 'Funzioni e Procedure',
      {trTypes} 'Tipi',
        {trType} 'Tipo',
      {trVariables} 'Variabili',
      {trAuthors} 'Autori',
        {trAuthor} 'Autore',
      {trCreated} 'Creato',
      {trLastModified} 'Ultima Variazione',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} 'Parametri',
      {trReturns} 'Ritorni',
      {trExceptionsRaised} 'Eccezioni sollevate',
    {trExceptions} 'Eccezione',
      {trException} strToDo, //'Exception',
    {trEnum} strToDo, //'Enumeration',
  //visibilities
    {trVisibility} strToDo, //'Visibility',
      {trPrivate} strToDo, //'Private',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} strToDo, //'Protected',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} strToDo, //'Public',
      {trPublished} strToDo, //'Published',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} strToDo, //'this symbol is deprecated',
    {trPlatformSpecific} strToDo, //'this symbol is specific to some platform',
    {trLibrarySpecific} strToDo, //'this symbol is specific to some library',
  //headings
    {trOverview} 'Sommario',
    {trIntroduction} 'Introduczione',
    {trConclusion} strToDo, //'Conclusion',
    {trHeadlineCio} 'Tutte le Classi, Interfacce ed Oggetti',
    {trHeadlineConstants} 'Tutte le Costanti',
    {trHeadlineFunctionsAndProcedures} 'Tutte le Funzioni e Procedure',
    {trHeadlineIdentifiers} 'Tutti gli Identificatori',
    {trHeadlineTypes} 'Tutti i Tipi',
    {trHeadlineUnits} 'Tutte le Units',
    {trHeadlineVariables} 'Tutte le Variabili',
    {trSummaryCio} 'Sommario di Classi, Interfacce ed Oggetti',
  //column headings
    {trDeclaration} 'Dichiarazione',
    {trDescription} 'Descrizione',
    {trName} 'Nome',
    {trValues} 'Valori',
  //empty
    {trNone} 'Nessuno',
    {trNoCIOs} strToDo, //'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} strToDo, //'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} strToDo, //'The units do not contain any types.',
    {trNoVariables} strToDo, //'The units do not contain any variables.',
    {trNoConstants} strToDo, //'The units do not contain any constants.',
    {trNoFunctions} strToDo, //'The units do not contain any functions or procedures.',
    {trNoIdentifiers} strToDo, //'The units do not contain any identifiers.',
  //misc
    {trHelp} strToDo, //'Help',
    {trLegend} 'Legenda',
    {trMarker} strToDo, //'Marker',
    {trWarningOverwrite} 'Attenzione: Non modificare - questo file � stato generato automaticamente e verr� probabilmente sovrascritto',
    {trWarning} 'Attenzione',
    {trGeneratedBy} strToDo, //'Generated by',
    {trOnDateTime} strToDo, //'on',
    {trSearch} 'Cerca',
    {trSeeAlso} 'Vedere Anche',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageJavanese;
begin
  FTranslation[trAuthor] := 'Sing Nggawe';
  FTranslation[trAuthors] := 'Sing Nggawe';
  FTranslation[trCio] := 'Kelas, Interface, lan Objek';
  FTranslation[trClass] := 'Kelas';
  FTranslation[trClasses] := 'Kelas';
  FTranslation[trConstants] := 'Konstanta';
  FTranslation[trCreated] := 'Digawe';
  FTranslation[trDeclaration] := 'Deklarasi';
  FTranslation[trDescription] := 'Katrangan';
  FTranslation[trParameters] := 'Parameters';
  FTranslation[trReturns] := 'Returns';
  FTranslation[trExceptions] := 'Exceptions'; // TODO: translate
  FTranslation[trExceptionsRaised] := 'Exceptions raised'; // TODO: translate
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Field';
  FTranslation[trFunctionsAndProcedures] := 'Fungsi lan Prosedur';
  FTranslation[trHelp] := 'Tulung';
  FTranslation[trHierarchy] := 'Hirarki';
  FTranslation[trIdentifiers] := 'Identifier';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'Katrangan';
  FTranslation[trMarker] := 'Marker'; // TODO: translate
  FTranslation[trVisibility] := 'Visibility'; // TODO: translate
  FTranslation[trMethods] := 'Method';
  FTranslation[trLastModified] := 'Terakhir Diowahi';
  FTranslation[trName] := 'Jeneng';
  FTranslation[trNone] := 'Mboten Wonten';
  FTranslation[trObject] := 'Objek';
  FTranslation[trObjects] := 'Objek';
  FTranslation[trOverview] := 'Pambuka';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trProperties] := 'Property';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Macem Gawean';
  FTranslation[trTypes] := 'Macem Gawean';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Unit';
  FTranslation[trVariables] := 'Variabel';
  FTranslation[trGvUses] := 'Unit dependency graph'; // TODO: translate
  FTranslation[trGvClasses] := 'Classes hierarchy graph'; // TODO: translate
  FTranslation[trHeadlineCio] := 'Kabeh Kelas, Interface, lan Objek';
  FTranslation[trHeadlineConstants] := 'Kabeh Konstanta';
  FTranslation[trHeadlineFunctionsAndProcedures] :=
    'Kabeh Fungsi lan Prosedur';
  FTranslation[trHeadlineIdentifiers] := 'Kabeh Identifier';
  FTranslation[trHeadlineTypes] := 'Kabeh Macem Gawean';
  FTranslation[trHeadlineUnits] := 'Kabeh Unit';
  FTranslation[trHeadlineVariables] := 'Kabeh Variabel';
  FTranslation[trSummaryCio] := 'Ringkesan Kelas, Interface, lan Objek';
  FTranslation[trWarningOverwrite] := 'Ati-ati: Ojo diowahi - '
    + 'file iki digawe otomatis dadi iso ilang owahanmu';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trGeneratedBy] := 'Dihasilne karo';
  FTranslation[trOnDateTime] := 'ing';
  FTranslation[trDeprecated] := 'this symbol is deprecated'; // TODO: translate
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform'; // TODO: translate
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library'; // TODO: translate
  FTranslation[trIntroduction] := 'Introduction'; // TODO: translate
  FTranslation[trConclusion] := 'Conclusion'; // TODO: translate
  FTranslation[trSearch] := 'Search'; // TODO: translate
  FTranslation[trSeeAlso] := 'See also'; // TODO: translate
  FTranslation[trValues] := 'Values'; // TODO: translate
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.'; // TODO: translate
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.'; // TODO: translate
  FTranslation[trNoTypes] := 'The units do not contain any types.'; // TODO: translate
  FTranslation[trNoVariables] := 'The units do not contain any variables.'; // TODO: translate
  FTranslation[trNoConstants] := 'The units do not contain any constants.'; // TODO: translate
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.'; // TODO: translate
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.'; // TODO: translate
  FTranslation[trProgram] := 'Program'; // TODO: translate
end;
{$ELSE}
const
  aJavanese: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Javanese',
  //map
    {trUnits} strToDo, //'Units',
    {trClassHierarchy} strToDo, //'Class Hierarchy',
    {trCio} 'Kelas, Interface, lan Objek',
    {trIdentifiers} strToDo, //'Identifiers',
    {trGvUses} strToDo, //'Unit dependency graph',
    {trGvClasses} strToDo, //'Classes hierarchy graph',
  //tables and members
    {trClasses} 'Kelas',
      {trClass} 'Kelas',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} strToDo, //'Interface',
    {trObjects} 'Objek',
      {trObject} 'Objek',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Hirarki',
        {trFields} strToDo, //'Fields',
        {trMethods} strToDo, //'Methods',
        {trProperties} strToDo, //'Properties',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} strToDo, //'Unit',
      {trUses} strToDo, //'Uses',
      {trConstants} 'Konstanta',
      {trFunctionsAndProcedures} 'Fungsi lan Prosedur',
      {trTypes} 'Macem Gawean',
        {trType} 'Macem Gawean',
      {trVariables} 'Variabel',
      {trAuthors} 'Sing Nggawe',
        {trAuthor} 'Sing Nggawe',
      {trCreated} 'Digawe',
      {trLastModified} 'Terakhir Diowahi',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} strToDo, //'Parameters',
      {trReturns} strToDo, //'Returns',
      {trExceptionsRaised} strToDo, //'Exceptions raised',
    {trExceptions} strToDo, //'Exceptions',
      {trException} strToDo, //'Exception',
    {trEnum} strToDo, //'Enumeration',
  //visibilities
    {trVisibility} strToDo, //'Visibility',
      {trPrivate} strToDo, //'Private',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} strToDo, //'Protected',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} strToDo, //'Public',
      {trPublished} strToDo, //'Published',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} strToDo, //'this symbol is deprecated',
    {trPlatformSpecific} strToDo, //'this symbol is specific to some platform',
    {trLibrarySpecific} strToDo, //'this symbol is specific to some library',
  //headings
    {trOverview} 'Pambuka',
    {trIntroduction} strToDo, //'Introduction',
    {trConclusion} strToDo, //'Conclusion',
    {trHeadlineCio} 'Kabeh Kelas, Interface, lan Objek',
    {trHeadlineConstants} 'Kabeh Konstanta',
    {trHeadlineFunctionsAndProcedures} 'Kabeh Fungsi lan Prosedur',
    {trHeadlineIdentifiers} 'Kabeh Identifier',
    {trHeadlineTypes} 'Kabeh Macem Gawean',
    {trHeadlineUnits} 'Kabeh Unit',
    {trHeadlineVariables} 'Kabeh Variabel',
    {trSummaryCio} 'Ringkesan Kelas, Interface, lan Objek',
  //column headings
    {trDeclaration} 'Deklarasi',
    {trDescription} 'Katrangan',
    {trName} 'Jeneng',
    {trValues} strToDo, //'Values',
  //empty
    {trNone} 'Mboten Wonten',
    {trNoCIOs} strToDo, //'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} strToDo, //'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} strToDo, //'The units do not contain any types.',
    {trNoVariables} strToDo, //'The units do not contain any variables.',
    {trNoConstants} strToDo, //'The units do not contain any constants.',
    {trNoFunctions} strToDo, //'The units do not contain any functions or procedures.',
    {trNoIdentifiers} strToDo, //'The units do not contain any identifiers.',
  //misc
    {trHelp} 'Tulung',
    {trLegend} 'Katrangan',
    {trMarker} strToDo, //'Marker',
    {trWarningOverwrite} 'Ati-ati: Ojo diowahi - '
      + 'file iki digawe otomatis dadi iso ilang owahanmu',
    {trWarning} 'Ati-ati', //?
    {trGeneratedBy} 'Dihasilne karo',
    {trOnDateTime} 'ing',
    {trSearch} strToDo, //'Search',
    {trSeeAlso} strToDo, //'See also',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguagePolish_CP1250;
begin
  FTranslation[trAuthor] := 'Autor';
  FTranslation[trAuthors] := 'Autorzy';
  FTranslation[trAutomated] := 'Automated';
  FTranslation[trCio] := 'Klasy, interfejsy, obiekty i rekordy';
  FTranslation[trClass] := 'Klasa';
  FTranslation[trClasses] := 'Klasy';
  FTranslation[trClassHierarchy] := 'Hierarchia klas';
  FTranslation[trConstants] := 'Sta�e';
  FTranslation[trCreated] := 'Utworzony';
  FTranslation[trDeclaration] := 'Deklaracja';
  FTranslation[trDescription] := 'Opis';
  FTranslation[trParameters] := 'Parametry';
  FTranslation[trReturns] := 'Wynik';
  FTranslation[trExceptions] := 'Wyj�tki';
  FTranslation[trExceptionsRaised] := 'Generowane wyj�tki';
  FTranslation[trEnum] := 'Wyliczenie';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Pola';
  FTranslation[trFunctionsAndProcedures] := 'Podprogramy';
  FTranslation[trHelp] := 'Pomoc';
  FTranslation[trHierarchy] := 'Hierarchia';
  FTranslation[trIdentifiers] := 'Identyfikatory';
  FTranslation[trInterface] := 'Interfejs';
  FTranslation[trLegend] := 'Legenda';
  FTranslation[trMarker] := 'Kolor';
  FTranslation[trVisibility] := 'Widoczno��';
  FTranslation[trMethods] := 'Metody';
  FTranslation[trLastModified] := 'Ostatnia modyfikacja';
  FTranslation[trName] := 'Nazwa';
  FTranslation[trNone] := 'Brak';
  FTranslation[trObject] := 'Obiekt';
  FTranslation[trObjects] := 'Obiekty';
  FTranslation[trOverview] := 'Przegl�d';
  FTranslation[trPrivate] := 'Prywatne';
  FTranslation[trProperties] := 'W�a�ciwo�ci';
  FTranslation[trProtected] := 'Chronione';
  FTranslation[trPublic] := 'Publiczne';
  FTranslation[trImplicit] := 'Domy�lne';
  FTranslation[trPublished] := 'Publikowane';
  FTranslation[trType] := 'Typ';
  FTranslation[trTypes] := 'Typy';
  FTranslation[trUnit] := 'Modu�';
  FTranslation[trUnits] := 'Modu�y';
  FTranslation[trVariables] := 'Zmienne';
  FTranslation[trGvUses] := 'Graf zale�no�ci modu��w';
  FTranslation[trGvClasses] := 'Graf dziedziczenia klas';
  FTranslation[trHeadlineCio] := 'Wszystkie klasy, interfejsy, obiekty i rekordy';
  FTranslation[trHeadlineConstants] := 'Wszystkie sta�e';
  FTranslation[trHeadlineFunctionsAndProcedures] := 'Wszystkie podprogramy';
  FTranslation[trHeadlineIdentifiers] := 'Wszystkie identyfikatory';
  FTranslation[trHeadlineTypes] := 'Wszystkie typy';
  FTranslation[trHeadlineUnits] := 'Wszystkie modu�y';
  FTranslation[trHeadlineVariables] := 'Wszystkie zmienne';
  FTranslation[trSummaryCio] := 
    'Podsumowanie klas, interfejs�w, obiekt�w i rekord�w';
  FTranslation[trWarningOverwrite] :=
    'Uwaga, nie modyfikuj - ten plik zosta� wygenerowany automatycznie i mo�e zosta� nadpisany';
  FTranslation[trWarning] := 'Uwaga';
  FTranslation[trGeneratedBy] := 'Wygenerowane przez';
  FTranslation[trOnDateTime] := ' - ';
  FTranslation[trDeprecated] := 'odradza si� u�ywania tego identyfikatora';
  FTranslation[trPlatformSpecific] := 'ten identyfikator jest zale�ny od platformy';
  FTranslation[trLibrarySpecific] := 'ten identyfikator jest zale�ny od biblioteki';
  FTranslation[trIntroduction] := 'Wst�p';
  FTranslation[trConclusion] := 'Podsumowanie';
  FTranslation[trSearch] := 'Szukaj';
  FTranslation[trSeeAlso] := 'Zobacz tak�e';
  FTranslation[trValues] := 'Warto�ci';
  FTranslation[trNoCIOs] := 'Modu� nie zawiera �adnych klas, interfejs�w, obiekt�w ani rekord�w.';
  FTranslation[trNoCIOsForHierarchy] := 'Modu� nie zawiera �adnych klas, interfejs�w ani obiekt�w.';
  FTranslation[trNoTypes] := 'Modu� nie zawiera �adnych typ�w.';
  FTranslation[trNoVariables] := 'Modu� nie zawiera �adnych zmiennych.';
  FTranslation[trNoConstants] := 'Modu� nie zawiera �adnych sta�ych.';
  FTranslation[trNoFunctions] := 'Modu� nie zawiera �adnych funkcji ani podprogram�w.';
  FTranslation[trNoIdentifiers] := 'Modu� nie zawiera �adnych identyfikator�w.';
  FTranslation[trProgram] := 'Program';
end;
{$ELSE}
const
  aPolish1250: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Polish',
  //map
    {trUnits} 'Modu�y',
    {trClassHierarchy} 'Hierarchia klas',
    {trCio} 'Klasy, interfejsy, obiekty i rekordy',
    {trIdentifiers} 'Identyfikatory',
    {trGvUses} 'Graf zale�no�ci modu��w',
    {trGvClasses} 'Graf dziedziczenia klas',
  //tables and members
    {trClasses} 'Klasy',
      {trClass} 'Klasa',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} 'Interfejs',
    {trObjects} 'Obiekty',
      {trObject} 'Obiekt',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Hierarchia',
        {trFields} 'Pola',
        {trMethods} 'Metody',
        {trProperties} 'W�a�ciwo�ci',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} 'Modu�',
      {trUses} strToDo, //'Uses',
      {trConstants} 'Sta�e',
      {trFunctionsAndProcedures} 'Podprogramy',
      {trTypes} 'Typy',
        {trType} 'Typ',
      {trVariables} 'Zmienne',
      {trAuthors} 'Autorzy',
        {trAuthor} 'Autor',
      {trCreated} 'Utworzony',
      {trLastModified} 'Ostatnia modyfikacja',
    {trSubroutine} 'Podprograma', //?
      {trParameters} 'Parametry',
      {trReturns} 'Wynik',
      {trExceptionsRaised} 'Generowane wyj�tki',
    {trExceptions} 'Wyj�tki',
      {trException} strToDo, //'Exception',
    {trEnum} 'Wyliczenie',
  //visibilities
    {trVisibility} 'Kabeh Unit',
      {trPrivate} 'Prywatne',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} 'Chronione',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} 'Publiczne',
      {trPublished} 'Publikowane',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} 'Domy�lne',
  //hints
    {trDeprecated} 'odradza si� u�ywania tego identyfikatora',
    {trPlatformSpecific} 'ten identyfikator jest zale�ny od platformy',
    {trLibrarySpecific} 'ten identyfikator jest zale�ny od biblioteki',
  //headings
    {trOverview} 'Przegl�d',
    {trIntroduction} 'Wst�p',
    {trConclusion} 'Podsumowanie',
    {trHeadlineCio} 'Wszystkie klasy, interfejsy, obiekty i rekordy',
    {trHeadlineConstants} 'Wszystkie sta�e',
    {trHeadlineFunctionsAndProcedures} 'Wszystkie podprogramy',
    {trHeadlineIdentifiers} 'Wszystkie identyfikatory',
    {trHeadlineTypes} 'Wszystkie typy',
    {trHeadlineUnits} 'Wszystkie modu�y',
    {trHeadlineVariables} 'Wszystkie zmienne',
    {trSummaryCio} 'Podsumowanie klas, interfejs�w, obiekt�w i rekord�w',
  //column headings
    {trDeclaration} 'Deklaracja',
    {trDescription} 'Opis',
    {trName} 'Nazwa',
    {trValues} 'Warto�ci',
  //empty
    {trNone} 'Brak',
    {trNoCIOs} 'Modu� nie zawiera �adnych klas, interfejs�w, obiekt�w ani rekord�w.',
    {trNoCIOsForHierarchy} 'Modu� nie zawiera �adnych klas, interfejs�w ani obiekt�w.',
    {trNoTypes} 'Modu� nie zawiera �adnych typ�w.',
    {trNoVariables} 'Modu� nie zawiera �adnych zmiennych.',
    {trNoConstants} 'Modu� nie zawiera �adnych sta�ych.',
    {trNoFunctions} 'Modu� nie zawiera �adnych funkcji ani podprogram�w.',
    {trNoIdentifiers} 'Modu� nie zawiera �adnych identyfikator�w.',
  //misc
    {trHelp} 'Pomoc',
    {trLegend} 'Legenda',
    {trMarker} 'Kolor',
    {trWarningOverwrite} 'Uwaga, nie modyfikuj - ten plik zosta� wygenerowany automatycznie i mo�e zosta� nadpisany',
    {trWarning} 'Uwaga',
    {trGeneratedBy} 'Wygenerowane przez',
    {trOnDateTime} ' - ',
    {trSearch} 'Szukaj',
    {trSeeAlso} 'Zobacz tak�e',
    ''  //dummy
  );
{$ENDIF}

{$IFDEF old}
procedure TPasDocLanguages.SetLanguagePolish_ISO_8859_2;
begin
  FTranslation[trAuthor] := 'Autor';
  FTranslation[trAuthors] := 'Autorzy';
  FTranslation[trAutomated] := 'Automated';
  FTranslation[trCio] := 'Klasy, interfejsy, obiekty i rekordy';
  FTranslation[trClass] := 'Klasa';
  FTranslation[trClasses] := 'Klasy';
  FTranslation[trClassHierarchy] := 'Hierarchia klas';
  FTranslation[trConstants] := 'Sta�e';
  FTranslation[trCreated] := 'Utworzony';
  FTranslation[trDeclaration] := 'Deklaracja';
  FTranslation[trDescription] := 'Opis';
  FTranslation[trParameters] := 'Parametry';
  FTranslation[trReturns] := 'Wynik';
  FTranslation[trExceptions] := 'Wyj�tki';
  FTranslation[trExceptionsRaised] := 'Generowane wyj�tki';
  FTranslation[trEnum] := 'Wyliczenie';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Pola';
  FTranslation[trFunctionsAndProcedures] := 'Podprogramy';
  FTranslation[trHelp] := 'Pomoc';
  FTranslation[trHierarchy] := 'Hierarchia';
  FTranslation[trIdentifiers] := 'Identyfikatory';
  FTranslation[trInterface] := 'Interfejs';
  FTranslation[trLegend] := 'Legenda';
  FTranslation[trMarker] := 'Kolor';
  FTranslation[trVisibility] := 'Widoczno��';
  FTranslation[trMethods] := 'Metody';
  FTranslation[trLastModified] := 'Ostatnia modyfikacja';
  FTranslation[trName] := 'Nazwa';
  FTranslation[trNone] := 'Brak';
  FTranslation[trObject] := 'Obiekt';
  FTranslation[trObjects] := 'Obiekty';
  FTranslation[trOverview] := 'Przegl�d';
  FTranslation[trPrivate] := 'Prywatne';
  FTranslation[trProperties] := 'W�a�ciwo�ci';
  FTranslation[trProtected] := 'Chronione';
  FTranslation[trPublic] := 'Publiczne';
  FTranslation[trImplicit] := 'Domy�lne';
  FTranslation[trPublished] := 'Publikowane';
  FTranslation[trType] := 'Typ';
  FTranslation[trTypes] := 'Typy';
  FTranslation[trUnit] := 'Modu�';
  FTranslation[trUnits] := 'Modu�y';
  FTranslation[trVariables] := 'Zmienne';
  FTranslation[trGvUses] := 'Graf zale�no�ci modu��w';
  FTranslation[trGvClasses] := 'Graf dziedziczenia klas';
  FTranslation[trHeadlineCio] := 'Wszystkie klasy, interfejsy, obiekty i rekordy';
  FTranslation[trHeadlineConstants] := 'Wszystkie sta�e';
  FTranslation[trHeadlineFunctionsAndProcedures] := 'Wszystkie podprogramy';
  FTranslation[trHeadlineIdentifiers] := 'Wszystkie identyfikatory';
  FTranslation[trHeadlineTypes] := 'Wszystkie typy';
  FTranslation[trHeadlineUnits] := 'Wszystkie modu�y';
  FTranslation[trHeadlineVariables] := 'Wszystkie zmienne';
  FTranslation[trSummaryCio] :=
    'Podsumowanie klas, interfejs�w, obiekt�w i rekord�w';
  FTranslation[trWarningOverwrite] :=
    'Uwaga, nie modyfikuj - ten plik zosta� wygenerowany automatycznie i mo�e zosta� nadpisany';
  FTranslation[trWarning] := 'Uwaga';
  FTranslation[trGeneratedBy] := 'Wygenerowane przez';
  FTranslation[trOnDateTime] := ' - ';
  FTranslation[trDeprecated] := 'odradza si� u�ywania tego identyfikatora';
  FTranslation[trPlatformSpecific] := 'ten identyfikator jest zale�ny od platformy';
  FTranslation[trLibrarySpecific] := 'ten identyfikator jest zale�ny od biblioteki';
  FTranslation[trIntroduction] := 'Wst�p';
  FTranslation[trConclusion] := 'Podsumowanie';
  FTranslation[trSearch] := 'Szukaj';
  FTranslation[trSeeAlso] := 'Zobacz tak�e';
  FTranslation[trValues] := 'Warto�ci';
  FTranslation[trNoCIOs] := 'Modu� nie zawiera �adnych klas, interfejs�w, obiekt�w ani rekord�w.';
  FTranslation[trNoCIOsForHierarchy] := 'Modu� nie zawiera �adnych klas, interfejs�w ani obiekt�w.';
  FTranslation[trNoTypes] := 'Modu� nie zawiera �adnych typ�w.';
  FTranslation[trNoVariables] := 'Modu� nie zawiera �adnych zmiennych.';
  FTranslation[trNoConstants] := 'Modu� nie zawiera �adnych sta�ych.';
  FTranslation[trNoFunctions] := 'Modu� nie zawiera �adnych funkcji ani podprogram�w.';
  FTranslation[trNoIdentifiers] := 'Modu� nie zawiera �adnych identyfikator�w.';
  FTranslation[trProgram] := 'Program';
end;
{$ELSE}
const
  aPolish_ISO_8859_2: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Polish',
  //map
    {trUnits} 'Modu�y',
    {trClassHierarchy} 'Hierarchia klas',
    {trCio} 'Klasy, interfejsy, obiekty i rekordy',
    {trIdentifiers} 'Identyfikatory',
    {trGvUses} 'Graf zale�no�ci modu��w',
    {trGvClasses} 'Graf dziedziczenia klas',
  //tables and members
    {trClasses} 'Klasy',
      {trClass} 'Klasa',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} 'Interfejs',
    {trObjects} 'Obiekty',
      {trObject} 'Obiekt',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Hierarchia',
        {trFields} 'Pola',
        {trMethods} 'Metody',
        {trProperties} 'W�a�ciwo�ci',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} 'Modu�',
      {trUses} strToDo, //'Uses',
      {trConstants} 'Sta�e',
      {trFunctionsAndProcedures} 'Podprogramy',
      {trTypes} 'Typy',
        {trType} 'Typ',
      {trVariables} 'Zmienne',
      {trAuthors} 'Autorzy',
        {trAuthor} 'Autor',
      {trCreated} 'Utworzony',
      {trLastModified} 'Ostatnia modyfikacja',
    {trSubroutine} 'Podprograma', //???
      {trParameters} 'Parametry',
      {trReturns} 'Wynik',
      {trExceptionsRaised} 'Generowane wyj�tki',
    {trExceptions} 'Wyj�tki',
      {trException} strToDo, //'Exception',
    {trEnum} 'Wyliczenie',
  //visibilities
    {trVisibility} 'Widoczno��',
      {trPrivate} 'Prywatne',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} 'Chronione',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} 'Publiczne',
      {trPublished} 'Publikowane',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} 'Domy�lne',
  //hints
    {trDeprecated} 'odradza si� u�ywania tego identyfikatora',
    {trPlatformSpecific} 'ten identyfikator jest zale�ny od platformy',
    {trLibrarySpecific} 'ten identyfikator jest zale�ny od biblioteki',
  //headings
    {trOverview} 'Przegl�d',
    {trIntroduction} 'Wst�p',
    {trConclusion} 'Podsumowanie',
    {trHeadlineCio} 'Wszystkie klasy, interfejsy, obiekty i rekordy',
    {trHeadlineConstants} 'Wszystkie sta�e',
    {trHeadlineFunctionsAndProcedures} 'Wszystkie podprogramy',
    {trHeadlineIdentifiers} 'Wszystkie identyfikatory',
    {trHeadlineTypes} 'Wszystkie typy',
    {trHeadlineUnits} 'Wszystkie modu�y',
    {trHeadlineVariables} 'Wszystkie zmienne',
    {trSummaryCio} 'Podsumowanie klas, interfejs�w, obiekt�w i rekord�w',
  //column headings
    {trDeclaration} 'Deklaracja',
    {trDescription} 'Opis',
    {trName} 'Nazwa',
    {trValues} 'Warto�ci',
  //empty
    {trNone} 'Brak',
    {trNoCIOs} 'Modu� nie zawiera �adnych klas, interfejs�w, obiekt�w ani rekord�w.',
    {trNoCIOsForHierarchy} 'Modu� nie zawiera �adnych klas, interfejs�w ani obiekt�w.',
    {trNoTypes} 'Modu� nie zawiera �adnych typ�w.',
    {trNoVariables} 'Modu� nie zawiera �adnych zmiennych.',
    {trNoConstants} 'Modu� nie zawiera �adnych sta�ych.',
    {trNoFunctions} 'Modu� nie zawiera �adnych funkcji ani podprogram�w.',
    {trNoIdentifiers} 'Modu� nie zawiera �adnych identyfikator�w.',
  //misc
    {trHelp} 'Pomoc',
    {trLegend} 'Legenda',
    {trMarker} 'Kolor',
    {trWarningOverwrite} 'Uwaga, nie modyfikuj - ten plik zosta� wygenerowany automatycznie i mo�e zosta� nadpisany',
    {trWarning} 'Uwaga',
    {trGeneratedBy} 'Wygenerowane przez',
    {trOnDateTime} ' - ',
    {trSearch} 'Szukaj',
    {trSeeAlso} 'Zobacz tak�e',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageRussian_1251;
begin
  FTranslation[trAuthor] := '�����';
  FTranslation[trAuthors] := '������';
  FTranslation[trCio] := '������, ���������� � �������';
  FTranslation[trClass] := '�����';
  FTranslation[trClasses] := '������';
  FTranslation[trClassHierarchy] := '�������� �������';
  FTranslation[trConstants] := '���������';
  FTranslation[trCreated] := '�������';
  FTranslation[trDeclaration] := '����������';
  FTranslation[trParameters] := '���������'; // DONE: translate
  FTranslation[trReturns] := '������������ ��������'; // DONE: translate
  FTranslation[trExceptions] := '����������'; // DONE: translate
  FTranslation[trExceptionsRaised] := '�������� ����������'; // DONE: translate
  FTranslation[trEnum] := '������������';
  FTranslation[trDescription] := '��������';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := '����';
  FTranslation[trFunctionsAndProcedures] := '��������� � �������';
  FTranslation[trHelp] := 'Help';
    // Untranslated to avoid Russian file name for css
  FTranslation[trHierarchy] := '��������';
  FTranslation[trIdentifiers] := '��������������';
  FTranslation[trInterface] := '���������';
  FTranslation[trLegend] := '�����������';
  FTranslation[trMarker] := '������'; // DONE: translate
  FTranslation[trVisibility] := '���� ���������'; // DONE: translate
  FTranslation[trLastModified] := '��������� ���������';
  FTranslation[trMethods] := '������';
  FTranslation[trName] := '���';
  FTranslation[trNone] := '���';
  FTranslation[trObject] := '������';
  FTranslation[trObjects] := '�������';
  FTranslation[trOverview] := '�����';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trProperties] := '��������';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := '���';
  FTranslation[trTypes] := '����';
  FTranslation[trUnit] := '������';
  FTranslation[trUnits] := '������';
  FTranslation[trVariables] := '����������';
  FTranslation[trGvUses] := '������ ����������� �������'; // DONE: translate
  FTranslation[trGvClasses] := '������ �������� �������'; // DONE: translate
  FTranslation[trWarningOverwrite] :=
    '��������������: �� ������������� - ���� ���� ������ ������������� � ����� ���� ������ ��� ��������������';
  FTranslation[trWarning] := '��������������';  // DONE: translate
  FTranslation[trHeadlineCio] := '��� ������, ���������� � �������';
  FTranslation[trHeadlineConstants] := '��� ���������';
  FTranslation[trHeadlineFunctionsAndProcedures] := '��� ��������� � �������';
  FTranslation[trHeadlineIdentifiers] := '��� ��������������';
  FTranslation[trHeadlineTypes] := '��� ����';
  FTranslation[trHeadlineUnits] := '��� ������';
  FTranslation[trHeadlineVariables] := '��� ����������';
  FTranslation[trSummaryCio] := '������ �������, ����������� � ��������';
  FTranslation[trGeneratedBy] := '������������ '; // DONE: translate
  FTranslation[trOnDateTime] := '����/�����'; // DONE: translate
  FTranslation[trDeprecated] := '���� ������ ������ �� ������������'; // DONE: translate
  FTranslation[trPlatformSpecific] := '���� ������ ������� �� ���������'; // DONE: translate
  FTranslation[trLibrarySpecific] := '���� ������ ������� �� ����������'; // DONE: translate
  FTranslation[trIntroduction] := '��������'; // DONE: translate
  FTranslation[trConclusion] := '����������'; // DONE: translate
  FTranslation[trSearch] := '�����'; // DONE: translate
  FTranslation[trSeeAlso] := '��������� �� ����'; // DONE: translate
  FTranslation[trValues] := '��������'; // DONE: translate
  FTranslation[trNoCIOs] := '������ �� �������� �������, �����������, �������� � �������.'; // DONE: translate
  FTranslation[trNoCIOsForHierarchy] := '������ �� �������� �������, ����������� � ��������.'; // DONE: translate
  FTranslation[trNoTypes] := '������ �� �������� �����.'; // DONE: translate
  FTranslation[trNoVariables] := '������ �� �������� ����������.'; // DONE: translate
  FTranslation[trNoConstants] := '������ �� �������� ��������.'; // DONE: translate
  FTranslation[trNoFunctions] := '������ �� �������� ������� � ���������.'; // DONE: translate
  FTranslation[trNoIdentifiers] := '������ �� �������� �� ������ ��������������.'; // DONE: translate
  FTranslation[trProgram] := '���������'; // DONE: translate
  FTranslation[trUses] := '������������ ������';
end;
{$ELSE}
const
  aRussian_1251: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Russian',
  //map
    {trUnits} '������',
    {trClassHierarchy} '�������� �������',
    {trCio} '������, ���������� � �������',
    {trIdentifiers} '��������������',
    {trGvUses} '������ ����������� �������',
    {trGvClasses} '������ �������� �������',
  //tables and members
    {trClasses} '������',
      {trClass} '�����',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} '���������',
    {trObjects} '�������',
      {trObject} '������',
      {trRecord} strToDo, //'Record',
        {trHierarchy} '��������',
        {trFields} '����',
        {trMethods} '������',
        {trProperties} '��������',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} '���������',
    {trUnit} '������',
      {trUses} '������������ ������',
      {trConstants} '���������',
      {trFunctionsAndProcedures} '��������� � �������',
      {trTypes} '����',
        {trType} '���',
      {trVariables} '����������',
      {trAuthors} '������',
        {trAuthor} '�����',
      {trCreated} '�������',
      {trLastModified} '��������� ���������',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} '���������',
      {trReturns} '������������ ��������',
      {trExceptionsRaised} '�������� ����������',
    {trExceptions} '����������',
      {trException} strToDo, //'Exception',
    {trEnum} '������������',
  //visibilities
    {trVisibility} '���� ���������',
      {trPrivate} strToDo, //'Private',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} strToDo, //'Protected',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} strToDo, //'Public',
      {trPublished} strToDo, //'Published',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} '���� ������ ������ �� ������������',
    {trPlatformSpecific} '���� ������ ������� �� ���������',
    {trLibrarySpecific} '���� ������ ������� �� ����������',
  //headings
    {trOverview} '�����',
    {trIntroduction} '��������',
    {trConclusion} '����������',
    {trHeadlineCio} '��� ������, ���������� � �������',
    {trHeadlineConstants} '��� ���������',
    {trHeadlineFunctionsAndProcedures} '��� ��������� � �������',
    {trHeadlineIdentifiers} '��� ��������������',
    {trHeadlineTypes} '��� ����',
    {trHeadlineUnits} '��� ������',
    {trHeadlineVariables} '��� ����������',
    {trSummaryCio} '������ �������, ����������� � ��������',
  //column headings
    {trDeclaration} '����������',
    {trDescription} '��������',
    {trName} '���',
    {trValues} '��������',
  //empty
    {trNone} '���',
    {trNoCIOs} '������ �� �������� �������, �����������, �������� � �������.',
    {trNoCIOsForHierarchy} '������ �� �������� �������, ����������� � ��������.',
    {trNoTypes} '������ �� �������� �����.',
    {trNoVariables} '������ �� �������� ����������.',
    {trNoConstants} '������ �� �������� ��������.',
    {trNoFunctions} '������ �� �������� ������� � ���������.',
    {trNoIdentifiers} '������ �� �������� �� ������ ��������������.',
  //misc
    {trHelp} strKeep, //'Help', // Untranslated to avoid Russian file name for css
      { TODO : how does "Help" interfere with file names? }
    {trLegend} '�����������',
    {trMarker} '������',
    {trWarningOverwrite} '��������������: �� ������������� - ���� ���� ������ ������������� � ����� ���� ������ ��� ��������������',
    {trWarning} '��������������',
    {trGeneratedBy} '������������', // + ' '?
    {trOnDateTime} '����/�����', //really???
    {trSearch} '�����',
    {trSeeAlso} '��������� �� ����',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

procedure TPasDocLanguages.SetLanguageRussian_866;
begin
  FTranslation[trAuthor] := '����';
  FTranslation[trAuthors] := '�����';
  FTranslation[trCio] := '������, ����䥩�� � ��ꥪ��';
  FTranslation[trClass] := '�����';
  FTranslation[trClasses] := '������';
  FTranslation[trClassHierarchy] := '������ ����ᮢ';
  FTranslation[trConstants] := '����⠭��';
  FTranslation[trCreated] := '�������';
  FTranslation[trDeclaration] := '�������';
  FTranslation[trParameters] := '��ࠬ����'; // DONE: translate
  FTranslation[trReturns] := '�����頥�� ���祭��'; // DONE: translate
  FTranslation[trExceptions] := '�᪫�祭��'; // DONE: translate
  FTranslation[trExceptionsRaised] := '��뢠�� �᪫�祭��'; // DONE: translate
  FTranslation[trEnum] := '����᫥���';
  FTranslation[trDescription] := '���ᠭ��';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := '����';
  FTranslation[trFunctionsAndProcedures] := '��楤��� � �㭪樨';
  FTranslation[trHelp] := 'Help';
    // Untranslated to avoid Russian file name for css
  FTranslation[trHierarchy] := '������';
  FTranslation[trIdentifiers] := '�����䨪����';
  FTranslation[trInterface] := '����䥩�';
  FTranslation[trLegend] := '������祭��';
  FTranslation[trMarker] := '��થ�'; // DONE: translate
  FTranslation[trVisibility] := '���� ��������'; // DONE: translate
  FTranslation[trLastModified] := '��᫥���� ���������';
  FTranslation[trMethods] := '��⮤�';
  FTranslation[trName] := '���';
  FTranslation[trNone] := '���';
  FTranslation[trObject] := '��ꥪ�';
  FTranslation[trObjects] := '��ꥪ��';
  FTranslation[trOverview] := '�����';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trProperties] := '�����⢠';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := '���';
  FTranslation[trTypes] := '����';
  FTranslation[trUnit] := '�����';
  FTranslation[trUnits] := '���㫨';
  FTranslation[trVariables] := '��६����';
  FTranslation[trGvUses] := '��䨪 ����ᨬ��� ���㫥�'; // DONE: translate
  FTranslation[trGvClasses] := '��䨪 ����娨 ����ᮢ'; // DONE: translate
  FTranslation[trWarningOverwrite] :=
    '�।�०�����: �� ।���஢��� - ��� 䠩� ᮧ��� ��⮬���᪨ � ����� ���� ������ ��� �।�०�����';
  FTranslation[trWarning] := '�।�०�����';  // DONE: translate
  FTranslation[trHeadlineCio] := '�� ������, ����䥩�� � ��ꥪ��';
  FTranslation[trHeadlineConstants] := '�� ����⠭��';
  FTranslation[trHeadlineFunctionsAndProcedures] := '�� ��楤��� � �㭪樨';
  FTranslation[trHeadlineIdentifiers] := '�� �����䨪����';
  FTranslation[trHeadlineTypes] := '�� ⨯�';
  FTranslation[trHeadlineUnits] := '�� ���㫨';
  FTranslation[trHeadlineVariables] := '�� ��६����';
  FTranslation[trSummaryCio] := '���᮪ ����ᮢ, ����䥩ᮢ � ��ꥪ⮢';
  FTranslation[trGeneratedBy] := '������஢�� '; // DONE: translate
  FTranslation[trOnDateTime] := '���/�६�'; // DONE: translate
  FTranslation[trDeprecated] := '��� ᨬ��� ����� �� �ᯮ������'; // DONE: translate
  FTranslation[trPlatformSpecific] := '��� ᨬ��� ������ �� �������'; // DONE: translate
  FTranslation[trLibrarySpecific] := '��� ᨬ��� ������ �� ������⥪�'; // DONE: translate
  FTranslation[trIntroduction] := '��������'; // DONE: translate
  FTranslation[trConclusion] := '�����祭��'; // DONE: translate
  FTranslation[trSearch] := '����'; // DONE: translate
  FTranslation[trSeeAlso] := '���ਠ�� �� ⥬�'; // DONE: translate
  FTranslation[trValues] := '���祭��'; // DONE: translate
  FTranslation[trNoCIOs] := '���㫨 �� ᮤ�ঠ� ����ᮢ, ����䥩ᮢ, ��ꥪ⮢ � ����ᥩ.'; // DONE: translate
  FTranslation[trNoCIOsForHierarchy] := '���㫨 �� ᮤ�ঠ� ����ᮢ, ����䥩ᮢ � ��ꥪ⮢.'; // DONE: translate
  FTranslation[trNoTypes] := '���㫨 �� ᮤ�ঠ� ⨯��.'; // DONE: translate
  FTranslation[trNoVariables] := '���㫨 �� ᮤ�ঠ� ��६�����.'; // DONE: translate
  FTranslation[trNoConstants] := '���㫨 �� ᮤ�ঠ� ����⠭�.'; // DONE: translate
  FTranslation[trNoFunctions] := '���㫨 �� ᮤ�ঠ� �㭪樨 � ��楤���.'; // DONE: translate
  FTranslation[trNoIdentifiers] := '���㫨 �� ᮤ�ঠ� �� ������ �����䨪���.'; // DONE: translate
  FTranslation[trProgram] := '�ணࠬ��'; // DONE: translate
  FTranslation[trUses] := 'L���������v� ������';
end;

{ ---------------------------------------------------------------------------- }

procedure TPasDocLanguages.SetLanguageRussian_koi8;
begin
  FTranslation[trAuthor] := '�����';
  FTranslation[trAuthors] := '������';
  FTranslation[trCio] := '������, ���������� � �������';
  FTranslation[trClass] := '�����';
  FTranslation[trClasses] := '������';
  FTranslation[trClassHierarchy] := '�������� �������';
  FTranslation[trConstants] := '���������';
  FTranslation[trCreated] := '�������';
  FTranslation[trDeclaration] := '����������';
  FTranslation[trParameters] := '���������'; // DONE: translate
  FTranslation[trReturns] := '������������ ��������'; // DONE: translate
  FTranslation[trExceptions] := '����������'; // DONE: translate
  FTranslation[trExceptionsRaised] := '�������� ����������'; // DONE: translate
  FTranslation[trEnum] := '������������';
  FTranslation[trDescription] := '��������';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := '����';
  FTranslation[trFunctionsAndProcedures] := '��������� � �������';
  FTranslation[trHelp] := 'Help';
    // Untranslated to avoid Russian file name for css
  FTranslation[trHierarchy] := '��������';
  FTranslation[trIdentifiers] := '��������������';
  FTranslation[trInterface] := '���������';
  FTranslation[trLegend] := '�����������';
  FTranslation[trMarker] := '������'; // DONE: translate
  FTranslation[trVisibility] := '���� ���������'; // DONE: translate
  FTranslation[trLastModified] := '��������� ���������';
  FTranslation[trMethods] := '������';
  FTranslation[trName] := '���';
  FTranslation[trNone] := '���';
  FTranslation[trObject] := '������';
  FTranslation[trObjects] := '�������';
  FTranslation[trOverview] := '�����';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trProperties] := '��������';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := '���';
  FTranslation[trTypes] := '����';
  FTranslation[trUnit] := '������';
  FTranslation[trUnits] := '������';
  FTranslation[trVariables] := '����������';
  FTranslation[trGvUses] := '������ ����������� �������'; // DONE: translate
  FTranslation[trGvClasses] := '������ �������� �������'; // DONE: translate
  FTranslation[trWarningOverwrite] :=
    '��������������: �� ������������� - ���� ���� ������ ������������� � ����� ���� ����Σ� ��� ��������������';
  FTranslation[trWarning] := '��������������';  // DONE: translate
  FTranslation[trHeadlineCio] := '��� ������, ���������� � �������';
  FTranslation[trHeadlineConstants] := '��� ���������';
  FTranslation[trHeadlineFunctionsAndProcedures] := '��� ��������� � �������';
  FTranslation[trHeadlineIdentifiers] := '��� ��������������';
  FTranslation[trHeadlineTypes] := '��� ����';
  FTranslation[trHeadlineUnits] := '��� ������';
  FTranslation[trHeadlineVariables] := '��� ����������';
  FTranslation[trSummaryCio] := '������ �������, ����������� � ��������';
  FTranslation[trGeneratedBy] := '������������ '; // DONE: translate
  FTranslation[trOnDateTime] := '����/�����'; // DONE: translate
  FTranslation[trDeprecated] := '���� ������ ������ �� ������������'; // DONE: translate
  FTranslation[trPlatformSpecific] := '���� ������ ������� �� ���������'; // DONE: translate
  FTranslation[trLibrarySpecific] := '���� ������ ������� �� ����������'; // DONE: translate
  FTranslation[trIntroduction] := '��������'; // DONE: translate
  FTranslation[trConclusion] := '����������'; // DONE: translate
  FTranslation[trSearch] := '�����'; // DONE: translate
  FTranslation[trSeeAlso] := '��������� �� ����'; // DONE: translate
  FTranslation[trValues] := '��������'; // DONE: translate
  FTranslation[trNoCIOs] := '������ �� �������� �������, �����������, �������� � �������.'; // DONE: translate
  FTranslation[trNoCIOsForHierarchy] := '������ �� �������� �������, ����������� � ��������.'; // DONE: translate
  FTranslation[trNoTypes] := '������ �� �������� �����.'; // DONE: translate
  FTranslation[trNoVariables] := '������ �� �������� ����������.'; // DONE: translate
  FTranslation[trNoConstants] := '������ �� �������� ��������.'; // DONE: translate
  FTranslation[trNoFunctions] := '������ �� �������� ������� � ���������.'; // DONE: translate
  FTranslation[trNoIdentifiers] := '������ �� �������� �� ������ ��������������.'; // DONE: translate
  FTranslation[trProgram] := '���������'; // DONE: translate
  FTranslation[trUses] := '������������ ������';
end;

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageSlovak;
begin
  FTranslation[trAuthor] := 'Autor';
  FTranslation[trAuthors] := 'Autori';
  FTranslation[trCio] := 'Triedy, interfejsy a objekty';
  FTranslation[trClass] := 'Trieda';
  FTranslation[trClasses] := 'Triedy';
  FTranslation[trConstants] := 'Kon�tanty';
  FTranslation[trCreated] := 'Vytvoren�';
  FTranslation[trDeclaration] := 'Deklar�cie';
  FTranslation[trDescription] := 'Popis';
  FTranslation[trParameters] := 'Parameters';
  FTranslation[trReturns] := 'Returns';
  FTranslation[trExceptions] := 'Exceptions'; // TODO: translate
  FTranslation[trExceptionsRaised] := 'Exceptions raised'; // TODO: translate
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trFields] := 'Polo�ky';
  FTranslation[trFunctionsAndProcedures] := 'Funkcie a proced�ry';
  FTranslation[trHierarchy] := 'Hierarchia';
  FTranslation[trIdentifiers] := 'Identifik�tory';
  FTranslation[trInterface] := 'Interfejs';
  FTranslation[trLastModified] := 'Posledn� zmena';
  FTranslation[trMethods] := 'Met�dy';
  FTranslation[trName] := 'Meno';
  FTranslation[trNone] := 'Ni�';
  FTranslation[trObject] := 'Objekt';
  FTranslation[trObjects] := 'Objekty';
  FTranslation[trOverview] := 'Overview';
  FTranslation[trProperties] := 'Mo�nosti';
  FTranslation[trType] := 'Typ';
  FTranslation[trTypes] := 'Typy';
  FTranslation[trUnit] := 'Jednotka';
  FTranslation[trUnits] := 'Jednotky';
  FTranslation[trVariables] := 'Premenn�';
  FTranslation[trGvUses] := 'Unit dependency graph'; // TODO: translate
  FTranslation[trGvClasses] := 'Classes hierarchy graph'; // TODO: translate
  FTranslation[trWarningOverwrite] :=
    'Upozornenie: Needitujte - tento s�bor bol vytvoren� automaticky a je pravdepodobn�, �e bude prep�san�';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trHeadlineCio] := 'V�etky triedy, interfejsy a objekty';
  FTranslation[trHeadlineConstants] := 'V�etky kon�tanty';
  FTranslation[trHeadlineFunctionsAndProcedures] :=
    'V�etky funkcie a proced�ry';
  FTranslation[trHeadlineIdentifiers] := 'V�etky identifik�tory';
  FTranslation[trHeadlineTypes] := 'V�etky typy';
  FTranslation[trHeadlineUnits] := 'V�etky jednotky';
  FTranslation[trHeadlineVariables] := 'V�etky premenn�';
  FTranslation[trSummaryCio] := 'Zoznam tried, interfejsov a objektov';
  FTranslation[trGeneratedBy] := 'Generated by'; // TODO: translate
  FTranslation[trOnDateTime] := 'on'; // TODO: translate
  FTranslation[trDeprecated] := 'this symbol is deprecated';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library';
  FTranslation[trIntroduction] := 'Introduction'; // TODO: translate
  FTranslation[trConclusion] := 'Conclusion'; // TODO: translate
  FTranslation[trSearch] := 'Search'; // TODO: translate
  FTranslation[trSeeAlso] := 'See also'; // TODO: translate
  FTranslation[trValues] := 'Values'; // TODO: translate
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.'; // TODO: translate
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.'; // TODO: translate
  FTranslation[trNoTypes] := 'The units do not contain any types.'; // TODO: translate
  FTranslation[trNoVariables] := 'The units do not contain any variables.'; // TODO: translate
  FTranslation[trNoConstants] := 'The units do not contain any constants.'; // TODO: translate
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.'; // TODO: translate
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.'; // TODO: translate
  FTranslation[trProgram] := 'Program'; // TODO: translate
end;
{$ELSE}
const
  aSlovak: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Slovak',
  //map
    {trUnits} 'Jednotky',
    {trClassHierarchy} strToDo, //'Class Hierarchy',
    {trCio} 'Triedy, interfejsy a objekty',
    {trIdentifiers} 'Identifik�tory',
    {trGvUses} strToDo, //'Unit dependency graph',
    {trGvClasses} strToDo, //'Classes hierarchy graph',
  //tables and members
    {trClasses} 'Triedy',
      {trClass} 'Trieda',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} 'Interfejs',
    {trObjects} 'Objekty',
      {trObject} 'Objekt',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Hierarchia',
        {trFields} 'Polo�ky',
        {trMethods} 'Met�dy',
        {trProperties} 'Mo�nosti',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} 'Jednotka',
      {trUses} strToDo, //'Uses',
      {trConstants} 'Kon�tanty',
      {trFunctionsAndProcedures} 'Funkcie a proced�ry',
      {trTypes} 'Typy',
        {trType} 'Typ',
      {trVariables} 'Premenn�',
      {trAuthors} 'Autori',
        {trAuthor} 'Autor',
      {trCreated} 'Vytvoren�',
      {trLastModified} 'Posledn� zmena',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} 'Parameters',
      {trReturns} strToDo, //'Returns',
      {trExceptionsRaised} strToDo, //'Exceptions raised',
    {trExceptions} strToDo, //'Exceptions',
      {trException} strToDo, //'Exception',
    {trEnum} strToDo, //'Enumeration',
  //visibilities
    {trVisibility} strToDo, //'Visibility',
      {trPrivate} strToDo, //'Private',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} strToDo, //'Protected',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} strToDo, //'Public',
      {trPublished} strToDo, //'Published',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} strToDo, //'this symbol is deprecated',
    {trPlatformSpecific} strToDo, //'this symbol is specific to some platform',
    {trLibrarySpecific} strToDo, //'this symbol is specific to some library',
  //headings
    {trOverview} strToDo, //'Overview',
    {trIntroduction} strToDo, //'Introduction',
    {trConclusion} strToDo, //'Conclusion',
    {trHeadlineCio} 'V�etky triedy, interfejsy a objekty',
    {trHeadlineConstants} 'V�etky kon�tanty',
    {trHeadlineFunctionsAndProcedures} 'V�etky funkcie a proced�ry',
    {trHeadlineIdentifiers} 'V�etky identifik�tory',
    {trHeadlineTypes} 'V�etky typy',
    {trHeadlineUnits} 'V�etky jednotky',
    {trHeadlineVariables} 'V�etky premenn�',
    {trSummaryCio} 'Zoznam tried, interfejsov a objektov',
  //column headings
    {trDeclaration} 'Deklar�cie',
    {trDescription} 'Popis',
    {trName} 'Meno',
    {trValues} strToDo, //'Values',
  //empty
    {trNone} 'Ni�',
    {trNoCIOs} strToDo, //'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} strToDo, //'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} strToDo, //'The units do not contain any types.',
    {trNoVariables} strToDo, //'The units do not contain any variables.',
    {trNoConstants} strToDo, //'The units do not contain any constants.',
    {trNoFunctions} strToDo, //'The units do not contain any functions or procedures.',
    {trNoIdentifiers} strToDo, //'The units do not contain any identifiers.',
  //misc
    {trHelp} strToDo, //'Help',
    {trLegend} strToDo, //'Legend',
    {trMarker} strToDo, //'Marker',
    {trWarningOverwrite} 'Upozornenie: Needitujte - tento s�bor bol vytvoren� automaticky a je pravdepodobn�, �e bude prep�san�',
    {trWarning} 'Upozornenie',
    {trGeneratedBy} strToDo, //'Generated by',
    {trOnDateTime} strToDo, //'on',
    {trSearch} strToDo, //'Search',
    {trSeeAlso} strToDo, //'See also',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageSpanish;
begin
  FTranslation[trAuthor] := 'Autor';
  FTranslation[trAuthors] := 'Autores';
  FTranslation[trAutomated] := 'Automated';
  FTranslation[trCio] := 'Clases, interfaces y objetos';
  FTranslation[trClass] := 'Clase';
  FTranslation[trClasses] := 'Clases';
  FTranslation[trClassHierarchy] := 'Jerarqu�a de clases';
  FTranslation[trConstants] := 'Constantes';
  FTranslation[trCreated] := 'Creado';
  FTranslation[trDeclaration] := 'Declaraci�n';
  FTranslation[trDescription] := 'Descripci�n';
  FTranslation[trParameters] := 'Par�metros';
  FTranslation[trReturns] := 'Retornos';
  FTranslation[trExceptions] := 'Excepciones';
  FTranslation[trExceptionsRaised] := 'Excepciones lanzadas';
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Campos';
  FTranslation[trFunctionsAndProcedures] := 'Funciones y procedimientos';
  FTranslation[trHelp] := 'Ayuda';
  FTranslation[trHierarchy] := 'Jerarqu�a';
  FTranslation[trIdentifiers] := 'Identificadores';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'Leyenda';
  FTranslation[trMarker] := 'Marcador';
  FTranslation[trVisibility] := 'Visibilidad';
  FTranslation[trMethods] := 'M�todos';
  FTranslation[trLastModified] := '�ltima modificaci�n';
  FTranslation[trName] := 'Nombre';
  FTranslation[trNone] := 'Ninguno';
  FTranslation[trObject] := 'Objeto';
  FTranslation[trObjects] := 'Objetos';
  FTranslation[trOverview] := 'Resumen';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trProperties] := 'Propiedades';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Tipo';
  FTranslation[trTypes] := 'Tipos';
  FTranslation[trUnit] := 'Unidad';
  FTranslation[trUnits] := 'Unidades';
  FTranslation[trVariables] := 'Variables';
  FTranslation[trGvUses] := 'Gr�fico de las dependencias de unidades';
  FTranslation[trGvClasses] := 'Gr�fico de la jerarqu�a de clases';
  FTranslation[trHeadlineCio] := 'Todas las clases, interfaces y objetos';
  FTranslation[trHeadlineConstants] := 'Todas las constantes';
  FTranslation[trHeadlineFunctionsAndProcedures] :=    'Todos las funciones y procedimientos';
  FTranslation[trHeadlineIdentifiers] := 'Todos los indentificadores';
  FTranslation[trHeadlineTypes] := 'Todos los tipos';
  FTranslation[trHeadlineUnits] := 'Todas las unidades';
  FTranslation[trHeadlineVariables] := 'Todas las variables';
  FTranslation[trSummaryCio] := 'Lista de clases, interfaces y objetos';
  FTranslation[trWarningOverwrite] :=  'Atenci�n, no editar - este fichero ha sido creado automaticamente y puede ser sobrescrito';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trGeneratedBy] := 'Generador por';
  FTranslation[trOnDateTime] := 'a';
  FTranslation[trDeprecated] := 'Este s�mbolo est� obsoleto';
  FTranslation[trPlatformSpecific] := 'Este s�mbolo es espec�fico para alguna plataforma';
  FTranslation[trLibrarySpecific] := 'Este s�mbolo es espec�fico para alguna librer�a';
  FTranslation[trIntroduction] := 'Introducci�n';
  FTranslation[trConclusion] := 'Conclusi�n';
  FTranslation[trSearch] := 'Buscar';
  FTranslation[trSeeAlso] := 'Ver';
  FTranslation[trValues] := 'Valores';
  FTranslation[trNoCIOs] := 'Las unidades no contienen ni clases ni interfaces ni objetos ni registros.';
  FTranslation[trNoCIOsForHierarchy] := 'Las unidades no contienen ni clases ni interfaces ni objetos.';
  FTranslation[trNoTypes] := 'Las unidades no contienen ning�n tipo.';
  FTranslation[trNoVariables] := 'Las unidades no contienen ningunas variables.';
  FTranslation[trNoConstants] := 'Las unidades no contienen ningunas constantes.';
  FTranslation[trNoFunctions] := 'Las unidades no contienen ni variables ni procedimientos.';
  FTranslation[trNoIdentifiers] := 'Las unidades no contienen ning�n Identificador.';
  FTranslation[trProgram] := 'Program'; // TODO: translate
end;
{$ELSE}
const
  aSpanish: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Spanish',
  //map
    {trUnits} 'Unidades',
    {trClassHierarchy} 'Jerarqu�a de clases',
    {trCio} 'Clases, interfaces y objetos',
    {trIdentifiers} 'Identificadores',
    {trGvUses} 'Gr�fico de las dependencias de unidades',
    {trGvClasses} 'Gr�fico de la jerarqu�a de clases',
  //tables and members
    {trClasses} 'Clases',
      {trClass} 'Clase',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} strToDo, //'Interface',
    {trObjects} 'Objetos',
      {trObject} 'Objeto',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Jerarqu�a',
        {trFields} 'Campos',
        {trMethods} 'M�todos',
        {trProperties} 'Propiedades',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} 'Unidad',
      {trUses} strToDo, //'Uses',
      {trConstants} 'Constantes',
      {trFunctionsAndProcedures} 'Funciones y procedimientos',
      {trTypes} 'Tipos',
        {trType} 'Tipo',
      {trVariables} strKeep, //'Variables', //???
      {trAuthors} 'Autores',
        {trAuthor} 'Autor',
      {trCreated} 'Creado',
      {trLastModified} '�ltima modificaci�n',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} 'Par�metros',
      {trReturns} 'Retorno', //strToDo??? solo uno!
      {trExceptionsRaised} 'Excepciones lanzadas',
    {trExceptions} 'Excepciones',
      {trException} 'Excepcion', //?
    {trEnum} strKeep, //'Enumeration',
  //visibilities
    {trVisibility} 'Visibilidad',
      {trPrivate} strToDo, //'Private',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} strToDo, //'Protected',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} strToDo, //'Public',
      {trPublished} strToDo, //'Published',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} 'Este s�mbolo est� obsoleto',
    {trPlatformSpecific} 'Este s�mbolo es espec�fico para alguna plataforma',
    {trLibrarySpecific} 'Este s�mbolo es espec�fico para alguna librer�a',
  //headings
    {trOverview} 'Resumen',
    {trIntroduction} 'Introducci�n',
    {trConclusion} 'Conclusi�n',
    {trHeadlineCio} 'Todas las clases, interfaces y objetos',
    {trHeadlineConstants} 'Todas las constantes',
    {trHeadlineFunctionsAndProcedures} 'Todos las funciones y procedimientos',
    {trHeadlineIdentifiers} 'Todos los indentificadores',
    {trHeadlineTypes} 'Todos los tipos',
    {trHeadlineUnits} 'Todas las unidades',
    {trHeadlineVariables} 'Todas las variables',
    {trSummaryCio} 'Lista de clases, interfaces y objetos',
  //column headings
    {trDeclaration} 'Declaraci�n',
    {trDescription} 'Descripci�n',
    {trName} 'Nombre',
    {trValues} 'Valores',
  //empty
    {trNone} 'Ninguno',
    {trNoCIOs} 'Las unidades no contienen ni clases ni interfaces ni objetos ni registros.',
    {trNoCIOsForHierarchy} 'Las unidades no contienen ni clases ni interfaces ni objetos.',
    {trNoTypes} 'Las unidades no contienen ning�n tipo.',
    {trNoVariables} 'Las unidades no contienen ningunas variables.',
    {trNoConstants} 'Las unidades no contienen ningunas constantes.',
    {trNoFunctions} 'Las unidades no contienen ni funciones ni procedimientos',
      //??? strToDo, //'Las unidades no contienen ni variables ni procedimientos',
    {trNoIdentifiers} 'Las unidades no contienen ning�n Identificador.',
  //misc
    {trHelp} 'Ayuda',
    {trLegend} 'Leyenda',
    {trMarker} 'Marcador',
    {trWarningOverwrite} 'Atenci�n, no editar - este fichero ha sido creado automaticamente y puede ser sobrescrito',
    {trWarning} 'Atenci�n',
    {trGeneratedBy} 'Generado por', //??? strToDo, //'Generador por',
    {trOnDateTime} 'a',
    {trSearch} 'Buscar',
    {trSeeAlso} 'Ver',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageSwedish;
begin
  FTranslation[trAuthor] := 'F�rfattare';
  FTranslation[trAuthors] := 'F�rfattare';
  FTranslation[trCio] := 'Klasser, interface och objekt';
  FTranslation[trClass] := 'Klass';
  FTranslation[trClasses] := 'Klasser';
  FTranslation[trConstants] := 'Constants';
  FTranslation[trCreated] := 'Skapad';
  FTranslation[trDeclaration] := 'Deklarationer';
  FTranslation[trDescription] := 'Beskrivning';
  FTranslation[trParameters] := 'Se parameter';
  FTranslation[trReturns] := 'Retur';
  FTranslation[trExceptions] := 'Exceptions'; // TODO: translate
  FTranslation[trExceptionsRaised] := 'Exceptions raised'; // TODO: translate
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'F�lt';
  FTranslation[trFunctionsAndProcedures] := 'Functions and Procedures';
  FTranslation[trHelp] := 'Help';
    // Untranslated to avoid Swedish file name for css
  FTranslation[trHierarchy] := 'Hierarki';
  FTranslation[trIdentifiers] := 'Identifiers';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'F�rklaring';
  FTranslation[trMarker] := 'Marker'; // TODO: translate
  FTranslation[trVisibility] := 'Visibility'; // TODO: translate
  FTranslation[trMethods] := 'Metoder';
  FTranslation[trLastModified] := 'Senast �ndrad';
  FTranslation[trName] := 'Namn';
  FTranslation[trNone] := 'Ingen/inget.';
  FTranslation[trObject] := 'Objekt';
  FTranslation[trObjects] := 'Objekt';
  FTranslation[trOverview] := '�versikt';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trProperties] := 'Properties';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Typer';
  FTranslation[trTypes] := 'Typer';
  FTranslation[trUnit] := 'Enhet';
  FTranslation[trUnits] := 'Enheter';
  FTranslation[trVariables] := 'Variabler';
  FTranslation[trGvUses] := 'Unit dependency graph'; // TODO: translate
  FTranslation[trGvClasses] := 'Classes hierarchy graph'; // TODO: translate
  FTranslation[trHeadlineCio] := 'Alla klasser, interface och objekt';
  FTranslation[trHeadlineConstants] := 'All Constants';
  FTranslation[trHeadlineFunctionsAndProcedures] :=
    'Alla funktioner och procedurer';
  FTranslation[trHeadlineIdentifiers] := 'Alla identifierare';
  FTranslation[trHeadlineTypes] := 'Alla typer';
  FTranslation[trHeadlineUnits] := 'Alla enheter';
  FTranslation[trHeadlineVariables] := 'Alla variabler';
  FTranslation[trSummaryCio] :=
    'Sammanfattning av Klasser, Interface, Objekt';
  FTranslation[trWarningOverwrite] :=
    'Varning: �ndra inte denna fil manuellt - filen har skapats automatiskt och kommer troligen att skrivas �ver vid ett senare tilf�lle';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trGeneratedBy] := 'Generated by'; // TODO: translate
  FTranslation[trOnDateTime] := 'on'; // TODO: translate
  FTranslation[trDeprecated] := 'this symbol is deprecated'; // TODO: translate
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform'; // TODO: translate
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library'; // TODO: translate
  FTranslation[trIntroduction] := 'Introduction'; // TODO: translate
  FTranslation[trConclusion] := 'Conclusion'; // TODO: translate
  FTranslation[trSearch] := 'Search'; // TODO: translate
  FTranslation[trSeeAlso] := 'See also'; // TODO: translate
  FTranslation[trValues] := 'Values'; // TODO: translate
  FTranslation[trNoCIOs] := 'The units do not contain any classes, interfaces, objects or records.'; // TODO: translate
  FTranslation[trNoCIOsForHierarchy] := 'The units do not contain any classes, interfaces or objects.'; // TODO: translate
  FTranslation[trNoTypes] := 'The units do not contain any types.'; // TODO: translate
  FTranslation[trNoVariables] := 'The units do not contain any variables.'; // TODO: translate
  FTranslation[trNoConstants] := 'The units do not contain any constants.'; // TODO: translate
  FTranslation[trNoFunctions] := 'The units do not contain any functions or procedures.'; // TODO: translate
  FTranslation[trNoIdentifiers] := 'The units do not contain any identifiers.'; // TODO: translate
  FTranslation[trProgram] := 'Program'; // TODO: translate
end;
{$ELSE}
const
  aSwedish: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Swedish',
  //map
    {trUnits} 'Enheter',
    {trClassHierarchy} strToDo, //'Class Hierarchy',
    {trCio} 'Klasser, interface och objekt',
    {trIdentifiers} strToDo, //'Identifiers',
    {trGvUses} strToDo, //'Unit dependency graph',
    {trGvClasses} strToDo, //'Classes hierarchy graph',
  //tables and members
    {trClasses} 'Klasser',
      {trClass} 'Klass',
      {trDispInterface} strToDo, //'DispInterface',
      {trInterface} strToDo, //'Interface',
    {trObjects} 'Objekt', //-er ???
      {trObject} 'Objekt',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Hierarki',
        {trFields} 'F�lt', //-er ???
        {trMethods} 'Metoder',
        {trProperties} strToDo, //'Properties',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} 'Enhet',
      {trUses} strToDo, //'Uses',
      {trConstants} strToDo, //'Constants',
      {trFunctionsAndProcedures} strToDo, //'Functions and Procedures',
      {trTypes} 'Typer',
        {trType} 'Typer',
      {trVariables} 'Variabler',
      {trAuthors} 'F�rfattare',
        {trAuthor} 'F�rfattare',
      {trCreated} 'Skapad',
      {trLastModified} 'Senast �ndrad',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} 'Se parameter',
      {trReturns} 'Retur',
      {trExceptionsRaised} strToDo, //'Exceptions raised',
    {trExceptions} strToDo, //'Exceptions',
      {trException} strToDo, //'Exception',
    {trEnum} strToDo, //'Enumeration',
  //visibilities
    {trVisibility} strToDo, //'Visibility',
      {trPrivate} strToDo, //'Private',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} strToDo, //'Protected',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} strToDo, //'Public',
      {trPublished} strToDo, //'Published',
      {trAutomated} strToDo, //'Automated',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} strToDo, //'this symbol is deprecated',
    {trPlatformSpecific} strToDo, //'this symbol is specific to some platform',
    {trLibrarySpecific} strToDo, //'this symbol is specific to some library',
  //headings
    {trOverview} '�versikt',
    {trIntroduction} strToDo, //'Introduction',
    {trConclusion} strToDo, //'Conclusion',
    {trHeadlineCio} 'Alla klasser, interface och objekt',
    {trHeadlineConstants} strToDo, //'All Constants',
    {trHeadlineFunctionsAndProcedures} 'Alla funktioner och procedurer',
    {trHeadlineIdentifiers} 'Alla identifierare',
    {trHeadlineTypes} 'Alla typer',
    {trHeadlineUnits} 'Alla enheter',
    {trHeadlineVariables} 'Alla variabler',
    {trSummaryCio} 'Sammanfattning av Klasser, Interface, Objekt',
  //column headings
    {trDeclaration} 'Deklarationer',
    {trDescription} 'Beskrivning',
    {trName} 'Namn',
    {trValues} strToDo, //'Values',
  //empty
    {trNone} 'Ingen/inget.', //???
    {trNoCIOs} strToDo, //'The units do not contain any classes, interfaces, objects or records.',
    {trNoCIOsForHierarchy} strToDo, //'The units do not contain any classes, interfaces or objects.',
    {trNoTypes} strToDo, //'The units do not contain any types.',
    {trNoVariables} strToDo, //'The units do not contain any variables.',
    {trNoConstants} strToDo, //'The units do not contain any constants.',
    {trNoFunctions} strToDo, //'The units do not contain any functions or procedures.',
    {trNoIdentifiers} strToDo, //'The units do not contain any identifiers.',
  //misc
    {trHelp} strToDo, //'Help', // Untranslated to avoid Swedish file name for css
    {trLegend} 'F�rklaring',
    {trMarker} strToDo, //'Marker',
    {trWarningOverwrite} 'Varning: �ndra inte denna fil manuellt - filen har skapats automatiskt och kommer troligen att skrivas �ver vid ett senare tilf�lle',
    {trWarning} 'Varning',
    {trGeneratedBy} strToDo, //'Generated by',
    {trOnDateTime} strToDo, //'on',
    {trSearch} strToDo, //'Search',
    {trSeeAlso} strToDo, //'See also',
    ''  //dummy
  );
{$ENDIF}

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TPasDocLanguages.SetLanguageHungarian_1250;
begin
  FTranslation[trAuthor] := 'Szerz�';
  FTranslation[trAuthors] := 'Szerz�k';
  FTranslation[trAutomated] := 'Automatikus';
  FTranslation[trCio] := 'Oszt�lyok, Kapcsol�d�si fel�letek �s Objektumok';
  FTranslation[trClass] := 'Oszt�ly';
  FTranslation[trClasses] := 'Oszt�lyok';
  FTranslation[trClassHierarchy] := 'Oszt�ly hierarchia';
  FTranslation[trConstants] := 'Konstansok';
  FTranslation[trCreated] := 'K�sz�lt';
  FTranslation[trDeclaration] := 'Deklar�ci�';
  FTranslation[trDescription] := 'Megjegyz�s';
  FTranslation[trParameters] := 'Param�terek';
  FTranslation[trReturns] := 'Visszat�r�si �rt�kek';
  FTranslation[trExceptions] := 'Kiv�telek';
  FTranslation[trExceptionsRaised] := 'Kiv�telek kiemel�se';
  FTranslation[trEnum] := 'Felsorol�sok';
  FTranslation[trDispInterface] := 'K�perny� fel�letek';
  FTranslation[trFields] := 'Mez�k';
  FTranslation[trFunctionsAndProcedures] := 'F�ggv�nyek �s Elj�r�sok';
  FTranslation[trHelp] := 'S�g�';
  FTranslation[trHierarchy] := 'Hierarchia';
  FTranslation[trIdentifiers] := 'Azonos�t�k';
  FTranslation[trInterface] := 'Kapcsol�d�si fel�let';
  FTranslation[trLegend] := 'T�rt�net';
  FTranslation[trMarker] := 'Jelz�';
  FTranslation[trVisibility] := 'L�that�s�g';
  FTranslation[trMethods] := 'Met�dusok';
  FTranslation[trLastModified] := 'Utols� m�dos�t�s';
  FTranslation[trName] := 'N�v';
  FTranslation[trNone] := 'Nincs';
  FTranslation[trObject] := 'Objektum';
  FTranslation[trObjects] := 'Objektumok';
  FTranslation[trOverview] := '�ttekint�s';
  FTranslation[trPrivate] := 'Priv�t';
  FTranslation[trProperties] := 'Tulajdons�gok';
  FTranslation[trProtected] := 'V�dett';
  FTranslation[trPublic] := 'Publikus';
  FTranslation[trImplicit] := 'Implicit';
  FTranslation[trPublished] := 'Publik�lt';
  FTranslation[trType] := 'T�pus';
  FTranslation[trTypes] := 'T�pusok';
  FTranslation[trUnit] := 'Egys�g';
  FTranslation[trUnits] := 'Egys�gek';
  FTranslation[trVariables] := 'V�ltoz�k';
  FTranslation[trGvUses] := 'Egys�g f�gg�s�gi gr�f';
  FTranslation[trGvClasses] := 'Oszt�ly hierarchia gr�f';
  FTranslation[trHeadlineCio] := '�sszes Oszt�ly, Kapcsol�d�si fel�let �s Objektumok';
  FTranslation[trHeadlineConstants] := '�sszes Kontans';
  FTranslation[trHeadlineFunctionsAndProcedures] := '�sszes F�ggv�ny �s Elj�r�s';
  FTranslation[trHeadlineIdentifiers] := '�sszes Azonos�t�';
  FTranslation[trHeadlineTypes] := '�sszes T�pus';
  FTranslation[trHeadlineUnits] := '�sszes Egys�g';
  FTranslation[trHeadlineVariables] := '�sszes V�ltoz�';
  FTranslation[trSummaryCio] := '�szefoglal� az Oszt�lyokr�l, Kapcsold�si fel�letekr�l �s Objektumokr�l';
  FTranslation[trWarningOverwrite] := 'Vigy�zat: Nem szerkesztend� file - ez a file automatikusan k�sz�lt, val�sz�n�leg fel�l�r�sra ker�lne';
  FTranslation[trWarning] := 'Warning';  // TODO: translate
  FTranslation[trGeneratedBy] := 'K�sz�tette';
  FTranslation[trOnDateTime] := ''; //none in Hungarian language
  FTranslation[trDeprecated] := 'ez az azonos�t� �rt�k n�lk�li';
  FTranslation[trPlatformSpecific] := 'ez az azonos�t� sz�ks�ges n�mely platform sz�m�ra';
  FTranslation[trLibrarySpecific] := 'ez az azonos�t� sz�ks�ges n�mely library sz�m�ra';
  FTranslation[trIntroduction] := 'Bevezet�';
  FTranslation[trConclusion] := '�sszefoglal�';
  FTranslation[trSearch] := 'Keres�s';
  FTranslation[trSeeAlso] := 'L�sd m�g';
  FTranslation[trValues] := '�rt�kek';
  FTranslation[trNoCIOs] := 'Az egys�g nem tartalmaz oszt�lyt, interf�szt, objektumot, vagy rekordot.';
  FTranslation[trNoCIOsForHierarchy] := 'Az egys�g nem tartalmaz oszt�lyt, interf�szt vagy objektumot.';
  FTranslation[trNoTypes] := 'Az egys�g nem tartalmaz t�pusokat';
  FTranslation[trNoVariables] := 'Az egys�g nem tartalmaz v�ltoz�kat.';
  FTranslation[trNoConstants] := 'Az egys�g nem tartalmaz konstansokat.';
  FTranslation[trNoFunctions] := 'Az egys�g nem tartalmaz f�ggv�nyeket vagy elj�r�sokat.';
  FTranslation[trNoIdentifiers] := 'Az egys�g nem tartalmaz azonos�t�kat.';
  FTranslation[trProgram] := 'Program';
end;
{$ELSE}
const
  aHungarian_1250: RTransTable = (
    {trNoTrans} '<what?>', //no ID assigned, so far
    {trLanguage} 'Hungarian',
  //map
    {trUnits} 'Egys�gek',
    {trClassHierarchy} 'Oszt�ly hierarchia',
    {trCio} 'Oszt�lyok, Kapcsol�d�si fel�letek �s Objektumok',
    {trIdentifiers} 'Azonos�t�k',
    {trGvUses} 'Egys�g f�gg�s�gi gr�f',
    {trGvClasses} 'Oszt�ly hierarchia gr�f',
  //tables and members
    {trClasses} 'Oszt�lyok',
      {trClass} 'Oszt�ly',
      {trDispInterface} 'K�perny� fel�letek',
      {trInterface} 'Kapcsol�d�si fel�let',
    {trObjects} 'Objektumok',
      {trObject} 'Objektum',
      {trRecord} strToDo, //'Record',
        {trHierarchy} 'Hierarchia',
        {trFields} 'Mez�k',
        {trMethods} 'Met�dusok',
        {trProperties} 'Tulajdons�gok',
    {trLibrary} strToDo,  //'Library',
    {trPackage} strToDo,  //'Package',
    {trProgram} strToDo,  //'Program',
    {trUnit} 'Egys�g',
      {trUses} strToDo, //'Uses',
      {trConstants} 'Konstansok',
      {trFunctionsAndProcedures} 'F�ggv�nyek �s Elj�r�sok',
      {trTypes} 'T�pusok',
        {trType} 'T�pus',
      {trVariables} 'V�ltoz�k',
      {trAuthors} 'Szerz�k',
        {trAuthor} 'Szerz�',
      {trCreated} 'K�sz�lt',
      {trLastModified} 'Utols� m�dos�t�s',
    {trSubroutine} strToDo, //'Subroutine',
      {trParameters} 'Param�terek',
      {trReturns} 'Visszat�r�si �rt�kek',
      {trExceptionsRaised} 'Kiv�telek kiemel�se',
    {trExceptions} 'Kiv�telek',
      {trException} strToDo, //'Exception',
    {trEnum} 'Felsorol�sok',
  //visibilities
    {trVisibility} 'L�that�s�g',
      {trPrivate} 'Priv�t',
      {trStrictPrivate} strToDo, //'Strict Private',
      {trProtected} 'V�dett',
      {trStrictProtected} strToDo, //'Strict Protected',
      {trPublic} 'Publikus',
      {trPublished} 'Publik�lt',
      {trAutomated} 'Automatikus',
      {trImplicit} strToDo, //'Implicit',
  //hints
    {trDeprecated} 'ez az azonos�t� �rt�k n�lk�li',
    {trPlatformSpecific} 'ez az azonos�t� sz�ks�ges n�mely platform sz�m�ra',
    {trLibrarySpecific} 'ez az azonos�t� sz�ks�ges n�mely library sz�m�ra',
  //headings
    {trOverview} '�ttekint�s',
    {trIntroduction} 'Bevezet�',
    {trConclusion} '�sszefoglal�',
    {trHeadlineCio} '�sszes Oszt�ly, Kapcsol�d�si fel�let �s Objektumok',
    {trHeadlineConstants} '�sszes Kontans',
    {trHeadlineFunctionsAndProcedures} '�sszes F�ggv�ny �s Elj�r�s',
    {trHeadlineIdentifiers} '�sszes Azonos�t�',
    {trHeadlineTypes} '�sszes T�pus',
    {trHeadlineUnits} '�sszes Egys�g',
    {trHeadlineVariables} '�sszes V�ltoz�',
    {trSummaryCio} '�szefoglal� az Oszt�lyokr�l, Kapcsold�si fel�letekr�l �s Objektumokr�l',
  //column headings
    {trDeclaration} 'Deklar�ci�',
    {trDescription} 'Megjegyz�s',
    {trName} 'N�v',
    {trValues} '�rt�kek',
  //empty
    {trNone} 'Nincs',
    {trNoCIOs} 'Az egys�g nem tartalmaz oszt�lyt, interf�szt, objektumot, vagy rekordot.',
    {trNoCIOsForHierarchy} 'Az egys�g nem tartalmaz oszt�lyt, interf�szt vagy objektumot.',
    {trNoTypes} 'Az egys�g nem tartalmaz t�pusokat',
    {trNoVariables} 'Az egys�g nem tartalmaz v�ltoz�kat.',
    {trNoConstants} 'Az egys�g nem tartalmaz konstansokat.',
    {trNoFunctions} 'Az egys�g nem tartalmaz f�ggv�nyeket vagy elj�r�sokat.',
    {trNoIdentifiers} 'Az egys�g nem tartalmaz azonos�t�kat.',
  //misc
    {trHelp} 'S�g�',
    {trLegend} 'T�rt�net',
    {trMarker} 'Jelz�',
    {trWarningOverwrite} 'Vigy�zat: Nem szerkesztend� file - ez a file automatikusan k�sz�lt, val�sz�n�leg fel�l�r�sra ker�lne',
    {trWarning} 'Vigy�zat',
    {trGeneratedBy} 'K�sz�tette',
    {trOnDateTime} ' ', //none in Hungarian language
    {trSearch} 'Keres�s',
    {trSeeAlso} 'L�sd m�g',
    ''  //dummy
  );
{$ENDIF}

const
  LANGUAGE_ARRAY: array[TLanguageID] of TLanguageRecord = (
    (Table: @aBosnian; Name: 'Bosnian (Codepage 1250)'; Syntax: 'ba'; CharSet: 'windows-1250'),
    (Table: @aBrasilian; Name: 'Brasilian'; Syntax: 'br'; CharSet: ''),
    (Table: @aCatalan; Name: 'Catalan'; Syntax: 'ct'; CharSet: ''),
    (Table: @aChinese_950; Name: 'Chinese (Codepage 950)'; Syntax: 'big5'; CharSet: 'big5'),
    (Table: nil;  Name: 'Chinese (Simple, gb2312)'; Syntax: 'gb2312'; CharSet: 'gb2312'),
    (Table: @aDanish; Name: 'Danish'; Syntax: 'dk'; CharSet: 'iso-8859-15'),
    (Table: @aDutch; Name: 'Dutch'; Syntax: 'nl'; CharSet: 'iso-8859-15'),
    (Table: @aEnglish; Name: 'English'; Syntax: 'en'; CharSet: 'iso-8859-1'),
    (Table: @aFrench; Name: 'French'; Syntax: 'fr'; CharSet: 'iso-8859-15'),
    (Table: @aGerman; Name: 'German'; Syntax: 'de'; CharSet: 'iso-8859-15'),
    (Table: @aIndonesian; Name: 'Indonesian'; Syntax: 'id'; CharSet: ''),
    (Table: @aItalian; Name: 'Italian'; Syntax: 'it'; CharSet: 'iso-8859-15'),
    (Table: @aJavanese; Name: 'Javanese'; Syntax: 'jv'; CharSet: ''),
    (Table: @aPolish1250; Name: 'Polish (Codepage CP1250)'; Syntax: 'pl.cp1250'; CharSet: 'windows-1250'),
    (Table: @aPolish_ISO_8859_2; Name: 'Polish (Codepage ISO 8859-2)'; Syntax: 'pl.iso-8859-2'; CharSet: 'iso-8859-2'),
    (Table: @aRussian_1251; Name: 'Russian (Codepage 1251)'; Syntax: 'ru.1251'; CharSet: 'windows-1251'),
    (Table: nil;  Name: 'Russian (Codepage 866)'; Syntax: 'ru.866'; CharSet: 'IBM866'),
    (Table: nil;  Name: 'Russian (KOI-8)'; Syntax: 'ru.KOI8'; CharSet: 'koi8-r'),
    (Table: @aSlovak; Name: 'Slovak'; Syntax: 'sk'; CharSet: ''),
    (Table: @aSpanish; Name: 'Spanish'; Syntax: 'es'; CharSet: 'iso-8859-15'),
    (Table: @aSwedish; Name: 'Swedish'; Syntax: 'se'; CharSet: 'iso-8859-15'),
    (Table: @aHungarian_1250; Name: 'Hungarian (Codepage 1250)'; Syntax: 'hu.1250'; CharSet: 'windows-1250')
  );

function TPasDocLanguages.GetTranslation(
  ATranslationID: TTranslationID): string;
begin
{$IFDEF old}
  Result := FTranslation[ATranslationID];
{$ELSE}
  Result := pTable^[ATranslationID];
  if Result <= strKeep then
    Result := aEnglish[ATranslationID];
{$ENDIF}
end;

procedure TPasDocLanguages.SetTranslation(id: TTranslationID;
  const into: string);
begin
  pTable^[id] := into;
end;

constructor TPasDocLanguages.Create;
begin
  inherited;
  SetLanguage(DEFAULT_LANGUAGE);
end;

procedure TPasDocLanguages.SetLanguage(const Value: TLanguageID);
begin
  FLanguage := Value;
  FCharSet := LANGUAGE_ARRAY[Value].Charset;
{$IFDEF old}
{$ELSE}
//get table
  pTable := LANGUAGE_ARRAY[Value].Table;
  if assigned(pTable) then
    exit; //array already exists

//use writeable table
  pTable := addr(aNewLanguage);
{$ENDIF}
  case Value of
  {$IFDEF old}
    lgBosnian: SetLanguageBosnian;
    lgBrasilian: SetLanguageBrasilian;
    lgCatalan: SetLanguageCatalan;
    lgChinese_950: SetLanguageChinese_950;
    lgDanish: SetLanguageDanish;
    lgDutch: SetLanguageDutch;
    lgEnglish: SetLanguageEnglish;
    lgFrench: SetLanguageFrench;
    lgGerman: SetLanguageGerman;
    lgIndonesian: SetLanguageIndonesian;
    lgItalian: SetLanguageItalian;
    lgJavanese: SetLanguageJavanese;
    lgPolish_CP1250: SetLanguagePolish_CP1250;
    lgPolish_ISO_8859_2: SetLanguagePolish_ISO_8859_2;
    lgRussian_1251: SetLanguageRussian_1251;
    lgSlovak: SetLanguageSlovak;
    lgSpanish: SetLanguageSpanish;
    lgSwedish: SetLanguageSwedish;
    lgHungarian_1250: SetLanguageHungarian_1250;
  {$ELSE}
  //no array yet
    lgChinese_gb2312: SetLanguageChinese_gb2312;
    lgRussian_866: SetLanguageRussian_866;
    lgRussian_koi8: SetLanguageRussian_koi8;
  {$ENDIF}
  else  //this should never be reached
  {$IFDEF old}
    SetLanguageEnglish;
  {$ELSE}
    pTable := addr(aEnglish);
  {$ENDIF}
  end;
end;

function LanguageFromStr(S: string; out LanguageId: TLanguageID): boolean;
var
  I: TLanguageID;
begin
  S := LowerCase(S);
  for I := Low(LANGUAGE_ARRAY) to High(LANGUAGE_ARRAY) do
  begin
    if LowerCase(LANGUAGE_ARRAY[I].Syntax) = S then
    begin
      Result := true;
      LanguageId := I;
      Exit;
    end;
  end;

  Result := false;
end;

//------------- language helpers, for PasDoc_gui -----------------

function LanguageFromIndex(i: integer): string;
begin
  Result := language_array[TLanguageID(i)].Name;
end;

function SyntaxFromIndex(i: integer): string;
var
  l: TLanguageID absolute i;
begin
  Result := Language_array[l].Syntax;
end;

function IDfromLanguage(const s: string): TLanguageID;
var
  i: TLanguageID;
begin
  for i := low(i) to high(i) do begin
    if (LANGUAGE_ARRAY[i].Name = s)
    or (LANGUAGE_ARRAY[i].Syntax = s) then begin
      Result := i;
      exit;
    end;
  end;
  Result := DEFAULT_LANGUAGE;
end;

function LanguageDescriptor(id: TLanguageID): PLanguageRecord;
begin
  Result := @Language_array[id];
end;

function  Translation(id: TTranslationID; lang: TLanguageID): string;
var
  tbl: PTransTable;
begin
  tbl := LANGUAGE_ARRAY[lang].Table;
  if not assigned(tbl) then
    tbl := @aEnglish;
  Result := tbl^[id];
end;

end.
