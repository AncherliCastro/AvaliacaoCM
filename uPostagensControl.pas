unit uPostagensControl;

interface

uses
  uPostagensModel, System.SysUtils, FireDAC.Comp.Client;

type
  TPostagensControl = class
  private
    FPostagensModel: TpostagensModel;

  public
    constructor Create;
    destructor Destroy; override;

    function Exibir(): TFDQuery;
    function Excluir(pId: Integer): Boolean;
    function Alterar(pIdUsario, pId : Integer; pTituloPostagem, pPostagem : string): Boolean;
    function Inserir (pIdUsario, pId : Integer; pTituloPostagem, pPostagem : string) : Boolean;
    function CriarBanco(pBancoDados : string ): Boolean;
    function ExecutaScript(): Boolean;

  end;

implementation

function TPostagensControl.Alterar(pIdUsario, pId : Integer; pTituloPostagem, pPostagem : string): Boolean;
var
  PostagensModel: TpostagensModel;
begin
  try
    PostagensModel := TpostagensModel.Create;
    Result := PostagensModel.Alterar(pIdUsario, pId, pTituloPostagem, pPostagem);
  finally
    PostagensModel.Free;
  end;
end;

constructor TPostagensControl.Create;
begin
  FPostagensModel := TpostagensModel.Create;
end;

function TPostagensControl.CriarBanco(pBancoDados: string): Boolean;
var
  PostagensModel: TpostagensModel;
begin
  try
    PostagensModel := TpostagensModel.Create;
    Result := PostagensModel.CriarBanco(pBancoDados);
  finally
    PostagensModel.Free;
  end;
end;

destructor TPostagensControl.Destroy;
begin
  FPostagensModel.Free;
  inherited;
end;

function TPostagensControl.Excluir(pId: Integer): Boolean;
var
  PostagensModel: TpostagensModel;
begin
  try
    PostagensModel := TpostagensModel.Create;
    Result := PostagensModel.Excluir(pId);
  finally
    PostagensModel.Free;
  end;
end;

function TPostagensControl.ExecutaScript : Boolean;
var
  PostagensModel: TpostagensModel;
begin
  try
    PostagensModel := TpostagensModel.Create;
    Result := PostagensModel.ExecutaScript;
  finally
    PostagensModel.Free;
  end;
end;

function TPostagensControl.Exibir: TFDQuery;
begin
  Result := FPostagensModel.Exibir;
end;

function TPostagensControl.Inserir(pIdUsario, pId: Integer; pTituloPostagem, pPostagem: string): Boolean;
var
  PostagensModel: TpostagensModel;
begin
  try
    PostagensModel := TpostagensModel.Create;
    Result := PostagensModel.Inserir(pIdUsario, pId, pTituloPostagem, pPostagem);
  finally
    PostagensModel.Free;
  end;
end;

end.
