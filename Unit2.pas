unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Unit1, ComCtrls, ShellCtrls, AbBase, AbBrowse,
  AbZBrows, AbUnzper, xmldom, XMLIntf, msxmldom, XMLDoc, FileCTRL;

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
    AbUnZipper1: TAbUnZipper;
    XMLDocument1: TXMLDocument;
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
  rc: cardinal;

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
label2.Caption:= MinimizeName(opendialog1.FileName, label2.Canvas, 250);
AbUnZipper1.FileName:=opendialog1.FileName;
AbUnZipper1.BaseDirectory:=ExtractFilePath(opendialog1.FileName);
end;

procedure TForm2.Button3Click(Sender: TObject);
var
searchResult : TSearchRec;
s, filename, filepath, tvendor, tname, tvers: string;
doc: IXMLDocument;
parentnode: IXMLNode;
begin
if opendialog1.FileName<>'' then
begin
AbUnZipper1.ExtractFiles('*.pdsc');
FindFirst('*.pdsc', faAnyFile, searchResult);
filepath:= AbUnZipper1.BaseDirectory;
filename:= searchResult.Name;
GetDosOutput('cmd /c python -c "import cmsis_pack_manager.pack_manager as pack_manager; pack_manager.main()" add-packs '+ filepath +'\'+filename, 'c:\', Rc);

doc := TXMLDocument.Create(Nil);
doc.LoadFromFile(filepath+'\'+filename);
doc.Active:=True;
parentnode:=doc.ChildNodes.FindNode('package');
tvendor:=parentnode.ChildNodes['vendor'].NodeValue;
tname:=parentnode.ChildNodes['name'].NodeValue;
tvers:=parentnode.ChildNodes['releases'].ChildNodes[0].Attributes['version'];
s :=ExtractFilePath(GetEnvironmentVariable('APPDATA'));
s:=s+'\Local\cmsis-pack-manager\cmsis-pack-manager\'+ tvendor;
CreateDir(s);
s:=s+'\'+tname;
CreateDir(s);
CopyFile(PAnsiChar(opendialog1.FileName), PAnsiChar(s+'\'+tvers+'.pack'), false);
doc.Active:=False;
doc:=nil;
FindClose(searchResult);
DeleteFile(filepath+'\'+filename);
refresh_target;
form2.Close;
end else
messagedlg('Выберите файл *.pack!', mtWarning, [mbOK], 0);
end;

end.
