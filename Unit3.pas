unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, unit1;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ColorDialog1: TColorDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
if colordialog1.Execute then
edit1.Color:=colordialog1.Color;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
if colordialog1.Execute then
edit2.Color:=colordialog1.Color;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
if colordialog1.Execute then
edit3.Color:=colordialog1.Color;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
if colordialog1.Execute then
edit4.Color:=colordialog1.Color;
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
form1.StringGrid1.Refresh;
form3.Close;
end;

procedure TForm3.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, 'a', 'A', 'b', 'B', 'c', 'C', 'd', 'D', 'e', 'E', 'f', 'F']) then
    Key := #0;
end;

procedure TForm3.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, 'a', 'A', 'b', 'B', 'c', 'C', 'd', 'D', 'e', 'E', 'f', 'F']) then
    Key := #0;
end;

procedure TForm3.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, 'a', 'A', 'b', 'B', 'c', 'C', 'd', 'D', 'e', 'E', 'f', 'F']) then
    Key := #0;
end;

procedure TForm3.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, 'a', 'A', 'b', 'B', 'c', 'C', 'd', 'D', 'e', 'E', 'f', 'F']) then
    Key := #0;
end;

end.
