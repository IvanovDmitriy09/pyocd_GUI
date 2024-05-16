unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unit1, ComCtrls, ShellCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Button2: TButton;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
if edit1.Text<>'' then
begin
form1.memo1.Text:=GetDosOutput('cmd /c pyocd pack install '+ edit1.Text, 'c:\', Rc);
refresh_target;
form2.Close;
end else
messagedlg('Введите название target!', mtWarning, [mbOK], 0);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
opendialog1.Filter:='Файл keil pack|*.pack';
if opendialog1.Execute then
label2.Caption:= opendialog1.FileName;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
opendialog1.Filter:='Файл keil pack description|*.pdsc';
if opendialog1.Execute then
label3.Caption:= opendialog1.FileName;
end;

end.
