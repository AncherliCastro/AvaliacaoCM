unit uPostagensModel;

interface

uses
   FireDAC.Comp.Client,uPostagensDAO, System.SysUtils;

type
  TPostagensModel = class
  private
    FID: Integer;
    FCodigoUsuario: integer;
    FTituloPostagem : string;
    FPostagem : string;
    FPostagemDAO : TPostagensDAO;
  public
    function Exibir(): TFDQuery;
    function Excluir(pId: Integer): Boolean;
    function Alterar(pIdUsario, pId : Integer; pTituloPostagem, pPostagem : string): Boolean;
    function Inserir (pIdUsario, pId : Integer; pTituloPostagem, pPostagem : string) : Boolean;
    function CriarBanco(pBancoDados : string ): Boolean;
    function ExecutaScript(): Boolean;

    constructor Create;
    destructor Destroy; override;

  end;

  implementation

{ TPostagensModel }

function TPostagensModel.Alterar(pIdUsario, pId : Integer; pTituloPostagem, pPostagem : string): Boolean;
begin
  Result := FPostagemDAO.Alterar(pIdUsario, pId, pTituloPostagem, pPostagem);
end;

constructor TPostagensModel.Create;
begin
  FPostagemDAO := TPostagensDAO.Create();
end;

function TPostagensModel.CriarBanco(pBancoDados: string): Boolean;
begin
  Result := FPostagemDAO.CriarBanco(pBancoDados);
end;

destructor TPostagensModel.Destroy;
begin
  FPostagemDAO.Free;
  inherited;
end;

function TPostagensModel.Excluir(pId: Integer): Boolean;
begin
  Result := FPostagemDAO.Excluir(pId);
end;

function TPostagensModel.ExecutaScript: Boolean;
begin
  Result := FPostagemDAO.ExecutaScript;
end;

function TPostagensModel.Exibir : TFDQuery;
begin
  Result := FPostagemDAO.Exibir;
end;

function TPostagensModel.Inserir(pIdUsario, pId: Integer; pTituloPostagem, pPostagem: string): Boolean;
begin
  Result := FPostagemDAO.Inserir(pIdUsario, pId, pTituloPostagem, pPostagem);
end;

end.
