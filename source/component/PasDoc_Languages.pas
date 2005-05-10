{ @abstract(PasDoc language definitions and translations.)
  @author(Johannes Berg <johannes@sipsolutions.de>)
  @author(Ralf Junker <delphi@zeitungsjunge.de>)
  @author(Alexander Lisnevsky <alisnevsky@yandex.ru> (Russian translation))
  @author(Hendy Irawan <ceefour@gauldong.net> (Indonesian and Javanese translation))
  @author(Ivan Montes Velencoso (Catalan and Spanish translations))
  @author(Javi (Spanish translation))
  @author(Jean Dit Bailleul (Frensh translation))
  @author(Marc Weustinks (Dutch translation))
  @author(Martin Hansen <mh@geus.dk> (Danish translation))
  @author(Michele Bersini <michele.bersini@smartit.it> (Italian translation))
  @author(Peter �imkovi� <simkovic_jr@manal.sk> (Slovak translation))
  @author(Peter Th�rnqvist <pt@timemetrics.se> (Swedish translation))
  @author(Rodrigo Urubatan Ferreira Jardim <rodrigo@netscape.net> (Brasilian translation))
  @author(Alexandre da Silva <simpsomboy@gmail.com> (Brasilian translation - Update))
  @author(Vitaly Kovalenko <v_l_kovalenko@alsy.by> (Russian translation))
  @author(Grzegorz Skoczylas <gskoczylas@program.z.pl> (corrected Polish translation))
  @author(J�n�s Gerg� <jonas.gergo@ch...> (Hungarian translation))
  }

unit PasDoc_Languages;

interface

type
  { An enumeration type of all supported languages }
  TLanguageID = (
    lgBosnian,
    lgBrasilian,
    lgCatalan,
    lgChinese_950,
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
    trEnum,
    trDispInterface,
    trFields,
    trFunctionsAndProcedures,
    trHelp,
    trHierarchy,
    trIdentifiers,
    trInterface,
    trLegend,
    trMethods,
    trLastModified,
    trName,
    trNone,
    trObject,
    trObjects,
    trOverview,
    trPrivate,
    trProperties,
    trProtected,
    trPublic,
    trPublished,
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

    trGeneratedBy,
    trOnDateTime,
    
    trDeprecated,
    trPlatformSpecific,
    trLibrarySpecific);

const
  DEFAULT_LANGUAGE = lgEnglish;

type
  { Language class to hold all translated strings }
  TPasDocLanguages = class
  private
    FLanguage: TLanguageID;
    procedure SetLanguage(const Value: TLanguageID);
  protected
    FTranslation: array[TTranslationID] of string;
    FCharSet: string;
    { @abstract(gets a translation token) }
    function GetTranslation(const ATranslationID: TTranslationID): string;
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
    { Defines translations for Polish (Codepage 1250. }
    procedure SetLanguagePolish_CP1250;           
    { Defines translations for Polish (Codepage ISO 8859-2. }
    procedure SetLanguagePolish_ISO_8859_2;       
    { Defines translations for Russian (Codepage 1251). }
    procedure SetLanguageRussian_1251;
    { Defines translations for Russian (Codepage 866). }
    procedure SetLanguageRussian_866;
    { Defines translations for Russian (KOI-8). }
    procedure SetLanguageRussian_koi8;
    { Defines translations for Slovak. }
    procedure SetLanguageSlovak;
    { Defines translations for Spanish. }
    procedure SetLanguageSpanish;
    { Defines translations for Swedish. }
    procedure SetLanguageSwedish;
    { Defines translations for Hungarian (Codepage 1250). }
    procedure SetLanguageHungarian_1250;


  public
    { Charset for current language }
    property CharSet: string read FCharSet;
    property Translation[const ATranslationID: TTranslationID]: string read GetTranslation;
    constructor Create;
    property Language: TLanguageID read FLanguage write SetLanguage
      default DEFAULT_LANGUAGE;
  end;

type
  TLanguageRecord = record
    Name: string;
    Syntax: string;
    CharSet: string;
  end;

const
  LANGUAGE_ARRAY: array[TLanguageID] of TLanguageRecord = (
    (Name: 'Bosnian (Codepage 1250)'; Syntax: 'ba'; CharSet: 'windows-1250'),
    (Name: 'Brasilian'; Syntax: 'br'; CharSet: ''),
    (Name: 'Catalan'; Syntax: 'ct'; CharSet: ''),
    (Name: 'Chinese (Codepage 950)'; Syntax: 'big5'; CharSet: 'big5'),
    (Name: 'Danish'; Syntax: 'dk'; CharSet: 'iso-8859-15'),
    (Name: 'Dutch'; Syntax: 'nl'; CharSet: 'iso-8859-15'),
    (Name: 'English'; Syntax: 'en'; CharSet: 'iso-8859-1'),
    (Name: 'French'; Syntax: 'fr'; CharSet: 'iso-8859-15'),
    (Name: 'German'; Syntax: 'de'; CharSet: 'iso-8859-15'),
    (Name: 'Indonesian'; Syntax: 'id'; CharSet: ''),
    (Name: 'Italian'; Syntax: 'it'; CharSet: 'iso-8859-15'),
    (Name: 'Javanese'; Syntax: 'jv'; CharSet: ''),
    (Name: 'Polish (Codepage CP1250)'; Syntax: 'pl.cp1250'; CharSet: 'windows-1250'),       
    (Name: 'Polish (Codepage ISO 8859-2)'; Syntax: 'pl.iso-8859-2'; CharSet: 'iso-8859-2'), 
    (Name: 'Russian (Codepage 1251)'; Syntax: 'ru.1251'; CharSet: 'windows-1251'),
    (Name: 'Russian (Codepage 866)'; Syntax: 'ru.866'; CharSet: 'IBM866'),
    (Name: 'Russian (KOI-8)'; Syntax: 'ru.KOI8'; CharSet: 'koi8-r'),
    (Name: 'Slovak'; Syntax: 'sk'; CharSet: ''),
    (Name: 'Spanish'; Syntax: 'es'; CharSet: 'iso-8859-15'),
    (Name: 'Swedish'; Syntax: 'se'; CharSet: 'iso-8859-15'),
    (Name: 'Hungarian (Codepage 1250)'; Syntax: 'hu.1250'; CharSet: 'windows-1250')
    
    );

implementation

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
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Fields';
  FTranslation[trFunctionsAndProcedures] := 'Functions and Procedures';
  FTranslation[trHelp] := 'Help';
  FTranslation[trHierarchy] := 'Hierarchy';
  FTranslation[trIdentifiers] := 'Identifiers';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'Legend';
  FTranslation[trMethods] := 'Methods';
  FTranslation[trLastModified] := 'Last Modified';
  FTranslation[trName] := 'Name';
  FTranslation[trNone] := 'None';
  FTranslation[trObject] := 'Object';
  FTranslation[trObjects] := 'Objects';
  FTranslation[trOverview] := 'Overview';
  FTranslation[trPrivate] := 'Private';
  FTranslation[trProperties] := 'Properties';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
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

  FTranslation[trSummaryCio] := 
    'Summary of Classes, Interfaces, Objects and Records';

  FTranslation[trWarningOverwrite] :=
    'Warning: Do not edit - this file has been created automatically and is likely be overwritten';

  FTranslation[trGeneratedBy] := 'Generated by';
  FTranslation[trOnDateTime] := 'on';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library';
end;

{ ---------------------------------------------------------------------------- }

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
  FTranslation[trExceptions] := 'Exceptions';
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Polja';
  FTranslation[trFunctionsAndProcedures] := 'Funkcije i Procedure';
  FTranslation[trHelp] := 'Pomo�';
  FTranslation[trHierarchy] := 'Hijerarhija';
  FTranslation[trIdentifiers] := 'Identifikatori';
  FTranslation[trInterface] := 'Interfejs';
  FTranslation[trLegend] := 'Legenda';
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
  FTranslation[trPublished] := 'Javan';
  FTranslation[trType] := 'Tip';
  FTranslation[trTypes] := 'Tipovi';
  FTranslation[trUnit] := 'Fajl';
  FTranslation[trUnits] := 'Fajlovi';
  FTranslation[trVariables] := 'Promjenjive';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';

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

  FTranslation[trGeneratedBy] := 'Generated by (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trOnDateTime] := 'on (PLEASE TRANSLATE THIS STRING)';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

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
  FTranslation[trEnum] := 'Enumera��es';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Campos';
  FTranslation[trFunctionsAndProcedures] := 'Fun��es e Procedimentos';
  FTranslation[trHelp] := 'Ajuda';
  FTranslation[trHierarchy] := 'Hierarquia';
  FTranslation[trIdentifiers] := 'Identificadores';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'Legenda';
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

  FTranslation[trGeneratedBy] := 'Gerado por';
  FTranslation[trOnDateTime] := 'as';

  FTranslation[trDeprecated] := 'este s�mbolo est� depreciado';
  FTranslation[trPlatformSpecific] := 'este s�mbolo � espec�fico para alguma plataforma';
  FTranslation[trLibrarySpecific] := 'este s�mbolo � espec�fico para alguma biblioteca';
end;

{ ---------------------------------------------------------------------------- }

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
  FTranslation[trExceptions] := 'Exceptions';
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
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Tipus';
  FTranslation[trTypes] := 'Tipus';
  FTranslation[trUnit] := 'Unitat';
  FTranslation[trUnits] := 'Unitats';
  FTranslation[trVariables] := 'Variables';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';

  FTranslation[trWarningOverwrite] :=
    'Atenci�, no editar - aquest fitxer ha estat creat automaticament i ser� sobrescrit';

  FTranslation[trHeadlineCio] := 'Totes les clases, interfaces i objectes';
  FTranslation[trHeadlineConstants] := 'Totes les constants';
  FTranslation[trHeadlineFunctionsAndProcedures] :=
    'Totes les funcions i procediments';
  FTranslation[trHeadlineIdentifiers] := 'Tot els indentificadors';
  FTranslation[trHeadlineTypes] := 'Tots els tipus';
  FTranslation[trHeadlineUnits] := 'Totes les unitats';
  FTranslation[trHeadlineVariables] := 'Totes les variables';

  FTranslation[trSummaryCio] := 'Llista de clases, interfaces i objectes';

  // Please translate
  // FTranslation[trGeneratedBy] := 'Generated by';
  // FTranslation[trOnDateTime] := 'on';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

procedure TPasDocLanguages.SetLanguageChinese_950;
begin
  FTranslation[trAuthor] := '�@��';
  FTranslation[trAuthors] := '�@�̸s';

  // Please translate
  // FTranslation[trGeneratedBy] := 'Generated by';
  // FTranslation[trOnDateTime] := 'on';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

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
  FTranslation[trExceptions] := 'Exceptions';
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Felter';
  FTranslation[trFunctionsAndProcedures] := 'Funktioner og prosedurer';
  FTranslation[trHelp] := 'Hj�lp';
  FTranslation[trHierarchy] := 'Herarki';
  FTranslation[trIdentifiers] := 'Identifiers';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'Legende';
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
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Type';
  FTranslation[trTypes] := 'Typer';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Units';
  FTranslation[trVariables] := 'Variable';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';

  FTranslation[trWarningOverwrite] :=
    'Advarsel: Editer ikke denne fil, den er autogeneret og vil sansylgvis blive overskret';

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

  // Please translate
  // FTranslation[trGeneratedBy] := 'Generated by';
  // FTranslation[trOnDateTime] := 'on';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

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
  FTranslation[trExceptions] := 'Exceptions';
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
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Type';
  FTranslation[trTypes] := 'Typen';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Units';
  FTranslation[trVariables] := 'Variabelen';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';

  FTranslation[trWarningOverwrite] :=
    'Waarschuwing, wijzig niets - dit bestand is automatisch gegenereerd en zal worden overschreven';

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

  // Please translate
  // FTranslation[trGeneratedBy] := 'Generated by';
  // FTranslation[trOnDateTime] := 'on';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

procedure TPasDocLanguages.SetLanguageFrench;
begin
  FTranslation[trAuthor] := 'Auteur';
  FTranslation[trAuthors] := 'Auteurs';
  FTranslation[trCio] := 'Classes, interfaces, structures et objets';
  FTranslation[trClass] := 'Classe';
  FTranslation[trClasses] := 'Classes';
  FTranslation[trConstants] := 'Constantes';
  FTranslation[trCreated] := 'Cr�e';
  FTranslation[trDeclaration] := 'D�claration';
  FTranslation[trDescription] := 'Description';
  FTranslation[trParameters] := 'Param�tres';
  FTranslation[trReturns] := 'Retourne';
  FTranslation[trExceptions] := 'Exceptions';
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Champs';
  FTranslation[trFunctionsAndProcedures] := 'Fonctions et proc�dures';
  FTranslation[trHelp] := 'Aide';
  FTranslation[trHierarchy] := 'Hierarchie';
  FTranslation[trIdentifiers] := 'Identificateurs';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLastModified] := 'Derni�re modification';
  FTranslation[trLegend] := 'L�gende';
  FTranslation[trMethods] := 'M�thodes';
  FTranslation[trName] := 'Nom';
  FTranslation[trNone] := 'Aucun(e)(s)';
  FTranslation[trObject] := 'Objet';
  FTranslation[trObjects] := 'Objets';
  FTranslation[trOverview] := 'Aper�u';
  FTranslation[trPrivate] := 'Priv�';
  FTranslation[trProperties] := 'Propri�t�s';
  FTranslation[trProtected] := 'Prot�g�';
  FTranslation[trPublic] := 'Public';
  FTranslation[trPublished] := 'Publi�s';
  FTranslation[trType] := 'Type';
  FTranslation[trTypes] := 'Types';
  FTranslation[trUnit] := 'Unit�';
  FTranslation[trUnits] := 'Unit�s';
  FTranslation[trVariables] := 'Variables';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';

  FTranslation[trWarningOverwrite] :=
    'Attention, ne pas �dtier - ce fichier est cr�� automatiquement et va �tre �cras�';

  FTranslation[trHeadlineCio] := 'Toutes les classes, interfaces et objets';
  FTranslation[trHeadlineConstants] := 'Toutes les constants';
  FTranslation[trHeadlineFunctionsAndProcedures] :=
    'Toutes les fonctions et proc�dures';
  FTranslation[trHeadlineIdentifiers] := 'Tous les identificateurs';
  FTranslation[trHeadlineTypes] := 'Tous les types';
  FTranslation[trHeadlineUnits] := 'Toutes les unit�s';
  FTranslation[trHeadlineVariables] := 'Toutes les variables';

  FTranslation[trSummaryCio] := 'Classes, interfaces & objets';

  // Please translate
  // FTranslation[trGeneratedBy] := 'Generated by';
  // FTranslation[trOnDateTime] := 'on';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

procedure TPasDocLanguages.SetLanguageGerman;
begin
  FTranslation[trAuthor] := 'Autor';
  FTranslation[trAuthors] := 'Autoren';
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
  FTranslation[trExceptions] := 'Exceptions';
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Felder';
  FTranslation[trFunctionsAndProcedures] := 'Funktionen und Prozeduren';
  FTranslation[trHelp] := 'Hilfe';
  FTranslation[trHierarchy] := 'Hierarchie';
  FTranslation[trIdentifiers] := 'Bezeichner';
  FTranslation[trInterface] := 'Schnittstelle';
  FTranslation[trLastModified] := 'Letzte �nderung';
  FTranslation[trLegend] := 'Legende';
  FTranslation[trMethods] := 'Methoden';
  FTranslation[trName] := 'Name';
  FTranslation[trNone] := 'Keine';
  FTranslation[trObject] := 'Objekt';
  FTranslation[trObjects] := 'Objekte';
  FTranslation[trOverview] := '�bersicht';
  FTranslation[trPrivate] := 'Privat';
  FTranslation[trProperties] := 'Eigenschaften';
  FTranslation[trProtected] := 'Protected';
  FTranslation[trPublic] := 'Public';
  FTranslation[trPublished] := 'Published';
  FTranslation[trTypes] := 'Typen';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Units';
  FTranslation[trVariables] := 'Variablen';
  FTranslation[trType] := 'Typ';
  FTranslation[trTypes] := 'Typen';
  FTranslation[trGvUses] := 'Unit Abh�ngigkeitsgraph';
  FTranslation[trGvClasses] := 'Klassenhierarchie Graph';

  FTranslation[trHeadlineCio] := 'Alle Klassen, Schnittstellen und Objekte';
  FTranslation[trHeadlineConstants] := 'Alle Konstanten';
  FTranslation[trHeadlineFunctionsAndProcedures] :=
    'Alle Funktionen und Prozeduren';
  FTranslation[trHeadlineIdentifiers] := 'Alle Bezeichner';
  FTranslation[trHeadlineTypes] := 'Alle Typen';
  FTranslation[trHeadlineUnits] := 'Alle Units';
  FTranslation[trHeadlineVariables] := 'Alle Variablen';

  FTranslation[trWarningOverwrite] :=
    'Achtung: Nicht �ndern - diese Datei wurde automatisch erstellt und wird m�glicherweise �berschrieben';

  FTranslation[trGeneratedBy] := 'Erstellt von';
  FTranslation[trOnDateTime] := 'am';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

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
  FTranslation[trExceptions] := 'Exceptions';
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Field';
  FTranslation[trFunctionsAndProcedures] := 'Fungsi dan Prosedur';
  FTranslation[trHelp] := 'Bantuan';
  FTranslation[trHierarchy] := 'Hirarki';
  FTranslation[trIdentifiers] := 'Identifier';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'Legenda';
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
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Tipe Bentukan';
  FTranslation[trTypes] := 'Tipe Bentukan';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Unit';
  FTranslation[trVariables] := 'Variabel';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';

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

  FTranslation[trGeneratedBy] := 'Dihasilkan oleh';
  FTranslation[trOnDateTime] := 'pada';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

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
  FTranslation[trExceptions] := 'Exceptions';
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Campi';
  FTranslation[trFunctionsAndProcedures] := 'Funzioni e Procedure';
  FTranslation[trHelp] := 'Help';
  FTranslation[trHierarchy] := 'Gerarchia';
  FTranslation[trIdentifiers] := 'Identificatori';
  FTranslation[trInterface] := 'Interfacce';
  FTranslation[trLegend] := 'Legenda';
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
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Tipo';
  FTranslation[trTypes] := 'Tipi';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Units';
  FTranslation[trVariables] := 'Variabili';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';

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

  // Please translate
  // FTranslation[trGeneratedBy] := 'Generated by';
  // FTranslation[trOnDateTime] := 'on';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

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
  FTranslation[trExceptions] := 'Exceptions';
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Field';
  FTranslation[trFunctionsAndProcedures] := 'Fungsi lan Prosedur';
  FTranslation[trHelp] := 'Tulung';
  FTranslation[trHierarchy] := 'Hirarki';
  FTranslation[trIdentifiers] := 'Identifier';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'Katrangan';
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
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Macem Gawean';
  FTranslation[trTypes] := 'Macem Gawean';
  FTranslation[trUnit] := 'Unit';
  FTranslation[trUnits] := 'Unit';
  FTranslation[trVariables] := 'Variabel';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';

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

  FTranslation[trGeneratedBy] := 'Dihasilne karo';
  FTranslation[trOnDateTime] := 'ing';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

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
  FTranslation[trEnum] := 'Wyliczenie';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Pola';
  FTranslation[trFunctionsAndProcedures] := 'Podprogramy';
  FTranslation[trHelp] := 'Pomoc';
  FTranslation[trHierarchy] := 'Hierarchia';
  FTranslation[trIdentifiers] := 'Identyfikatory';
  FTranslation[trInterface] := 'Interfejs';
  FTranslation[trLegend] := 'Legenda';
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

  FTranslation[trGeneratedBy] := 'Wygenerowane przez';
  FTranslation[trOnDateTime] := ' - ';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

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
  FTranslation[trEnum] := 'Wyliczenie';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Pola';
  FTranslation[trFunctionsAndProcedures] := 'Podprogramy';
  FTranslation[trHelp] := 'Pomoc';
  FTranslation[trHierarchy] := 'Hierarchia';
  FTranslation[trIdentifiers] := 'Identyfikatory';
  FTranslation[trInterface] := 'Interfejs';
  FTranslation[trLegend] := 'Legenda';
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

  FTranslation[trGeneratedBy] := 'Wygenerowane przez';
  FTranslation[trOnDateTime] := ' - ';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

procedure TPasDocLanguages.SetLanguageRussian_1251;
begin
  FTranslation[trAuthor] := '�����';
  FTranslation[trAuthors] := '������';
  FTranslation[trCio] := '������, ���������� � �������';
  FTranslation[trClass] := '�����';
  FTranslation[trClasses] := '������';
  FTranslation[trConstants] := '���������';
  FTranslation[trCreated] := '�������';
  FTranslation[trDeclaration] := '����������';
  FTranslation[trParameters] := 'Parameters';
  FTranslation[trReturns] := 'Returns';
  FTranslation[trExceptions] := 'Exceptions';
  FTranslation[trEnum] := 'Enumeration';
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
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := '���';
  FTranslation[trTypes] := '����';
  FTranslation[trUnit] := '������';
  FTranslation[trUnits] := '������';
  FTranslation[trVariables] := '����������';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';
  FTranslation[trWarningOverwrite] :=
    '��������������: �� ������������� - ���� ���� ������ ������������� � ����� ���� ������ ��� ��������������';

  FTranslation[trHeadlineCio] := '��� ������, ���������� � �������';
  FTranslation[trHeadlineConstants] := '��� ���������';
  FTranslation[trHeadlineFunctionsAndProcedures] := '��� ��������� � �������';
  FTranslation[trHeadlineIdentifiers] := '��� ��������������';
  FTranslation[trHeadlineTypes] := '��� ����';
  FTranslation[trHeadlineUnits] := '��� ������';
  FTranslation[trHeadlineVariables] := '��� ����������';

  FTranslation[trSummaryCio] := '������ �������, ����������� � ��������';

  // Please translate
  // FTranslation[trGeneratedBy] := 'Generated by';
  // FTranslation[trOnDateTime] := 'on';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

procedure TPasDocLanguages.SetLanguageRussian_866;
begin
  FTranslation[trAuthor] := '����';
  FTranslation[trAuthors] := '�����';
  FTranslation[trCio] := '������, ����䥩�� � ��ꥪ��';
  FTranslation[trClass] := '�����';
  FTranslation[trClasses] := '������';
  FTranslation[trConstants] := '����⠭��';
  FTranslation[trCreated] := '�������';
  FTranslation[trDeclaration] := '�������';
  FTranslation[trDescription] := '���ᠭ��';
  FTranslation[trParameters] := 'Parameters';
  FTranslation[trReturns] := 'Returns';
  FTranslation[trExceptions] := 'Exceptions';
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := '����';
  FTranslation[trFunctionsAndProcedures] := '��楤��� � �㭪樨';
  FTranslation[trHelp] := 'Help';
    // Untranslated to avoid Russian file name for css
  FTranslation[trHierarchy] := '������';
  FTranslation[trIdentifiers] := '�����䨪����';
  FTranslation[trInterface] := '����䥩�';
  FTranslation[trLegend] := '������祭��';
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
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := '���';
  FTranslation[trTypes] := '����';
  FTranslation[trUnit] := '�����';
  FTranslation[trUnits] := '���㫨';
  FTranslation[trVariables] := '��६����';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';
  FTranslation[trWarningOverwrite] :=
    '�।�०�����: �� ।���஢��� - ��� 䠩� ᮧ��� ��⮬���᪨ � ����� ���� ������ ��� �।�०�����';

  FTranslation[trHeadlineCio] := '�� ������, ����䥩�� � ��ꥪ��';
  FTranslation[trHeadlineConstants] := '�� ����⠭��';
  FTranslation[trHeadlineFunctionsAndProcedures] := '�� ��楤��� � �㭪樨';
  FTranslation[trHeadlineIdentifiers] := '�� �����䨪����';
  FTranslation[trHeadlineTypes] := '�� ⨯�';
  FTranslation[trHeadlineUnits] := '�� ���㫨';
  FTranslation[trHeadlineVariables] := '�� ��६����';

  FTranslation[trSummaryCio] := '���᮪ ����ᮢ, ����䥩ᮢ � ��ꥪ⮢';

  // Please translate
  // FTranslation[trGeneratedBy] := 'Generated by';
  // FTranslation[trOnDateTime] := 'on';

  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

procedure TPasDocLanguages.SetLanguageRussian_koi8;
begin
  FTranslation[trAuthor] := '�����';
  FTranslation[trAuthors] := '������';
  FTranslation[trCio] := '������, ���������� � �������';
  FTranslation[trClass] := '�����';
  FTranslation[trClasses] := '������';
  FTranslation[trConstants] := '���������';
  FTranslation[trCreated] := '�������';
  FTranslation[trDeclaration] := '����������';
  FTranslation[trDescription] := '��������';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trParameters] := 'Parameters';
  FTranslation[trExceptions] := 'Exceptions';
  FTranslation[trReturns] := 'Returns';
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trFields] := '����';
  FTranslation[trFunctionsAndProcedures] := '��������� � �������';
  FTranslation[trHelp] := 'Help';
    // Untranslated to avoid Russian file name for css
  FTranslation[trHierarchy] := '��������';
  FTranslation[trIdentifiers] := '��������������';
  FTranslation[trInterface] := '���������';
  FTranslation[trLegend] := '�����������';
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
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := '���';
  FTranslation[trTypes] := '����';
  FTranslation[trUnit] := '������';
  FTranslation[trUnits] := '������';
  FTranslation[trVariables] := '����������';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';
  FTranslation[trWarningOverwrite] :=
    '��������������: �� ������������� - ���� ���� ������ ������������� � ����� ���� ����Σ� ��� ��������������';

  FTranslation[trHeadlineCio] := '��� ������, ���������� � �������';
  FTranslation[trHeadlineConstants] := '��� ���������';
  FTranslation[trHeadlineFunctionsAndProcedures] := '��� ��������� � �������';
  FTranslation[trHeadlineIdentifiers] := '��� ��������������';
  FTranslation[trHeadlineTypes] := '��� ����';
  FTranslation[trHeadlineUnits] := '��� ������';
  FTranslation[trHeadlineVariables] := '��� ����������';

  FTranslation[trSummaryCio] := '������ �������, ����������� � ��������';

  // Please translate
  // FTranslation[trGeneratedBy] := 'Generated by';
  // FTranslation[trOnDateTime] := 'on';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

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
  FTranslation[trExceptions] := 'Exceptions';
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
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';
  FTranslation[trWarningOverwrite] :=
    'Upozornenie: Needitujte - tento s�bor bol vytvoren� automaticky a je pravdepodobn�, �e bude prep�san�';

  FTranslation[trHeadlineCio] := 'V�etky triedy, interfejsy a objekty';
  FTranslation[trHeadlineConstants] := 'V�etky kon�tanty';
  FTranslation[trHeadlineFunctionsAndProcedures] :=
    'V�etky funkcie a proced�ry';
  FTranslation[trHeadlineIdentifiers] := 'V�etky identifik�tory';
  FTranslation[trHeadlineTypes] := 'V�etky typy';
  FTranslation[trHeadlineUnits] := 'V�etky jednotky';
  FTranslation[trHeadlineVariables] := 'V�etky premenn�';

  FTranslation[trSummaryCio] := 'Zoznam tried, interfejsov a objektov';

  // Please translate
  // FTranslation[trGeneratedBy] := 'Generated by';
  // FTranslation[trOnDateTime] := 'on';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

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
  FTranslation[trReturns] := 'Vueltas';
  FTranslation[trExceptions] := 'Exceptions';
  FTranslation[trEnum] := 'Enumeration';
  FTranslation[trDispInterface] := 'DispInterface';
  FTranslation[trFields] := 'Campos';
  FTranslation[trFunctionsAndProcedures] := 'Funciones y procedimientos';
  FTranslation[trHelp] := 'Ayuda';
  FTranslation[trHierarchy] := 'Jerarqu�a';
  FTranslation[trIdentifiers] := 'Identificadores';
  FTranslation[trInterface] := 'Interface';
  FTranslation[trLegend] := 'Leyenda';
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
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Tipo';
  FTranslation[trTypes] := 'Tipos';
  FTranslation[trUnit] := 'Unidad';
  FTranslation[trUnits] := 'Unidades';
  FTranslation[trVariables] := 'Variables';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';
  FTranslation[trHeadlineCio] := 'Todas las clases, interfaces y objetos';
  FTranslation[trHeadlineConstants] := 'Todas las constantes';
  FTranslation[trHeadlineFunctionsAndProcedures] :=    'Todos las funciones y procedimientos';
  FTranslation[trHeadlineIdentifiers] := 'Todos los indentificadores';
  FTranslation[trHeadlineTypes] := 'Todos los tipos';
  FTranslation[trHeadlineUnits] := 'Todas las unidades';
  FTranslation[trHeadlineVariables] := 'Todas las variables';
  FTranslation[trSummaryCio] := 'Lista de clases, interfaces y objetos';
  FTranslation[trWarningOverwrite] :=    'Atenci�n, no editar - este fichero ha sido creado automaticamente y puede ser sobrescrito';
  FTranslation[trGeneratedBy] := 'Generador por';
  FTranslation[trOnDateTime] := 'a';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

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
  FTranslation[trExceptions] := 'Exceptions';
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
  FTranslation[trPublished] := 'Published';
  FTranslation[trType] := 'Typer';
  FTranslation[trTypes] := 'Typer';
  FTranslation[trUnit] := 'Enhet';
  FTranslation[trUnits] := 'Enheter';
  FTranslation[trVariables] := 'Variabler';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';

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

  // Please translate
  // FTranslation[trGeneratedBy] := 'Generated by';
  // FTranslation[trOnDateTime] := 'on';
  
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

{ ---------------------------------------------------------------------------- }

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
   FTranslation[trEnum] := 'Felsorol�sok';
   FTranslation[trDispInterface] := 'K�perny� fel�letek';
   FTranslation[trFields] := 'Mez�k';
   FTranslation[trFunctionsAndProcedures] := 'F�ggv�nyek �s Elj�r�sok';
   FTranslation[trHelp] := 'S�g�';
   FTranslation[trHierarchy] := 'Hierarchia';
   FTranslation[trIdentifiers] := 'Azonos�t�k';
   FTranslation[trInterface] := 'Kapcsol�d�si fel�let';
   FTranslation[trLegend] := 'T�rt�net';
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
   FTranslation[trPublished] := 'Publik�lt';
   FTranslation[trType] := 'T�pus';
   FTranslation[trTypes] := 'T�pusok';
   FTranslation[trUnit] := 'Egys�g';
   FTranslation[trUnits] := 'Egys�gek';
   FTranslation[trVariables] := 'V�ltoz�k';
  { TODO : add translation }
//  FTranslation[trGvUses] := 'Unit dependency graph';
//  FTranslation[trGvClasses] := 'Classes hierarchy graph';

   FTranslation[trHeadlineCio] := '�sszes Oszt�ly, Kapcsol�d�si fel�let �s Objektumok';
   FTranslation[trHeadlineConstants] := '�sszes Kontans';
   FTranslation[trHeadlineFunctionsAndProcedures] := '�sszes F�ggv�ny �s Elj�r�s';
   FTranslation[trHeadlineIdentifiers] := '�sszes Azonos�t�';
   FTranslation[trHeadlineTypes] := '�sszes T�pus';
   FTranslation[trHeadlineUnits] := '�sszes Egys�g';
   FTranslation[trHeadlineVariables] := '�sszes V�ltoz�';
  
   FTranslation[trSummaryCio] := '�szefoglal� az Oszt�lyokr�l, Kapcsold�si fel�letekr�l �s Objektumokr�l';
  
   FTranslation[trWarningOverwrite] :=
     'Vigy�zat: Nem szerkesztend� file - ez a file automatikusan k�sz�lt, val�sz�n�leg fel�l�r�sra ker�lne';
  
   FTranslation[trGeneratedBy] := 'K�sz�tette';
   FTranslation[trOnDateTime] := ''; //none in Hungarian language
   
  FTranslation[trDeprecated] := 'this symbol is deprecated (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trPlatformSpecific] := 'this symbol is specific to some platform (PLEASE TRANSLATE THIS STRING)';
  FTranslation[trLibrarySpecific] := 'this symbol is specific to some library (PLEASE TRANSLATE THIS STRING)';
end;

function TPasDocLanguages.GetTranslation(
  const ATranslationID: TTranslationID): string;
begin
  Result := FTranslation[ATranslationID];
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
  case Value of
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
    lgRussian_866: SetLanguageRussian_866;
    lgRussian_koi8: SetLanguageRussian_koi8;
    lgSlovak: SetLanguageSlovak;
    lgSpanish: SetLanguageSpanish;
    lgSwedish: SetLanguageSwedish;
    
    lgHungarian_1250: SetLanguageHungarian_1250;

  end;
end;

{
  $Log$
  Revision 1.20  2005/05/10 07:28:27  kambi
  * Updates to Brasilian translation from Alexandre da Silva

  Revision 1.19  2005/05/07 19:03:41  kambi
  * Displaying hint directives in html and latex output

  Revision 1.18  2005/05/06 23:30:49  kambi
  * Updates to Brasilian translation from Alexandre da Silva

  Revision 1.17  2005/04/17 03:46:53  kambi
  * typo fix: Frensh -> French

  Revision 1.16  2005/04/14 10:21:51  kambi
  * Specified default values for many properties. This means that code is better self-documenting,
    and also component is better shown in object inspector and saved to dfm/xfm/lfm files.

  Revision 1.15  2005/04/08 02:51:47  ccodere
    + corrected french language

  Revision 1.14  2005/04/06 13:34:36  kambi
  * Added "and Records" to FTranslation[trCio], FTranslation[trHeadlineCio],
    FTranslation[trSummaryCio] for English and two Polish versions
  * trGvUses/Classes in Polish translation and minor fixes for Polish translation,
    removed "//GSk" (this was a leftover from patch of Grzegorz Skoczylas,
    but these comments belonged to cvs logs, not to clutter source code)

  Revision 1.13  2005/03/30 10:18:59  johill
  add charsets to languages

  Revision 1.12  2004/08/10 20:43:26  twm
  patches from Ricardo Pardini:
  * Include graphics into htmlhelp
  * Check whether --link-gv-* are actually given before creating the links
  * Brazilian Portuguese translations

  Revision 1.11  2004/08/08 14:56:33  twm
  Bugfixes:
  * In several places the return value of CreateStream wasn't checked leading a access violations if a file could not be created (e.g. if the output directory didn't exist)
  * Missing field declarations for FLinkGraphVizUses and FLinkGraphVizClasses
  * missing declaration and translations for trGvUses and trGvClasses
  * Main program did not handle all exceptions (e.g. EAbort)

  Revision 1.10  2004/07/16 16:34:16  johill
  some code cleanup, fixes from Pierre Woestyn

  Revision 1.9  2004/06/20 18:36:26  johill
  Changes from Grzegorz Skoczylas: character set handling + updated Polish
  translation

  Revision 1.8  2004/06/13 17:58:07  ccodere
    + added hungarian translation from Jonas (thanks!)

}
end.
