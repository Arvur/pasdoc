{ @abstract(PasDoc language definitions and translations.)
  @author(Ralf Junker <delphi@zeitungsjunge.de>)
  @author(Alexander Lisnevsky <alisnevsky@yandex.ru> (Russian translation))
  @author(Hendy Irawan <ceefour@gauldong.net> (Indonesian and Javanese translation))
  @author(Ivan Montes Velencoso (Catalan and Spanish translations))
  @author(Jean Dit Bailleul (Frensh translation))
  @author(Marc Weustinks (Dutch translation))
  @author(Martin Hansen <mh@geus.dk> (Danish translation))
  @author(Michele Bersini <michele.bersini@smartit.it> (Italian translation))
  @author(Peter �imkovi� <simkovic_jr@manal.sk> (Slovak translation))
  @author(Peter Th�rnqvist <pt@timemetrics.se> (Swedish translation))
  @author(Rodrigo Urubatan Ferreira Jardim <rodrigo@netscape.net> (Brasilian translation))
  @author(Vitaly Kovalenko <v_l_kovalenko@alsy.by> (Russian translation))
  }

unit PasDoc_Languages;

interface

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
{ Defines translations for Polish. }
procedure SetLanguagePolish;
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

type
  { An enumeration type of all supported languages.
    Should always be kept in alphabetical order. }
  TLanguageID = (
    lgDefault,
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
    lgPolish,
    lgRussian_1251,
    lgRussian_866,
    lgRussian_koi8,
    lgSlovak,
    lgSpanish,
    lgSwedish);

  TSetLanguageProc = procedure;

  TLanguageRecord = record
    Name: string;
    Syntax: string;
    CharSet: string;
    proc: TSetLanguageProc;
  end;

const
  LANGUAGE_ARRAY: array[TLanguageID] of TLanguageRecord = (
    (Name: ''; Syntax: ''; CharSet: ''; proc: nil),
      // Dummy entry for default language
    (Name: 'Bosnian (Codepage 1250)'; Syntax: 'ba'; CharSet: 'windows-1250';
      proc: SetLanguageBosnian),
    (Name: 'Brasilian'; Syntax: 'br'; CharSet: ''; proc:
      SetLanguageBrasilian),
    (Name: 'Catalan'; Syntax: 'ct'; CharSet: ''; proc: SetLanguageCatalan),
    (Name: 'Chinese (Codepage 950)'; Syntax: 'big5'; CharSet: 'big5'; proc:
      SetLanguageChinese_950),
    (Name: 'Danish'; Syntax: 'dk'; CharSet: ''; proc: SetLanguageDanish),
    (Name: 'Dutch'; Syntax: 'nl'; CharSet: ''; proc: SetLanguageDutch),
    (Name: 'English'; Syntax: 'en'; CharSet: ''; proc: SetLanguageEnglish),
    (Name: 'Frensh'; Syntax: 'fr'; CharSet: ''; proc: SetLanguageFrench),
    (Name: 'German'; Syntax: 'de'; CharSet: ''; proc: SetLanguageGerman),
    (Name: 'Indonesian'; Syntax: 'id'; CharSet: ''; proc:
      SetLanguageIndonesian),
    (Name: 'Italian'; Syntax: 'it'; CharSet: ''; proc: SetLanguageItalian),
    (Name: 'Javanese'; Syntax: 'jv'; CharSet: ''; proc: SetLanguageJavanese),
    (Name: 'Polish'; Syntax: 'pl'; CharSet: ''; proc: SetLanguagePolish),
    (Name: 'Russian (Codepage 1251)'; Syntax: 'ru.1251'; CharSet:
      'windows-1251'; proc: SetLanguageRussian_1251),
    (Name: 'Russian (Codepage 866)'; Syntax: 'ru.866'; CharSet: 'IBM866';
      proc: SetLanguageRussian_866),
    (Name: 'Russian (KOI-8)'; Syntax: 'ru.KOI8'; CharSet: 'koi8-r'; proc:
      SetLanguageRussian_koi8),
    (Name: 'Slovak'; Syntax: 'sk'; CharSet: ''; proc: SetLanguageSlovak),
    (Name: 'Spanish'; Syntax: 'es'; CharSet: ''; proc: SetLanguageSpanish),
    (Name: 'Swedish'; Syntax: 'se'; CharSet: ''; proc: SetLanguageSwedish));

  DEFAULT_LANGUAGE = lgEnglish;

type
  { An enumeration type of all static output texts. }
  TTranslationID = (
    trAuthor,
    trAuthors,
    trCio,
    trClass,
    trClasses,
    trClassHierarchy,
    trConstants,
    trCreated,
    trDeclaration,
    trDescription,
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
    trOnDateTime);

var
  Translation: array[TTranslationID] of string;

implementation

procedure SetLanguageEnglish;
begin
  Translation[trAuthor] := 'Author';
  Translation[trAuthors] := 'Authors';
  Translation[trCio] := 'Classes, Interfaces and Objects';
  Translation[trClass] := 'Class';
  Translation[trClasses] := 'Classes';
  Translation[trClassHierarchy] := 'Class Hierarchy';
  Translation[trConstants] := 'Constants';
  Translation[trCreated] := 'Created';
  Translation[trDeclaration] := 'Declaration';
  Translation[trDescription] := 'Description';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'Fields';
  Translation[trFunctionsAndProcedures] := 'Functions and Procedures';
  Translation[trHelp] := 'Help';
  Translation[trHierarchy] := 'Hierarchy';
  Translation[trIdentifiers] := 'Identifiers';
  Translation[trInterface] := 'Interface';
  Translation[trLegend] := 'Legend';
  Translation[trMethods] := 'Methods';
  Translation[trLastModified] := 'Last Modified';
  Translation[trName] := 'Name';
  Translation[trNone] := 'None';
  Translation[trObject] := 'Object';
  Translation[trObjects] := 'Objects';
  Translation[trOverview] := 'Overview';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := 'Properties';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trType] := 'Type';
  Translation[trTypes] := 'Types';
  Translation[trUnit] := 'Unit';
  Translation[trUnits] := 'Units';
  Translation[trVariables] := 'Variables';

  Translation[trHeadlineCio] := 'All Classes, Interfaces and Objects';
  Translation[trHeadlineConstants] := 'All Constants';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'All Functions and Procedures';
  Translation[trHeadlineIdentifiers] := 'All Identifiers';
  Translation[trHeadlineTypes] := 'All Types';
  Translation[trHeadlineUnits] := 'All Units';
  Translation[trHeadlineVariables] := 'All Variables';

  Translation[trSummaryCio] := 'Summary of Classes, Interfaces and Objects';

  Translation[trWarningOverwrite] :=
    'Warning: Do not edit - this file has been created automatically and is likely be overwritten';

  Translation[trGeneratedBy] := 'Generated by';
  Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageBosnian;
begin
  Translation[trAuthor] := 'Autor';
  Translation[trAuthors] := 'Autori';
  Translation[trCio] := 'Klase, Interfejsi i Objekti';
  Translation[trClass] := 'Klasa';
  Translation[trClasses] := 'Klase';
  Translation[trConstants] := 'Konstante';
  Translation[trCreated] := 'Kreirano';
  Translation[trDeclaration] := 'Deklaracija';
  Translation[trDescription] := 'Opis';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'Polja';
  Translation[trFunctionsAndProcedures] := 'Funkcije i Procedure';
  Translation[trHelp] := 'Pomo�';
  Translation[trHierarchy] := 'Hijerarhija';
  Translation[trIdentifiers] := 'Identifikatori';
  Translation[trInterface] := 'Interfejs';
  Translation[trLegend] := 'Legenda';
  Translation[trMethods] := 'Metode';
  Translation[trLastModified] := 'Zadnja promjena';
  Translation[trName] := 'Ime';
  Translation[trNone] := 'Ni�ta';
  Translation[trObject] := 'Objekt';
  Translation[trObjects] := 'Objekti';
  Translation[trOverview] := 'Pregled';
  Translation[trPrivate] := 'Privatni';
  Translation[trProperties] := 'Osibine';
  Translation[trProtected] := 'Za�ti�en';
  Translation[trPublic] := 'Publikovan';
  Translation[trPublished] := 'Javan';
  Translation[trType] := 'Tip';
  Translation[trTypes] := 'Tipovi';
  Translation[trUnit] := 'Fajl';
  Translation[trUnits] := 'Fajlovi';
  Translation[trVariables] := 'Promjenjive';

  Translation[trHeadlineCio] := 'Sve Klase, Interfejsi i Objekti';
  Translation[trHeadlineConstants] := 'Sve Konstante';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'Sve Funkcije i Procedure';
  Translation[trHeadlineIdentifiers] := 'Svi Identifikatoti';
  Translation[trHeadlineTypes] := 'Svi Tipovi';
  Translation[trHeadlineUnits] := 'Svi Fajlovi';
  Translation[trHeadlineVariables] := 'Sve Varijable';

  Translation[trSummaryCio] := 'Zbirno od Klasa, Interfejsa i Objekata';

  Translation[trWarningOverwrite] :=
    'Upozorenje: Ne mjenjajte fajl - ovaj fajl je kreiran automatski i velika je vjerovatno�a da �e biti prepisan';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageBrasilian;
begin
  Translation[trAuthor] := 'Autor';
  Translation[trAuthors] := 'Autores';
  Translation[trCio] := 'Classes, Interfaces e Objetos';
  Translation[trClass] := 'Classe';
  Translation[trClasses] := 'Classes';
  Translation[trConstants] := 'Constantes';
  Translation[trCreated] := 'Criado';
  Translation[trDeclaration] := 'Declara��o';
  Translation[trDescription] := 'Descri��o';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'Campos';
  Translation[trFunctionsAndProcedures] := 'Fun��es e Procedimentos';
  Translation[trHelp] := 'Ajuda';
  Translation[trHierarchy] := 'Hierarquia';
  Translation[trIdentifiers] := 'Identificadores';
  Translation[trInterface] := 'Interface';
  Translation[trLegend] := 'Legenda';
  Translation[trLastModified] := '�ltima modifica��o';
  Translation[trMethods] := 'M�todos';
  Translation[trName] := 'Nome';
  Translation[trNone] := 'Nenhum';
  Translation[trObject] := 'Objeto';
  Translation[trObjects] := 'Objetos';
  Translation[trOverview] := 'Vis�o geral';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := 'Propriedades';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trType] := 'Tipo';
  Translation[trTypes] := 'Tipos';
  Translation[trUnit] := 'Unit';
  Translation[trUnits] := 'Unit';
  Translation[trVariables] := 'Vari�veis';
  Translation[trWarningOverwrite] :=
    'Aviso, n�o altere - este arquivo foi gerado automaticamente e ser� sobrescrito';

  Translation[trHeadlineCio] := 'Todas as classes, interfaces e objetos';
  Translation[trHeadlineConstants] := 'Todas as constantes';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'Todas as fun��es e procedimentos';
  Translation[trHeadlineIdentifiers] := 'Todos os identificadores';
  Translation[trHeadlineTypes] := 'Todos os tipos';
  Translation[trHeadlineUnits] := 'Todos as units';
  Translation[trHeadlineVariables] := 'Todas as vari�veis';

  Translation[trSummaryCio] := 'Lista de classes, interfaces e objetos';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageCatalan;
begin
  Translation[trAuthor] := 'Autor';
  Translation[trAuthors] := 'Autors';
  Translation[trCio] := 'Clases, interfaces i objectes';
  Translation[trClass] := 'Clase';
  Translation[trClasses] := 'Clases';
  Translation[trConstants] := 'Constants';
  Translation[trCreated] := 'Creat';
  Translation[trDeclaration] := 'Declaraci�';
  Translation[trDescription] := 'Descripci�';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'Camps';
  Translation[trFunctionsAndProcedures] := 'Funcions i procediments';
  Translation[trHelp] := 'Help';
  Translation[trHierarchy] := 'Hierarchy';
  Translation[trIdentifiers] := 'Identificadors';
  Translation[trInterface] := 'Interface';
  Translation[trLastModified] := '�ltima modificaci�';
  Translation[trLegend] := 'Legend';
  Translation[trMethods] := 'M�todes';
  Translation[trName] := 'Nom';
  Translation[trNone] := 'Ningu';
  Translation[trObject] := 'Objecte';
  Translation[trObjects] := 'Objectes';
  Translation[trOverview] := 'Resum';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := 'Propietats';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trType] := 'Tipus';
  Translation[trTypes] := 'Tipus';
  Translation[trUnit] := 'Unitat';
  Translation[trUnits] := 'Unitats';
  Translation[trVariables] := 'Variables';
  Translation[trWarningOverwrite] :=
    'Atenci�, no editar - aquest fitxer ha estat creat automaticament i ser� sobrescrit';

  Translation[trHeadlineCio] := 'Totes les clases, interfaces i objectes';
  Translation[trHeadlineConstants] := 'Totes les constants';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'Totes les funcions i procediments';
  Translation[trHeadlineIdentifiers] := 'Tot els indentificadors';
  Translation[trHeadlineTypes] := 'Tots els tipus';
  Translation[trHeadlineUnits] := 'Totes les unitats';
  Translation[trHeadlineVariables] := 'Totes les variables';

  Translation[trSummaryCio] := 'Llista de clases, interfaces i objectes';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageChinese_950;
begin
  Translation[trAuthor] := '�@��';
  Translation[trAuthors] := '�@�̸s';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageDanish;
begin
  Translation[trAuthor] := 'Forfatter';
  Translation[trAuthors] := 'Forfatre';
  Translation[trCio] := 'Klasser, interfaces og objekter';
  Translation[trClass] := 'Klasse';
  Translation[trClasses] := 'Klasser';
  Translation[trConstants] := 'Konstanter';
  Translation[trCreated] := 'Udf�rt';
  Translation[trDeclaration] := 'Declaration';
  Translation[trDescription] := 'Beskrivelse';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'Felter';
  Translation[trFunctionsAndProcedures] := 'Funktioner og prosedurer';
  Translation[trHelp] := 'Hj�lp';
  Translation[trHierarchy] := 'Herarki';
  Translation[trIdentifiers] := 'Identifiers';
  Translation[trInterface] := 'Interface';
  Translation[trLegend] := 'Legende';
  Translation[trLastModified] := 'Sidst Modificieret';
  Translation[trMethods] := 'Metoder';
  Translation[trName] := 'Navn';
  Translation[trNone] := 'Ingen';
  Translation[trObject] := 'Objekt';
  Translation[trObjects] := 'Objekter';
  Translation[trOverview] := 'Sammendrag';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := 'Egenskaber';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trType] := 'Type';
  Translation[trTypes] := 'Typer';
  Translation[trUnit] := 'Unit';
  Translation[trUnits] := 'Units';
  Translation[trVariables] := 'Variable';
  Translation[trWarningOverwrite] :=
    'Advarsel: Editer ikke denne fil, den er autogeneret og vil sansylgvis blive overskret';

  Translation[trHeadlineCio] := 'Alle Klasesr, Interfaces og Objekter';
  Translation[trHeadlineConstants] := 'Alle Konstanter';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'Alle Functioner and Procedurer';
  Translation[trHeadlineIdentifiers] := 'Alle Identifiers';
  Translation[trHeadlineTypes] := 'Alle Typer';
  Translation[trHeadlineUnits] := 'Alle Units';
  Translation[trHeadlineVariables] := 'Alle Variable';

  Translation[trSummaryCio] :=
    'Oversigt over klasser, interfaces & objekter';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageDutch;
begin
  Translation[trAuthor] := 'Auteur';
  Translation[trAuthors] := 'Auteurs';
  Translation[trCio] := 'Classes, interfaces and objecten';
  Translation[trClass] := 'Class';
  Translation[trClasses] := 'Classes';
  Translation[trConstants] := 'Constanten';
  Translation[trCreated] := 'Gemaakt';
  Translation[trDeclaration] := 'Declaratie';
  Translation[trDescription] := 'Omschrijving';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'Velden';
  Translation[trFunctionsAndProcedures] := 'Functies en procedures';
  Translation[trHelp] := 'Help';
  Translation[trHierarchy] := 'Hierarchie';
  Translation[trIdentifiers] := 'Identifiers';
  Translation[trInterface] := 'Interface';
  Translation[trLastModified] := 'Laatste wijziging';
  Translation[trLegend] := 'Legend';
  Translation[trMethods] := 'Methods';
  Translation[trName] := 'Naam';
  Translation[trNone] := 'Geen';
  Translation[trObject] := 'Object';
  Translation[trObjects] := 'Objecten';
  Translation[trOverview] := 'Overzicht';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := 'Eigenschappen';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trType] := 'Type';
  Translation[trTypes] := 'Typen';
  Translation[trUnit] := 'Unit';
  Translation[trUnits] := 'Units';
  Translation[trVariables] := 'Variabelen';
  Translation[trWarningOverwrite] :=
    'Waarschuwing, wijzig niets - dit bestand is automatisch gegenereerd en zal worden overschreven';

  Translation[trHeadlineCio] := 'Alle classes, interfaces en objecten';
  Translation[trHeadlineConstants] := 'Alle constanten';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'Alle functies en procedures';
  Translation[trHeadlineIdentifiers] := 'Alle identifiers';
  Translation[trHeadlineTypes] := 'Alle typen';
  Translation[trHeadlineUnits] := 'Alle units';
  Translation[trHeadlineVariables] := 'Alle variabelen';

  Translation[trSummaryCio] :=
    'Overzicht van classes, interfaces & objecten';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageFrench;
begin
  Translation[trAuthor] := 'Auteur';
  Translation[trAuthors] := 'Auteurs';
  Translation[trCio] := 'Classes, interfaces and objects';
  Translation[trClass] := 'Classe';
  Translation[trClasses] := 'Classes';
  Translation[trConstants] := 'Constantes';
  Translation[trCreated] := 'Cr�e';
  Translation[trDeclaration] := 'D�claration';
  Translation[trDescription] := 'Description';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'Champs';
  Translation[trFunctionsAndProcedures] := 'Fonctions et proc�dures';
  Translation[trHelp] := 'Help';
  Translation[trHierarchy] := 'Hierarchy';
  Translation[trIdentifiers] := 'Identificateurs';
  Translation[trInterface] := 'Interface';
  Translation[trLastModified] := 'Derni�re modification';
  Translation[trLegend] := 'Legend';
  Translation[trMethods] := 'M�thodes';
  Translation[trName] := 'Nom';
  Translation[trNone] := 'Aucun(e)(s)';
  Translation[trObject] := 'Objet';
  Translation[trObjects] := 'Objets';
  Translation[trOverview] := 'Aper�u';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := 'Propri�t�s';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trType] := 'Type';
  Translation[trTypes] := 'Types';
  Translation[trUnit] := 'Unit�';
  Translation[trUnits] := 'Unit�s';
  Translation[trVariables] := 'Variables';
  Translation[trWarningOverwrite] :=
    'Attention, ne pas �dtier - ce fichier est cr�� automatiquement et va �tre �cras�';

  Translation[trHeadlineCio] := 'Toutes les classes, interfaces et objets';
  Translation[trHeadlineConstants] := 'Toutes les constants';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'Toutes les fonctions et proc�dures';
  Translation[trHeadlineIdentifiers] := 'Tous les identificateurs';
  Translation[trHeadlineTypes] := 'Tous les types';
  Translation[trHeadlineUnits] := 'Toutes les unit�s';
  Translation[trHeadlineVariables] := 'Toutes les variables';

  Translation[trSummaryCio] := 'Classes, interfaces & objets';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageGerman;
begin
  Translation[trAuthor] := 'Autor';
  Translation[trAuthors] := 'Autoren';
  Translation[trCio] := 'Klassen, Schnittstellen und Objekte';
  Translation[trClass] := 'Klasse';
  Translation[trClasses] := 'Klassen';
  Translation[trClassHierarchy] := 'Klassenhierarchie';
  Translation[trConstants] := 'Konstanten';
  Translation[trCreated] := 'Erstellt';
  Translation[trDeclaration] := 'Deklaration';
  Translation[trDescription] := 'Beschreibung';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'Felder';
  Translation[trFunctionsAndProcedures] := 'Funktionen und Prozeduren';
  Translation[trHelp] := 'Hilfe';
  Translation[trHierarchy] := 'Hierarchie';
  Translation[trIdentifiers] := 'Bezeichner';
  Translation[trInterface] := 'Schnittstelle';
  Translation[trLastModified] := 'Letzte �nderung';
  Translation[trLegend] := 'Legende';
  Translation[trMethods] := 'Methoden';
  Translation[trName] := 'Name';
  Translation[trNone] := 'Keine';
  Translation[trObject] := 'Objekt';
  Translation[trObjects] := 'Objekte';
  Translation[trOverview] := '�bersicht';
  Translation[trPrivate] := 'Privat';
  Translation[trProperties] := 'Eigenschaften';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trTypes] := 'Typen';
  Translation[trUnit] := 'Unit';
  Translation[trUnits] := 'Units';
  Translation[trVariables] := 'Variablen';
  Translation[trType] := 'Typ';
  Translation[trTypes] := 'Typen';

  Translation[trHeadlineCio] := 'Alle Klassen, Schnittstellen und Objekte';
  Translation[trHeadlineConstants] := 'Alle Konstanten';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'Alle Funktionen und Prozeduren';
  Translation[trHeadlineIdentifiers] := 'Alle Bezeichner';
  Translation[trHeadlineTypes] := 'Alle Typen';
  Translation[trHeadlineUnits] := 'Alle Units';
  Translation[trHeadlineVariables] := 'Alle Variablen';

  Translation[trWarningOverwrite] :=
    'Achtung: Nicht �ndern - diese Datei wurde automatisch erstellt und wird m�glicherweise �berschrieben';

  Translation[trGeneratedBy] := 'Erstellt von';
  Translation[trOnDateTime] := 'am';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageIndonesian;
begin
  Translation[trAuthor] := 'Pembuat';
  Translation[trAuthors] := 'Pembuat';
  Translation[trCio] := 'Kelas, Interface, dan Objek';
  Translation[trClass] := 'Kelas';
  Translation[trClasses] := 'Kelas';
  Translation[trConstants] := 'Konstanta';
  Translation[trCreated] := 'Dibuat';
  Translation[trDeclaration] := 'Deklarasi';
  Translation[trDescription] := 'Definisi';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'Field';
  Translation[trFunctionsAndProcedures] := 'Fungsi dan Prosedur';
  Translation[trHelp] := 'Bantuan';
  Translation[trHierarchy] := 'Hirarki';
  Translation[trIdentifiers] := 'Identifier';
  Translation[trInterface] := 'Interface';
  Translation[trLegend] := 'Legenda';
  Translation[trMethods] := 'Method';
  Translation[trLastModified] := 'Terakhir Dimodifikasi';
  Translation[trName] := 'Nama';
  Translation[trNone] := 'Tidak Ada';
  Translation[trObject] := 'Objek';
  Translation[trObjects] := 'Objek';
  Translation[trOverview] := 'Sekilas';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := 'Property';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trType] := 'Tipe Bentukan';
  Translation[trTypes] := 'Tipe Bentukan';
  Translation[trUnit] := 'Unit';
  Translation[trUnits] := 'Unit';
  Translation[trVariables] := 'Variabel';

  Translation[trHeadlineCio] := 'Semua Kelas, Interface, dan Objek';
  Translation[trHeadlineConstants] := 'Semua Konstanta';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'Semua Fungsi dan Prosedur';
  Translation[trHeadlineIdentifiers] := 'Semua Identifier';
  Translation[trHeadlineTypes] := 'Semua Tipe Bentukan';
  Translation[trHeadlineUnits] := 'Semua Unit';
  Translation[trHeadlineVariables] := 'Semua Variabel';

  Translation[trSummaryCio] := 'Ringkasan Kelas, Interface, dan Objek';

  Translation[trWarningOverwrite] := 'Perhatian: Jangan dimodifikasi - '
    + 'file ini dihasilkan secara otomatis dan mungkin saja ditimpa ulang';

  Translation[trGeneratedBy] := 'Dihasilkan oleh';
  Translation[trOnDateTime] := 'pada';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageItalian;
begin
  Translation[trAuthor] := 'Autore';
  Translation[trAuthors] := 'Autori';
  Translation[trCio] := 'Classi, Interfacce ed Oggetti';
  Translation[trClass] := 'Classe';
  Translation[trClasses] := 'Classi';
  Translation[trConstants] := 'Costanti';
  Translation[trCreated] := 'Creato';
  Translation[trDeclaration] := 'Dichiarazione';
  Translation[trDescription] := 'Descrizione';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'Campi';
  Translation[trFunctionsAndProcedures] := 'Funzioni e Procedure';
  Translation[trHelp] := 'Help';
  Translation[trHierarchy] := 'Gerarchia';
  Translation[trIdentifiers] := 'Identificatori';
  Translation[trInterface] := 'Interfacce';
  Translation[trLegend] := 'Legenda';
  Translation[trMethods] := 'Metodi';
  Translation[trLastModified] := 'Ultima Variazione';
  Translation[trName] := 'Nome';
  Translation[trNone] := 'Nessuno';
  Translation[trObject] := 'Oggetto';
  Translation[trObjects] := 'Oggetti';
  Translation[trOverview] := 'Sommario';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := 'Propriet�';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trType] := 'Tipo';
  Translation[trTypes] := 'Tipi';
  Translation[trUnit] := 'Unit';
  Translation[trUnits] := 'Units';
  Translation[trVariables] := 'Variabili';

  Translation[trHeadlineCio] := 'Tutte le Classi, Interfacce ed Oggetti';
  Translation[trHeadlineConstants] := 'Tutte le Costanti';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'Tutte le Funzioni e Procedure';
  Translation[trHeadlineIdentifiers] := 'Tutti gli Identificatori';
  Translation[trHeadlineTypes] := 'Tutti i Tipi';
  Translation[trHeadlineUnits] := 'Tutte le Units';
  Translation[trHeadlineVariables] := 'Tutte le Variabili';

  Translation[trSummaryCio] := 'Sommario di Classi, Interfacce ed Oggetti';

  Translation[trWarningOverwrite] :=
    'Attenzione: Non modificare - questo file � stato generato automaticamente e verr� probabilmente sovrascritto';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageJavanese;
begin
  Translation[trAuthor] := 'Sing Nggawe';
  Translation[trAuthors] := 'Sing Nggawe';
  Translation[trCio] := 'Kelas, Interface, lan Objek';
  Translation[trClass] := 'Kelas';
  Translation[trClasses] := 'Kelas';
  Translation[trConstants] := 'Konstanta';
  Translation[trCreated] := 'Digawe';
  Translation[trDeclaration] := 'Deklarasi';
  Translation[trDescription] := 'Katrangan';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'Field';
  Translation[trFunctionsAndProcedures] := 'Fungsi lan Prosedur';
  Translation[trHelp] := 'Tulung';
  Translation[trHierarchy] := 'Hirarki';
  Translation[trIdentifiers] := 'Identifier';
  Translation[trInterface] := 'Interface';
  Translation[trLegend] := 'Katrangan';
  Translation[trMethods] := 'Method';
  Translation[trLastModified] := 'Terakhir Diowahi';
  Translation[trName] := 'Jeneng';
  Translation[trNone] := 'Mboten Wonten';
  Translation[trObject] := 'Objek';
  Translation[trObjects] := 'Objek';
  Translation[trOverview] := 'Pambuka';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := 'Property';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trType] := 'Macem Gawean';
  Translation[trTypes] := 'Macem Gawean';
  Translation[trUnit] := 'Unit';
  Translation[trUnits] := 'Unit';
  Translation[trVariables] := 'Variabel';

  Translation[trHeadlineCio] := 'Kabeh Kelas, Interface, lan Objek';
  Translation[trHeadlineConstants] := 'Kabeh Konstanta';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'Kabeh Fungsi lan Prosedur';
  Translation[trHeadlineIdentifiers] := 'Kabeh Identifier';
  Translation[trHeadlineTypes] := 'Kabeh Macem Gawean';
  Translation[trHeadlineUnits] := 'Kabeh Unit';
  Translation[trHeadlineVariables] := 'Kabeh Variabel';

  Translation[trSummaryCio] := 'Ringkesan Kelas, Interface, lan Objek';

  Translation[trWarningOverwrite] := 'Ati-ati: Ojo diowahi - '
    + 'file iki digawe otomatis dadi iso ilang owahanmu';

  Translation[trGeneratedBy] := 'Dihasilne karo';
  Translation[trOnDateTime] := 'ing';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguagePolish;
begin
  Translation[trAuthor] := 'Autor';
  Translation[trAuthors] := 'Autorzy';
  Translation[trCio] := 'Klasy, Interfejsy i Obiekty';
  Translation[trClass] := 'Klasa';
  Translation[trClasses] := 'Klasy';
  Translation[trConstants] := 'Sta�e';
  Translation[trCreated] := 'Utworzony';
  Translation[trDeclaration] := 'Deklaracja';
  Translation[trDescription] := 'Opis';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'Pola';
  Translation[trFunctionsAndProcedures] := 'Funkcje i Procedury';
  Translation[trHelp] := 'Pomoc';
  Translation[trHierarchy] := 'Hierarchia';
  Translation[trIdentifiers] := 'Identyfikatory';
  Translation[trInterface] := 'Interfejs';
  Translation[trLegend] := 'Legenda';
  Translation[trMethods] := 'Metody';
  Translation[trLastModified] := 'Ostatnia modyfikacja';
  Translation[trName] := 'Nazwa';
  Translation[trNone] := 'Brak';
  Translation[trObject] := 'Obiekt';
  Translation[trObjects] := 'Obiekty';
  Translation[trOverview] := 'Przegl�d';
  Translation[trPrivate] := 'Prywatne';
  Translation[trProperties] := 'W�a�ciwo�ci';
  Translation[trProtected] := 'Chronione';
  Translation[trPublic] := 'Publiczne';
  Translation[trPublished] := 'Publikowane';
  Translation[trType] := 'Typ';
  Translation[trTypes] := 'Typy';
  Translation[trUnit] := 'Modu�';
  Translation[trUnits] := 'Modu�y';
  Translation[trVariables] := 'Zmienne';

  Translation[trHeadlineCio] := 'Wszystkie Klasy, Interfejsy i Obiekty';
  Translation[trHeadlineConstants] := 'Wszystkie Sta�e';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'Wszystkie Funkcje i Procedury';
  Translation[trHeadlineIdentifiers] := 'Wszystkie Identyfikatory';
  Translation[trHeadlineTypes] := 'Wszystkie typy';
  Translation[trHeadlineUnits] := 'Wszystkie modu�y';
  Translation[trHeadlineVariables] := 'Wszystkie zmienne';

  Translation[trSummaryCio] := 'Strzeszczenie Klas, Interfejs�w i Obiekt�w';

  Translation[trWarningOverwrite] :=
    'Uwaga, nie edytuj - ten plik zosta� wygenerowany przez automat i mo�e zosta� nadpisany';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageRussian_1251;
begin
  Translation[trAuthor] := '�����';
  Translation[trAuthors] := '������';
  Translation[trCio] := '������, ���������� � �������';
  Translation[trClass] := '�����';
  Translation[trClasses] := '������';
  Translation[trConstants] := '���������';
  Translation[trCreated] := '�������';
  Translation[trDeclaration] := '����������';
  Translation[trDescription] := '��������';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := '����';
  Translation[trFunctionsAndProcedures] := '��������� � �������';
  Translation[trHelp] := 'Help';
    // Untranslated to avoid Russian file name for css
  Translation[trHierarchy] := '��������';
  Translation[trIdentifiers] := '��������������';
  Translation[trInterface] := '���������';
  Translation[trLegend] := '�����������';
  Translation[trLastModified] := '��������� ���������';
  Translation[trMethods] := '������';
  Translation[trName] := '���';
  Translation[trNone] := '���';
  Translation[trObject] := '������';
  Translation[trObjects] := '�������';
  Translation[trOverview] := '�����';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := '��������';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trType] := '���';
  Translation[trTypes] := '����';
  Translation[trUnit] := '������';
  Translation[trUnits] := '������';
  Translation[trVariables] := '����������';
  Translation[trWarningOverwrite] :=
    '��������������: �� ������������� - ���� ���� ������ ������������� � ����� ���� ������ ��� ��������������';

  Translation[trHeadlineCio] := '��� ������, ���������� � �������';
  Translation[trHeadlineConstants] := '��� ���������';
  Translation[trHeadlineFunctionsAndProcedures] := '��� ��������� � �������';
  Translation[trHeadlineIdentifiers] := '��� ��������������';
  Translation[trHeadlineTypes] := '��� ����';
  Translation[trHeadlineUnits] := '��� ������';
  Translation[trHeadlineVariables] := '��� ����������';

  Translation[trSummaryCio] := '������ �������, ����������� � ��������';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageRussian_866;
begin
  Translation[trAuthor] := '����';
  Translation[trAuthors] := '�����';
  Translation[trCio] := '������, ����䥩�� � ��ꥪ��';
  Translation[trClass] := '�����';
  Translation[trClasses] := '������';
  Translation[trConstants] := '����⠭��';
  Translation[trCreated] := '�������';
  Translation[trDeclaration] := '�������';
  Translation[trDescription] := '���ᠭ��';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := '����';
  Translation[trFunctionsAndProcedures] := '��楤��� � �㭪樨';
  Translation[trHelp] := 'Help';
    // Untranslated to avoid Russian file name for css
  Translation[trHierarchy] := '������';
  Translation[trIdentifiers] := '�����䨪����';
  Translation[trInterface] := '����䥩�';
  Translation[trLegend] := '������祭��';
  Translation[trLastModified] := '��᫥���� ���������';
  Translation[trMethods] := '��⮤�';
  Translation[trName] := '���';
  Translation[trNone] := '���';
  Translation[trObject] := '��ꥪ�';
  Translation[trObjects] := '��ꥪ��';
  Translation[trOverview] := '�����';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := '�����⢠';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trType] := '���';
  Translation[trTypes] := '����';
  Translation[trUnit] := '�����';
  Translation[trUnits] := '���㫨';
  Translation[trVariables] := '��६����';
  Translation[trWarningOverwrite] :=
    '�।�०�����: �� ।���஢��� - ��� 䠩� ᮧ��� ��⮬���᪨ � ����� ���� ������ ��� �।�०�����';

  Translation[trHeadlineCio] := '�� ������, ����䥩�� � ��ꥪ��';
  Translation[trHeadlineConstants] := '�� ����⠭��';
  Translation[trHeadlineFunctionsAndProcedures] := '�� ��楤��� � �㭪樨';
  Translation[trHeadlineIdentifiers] := '�� �����䨪����';
  Translation[trHeadlineTypes] := '�� ⨯�';
  Translation[trHeadlineUnits] := '�� ���㫨';
  Translation[trHeadlineVariables] := '�� ��६����';

  Translation[trSummaryCio] := '���᮪ ����ᮢ, ����䥩ᮢ � ��ꥪ⮢';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageRussian_koi8;
begin
  Translation[trAuthor] := '�����';
  Translation[trAuthors] := '������';
  Translation[trCio] := '������, ���������� � �������';
  Translation[trClass] := '�����';
  Translation[trClasses] := '������';
  Translation[trConstants] := '���������';
  Translation[trCreated] := '�������';
  Translation[trDeclaration] := '����������';
  Translation[trDescription] := '��������';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := '����';
  Translation[trFunctionsAndProcedures] := '��������� � �������';
  Translation[trHelp] := 'Help';
    // Untranslated to avoid Russian file name for css
  Translation[trHierarchy] := '��������';
  Translation[trIdentifiers] := '��������������';
  Translation[trInterface] := '���������';
  Translation[trLegend] := '�����������';
  Translation[trLastModified] := '��������� ���������';
  Translation[trMethods] := '������';
  Translation[trName] := '���';
  Translation[trNone] := '���';
  Translation[trObject] := '������';
  Translation[trObjects] := '�������';
  Translation[trOverview] := '�����';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := '��������';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trType] := '���';
  Translation[trTypes] := '����';
  Translation[trUnit] := '������';
  Translation[trUnits] := '������';
  Translation[trVariables] := '����������';
  Translation[trWarningOverwrite] :=
    '��������������: �� ������������� - ���� ���� ������ ������������� � ����� ���� ����Σ� ��� ��������������';

  Translation[trHeadlineCio] := '��� ������, ���������� � �������';
  Translation[trHeadlineConstants] := '��� ���������';
  Translation[trHeadlineFunctionsAndProcedures] := '��� ��������� � �������';
  Translation[trHeadlineIdentifiers] := '��� ��������������';
  Translation[trHeadlineTypes] := '��� ����';
  Translation[trHeadlineUnits] := '��� ������';
  Translation[trHeadlineVariables] := '��� ����������';

  Translation[trSummaryCio] := '������ �������, ����������� � ��������';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageSlovak;
begin
  Translation[trAuthor] := 'Autor';
  Translation[trAuthors] := 'Autori';
  Translation[trCio] := 'Triedy, interfejsy a objekty';
  Translation[trClass] := 'Trieda';
  Translation[trClasses] := 'Triedy';
  Translation[trConstants] := 'Kon�tanty';
  Translation[trCreated] := 'Vytvoren�';
  Translation[trDeclaration] := 'Deklar�cie';
  Translation[trDescription] := 'Popis';
  Translation[trFields] := 'Polo�ky';
  Translation[trFunctionsAndProcedures] := 'Funkcie a proced�ry';
  Translation[trHierarchy] := 'Hierarchia';
  Translation[trIdentifiers] := 'Identifik�tory';
  Translation[trInterface] := 'Interfejs';
  Translation[trLastModified] := 'Posledn� zmena';
  Translation[trMethods] := 'Met�dy';
  Translation[trName] := 'Meno';
  Translation[trNone] := 'Ni�';
  Translation[trObject] := 'Objekt';
  Translation[trObjects] := 'Objekty';
  Translation[trOverview] := 'Overview';
  Translation[trProperties] := 'Mo�nosti';
  Translation[trType] := 'Typ';
  Translation[trTypes] := 'Typy';
  Translation[trUnit] := 'Jednotka';
  Translation[trUnits] := 'Jednotky';
  Translation[trVariables] := 'Premenn�';
  Translation[trWarningOverwrite] :=
    'Upozornenie: Needitujte - tento s�bor bol vytvoren� automaticky a je pravdepodobn�, �e bude prep�san�';

  Translation[trHeadlineCio] := 'V�etky triedy, interfejsy a objekty';
  Translation[trHeadlineConstants] := 'V�etky kon�tanty';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'V�etky funkcie a proced�ry';
  Translation[trHeadlineIdentifiers] := 'V�etky identifik�tory';
  Translation[trHeadlineTypes] := 'V�etky typy';
  Translation[trHeadlineUnits] := 'V�etky jednotky';
  Translation[trHeadlineVariables] := 'V�etky premenn�';

  Translation[trSummaryCio] := 'Zoznam tried, interfejsov a objektov';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageSpanish;
begin
  Translation[trAuthor] := 'Autor';
  Translation[trAuthors] := 'Autores';
  Translation[trCio] := 'Clases, interfaces y objetos';
  Translation[trClass] := 'Clase';
  Translation[trClasses] := 'Clases';
  Translation[trConstants] := 'Constantes';
  Translation[trCreated] := 'Creado';
  Translation[trDeclaration] := 'Declaraci�n';
  Translation[trDescription] := 'Descripcion';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'Campos';
  Translation[trFunctionsAndProcedures] := 'Funciones y procedimientos';
  Translation[trHelp] := 'Help';
  Translation[trHierarchy] := 'Hierarchy';
  Translation[trIdentifiers] := 'Identificadores';
  Translation[trInterface] := 'Interface';
  Translation[trLegend] := 'Legend';
  Translation[trLastModified] := '�ltima modificaci�n';
  Translation[trMethods] := 'M�todos';
  Translation[trName] := 'Nombre';
  Translation[trNone] := 'Ninguno';
  Translation[trObject] := 'Objeto';
  Translation[trObjects] := 'Objetos';
  Translation[trOverview] := 'Resumen';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := 'Propiedades';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trUnit] := 'Unidad';
  Translation[trUnits] := 'Unidades';
  Translation[trType] := 'Tipo';
  Translation[trTypes] := 'Tipos';
  Translation[trVariables] := 'Variables';
  Translation[trWarningOverwrite] :=
    'Atenci�n, no editar - este fichero ha sido creado automaticamente y ser�sobrescrito';

  Translation[trHeadlineCio] := 'Todas las clases, interfaces y objetos';
  Translation[trHeadlineConstants] := 'Todas las constantes';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'Todos las funciones y procedimientos';
  Translation[trHeadlineIdentifiers] := 'Todos los indentificadores';
  Translation[trHeadlineTypes] := 'Todos los tipos';
  Translation[trHeadlineUnits] := 'Todas las unidades';
  Translation[trHeadlineVariables] := 'Todas las variables';

  Translation[trSummaryCio] := 'Lista de clases, interfaces y objetos';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

{ ---------------------------------------------------------------------------- }

procedure SetLanguageSwedish;
begin
  Translation[trAuthor] := 'F�rfattare';
  Translation[trAuthors] := 'F�rfattare';
  Translation[trCio] := 'Klasser, interface och objekt';
  Translation[trClass] := 'Klass';
  Translation[trClasses] := 'Klasser';
  Translation[trConstants] := 'Constants';
  Translation[trCreated] := 'Skapad';
  Translation[trDeclaration] := 'Deklarationer';
  Translation[trDescription] := 'Beskrivning';
  Translation[trDispInterface] := 'DispInterface';
  Translation[trFields] := 'F�lt';
  Translation[trFunctionsAndProcedures] := 'Functions and Procedures';
  Translation[trHelp] := 'Help';
    // Untranslated to avoid Swedish file name for css
  Translation[trHierarchy] := 'Hierarki';
  Translation[trIdentifiers] := 'Identifiers';
  Translation[trInterface] := 'Interface';
  Translation[trLegend] := 'F�rklaring';
  Translation[trMethods] := 'Metoder';
  Translation[trLastModified] := 'Senast �ndrad';
  Translation[trName] := 'Namn';
  Translation[trNone] := 'Ingen/inget.';
  Translation[trObject] := 'Objekt';
  Translation[trObjects] := 'Objekt';
  Translation[trOverview] := '�versikt';
  Translation[trPrivate] := 'Private';
  Translation[trProperties] := 'Properties';
  Translation[trProtected] := 'Protected';
  Translation[trPublic] := 'Public';
  Translation[trPublished] := 'Published';
  Translation[trType] := 'Typer';
  Translation[trTypes] := 'Typer';
  Translation[trUnit] := 'Enhet';
  Translation[trUnits] := 'Enheter';
  Translation[trVariables] := 'Variabler';

  Translation[trHeadlineCio] := 'Alla klasser, interface och objekt';
  Translation[trHeadlineConstants] := 'All Constants';
  Translation[trHeadlineFunctionsAndProcedures] :=
    'Alla funktioner och procedurer';
  Translation[trHeadlineIdentifiers] := 'Alla identifierare';
  Translation[trHeadlineTypes] := 'Alla typer';
  Translation[trHeadlineUnits] := 'Alla enheter';
  Translation[trHeadlineVariables] := 'Alla variabler';

  Translation[trSummaryCio] :=
    'Sammanfattning av Klasser, Interface, Objekt';

  Translation[trWarningOverwrite] :=
    'Varning: �ndra inte denna fil manuellt - filen har skapats automatiskt och kommer troligen att skrivas �ver vid ett senare tilf�lle';

  // Please translate
  // Translation[trGeneratedBy] := 'Generated by';
  // Translation[trOnDateTime] := 'on';
end;

end.
