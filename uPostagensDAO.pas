unit uPostagensDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils, System.StrUtils;

type
  TPostagensDAO = class
  private
    FConexao : TConexao;
  public
    constructor Create;

    function Exibir(): TFDQuery;
    function Excluir(pId: Integer): Boolean;
    function Alterar(pIdUsario, pId : Integer; pTituloPostagem, pPostagem : string): Boolean;
    function Inserir (pIdUsario, pId : Integer; pTituloPostagem, pPostagem : string) : Boolean;
    function CriarBanco(pBancoDados : string ): Boolean;
    function ExecutaScript(): Boolean;

  end;

implementation

{ TPostagensDAO }

function TPostagensDAO.Alterar(pIdUsario, pId : Integer; pTituloPostagem, pPostagem : string): Boolean;
const
  SEL_POST = 'SELECT * FROM POSTS WHERE ID = %S';
  UPD = 'UPDATE POSTS SET ID_USER = %S, TITULO_POSTAGEM = %S, POSTAGEM = %S WHERE ID = %S';
var
  Qry, Qry2: TFDQuery;
begin
  Result := False;
  Qry := FConexao.CriaQuery();
  Qry2 := FConexao.CriaQuery();
  try
    Qry.SQL.Add(Format(SEL_POST,[IntToStr(pId)]));
    Qry.Open;

    if Qry.RecordCount > 0 then
    begin
      Qry2.ExecSQL(Format(UPD,[
                               IntToStr(pIdUsario),
                               pTituloPostagem.QuotedString,
                               pPostagem.QuotedString,
                               IntToStr(pId)]));
      Result := True;
    end;
  finally
    Qry.Free;
    Qry2.Free;
  end;
end;

constructor TPostagensDAO.Create;
begin
  FConexao := TConexao.GetInstancia;
end;

function TPostagensDAO.CriarBanco(pBancoDados: string): Boolean;
const
  BANCO = 'CREATE DATABASE %S';
var
  Qry: TFDQuery;
begin
  Qry := FConexao.CriaQuery();
  try
    Qry.ExecSQL(Format(BANCO,[pBancoDados]));
    Result := True;
  finally
    Qry.Free;
  end;
end;

function TPostagensDAO.Excluir(pId: Integer): Boolean;
const
  DEL = 'DELETE POSTS WHERE ID = %S';
var
  Qry: TFDQuery;
begin
  Qry := FConexao.CriaQuery();
  try
    Qry.ExecSQL(Format(DEL,[IntToStr(pId)]));
    Result := True;
  finally
    Qry.Free;
  end;
end;

function TPostagensDAO.ExecutaScript: Boolean;
const
  SCRIPT = 'CREATE TABLE POSTS ( '+
           '					ID_USER INT, '+
           '					ID INT, '+
           '					TITULO_POSTAGEM VARCHAR(100), '+
           '					POSTAGEM VARCHAR(500) '+
           '					) ';
var
  Qry: TFDQuery;
begin
  Qry := FConexao.CriaQuery();
  try
    Qry.ExecSQL(SCRIPT);
    Result := True;
  finally
    Qry.Free;
  end;
end;

function TPostagensDAO.Exibir: TFDQuery;
const
  SELECT = 'SELECT ID_USER, ID, TITULO_POSTAGEM, POSTAGEM FROM POSTS ORDER BY ID_USER, ID';
var
  Qry: TFDQuery;
begin
  try
    Qry := FConexao.CriaQuery();
    Qry.SQL.Add(SELECT);
    Qry.Open();

    Result := Qry;
  finally
    //Qry.Free;
  end;
end;

function TPostagensDAO.Inserir(pIdUsario, pId: Integer; pTituloPostagem, pPostagem: string): Boolean;
const
  INSERT = 'INSERT INTO POSTS (ID_USER, ID, TITULO_POSTAGEM, POSTAGEM) VALUES (%S, %S, %S, %S)';
var
  Qry: TFDQuery;
begin
  try
    Qry := FConexao.CriaQuery();
    Qry.SQL.Add(Format(INSERT,[
                              IntToStr(pIdUsario),
                              IntToStr(pId),
                              pTituloPostagem.QuotedString,
                              pPostagem.QuotedString
                              ]));
    Qry.ExecSQL;

  finally
    Qry.Free;
  end;

end;

end.
