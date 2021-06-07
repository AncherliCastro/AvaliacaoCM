program AvaliacaoCM;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frm_Principal},
  uConexao in 'uConexao.pas',
  uPostagensDAO in 'uPostagensDAO.pas',
  uPostagensModel in 'uPostagensModel.pas',
  uPostagensControl in 'uPostagensControl.pas',
  uLog in 'uLog.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_Principal, frm_Principal);
  Application.Run;
end.
