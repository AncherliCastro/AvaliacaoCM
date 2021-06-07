unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uPostagensControl, REST.Json, uPostagensModel,System.JSON,
  FireDAC.Phys.MSSQLDef, FireDAC.Phys, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, FireDAC.Stan.Async, FireDAC.DApt, uConexao,
  REST.Client, IPPeerClient, Vcl.OleCtrls, SHDocVw, REST.Authenticator.Basic,System.Generics.Collections,
  Data.Bind.Components, Data.Bind.ObjectScope, System.NetEncoding, REST.Types, uLog,StrUtils;

type
  Tfrm_Principal = class(TForm)
    pgcPrincipal: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    btnConsultaPostagens: TButton;
    mmoListarPostagens: TMemo;
    btnGravar: TButton;
    Label2: TLabel;
    Label1: TLabel;
    edtCodigoUsuario: TEdit;
    dbgListaPostagens: TDBGrid;
    btnExibir: TButton;
    edtCodigo: TEdit;
    btnAlterar: TButton;
    btnExcluir: TButton;
    Label3: TLabel;
    edtTituloPostagem: TEdit;
    mmoPostagem: TMemo;
    dsPostagens: TDataSource;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDQuery: TFDQuery;
    mmoLog: TMemo;
    Label5: TLabel;
    edtServidor: TEdit;
    Label4: TLabel;
    edtBanco: TEdit;
    Label6: TLabel;
    edtUsuarioBanco: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label7: TLabel;
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgListaPostagensDblClick(Sender: TObject);
    procedure btnExibirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnConsultaPostagensClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FPostagensControl : TPostagensControl;
    FConexao : TConexao;
    FRestClient : TRESTClient;
    FRestRequest : TRESTRequest;
    FRestResponse : TRESTResponse;
    FLog: TLog;

  public
    { Public declarations }
    procedure CarregarDados;
    function Gravar() : Boolean;
    function GetPostagem(): string;
    function ConectarBanco():Boolean;

    procedure AfterConstruction; override;

  end;

var
  frm_Principal: Tfrm_Principal;


implementation

{$R *.dfm}

procedure Tfrm_Principal.AfterConstruction;
begin
  inherited;
  FLog := TLog.Create;
  FLog.SetCalback(procedure  (pValor: string)
  begin
    mmoLog.Lines.Add(pvalor);
  end);
end;


procedure Tfrm_Principal.btnAlterarClick(Sender: TObject);
begin
  FPostagensControl.Alterar(StrToInt(edtCodigoUsuario.Text),StrToInt(edtCodigo.Text),edtTituloPostagem.Text,mmoPostagem.Text);
  CarregarDados;
  FLog.Add('Editado: ' + 'IdPostagem: ' + edtCodigo.Text );
end;


procedure Tfrm_Principal.btnConsultaPostagensClick(Sender: TObject);
var
  json : string;
begin
  json := GetPostagem;
  mmoListarPostagens.Lines.Text := json;
end;

procedure Tfrm_Principal.btnExcluirClick(Sender: TObject);
begin
  if edtCodigo.Text <> EmptyStr then
  begin
    if (Application.MessageBox(PChar('Deseja excluir o registro?'), 'Confirmação', MB_YESNO
      + MB_DEFBUTTON2 + MB_ICONQUESTION) = mrYes) then
    begin
      FPostagensControl.Excluir(StrToInt(edtCodigo.Text));
      CarregarDados;
      FLog.Add('Excluído: ' + 'IdPostagem :' + edtCodigo.Text );
    end;
  end;
end;

procedure Tfrm_Principal.btnExibirClick(Sender: TObject);
begin
  CarregarDados;
end;

procedure Tfrm_Principal.btnGravarClick(Sender: TObject);
begin
  if Gravar then
    Application.MessageBox('Gravado com sucesso!', 'Warning', MB_OK +
      MB_ICONWARNING);
      ;
end;


procedure Tfrm_Principal.Button1Click(Sender: TObject);
begin
  if ConectarBanco then
    ShowMessage('Conectado com Sucesso!');
end;

procedure Tfrm_Principal.Button2Click(Sender: TObject);
begin
  if FPostagensControl.CriarBanco(edtBanco.Text) then
  begin
    ShowMessage('Banco de dados e tabela criada com sucesso!');
    ConectarBanco;
    FPostagensControl.ExecutaScript;
    btnGravar.Enabled := True;
  end;
end;

procedure Tfrm_Principal.CarregarDados;
var
  FPostagensControl : TPostagensControl;
begin
  FPostagensControl := TPostagensControl.Create;
  try
    FConexao := TConexao.GetInstancia;
    FDQuery.Connection := FConexao.CriaConexao;
    FDQuery.Close;
    FDQuery.Data := FPostagensControl.Exibir;
    FDQuery.Open();

  finally
    FPostagensControl.Free;
  end;
end;

function Tfrm_Principal.ConectarBanco: Boolean;
begin
  FConexao := TConexao.GetInstancia;
  Result := FConexao.ConectaBaseDeDados(edtServidor.Text, edtBanco.Text, edtUsuarioBanco.Text);
end;

procedure Tfrm_Principal.dbgListaPostagensDblClick(Sender: TObject);
begin
  edtCodigoUsuario.Text := FDQuery.Fields[0].AsString;
  edtCodigo.Text := FDQuery.Fields[1].AsString;
  edtTituloPostagem.Text := FDQuery.Fields[2].AsString;
  mmoPostagem.Text := FDQuery.Fields[3].AsString;
end;

procedure Tfrm_Principal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FRestClient);
  FreeAndNil(FRestRequest);
  FreeAndNil(FRestResponse);
end;

procedure Tfrm_Principal.FormCreate(Sender: TObject);
begin
  mmoPostagem.Clear;
  mmoListarPostagens.Clear;
  FRestClient               := TRESTClient.Create('');
  FRestClient.ContentType   := 'application/json';
  FRestRequest              := TRESTRequest.Create(nil);
  FRestResponse             := TRESTResponse.Create(nil);
  FRestRequest.Client       := FRestClient;
  FRestRequest.Response     := FRestResponse;
  FRestRequest.Params.Clear;
  FRestRequest.Method       := rmGET;
  btnGravar.Enabled := False;
end;

function Tfrm_Principal.GetPostagem: string;
const
  URL = 'https://jsonplaceholder.typicode.com/posts';
begin
  FRestRequest.Params.Clear;
  FRestRequest.Method := rmGET;
  FRestClient.BaseURL := URL;
  FRestRequest.Execute;
  Result := FRestResponse.Content;
end;

function Tfrm_Principal.Gravar : Boolean;
var
  json : string;
  jsArray : TJSONArray;
  i : Integer;
begin
  try
    json := mmoListarPostagens.Lines.Text ;
    jsArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONArray;

    for i := 0 to JSArray.Size - 1 do
    begin
      FPostagensControl.Inserir(
                                jsArray.Get(i).GetValue<integer>('userId', 0),
                                jsArray.Get(i).GetValue<integer>('id', 0),
                                jsArray.Get(i).GetValue<string>('title', ''),
                                jsArray.Get(i).GetValue<string>('body', '')
                                );
    end;
  finally
    jsArray.DisposeOf;
  end;
end;

end.
