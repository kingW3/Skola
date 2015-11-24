unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Menus;

type
  TForm2 = class(TForm)
    StringGrid1: TStringGrid;
    Predmeti: TListBox;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit2: TEdit;
    Button5: TButton;
    Button6: TButton;
    MainMenu1: TMainMenu;
    asd1: TMenuItem;
    sad1: TMenuItem;
    asd: TMenuItem;
    Ucenici: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure sad1Click(Sender: TObject);
    procedure asdClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    UceniciFile : TextFile;
    Neocenjeni : TStringList;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
// procedura za brisanje reda u slucaju da neki predmet mora da se izbrise
procedure DeleteRow(Grid: TStringGrid; ACol: Integer);
var
  i: Integer;
begin
  for i := ACol to Grid.ColCount - 2 do
    Grid.Cols[i].Assign(Grid.Cols[i + 1]);
  Grid.ColCount := Grid.ColCount - 1;
end;
procedure DeleteCol(Grid: TStringGrid; ARow: Integer);
var
  i: Integer;
begin
  for i := ARow to Grid.RowCount - 2 do
    Grid.Rows[i].Assign(Grid.Rows[i + 1]);
  Grid.RowCount := Grid.RowCount - 1;
end;
// dodati pocetne predmete
procedure TForm2.FormCreate(Sender: TObject);
begin
StringGrid1.Rows[0][0]:='asd';
Predmeti.Items.Add('Srpski jezik i knjizevnost');
Predmeti.Items.Add('Engleski jezik');
Predmeti.Items.Add('Drugi strani jezik');
Predmeti.Items.Add('Latinski jezik');
Predmeti.Items.Add('Ustav i prava gradjana');
Predmeti.Items.Add('Sociologija');
Predmeti.Items.Add('Psihologija');
Predmeti.Items.Add('Filozofija');
Predmeti.Items.Add('Istorija');
Predmeti.Items.Add('Geografija');
Predmeti.Items.Add('Biologija');
Predmeti.Items.Add('Matematika');
Predmeti.Items.Add('Fizika');
Predmeti.Items.Add('Hemija');
Predmeti.Items.Add('Racunarstvo i informatika');
Predmeti.Items.Add('Muzicka kultura');
Predmeti.Items.Add('Likovna kultura');
Predmeti.Items.Add('Gradjansko/Verska nastava');
Predmeti.Items.Add('Fizicka kultura');
Ucenici.Items.Add('Cope');
Ucenici.Items.Add('Mirko');
Ucenici.Items.Add('Mitar');
Ucenici.Items.Add('asd');
Ucenici.Items.Add('fgh');
Ucenici.Items.Add('jkl');
Ucenici.Items.Add('mnj');
StringGrid1.ColCount:=Predmeti.Items.Count+1;
StringGrid1.RowCount:=Ucenici.Items.Count+1;
Neocenjeni :=TStringList.Create;
AssignFile(UceniciFile, 'Test.txt');
ReWrite(UceniciFile);
end;
// izbrisi predmet koji je selektovan
procedure TForm2.Button2Click(Sender: TObject);
  begin
    DeleteRow(StringGrid1,Predmeti.ItemIndex);
    Predmeti.Items.Delete(Predmeti.ItemIndex);
  end;
//dodaj predmet iz Edit1.Text
procedure TForm2.Button1Click(Sender: TObject);
  begin
    Predmeti.Items.Add(Edit1.Text);
    StringGrid1.ColCount:=StringGrid1.ColCount+1;
		StringGrid1.Cells[StringGrid1.ColCount-1,0]:=Predmeti.Items.Strings[Predmeti.Items.Count-1];
	end;
//Ubaci predmete iz liste u StringGrid
procedure TForm2.Button3Click(Sender: TObject);
	var brojac : integer;
	begin
		for brojac:=0 to Predmeti.Items.Count-1
		do
			begin
				StringGrid1.Rows[0][brojac+1]:=Predmeti.Items.Strings[brojac];
			end;
	end;
//Ako je broj 1 u celiji onda ga oboji u crveno ako je 0 u sivo
procedure TForm2.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
	begin
		if StringGrid1.Cells[ACol,ARow]='1' then
			begin
				StringGrid1.Canvas.Brush.Color:=clRed;
				StringGrid1.Canvas.FillRect(Rect);
				StringGrid1.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, StringGrid1.Cells[acol, arow]);
			end;
		if StringGrid1.Cells[ACol,ARow]='0' then
			begin
				StringGrid1.Canvas.Brush.Color:=clGray;
				StringGrid1.Canvas.FillRect(Rect);
				StringGrid1.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, StringGrid1.Cells[acol, arow]);
			end
	end;
procedure TForm2.StringGrid1KeyPress(Sender: TObject; var Key: Char);
	begin
		if Key in ['0'..'5'] then
		StringGrid1.Cells[StringGrid1.Col,StringGrid1.Row]:=Key;
	end;


procedure TForm2.Button4Click(Sender: TObject);
	var brojac : integer;
	begin
		for brojac:=0 to Ucenici.Items.Count-1
			do
				StringGrid1.Cols[0][brojac+1]:=Ucenici.Items.Strings[brojac];
			end;

procedure TForm2.Button5Click(Sender: TObject);
	begin
		Ucenici.Items.Add(Edit2.Text);
		StringGrid1.rowCount:=StringGrid1.RowCount+1;
		StringGrid1.Cells[0,StringGrid1.RowCount-1]:=Ucenici.Items.Strings[Ucenici.Items.Count-1];
	end;

procedure TForm2.Button6Click(Sender: TObject);
	begin
		DeleteCol(StringGrid1,Ucenici.ItemIndex+1);
		Ucenici.Items.Delete(Ucenici.ItemIndex);
	end;

procedure TForm2.sad1Click(Sender: TObject);
	var brojac1,brojac2,brojacjed,brojacnul : integer;
	begin
		brojacjed:=0;
		brojacnul:=0;
		for brojac1:=1 to StringGrid1.RowCount do
		for brojac2:=1 to StringGrid1.ColCount do
			if (StringGrid1.Cells[brojac2,brojac1]='1') then brojacjed:=brojacjed+1
			else if (StringGrid1.Cells[brojac2,brojac1]='0') then brojacnul:=brojacnul+1;
		showmessage('Broj jedinica je : ' + Inttostr(brojacjed)+ ', a broj neocenjenih je '+inttostr(brojacnul));
	end;

procedure TForm2.asdClick(Sender: TObject);
	var brojac1,brojac2,brojac3 : integer;
	begin
		for brojac1:=1 to StringGrid1.RowCount do
		for brojac2:=1 to StringGrid1.ColCount do
			if (StringGrid1.Cells[brojac2,brojac1]='0') then Neocenjeni.Add(IntToStr(Brojac1));
		for brojac3:=1 to Neocenjeni.Count do showmessage('Ucenik '+StringGrid1.Cells[0,StrToint(Neocenjeni.Strings[brojac3-1])]);
	Neocenjeni.Clear;
	end;

end.
