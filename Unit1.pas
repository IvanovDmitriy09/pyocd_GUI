unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, math, Buttons, ExtCtrls, Menus, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    StringGrid1: TStringGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Button3: TButton;
    Button4: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    ComboBox2: TComboBox;
    Button6: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    ComboBox3: TComboBox;
    Label5: TLabel;
    Button5: TButton;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Button6Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure N1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  rc: cardinal;
  Function GetDosOutput( const CommandLine, WorkDir: String; var ResultCode: Cardinal ): String;
  procedure refresh_target;
  procedure refresh_debugprobe;
implementation

uses Unit2, Unit3;

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
   Screen.Cursor := CrHourGlass;
   //Application.ProcessMessages;
   With SA do
   Begin
      nLength := SizeOf( SA );
      bInheritHandle := True;
      lpSecurityDescriptor := nil;
   end;
   // создаём пайп для перенаправления стандартного вывода
   CreatePipe( StdOutPipeRead,  // дескриптор чтения
               StdOutPipeWrite, // дескриптор записи
               @SA,              // аттрибуты безопасности
               0                // количество байт принятых для пайпа - 0 по умолчанию
              );
   try
    // Создаём дочерний процесс, используя StdOutPipeWrite в качестве стандартного вывода,
    // а так же проверяем, чтобы он не показывался на экране.
    with SI do
    Begin
       FillChar( SI, SizeOf( SI ), 0 );
       cb := SizeOf( SI );
       dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
       wShowWindow := SW_HIDE;
       hStdInput := GetStdHandle( STD_INPUT_HANDLE ); // стандартный ввод не перенаправляем
       hStdOutput := StdOutPipeWrite;
       hStdError := StdOutPipeWrite;
    end;

    // Запускаем компилятор из командной строки
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
    // Теперь, когда дескриптор получен, для безопасности закрываем запись.
    // Нам не нужно, чтобы произошло случайное чтение или запись.
    CloseHandle( StdOutPipeWrite );
    // если процесс может быть создан, то дескриптор, это его вывод
    if not WasOK then
     raise Exception.Create( '?????? ?????????? ??? ??????????: ' +
            Chr( 10 ) + Chr( 13 ) + CommandLine )
    else
      try
        // получаем весь вывод до тех пор, пока DOS-приложение не будет завершено
        Line := '';
        Repeat
           // читаем блок символов (могут содержать возвраты каретки и переводы строки)
           WasOK := ReadFile( StdOutPipeRead, Buffer, 255, BytesRead, nil );
           // есть ли что-нибудь ещё для чтения?
           if BytesRead > 0 then
           Begin
              // завершаем буфер PChar-ом
              Buffer[BytesRead] := #0;
              // добавляем буфер в общий вывод
              Line := Line + Buffer;
           end;
           //Application.ProcessMessages;
        Until not WasOK or ( BytesRead = 0 );
        // ждём, пока завершится консольное приложение
        WaitForSingleObject( PI.hProcess, INFINITE );
        ResultCode := 0;
        GetExitCodeProcess( PI.hProcess, ResultCode );
      finally
        // Закрываем все оставшиеся дескрипторы
        CloseHandle( PI.hThread );
        CloseHandle( PI.hProcess );
      end;
   finally
     Result := Line;
     CloseHandle( StdOutPipeRead );
     Screen.Cursor := CrDefault;
 end;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  s, sc: string;
  p, i, z: longint;
begin
  if (edit1.Text <> '') and (edit2.Text <> '') and (combobox2.Text <> '') then
  begin
  edit2.Text:=inttostr(strtoint(edit2.Text));
    if (edit2.Text<>'0') then
    begin
    progressbar1.Position:=0;
      s:=GetDosOutput('cmd /c pyocd cmd -u '+ copy(combobox1.Items.Text, 25, 6) +' -t '+ combobox2.Text +' -f '+ combobox3.Text +' -c "read8 0x'+edit1.text+' '+edit2.text+'"', 'c:\', Rc);

      memo1.Text:=s;
      stringgrid1.RowCount:=ceil(strtoint(edit2.Text)/16)+1;
      progressbar1.Max:=stringgrid1.RowCount;
      z:=length(edit1.Text);
      if z<>8 then
        begin
          z:=8-z;
          for i:=1 to z do
          edit1.Text:='0'+edit1.Text;
        end;
      p:=pos(edit1.text, s);
      delete(s, 1, p-1);
      for i:=1 to stringgrid1.RowCount+1 do
        begin
          progressbar1.Position:=progressbar1.Position+1;
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
      if stringgrid1.Cells[1,1]<>'' then
        SpeedButton1.Enabled:=true else
          SpeedButton1.Enabled:=false;
      messagedlg('Flash прочитана!', mtInformation, [mbOK], 0);
      end else
      messagedlg('Объем считываемой памяти не может быть равен 0!', mtWarning, [mbOK], 0);
  end else
  messagedlg('Не все поля заполнены!', mtWarning, [mbOK], 0);
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, 'a', 'b', 'c', 'd', 'e', 'f']) then
    Key := #0;
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
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

procedure TForm1.Button2Click(Sender: TObject);
begin
  if combobox2.Text <> '' then
    begin
      if messagedlg('Вы точно хотите очистить Flash?', mtConfirmation, [mbYes, mbNo], 0)= mryes then
      begin
        memo1.text:=GetDosOutput('cmd /c pyocd cmd -u '+ copy(combobox1.Items.Text, 25, 6) +' -t '+ combobox2.Text +' -f '+ combobox3.Text +' -c "erase"', 'c:\', Rc);
        messagedlg('Flash очищена!', mtInformation, [mbOK], 0);
      end else
    end else
  messagedlg('Не все поля заполнены!', mtWarning, [mbOK], 0);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  refresh_debugprobe;
    if combobox1.Text='' then
      begin
        button1.Enabled:=false;
        button2.Enabled:=false;
        speedButton2.Enabled:=false;
      end else
      begin
        button1.Enabled:=true;
        button2.Enabled:=true;
        speedButton2.Enabled:=true;
      end;
  refresh_target;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if (combobox2.Text <> '') and (edit4.Text <> '') then
    begin
      if messagedlg('Вы точно хотите записать файл '+ label1.Caption +' на Flash?', mtConfirmation, [mbYes, mbNo], 0)= mryes then
        begin
          memo1.Text:=GetDosOutput('cmd /c pyocd flash -u '+ copy(combobox1.Items.Text, 25, 6) +' -t '+ combobox2.Text +' -f '+ combobox3.Text +' '+opendialog1.FileName+' --base-address '+'0x'+edit4.text+'"', 'c:\', Rc);
          messagedlg('Файл '+label1.caption+' записан на Flash по адресу: 0x'+ edit4.Text +'!', mtInformation, [mbOK], 0);
        end else
    end else
    messagedlg('Не все поля заполнены!', mtWarning, [mbOK], 0);
end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, 'a', 'b', 'c', 'd', 'e', 'f']) then
    Key := #0;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  form2.ShowModal;
end;

procedure refresh_debugprobe;
var
  s: string;
  p: integer;
begin
  s:=GetDosOutput('cmd /c pyocd list', 'c:\', Rc);
  form1.combobox1.Clear;
    while pos(#13, s)<>0 do
      begin
        p:=pos(#13, s);
        delete(s, 1, p+1);
        p:=pos(#13, s);
        delete(s, 1, p+1);
        form1.memo1.Text:=s;
        form1.combobox1.Items.Add(s);
      end;
  form1.combobox1.Items.Delete(form1.combobox1.Items.Count-1);
  form1.combobox1.ItemIndex:=0;
end;

procedure refresh_target;
var
  s, sl: string;
  p, i: integer;
begin
  s:=GetDosOutput('cmd /c pyocd list -t', 'c:\', Rc);
  form1.combobox2.Clear;
  while pos('pack', s)<>0 do
  begin
    p:=pos('pack', s);
    while s[p] <> #13  do
    begin
      p:=p-1;
    end;
    delete(s, 1, p);
    p:=pos('pack', s);
    sl:=copy(s, 0, p-1);
    i:=pos('   ', sl);
    delete(sl, 1, i);

    i:=1;
      while sl[i] = ' '  do
      begin
        i:=i+1;
      end;
    delete(sl, 1, i-1);
    i:=pos('   ', sl);
    delete(sl, 1, i);
    i:=1;
      while sl[i] = ' '  do
      begin
        i:=i+1;
      end;
      delete(sl, 1, i-1);
      i:=pos(' ', sl);
      sl:=copy(sl, 0, i-1);
      form1.combobox2.Items.Add(sl);
      form1.combobox2.ItemIndex:=0;
    delete(s, 1, p);
  end;
end;



procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if opendialog1.Execute then
    label1.Caption:=opendialog1.FileName;
      if label1.Caption<>'' then
        button4.Enabled:=true else
          button4.Enabled:=false;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  byte1: byte;
  fs: TFileStream;
  i, n: integer;
begin
  savedialog1.Filter:='Двоичный файл (*.bin)|*.bin';
    if savedialog1.Execute then
      begin
        fs := TFileStream.Create(savedialog1.FileName+'.bin', fmCreate or fmOpenReadWrite or fmShareDenyWrite);
        fs.Seek(0, soFromBeginning);

        for n:=1 to stringgrid1.RowCount-1 do
          for i:=1 to 16 do
            begin
              byte1:= strtoint('$'+stringgrid1.Cells[i,n]);
              fs.Write(byte1,sizeof(byte1));
            end;
          fs.Free;
      end;
end;

procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if stringgrid1.Cells[ACol,ARow] = form3.Edit1.Text then
  begin
    Stringgrid1.Canvas.Brush.Color := form3.Edit1.Color;
    StringGrid1.Canvas.FillRect(Rect);
    StringGrid1.Canvas.TextOut(Rect.Left+2, Rect.Top+2, StringGrid1.Cells[ACol, ARow]);
  end;
  if stringgrid1.Cells[ACol,ARow] = form3.Edit2.Text then
  begin
    Stringgrid1.Canvas.Brush.Color := form3.Edit2.Color;
    StringGrid1.Canvas.FillRect(Rect);
    StringGrid1.Canvas.TextOut(Rect.Left+2, Rect.Top+2, StringGrid1.Cells[ACol, ARow]);
  end;
  if stringgrid1.Cells[ACol,ARow] = form3.Edit3.Text then
  begin
    Stringgrid1.Canvas.Brush.Color := form3.Edit3.Color;
    StringGrid1.Canvas.FillRect(Rect);
    StringGrid1.Canvas.TextOut(Rect.Left+2, Rect.Top+2, StringGrid1.Cells[ACol, ARow]);
  end;
  if stringgrid1.Cells[ACol,ARow] = form3.Edit4.Text then
  begin
    Stringgrid1.Canvas.Brush.Color := form3.Edit4.Color;
    StringGrid1.Canvas.FillRect(Rect);
    StringGrid1.Canvas.TextOut(Rect.Left+2, Rect.Top+2, StringGrid1.Cells[ACol, ARow]);
  end;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
Form3.ShowModal;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
s: string;
f: TFileStream;
a: byte;
i, j, b: integer;
begin
progressbar1.Position:=0;
progressbar1.Max:=strtoint(edit2.Text);
b:=strtoint('$'+edit1.Text);
s:=GetDosOutput('cmd /c pyocd cmd -u '+ copy(combobox1.Items.Text, 25, 6) +' -t '+ combobox2.Text +' -f '+ combobox3.Text +' -c "savemem 0x'+edit1.text+' '+edit2.text+' dump~.bin"', extractfilepath(application.ExeName), Rc);
memo1.Text:=s;
f:= TFileStream.Create('dump~.bin', fmOpenRead);
stringgrid1.RowCount:=ceil(f.Size/16)+1;
f.Position:=0;
for i:=1 to stringgrid1.RowCount do
begin
stringgrid1.Cells[0, i]:=inttohex(b,8);
b:=b+$10;
for j:=1 to 16 do
begin
f.Read(a, 1);
stringgrid1.Cells[j, i]:=inttohex(a,2);
progressbar1.Position:=progressbar1.Position+1;
if f.Position = strtoint(edit2.Text) then
break else
end;
end;
f.Free;
end;

end.
