unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, math, XPMan;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    StringGrid1: TStringGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    XPManifest1: TXPManifest;
    Button3: TButton;
    Button4: TButton;
    ComboBox1: TComboBox;
    Button5: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  rc: cardinal;

implementation

{$R *.dfm}


Function GetDosOutput( const CommandLine, WorkDir: String; var
ResultCode: Cardinal ): String;
var StdOutPipeRead, StdOutPipeWrite: THandle;
   SA                             : TSecurityAttributes;
   SI                             : TStartupInfo;
   PI                             : TProcessInformation;
   WasOK                          : Boolean;
   Buffer                         : array[0..255] of Char;
   BytesRead                      : Cardinal;
   Line                           : String;
Begin
   //Application.ProcessMessages;
   With SA do
   Begin
      nLength := SizeOf( SA );
      bInheritHandle := True;
      lpSecurityDescriptor := nil;
   end;
   // ??????? ???? ??? ??????????????? ???????????? ??????
   CreatePipe( StdOutPipeRead,  // ?????????? ??????
               StdOutPipeWrite, // ?????????? ??????
               @SA,              // ????????? ????????????
               0                // ?????????? ???? ???????? ??? ????? - 0 ?? ?????????
              );
   try
    // ??????? ???????? ???????, ????????? StdOutPipeWrite ? ???????? ???????????? ??????,
    // ? ??? ?? ?????????, ????? ?? ?? ??????????? ?? ??????.
    with SI do
    Begin
       FillChar( SI, SizeOf( SI ), 0 );
       cb := SizeOf( SI );
       dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
       wShowWindow := SW_HIDE;
       hStdInput := GetStdHandle( STD_INPUT_HANDLE ); // ??????????? ???? ?? ??????????????
       hStdOutput := StdOutPipeWrite;
       hStdError := StdOutPipeWrite;
    end;

    //????????? ?????????? ?? ????????? ??????
    //WorkDir := ExtractFilePath(CommandLine);
    WasOK := CreateProcess( nil,
                            PChar( CommandLine ),
                            nil,
                            nil,
                            True,
                            0,
                            nil,
                            PChar( WorkDir ),
                            SI,
                            PI );
    // ??????, ????? ?????????? ???????, ??? ???????????? ????????? ??????.
    // ??? ?? ?????, ????? ????????? ????????? ?????? ??? ??????.
    CloseHandle( StdOutPipeWrite );
    // ???? ??????? ????? ???? ??????, ?? ??????????, ??? ??? ?????
    if not WasOK then
     raise Exception.Create( '?????? ?????????? ??? ??????????: ' +
            Chr( 10 ) + Chr( 13 ) + CommandLine )
    else
      try
        // ???????? ???? ????? ?? ??? ???, ???? DOS-?????????? ?? ????? ?????????
        Line := '';
        Repeat
           // ?????? ???? ???????? (????? ????????? ???????? ??????? ? ???????? ??????)
           WasOK := ReadFile( StdOutPipeRead, Buffer, 255, BytesRead, nil );
           // ???? ?? ???-?????? ??? ??? ???????
           if BytesRead > 0 then
           Begin
              // ????????? ????? PChar-??
              Buffer[BytesRead] := #0;
              // ????????? ????? ? ????? ?????
              Line := Line + Buffer;
           end;
           //Application.ProcessMessages;
        Until not WasOK or ( BytesRead = 0 );
        // ????, ???? ?????????? ?????????? ??????????
        WaitForSingleObject( PI.hProcess, INFINITE );
        ResultCode := 0;
        GetExitCodeProcess( PI.hProcess, ResultCode );
      finally
        // ????????? ??? ?????????? ???????????
        CloseHandle( PI.hThread );
        CloseHandle( PI.hProcess );
      end;
   finally
     Result := Line;
     CloseHandle( StdOutPipeRead );
 end;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
s, sc: string;
p, i: longint;
begin
if (edit1.Text <> '') and (edit2.Text <> '') and (edit3.Text <> '') then
begin
s:=GetDosOutput('cmd /c pyocd cmd -u '+ copy(combobox1.Items.Text, 25, 6) +' -t '+ edit3.Text +' -c "read8 0x'+edit1.text+' '+edit2.text+'"', 'c:\', Rc);
memo1.Text:=s;

stringgrid1.RowCount:=ceil(strtoint(edit2.Text)/16)+1;


for i:=1 to stringgrid1.RowCount+1 do
begin
p:=pos('|', s);
sc:=copy(s, 0, p-5);
stringgrid1.Cells[0,i]:=copy(sc,0,8);
stringgrid1.Cells[1,i]:=copy(sc,12,2);
stringgrid1.Cells[2,i]:=copy(sc,15,2);
stringgrid1.Cells[3,i]:=copy(sc,18,2);
stringgrid1.Cells[4,i]:=copy(sc,21,2);
stringgrid1.Cells[5,i]:=copy(sc,25,2);
stringgrid1.Cells[6,i]:=copy(sc,28,2);
stringgrid1.Cells[7,i]:=copy(sc,31,2);
stringgrid1.Cells[8,i]:=copy(sc,34,2);
stringgrid1.Cells[9,i]:=copy(sc,38,2);
stringgrid1.Cells[10,i]:=copy(sc,41,2);
stringgrid1.Cells[11,i]:=copy(sc,44,2);
stringgrid1.Cells[12,i]:=copy(sc,47,2);
stringgrid1.Cells[13,i]:=copy(sc,51,2);
stringgrid1.Cells[14,i]:=copy(sc,54,2);
stringgrid1.Cells[15,i]:=copy(sc,57,2);
stringgrid1.Cells[16,i]:=copy(sc,60,2);

delete(s, 1, p);
p:=pos(#13, s);
delete(s, 1, p+1);
end;
messagedlg('Flash прочитана!', mtInformation, [mbOK], 0);

end else
messagedlg('Не все поля заполнены!', mtWarning, [mbOK], 0);

end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, 'a', 'A', 'b', 'B', 'c', 'C', 'd', 'D', 'e', 'E', 'f', 'F']) then
    Key := #0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
stringgrid1.ColWidths[0]:=55;

stringgrid1.Cells[1,0]:='0';
stringgrid1.Cells[2,0]:='1';
stringgrid1.Cells[3,0]:='2';
stringgrid1.Cells[4,0]:='3';
stringgrid1.Cells[5,0]:='4';
stringgrid1.Cells[6,0]:='5';
stringgrid1.Cells[7,0]:='6';
stringgrid1.Cells[8,0]:='7';
stringgrid1.Cells[9,0]:='8';
stringgrid1.Cells[10,0]:='9';
stringgrid1.Cells[11,0]:='A';
stringgrid1.Cells[12,0]:='B';
stringgrid1.Cells[13,0]:='C';
stringgrid1.Cells[14,0]:='D';
stringgrid1.Cells[15,0]:='E';
stringgrid1.Cells[16,0]:='F';
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if edit3.Text <> '' then
begin
if messagedlg('Вы точно хотите очистить Flash?', mtConfirmation, [mbYes, mbNo], 0)= mryes then
begin
memo1.text:=GetDosOutput('cmd /c pyocd cmd -u '+ copy(combobox1.Items.Text, 25, 6) +' -t '+ edit3.Text +' -c "erase"', 'c:\', Rc);
messagedlg('Flash очищена!', mtInformation, [mbOK], 0);
end else
end else
messagedlg('Не все поля заполнены!', mtWarning, [mbOK], 0);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
s, sl: string;
p: integer;
begin

s:=GetDosOutput('cmd /c pyocd list', 'c:\', Rc);
combobox1.Clear;

p:=pos(#13, s);

while pos(#13, s)<>0 do
begin
p:=pos(#13, s);
delete(s, 1, p+1);
p:=pos(#13, s);
delete(s, 1, p+1);
memo1.Text:=s;
combobox1.Items.Add(s);
end;
combobox1.Items.Delete(combobox1.Items.Count-1);

combobox1.ItemIndex:=0;

if combobox1.Text='' then
begin
button1.Enabled:=false;
button2.Enabled:=false;
button5.Enabled:=false;
edit3.Enabled:=false;
end else
begin
button1.Enabled:=true;
button2.Enabled:=true;
button5.Enabled:=true;
edit3.Enabled:=true;
end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
if (edit3.Text <> '') and (edit4.Text <> '') then
begin
if messagedlg('Вы точно хотите записать файл '+ label1.Caption +' на Flash?', mtConfirmation, [mbYes, mbNo], 0)= mryes then
begin
memo1.Text:=GetDosOutput('cmd /c pyocd cmd -u '+ copy(combobox1.Items.Text, 25, 6) +' -t '+ edit3.Text +' -c "load '+label1.caption+' 0x'+edit4.text+'"', 'c:\', Rc);
messagedlg('Файл '+label1.caption+' записан на Flash по адресу: 0x'+ edit4.Text +'!', mtInformation, [mbOK], 0);
end else
end else
messagedlg('Не все поля заполнены!', mtWarning, [mbOK], 0);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
if opendialog1.Execute then
label1.Caption:=opendialog1.FileName;
if label1.Caption<>'' then
button4.Enabled:=true else
button4.Enabled:=false;
end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, 'a', 'A', 'b', 'B', 'c', 'C', 'd', 'D', 'e', 'E', 'f', 'F']) then
    Key := #0;
end;

end.
