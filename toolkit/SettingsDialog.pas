unit SettingsDialog;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.EditBox,
  FMX.SpinBox, FMX.Edit, FMX.StdCtrls, FMX.TabControl, FMX.Controls.Presentation,
  IniFiles, System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox;

type
  TSettingsForm = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    Label1: TLabel;
    Label2: TLabel;
    edtProxy: TEdit;
    edtTimeout: TSpinBox;
    Label3: TLabel;
    Label4: TLabel;
    TabItem2: TTabItem;
    Grid1: TGrid;
    StringColumn1: TStringColumn;
    btnAdd: TButton;
    btnUp: TButton;
    btnDown: TButton;
    btnDelete: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Grid1GetValue(Sender: TObject; const ACol, ARow: Integer;
      var Value: TValue);
    procedure Grid1Resize(Sender: TObject);
    procedure Grid1SelChanged(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure Grid1SetValue(Sender: TObject; const ACol, ARow: Integer;
      const Value: TValue);
  private
    FIni : TIniFile;
    FServers : TStringList;
  public
    Property Ini : TIniFile read FIni write FIni;
  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.fmx}

procedure TSettingsForm.btnAddClick(Sender: TObject);
begin
  FServers.Add('http://...');
  Grid1.RowCount := 0;
  Grid1.RowCount := FServers.Count;
  Grid1.Row := FServers.Count - 1;
  Grid1SelChanged(nil);
end;

procedure TSettingsForm.btnDeleteClick(Sender: TObject);
var
  i : integer;
begin
  i := Grid1.Row;
  FServers.Delete(i);
  Grid1.RowCount := 0;
  Grid1.RowCount := FServers.Count;
  Grid1.Row := i - 1;
  Grid1SelChanged(nil);
end;

procedure TSettingsForm.btnDownClick(Sender: TObject);
var
  i : integer;
begin
  i := Grid1.Row;
  FServers.Exchange(i, i+1);
  Grid1.RowCount := 0;
  Grid1.RowCount := FServers.Count;
  Grid1.Row := i - 1;
  Grid1SelChanged(nil);
end;

procedure TSettingsForm.btnUpClick(Sender: TObject);
var
  i : integer;
begin
  i := Grid1.Row;
  FServers.Exchange(i, i-1);
  Grid1.RowCount := 0;
  Grid1.RowCount := FServers.Count;
  Grid1.Row := i - 1;
  Grid1SelChanged(nil);
end;

procedure TSettingsForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  s : String;
begin
  if ModalResult = mrOk then
  begin
    FIni.WriteString('HTTP', 'proxy', edtProxy.Text);
    FIni.WriteInteger('HTTP', 'timeout', trunc(edtTimeout.Value));
    FIni.EraseSection('Terminology-Servers');
    for s in FServers do
      FIni.WriteString('Terminology-Servers', s, '');
  end;
  FServers.free;
end;

procedure TSettingsForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
end;

procedure TSettingsForm.FormShow(Sender: TObject);
begin
  edtProxy.Text := FIni.ReadString('HTTP', 'proxy', '');
  edtTimeout.Value := FIni.ReadInteger('HTTP', 'timeout', 5);
  FServers := TStringList.create;
  FIni.ReadSection('Terminology-Servers', FServers);
  if FServers.Count = 0 then
  begin
    FServers.add('http://tx.fhir.org/r3');
    FIni.WriteString('Terminology-Servers', 'http://tx.fhir.org/r3', '');
  end;
  Grid1.RowCount := 0;
  Grid1.RowCount := FServers.Count;
  Grid1SelChanged(nil);
end;

procedure TSettingsForm.Grid1GetValue(Sender: TObject; const ACol, ARow: Integer; var Value: TValue);
begin
  Value := FServers[aRow];
end;

procedure TSettingsForm.Grid1Resize(Sender: TObject);
begin
  Grid1.Columns[0].Width := Grid1.Width - 4;
end;

procedure TSettingsForm.Grid1SelChanged(Sender: TObject);
begin
  btnAdd.enabled := true;
  btnDown.enabled := (grid1.Row > -1) and (grid1.Row < FServers.Count - 1);
  btnUp.enabled := grid1.Row > 0;
  btnDelete.enabled := (grid1.Row > -1) and (FServers.Count > 1);
end;

procedure TSettingsForm.Grid1SetValue(Sender: TObject; const ACol, ARow: Integer; const Value: TValue);
begin
  FServers[aRow] := Value.AsString;

end;

end.
