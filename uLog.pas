unit uLog;

interface
  uses
    System.Classes, System.Contnrs, System.Generics.Collections,  System.SysUtils;
type
  TLog = class(TThread)
  private

  protected
    FCalback : TProc<String>;
    FFila: TQueue<string>;
    procedure Execute; override;
    procedure Escrever;
  public
    procedure SetCalback(pValor: TProc<String>);
    procedure Add(value: string);
    constructor Create;
    destructor Destroy; override;

  end;
implementation

{ TLog }

procedure TLog.Add(value: string);
begin
  FFila.Enqueue(value);
end;

constructor TLog.Create;
begin
  FFila := TQueue<string>.Create;
  inherited Create(False);
end;

destructor TLog.Destroy;
begin
  FFila.Free;
  inherited;
end;

procedure TLog.Escrever;
begin
  if Assigned(FCalback) then
    FCalback(FFila.Dequeue);
end;

procedure TLog.Execute;
begin
  inherited;
  while not Self.Terminated do
  begin
    Sleep(500);
    if FFila.Count > 0 then
      Self.Synchronize(Escrever);
  end;
end;


procedure TLog.SetCalback(pValor: TProc<String>);
begin
  FCalback := pValor;
end;

end.
