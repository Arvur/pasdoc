{ @abstract(Provides Latex document generator object.)
  @cvs($Date$)

  Implements an object to generate latex documentation, overriding many of
  @link(TDocGenerator)'s virtual methods. }

unit PasDoc_GenLatex;

interface

uses
  PasDoc_Gen,
  PasDoc_Items,
  PasDoc_Languages,
  StringVector,
  PasDoc_Types,
  Classes;

type
  { @abstract(generates latex documentation)
    Extends @link(TDocGenerator) and overwrites many of its methods to generate
    output in laTex (HyperText Markup Language) format.
    This type of output is well suited to be read with a web browser at the
    computer, as a reference manual that does not have to be printed.
    For printed output, use @link(Tex.TTexDocGenerator). }
  TTexDocGenerator = class(TDocGenerator)
  protected
    FNumericFilenames: boolean;
    FWriteUses: boolean;
    FLinkCount: Integer;
    FFooter: string;
    FHeader: string;
    FOddTableRow: Integer;
    { number of cells (= columns) per table row }
    NumCells: Integer;
    { number of cells we've already written in current table row }
    CellCounter: LongInt;
    
    { Contains Name of a file to read HtmlHelp Contents from.
      If empty, create default contents file. }
    FContentsFile: string;
    { Writes information on doc generator to current output stream,
      including link to pasdoc homepage. }
    procedure WriteAppInfo;
    { Writes authors to output, at heading level HL. Will not write anything
      if collection of authors is not assigned or empty. }
    procedure WriteAuthors(HL: integer; Authors: TStringVector);
    procedure WriteCodeWithLinks(const p: TPasItem; const Code: string; const
      ItemLink: string);
    { Writes an empty table cell, '&nbsp;'. }
    procedure WriteEmptyCell;

    procedure WriteEndOfDocument;
    { Finishes an HTML paragraph element by writing a closing P tag. }
    procedure WriteEndOfParagraph;
    { Finishes an HTML table cell by writing a closing TD tag. }
    procedure WriteEndOfTableCell;
    { Finishes an HTML table by writing a closing TABLE tag. }
    procedure WriteEndOfTable;
    { Finishes an HTML table row by writing a closing TR tag. }
    procedure WriteEndOfTableRow;
    procedure WriteFields(const Order: integer; const Fields: TPasItems);
    procedure WriteFooter;
    { Writes a Hireachy list - this is more useful than the simple class list }
    procedure WriteHierarchy;
    procedure WriteItemDescription(const AItem: TPasItem);
    { Writes the Item's DetailedDescription. If the Item also has Discription
      (extracted from @@abstract), this is written to a separate paragraph
      in front of the DetailedDescription. }
    procedure WriteItemDetailedDescription(const AItem: TPasItem);
    procedure WriteOverviewFiles;
    procedure WriteParagraph(HL: integer; s: string; t: string);
    procedure WritePropertiesSummary(HL: integer; p: TPasProperties);

    { Writes an opening A element, including a name attribute given by the
      argument. }
    procedure WriteStartOfDocument(AName: string);

    { Starts an HTML paragraph element by writing an opening P tag. }
    procedure WriteStartOfParagraph;

    procedure WriteStartOfTableCell; overload;
    procedure WriteStartOfTableCell(const css: string); overload;
    procedure WriteStartOfTableCell(const Params, css: string); overload;
    
    procedure WriteStartOfTable1Column(t: string);
    procedure WriteStartOfTable2Columns(t1, t2: string);
    procedure WriteStartOfTable3Columns(t1, t2, T3: string);
    procedure WriteStartOfTableRow(const CssClass: string);

    { Creates an output stream that lists up all units and short descriptions. }
    procedure WriteUnitOverviewFile;
    { Writes a cell into a table row with the Item's visibility image. }
    procedure WriteVisibilityCell(const Item: TPasItem);

    { Called by @link(ConvertString) to convert a character.
      Will convert special characters to their html escape sequence
      -> test }
    function ConvertString(const s: string): string; override;

    procedure WriteUnit(const HL: integer; const U: TPasUnit); override;
    procedure WriteUnitUses(const HL: integer; U: TPasUnit);
    procedure WriteUnitDescription(HL: integer; U: TPasUnit); override;
    procedure WriteProperties(HL: integer; const p: TPasProperties); override;

    procedure WriteSpellChecked(const AString: string);

    procedure WriteWithURLs(s: string);
    { Return the text within the parentheses after the @HTML field.  The user
      is required to provided correctly formatted html text within the
      parentheses  and to have matching parentheses.  If no parentheses are found
      after @HTML, the string '@HTML' is returned instead. }
    function HtmlString(const Desc: string; Len: integer; var CurPos: integer): string; override;

    { Makes a String look like a coded String, i.e. <CODE>TheString</CODE>
      in Html. }
    function CodeString(const s: string): string; override;
    { Returns a link to an anchor within a document. HTML simply concatenates
      the strings with a "-" character between them. }
    function CreateLink(const Item: TPasItem): string; override;
    { Creates a valid HTML link, starting with an anchor that points to Link,
      encapsulating the text ItemName in it. }
    function CreateReferencedLink(ItemName, Link: string): string; override;
    { Returns HTML file extension ".htm". }
    function GetFileExtension: string; override;
    { Writes a single class, interface or object CIO to output, at heading
      level HL. }
    procedure WriteCIO(HL: integer; const CIO: TPasCio); override;
    { Calls @link(WriteCIO) with each element in the argument collection C,
      using heading level HL. }
    procedure WriteCIOs(HL: integer; c: TPasItems); override;
    procedure WriteCIOSummary(HL: integer; c: TPasItems); override;
    { Writes dates Created and LastMod at heading level HL to output
      (if at least one the two has a value assigned). }
    procedure WriteDates(const HL: integer; const Created, LastMod: string); override;
    procedure WriteStartOfCode; override;
    procedure WriteItems(HL: integer; Heading: string; const Anchor: string;
      const i: TPasItems); override;
    { Writes heading S to output, at heading level I.
      For HTML, only levels 1 to 6 are valid, so that values smaller
      than 1 will be set to 1 and arguments larger than 6 are set to 6.
      The String S will then be enclosed in an element from H1 to H6,
      according to the level. }
    procedure WriteHeading(Level: integer; const s: string); override;

    procedure WriteEndOfCode; override;
    { Writes information on functions and procedures or methods of a unit or
      class, interface or object to output.
      If argument Methods is true, they will be considered methods of a class,
      interface or object, otherwise they're considered functions or procedures
      of a unit.
      The functions are stored in the FuncsProcs argument. }
      procedure WriteFuncsProcs(const HL: integer; const FuncsProcs: TPasMethods);
      
    { Writes information on functions and procedures or methods of a unit or
      class, interface or object to output.
      If argument Methods is true, they will be considered methods of a class,
      interface or object, otherwise they're considered functions or procedures
      of a unit.
      The functions are stored in the FuncsProcs argument. }
    procedure WriteMethods(const HL: integer; const FuncsProcs: TPasMethods); 
    procedure WriteMethodsSummary(const HL: integer; const FuncsProcs: TPasMethods); 
    procedure WriteFuncsProcsSummary(const HL: integer; const FuncsProcs: TPasMethods);

    { output all the necessary images }
    procedure WriteBinaryFiles;

    { write the legend file for visibility markers }
    procedure WriteVisibilityLegendFile;
    procedure WriteImage(const src, alt, css: string);
    procedure WriteLink(const href, caption, css: string); overload;
    procedure WriteLink(const href, caption, css, target: string); overload;
    procedure WriteAnchor(ItemName, Link: string);
  public
    { The method that does everything - writes documentation for all units
      and creates overview files. }
    procedure WriteDocumentation; override;
    procedure LoadFooterFromFile(const AFileName: string);
    procedure LoadHeaderFromFile(const AFileName: string);
    procedure BuildLinks; override;

    function EscapeURL(const AString: string): string; virtual;
  published
    property ContentsFile: string read FContentsFile write FContentsFile;
    property Header: string read FHeader write FHeader;
    property Footer: string read FFooter write FFooter;
    property NumericFilenames: boolean read FNumericFilenames write FNumericFilenames;
    property WriteUsesClause: boolean read FWriteUses write FWriteUses;
   private
    procedure WriteParameter(const ParamName: string; const Desc: string);
    procedure WriteParamsOrRaises(Func: TPasMethod; const Caption: string;
      List: TStringVector);
    procedure WriteReturnDesc(Func: TPasMethod; ReturnDesc: string);
  end;

{$INCLUDE automated.inc}
{$INCLUDE private.inc}
{$INCLUDE public.inc}
{$INCLUDE published.inc}
{$INCLUDE protected.inc}

const
  { HTML table padding inside each cell. }
  HTML_TABLE_CELLPADNG = '4';
  { HTML table spacing between cells. }
  HTML_TABLE_CELLSPACING = '2';

implementation

uses
  SysUtils,
  PasDoc,
  ObjectVector,
  StreamUtils,
  Utils,
  PasDoc_Tokenizer,
  PasDoc_HierarchyTree;
  
type
  TCIONames = array[TCIOType] of string;

const
  CIO_NAMES: TCIONames = (
    'class',
    'dispinterface',
    'interface',
    'object',
    'record',
    'packed record');


{ HTML things to be customized:
    - standard background color (white)
    - background color for table headings and overview list at the top of each file (light gray)
    - background color for normal table cells (light gray, slightly lighter than the above)
    - standard foreground color (black)
    - unused link color (blue)
    - used link color (purple)
    - link color while being clicked on (red)
    - normal font (Times Roman)
    - heading font (Helvetica)
    - code font (Courier New) }

function TTexDocGenerator.HtmlString(const Desc: string; Len: integer; var CurPos: integer): string;
var
  ParenthesesLevel: integer;
  CharPos: integer;
begin
  CharPos := CurPos;
  if (CharPos > Len) or (Desc[CharPos] <> '(') then
  begin
    result := '@HTML';
  end
  else
  begin
    ParenthesesLevel := 1;
    while (ParenthesesLevel <> 0) and (CharPos <= Len) do
    begin
      Inc(CharPos);
      if Desc[CharPos] = '(' then
      begin
        Inc(ParenthesesLevel)
      end
      else if Desc[CharPos] = ')' then
      begin
        Dec(ParenthesesLevel)
      end;
    end;
    if ParenthesesLevel = 0 then
    begin
      result := Copy(Desc, CurPos + 1, CharPos - CurPos - 1);
      CurPos := CharPos + 1;
    end
    else
    begin
      result := '@HTML';
    end;
  end;
end;

function TTexDocGenerator.CodeString(const s: string): string;
begin
  Result := '\texttt{' + s + '}';
end;

function TTexDocGenerator.CreateLink(const Item: TPasItem): string;
  function NewLink(const AFullName: string): string;
  begin
    if NumericFilenames then begin
      Result := Format('%.8d', [FLinkCount]) + GetFileExtension;
      Inc(FLinkCount);
    end else begin
      Result := AFullName + GetFileExtension;
    end;
  end;

begin
  Result := '';
  if (not Assigned(Item)) then Exit;
  if Assigned(Item.MyUnit) then begin
    if Assigned(Item.MyObject) then begin
      { it's a method, a field or a property - only those have MyObject initialized }
      Result := Item.MyObject.FullLink + '-' + Item.Name;
    end else begin
      if Item.ClassType = TPasCio then begin
        { it's an object / a class }
        Result := NewLink(Item.MyUnit.Name + '.' + Item.Name);
      end else begin
        { it's a constant, a variable, a type or a function / procedure }
        Result := Item.MyUnit.FullLink + '-' + Item.Name;
      end;
    end;
  end else begin
    { it's a unit - only units don't have a MyUnit pointer }
    Result := NewLink(Item.Name);
  end;
end;

function TTexDocGenerator.CreateReferencedLink(ItemName, Link: string):
  string;
begin
  Result :=  '\texttt{'+ConvertString(ItemName) +'}(\ref{' + 
     EscapeURL(Link) + '})'; 
end;

function TTexDocGenerator.GetFileExtension: string;
begin
  Result := '.tex';
end;

procedure TTexDocGenerator.WriteAppInfo;
begin
  { check if user does not want a link to the pasdoc homepage }
  if NoGeneratorInfo then Exit;
  { write a horizontal line, pasdoc version and a link to the pasdoc homepage }
  WriteDirect('% '+FLanguage.Translation[trGeneratedBy] + ' ');
  WriteDirect(PASDOC_HOMEPAGE+ PASDOC_NAME_AND_VERSION);
  WriteDirect(' ' + FLanguage.Translation[trOnDateTime] + ' ' +
    FormatDateTime('yyyy-mm-dd hh:mm:ss', Now));
  WriteDirect('', true);
end;

procedure TTexDocGenerator.WriteAuthors(HL: integer; Authors: TStringVector);
var
  i: Integer;
  s, S1, S2: string;
  EmailAddress: string;
begin
  if StringVectorIsNilOrEmpty(Authors) then Exit;

  if (Authors.Count = 1) then
    WriteHeading(HL, FLanguage.Translation[trAuthor])
  else
    WriteHeading(HL, FLanguage.Translation[trAuthors]);

  for i := 0 to Authors.Count - 1 do begin
    s := Authors[i];
    WriteStartOfParagraph;

    if ExtractEmailAddress(s, S1, S2, EmailAddress) then begin
      WriteConverted(S1);
      WriteConverted(EmailAddress);
      WriteConverted(S2);
    end else begin
      WriteConverted(s);
    end;

    WriteEndOfParagraph;
  end;
end;

procedure TTexDocGenerator.WriteCIO(HL: integer; const CIO: TPasCio);
type
  TSections = (dsDescription, dsHierarchy, dsFields, dsMethods, dsProperties);
  TSectionSet = set of TSections;
const
  CIO_NAMES: TCIONames = (
    'class',
    'dispinterface',
    'interface',
    'object',
    'record',
    'packed record');
var
  i: Integer;
  s: string;
  Item: TPasItem;
  TheLink: string;
  SectionsAvailable: TSectionSet;
  SectionHeads: array[TSections] of string;
  Section: TSections;
  j: integer;
begin
  if not Assigned(CIO) then Exit;
  { write the complete definition }  
  WriteHeading(HL + 1, FLanguage.Translation[trDescription]);
  
  SectionHeads[dsDescription] := FLanguage.Translation[trDescription];
  SectionHeads[dsHierarchy] := FLanguage.Translation[trHierarchy];
  SectionHeads[dsFields ]:= FLanguage.Translation[trFields];
  SectionHeads[dsMethods ]:= FLanguage.Translation[trMethods];
  SectionHeads[dsProperties ]:= FLanguage.Translation[trProperties];

  SectionsAvailable := [dsDescription];
  if Assigned(CIO.Ancestors) and (CIO.Ancestors.Count > 0) then
    Include(SectionsAvailable, dsHierarchy);
  if not ObjectVectorIsNilOrEmpty(CIO.Fields) then
    Include(SectionsAvailable, dsFields);
  if not ObjectVectorIsNilOrEmpty(CIO.Methods) then
    Include(SectionsAvailable, dsMethods);
  if not ObjectVectorIsNilOrEmpty(CIO.Properties) then
    Include(SectionsAvailable, dsProperties);

  CIO.SortPasItems;

  WriteAnchor(CIO.Name,CIO.FullLink);
  WriteHeading(HL+2, CIO.Name);

(*  WriteDirect('<table class="sections"><tr>', true);
  for Section := Low(TSections) to High(TSections) do
    begin
      WriteDirect('<td>');
      if Section in SectionsAvailable then
        WriteLink('#'+SectionAnchors[Section], SectionHeads[Section], 'section')
      else
        WriteConverted(SectionHeads[Section]);
      WriteDirect('</td>');
    end;
  WriteDirect('</tr></table>', true);

  WriteAnchor(SectionAnchors[dsDescription]);

  { write unit link }
  if Assigned(CIO.MyUnit) then begin
    WriteHeading(HL + 1, FLanguage.Translation[trUnit]);
    WriteLink(CIO.MyUnit.FullLink, ConvertString(CIO.MyUnit.Name), 'bold');
    WriteDirect('<br/>');
  end;

  { write declaration link }
  WriteHeading(HL + 1, FLanguage.Translation[trDeclaration]);
  WriteStartOfParagraph;
  WriteStartOfCode;
  WriteConverted('type ' + CIO.Name + ' = ');
  WriteConverted(CIO_NAMES[CIO.MyType]);

  if not StringVectorIsNilOrEmpty(CIO.Ancestors) then begin
    WriteConverted('(');
    for i := 0 to CIO.Ancestors.Count - 1 do begin
      s := CIO.Ancestors[i];
      TheLink := SearchLink(s, CIO);
      if TheLink <> '' then
        s := TheLink;
      WriteDirect(s);
      if (i <> CIO.Ancestors.Count - 1) then
        WriteConverted(', ');
    end;
    WriteConverted(')');
  end;
  WriteEndOfCode;
  WriteEndOfParagraph;

  { Write Description }
  WriteHeading(HL + 1, FLanguage.Translation[trDescription]);
  WriteItemDetailedDescription(CIO);

  { Write Hierarchy }
  if Assigned(CIO.Ancestors) and (CIO.Ancestors.Count > 0) then begin
    WriteAnchor(SectionAnchors[dsHierarchy]);
    WriteHeading(HL + 1, SectionHeads[dsHierarchy]);

    WriteDirect(CIO.Name);
    WriteDirect('&nbsp;&gt; ');
    s := CIO.Ancestors.FirstName;
    Item := SearchItem(s, CIO);
    if Assigned(Item) and (Item is TPasCio) then begin
      repeat
        s := CreateReferencedLink(Item.Name, Item.FullLink);
        WriteDirect(s);

        if not StringVectorIsNilOrEmpty(TPasCio(Item).Ancestors) then begin
          s := TPasCio(Item).Ancestors.FirstName;
          Item := SearchItem(s, Item);

          WriteDirect('&nbsp;&gt; ');
          if (Item <> nil) and (Item is TPasCio) then begin
            Continue;
          end;
        end;
        Break;
      until False;
    end;
    if Item = nil then WriteDirect(s);
  end;

  WriteFields(HL + 1, CIO.Fields);

  WriteFuncsProcs(HL + 1, True, CIO.Methods);

  if (CIO.MyType in [CIO_CLASS, CIO_SPINTERFACE, CIO_INTERFACE]) then begin
    WritePropertiesSummary(HL + 1, CIO.Properties);
    WriteProperties(HL + 1, CIO.Properties);
  end;*)

  WriteAuthors(HL + 1, CIO.Authors);
  WriteDates(HL + 1, CIO.Created, CIO.LastMod);
end;

procedure TTexDocGenerator.WriteCIOs(HL: integer; c: TPasItems);
type
  TSections = (dsDescription, dsHierarchy, dsFields, dsMethods, dsProperties);
  TSectionSet = set of TSections;
var
  i,j: Integer;
  CIO: TPasCio;
  s: string;
  Item: TPasItem;
  TheLink: string;
  SectionsAvailable: TSectionSet;
  SectionHeads: array[TSections] of string;
  Section: TSections;
begin
  if c = nil then Exit;

  WriteHeading(HL, FLanguage.Translation[trCio]);

  for j := 0 to c.Count - 1 do 
    begin
      CIO := TPasCio(c.PasItemAt[j]);
      SectionHeads[dsDescription] := FLanguage.Translation[trDescription];
      SectionHeads[dsHierarchy] := FLanguage.Translation[trHierarchy];
      SectionHeads[dsFields ]:= FLanguage.Translation[trFields];
      SectionHeads[dsMethods ]:= FLanguage.Translation[trMethods];
      SectionHeads[dsProperties ]:= FLanguage.Translation[trProperties];

      SectionsAvailable := [dsDescription];
      if Assigned(CIO.Ancestors) and (CIO.Ancestors.Count > 0) then
        Include(SectionsAvailable, dsHierarchy);
      if not ObjectVectorIsNilOrEmpty(CIO.Fields) then
        Include(SectionsAvailable, dsFields);
      if not ObjectVectorIsNilOrEmpty(CIO.Methods) then
        Include(SectionsAvailable, dsMethods);
      if not ObjectVectorIsNilOrEmpty(CIO.Properties) then
        Include(SectionsAvailable, dsProperties);

      CIO.SortPasItems;

      WriteHeading(HL+1,CIO.Name+' '+ConvertString(GETCIOTypeName(CIO.MyType)));
      WriteAnchor(CIO.Name,CIO.FullLink);

      if dsHierarchy in SectionsAvailable then
        begin
          { Write Hierarchy }
          if Assigned(CIO.Ancestors) and (CIO.Ancestors.Count > 0) then 
            begin
              WriteHeading(HL + 2, SectionHeads[dsHierarchy]);

              WriteDirect(CIO.Name);
              WriteConverted(' > ');
              s := CIO.Ancestors.FirstName;
              Item := SearchItem(s, CIO);
              if Assigned(Item) and (Item is TPasCio) then 
                begin
                  repeat
                    s := CreateReferencedLink(Item.Name, Item.FullLink);
                    WriteDirect(s);

                    if not StringVectorIsNilOrEmpty(TPasCio(Item).Ancestors) then 
                      begin
                        s := TPasCio(Item).Ancestors.FirstName;
                        Item := SearchItem(s, Item);

                        WriteConverted(' > ');
                        if (Item <> nil) and (Item is TPasCio) then 
                          begin
                            Continue;
                          end;
                      end;
                      WriteDirect('',true);
                      Break;
                  until False;
                end;
                if Item = nil then 
                  begin
                    WriteDirect(s,true);
                  end;
            end;
        end;

      if dsDescription in SectionsAvailable then
        begin
          WriteHeading(HL + 2, SectionHeads[dsDescription]);
          WriteItemDetailedDescription(CIO);
        end;
        
      if (CIO.MyType in [CIO_CLASS, CIO_SPINTERFACE, CIO_INTERFACE]) then 
          WriteProperties(HL + 2, CIO.Properties);
        
      WriteFields(HL + 2, CIO.Fields);

      WriteMethods(HL + 2, CIO.Methods);
        

      WriteAuthors(HL + 2, CIO.Authors);
      WriteDates(HL + 2, CIO.Created, CIO.LastMod);
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TTexDocGenerator.WriteCIOSummary(HL: integer; c: TPasItems);
var
  j: Integer;
  p: TPasCio;
  CIO: TPasCio;
  s: string;
  Item: TPasItem;
begin
  if ObjectVectorIsNilOrEmpty(c) then Exit;
  WriteDirect('\begin{description}',true);
  for j := 0 to c.Count - 1 do 
    begin
      CIO := TPasCio(c.PasItemAt[j]);
      WriteDirect('\item[{\ttfamily ');
      WriteLink(CIO.FullLink, CodeString(CIO.Name), 'bold');
      { name of class/interface/object and unit }
      WriteDirect(' ');
      WriteConverted(GETCIOTypeName(CIO.MyType));
      WriteDirect('}]');

      { Write only the description and do not opt for DetailedDescription,
        like WriteItemDescription does. }
      if CIO.Description <> '' then
        WriteWithURLs(CIO.Description);
      WriteDirect('',true);
    end;
  WriteDirect('\end{description}',true);
end;

procedure TTexDocGenerator.WriteCodeWithLinks(const p: TPasItem; const Code:
  string; const ItemLink: string);
var
  NameFound,SearchForLink: Boolean;
  FoundItem: TPasItem;
  i, j, l: Integer;
  s: string;
  pl: TStandardDirective;
  n, ncstart: Integer;
  S1: string;
  S2: string;
  S3: string;
begin
  WriteStartOfCode;
  i := 1;
  NameFound := false;
  SearchForLink := false;
  l := Length(Code);
  ncstart := i;
  while i <= l do
  begin
    case Code[i] of
      '_', 'A'..'Z', 'a'..'z':
         begin
          WriteConverted(Copy(Code, ncstart, i - ncstart));
          { assemble item }
          j := i;
          repeat
            Inc(i);
          until (i > l) or (not (Code[i] in ['.', '_', '0'..'9', 'A'..'Z', 'a'..'z']));
          s := Copy(Code, j, i - j);

           { Special processing for standard directives. }
          pl := StandardDirectiveByName(s);
          case pl of
            SD_ABSTRACT, SD_ASSEMBLER, SD_CDECL, SD_DYNAMIC, SD_EXPORT,
              SD_FAR, SD_FORWARD, SD_NAME, SD_NEAR, SD_OVERLOAD, SD_OVERRIDE,
              SD_PASCAL, SD_REGISTER, SD_SAFECALL, SD_STDCALL, SD_REINTRODUCE, SD_VIRTUAL:
              begin
                WriteConverted(s);
                SearchForLink := False;
                ncstart := i;
                Continue;
              end;
            SD_EXTERNAL:
              begin
                WriteConverted(s);
                SearchForLink := False;
                ncstart := i;
                Continue;
              end;
          end;
          if not NameFound and (s = p.Name) then begin
            if ItemLink <> '' then begin
              WriteLink(ItemLink,ConvertString(s), '');
            end else begin
              WriteConverted(s);
            end;
            NameFound := True;
          end else begin
            { search for item of name  L }
            if SearchForLink and (SplitLink(s, S1, S2, S3, n)) then begin
              FoundItem := p.FindName(S1, S2, S3, n);
              if not Assigned(FoundItem) then
                FoundItem := FindGlobal(S1, S2, S3, n);
            end
            else
              FoundItem := nil;

            if Assigned(FoundItem) then
              WriteLink(FoundItem.FullLink, ConvertString(s), '')
            else begin
              WriteConverted(s);
            end;
          end;
          ncstart := i;
          Continue; // We don't want to miss out on any ':' or ';' for SearchForLink
        end;
      ':',
      '=': SearchForLink := True;
      ';': SearchForLink := False;
      '''': begin
          Inc(i);
          while (i<=l) and (Code[i] <> '''') do Inc(i);
        end;
    end;
    Inc(i);
  end;
  WriteConverted(Copy(Code, ncstart, i - ncstart));
  WriteEndOfCode;
end;

{ ---------------------------------------------------------------------------- }

procedure TTexDocGenerator.WriteDates(const HL: integer; const Created,
  LastMod: string);
begin
  if Created <> '' then begin
    WriteHeading(HL, FLanguage.Translation[trCreated]);
    WriteStartOfParagraph;
    WriteConverted(Created);
    WriteEndOfParagraph;
  end;
  if LastMod <> '' then begin
    WriteHeading(HL, FLanguage.Translation[trLastModified]);
    WriteStartOfParagraph;
    WriteConverted(LastMod, true);
    WriteEndOfParagraph;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TTexDocGenerator.WriteDocumentation;
begin
{  StartSpellChecking('sgml');}
  inherited;
  WriteUnits(1);
{  WriteHierarchy;
  WriteBinaryFiles;
  WriteOverviewFiles;
  WriteVisibilityLegendFile;}
{  EndSpellChecking;}
end;

{ ---------------------------------------------------------------------------- }

procedure TTexDocGenerator.WriteEmptyCell;
begin
end;

procedure TTexDocGenerator.WriteEndOfDocument;
begin
  WriteDirect('\end{document}',true);
end;

procedure TTexDocGenerator.WriteEndOfCode;
begin
  WriteDirect('}');
end;

procedure TTexDocGenerator.WriteLink(const href, caption, css: string);
begin
  WriteLink(href, caption, css, '');
end;

procedure TTexDocGenerator.WriteLink(const href, caption, css, target: string);
var
  s: string;
begin
  WriteDirect(caption);
end;

procedure TTexDocGenerator.WriteEndOfParagraph;
begin
  WriteDirect('', true);
  WriteDirect('',true);
end;

procedure TTexDocGenerator.WriteEndOfTableCell;
begin
  Inc(CellCounter);
  if (CellCounter < NumCells)
  then WriteDirect(' & ');
end;

procedure TTexDocGenerator.WriteEndOfTable;
begin
 WriteDirect('\end{tabular}',true);
end;

procedure TTexDocGenerator.WriteEndOfTableRow;
begin
   WriteDirect('\\',true);
end;

{ ---------------------------------------------------------------------------- }

procedure TTexDocGenerator.WriteFields(const Order: integer; const Fields:
  TPasItems);
var
  j: Integer;
  Item: TPasItem;
  s: string;
begin
  if ObjectVectorIsNilOrEmpty(Fields) then Exit;

  WriteHeading(Order, FLanguage.Translation[trFields]);
  
  { get the longest string for names }
  s:='';
  for j := 0 to Fields.Count - 1 do 
    begin
      Item := Fields.PasItemAt[j];
      if length(s) < length(Item.Name) then
        s:=Item.Name;
    end;
  
  { Determine the longest string used.
    This is the one we will use for determining the label width.
  }
  WriteDirect('\begin{list}{}{',true);
  WriteDirect('\settowidth{\tmplength}{\textbf{'+s+'}}',true);
  WriteDirect('\setlength{\itemindent}{0cm}',true);
  WriteDirect('\setlength{\listparindent}{0cm}',true);
  WriteDirect('\setlength{\leftmargin}{\evensidemargin}',true);
  WriteDirect('\addtolength{\leftmargin}{\tmplength}',true);
  WriteDirect('\settowidth{\labelsep}{X}',true);
  WriteDirect('\addtolength{\leftmargin}{\labelsep}',true);
  WriteDirect('\setlength{\labelwidth}{\tmplength}',true);
  WriteDirect('}',true);
  for j := 0 to Fields.Count - 1 do 
    begin
      Item := Fields.PasItemAt[j];
      WriteDirect('\item[');
      WriteDirect('\textbf{'+Item.name);
      WriteDirect('}\hfill]',true);
      WriteDirect('',true);
      WriteDirect('\begin{flushleft}',true);
      if Item is TPasVarConst then 
      begin
        WriteCodeWithLinks(Item, TPasVarConst(Item).FullDeclaration, '');
      end
      else
        WriteCodeWithLinks(Item, Item.Name, '');
      WriteDirect('\end{flushleft}',true);
      WriteDirect('\par ');
      WriteItemDetailedDescription(Item);
    end;
   WriteDirect('\end{list}',true); 
end;

{ ---------------------------------------------------------------------------- }

procedure TTexDocGenerator.WriteFooter;
begin
{  WriteConverted(Footer);}
end;

{ ---------------------------------------------------------------------------- }
  function ExtractFirstWord(var s: string): string;
  var
    p: integer;
    Len: integer;
  begin
    Result := '';
    Len := Length(s);
    p := 1;
    while (p <= Len) and (s[p] in [' ', #9, #13, #10]) do
      Inc(p);
    while (p <= Len) and not (s[p] in [' ', #9, #13, #10]) do
      begin
        Result := Result + s[p];
        Inc(p);
      end;
    s := Copy(s, p, Length(s));
  end;

  procedure TTexDocGenerator.WriteParameter(const ParamName: string; const Desc: string);
  begin
    WriteDirect('\item[');
    WriteConverted(ParamName);
    WriteDirect('] ');
    WriteWithURLs(Desc);
    WriteDirect('',true);
  end;

  { writes the parameters or exceptions list }
  procedure TTexDocgenerator.WriteParamsOrRaises(Func: TPasMethod; const Caption: string;
    List: TStringVector);
  var
    i: integer;
    s: string;
    ParamName: string;
  begin
    if StringVectorIsNilOrEmpty(List) then
      exit;

    WriteDirect('\item[\textbf{'+Caption+'}]',true);
    WriteDirect('\begin{description}',true);
    { Terrible hack : To fix and replace by a clean solution,
      we need to add an empty item so that the list starts
      at the correct margin.
    }
    WriteDirect('\item',true);
    for i := 0 to List.Count - 1 do begin
      s := List[i];
      ParamName := ExtractFirstWord(s);
      ExpandDescription(Func, s);
      WriteParameter(ParamName, s);
    end;
    WriteDirect('\end{description}',true);
  end;

  procedure TTexDocGenerator.WriteReturnDesc(Func: TPasMethod; ReturnDesc: string);
  begin
    if ReturnDesc = '' then
      exit;
    WriteDirect('\item['+FLanguage.Translation[trReturns]+']');
    ExpandDescription(Func, ReturnDesc);
    WriteWithURLs(ReturnDesc);
    WriteDirect('',true);
  end;


procedure TTexDocGenerator.WriteMethodsSummary(const HL: integer; const FuncsProcs: TPasMethods); 
var
  i: Integer;
  j: Integer;
  p: TPasMethod;
  s: string;
begin
  // Sort alphabatically
  FuncsProcs.SortByPasItemName;
  // two passes, in the first (i=0) we write the overview
  // in the second (i=1) we write the descriptions
  WriteHeading(HL + 1, FLanguage.Translation[trOverview]);
  WriteDirect('\begin{description}',true);
  for j := 0 to FuncsProcs.Count - 1 do 
  begin
    p := TPasMethod(FuncsProcs.PasItemAt[j]);
    
    WriteDirect('\item[{\ttfamily ');
    { overview of functions and procedures }
    { Only write visibility for methods of classes and objects. }
    WriteVisibilityCell(p);

    s := p.FullLink;
      if Assigned(p.MyUnit) then
         if CompareText(p.MyUnit.FullLink, Copy(s, 1,
            Length(p.MyUnit.FullLink))) = 0 then
            begin
              Delete(s, 1, Length(p.MyUnit.FullLink));
              { remove - character from the link }
              Delete(s, 1,1);
            end;

    WriteDirect(p.name);
    WriteDirect('}]');

    WriteItemDescription(p);
  end;
  WriteDirect('\end{description}',true);
end;

procedure TTexDocGenerator.WriteMethods(const HL: integer; const FuncsProcs: TPasMethods);
var
  i: Integer;
  j: Integer;
  p: TPasMethod;
  s: string;
begin
  if ObjectVectorIsNilOrEmpty(FuncsProcs) then Exit;

  WriteHeading(HL, FLanguage.Translation[trMethods]);

  { Determine the longest string used.
    This is the one we will use for determining the label width.
  }
  s:=FLanguage.Translation[trDescription];
  if length(s) < length(FLanguage.Translation[trDeclaration])  then
     s:= FLanguage.Translation[trDeclaration];
  if length(s) < length(FLanguage.Translation[trReturns])  then
     s:=FLanguage.Translation[trReturns];
  if length(s) < length(FLanguage.Translation[trParameters])  then
     s:=FLanguage.Translation[trParameters];
  if length(s) < length(FLanguage.Translation[trExceptions])  then
     s:=FLanguage.Translation[trExceptions];


  for j := 0 to FuncsProcs.Count - 1 do 
  begin
      p := TPasMethod(FuncsProcs.PasItemAt[j]);
      { overview of functions and procedures }
      begin

        WriteVisibilityCell(p);
        
        WriteHeading(HL+1,p.Name);
        WriteAnchor(p.Name,p.FullLink);
        
        WriteDirect('\begin{list}{}{',true);
        WriteDirect('\settowidth{\tmplength}{\textbf{'+s+'}}',true);
        WriteDirect('\setlength{\itemindent}{0cm}',true);
        WriteDirect('\setlength{\listparindent}{0cm}',true);
        WriteDirect('\setlength{\leftmargin}{\evensidemargin}',true);
        WriteDirect('\addtolength{\leftmargin}{\tmplength}',true);
        WriteDirect('\settowidth{\labelsep}{X}',true);
        WriteDirect('\addtolength{\leftmargin}{\labelsep}',true);
        WriteDirect('\setlength{\labelwidth}{\tmplength}',true);
        WriteDirect('}',true);
        
        WriteDirect('\item[\textbf{'+FLanguage.Translation[trDeclaration]+'}]',true);
        WriteDirect('\begin{flushleft}',true);
        WriteCodeWithLinks(p, p.FullDeclaration, '');
        WriteDirect('\end{flushleft}',true);

        WriteStartOfParagraph;
        WriteDirect('\item[\textbf{'+FLanguage.Translation[trDescription]+'}]',true);
        WriteItemDetailedDescription(p);
        WriteEndOfParagraph;

        WriteParamsOrRaises(p, FLanguage.Translation[trParameters], p.Params);
        WriteReturnDesc(p, p.Returns);
        WriteParamsOrRaises(p, FLanguage.Translation[trExceptions], p.Raises);
        WriteDirect('\end{list}',true);
      end;
  end;
end;
 

{ ---------------------------------------------------------------------------- }

procedure TTexDocGenerator.WriteFuncsProcsSummary(const HL: integer; const FuncsProcs: TPasMethods);
var
  i: Integer;
  j: Integer;
  p: TPasMethod;
  s: string;
 begin
  if ObjectVectorIsNilOrEmpty(FuncsProcs) then Exit;
  
  // Sort alphabatically
  FuncsProcs.SortByPasItemName;
  WriteDirect('\begin{description}',true);
  for j := 0 to FuncsProcs.Count - 1 do 
  begin
    p := TPasMethod(FuncsProcs.PasItemAt[j]);
    
    WriteDirect('\item[{\ttfamily ');
    { overview of functions and procedures }
    { Only write visibility for methods of classes and objects. }
    s := p.FullLink;
      if Assigned(p.MyUnit) then
         if CompareText(p.MyUnit.FullLink, Copy(s, 1,
            Length(p.MyUnit.FullLink))) = 0 then
            begin
              Delete(s, 1, Length(p.MyUnit.FullLink));
              { remove - character from the link }
              Delete(s, 1,1);
            end;

    WriteDirect(p.name);
    WriteDirect('}]');
    WriteItemDescription(p);
  end;
  WriteDirect('\end{description}',true);
 end;

{ ---------------------------------------------------------------------------- }

procedure TTexDocGenerator.WriteFuncsProcs(const HL: integer; const FuncsProcs: TPasMethods);


var
  i: Integer;
  j: Integer;
  p: TPasMethod;
  s: string;
  procstr: string;
begin
  if ObjectVectorIsNilOrEmpty(FuncsProcs) then Exit;

  WriteHeading(HL, FLanguage.Translation[trFunctionsAndProcedures]);

  { Determine the longest string used.
    This is the one we will use for determining the label width.
  }
  s:=FLanguage.Translation[trDescription];
  if length(s) < length(FLanguage.Translation[trDeclaration])  then
     s:= FLanguage.Translation[trDeclaration];
  if length(s) < length(FLanguage.Translation[trReturns])  then
     s:=FLanguage.Translation[trReturns];
  if length(s) < length(FLanguage.Translation[trParameters])  then
     s:=FLanguage.Translation[trParameters];


  for j := 0 to FuncsProcs.Count - 1 do
  begin
      p := TPasMethod(FuncsProcs.PasItemAt[j]);
      { overview of functions and procedures }
      begin
        { Check if this is a function or a procedure }
        { and add it as an end string                }
        procstr:=p.FullDeclaration;
        procstr:=trimleft(procstr);
        procstr:=trimright(procstr);
        if (pos('procedure',LowerCase(procstr)) >= 1) then
          procstr:='procedure'
        else
          procstr:='function';

        WriteHeading(HL+1,p.Name+' '+procstr);
        WriteAnchor(p.Name,p.FullLink);

        WriteDirect('\begin{list}{}{',true);
        WriteDirect('\settowidth{\tmplength}{\textbf{'+s+'}}',true);
        WriteDirect('\setlength{\itemindent}{0cm}',true);
        WriteDirect('\setlength{\listparindent}{0cm}',true);
        WriteDirect('\setlength{\leftmargin}{\evensidemargin}',true);
        WriteDirect('\addtolength{\leftmargin}{\tmplength}',true);
        WriteDirect('\settowidth{\labelsep}{X}',true);
        WriteDirect('\addtolength{\leftmargin}{\labelsep}',true);
        WriteDirect('\setlength{\labelwidth}{\tmplength}',true);
        WriteDirect('}',true);

        WriteDirect('\item[\textbf{'+FLanguage.Translation[trDeclaration]+'}]',true);
        WriteDirect('\begin{flushleft}',true);
        WriteCodeWithLinks(p, p.FullDeclaration, '');
        WriteDirect('\end{flushleft}',true);

        WriteStartOfParagraph;
        WriteDirect('\item[\textbf{'+FLanguage.Translation[trDescription]+'}]',true);
        WriteItemDetailedDescription(p);
        WriteEndOfParagraph;

        WriteParamsOrRaises(p, FLanguage.Translation[trParameters], p.Params);
        WriteReturnDesc(p, p.Returns);
        WriteParamsOrRaises(p, FLanguage.Translation[trExceptions], p.Raises);
        WriteDirect('\end{list}',true);
      end;
  end;
end;

procedure TTexDocGenerator.WriteHeading(Level: integer; const s: string);
var
  c: string;
begin
  if (Level < 1) then Level := 1;
  if Level > 5 then begin
    DoMessage(2, mtWarning, 'latex generator cannot write headlines of level 4 or greater; will use 4 instead.', []);
    Level := 5;
  end;
  case Level of
    1: begin
        WriteDirect('\chapter{');
        WriteConverted(s);
        WriteDirect('}', true);
       end; 
    2: begin
        WriteDirect('\section{');
        WriteConverted(s);
        WriteDirect('}', true);
       end; 
    3: begin
        WriteDirect('\subsection*{');
          WriteDirect('\large{\textbf{'+ConvertString(s)+'}}\normalsize\hspace{1ex}'+
          '\hrulefill');
        WriteDirect('}', true);
       end; 
    4: begin
          WriteDirect('\subsubsection*{');
          WriteDirect('\large{\textbf{'+ConvertString(s)+'}}\normalsize\hspace{1ex}'+
          '\hfill');
          WriteDirect('}',true);
       end;
    5: begin
        WriteDirect('\paragraph*{');
        WriteConverted(s);
        WriteDirect('}\hspace*{\fill}', true);
        WriteDirect('',true);
       end; 
  end;
end;

{ ---------- }

procedure TTexDocGenerator.WriteItemDescription(const AItem: TPasItem);
begin
  if AItem = nil then Exit;
  if AItem.Description <> '' then
    begin
      WriteWithURLs(AItem.Description);
    end
  else
      WriteDirect(' ');
end;

procedure TTexDocGenerator.WriteItemDetailedDescription(const AItem: TPasItem);
var
  Ancestor: TPasCio;
  AncestorName: string;
begin
  if not Assigned(AItem) then Exit;

  if AItem.Description <> '' then 
  begin
    WriteWithURLs(AItem.Description);
    
    if AItem.DetailedDescription <> '' then 
      begin
        WriteDirect('\hfill\vspace*{1ex}',true);
        WriteDirect('',true);
        WriteWithURLs(AItem.DetailedDescription);
      end;
  end else 
  begin
    if AItem.DetailedDescription <> '' then 
    begin
      WriteWithURLs(AItem.DetailedDescription);
    end else 
    begin
      if (AItem is TPasCio) and not StringVectorIsNilOrEmpty(TPasCio(AItem).Ancestors) then 
      begin
        AncestorName := TPasCio(AItem).Ancestors.FirstName;
        Ancestor := TPasCio(SearchItem(AncestorName, AItem));
        if Assigned(Ancestor) then
          begin
            WriteConverted(Format('no description available, %s description follows', [AncestorName]));
            WriteItemDetailedDescription(Ancestor);
          end;
      end else
      begin
        WriteDirect(' ');
      end;
    end;
  end;
end;

procedure TTexDocGenerator.WriteItems(HL: integer; Heading: string; const
  Anchor: string; const i: TPasItems);
var
  j, k: Integer;
  Item: TPasItem;
  s: string;
begin
  if ObjectVectorIsNilOrEmpty(i) then Exit;

  WriteHeading(HL, Heading);
  
  s:=FLanguage.Translation[trDescription];
  if length(s) < length(FLanguage.Translation[trDeclaration])  then
     s:= FLanguage.Translation[trDeclaration];
  if length(s) < length(FLanguage.Translation[trReturns])  then
     s:=FLanguage.Translation[trReturns];
  if length(s) < length(FLanguage.Translation[trParameters])  then
     s:=FLanguage.Translation[trParameters];
  
  
  for j := 0 to i.Count - 1 do begin
    Item := i.PasItemAt[j];

    if Item is TPasEnum then
      WriteHeading(HL+1, Item.Name+' '+LowerCase(FLanguage.Translation[trEnum]))
    else
      WriteHeading(HL+1, Item.Name);
    
    WriteAnchor(Item.Name,Item.FullLink);
    WriteDirect('\begin{list}{}{',true);
    WriteDirect('\settowidth{\tmplength}{\textbf{'+s+'}}',true);
    WriteDirect('\setlength{\itemindent}{0cm}',true);
    WriteDirect('\setlength{\listparindent}{0cm}',true);
    WriteDirect('\setlength{\leftmargin}{\evensidemargin}',true);
    WriteDirect('\addtolength{\leftmargin}{\tmplength}',true);
    WriteDirect('\settowidth{\labelsep}{X}',true);
    WriteDirect('\addtolength{\leftmargin}{\labelsep}',true);
    WriteDirect('\setlength{\labelwidth}{\tmplength}',true);
    WriteDirect('}',true);

    WriteDirect('\item[\textbf{'+FLanguage.Translation[trDeclaration]+'}]',true);
    WriteDirect('\begin{flushleft}',true);
    if Item is TPasVarConst then 
      begin
        WriteCodeWithLinks(Item, Item.Name, '');
        WriteCodeWithLinks(Item, TPasVarConst(Item).FullDeclaration, '')
      end
    else
      WriteCodeWithLinks(Item, Item.Name, '');
      
    WriteDirect('\end{flushleft}',true);

    WriteDirect('\item[\textbf{'+FLanguage.Translation[trDescription]+'}]',true);
    WriteItemDetailedDescription(Item);
    
    if not (Item is TPasEnum) then
       WriteDirect('\par ',true)
    else
     begin
      WriteDirect('\begin{description}', true);
      for k := 0 to TPasEnum(Item).Members.Count-1 do begin
        WriteDirect('\item[{\ttfamily ');
        { add the first character for enums }
        WriteConverted(TPasItem(TPasEnum(Item).Members.PasItemAt[k]).Name);
        { add the end characters for enums }
        WriteDirect('}] ');
        WriteWithURLs(TPasItem(TPasEnum(Item).Members.PasItemAt[k]).GetDescription);
        WriteDirect('', true);
      end;
      WriteDirect('\end{description}', true);
    end;
    WriteDirect('\end{list}',true);
  end;
end;

{ ---------- }

procedure TTexDocGenerator.WriteOverviewFiles;
var
  ItemsToCopy: TPasItems;
  PartialItems: TPasItems;
  TotalItems: TPasItems; // Collect all Items for final listing.
  i: Integer;
  Item: TPasItem;
  j: Integer;
  PU: TPasUnit;
begin
  WriteUnitOverviewFile;

  if ObjectVectorIsNilOrEmpty(Units) then Exit;

  // Make sure we don't free the Itmes when we free the container.
  TotalItems := TPasItems.Create(False);

  for i := 2 to NUM_OVERVIEW_FILES_USED - 1  do begin
    if (CreateStream(OverviewFilenames[i] + GetFileExtension, True) = csError)
      then begin
      DoMessage(1, mtError, 'Error: Could not create output file "' +
        OverviewFilenames[i] + '".', []);
      Exit;
    end;
    DoMessage(3, mtInformation, 'Writing overview file ' +
      OverviewFilenames[i] + '...', []);

    case i of
      2: WriteStartOfDocument(FLanguage.Translation[trHeadlineCio]);
      3: WriteStartOfDocument(FLanguage.Translation[trHeadlineTypes]);
      4: WriteStartOfDocument(FLanguage.Translation[trHeadlineVariables]);
      5: WriteStartOfDocument(FLanguage.Translation[trHeadlineConstants]);
      6: WriteStartOfDocument(FLanguage.Translation[trHeadlineFunctionsAndProcedures]);
      7: WriteStartOfDocument(FLanguage.Translation[trHeadlineIdentifiers]);
    end;

    case i of
      2: WriteHeading(1, FLanguage.Translation[trHeadlineCio]);
      3: WriteHeading(1, FLanguage.Translation[trHeadlineTypes]);
      4: WriteHeading(1, FLanguage.Translation[trHeadlineVariables]);
      5: WriteHeading(1, FLanguage.Translation[trHeadlineConstants]);
      6: WriteHeading(1, FLanguage.Translation[trHeadlineFunctionsAndProcedures]);
      7: WriteHeading(1, FLanguage.Translation[trHeadlineIdentifiers]);
    end;

      // Make sure we don't free the Itmes when we free the container.
    PartialItems := TPasItems.Create(False);

    for j := 0 to Units.Count - 1 do begin
      PU := Units.UnitAt[j];
      case i of
        2: ItemsToCopy := PU.CIOs;
        3: ItemsToCopy := PU.Types;
        4: ItemsToCopy := PU.Variables;
        5: ItemsToCopy := PU.Constants;
        6: ItemsToCopy := PU.FuncsProcs;
      else
        ItemsToCopy := nil;
      end;
      PartialItems.InsertItems(ItemsToCopy);
    end;

    if not ObjectVectorIsNilOrEmpty(PartialItems) then begin
      WriteStartOfTable3Columns(FLanguage.Translation[trName], FLanguage.Translation[trUnit],
        FLanguage.Translation[trDescription]);

      PartialItems.SortByPasItemName;

      for j := 0 to PartialItems.Count - 1 do begin
        Item := PartialItems.PasItemAt[j];
        WriteStartOfTableRow('');

        WriteStartOfTableCell('nowrap="nowrap"', 'itemname');
        WriteLink(Item.FullLink, Item.Name, 'bold');
        WriteEndOfTableCell;

        WriteStartOfTableCell;
        WriteLink(Item.MyUnit.FullLink, Item.MyUnit.Name, 'bold');
        WriteEndOfTableCell;

        if j = 0 then
          WriteStartOfTableCell('width="100%"', '')
        else
          WriteStartOfTableCell;
        WriteItemDescription(Item);
        WriteEndOfTableCell;

        WriteEndOfTableRow;
      end;
      WriteEndOfTable;
    end
    else begin
      WriteStartOfParagraph;
      WriteConverted(FLanguage.Translation[trNone]);
      WriteEndOfParagraph;
    end;

    TotalItems.InsertItems(PartialItems);
    PartialItems.Free;
    WriteFooter;
    WriteEndOfDocument;
    CloseStream;
  end;

  if CreateStream(OverviewFilenames[7] + GetFileExtension, True) = csError then
    begin
    DoMessage(1, mtError, 'Could not create overview output file "' +
      OverviewFilenames[7] + '".', []);
    Exit;
  end;
  DoMessage(3, mtInformation, 'Writing overview file ' + OverviewFilenames[7]
    + '...', []);
  WriteStartOfDocument(FLanguage.Translation[trHeadlineIdentifiers]);
  WriteHeading(1, FLanguage.Translation[trHeadlineIdentifiers]);
  WriteStartOfTable3Columns(FLanguage.Translation[trName], FLanguage.Translation[trUnit],
    FLanguage.Translation[trDescription]);

  TotalItems.SortByPasItemName;
  for j := 0 to TotalItems.Count - 1 do begin
    Item := TotalItems.PasItemAt[j];
    WriteStartOfTableRow('');

    WriteStartOfTableCell('nowrap="nowrap"', 'itemname');
    WriteLink(Item.FullLink, Item.Name, 'bold');
    WriteEndOfTableCell;

    WriteStartOfTableCell;
    WriteLink(Item.MyUnit.FullLink, Item.MyUnit.Name, 'bold');
    WriteEndOfTableCell;

    if j = 0 then
      WriteStartOfTableCell('width="100%"', '')
    else
      WriteStartOfTableCell;
    WriteItemDescription(Item);
    WriteEndOfTableCell;

    WriteEndOfTableRow;
  end;

  TotalItems.Free;

  WriteEndOfTable;
  WriteFooter;
  WriteEndOfDocument;
  CloseStream;
end;

procedure TTexDocGenerator.WriteParagraph(HL: integer; s: string; t: string);
begin
  // if (not Assigned(t)) or (t.Content < 1) then Exit;
  WriteHeading(HL, s);
  WriteStartOfParagraph;
  WriteWithURLs(t);
  WriteEndOfParagraph;
end;

procedure TTexDocGenerator.WriteProperties(HL: integer; const p:
  TPasProperties);
var
  j: Integer;
  Prop: TPasProperty;
  s: string;
begin
  if ObjectVectorIsNilOrEmpty(p) then Exit;

  WriteHeading(HL, FLanguage.Translation[trProperties]);
  
  { get the longest string for names }
  s:='';
  for j := 0 to p.Count - 1 do
    begin
      Prop := TpasProperty(p.PasItemAt[j]);
      if length(s) < length(Prop.Name) then
        s:=Prop.Name;
    end;
  
  { Determine the longest string used.
    This is the one we will use for determining the label width.
  }
  WriteDirect('\begin{list}{}{',true);
  WriteDirect('\settowidth{\tmplength}{\textbf{'+s+'}}',true);
  WriteDirect('\setlength{\itemindent}{0cm}',true);
  WriteDirect('\setlength{\listparindent}{0cm}',true);
  WriteDirect('\setlength{\leftmargin}{\evensidemargin}',true);
  WriteDirect('\addtolength{\leftmargin}{\tmplength}',true);
  WriteDirect('\settowidth{\labelsep}{X}',true);
  WriteDirect('\addtolength{\leftmargin}{\labelsep}',true);
  WriteDirect('\setlength{\labelwidth}{\tmplength}',true);
  WriteDirect('}',true);
  for j := 0 to p.Count - 1 do 
    begin
      Prop := TPasProperty(p.PasItemAt[j]);
      WriteDirect('\item[');
      WriteDirect('\textbf{'+Prop.name);
      WriteDirect('}\hfill]',true);
      WriteDirect('',true);
      WriteDirect('\begin{flushleft}',true);
      WriteCodeWithLinks(Prop, Prop.FullDeclaration, '');
      WriteDirect('\end{flushleft}',true);
      WriteDirect('\par ');
      WriteItemDetailedDescription(Prop);
    end;
   WriteDirect('\end{list}',true); 
end;

procedure TTexDocGenerator.WritePropertiesSummary(HL: integer; p:
  TPasProperties);
var
  j: Integer;
  Prop: TPasProperty;
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TTexDocGenerator.WriteAnchor(ItemName, Link: string);
begin
  if Link <> '' then
     WriteDirect('\label{'+Link+'}',true)
  else
     WriteDirect('\label{'+ItemName+'}',true);
  WriteDirect('\index{'+ConvertString(ItemName)+'}',true);
end;


{ ---------------------------------------------------------------------------- }

procedure TTexDocGenerator.WriteStartOfCode;
begin
  WriteDirect('{\ttfamily ');
end;

{ ---------------------------------------------------------------------------- }

procedure TTexDocGenerator.WriteStartOfDocument(AName: string);
var
 i : integer;
 Localtitle: string;
begin
  if Title <> '' then
    Localtitle:= Title + ':' + Aname
  else
    LocalTitle := AName;
  { write basic header }
  WriteAppInfo;
  WriteDirect('\documentclass{report}',true);
  WriteDirect('% WARNING: THIS SHOULD BE MODIFIED DEPENDING ON THE LETTER/A4 SIZE',true);
  WriteDirect('\oddsidemargin 0cm',true);
  WriteDirect('\evensidemargin 0cm',true);
  WriteDirect('\marginparsep 0cm',true);
  WriteDirect('\marginparwidth 0cm',true);
  WriteDirect('\textwidth 16.5cm',true);
  WriteDirect('\parindent 0cm',true);
  WriteDirect('',true);
  { PDF output support, create ifpdf macro 
    to be able to support extended PDF features.
  }
  WriteDirect('\newif\ifpdf',true);
  WriteDirect('\ifx\pdfoutput\undefined',true);
  WriteDirect('\pdffalse',true);
  WriteDirect('\else',true);
  WriteDirect('\pdfoutput=1',true);
  WriteDirect('\pdftrue',true);
  WriteDirect('\fi',true);
  WriteDirect('',true);
  WriteDirect('\ifpdf',true);
  WriteDirect('\pdfinfo{',true);
  WriteDirect(' /Author     (Pasdoc)',true);
  WriteDirect(' /Title      ('+LocalTitle+')',true);
  WriteDirect(' /CreationDate ('+FormatDateTime('yyyymmddhhmmss', Now)+')',true);
  WriteDirect('}',true);
  
  WriteDirect('\fi',true);
  WriteDirect('\begin{document}',true);
  WriteDirect('% special variable used for calculating some widths.',true);
  WriteDirect('\newlength{\tmplength}',true);
  if Length(Header) > 0 then begin
    WriteWithURLs(Header);
  end;
end;


procedure TTexDocGenerator.WriteStartOfParagraph;
begin
  WriteDirect('\par',true);
end;

procedure TTexDocGenerator.WriteStartOfTable1Column(T: String);
begin
  FOddTableRow := 0;
  NumCells := 1;
  WriteDirect('\begin{tabular}{|l|}',true);
  WriteDirect('\hline',true);
  if t <> '' then
    begin
     WriteConverted(t);
     WriteDirect(' \\',true);
     WriteDirect('\hline',true);
    end;
end;

procedure TTexDocGenerator.WriteStartOfTable2Columns(T1, T2: String);
begin
  WriteDirect('\begin{tabular}{|ll|}',true);
  WriteDirect('\hline',true);
  if t1 <> '' then
  Begin
     WriteConverted(t1);
     WriteDirect(' & ');
     WriteConverted(t2);
     WriteDirect(' \\',true);
     WriteDirect('\hline',true);
  end;
  NumCells := 2;
end;

procedure TTexDocGenerator.WriteStartOfTable3Columns(T1, T2, T3: String);
begin
  WriteDirect('\begin{tabular}{|lll|}',true);
  WriteDirect('\hline',true);
  WriteConverted(T1);
  WriteDirect(' & ');
  WriteConverted(T2);
  WriteDirect(' & ');
  WriteConverted(T3);
  WriteDirect(' \\',true);
  WriteDirect('\hline',true);
  NumCells := 3;
end;


procedure TTexDocGenerator.WriteStartOfTableCell(const Params, css: string);
var
  s: string;
begin
end;

procedure TTexDocGenerator.WriteStartOfTableCell(const css: string);
begin
  WriteStartOfTableCell('', css);
end;

procedure TTexDocGenerator.WriteStartOfTableCell;
begin
  WriteStartOfTableCell('', '');
end;

procedure TTexDocGenerator.WriteStartOfTableRow(const CssClass: string);
var
  s: string;
begin
  CellCounter := 0;
end;

{ ---------------------------------------------------------------------------- }
{ HtmlHelp Content Generation inspired by Wim van der Vegt <wvd_vegt@knoware.nl> }
{ ---------------------------------------------------------------------------- }

function BeforeEqualChar(const s: string): string;
var
  i: Cardinal;
begin
  Result := s;
  i := Pos('=', Result);
  if i <> 0 then
    SetLength(Result, i - 1);
end;

function AfterEqualChar(const s: string): string;
var
  i: Cardinal;
begin
  Result := s;
  i := Pos('=', Result);
  if i <> 0 then
    Delete(Result, 1, i)
  else
    Result := '';
end;

function GetLevel(var s: string): Integer;
var
  l: Cardinal;
  p: PChar;
begin
  Result := 0;
  p := Pointer(s);
  l := Length(s);
  while (l > 0) and (p^ in [' ', #9]) do begin
    Inc(Result);
    Inc(p);
    Dec(l);
  end;
  Delete(s, 1, Result);
end;

{ ---------------------------------------------------------------------------- }

procedure TTexDocGenerator.WriteUnit(const HL: integer; const U: TPasUnit);
type
  TSections = (dsDescription, dsUses, dsClasses, dsFuncsProcs,
    dsTypes, dsConstants, dsVariables);
  TSectionSet = set of TSections;
  TSectionAnchors = array[TSections] of string;
const
  SectionAnchors: TSectionAnchors = (
    '@Description',
    '@Uses',
    '@Classes',
    '@FuncsProcs',
    '@Types',
    '@Constants',
    '@Variables');
var
  SectionsAvailable: TSectionSet;
  SectionHeads: array[TSections] of string;
  Section: TSections;

  procedure ConditionallyAddSection(Section: TSections; Condition: boolean);
  begin
    if Condition then
      Include(SectionsAvailable, Section);
  end;

begin
  if not Assigned(U) then begin
    DoMessage(1, mtError,
      'TTexDocGenerator.WriteUnit: Unit variable has not been initialized.',
      []);
    Exit;
  end;

  case CreateStream(U.OutputFileName, not U.WasDeserialized) of
    csError: begin
      DoMessage(1, mtError, 'Could not create HTML unit doc file for unit %s.', [U.Name]);
      Exit;
    end;
    csExisted: begin
      Exit;
    end;
  end;

  SectionHeads[dsDescription] := FLanguage.Translation[trDescription];
  SectionHeads[dsUses] := 'uses';
  SectionHeads[dsClasses] := FLanguage.Translation[trCio];
  SectionHeads[dsFuncsProcs]:= FLanguage.Translation[trFunctionsAndProcedures];
  SectionHeads[dsTypes]:= FLanguage.Translation[trTypes];
  SectionHeads[dsConstants]:= FLanguage.Translation[trConstants];
  SectionHeads[dsVariables]:= FLanguage.Translation[trVariables];

  SectionsAvailable := [dsDescription];
  ConditionallyAddSection(dsUses, WriteUsesClause and not StringVectorIsNilOrEmpty(U.UsesUnits));
  ConditionallyAddSection(dsClasses, not ObjectVectorIsNilOrEmpty(U.CIOs));
  ConditionallyAddSection(dsFuncsProcs, not ObjectVectorIsNilOrEmpty(U.FuncsProcs));
  ConditionallyAddSection(dsTypes, not ObjectVectorIsNilOrEmpty(U.Types));
  ConditionallyAddSection(dsConstants, not ObjectVectorIsNilOrEmpty(U.Constants));
  ConditionallyAddSection(dsVariables, not ObjectVectorIsNilOrEmpty(U.Variables));

  DoMessage(2, mtInformation, 'Writing Docs for unit "%s"', [U.Name]);
  WriteStartOfDocument(U.Name);

  WriteHeading(HL, FLanguage.Translation[trUnit] + ' ' + U.Name);

  WriteUnitDescription(HL + 1, U);

  WriteUnitUses(HL + 1, U);
  
  WriteHeading(HL + 1, FLanguage.Translation[trOverview]);
  WriteCIOSummary(HL + 1, U.CIOs);
  WriteFuncsProcsSummary(HL + 1, U.FuncsProcs);
  
  WriteCIOs(HL + 1, U.CIOs);

  WriteFuncsProcs(HL + 1, U.FuncsProcs);

  WriteAnchor(SectionAnchors[dsTypes],'');
  WriteTypes(HL + 1, U.Types);

  WriteAnchor(SectionAnchors[dsConstants],'');
  WriteConstants(HL + 1, U.Constants);

  WriteAnchor(SectionAnchors[dsVariables],'');
  WriteVariables(HL + 1, U.Variables);

  WriteAuthors(HL + 1, U.Authors);
  WriteDates(HL + 1, U.Created, U.LastMod);
  WriteFooter;
  WriteEndOfDocument;
  CloseStream;
end;

procedure TTexDocGenerator.WriteUnitDescription(HL: integer; U: TPasUnit);
begin
  WriteHeading(HL, FLanguage.Translation[trDescription]);
  WriteItemDetailedDescription(U);
  WriteDirect('',true);
end;

procedure TTexDocGenerator.WriteUnitOverviewFile;
var
  c: TPasItems;
  Item: TPasItem;
  j: Integer;
begin
  c := Units;
  if CreateStream(OverviewFilenames[0] + GetFileExtension, True) = csError
    then begin
    DoMessage(1, mtError, 'Could not create overview output file "' +
      OverviewFilenames[0] + '".', []);
    Exit;
  end;
  DoMessage(3, mtInformation, 'Writing unit overview file "%s" ...',
    [OverviewFilenames[0]]);
  WriteStartOfDocument(FLanguage.Translation[trHeadlineUnits]);
  WriteHeading(1, FLanguage.Translation[trHeadlineUnits]);
  if Assigned(c) and (c.Count > 0) then begin
    WriteStartOfTable2Columns(FLanguage.Translation[trName],
      FLanguage.Translation[trDescription]);
    for j := 0 to c.Count - 1 do begin
      Item := c.PasItemAt[j];
      WriteStartOfTableRow('');
      WriteStartOfTableCell('nowrap="nowrap"', 'itemname');
      WriteLink(Item.FullLink, Item.Name, 'bold');
      WriteEndOfTableCell;

      if j = 0 then
        WriteStartOfTableCell('width="100%"', '')
      else
        WriteStartOfTableCell;
      WriteItemDescription(Item);
      WriteEndOfTableCell;
      WriteEndOfTableRow;
    end;
    WriteEndOfTable;
  end;
  WriteFooter;
  WriteEndOfDocument;
  CloseStream;
end;

procedure TTexDocGenerator.WriteImage(const src, alt, css: string);
var
  s: string;
begin
  if css <> '' then
    s := Format('<img class="%s"', [css])
  else
    s := '<img border="0"';
  WriteDirect(Format('%s src="%s" alt="%s"/>', [s, src, alt]));
end;

procedure TTexDocGenerator.WriteVisibilityCell(const Item: TPasItem);

  procedure WriteVisibilityImage(const Image: string; trans: TTranslationID);
  begin
    WriteImage(Image, ConvertString(FLanguage.Translation[trans]), '');
  end;

begin
{
  case Item.State of
    STATE_PRIVATE:
      WriteVisibilityImage('private.gif', trPrivate);
    STATE_PROTECTED:
      WriteVisibilityImage('protected.gif', trProtected);
    STATE_PUBLIC:
      WriteVisibilityImage('public.gif', trPublic);
    STATE_PUBLISHED:
      WriteVisibilityImage('published.gif', trPublished);
    STATE_AUTOMATED:
      WriteVisibilityImage('automated.gif', trAutomated);
  end;
}  
end;

{ ---------------------------------------------------------------------------- }

procedure TTexDocGenerator.WriteVisibilityLegendFile;

  procedure WriteLegendEntry(const Image: string; trans: TTranslationID);
  begin
    WriteStartOfTableRow('');
    WriteStartOfTableCell();
    WriteImage(Image, ConvertString(FLanguage.Translation[trans]), '');
    WriteEndOfTableCell;
    WriteStartOfTableCell();
    WriteConverted(FLanguage.Translation[trans]);
    WriteEndOfTableCell;
    WriteEndOfTableRow;
  end;

const
  Filename = 'legend';
begin
  if CreateStream(Filename + GetFileextension, True) = csError then
    begin
      DoMessage(1, mtError, 'Could not create output file "%s".',
        [Filename + GetFileExtension]);
      Abort;
    end;
  WriteStartOfDocument(FLanguage.Translation[trLegend]);

  WriteHeading(1, FLanguage.Translation[trLegend]);

  WriteDirect('<table cellspacing="' + HTML_TABLE_CELLSPACING
    + '" cellpadding="' + HTML_TABLE_CELLPADNG + '">', true);
  WriteDirect('<tr class="listheader"><th class="listheader">');
  { TODO -otwm : needs translation }
  WriteConverted('Marker');
  WriteDirect('</th><th class="listheader">');
  { TODO -otwm : needs translation }
  WriteConverted('Visibility');
  WriteDirect('</th></tr>', true);

  WriteLegendEntry('private.gif', trPrivate);
  WriteLegendEntry('protected.gif', trProtected);
  WriteLegendEntry('public.gif', trPublic);
  WriteLegendEntry('published.gif', trPublished);
  WriteLegendEntry('automated.gif', trAutomated);
  WriteEndOfTable;

  WriteFooter;
  WriteEndOfDocument;
end;

{ ---------------------------------------------------------------------------- }

procedure TTexDocGenerator.WriteHierarchy;
var
  Level, OldLevel: Integer;
  Node: TPasItemNode;
begin
  CreateClassHierarchy;

  if CreateStream(OverviewFilenames[1] + GetFileExtension, True) = csError then begin
    DoMessage(1, mtError, 'Could not create output file "%s".',
      [OverviewFilenames[1] + GetFileExtension]);
    Abort;
  end;

  WriteStartOfDocument(FLanguage.Translation[trClassHierarchy]);
  WriteHeading(1, FLanguage.Translation[trClassHierarchy]);

  if FClassHierarchy.IsEmpty then begin
    WriteStartOfParagraph;
    WriteConverted(FLanguage.Translation[trNone]);
    WriteEndOfParagraph;
  end else begin
    OldLevel := -1;
    Node := FClassHierarchy.FirstItem;
    while Node <> nil do begin
      Level := Node.Level;
      if Level > OldLevel then
        WriteDirect('\begin{itemize}',true)
      else
        while Level < OldLevel do begin
          WriteDirect('\end{itemize}',true);
          Dec(OldLevel);
        end;
      OldLevel := Level;

      if Node.Item = nil then
        begin
          WriteDirect('\item ');
          WriteConverted(Node.Name);
          WriteDirect('',true);
        end
      else
        begin
          WriteDirect('\item ');
          WriteLink(Node.Item.FullLink, ConvertString(Node.Name), 'bold');
          WriteDirect('',true);
        end;
      Node := FClassHierarchy.NextItem(Node);
    end;

    while OldLevel > 0 do begin
      WriteDirect('\end{itemize}',true);
      Dec(OldLevel);
    end;
  end;

  WriteFooter;
  WriteEndOfDocument;

  CloseStream;
end;

procedure TTexDocGenerator.LoadFooterFromFile(const AFileName: string);
begin
  LoadStrFromFileA(AFileName, FFooter);
end;

procedure TTexDocGenerator.LoadHeaderFromFile(const AFileName: string);
begin
  LoadStrFromFileA(AFileName, FHeader);
end;

procedure TTexDocGenerator.WriteUnitUses(const HL: integer; U: TPasUnit);
var
  i: Integer;
  ULink: TPasItem;
begin
  if WriteUsesClause and not StringVectorIsNilOrEmpty(U.UsesUnits) then begin
    WriteHeading(HL, 'uses');
    WriteDirect('\begin{itemize}',true);
    for i := 0 to U.UsesUnits.Count-1 do begin
      WriteDirect('\item ');
      ULink := FUnits.FindName(U.UsesUnits[i]);
      if ULink is TPasUnit then begin
        WriteLink(ULink.FullLink, U.UsesUnits[i], 'bold');
      end else begin
        WriteDirect(U.UsesUnits[i]);
      end;
      WriteDirect('');
    end;   
    WriteDirect('\end{itemize}',true);
  end;
end;

procedure TTexDocGenerator.WriteWithURLs(s: string);
var
  s1, s2, link: string;
begin
  while ExtractLink(s, s1, s2, link) do begin
    WriteSpellChecked(S1);
    s:=s2;
  end;
  WriteSpellChecked(s);
end;

procedure TTexDocGenerator.WriteSpellChecked(const AString: string);
var
  LErrors: TObjectVector;
  i, temp: Integer;
  LString, s: string;
begin
  LErrors := TObjectVector.Create(True);
  CheckString(AString, LErrors);
  if LErrors.Count = 0 then begin
    WriteDirect(AString);
  end else begin
    // build s
    s := '';
    LString := AString;
    for i := LErrors.Count-1 downto 0 do begin
      // everything after the offending word
      temp := TSpellingError(LErrors.Items[i]).Offset+Length(TSpellingError(LErrors.Items[i]).Word) + 1;
      s := ( '">' + TSpellingError(LErrors.Items[i]).Word +  '</acronym>' + Copy(LString, temp, MaxInt)) + s; // insert into string
      if Length(TSpellingError(LErrors.Items[i]).Suggestions) > 0 then begin
        s := 'suggestions: '+TSpellingError(LErrors.Items[i]).Suggestions + s;
      end else begin
        s := 'no suggestions' + s;
      end;
      s := '<acronym style="#0000FF; border-bottom: 1px solid crimson" title="' + s;
      SetLength(LString, TSpellingError(LErrors.Items[i]).Offset);
    end;
    WriteDirect(LString);
    WriteDirect(s);
  end;
  LErrors.Free;
end;

procedure TTexDocGenerator.WriteBinaryFiles;
var
  i: Integer;
begin
  CreateStream('automated.gif', True);
  CurrentStream.Write(img_automated[0], High(img_automated)+1);  CloseStream;

  CreateStream('private.gif', True);
  CurrentStream.Write(img_private[0], High(img_private)+1);
  CloseStream;

  CreateStream('protected.gif', True);
  CurrentStream.Write(img_protected[0], High(img_protected)+1);
  CloseStream;

  CreateStream('public.gif', True);
  CurrentStream.Write(img_public[0], High(img_public)+1);
  CloseStream;

  CreateStream('published.gif', True);
  CurrentStream.Write(img_published[0], High(img_published)+1);
  CloseStream;

  if not FileExists(DestinationDirectory+'pasdoc.css') then begin
    CreateStream('pasdoc.css', True);
    StreamUtils.WriteLine(CurrentStream, 'body {' +
      'font-family: Verdana,Arial;' +
      'color: black;' +
      'background-color: white; font-size: 12px; }');
    StreamUtils.WriteLine(CurrentStream, 'body.navigationframe {' +
      'font-family: Verdana,Arial;' +
      'color: white;' +
      'background-color: #787878; font-size: 12px; }');

    StreamUtils.WriteLine(CurrentStream, 'a.navigation:link {' +
      'color: white; text-decoration: none;  font-size: 12px;}');
    StreamUtils.WriteLine(CurrentStream, 'a.navigation:visited {' +
      'color: white; text-decoration: none;  font-size: 12px;}');
    StreamUtils.WriteLine(CurrentStream, 'a.navigation:hover {' +
      'color: white;' +
      'font-weight: bold; text-decoration: none;  font-size: 12px;}');
    StreamUtils.WriteLine(CurrentStream, 'a.navigation:active {' +
      'color: white; text-decoration: none;  font-size: 12px;}');

    StreamUtils.WriteLine(CurrentStream, 'a.normal:link {' +
      'color:#C91E0C; text-decoration: none; }');
    StreamUtils.WriteLine(CurrentStream, 'a.normal:visited {' +
      'color:#7E5C31; text-decoration: none; }');
    StreamUtils.WriteLine(CurrentStream, 'a.normal:hover {' +
      'text-decoration: underline; }');
    StreamUtils.WriteLine(CurrentStream, 'a.normal:active {' +
      'text-decoration: underline; }');

    StreamUtils.WriteLine(CurrentStream, 'a.bold:link {' +
      'color:#C91E0C; text-decoration: none; font-weight:bold; }');
    StreamUtils.WriteLine(CurrentStream, 'a.bold:visited {' +
      'color:#7E5C31; text-decoration: none; font-weight:bold; }');
    StreamUtils.WriteLine(CurrentStream, 'a.bold:hover {' +
      'text-decoration: underline; font-weight:bold; }');
    StreamUtils.WriteLine(CurrentStream, 'a.bold:active {' +
      'text-decoration: underline; font-weight:bold; }');

    StreamUtils.WriteLine(CurrentStream, 'tr.list { background: #FFBF44; }');
    StreamUtils.WriteLine(CurrentStream, 'tr.list2 { background: #FFC982; }');
    StreamUtils.WriteLine(CurrentStream, 'tr.listheader { background: #C91E0C; }');
    StreamUtils.WriteLine(CurrentStream, 'th.listheader { color: white; }');

    StreamUtils.WriteLine(CurrentStream, 'a.section {' +
      'color: green; '+
      'text-decoration: none; '+
      'font-weight: bold; }');
    StreamUtils.WriteLine(CurrentStream, 'a.section:hover {' +
      'color: green; '+
      'text-decoration: underline; '+
      'font-weight: bold; }');
    StreamUtils.WriteLine(CurrentStream, 'td.itemname {' +
      'white-space:nowrap; }');
    StreamUtils.WriteLine(CurrentStream, 'div.nodescription {' +
      'color:red;}');
    StreamUtils.WriteLine(CurrentStream, 'dl.parameters {;}');
    StreamUtils.WriteLine(CurrentStream, 'dt.parameters {' +
      'color:blue;}');
    StreamUtils.WriteLine(CurrentStream, 'dd.parameters {;}');

    CloseStream;
  end;

  CreateStream('index.html', True);
  WriteLine(CurrentStream, '<html><head><title>'+Title+'</title>');
  WriteLine(CurrentStream, '</head><frameset cols="200,*" border="1">');
  WriteLine(CurrentStream, '<frame src="navigation.html"/>');
  WriteLine(CurrentStream, '<frame src="AllUnits.html" name="content"/>');
  WriteLine(CurrentStream, '</frameset></html>');
  CloseStream;

  CreateStream('navigation.html', True);
  WriteLine(CurrentStream, '<html><head>');
  WriteDirect('<link rel="StyleSheet" href="');
  WriteDirect(EscapeURL('pasdoc.css'));
  WriteDirect('"/>', true);
  WriteLine(CurrentStream, '</head>');
  WriteLine(CurrentStream, '<body class="navigationframe">');
  WriteDirect('<h2>'+Title+'</h2>');
  WriteDirect('<table cellspacing="' + HTML_TABLE_CELLSPACING
    + '" cellpadding="' + HTML_TABLE_CELLPADNG
    + '" width="100%">', true);
  for i := 0 to NUM_OVERVIEW_FILES_USED - 1 do begin
    WriteDirect('<tr><td><a target="content" href="' + EscapeURL(OverviewFilenames[i] + GetFileExtension) + '" class="navigation">');
    case i of
      0: WriteConverted(FLanguage.Translation[trUnits]);
      1: WriteConverted(FLanguage.Translation[trClassHierarchy]);
      2: WriteConverted(FLanguage.Translation[trCio]);
      3: WriteConverted(FLanguage.Translation[trTypes]);
      4: WriteConverted(FLanguage.Translation[trVariables]);
      5: WriteConverted(FLanguage.Translation[trConstants]);
      6: WriteConverted(FLanguage.Translation[trFunctionsAndProcedures]);
      7: WriteConverted(FLanguage.Translation[trIdentifiers]);
    end;
    WriteDirect('</a></td></tr>', true);
  end;
  WriteDirect('</table>', true);
  WriteLine(CurrentStream, '</body></html>');
  CloseStream;
end;

function TTEXDocGenerator.ConvertString(const s: String): String;
const
  NumSpecials = 69;  
  Entities: array [1..NumSpecials] of string[12] =
    ('\c{C}','\c{c}',
     '\~{N}','\~{n}',
     '\~{A}','\~{a}',
     '\~{O}','\~{o}',
     '\''{A}','\`{A}',
     '\''{a}','\`{a}',
     '\''{o}','\`{o}',
     '\''{E}','\`{E}',
     '\''{e}','\`{e}',
     '\''{U}','\`{U}',
     '\''{u}','\`{u}',
     '\''{O}','\`{O}',
     '\''{I}','\`{I}',
     '\''{i}','\`{i}',
     '\AA',  ',\aa',
     '\"{A}','\"{a}',
     '\"{E}','\"{e}',
     '\"{U}','\"{u}',
     '\"{O}','\"{o}',
     '\"{I}','\"{i}',
     '\^{U}','\^{u}',
     '\^{I}','\^{i}',
     '\^{a}','\ae',
     '\''{y}','\"{y}',
     '\ss','\AE',
     '\^{E}','\^{e}',
     '\^{o}','\copyright',
     '\S','\pounds',
     '\P','?''',
     '\$','\&',
     '\%','\#',
     '\{','\}',
      '$>$','$<$',
      '\^{}','\verb|\|',
      '\_'
      
    );
  Specials: array [1..NumSpecials] of char =
     ('�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',    
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '�','�',
      '$','&',
      '%','#',
      '{','}',
      '>','<',
      '^','\',
      '_'
      );
      

    function Entity(const Special: Char): String;
    var
      i: Integer;
    begin
      Result := Special;
      for i := 1 to NumSpecials do
        if Specials[i] = Special then
        begin
          Result := Entities[i];
          break;
        end
    end;

var
  i: Integer;
  Ent: string;
begin
  i := 1;
  Result := '';
  for i:=1 to length (s) do
   begin
    Result := Result + Entity(s[i]);
   end;
end;

procedure TTexDocGenerator.BuildLinks;
begin
  FLinkCount := 1;
  inherited;
end;

function TTexDocGenerator.EscapeURL(const AString: string): string;
var
  i: Integer;
begin
  EscapeURL := AString;
end;

end.

{
  $Log$
  Revision 1.4  2004/03/12 05:01:21  ccodere
  added support for properties.
  added support for overview of functions
  some fixes regarding illegal characters
  some fixes regarding some vertical spacing

}