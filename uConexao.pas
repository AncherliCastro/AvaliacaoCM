unit uConexao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait;
type
  TConexao = class

  class var FInstancia: TConexao;
  private
    FConexao : TFDConnection;
  public
    class function GetInstancia():TConexao;
    function ConectaBaseDeDados(pServidor, pDatabase, pUsuario : string ) : Boolean;
    function CriaQuery: TFDQuery;
    function CriaConexao : TFDConnection;

    constructor Create;
    destructor Destroy; override;

  end;

implementation

{ TConexao }

function TConexao.ConectaBaseDeDados(pServidor, pDatabase, pUsuario : string ) : Boolean;
begin
  FConexao.Params.Values['DriverID'] := 'MSSQL';
  FConexao.Params.values ['Server'] := pServidor;
  FConexao.Params.Values['Database'] := pDatabase;
  FConexao.Params.Values['User_name'] := pUsuario;
  FConexao.Params.Values['Password'] := '';
  FConexao.Connected := True;
  Result := FConexao.Connected;
end;

constructor TConexao.Create;
begin
  FConexao := TFDConnection.Create(nil);
  FInstancia := nil;
end;

function TConexao.CriaConexao: TFDConnection;
begin
  Result := FConexao;
end;


function TConexao.CriaQuery: TFDQuery;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.Connection := FConexao;

  Result := Query;
end;

destructor TConexao.Destroy;
begin
  FConexao.Free;
  FInstancia.Free;
  inherited;
end;

class function TConexao.GetInstancia: TConexao;
begin
   if not Assigned(FInstancia) then
   FInstancia := TConexao.Create;
   Result := FInstancia;
end;

end.
