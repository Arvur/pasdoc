{ @cvs($Date$)
  @author(Johannes Berg <johannes@sipsolutions.de>)
  @author(Michalis Kamburelis)
  @abstract(basic types used in PasDoc) }
unit PasDoc_Types;

interface
uses
  SysUtils;
  
type
  TTextStreamPos = LongInt; //<int64?
  { }
  TPasDocMessageType = (pmtPlainText, pmtInformation, pmtWarning, pmtError);
  { }
  TPasDocMessageEvent = procedure(const MessageType: TPasDocMessageType; const
    AMessage: string; const AVerbosity: Cardinal) of object;

  TCharSet = set of Char;

{ }
  EPasDoc = class(Exception)
  public
    constructor Create(const AMessage: string;
      const AArguments: array of const; const AExitCode: Word);
  end;

type
  { enumeration type that provides all types of tokens; each token's name
    starts with TOK_.

    TOK_DIRECTIVE is a compiler directive (like $ifdef, $define).

    Note that tokenizer is not able to tell whether you used
    standard directive (e.g. 'Register') as an identifier
    (e.g. you're declaring procedure named 'Register')
    or as a real standard directive (e.g. a calling specifier 'register').
    So there is @italic(no) value like TOK_STANDARD_DIRECTIVE here,
    standard directives are always reported as TOK_IDENTIFIER.
    You can check TToken.Info.StandardDirective to know whether
    this identifier is @italic(maybe) used as real standard directive. }
  TTokenType = (
    TOK_WHITESPACE,
    TOK_COMMENT_PAS, TOK_COMMENT_EXT, TOK_COMMENT_CSTYLE,
    TOK_ATT_ASSEMBLER_REGISTER,
    TOK_IDENTIFIER, TOK_DIRECTIVE,
    TOK_NUMBER, TOK_STRING,
    //TOK_SYMBOL,
  { enumeration type that provides all types of symbols; each
    symbol's name starts with SYM_ }
    SYM_PLUS, SYM_MINUS, SYM_ASTERISK, SYM_SLASH, SYM_EQUAL,
    SYM_LESS_THAN, SYM_LESS_THAN_EQUAL, SYM_GREATER_THAN,
    SYM_GREATER_THAN_EQUAL, SYM_LEFT_BRACKET, SYM_RIGHT_BRACKET,
    SYM_COMMA, SYM_LEFT_PARENTHESIS, SYM_RIGHT_PARENTHESIS, SYM_COLON,
    SYM_SEMICOLON, SYM_ROOF, SYM_PERIOD, SYM_AT,
    SYM_DOLLAR, SYM_ASSIGN, SYM_RANGE, SYM_POWER,
    { SYM_BACKSLASH may occur when writing char constant "^\",
      see ../../tests/ok_caret_character.pas }
    SYM_BACKSLASH,
    //TOK_KEYWORD,
    KEY_AND,
    KEY_ARRAY,
    KEY_AS,
    KEY_ASM,
    KEY_BEGIN,
    KEY_CASE,
    KEY_CLASS,
    KEY_CONST,
    KEY_CONSTRUCTOR,
    KEY_DESTRUCTOR,
    KEY_DISPINTERFACE,
    KEY_DIV,
    KEY_DO,
    KEY_DOWNTO,
    KEY_ELSE,
    KEY_END,
    KEY_EXCEPT,
    KEY_EXPORTS,
    KEY_FILE,
    KEY_FINALIZATION,
    KEY_FINALLY,
    KEY_FOR,
    KEY_FUNCTION,
    KEY_GOTO,
    KEY_IF,
    KEY_IMPLEMENTATION,
    KEY_IN,
    KEY_INHERITED,
    KEY_INITIALIZATION,
    KEY_INLINE,
    KEY_INTERFACE,
    KEY_IS,
    KEY_LABEL,
    KEY_LIBRARY,
    KEY_MOD,
    KEY_NIL,
    KEY_NOT,
    KEY_OBJECT,
    KEY_OF,
    KEY_ON,
    KEY_OR,
    KEY_PACKED,
    KEY_PROCEDURE,
    KEY_PROGRAM,
    KEY_PROPERTY,
    KEY_RAISE,
    KEY_RECORD,
    KEY_REPEAT,
    KEY_RESOURCESTRING,
    KEY_SET,
    KEY_SHL,
    KEY_SHR,
    KEY_STRING,
    KEY_THEN,
    KEY_THREADVAR,
    KEY_TO,
    KEY_TRY,
    KEY_TYPE,
    KEY_UNIT,
    KEY_UNTIL,
    KEY_USES,
    KEY_VAR,
    KEY_WHILE,
    KEY_WITH,
    KEY_XOR
  );
  eSymbolType = SYM_PLUS..SYM_BACKSLASH;
  eKeyword = KEY_AND..KEY_XOR;

const
  TokenCommentTypes = //: set of TTokenType =
    [ TOK_COMMENT_PAS, TOK_COMMENT_EXT, TOK_COMMENT_CSTYLE ];
  sSymbolType = [SYM_PLUS..SYM_BACKSLASH];
  sKeyword = [KEY_AND..KEY_XOR];
  KEY_INVALIDKEYWORD = tok_identifier;

type
  TStandardDirective = (
    SD_INVALIDSTANDARDDIRECTIVE,
    SD_ABSOLUTE,
    SD_ABSTRACT,
    SD_APIENTRY,
    SD_ASSEMBLER,
    SD_AUTOMATED,
    SD_CDECL,
    SD_CVAR,
    SD_DEFAULT,
    SD_DISPID,
    SD_DYNAMIC,
    SD_EXPORT,
    SD_EXTERNAL,
    SD_FAR,
    SD_FORWARD,
    SD_INDEX,
    SD_INLINE,
    SD_MESSAGE,
    SD_NAME,
    SD_NEAR,
    SD_NODEFAULT,
    SD_OPERATOR,
    SD_OUT,
    SD_OVERLOAD,
    SD_OVERRIDE,
    SD_PASCAL,
    SD_PRIVATE,
    SD_PROTECTED,
    SD_PUBLIC,
    SD_PUBLISHED,
    SD_READ,
    SD_REGISTER,
    SD_REINTRODUCE,
    SD_RESIDENT,
    SD_SEALED,
    SD_STATIC,
    SD_STDCALL,
    SD_STORED,
    SD_STRICT,
    SD_VIRTUAL,
    SD_WRITE,
    SD_DEPRECATED,
    SD_SAFECALL,
    SD_PLATFORM,
    SD_VARARGS);

const
  { Names of the token types. All start with lower letter.
    They should somehow describe (in a few short words) given
    TTokenType. }
  //TOKEN_TYPE_NAMES: array[TTokenType] of string =
  TokenNames: array[TTokenType] of string = (
    'whitespace',
    'comment ((**)-style)', 'comment ({}-style)', 'comment (//-style)',
    'AT&T assembler register name',
    'identifier', 'directive',
    'number', 'string',
    //'symbol',
  { Symbols as strings. They can be useful to have some mapping
    TSymbolType -> string, but remember that actually some symbols
    in tokenizer have multiple possible representations,
    e.g. "right bracket" is usually given as "]" but can also
    be written as ".)". }
  //SymbolNames: array[TSymbolType] of string = (
    '+', '-', '*', '/', '=', '<', '<=', '>', '>=', '[', ']', ',',
    '(', ')', ':', ';', '^', '.', '@', '$', ':=', '..', '**', '\',
    //'reserved word',
  { all Object Pascal keywords }
  //KeyWordArray: array[Low(TKeyword)..High(TKeyword)] of string = ('x', // lowercase never matches
    'AND', 'ARRAY', 'AS', 'ASM', 'BEGIN', 'CASE', 'CLASS', 'CONST',
    'CONSTRUCTOR', 'DESTRUCTOR', 'DISPINTERFACE', 'DIV',  'DO', 'DOWNTO',
    'ELSE', 'END', 'EXCEPT', 'EXPORTS', 'FILE', 'FINALIZATION',
    'FINALLY', 'FOR', 'FUNCTION', 'GOTO', 'IF', 'IMPLEMENTATION',
    'IN', 'INHERITED', 'INITIALIZATION', 'INLINE', 'INTERFACE',
    'IS', 'LABEL', 'LIBRARY', 'MOD', 'NIL', 'NOT', 'OBJECT', 'OF',
    'ON', 'OR', 'PACKED', 'PROCEDURE', 'PROGRAM', 'PROPERTY',
    'RAISE', 'RECORD', 'REPEAT', 'RESOURCESTRING', 'SET', 'SHL',
    'SHR', 'STRING', 'THEN', 'THREADVAR', 'TO', 'TRY', 'TYPE',
    'UNIT', 'UNTIL', 'USES', 'VAR', 'WHILE', 'WITH', 'XOR'
  );

  { Object Pascal directives }
  StandardDirectiveArray: array[TStandardDirective] of string = (
    'x', // lowercase letters never match
    'ABSOLUTE', 'ABSTRACT', 'APIENTRY', 'ASSEMBLER', 'AUTOMATED',
    'CDECL', 'CVAR', 'DEFAULT', 'DISPID', 'DYNAMIC', 'EXPORT', 'EXTERNAL',
    'FAR', 'FORWARD', 'INDEX', 'INLINE', 'MESSAGE', 'NAME', 'NEAR',
    'NODEFAULT', 'OPERATOR', 'OUT', 'OVERLOAD', 'OVERRIDE', 'PASCAL', 'PRIVATE',
    'PROTECTED', 'PUBLIC', 'PUBLISHED', 'READ', 'REGISTER',
    'REINTRODUCE', 'RESIDENT', 'SEALED', 'STATIC',
    'STDCALL', 'STORED', 'STRICT', 'VIRTUAL',
    'WRITE', 'DEPRECATED', 'SAFECALL', 'PLATFORM', 'VARARGS'
  );

//standardized token definition (for old style error reports)
function  TokenDefinition(ATokenType: TTokenType; data: string = ''): string;

type
  { This represents parts of a qualified name of some item.

    User supplies such name by separating each part with dot,
    e.g. 'UnitName.ClassName.ProcedureName', then @link(SplitNameParts)
    converts it to TNameParts like
    ['UnitName', 'ClassName', 'ProcedureName'].
    Length must be @italic(always) between 1 and @link(MaxNameParts). }
  TNameParts = array of string;

const
  MaxNameParts = 3;

{ Splits S, which can be made of up to three parts, separated by dots.
  If S is not a valid identifier or if it has more than
  three parts, false is returned, otherwise true is returned
  and splitted name is returned as NameParts. }
function SplitNameParts(S: string; out NameParts: TNameParts): Boolean;

{ Simply returns an array with Length = 1 and one item = S. }
function OneNamePart(S: string): TNameParts;

{ Simply concatenates all NameParts with dot. }
function GlueNameParts(const NameParts: TNameParts): string;

type
  { See command-line option @--implicit-visibility documentation at
    [http://pasdoc.sipsolutions.net/ImplicitVisibilityOption] }
  TImplicitVisibility = (ivPublic, ivPublished, ivImplicit);

implementation

{ EPasDoc -------------------------------------------------------------------- }

constructor EPasDoc.Create(const AMessage: string; const AArguments: array of
  const; const AExitCode: Word);
begin
  ExitCode := AExitCode;
  CreateFmt(AMessage, AArguments);
end;

{ global routines ------------------------------------------------------------ }

function  TokenDefinition(ATokenType: TTokenType; data: string = ''): string;
begin
  if ATokenType >= KEY_AND then begin
    if data = '' then
      data := LowerCase(TokenNames[ATokenType]);
    Result := 'reserved word "' + data + '"';
  end else if ATokenType >= SYM_PLUS then begin
    Result := 'symbol "' + TokenNames[ATokenType] + '"'
  end else if (data <> '') and (ATokenType = TOK_IDENTIFIER) then
    Result := 'identifier "' + data + '"'
  else
    Result := TokenNames[ATokenType];
end;

function SplitNameParts(S: string; 
  out NameParts: TNameParts): Boolean;

const
  { set of characters, including all letters and the underscore }
  IdentifierStart = ['A'..'Z', 'a'..'z', '_'];

  { set of characters, including all characters from @link(IdentifierStart)
    plus the ten decimal digits }
  IdentifierOther = ['A'..'Z', 'a'..'z', '_', '0'..'9', '.'];

  procedure SplitInTwo(s: string; var S1, S2: string);
  var
    i: Integer;
  begin
    i := Pos('.', s);
    if (i = 0) then begin
      S1 := s;
      S2 := '';
    end
    else begin
      S1 := System.Copy(s, 1, i - 1);
      S2 := System.Copy(s, i + 1, Length(s));
    end;
  end;

var
  i: Integer;
  t: string;
begin
  Result := False;
  
  SetLength(NameParts, 3);

  S := Trim(S);
  
  { Check that S starts with IdentifierStart and 
    then only IdentifierOther chars follow }
  if S = '' then Exit;
  if (not (s[1] in IdentifierStart)) then Exit;
  i := 2;
  while (i <= Length(s)) do begin
    if (not (s[i] in IdentifierOther)) then Exit;
    Inc(i);
  end;
  
  SplitInTwo(S, NameParts[0], NameParts[1]);
  if NameParts[1] = '' then 
  begin
    SetLength(NameParts, 1);
  end else 
  begin
    t := NameParts[1];
    SplitInTwo(t, NameParts[1], NameParts[2]);
    if NameParts[2] = '' then
      SetLength(NameParts, 2) else
      SetLength(NameParts, 3);
  end;
  Result := True;
end;

function OneNamePart(S: string): TNameParts;
begin
  SetLength(Result, 1);
  Result[0] := S;
end;

function GlueNameParts(const NameParts: TNameParts): string;
var
  i: Integer;
begin
  Result := NameParts[0];
  for i := 1 to Length(NameParts) - 1 do
    Result := Result + '.' + NameParts[i];
end;

end.
 
