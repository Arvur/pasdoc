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
  @author(Liu Da <xmacmail AT gmail.com> (Chinese gb2312 translation))
  @author(DoDi)
  @author(Ren� Mihula <rene.mihula@gmail.com> (Czech translation))
}

unit PasDoc_Languages;

interface

type
  { An enumeration type of all supported languages }
  TLanguageID = (
    lgBosnian,
    lgBrasilian,
    lgCatalan,
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
    lgRussian_utf8,
    lgRussian_866,
    lgRussian_koi8,
    lgSlovak,
    lgSpanish,
    lgSwedish,
    lgHungarian_1250,
    lgCzech_CP1250,
    lgCzech_ISO_8859_2
   );

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
    trDescription, //<as column OR section heading!
    trDescriptions, //<section heading for detailed descriptions
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
  //the table of the selected language
    pTable: PTransTable;
    FCharSet: string;
    { @abstract(gets a translation token) }
    function GetTranslation(ATranslationID: TTranslationID): string;
    procedure SetTranslation(id: TTranslationID; const into: string);
    property FTranslation[id: TTranslationID]: string
      read GetTranslation write SetTranslation;
  //following languages/codepages need transformation into tables
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
function LanguageFromID(i: TLanguageID): string;

//Language abbreviation
function SyntaxFromIndex(i: integer): string;
function SyntaxFromID(i: TLanguageID): string;

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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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
    {trDescriptions} 'Detailed Descriptions',
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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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

{ ---------------------------------------------------------------------------- }

{$I PasDoc_Languages_Chinese_gb2312.inc}

{ ---------------------------------------------------------------------------- }

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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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
    {trDescriptions} 'Ausf�hrliche Beschreibungen',
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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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
      {trDispInterface} 'DispInterface', //'DispInterface',
      {trInterface} 'Interfejs',
    {trObjects} 'Obiekty',
      {trObject} 'Obiekt',
      {trRecord} 'Rekord', //'Record',
        {trHierarchy} 'Hierarchia',
        {trFields} 'Pola',
        {trMethods} 'Metody',
        {trProperties} 'W�a�ciwo�ci',
    {trLibrary} 'Biblioteka',  //'Library',
    {trPackage} 'Pakiet',  //'Package',
    {trProgram} 'Program',  //'Program',
    {trUnit} 'Modu�',
      {trUses} 'U�ywa', //'Uses',
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
      {trException} 'Wyj�tek', //'Exception',
    {trEnum} 'Wyliczenie',
  //visibilities
    {trVisibility} 'Widoczno��',
      {trPrivate} 'Prywatne',
      {trStrictPrivate} '�ci�le prywatne', //'Strict Private',
      {trProtected} 'Chronione',
      {trStrictProtected} '�ci�le chronione', //'Strict Protected',
      {trPublic} 'Publiczne',
      {trPublished} 'Publikowane',
      {trAutomated} 'Automated', //'Automated',
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
    {trDescriptions} 'Szczeg�y', //'Descriptions', 'Detailed Descriptions'?
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
      {trDispInterface} 'DispInterface', //'DispInterface',
      {trInterface} 'Interfejs',
    {trObjects} 'Obiekty',
      {trObject} 'Obiekt',
      {trRecord} 'Rokord', //'Record',
        {trHierarchy} 'Hierarchia',
        {trFields} 'Pola',
        {trMethods} 'Metody',
        {trProperties} 'W�a�ciwo�ci',
    {trLibrary} 'Biblioteka',  //'Library',
    {trPackage} 'Pakiet',  //'Package',
    {trProgram} 'Program',  //'Program',
    {trUnit} 'Modu�',
      {trUses} 'U�ywa', //'Uses',
      {trConstants} 'Sta�e',
      {trFunctionsAndProcedures} 'Podprogramy',
      {trTypes} 'Typy',
        {trType} 'Typ',
      {trVariables} 'Zmienne',
      {trAuthors} 'Autorzy',
        {trAuthor} 'Autor',
      {trCreated} 'Utworzony',
      {trLastModified} 'Ostatnia modyfikacja',
    {trSubroutine} 'Podprogram',
      {trParameters} 'Parametry',
      {trReturns} 'Wynik',
      {trExceptionsRaised} 'Generowane wyj�tki',
    {trExceptions} 'Wyj�tki',
      {trException} 'Wyj�tek',
    {trEnum} 'Wyliczenie',
  //visibilities
    {trVisibility} 'Widoczno��',
      {trPrivate} 'Prywatne',
      {trStrictPrivate} '�ci�le prywatne', //'Strict Private',
      {trProtected} 'Chronione',
      {trStrictProtected} '�ci�le chronione', //'Strict Protected',
      {trPublic} 'Publiczne',
      {trPublished} 'Publikowane',
      {trAutomated} 'Automated', //'Automated',
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
    {trDescriptions} 'Szczeg�y', //'Descriptions', 'Detailed Descriptions'?
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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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

{$I PasDoc_Languages_Russian_utf8.inc}

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
  FTranslation[trParameters] := '��ࠬ����';
  FTranslation[trReturns] := '�����頥�� ���祭��';
  FTranslation[trExceptions] := '�᪫�祭��';
  FTranslation[trExceptionsRaised] := '��뢠�� �᪫�祭��';
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
  FTranslation[trMarker] := '��થ�';
  FTranslation[trVisibility] := '���� ��������';
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
  FTranslation[trGvUses] := '��䨪 ����ᨬ��� ���㫥�';
  FTranslation[trGvClasses] := '��䨪 ����娨 ����ᮢ';
  FTranslation[trWarningOverwrite] :=
    '�।�०�����: �� ।���஢��� - ��� 䠩� ᮧ��� ��⮬���᪨ � ����� ���� ������ ��� �।�०�����';
  FTranslation[trWarning] := '�।�०�����';
  FTranslation[trHeadlineCio] := '�� ������, ����䥩�� � ��ꥪ��';
  FTranslation[trHeadlineConstants] := '�� ����⠭��';
  FTranslation[trHeadlineFunctionsAndProcedures] := '�� ��楤��� � �㭪樨';
  FTranslation[trHeadlineIdentifiers] := '�� �����䨪����';
  FTranslation[trHeadlineTypes] := '�� ⨯�';
  FTranslation[trHeadlineUnits] := '�� ���㫨';
  FTranslation[trHeadlineVariables] := '�� ��६����';
  FTranslation[trSummaryCio] := '���᮪ ����ᮢ, ����䥩ᮢ � ��ꥪ⮢';
  FTranslation[trGeneratedBy] := '������஢�� ';
  FTranslation[trOnDateTime] := '���/�६�';
  FTranslation[trDeprecated] := '��� ᨬ��� ����� �� �ᯮ������';
  FTranslation[trPlatformSpecific] := '��� ᨬ��� ������ �� �������';
  FTranslation[trLibrarySpecific] := '��� ᨬ��� ������ �� ������⥪�';
  FTranslation[trIntroduction] := '��������';
  FTranslation[trConclusion] := '�����祭��';
  FTranslation[trSearch] := '����';
  FTranslation[trSeeAlso] := '���ਠ�� �� ⥬�';
  FTranslation[trValues] := '���祭��';
  FTranslation[trNoCIOs] := '���㫨 �� ᮤ�ঠ� ����ᮢ, ����䥩ᮢ, ��ꥪ⮢ � ����ᥩ.';
  FTranslation[trNoCIOsForHierarchy] := '���㫨 �� ᮤ�ঠ� ����ᮢ, ����䥩ᮢ � ��ꥪ⮢.';
  FTranslation[trNoTypes] := '���㫨 �� ᮤ�ঠ� ⨯��.';
  FTranslation[trNoVariables] := '���㫨 �� ᮤ�ঠ� ��६�����.';
  FTranslation[trNoConstants] := '���㫨 �� ᮤ�ঠ� ����⠭�.';
  FTranslation[trNoFunctions] := '���㫨 �� ᮤ�ঠ� �㭪樨 � ��楤���.';
  FTranslation[trNoIdentifiers] := '���㫨 �� ᮤ�ঠ� �� ������ �����䨪���.';
  FTranslation[trProgram] := '�ணࠬ��';
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
  FTranslation[trParameters] := '���������';
  FTranslation[trReturns] := '������������ ��������';
  FTranslation[trExceptions] := '����������';
  FTranslation[trExceptionsRaised] := '�������� ����������';
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
  FTranslation[trMarker] := '������';
  FTranslation[trVisibility] := '���� ���������';
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
  FTranslation[trGvUses] := '������ ����������� �������';
  FTranslation[trGvClasses] := '������ �������� �������';
  FTranslation[trWarningOverwrite] :=
    '��������������: �� ������������� - ���� ���� ������ ������������� � ����� ���� ����Σ� ��� ��������������';
  FTranslation[trWarning] := '��������������';
  FTranslation[trHeadlineCio] := '��� ������, ���������� � �������';
  FTranslation[trHeadlineConstants] := '��� ���������';
  FTranslation[trHeadlineFunctionsAndProcedures] := '��� ��������� � �������';
  FTranslation[trHeadlineIdentifiers] := '��� ��������������';
  FTranslation[trHeadlineTypes] := '��� ����';
  FTranslation[trHeadlineUnits] := '��� ������';
  FTranslation[trHeadlineVariables] := '��� ����������';
  FTranslation[trSummaryCio] := '������ �������, ����������� � ��������';
  FTranslation[trGeneratedBy] := '������������ ';
  FTranslation[trOnDateTime] := '����/�����';
  FTranslation[trDeprecated] := '���� ������ ������ �� ������������';
  FTranslation[trPlatformSpecific] := '���� ������ ������� �� ���������';
  FTranslation[trLibrarySpecific] := '���� ������ ������� �� ����������';
  FTranslation[trIntroduction] := '��������';
  FTranslation[trConclusion] := '����������';
  FTranslation[trSearch] := '�����';
  FTranslation[trSeeAlso] := '��������� �� ����';
  FTranslation[trValues] := '��������';
  FTranslation[trNoCIOs] := '������ �� �������� �������, �����������, �������� � �������.';
  FTranslation[trNoCIOsForHierarchy] := '������ �� �������� �������, ����������� � ��������.';
  FTranslation[trNoTypes] := '������ �� �������� �����.';
  FTranslation[trNoVariables] := '������ �� �������� ����������.';
  FTranslation[trNoConstants] := '������ �� �������� ��������.';
  FTranslation[trNoFunctions] := '������ �� �������� ������� � ���������.';
  FTranslation[trNoIdentifiers] := '������ �� �������� �� ������ ��������������.';
  FTranslation[trProgram] := '���������'; 
  FTranslation[trUses] := '������������ ������';
end;

{ ---------------------------------------------------------------------------- }

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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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
    {trDescriptions} 'Descripci�nes', //? 'Descriptions', 'Detailed Descriptions'?
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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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
    {trDescriptions} strToDo, //'Descriptions', 'Detailed Descriptions'?
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
  
  aCzech_ISO_8859_2: {$I PasDoc_Languages_Czech_ISO_8859_2.inc}
  aCzech_CP1250: {$I PasDoc_Languages_Czech_CP1250.inc}

const
  LANGUAGE_ARRAY: array[TLanguageID] of TLanguageRecord = (
    (Table: @aBosnian; Name: 'Bosnian (Codepage 1250)'; Syntax: 'ba'; CharSet: 'windows-1250'),
    (Table: @aBrasilian; Name: 'Brasilian'; Syntax: 'br'; CharSet: ''),
    (Table: @aCatalan; Name: 'Catalan'; Syntax: 'ct'; CharSet: ''),
    (Table: @aChinese_gb2312; Name: 'Chinese (Simple, gb2312)'; Syntax: 'gb2312'; CharSet: 'gb2312'),
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
    (Table: @aRussian_utf8; Name: 'Russian (Codepage utf8)'; Syntax: 'ru.utf8'; CharSet: 'utf-8'),
    (Table: nil;  Name: 'Russian (Codepage 866)'; Syntax: 'ru.866'; CharSet: 'IBM866'),
    (Table: nil;  Name: 'Russian (KOI-8)'; Syntax: 'ru.KOI8'; CharSet: 'koi8-r'),
    (Table: @aSlovak; Name: 'Slovak'; Syntax: 'sk'; CharSet: ''),
    (Table: @aSpanish; Name: 'Spanish'; Syntax: 'es'; CharSet: 'iso-8859-15'),
    (Table: @aSwedish; Name: 'Swedish'; Syntax: 'se'; CharSet: 'iso-8859-15'),
    (Table: @aHungarian_1250; Name: 'Hungarian (Codepage 1250)'; Syntax: 'hu.1250'; CharSet: 'windows-1250'),
    (Table: @aCzech_CP1250; Name: 'Czech (Codepage CP1250)'; Syntax: 'cz'; CharSet: 'windows-1250'),
    (Table: @aCzech_ISO_8859_2; Name: 'Czech (Codepage ISO 8859-2)'; Syntax: 'cz.iso-8859-2'; CharSet: 'iso-8859-2')
  );

function TPasDocLanguages.GetTranslation(
  ATranslationID: TTranslationID): string;
begin
  Result := pTable^[ATranslationID];
  if Result <= strKeep then
    Result := aEnglish[ATranslationID];
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
//get table
  pTable := LANGUAGE_ARRAY[Value].Table;
  if assigned(pTable) then
    exit; //array already exists

//use writeable table
  pTable := addr(aNewLanguage);
  case Value of
  //no array yet
    lgRussian_866: SetLanguageRussian_866;
    lgRussian_koi8: SetLanguageRussian_koi8;
  else  //this should never be reached
    pTable := addr(aEnglish);
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

function LanguageFromID(i: TLanguageID): string;
begin
  Result := language_array[i].Name;
end;

function SyntaxFromIndex(i: integer): string;
var
  l: TLanguageID absolute i;
begin
  Result := Language_array[l].Syntax;
end;

function SyntaxFromID(i: TLanguageID): string;
begin
  Result := Language_array[i].Syntax;
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

 	  	 
