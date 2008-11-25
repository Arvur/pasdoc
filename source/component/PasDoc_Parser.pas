{ @abstract(provides all the parsing functionality of pasdoc)
  @author(Ralf Junker (delphi@zeitungsjunge.de))
  @author(Marco Schmidt (marcoschmidt@geocities.com))
  @author(Johannes Berg <johannes@sipsolutions.de>)
  @author(Michalis Kamburelis)
  @author(Hans-Peter Diettrich <DrDiettrich1@aol.com>)
  @cvs($Date$)

  Parsing implements most of the functionality of the pasdoc program.

  It provides the @link(TParser) object, which scans the command line parameters
  for file names and switches and then starts collecting information from those
  files, issueing warnings to standard out if necessary. }

unit PasDoc_Parser;

(* ToDo:
- use format string for construction of FullDeclaration.
- chain comments on items.
- handle block comment (unchained).
- handle nested declarations (also: generators!)
- parse implementation section
  (using declaration+definition positions, for methods)
- define description sections.
*)

{.$DEFINE ParseParams} //-parse parameter lists? (todo)

{$I pasdoc_defines.inc}

interface

uses
  Classes,
  PasDoc_Types,
  PasDoc_Base,
  PasDoc_Languages,
  PasDoc_Items,
  PasDoc_Scanner,
  PasDoc_Tokenizer,
  PasDoc_StringVector;

const
//Descriptive comment markers
  cmNoRem = #0;
  cmIgnore = '-';
  cmFwd = '>';
  cmBack = '<';
  cmBlock = '[';
  cmEnd = ']';
  cmMarkers = [cmIgnore, cmFwd, cmBack, cmBlock, cmEnd];

type
  { Parser class that will process a complete unit file and all of its
    include files, regarding directives.
    When creating this object constructor @link(Create) takes as an argument
    an input stream and a list of directives.
    Parsing work is done by calling @link(ParseUnitOrProgram) method.
    If no errors appear, should return a @link(TPasUnit) object with
    all information on the unit. Else exception is raised.

    Things that parser inits in items it returns:

    @unorderedList(
      @item(Of every TPasItem :
        Name, RawDescription, Visibility, IsDeprecated, IsPlatformSpecific,
        IsLibrarySpecific, FullDeclararation (note: for now not all items
        get sensible FullDeclararation, but the intention is to improve this
        over time; see @link(TPasItem.FullDeclaration) to know where
        FullDeclararation is available now).

        Note to IsDeprecated: parser inits it basing on hint directive
        "deprecated" presence in source file; it doesn't handle the fact
        that @@deprecated tag may be specified inside RawDescription.

        Note to RawDescription: parser inits them from user's comments
        that preceded given item in source file.
        It doesn't handle the fact that @@member and @@value tags
        may also assign RawDescription for some item.)

      @item Of TPasCio: Ancestors, Fields, Methods, Properties, MyType.

      @item Of TPasEnum: Members, FullDeclararation.

      @item Of TPasMethod: What.

      @item Of TPasVarConst: FullDeclaration.

      @item(Of TPasProperty: IndexDecl, FullDeclaration.
        PropType (only if was specified in property declaration).
        It was intended that parser will also set Default,
        NoDefault, StoredId, DefaultId, Reader, Writer attributes,
        but it's still not implemented.)

      @item(Of TPasUnit; UsesUnits, Types, Variables, CIOs, Constants,
        FuncsProcs.)
    )

    It doesn't init other values.
    E.g. AbstractDescription or DetailedDescription of TPasItem
    should be inited while expanding this item's tags.
    E.g. SourceFileDateTime and SourceFileName of TPasUnit must
    be set by other means. }
  TParser = class
  private
    FImplicitVisibility: TImplicitVisibility;

    { The underlying scanner object. }
    Scanner: TScanner;

  {$IFDEF old}
    FOnMessage: TPasDocMessageEvent;
    FVerbosity: Cardinal;
    procedure DoMessage(const AVerbosity: Cardinal; const MessageType:
      TPasDocMessageType; const AMessage: string; const AArguments: array of const);
  {$ELSE}
    FDoc: TPasDoc;
  {$ENDIF}
    procedure DoError(const AMessage: string;
      const AArguments: array of const);

  protected
  //Token + whitespace recorder
    Token, Peeked: TToken;
    Recorder: string;
    PrevRecordSize: integer;

    { Reads scanner tokens, recording and skipping whitespace and comments.

      Returns non-white token that was found.
      Calling this method twice in a row will return the same thing.

      Always returns something non-nil (will raise exception in case
      of problems, e.g. when stream ended). }
    function PeekNextToken: TTokenType;
  //Make next token current, record it.
    function  GetNextToken: TTokenType;
  //Makes previously peeked token current and records it.
    procedure ConsumeToken;
  //Return recorded tokens. Optionally strip last token.
  //Recorder is cleared.
    function  Recorded(fStripLast: boolean = False): string;
  //Get next token and verify that it has the expected TTokenType.
    procedure Expect(tt: TTokenType);
  //Get next token, if it has the expected type.
    function  Skip(tt: TTokenType): boolean; overload;
  //Get next token, if it is the expected directive.
    function  Skip(dir: TStandardDirective): boolean; overload;

    { Checks if T.MyType is ATokenType, if not calls DoError
      with appropriate error mesg. }
    procedure CheckToken(T: TToken; ATokenType: TTokenType);

  protected
    FCommentMarkers: TStringList;
    FMarkersOptional: boolean;
    FIgnoreLeading: string;
  //Token chain
    Pending, BlockComment: TToken;
  //Tentative item, initialized by QualID.
    Identifier: TToken;

    { These are the items that the next "back-comment"
      (the comment starting with "<", see
      [http://pasdoc.sipsolutions.net/WhereToPlaceComments]
      section "Placing comments after the item") will apply to. }
    DeclLast: TPasItem;
    CurScope: TPasScope;
    ScopeStack: TList;
    procedure OpenScope(AScope: TPasScope);
    function  CloseScope: TPasScope;

  (* New comment model:
    Comments are kept in a token chain.
    C-style comments are collected into one (the first) token,
      as long as all comments come from the same stream.
    New comments are chained by PeekNextToken.
    CreateItem will remove (add or discard) all comments, preceding the new item.
      Pending comments from different streams are discarded.
  *)
  //apply comment to the (just created) item.
  {$IFDEF old}
    procedure ApplyComments(item: TPasItem);
  {$ELSE}
    procedure FlushBackRems(item: TPasItem; tlim: TToken);
    procedure FlushFwdRems(item: TPasItem);
  {$ENDIF}
  //try append description, return succ/fail
    function  AddDescription(var t: TToken; item: TPasItem = nil;
      fDestroy: boolean = True): boolean;
  //not yet...
    //function  ShiftComments: boolean;
    procedure CancelComments;
  //put new comment into the queue
    procedure PushComment(var C: TToken);

  (* parse qualified identifier, get first ident if fGet.  *)
    function  QualID(fGet: boolean; fOperator: boolean = False): TToken;

  (* Create an item in CurScope, using the given identifier token.
    Make the new item the target for back-comments, i.e. store in DeclLast.
  *)
    function CreateItem(AClass: TPasItemClass; tt: TTokenType; Ident: TToken): TPasItem;

  (* Parse an identifier list, create an item for every identifier.
    Return the first of these items, the last one is stored in DeclLast.
  *)
    function ParseVarList: TPasItem;

    { Parse variables or fields clause
      ("one clause" is something like
        NAME1, NAME2, ... : TYPE;
      i.e. a list of variables/fields sharing one type declaration.)

      @param(inUnit: also parse FPC modifiers?)
    }
    procedure ParseVariables(inUnit: boolean);

    { Read all tokens until you find a semicolon at brace-level 0 and
      end-level (between "record" and "end" keywords) also 0.

      Also stops before reading "end" without beginning
      "record" (so it can handle some cases where declaration doesn't end
      with semicolon).

      Also stops before reading ')' without matching '('.
      That's because fields' declarations
      inside record case may be terminated by just ')' indicating
      that this case clause terminates, without a semicolon.

      If you pass CurItem <> nil then all read data will be
      appended to Item.FullDeclaration, and directives will be added to the
      item attributes. }
    procedure SkipDeclaration(fSkipNext: boolean; CurItem: TPasItem);

    { Parses a constructor, a destructor, a function or a procedure
      or an operator (for FPC).
      Resulting @link(TPasMethod) item will be returned.

      MethodType is used for the What field of the resulting TPasMethod. }
    function  ParseCDFP(MethodType: TTokenType; Ident: TToken): TPasMethod;

    { Parses an structured type, e.g. class or record.
      CIOType is the according declaration token type.
      IsInRecordCase cares for special (nested) record declaration. }
      function ParseCIO(Ident: TToken; CIOType: TTokenType;
        const IsInRecordCase: boolean): TPasCio;

    procedure ParseRecordCase(const SubCase: boolean);
    procedure ParseConstant;
    procedure ParseInterfaceSection(const U: TPasUnit);
  //properties for units or CIOs - deserves a common base class?
    function  ParseProperty: TPasProperty;
    procedure ParseType;

    { This assumes that you just read left parenthesis starting
      an enumerated type. It finishes parsing of TPasEnum,
      returning it. }
    function  ParseEnum: TPasEnum;

    procedure ParseUses(const U: TPasUnit);

  {$IFDEF old}
    procedure SetCommentMarkers(const Value: TStringList);
  {$ELSE}
  {$ENDIF}

    { Skips all whitespace and comments and while it sees some hint directive
      (platform, library, deprecated) it consumes it, sets appropriate
      property of Item (IsPlatformSpecific, IsLibrarySpecific or IsDeprecated)
      to true and goes further.

      Stops when PeekNextToken returns some non-whitespace non-comment
      non-hint-directive token. }
    procedure ParseHintDirectives(Item: TPasItem);

    procedure ParseUnit(U: TPasUnit);
    procedure ParseProgram(U: TPasUnit);
    procedure ParseProgramOrLibraryUses(U: TPasUnit);
    procedure ParseLibrary(U: TPasUnit);
  public
  (* New comment handling, if True:
    The first character of an comment can be one of:
    "-" cmIgnore - the comment is ignored.
    "<" cmBack - the comment is a back-comment, on the preceding item.
    ">" cmFwd - the comment is a forward comment, on the following item.
    These marker characters are removed from the description text.

    Not implemented, should become a different option:
    Unmarked comments are ignored, unless markers are optional. In this case
    the direction of the comment is determined by the comment style:
    Pascal comments become forward comments,
    C-style comments become back-comments.
  *)
    SingleCharMarkers: boolean;
  {$IFDEF old}
    { Create a parser, initialize the scanner with input stream S.
      All strings in SD are defined compiler directives. }
    constructor Create(
      const InputStream: TStream;
      const Directives: TStringVector;
      const IncludeFilePaths: TStringVector;
      const OnMessageEvent: TPasDocMessageEvent;
      const VerbosityLevel: Cardinal;
      const AStreamName, AStreamPath: string;
      const AHandleMacros: boolean);
  {$ELSE}
    { Create a parser, initialize the scanner with input stream S.
      All strings in SD are defined compiler directives. }
    constructor Create(ADoc: TPasDoc; InputStream: TStream; const AStreamName, AStreamPath: string);
  {$ENDIF}

    { Release all dynamically allocated memory. }
    destructor Destroy; override;

    { This does the real parsing work, creating U unit and parsing
      InputStream and filling all U properties. }
    procedure ParseUnitOrProgram(var U: TPasUnit);

  {$IFDEF old}
    property OnMessage: TPasDocMessageEvent read FOnMessage write FOnMessage;
    property CommentMarkers: TStringList read FCommentMarkers write SetCommentMarkers;
  //if this is ever needed... (ShowVisibilities was moved into PasDoc_items)
    class function ShowVisibilities: TVisibilities;
  {$ELSE}
  //refers to the global CommentMarkers option.
    property CommentMarkers: TStringList read FCommentMarkers write FCommentMarkers;
  {$ENDIF}
    property MarkersOptional: boolean read fMarkersOptional write fMarkersOptional;
    property IgnoreLeading: string read FIgnoreLeading write FIgnoreLeading;

    { See command-line option @--implicit-visibility documentation at
      [http://pasdoc.sipsolutions.net/ImplicitVisibilityOption] }
    property ImplicitVisibility: TImplicitVisibility
      read FImplicitVisibility write FImplicitVisibility;
  end;

implementation

uses
  SysUtils,
  PasDoc_Utils;

procedure DebugBreak;
begin
  //dummy for debugging
end;

{ ---------------------------------------------------------------------------- }
{ TParser }
{ ---------------------------------------------------------------------------- }

{$IFDEF old}
constructor TParser.Create(
  const InputStream: TStream;
  const Directives: TStringVector;
  const IncludeFilePaths: TStringVector;
  const OnMessageEvent: TPasDocMessageEvent;
  const VerbosityLevel: Cardinal;
  const AStreamName, AStreamPath: string;
  const AHandleMacros: boolean);
begin
  inherited Create;
  FOnMessage := OnMessageEvent;
  FVerbosity := VerbosityLevel;

  Scanner := TScanner.Create(InputStream, OnMessageEvent,
    VerbosityLevel, AStreamName, AStreamPath, AHandleMacros);
  Scanner.AddSymbols(Directives);
  Scanner.IncludeFilePaths := IncludeFilePaths;
  FCommentMarkers := TStringlist.Create;
  //ItemsForNextBackComment := TPasItems.Create(false);
  ScopeStack := TList.Create;
end;
{$ELSE}

constructor TParser.Create(ADoc: TPasDoc; InputStream: TStream;
  const AStreamName, AStreamPath: string);
begin
  inherited Create;
{$IFDEF old}
  FOnMessage := CmdOptions.OnMessage;
  FVerbosity := CmdOptions.Verbosity;
{$ELSE}
  FDoc := ADoc;
{$ENDIF}

{$IFDEF old}
  Scanner := TScanner.Create(InputStream, OnMessageEvent,
    VerbosityLevel, AStreamName, AStreamPath, AHandleMacros);
  Scanner.AddSymbols(Directives);
  Scanner.IncludeFilePaths := IncludeFilePaths;
  FCommentMarkers := TStringlist.Create;
{$ELSE}
  Scanner := TScanner.Create(FDoc, InputStream, AStreamName, AStreamPath);
  ImplicitVisibility := FDoc.ImplicitVisibility;
  CommentMarkers := FDoc.CommentMarkers;
  MarkersOptional := FDoc.MarkerOptional;
  SingleCharMarkers := FDoc.SingleCharMarkers;
  IgnoreLeading := FDoc.IgnoreLeading;
{$ENDIF}

  //ItemsForNextBackComment := TPasItems.Create(false);
  ScopeStack := TList.Create;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }

destructor TParser.Destroy;
begin
{$IFDEF old}
  FCommentMarkers.Free;
{$ELSE}
  //owned by doc/generator
{$ENDIF}
  Scanner.Free;
  ScopeStack.Free;
  Peeked.Free;
  Token.Free;
  Identifier.Free;
  CancelComments; //move to the begin?
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TParser.DoError(const AMessage: string;
  const AArguments: array of const);
begin
  raise EPasDoc.Create(Scanner.GetStreamInfo + ': ' + AMessage, AArguments, 1);
end;

{$IFDEF old}
procedure TParser.DoMessage(const AVerbosity: Cardinal; const MessageType:
  TPasDocMessageType; const AMessage: string; const AArguments: array of const);
begin
  if (AVerbosity <= FVerbosity) and Assigned(FOnMessage) then
    FOnMessage(MessageType, Format(AMessage, AArguments), AVerbosity);
end;
{$ELSE}
{$ENDIF}

{ ---------------------------------------------------------------------------- }

function TParser.PeekNextToken: TTokenType;
var
  T: TToken;
  C: TToken;

  { The comment is intended to be a "documentation comment",
    i.e. we intend to put it inside output documentation.
    So comment markers, if present, are removed from the beginning of the data.
    Also, if comment markers were required but were not present,
    then CommentInfo.Content is an empty string.

    Also back-comment marker, the '<', is removed, if exists,
    and BackComment is set to @true. Otherwise BackComment is @false. }
  procedure ExtractDocComment;
  const
    BackCommentMarker = '<';
  var
    i: integer;
    Marker: string;
    WasMarker: boolean;
    cm: char;
  begin
    if SingleCharMarkers then begin
      cm := C.data[1];
      if cm in cmMarkers then
        Delete(C.Data, 1, 1)
      else begin
        WasMarker := cm in ['/', '*'];
        if WasMarker then
          Delete(C.Data, 1, 1);
        if (C.MyType = TOK_COMMENT_CSTYLE) = WasMarker then
        // ( * or / / /
          cm := cmFwd
        else  // ( ** or / /
          cm := cmBack;
      end;
    end else begin
      cm := cmFwd;  //default

      if CommentMarkers.Count > 0 then begin
      //markers are essential at all
        WasMarker := false;
        for i := 0 to CommentMarkers.Count - 1 do begin
          Marker := CommentMarkers[i];
          if IsPrefix(Marker, c.Data) then begin
            Delete(C.Data, 1, Length(Marker));
            WasMarker := true;
            Break;
          end;
        end;

        if (not MarkersOptional) and (not WasMarker) then
          cm := cmIgnore;
      end;
      if (cm = cmFwd) and (c.Data <> '') then begin
        case c.Data[1] of
        BackCommentMarker:  cm := cmBack;
        cmIgnore: cm := cmIgnore;
        end;
        if cm <> cmFwd then
          Delete(C.Data, 1, Length(BackCommentMarker));
      end;
    end;
  //now dispatch
    if cm = cmIgnore then
      FreeAndNil(C)
    else begin
      c.Mark := cm;
      PushComment(C);
    end;
    if assigned(C) then
      DebugBreak;
  end;

  { Collect multiple C-style comments.
    Dispatch non-C-style comments immediately.
    Also flush stream/style mismatched comments.
  }
  procedure Collect(fCstyle: boolean);
  begin
    if (C <> nil) then begin
    //check for extension of an pending C style comment
      if (c.StreamName <> t.StreamName) or not fCstyle then begin
      //cannot append: different stream or comment style
        ExtractDocComment;  //old comment
        assert(C = nil, 'comment not dispatched');
      end;
    end;
    if C = nil then begin
    //first comment
    //clear pending comments if empty?
    (* Problem: comments starting with newline!
    *)
      //if t.CommentContent <= ' ' then begin
      if (t.CommentContent = '') or (t.CommentContent = ' ') then begin
        CancelComments;
        FreeAndNil(t);
        exit;
      end;
      TToken(C) := T;
      T := nil;
      if not fCstyle then
        ExtractDocComment; //finish comment
  //else a C-style comment is waiting for continuation
    end else begin  //all conditions checked above!
    //append to preceding comment
      C.CommentContent := C.CommentContent + LineEnding + T.CommentContent;
      c.EndPosition := t.EndPosition;
      FreeAndNil(T);
    end;
  end;

begin
  if Peeked <> nil then begin
    Result := Peeked.MyType;
    exit;
  end;
//peek next
  C := nil; //mark no rem found
  PrevRecordSize := Length(Recorder); //allow to strip last token added
  repeat  //while state < psGotRem do begin
    t := Scanner.GetToken;
    case t.MyType of
    TOK_COMMENT_PAS, TOK_COMMENT_EXT:
      Collect(False);
    TOK_COMMENT_CSTYLE:
      Collect(True);
    TOK_WHITESPACE:
      begin
        if C = nil then //ignore between comments?
          Recorder := Recorder + ' '; //compress FullDeclaration
        FreeAndNil(T);
      end;
    else //case
      break;  //don't consume!
    end;
  until assigned(T);
//did we get an comment?
  if assigned(C) then
    ExtractDocComment;
  Peeked := t;
  Result := t.MyType;
end;

function TParser.Recorded(fStripLast: boolean): string;
begin
  Result := Recorder;
  if fStripLast then
    SetLength(Result, PrevRecordSize);
  Recorder := '';
end;

procedure TParser.CancelComments;
var
  c: TToken;
begin
{$IFDEF old}
//flush back rems?
  FlushBackRems(DeclLast, nil);
{$ELSE}
{$ENDIF}
//kill all comments
  while Pending <> nil do begin
    c := Pending;
    Pending := c.Next;
    c.Free;
  end;
end;

procedure TParser.PushComment(var C: TToken);

  procedure AppendIt;
  var
    t: TToken;
  begin
    t := Pending;
    if t = nil then
      Pending := c
    else begin
      while t.Next <> nil do
        t := t.Next;
    //link token here
      t.Next := c;
    end;
    c := nil;
  end;

begin //PushComment
//called from PeekNextToken
  assert(assigned(c), 'cannot push Nil comment');
  case c.Mark of
  cmNoRem,  //???
  cmIgnore: FreeAndNil(C);
  cmBlock:
    begin
      BlockComment.Free;
      BlockComment := c;
      c := nil;
    end;
  cmEnd:
    begin
      FreeAndNil(BlockComment);
      FreeAndNil(C);
    end;
{$IFDEF old}
  cmBack: //try apply immediately
    if not AddDescription(C) then
      AppendIt;
{$ELSE}
{$ENDIF}
  else  //any (forward) comment
    AppendIt;
  end;
end;

function TParser.AddDescription(var t: TToken; item: TPasItem; fDestroy: boolean): boolean;
//var  p: PRawDescriptionInfo;
begin
//currently the result is always True (remove?)
  //Result := False; //in case of any errors
//check item
  if item = nil then begin
    if CurScope.Members.Count <= 0 then begin
    //back-comment to the scope item itself!
      item := CurScope;
      //exit; //not item for comment
    end else
      item := CurScope.Members.LastItem
  end;
{$IFDEF old}
//first description?
  p := item.RawDescriptionInfo;
  if p^.Content = '' then begin
  //first description
    p^.Content := T.CommentContent;
    p^.StreamName := T.StreamName;
    p^.BeginPosition := T.BeginPosition;
  end else begin
    p^.Content := p^.Content + LineEnding + t.CommentContent;
    if p^.StreamName <> t.StreamName then
      p^.StreamName := ' ';  //should never occur here!
  end;
  p^.EndPosition := T.EndPosition;
  if fDestroy then FreeAndNil(t);
{$ELSE}
  item.AddRawDescription(t);
  t := nil;
{$ENDIF}
  Result := True;
end;

{$IFDEF old}
procedure TParser.ApplyComments(item: TPasItem);
var
  t: TToken;

  procedure DiscardT;
  begin
    DoMessage(2, pmtWarning, 'Comment discarded: "%s"', [t.CommentContent]);
    FreeAndNil(t);
  end;

begin
(* Called just after creation of item, or before CloseScope.
  DeclLast contains the previous item, item is the new one.
  Apply all pending comments (before item) to these two:
  [- pending fwd to DeclLast (? should have been done already!)]
  - pending back, before item, to DeclLast
    (all if DeclLast = nil, on CloseScope)?
  - pending fwd on item

  When a scope is closed, following back-comments must go into the scope item!
  (different procedure!)
*)
(* When the implementation is parsed, the target item may have different
  declaration and definition addresses! This can occur only with procedures,
  which must have both their declaration and definition position stored.
  Both positions are initialized to the same values, on item creation, the
  definition position can be updated later, and is used to determine the
  applicable comments.
*)
(* Block comments shall go into a special location (scope!?).
  Other comments shall be chained to the item.
  Allow for comments from external file?!
*)
  assert(item <> nil, 'cannot add comments to Nil');
  if assigned(BlockComment) and (BlockComment.BeginPosition < item.NamePosition) then
    AddDescription(BlockComment, item, False); //don't destroy!!!
  //else applies to following items only
//inspect all pending comments
  while Pending <> nil do begin
    t := Pending;
    Pending := t.Next;
    if t.StreamName <> item.NameStream then begin
      //DiscardT()
      DoMessage(1, pmtWarning,
        '%s: Comment in different file: "%s"',
        [Scanner.GetStreamInfo, t.CommentContent]);
      FreeAndNil(t);
    end else if (t.Mark = cmFwd) then begin
      if t.EndPosition > item.NamePosition then
        break;  //applies to following item
      AddDescription(t, item);
    end else if t.BeginPosition < item.NamePosition then begin //back comment
      //DiscardT()
      DoMessage(1, pmtWarning,
        '%s: No target for back-comment: "%s"',
        [Scanner.GetStreamInfo, t.CommentContent]);
        FreeAndNil(t);
    end else
      AddDescription(t, item);
    assert(t=nil, 'comment not destroyed');
  end;
//all remaining comments apply to following items
end;
{$ELSE}
{$ENDIF}

procedure TParser.FlushBackRems(item: TPasItem; tlim: TToken);
var
  t: TToken;

  procedure DropRem;
  begin
    FDoc.DoMessage(2, pmtWarning, 'Stream mismatch comment: "%s"', [t.CommentContent]);
    Pending := t.Next;
    FreeAndNil(t);
  end;

begin
(* add back comments to item, residing before tlim.
  Break on position > limit, fwd rem.
  Stream mismatch? (may apply to following token?)
  Discard position < item (no target)
*)
  if not Assigned(Pending) then
    exit;
//allow for Nil token - use peeked token
  if not Assigned(tlim) then begin
    PeekNextToken;
    tlim := Peeked;
  end;
  while assigned(Pending) do begin
    t := Pending;
    if t.StreamName <> item.NameStream then
      DropRem
    else if t.BeginPosition >= tlim.BeginPosition then
      break
    else if t.Mark <> cmBack then
      break
    else begin
      Pending := t.Next;
      AddDescription(t, item);
    end;
  end;
end;

procedure TParser.FlushFwdRems(item: TPasItem);
var
  t: TToken;
begin
(* Add fwd comments to item, until position > item position.
  Discard on stream mismatch.
  Warn on back comment befor item position (no target)
*)
  while assigned(Pending) do begin
    t := Pending;
    if t.StreamName <> item.NameStream then begin
      FDoc.DoMessage(2, pmtWarning, 'Stream mismatch comment: "%s"', [t.CommentContent]);
      Pending := t.Next;
      FreeAndNil(t);
    end else if t.BeginPosition > item.NamePosition then
      break //may be back rem, handled later
    else if t.Mark <> cmFwd then begin
      FDoc.DoMessage(2, pmtWarning, 'No target for back comment: "%s"', [t.CommentContent]);
      Pending := t.Next;
      FreeAndNil(t);
    end else begin
      Pending := t.Next;
      AddDescription(t, item);
    end;
  end;
end;

function TParser.CloseScope: TPasScope;
begin
(* Flush pending comments on last item - but only *before* closing token!
*)
  if Assigned(Pending) and Assigned(DeclLast) then
    FlushBackRems(DeclLast, Token);
  Result := CurScope; //old scope, to be closed
  DeclLast := Result; //for eventual further back-comments
  pointer(CurScope) := ScopeStack.Last;
  ScopeStack.Delete(ScopeStack.Count - 1);
end;

procedure TParser.OpenScope(AScope: TPasScope);
begin
  ScopeStack.Add(CurScope);
  CurScope := AScope;
end;

{ ---------------------------------------------------------------------------- }

const
  SExpectedButFound = '%s expected but %s found';

procedure TParser.CheckToken(T: TToken; ATokenType: TTokenType);
begin
//short version, error messages differ from old version! - really?
  if T.MyType <> ATokenType then
    DoError(SExpectedButFound, [TokenDefinition(ATokenType), T.Description]);
end;

procedure TParser.ConsumeToken;
begin
//valid only after a PeekNextToken! (Peeked must not be Nil)
  assert(Peeked <> nil, 'illegal ConsumeToken');
  Token.Free;
  Token := Peeked;
  Peeked := nil;
  Recorder := Recorder + Token.Data;
end;

function TParser.GetNextToken: TTokenType;
begin
  Result := PeekNextToken;
  ConsumeToken;
end;

procedure TParser.Expect(tt: TTokenType);
begin
  if GetNextToken <> tt then
    CheckToken(Token, tt);
end;

function TParser.Skip(tt: TTokenType): boolean;
begin
  Result := PeekNextToken = tt;
  if Result then
    ConsumeToken;
end;

function TParser.Skip(dir: TStandardDirective): boolean;
begin
  Result := (PeekNextToken = TOK_IDENTIFIER) and (Peeked.Directive = dir);
  if Result then
    ConsumeToken;
end;

{ ---------------------------------------------------------------------------- }

function  TParser.QualID(fGet: boolean; fOperator: boolean): TToken;
begin
(* get an fully qualified name, remember first token.
*)
//assumed: <ident> { "." <ident> }
  if fGet then
    GetNextToken;
  if fOperator and (Token.MyType in sOperator) then
    //okay
  else
    CheckToken(Token, TOK_IDENTIFIER);
//remember token
  Identifier := Token;
  Token := nil; //dangerous!!!
  if not fOperator then begin
  //collect qualifiers - the last token is the real identifier!
    while Skip(SYM_PERIOD) do begin
      Expect(TOK_IDENTIFIER);
      Identifier.Data := Identifier.Data + '.' + Token.Data;
    end;
  end;
//result, for convenience only
  Result := Identifier;
end;

function TParser.CreateItem(AClass: TPasItemClass; tt: TTokenType;
  Ident: TToken): TPasItem;
begin
//get identifier
  if Ident = nil then
    Ident := QualID(True); //assume: must read the name
//flush pending back comments
  if Assigned(DeclLast) then
    FlushBackRems(DeclLast, Ident);
  Result := AClass.Create(CurScope, tt, Ident.Data);
  Result.NameStream := Ident.StreamName;
  Result.NamePosition := Ident.BeginPosition;
  FreeAndNil(Identifier); //???
//init varlist processing
(* actually DeclLast is the previously created item (if any).
  Pending back-comments can be applied to it safely, up to the new item.
*)
  FlushFwdRems(Result);
  DeclLast := Result;
end;

function TParser.ParseVarList(): TPasItem;
const
  AClass: TPasItemClass = TPasFieldVariable;
  tt = KEY_VAR;
begin
(* ident <| { "," ident } |>
*)
(* The first and last item in the list should be tracked, for propagation of
  - declaration (as template)
  - attributes
  - comments (back-comments!)
*)
  Result := CreateItem(AClass, tt, QualID(False));
  while Skip(SYM_COMMA) do begin
    CreateItem(AClass, tt, nil); //sets DeclLast
  end;
//next token peeked, but not consumed (typically: ":")
end;

procedure TParser.ParseVariables(inUnit: boolean);

  // The section allows PasDoc to parse variable modifiers in FPC.
  // See: http://www.freepascal.org/docs-html/ref/refse19.html
  // This consumes some tokens and appends to ItemCollector.FullDeclaration.
  procedure ParseVariableModifiers(ItemCollector: TPasItem);
  begin
  (* <| { CVAR | EXPORT | PUBLIC | EXTERNAL ... ";" } |>
  *)
    while True do begin
      PeekNextToken;
      if not (Peeked.Directive in [SD_CVAR, SD_EXPORT, SD_EXTERNAL, SD_PUBLIC]) then
        break;  //not an expected directive
      ItemCollector.HasAttribute[Peeked.Directive] := True;
        //!Public here is NOT visibility! (Unit vars have no visibility, so far)
    //skip including ";"
      while GetNextToken <> SYM_SEMICOLON do
        ;
    end;
  end;

var
  FirstItem, NewItem, RemItem: TPasItem;
  t: TToken;
  I, fi, j, n: Integer;
  m: array of char; //all comment markers - could be useful in scope!?
begin //ParseFieldsVariables
(* ident <| { "," ident } ":" type [absolute] ";" [ modifiers ";" ] |>
*)
//parse ident list
  FirstItem := ParseVarList;
//record type
  Recorder := '';
  Expect(SYM_COLON);
  SkipDeclaration(False, FirstItem);
//past ";" or ")" or END
  if inUnit then  //modifiers apply only to unit variables
    ParseVariableModifiers(FirstItem);
  //FirstItem.FullDeclaration := Recorded; //???
  FlushBackRems(DeclLast, nil);

(* Propagate into all new items:
  - recorded declaration
  - recorded attributes
We assume that at most one rem is assigned to an item!
*)
  n := CurScope.Members.Count;
  SetLength(m, n);
  FillChar(m[0], n, cmNoRem);
  I := n - 1;
  while i >= 0 do begin
    NewItem := CurScope.Members.PasItemAt[i];
    t := NewItem.FirstDescription;
    if t <> nil then
      m[i] := t.Mark;
    NewItem.FullDeclaration := NewItem.Name + Recorder;
    if NewItem = FirstItem then
      break;  //this one already finished
    NewItem.Attributes := FirstItem.Attributes;
    dec(i);
  end;
  Recorder := '';
// i at FirstItem
  fi := i;
//propagate rems. Forward first, back last.
  RemItem := nil;
  for i := fi to n - 1 do begin
    NewItem := CurScope.Members.PasItemAt[i];
    if m[i] = cmBack then begin
    //propagate back rems
      RemItem := NewItem;
      for j := i-1 downto fi do begin
        if m[j] <> cmNoRem then
          break; //already has a description
        NewItem := CurScope.Members.PasItemAt[j];
        NewItem.RawDescriptions.Text := RemItem.RawDescriptions.Text;
      end;
      RemItem := nil; //was back rem
    end else if m[i] = cmFwd then begin
    //propagate rem fwd
      RemItem := NewItem;
    end else if assigned(RemItem) then
    //copy rem
      NewItem.RawDescriptions.Text := RemItem.RawDescriptions.Text;
  end;
end;

{ ---------------------------------------------------------------------------- }

function  TParser.ParseCDFP(MethodType: TTokenType; Ident: TToken): TPasMethod;

  { Reads tokens (adding them to M.FullDeclaration) until a semicolon
    (on parenthesis level zero) is found (this final semicolon
    is also read and appended to M.FullDeclaration). }
  procedure ReadTokensUntilSemicolon;
  var
    level: integer;
  begin
    level := 0;
    repeat
      case GetNextToken of
      SYM_LEFT_PARENTHESIS: Inc(level);
      SYM_RIGHT_PARENTHESIS: dec(level);
      SYM_SEMICOLON: if level = 0 then break;
      end;
    until False;
  end;

  procedure PeekSemicolon;
  begin
    repeat
      GetNextToken; //record it!
    until PeekNextToken = SYM_SEMICOLON;
  end;

{ Apparently, the Delphi compiler does NOT enforce that
  directives must be separated and be terminated by a semicolon,
  even though Delphi help consistently uses them consistently.
  However, we take the compiler as a reference and try to mimic its behaviour.
}
  procedure InsertSemicolon;
  begin
    if Peeked.MyType = SYM_SEMICOLON then
      GetNextToken //consume and record
    else
      Recorder := Recorder + ';';
  end;

var
  M: TPasMethod absolute Result;
begin //ParseCDFP
{ Parses a constructor, a destructor, a function or a procedure
      or an operator (for FPC).

FPC grammar states that modifiers are separated by ";",
  but are not necessarily terminated by ";"
Delphi also doesn't require an ";" between modifiers!

Modifiers with arguments:
  ALIAS ":" string
  EXTERNAL [ string ]
  NAME string
  INDEX expr
The arguments can be identifiers, so that we should assume that
  modifiers with arguments are terminated by ";"
}
//parse method declaration
  if Ident = nil then
    Ident := QualID(True, True);  //allow for operator???
  M := CreateItem(TPasMethod, MethodType, Ident) as TPasMethod;

  FDoc.DoMessage(5, pmtInformation, 'Parsing %s "%s"',
    [LowerCase(TokenNames[MethodType]), M.Name]);

{$IFDEF ParseParams}
  if Skip(SYM_LEFT_PARENTHESIS) then begin
    OpenScope(M);
    while GetNextToken in [KEY_VAR, KEY_CONST, KEY_IN, key_out] do //"out"? continue
      ;
    while Skip(TOK_IDENTIFIER) do begin
      ParseVariables(False);
      if not Skip(SYM_SEMICOLON) then
        break;
    end;
    CloseScope;
    Expect(SYM_RIGHT_PARENTHESIS);
  end;
{$ELSE}
{$ENDIF}
  ReadTokensUntilSemicolon; //function type!?

  { first get non-WC token - if it is not an identifier in SD_SET put it back
    into stream and leave; otherwise copy tokens until semicolon }
  repeat
    //case GetNextToken of
    case PeekNextToken of
    KEY_INLINE:   M.HasAttribute[SD_INLINE_] := True;
    KEY_LIBRARY:  M.HasAttribute[SD_LIBRARY_] := True;
    TOK_IDENTIFIER:
      case Peeked.Directive of
      SD_ABSTRACT, SD_ASSEMBLER, SD_CDECL, SD_DYNAMIC, SD_EXPORT,
      SD_FAR, SD_FORWARD, SD_NEAR, SD_OVERLOAD, SD_OVERRIDE,
      //SD_INLINE, is KEY_INLINE!
      SD_PASCAL, SD_REGISTER, SD_SAFECALL, SD_STATIC,
      SD_STDCALL, SD_REINTRODUCE, SD_VIRTUAL,
      SD_VARARGS,
      SD_DEPRECATED,
      SD_PLATFORM:
        M.HasAttribute[Peeked.Directive] := True;
      { * External declarations might be followed by a string constant.
        * Messages are followed by an integer constant between 1 and 49151 which
          specifies the message ID. }
      SD_EXTERNAL, SD_MESSAGE, SD_NAME,
      SD_DISPID:
        begin
          M.HasAttribute[Peeked.Directive] := True;
        // Keep on reading up to the next semicolon or declaration
          PeekSemicolon;
        end;
      else  //case directive
        Break;
      end;
    else //case type
      Break;
    end;
  (* We come here with either:
    PeekSemicolon: Peeked=";"
    or an valid unconsumed simple modifier
  *)
    if Peeked.MyType <> SYM_SEMICOLON then
      GetNextToken; //consume modifier
  //expect ";", but insert one if missing
    if not Skip(SYM_SEMICOLON) then
      Recorder := Recorder + ';';
  until False;

//we come here with an unrecognized peeked token
  M.FullDeclaration := Recorded;
end;

{ ---------------------------------------------------------------------------- }

function TParser.ParseCIO(Ident: TToken; CIOType: TTokenType;
  const IsInRecordCase: boolean): TPasCio;

const
//recognized visibilities
  sVisibilities = [SD_PRIVATE, SD_PROTECTED, SD_PUBLIC, SD_PUBLISHED, SD_AUTOMATED];
  sAllVisibilities = sVisibilities + [SD_STRICT];
//recognized sections
  sSections = [KEY_VAR, KEY_CONST, KEY_TYPE]; { TODO : handle sections in class declarations }
var
  i: TPasCio absolute Result;

  procedure AddDefaultAncestor;

    procedure CheckFor(const s: string);
    begin
      if not SameText(i.Name, s) then
        i.Ancestors.AddNew(trNoTrans, dkDelegate, s);
    end;

  begin
  //add default ancestor, depending on CIO type
    case i.MyType of
    KEY_CLASS:  CheckFor('TObject');
    KEY_DISPINTERFACE: CheckFor('IDispInterface');
    KEY_INTERFACE:  CheckFor('IInterface');
    end;
  end;

var
  Visibility: TVisibility;
begin //ParseCIO
(* ident "=" ( class | interface | record | object ) <| body ";" |>
class = CLASS [ ABSTRACT | SEALED ] [ancestors] [guid]
or
  ident = CLASS <| ";" |>
*)
  FDoc.DoMessage(5, pmtInformation, 'Parsing class/interface/object "%s"',
    [Ident.Data]);  //[CioName]);
  { Test for forward class definition here:
      class MyClass = class;
    with no ancestor or class members listed after the word class. }
  if Skip(SYM_SEMICOLON) then
    Exit;  // No error, continue the parsing.

  i := CreateItem(TPasCio, CIOType, Ident) as TPasCio;

  if PeekNextToken = TOK_IDENTIFIER then begin
    if (Peeked.Directive in [SD_ABSTRACT, SD_SEALED]) then begin
      i.HasAttribute[Peeked.Directive] := True;
      GetNextToken;
    end;
  end;
  { get ancestor and all interfaces; remember, this could look like
    TNewClass = class ( Classes.TClass, MyClasses.TFunkyClass, MoreClasses.YAC) ... end;
    Every entry but the first must be an interface. }
  if Skip(SYM_LEFT_PARENTHESIS) and not Skip(SYM_RIGHT_PARENTHESIS) then begin
    repeat //parse ancestor (ident) list
    //start recording ancestor
      i.FullDeclaration := i.FullDeclaration + Recorded;
      QualId(True); FreeAndNil(Identifier);
      i.Ancestors.AddNew(trNoTrans, dkDelegate, Recorder);
    until not Skip(SYM_COMMA);
    Expect(SYM_RIGHT_PARENTHESIS);
  end else
    AddDefaultAncestor;

//GUID?
  if Skip(SYM_LEFT_BRACKET) then begin
    GetNextToken;
    if not Skip(SYM_RIGHT_BRACKET) then
      DoError('Literal String or identifier as interface ID expected', []);
  end;
//finish declaration
  i.FullDeclaration := i.FullDeclaration + Recorded;

  if PeekNextToken <> SYM_SEMICOLON then begin
    { Else A declaration of type "name = class(ancestor);" }

  //default visibility
    if I.MyType = KEY_CLASS then begin
      { Visibility of members at the beginning of a class declaration
        that don't have a specified visibility is controlled
        by ImplicitVisibility value. }
      case ImplicitVisibility of
        ivPublic:
          if Scanner.SwitchOptions['M'] then
            Visibility := viPublished
          else
            Visibility := viPublic;
        ivPublished:
          Visibility := viPublished;
        ivImplicit:
          Visibility := viImplicit;
        else raise EInternalError.Create('ImplicitVisibility = ??');
      end;
    end else begin
      { Everything besides a class always starts with visibility "public". }
      Visibility := viPublic;
    end;
    i.CurVisibility := Visibility;

  { now collect methods, fields and properties }
    OpenScope(i);

    (* Sections are: visibility, newer OPL: local type, var... sections.
      END terminates the member list,
      everything else starts a member declaration.
    *)

    { This is needed to include ClassKeyWordString in
      class methods declarations. }

    while GetNextToken <> KEY_END do begin  //repeat
      if Token.Directive in sAllVisibilities then begin
      //visibility
        case Token.Directive of
        SD_PRIVATE:   Visibility := viPrivate;
        SD_PROTECTED: Visibility := viProtected;
        SD_PUBLIC:    Visibility := viPublic;
        SD_PUBLISHED: Visibility := viPublished;
        SD_AUTOMATED: Visibility := viAutomated;
        SD_STRICT:
          if Skip(SD_PRIVATE) then
            Visibility := viStrictPrivate
          else if Skip(SD_PROTECTED) then
            Visibility := viStrictProtected
          else
            DoError('"strict" not applicable to ', [Peeked.Data]);
        end;
        Recorder := ''; //throw away recorded visibilites
        i.CurVisibility := Visibility;
        Continue;
      end;
    //peek sections
      if Token.MyType in sSections then begin
      //to be implemented
        FDoc.DoMessage(1, pmtWarning, 'unhandled section in CIO: %s', [Token.Description]);
        GetNextToken;
      end;
    //everything else should be a member declaration
      case Token.MyType of
      KEY_CLASS:    ;
      KEY_CONSTRUCTOR, KEY_DESTRUCTOR,
      KEY_FUNCTION, KEY_PROCEDURE:
        {M :=} ParseCDFP(Token.MyType, nil);
      KEY_PROPERTY:
        {p :=} ParseProperty;
      KEY_CASE:
        ParseRecordCase(false);
      TOK_IDENTIFIER:
        ParseVariables(False);
      else  //case
        DoError('Unexpected %s', [Token.Description]);
      end;  //case
    end;  //member loop, skipped END
  //else peeked ";"
    CloseScope; //(Token)
  end;  //parse item with members

  ParseHintDirectives(i);
//how can a record case occur just here???
  if GetNextToken <> SYM_SEMICOLON then begin
    if IsInRecordCase then begin
      if Token.MyType <> SYM_RIGHT_PARENTHESIS then begin
        DoError('Unexpected symbol at end of sub-record: %s', [Token.Description]);
      end;
    end else begin
      DoError('Semicolon at the end of Class / Object / Interface' +
        ' / Record expected', []);
    end;
  end;
//consumed either ")" or ";"
//append "... end;"
  i.FullDeclaration := i.FullDeclaration + '... ' + Recorded;
end;

{ ---------------------------------------------------------------------------- }

procedure TParser.ParseConstant;
var
  i: TPasConstant;
begin
(* const ident <| [":" type] "=" value ";" |>
*)
  i := CreateItem(TPasConstant, KEY_CONST, QualId(False));
  FDoc.DoMessage(5, pmtInformation, 'Parsing constant %s', [i.Name]);
  SkipDeclaration(True, i);
  i.FullDeclaration := Recorded;
  CheckToken(Token, SYM_SEMICOLON);
end;

{ ---------------------------------------------------------------------------- }

function  TParser.ParseEnum: TPasEnum;
var
  Item: TPasItem;
  ParenLevel: Integer;
  p: TPasEnum absolute Result;
begin
(* <| "(" ident ["=" value] { "," ident ["=" value] } ");"
*)
  TPasItem(p) := CreateItem(TPasEnum, KEY_TYPE, Identifier);
  p.FullDeclaration := p.Name + ' = (...);';

  OpenScope(p);
  repeat  //while not Skip(SYM_RIGHT_PARENTHESIS) do begin
    Recorder := '';
    Item := CreateItem(TPasConstant, KEY_CONST, QualId(True));

    if Skip(SYM_EQUAL) or Skip(SYM_ASSIGN) then begin
    //value might be an expression?
      { Now read tokens until comma or right paren (but only on ParenLevel = 0). }
      ParenLevel := 0;
      repeat
        case GetNextToken of
        SYM_LEFT_PARENTHESIS, SYM_LEFT_BRACKET: Inc(ParenLevel);
        SYM_RIGHT_PARENTHESIS, SYM_RIGHT_BRACKET: Dec(ParenLevel);
        end;
      until ((Token.MyType = SYM_COMMA) and (ParenLevel = 0))
      or (ParenLevel < 0)
    //end with "," or ")"
    end else
      GetNextToken; //"," or ")"
  //eventually remove last token (delimiter) from Recorder
    Item.FullDeclaration := Recorded(True);
  until Token.MyType <> SYM_COMMA;

  CloseScope; //(Token)
  Expect(SYM_SEMICOLON);
end;

procedure TParser.ParseInterfaceSection(const U: TPasUnit);
const
  MODE_UNDEFINED = 0;
  MODE_CONST = 1;
  MODE_TYPE = 2;
  MODE_VAR = 3;
var
  Finished: Boolean;
  Mode: Integer;
begin
(* INTERFACE |> { clauses } IMPLEMENTATION |>
clauses:
  USES <| id-list ";" |>
  (VAR | CONST ...) { ident <| vc-decl ";" } |>
  TYPE { ident <| type-decl ";" } |>
Procedures are special, due to possible modifiers?
All possible modifiers should be peeked!
*)
  FDoc.DoMessage(4, pmtInformation, 'Entering interface section of unit %s',[U.Name]);
  Finished := False;
  Mode := MODE_UNDEFINED;

  repeat
    Recorder := '';
    case GetNextToken of
    KEY_USES: ParseUses(U);
    KEY_RESOURCESTRING, KEY_CONST:  Mode := MODE_CONST;
    KEY_TYPE:                       Mode := MODE_TYPE;
    KEY_THREADVAR, KEY_VAR:         Mode := MODE_VAR;
    TOK_IDENTIFIER: //or "operator"
      if Token.Directive = SD_OPERATOR then begin
        {M :=} ParseCDFP(Key_Operator_, nil);
        Mode := MODE_UNDEFINED;
      end else begin
        case Mode of
        MODE_CONST: ParseConstant;  //(U);
        MODE_TYPE:  ParseType;  //(U);
        MODE_VAR:   ParseVariables(True); //(U);
        else //case
          DoError('Unexpected %s', [Token.Description]);
        end; //case
      end;
    KEY_FUNCTION, KEY_PROCEDURE:
      begin
        {M :=} ParseCDFP(Token.MyType, nil);
        Mode := MODE_UNDEFINED;
      end;
    KEY_PROPERTY:
      begin
        {PropertyParsed :=} ParseProperty;  //(U); //(PropertyParsed);
        Mode := MODE_UNDEFINED;
      end;
    KEY_IMPLEMENTATION:
      Finished := True;
    else //case
      DoError('Unexpected %s', [Token.Description]);
    end; //case
  until Finished;
end;

{ ---------------------------------------------------------------------------- }

function  TParser.ParseProperty: TPasProperty;
var
  p: TPasProperty absolute Result;
begin
(* "property" ident [ decl ] ";"
decl: [ params ] ":" type [index] [reader] [writer] [";"] [default *] [stored *]
  ";"
*)
  TPasItem(p) := CreateItem(TPasProperty, KEY_PROPERTY, nil);
  FDoc.DoMessage(5, pmtInformation, 'Parsing property %s', [p.Name]);
{$IFDEF DetailedProps}
  p.IndexDecl := '';
  p.Proptype := '';
{$ELSE}
{$ENDIF}

{ Is this only a redeclaration of property from ancestor
    (to e.g. change it's visibility) }
  if Skip(SYM_SEMICOLON) then begin
    p.FullDeclaration := Recorded; //p.FullDeclaration + ';';
    Exit;
  end;

{ get index }
  p.FullDeclaration := Recorded; //separate optional parts
  if Skip(SYM_LEFT_BRACKET) then begin
    while GetNextToken <> SYM_RIGHT_BRACKET do
      ;
  {$IFDEF DetailedProps}
    p.IndexDecl := Recorder;
  {$ELSE}
  {$ENDIF}
    p.FullDeclaration := p.FullDeclaration + Recorded;
  end;

{ now if there is a colon, it is followed by the type }
  if Skip(SYM_COLON) then begin
    { get property type }
    p.FullDeclaration := p.FullDeclaration + Recorded;  //add ":"
  //problem: separate type from possibly following directives
  //wait for ";" or directive
    while (PeekNextToken <> SYM_SEMICOLON)
    and (Peeked.Directive = SD_INVALIDSTANDARDDIRECTIVE) do
      GetNextToken;
  {$IFDEF DetailedProps}
    p.Proptype := Recorder; //keep, added to FullDeclaration
  {$ELSE}
  {$ENDIF}
  end;

{ read the rest of declaration }
  SkipDeclaration(false, p); //doesn't read "default" etc., past first ";"
//skip further specifiers
  while (PeekNextToken = tok_identifier)
  and (Peeked.Directive in [sd_default, sd_nodefault, sd_stored]) do begin
    while GetNextToken <> sym_semicolon do
      ;
  end;
  p.FullDeclaration := p.FullDeclaration + Recorded;
//now past final ";"
end;

{ ---------------------------------------------------------------------------- }

procedure TParser.ParseRecordCase(const SubCase: boolean);
var
  P: TPasItem;
begin
(* CASE <| [ident ":"] type OF
  { ...":" "(" decl { ";" [decl] } ")" [";"] }
  |> END [ ";" ]

decl can be:
  CASE ... "(" ... ")"  [";"] ")" //<--- ")" instead of END!
*)
  Recorder := '';
  QualId(True); //name or type?
  if Skip(SYM_COLON) then begin
  { Then we have "case FieldName: FieldType of" }
    p := CreateItem(TPasItem, KEY_VAR, Identifier);
    while PeekNextToken <> Key_OF do
      GetNextToken;
    p.FullDeclaration := Recorded(True) + ';';
  end;

  Expect(KEY_OF);

  repeat  //sure that at least one case must exist?
  //why should we be stricter than the compiler???
    while GetNextToken <> SYM_COLON do
      ;
    Expect(SYM_LEFT_PARENTHESIS);

    //while not Skip(SYM_RIGHT_PARENTHESIS) do begin
    repeat
      if Skip(KEY_CASE) then
        ParseRecordCase(true)
      else begin
        Expect(TOK_IDENTIFIER);
        ParseVariables(False); //... ";" <| ")" <| ";"
        //CheckToken(Token, SYM_RIGHT_PARENTHESIS);
      end;
      if Token.MyType = SYM_SEMICOLON then
        Skip(SYM_RIGHT_PARENTHESIS);  //";" optional before ")"
    until Token.MyType = SYM_RIGHT_PARENTHESIS; //else ";" before ")"
    Skip(SYM_SEMICOLON);
  //until Skip(KEY_END)or (SubCase and Skip(SYM_RIGHT_PARENTHESIS));
  until (PeekNextToken = KEY_END)
  or (SubCase and Skip(SYM_RIGHT_PARENTHESIS));
end;

procedure TParser.ParseType;
var
  NormalType: TPasItem; //TPasType;
  TypeName: string;
begin
(* TYPE
  ident <| = [TYPE] decl ";" |>
decl can be
  CLASS OF ident
  CLASS [ancestors, guid] members... ";"
*)
  QualID(False);
  TypeName := Identifier.Data;
  FDoc.DoMessage(5, pmtInformation, 'Parsing type "%s"', [TypeName]);

  if Skip(SYM_SEMICOLON) then
    Exit; //what's that???

  Expect(SYM_EQUAL);
  Skip(KEY_TYPE);
  {fPacked :=} Skip(KEY_PACKED);

  case GetNextToken of
  KEY_CLASS:
    if Skip(KEY_OF) then begin
      { include "identifier = class of something;" as standard type }
    end else begin
      ParseCIO(Identifier, Token.MyType, False);
      Exit;
    end;
  KEY_DISPINTERFACE,
  KEY_INTERFACE,
  KEY_OBJECT,
  KEY_RECORD: begin
      ParseCIO(Identifier, Token.MyType, False);
      Exit;
    end;
  end;

  if Token.MyType in [KEY_FUNCTION, KEY_PROCEDURE] then begin
    {MethodType :=} ParseCDFP(Token.MyType, Identifier);
  end else if Token.IsSymbol(SYM_LEFT_PARENTHESIS) then begin
    {EnumType :=} ParseEnum;  //(TypeName);
  end else begin
  { TODO : Treat <type>=<class> as class(<class>), for class tree construction
    and name search in ancestors. }
    NormalType := CreateItem(TPasType, KEY_TYPE, Identifier);
    SkipDeclaration(False, NormalType);
    NormalType.FullDeclaration := Recorded;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TParser.ParseUnit(U: TPasUnit);
begin
(* UNIT ident <| ";"
  INTERFACE ...
  IMPLEMENTATION |>
*)
  ParseHintDirectives(U);
  u.ID := trUnit;
  Expect(SYM_SEMICOLON);
  U.FullDeclaration := Recorded;
  Expect(KEY_INTERFACE);

  { now parse the interface section of that unit }
  ParseInterfaceSection(U);
end;

{ ---------------------------------------------------------------------------- }
procedure TParser.ParseProgramOrLibraryUses(U: TPasUnit);
begin
  ParseHintDirectives(U);
  Expect(SYM_SEMICOLON);
  U.FullDeclaration := Recorded;

  if Skip(KEY_USES) then
    ParseUses(U);
end;

procedure TParser.ParseProgram(U: TPasUnit);
begin
  u.ID := trProgram;
//skip parameters
  if Skip(SYM_LEFT_PARENTHESIS) then begin
    while GetNextToken <> SYM_RIGHT_PARENTHESIS do
      ;
  end;
  U.FullDeclaration := Recorded;
  ParseProgramOrLibraryUses(U);
end;

procedure TParser.ParseLibrary(U: TPasUnit);
begin
  u.ID := trLibrary;
  ParseProgramOrLibraryUses(U);
end;

{ ---------------------------------------------------------------------------- }

procedure TParser.ParseUnitOrProgram(var U: TPasUnit);
(* required by PasDoc_base!
*)
var
  tt: TTokenType;
begin
(* [ UNIT | LIBRARY | PROGRAM | PACKAGE ] ident ...
*)
  assert(CurScope = nil, 'old scope???');
  tt := GetNextToken;
  U := CreateItem(TPasUnit, tt, nil) as TPasUnit;
  U.CurVisibility := viPublic;
  OpenScope(U);
  case tt of
  KEY_UNIT:     ParseUnit(U);
  KEY_LIBRARY:  ParseLibrary(U);
  KEY_PROGRAM:  ParseProgram(U);
  else
    DoError('unrecognized file type: %s', [Token.Description]);
  end;
  CloseScope;
end;

{ ---------------------------------------------------------------------------- }

procedure TParser.ParseUses(const U: TPasUnit);
var
  item: TPasItem;
begin
(* USES qualid { "," qualid } ";"
qualid (here)
  ident { "." ident } [ IN string ]
*)

//flush back rems?
  FlushBackRems(DeclLast, Token);
{$IFDEF old}
  { Parsing uses clause clears the comment, otherwise
    - normal comments before "uses" clause would be assigned to normal unit
      items (like a procedure), which is quite unexpected
      (see ok_comment_over_uses_clause.pas testcase).
    - analogously, back comments after "uses" clause would be assigned to the unit
      description (see ok_comment_over_uses_clause_2.pas testcase).

    New TPasUsed can receive comments!
  }
  CancelComments;
{$ELSE}
(* New approach: Uses become TPasItems (TPasUsed), so that comments
  have valid targets.
  FullDeclaration is set to the full declaration, including file specifiers.
*)
{$ENDIF}

  repeat
  {$IFDEF old}
    U.UsesUnits.AddNew(trNoTrans, dkDelegate, QualId(True).Data);
      //trUnit?
  {$ELSE}
    Recorder := ''; //skip "uses" and commas
    item := CreateItem(TPasUsed, KEY_UNIT, nil);
  {$ENDIF}

    if Skip(KEY_IN) then begin
    { Below we just ignore the value of next string token.

      We can do this -- because PasDoc (at least for now)
      does not recursively parse units on "uses" clause.
      So we are not interested in the value of
      given string (which should be a file-name (usually relative,
      but absolute is also allowed AFAIK) with given unit.)

      If we will ever want to implement such "recursive parsing
      of units" in PasDoc, we will have to fix this to
      *not* ignore value of token below.
    }
      Expect(TOK_STRING);
    end;
    item.FullDeclaration := Trim(Recorded); //trim?
  until not Skip(SYM_COMMA);
  Expect(SYM_SEMICOLON);
end;

{ ---------------------------------------------------------------------------- }

{$IFDEF old}
procedure TParser.SetCommentMarkers(const Value: TStringList);
begin
  FCommentMarkers.Assign(Value);
end;
{$ELSE}
{$ENDIF}

procedure TParser.SkipDeclaration(fSkipNext: boolean; CurItem: TPasItem);
var
  Level: Integer;
begin
(* intended use: skip all type specifiers after ":" (ref) or "=" (decl).
Take into account (nesting level) embedded:
  pairs of "()"
  structured type definitions (RECORD, CLASS? ..END)
    (best all CIO types)
  pairs of "[]" (property index specifier

  Terminate on nesting level 0, when either token is found:
  ";" ordinary declaration --> include following modifiers!?
  ")" end of argument or record case list
  "]" end of property index specifier
  END of record (case)
*)
  if fSkipNext and not (GetNextToken in [SYM_EQUAL, SYM_COLON]) then
    DoError('expected "=" or ":", got: %s', [Token.Description]);

  Level := 0;
  repeat
    case GetNextToken of
    SYM_LEFT_BRACKET,
    SYM_LEFT_PARENTHESIS: Inc(Level);
    SYM_RIGHT_BRACKET,
    SYM_RIGHT_PARENTHESIS: Dec(Level);
    SYM_ROOF: //in const expr (value): ctrl-char. in type decl: ptr-to.
      begin
        GetNextToken; //prevent interpretation of "[" etc.!
      end;
    SYM_SEMICOLON:
      if level = 0 then begin
      (* Include type modifiers, else break.
        Don't add the modifiers to CurItem, they apply to the type.
        See also: ParseCDFP

        Unit variable modifiers are checked by the caller,
          at least we assume that these must occur after type modifiers.
      *)
        case PeekNextToken of
        KEY_INLINE: ; //handle in next iteration
        TOK_IDENTIFIER:
          case Peeked.Directive of
          //general modifiers?
          SD_NEAR, SD_FAR: ; //ignore
          //procedure modifiers
          SD_CDECL, //SD_INLINE,
          SD_PASCAL, SD_REGISTER, SD_SAFECALL, SD_STDCALL, SD_VARARGS:
            begin //set attribute
              if Assigned(CurItem) then
                CurItem.HasAttribute[Token.Directive] := true;
              GetNextToken; //directive, wait for next ";"
            end;
          else //case directive
            break; // Dec(Level);
          end;
        else //case MyType
          break;
        end;
      end;
    KEY_END: Dec(Level);
    KEY_CLASS, KEY_INTERFACE, KEY_DISPINTERFACE, KEY_OBJECT,
    KEY_RECORD: Inc(Level);
    KEY_LIBRARY: if Assigned(CurItem) then //CurItem.IsLibrarySpecific := true;
      CurItem.HasAttribute[SD_LIBRARY_] := True; //translate keyword into pseudo directive
    TOK_IDENTIFIER:
      case Token.Directive of
      SD_PLATFORM,
      SD_DEPRECATED:  if Assigned(CurItem) then CurItem.HasAttribute[Token.Directive] := true;
      end;
    end; //case
  until Level < 0;
(* /regular description should always end with a ";",
  even if a ")" or "END" was reached.
  Whitespace may have been added, after a ";"!
*)
  Recorder := Recorded(True);
  if Recorder[Length(Recorder)] <> ';' then
    Recorder := Recorder + ';';
end;

{ ------------------------------------------------------------ }

procedure TParser.ParseHintDirectives(Item: TPasItem);
begin
(* <| { LIBRARY | PLATFORM | DEPRECATED } |>
*)
  while True do begin
    if Skip(KEY_LIBRARY) then //Item.IsLibrarySpecific := true
      Item.HasAttribute[SD_LIBRARY_] := True
    else if Skip(SD_PLATFORM)   //then Item.IsPlatformSpecific := true
          or Skip(SD_DEPRECATED) then //Item.IsDeprecated := true
            item.HasAttribute[Token.Directive] := True
    else
      break;
  end;  //until false;
end;

{$IFDEF old}
class function TParser.ShowVisibilities: TVisibilities;
begin
  Result := PasDoc_items.ShowVisibilities;
end;
{$ELSE}
{$ENDIF}

end.
