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
    Izracunajprosek1: TMenuItem;
    Izracunajprosekodeljenja1: TMenuItem;
    IzracunajProsek2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure IzracunajUspeh(Tabela: TStringGrid);
    procedure IzracunajProsek(Tabela: TStringGrid);
    procedure IzracunajProsekPredmeta(Tabela: TStringGrid; Predmeti: TListBox;Kolona : integer);
    procedure UbaciPredmete(Tabela: TStringGrid; Predmeti: TListBox);
    procedure UbaciUcenike(Tabela: TStringGrid; Ucenici: TListBox);
    procedure DodajPredmet(Tabela: TStringGrid; Predmeti: TListBox);
    procedure DodajUcenika(Tabela: TStringGrid; Ucenici: TListBox);
    procedure IzracunajUspehUcenika(Tabela: TStringGrid; Ucenici: TListBox;Red : integer);
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
    procedure Izracunajprosek1Click(Sender: TObject);
    procedure Izracunajprosekodeljenja1Click(Sender: TObject);
    procedure IzracunajProsek2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    UceniciFile : TextFile;
    Neocenjeni : TStringList; //Lista djaka koji su neocenjeni
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

// procedura za brisanje odrjedjenog reda datog po broju na kojem se nalazi
procedure DeleteRow(Grid: TStringGrid; ACol: Integer);
var
  i: Integer;
begin
  for i := ACol to Grid.ColCount - 2 do
    Grid.Cols[i].Assign(Grid.Cols[i + 1]);
  Grid.ColCount := Grid.ColCount - 1;
end;
// procedura za brisanje odrjedjene kolone date po broju na kojem se nalazi
procedure DeleteCol(Grid: TStringGrid; ARow: Integer);
var
  i: Integer;
begin
  for i := ARow to Grid.RowCount - 2 do
    Grid.Rows[i].Assign(Grid.Rows[i + 1]);
  Grid.RowCount := Grid.RowCount - 1;
end;
procedure TForm2.UbaciPredmete(Tabela: TStringGrid; Predmeti: TListBox);
var brojac : integer;
begin
  for brojac:=0 to Predmeti.Items.Count-1
    do begin
      Tabela.Rows[0][brojac+1]:=Predmeti.Items.Strings[brojac];
    end;
end;
procedure TForm2.UbaciUcenike(Tabela: TStringGrid; Ucenici: TListBox);
var brojac : integer;
begin
  for brojac:=0 to Ucenici.Items.Count-1
    do
      Tabela.Cols[0][brojac+1]:=Ucenici.Items.Strings[brojac];
    //Tabela.RowCount:=Tabela.RowCount+1;
    Tabela.Cols[0][Ucenici.Items.Count+1]:='Prosek';
end;
procedure TForm2.DodajPredmet(Tabela: TStringGrid; Predmeti: TListBox);
begin
    Predmeti.Items.Add(Edit1.Text);
    Tabela.ColCount:=Tabela.ColCount+1;
		Tabela.Cells[Tabela.ColCount-1,0]:=Predmeti.Items.Strings[Predmeti.Items.Count-1];
end;
procedure TForm2.DodajUcenika(Tabela: TStringGrid; Ucenici: TListBox);
begin
    Ucenici.Items.Add(Edit2.Text);
    Tabela.RowCount:=Tabela.RowCount+1;
		Tabela.Cells[0,Tabela.RowCount-1]:=Ucenici.Items.Strings[Ucenici.Items.Count-1];
    UbaciUcenike(Tabela,Ucenici); // Zato sto se list sortira posle unosa moramo ponovo da ubacimo ucenike
end;
procedure TForm2.IzracunajUspehUcenika(Tabela: TStringGrid; Ucenici: TListBox;Red : integer);
var brojac,brojac2,brojac3,BrPredmeta : integer;
    uspeh : real;
begin
  uspeh:=0; // Uspeh je neutralan
  BrPredmeta:=Predmeti.Items.IndexOf('Uspeh');
      for brojac:=1 to BrPredmeta do // Popunimo svaki predmet
      begin
        if(Tabela.Cells[brojac,Red]='1') then // Ako je jedinica onda je i uspeh jedan
        begin
          uspeh:=BrPredmeta;
          brojac3:=1;
        end
        else if(StringGrid1.Cells[brojac,Red]='0') then // Ako je neocenjen onda ne racunaj uspeh
          begin
            uspeh:=0;
            brojac3:=0; // Da prosek ne bih bio 1 za neocenjenog ucenika sa jedinicom
            break;
          end
        else
          begin
            if not(StringGrid1.Cells[brojac,Red]='') then uspeh:=uspeh+strtoint(StringGrid1.Cells[brojac,Red]) // U ostalom saberi sve ocene (osim ako je polje prazno)
            else showmessage('Upisite ocenu u celiju koja se nalazi u koloni '+inttostr(brojac)+',redu '+inttostr(Red))
          end
        end;
        uspeh:=uspeh/(Predmeti.Items.IndexOf('Uspeh')); // Pa ih podeli sa brojem predmeta
        if(brojac3=1) then uspeh:=1;
        StringGrid1.Cells[Predmeti.Items.IndexOf('Uspeh')+1,Red]:=FloatToStr(uspeh);  // I onda ispisi u Celiju Uspeh
        uspeh:=0; // Neka sledeci ucenik pocinje sa neutralnim uspehom
        brojac3:=0 // Ne prebacujemo keceve sa ucenika na ucenika

  end;
procedure TForm2.IzracunajProsekPredmeta(Tabela: TStringGrid; Predmeti: TListBox;Kolona : integer);
var brojac,brojac2,BrUcenika : integer;
    uspeh : real;
begin
  uspeh:=0; // Uspeh je neutralan
  brojac2:=0;
  BrUcenika:=Tabela.RowCount-2;
      for brojac:=1 to BrUcenika do // Radimo za sve ucenike
      begin
        if(StringGrid1.Cells[Kolona,brojac]='0') then // Ako je neocenjen onda ne racunamo njegovu ocenu
          begin
            brojac2:=brojac2+1; // Broj ucenika koje trebamo da oduzmemo pri deljenju
            break;
          end;
        if not(StringGrid1.Cells[Kolona,brojac]='') then uspeh:=uspeh+strtoint(StringGrid1.Cells[Kolona,brojac]) // U ostalom saberi sve ocene (osim ako je polje prazno)
        else brojac2:=brojac2+1;
        end;
        if BrUcenika<>brojac2 then uspeh:=uspeh/(BrUcenika-brojac2); // Pa ih podeli sa brojem predmeta
        StringGrid1.Cells[Kolona,BrUcenika+1]:=FloatToStr(uspeh);  // I onda ispisi u celiju prosek

  end;
procedure TForm2.IzracunajProsek(Tabela : TStringGrid);
var brojac: integer;
begin
for brojac:=1 to Tabela.ColCount-1 do
IzracunajProsekPredmeta(Tabela,Predmeti,brojac);
end;
procedure TForm2.FormCreate(Sender: TObject);
begin
// dodati pocetne predmete
StringGrid1.Rows[0][0]:='asd';
{Predmeti.Items.Add('Srpski jezik i knjizevnost');
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
Predmeti.Items.Add('Muzicka kultura');}
Predmeti.Items.Add('Likovna kultura');
Predmeti.Items.Add('Gradjansko/Verska nastava');
Predmeti.Items.Add('Fizicka kultura');
Predmeti.Items.Add('Uspeh');
// dodati pocetne ucenike
Ucenici.Items.Add('Cope');
Ucenici.Items.Add('Mirko');
Ucenici.Items.Add('Mitar');
Ucenici.Items.Add('asd');
Ucenici.Items.Add('fgh');
Ucenici.Items.Add('jkl');
Ucenici.Items.Add('mnj');
// Odrediti broj kolona po velicini liste sa predmetima
StringGrid1.ColCount:=Predmeti.Items.Count+1;
StringGrid1.RowCount:=Ucenici.Items.Count+2;
Ucenici.Sorted:=true;
UbaciPredmete(StringGrid1,Predmeti);// Ubacimo predmete pre nego sto pocnemo
UbaciUcenike(StringGrid1,Ucenici);// Ubacimmo i ucenike pre nego sto pocnemo
// Kreirati listu koja sadrzi sve neocenjene
Neocenjeni :=TStringList.Create;
AssignFile(UceniciFile, 'Test.txt');
ReWrite(UceniciFile);
end;
procedure TForm2.IzracunajUspeh(Tabela : TStringGrid);
{  var brojac,brojac2,brojac3,BrPredmeta : integer;
      uspeh : real;
  begin
    uspeh:=0; // Uspeh je neutralan
    BrPredmeta:=Predmeti.Items.IndexOf('Uspeh');
    for brojac2:=1 to StringGrid1.RowCount-1 do // Trazimo uspeh svakog ucenika
      begin
        for brojac:=1 to BrPredmeta do // Popunimo svaki predmet
          begin
            if(StringGrid1.Cells[brojac,brojac2]='1') then // Ako je jedinica onda je i uspeh jedan
              begin
                uspeh:=BrPredmeta;
                brojac3:=1;
              end
            else if(StringGrid1.Cells[brojac,brojac2]='0') then // Ako je neocenjen onda ne racunaj uspeh
              begin
                uspeh:=0;
                brojac3:=0; // Da prosek ne bih bio 1 za neocenjenog ucenika sa jedinicom
                break;
              end
            else
              begin
                if not(StringGrid1.Cells[brojac,brojac2]='') then uspeh:=uspeh+strtoint(StringGrid1.Cells[brojac,brojac2]) // U ostalom saberi sve ocene (osim ako je polje prazno)
                else showmessage('Upisite ocenu u celiju koja se nalazi u koloni '+inttostr(brojac)+',redu '+inttostr(brojac2))
              end
          end;
        uspeh:=uspeh/(Predmeti.Items.IndexOf('Uspeh')); // Pa ih podeli sa brojem predmeta
        if(brojac3=1) then uspeh:=1;
        StringGrid1.Cells[Predmeti.Items.IndexOf('Uspeh')+1,brojac2]:=FloatToStr(uspeh);  // I onda ispisi u Celiju Uspeh
        uspeh:=0; // Neka sledeci ucenik pocinje sa neutralnim uspehom
        brojac3:=0 // Ne prebacujemo keceve sa ucenika na ucenika
      end;

 end;}
var brojac : integer;
begin
for brojac:=1 to Tabela.RowCount-2 do IzracunajUspehUcenika(StringGrid1,Ucenici,brojac);
end;
// Izbrisi predmet koji je selektovan
procedure TForm2.Button2Click(Sender: TObject);
  begin
    if not (Predmeti.ItemIndex=-1) then //Provera da li je neki predmet selektovan
      begin
        DeleteRow(StringGrid1,Predmeti.ItemIndex+1);
        Predmeti.Items.Delete(Predmeti.ItemIndex);
      end;
  end;
// Dodaj predmet iz Edit1.Text
procedure TForm2.Button1Click(Sender: TObject);
  begin
{    Predmeti.Items.Add(Edit1.Text);
    StringGrid1.ColCount:=StringGrid1.ColCount+1;
 		StringGrid1.Cells[StringGrid1.ColCount-1,0]:=Predmeti.Items.Strings[Predmeti.Items.Count-1];
} DodajPredmet(StringGrid1,Predmeti);
	end;
// Ubaci predmete iz liste u StringGrid
procedure TForm2.Button3Click(Sender: TObject);
	begin
  UbaciPredmete(StringGrid1,Predmeti);
	end;
// Ako je broj 1 u celiji onda ga oboji u crveno ako je 0 u sivo
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
// Dozvoliti samo unose brojeva izmedju 0 i 5
procedure TForm2.StringGrid1KeyPress(Sender: TObject; var Key: Char);
	begin
		if Key in ['0'..'5'] then
		StringGrid1.Cells[StringGrid1.Col,StringGrid1.Row]:=Key;
	end;

// Ubaci imena ucenika u prvu kolonu
procedure TForm2.Button4Click(Sender: TObject);
	var brojac : integer;
	begin
		for brojac:=0 to Ucenici.Items.Count-1
			do
				StringGrid1.Cols[0][brojac+1]:=Ucenici.Items.Strings[brojac];
			end;
// Dodaj ucenika u listu i na StringGrid
procedure TForm2.Button5Click(Sender: TObject);
begin
  DodajUcenika(StringGrid1,Ucenici);
end;
// Izbaci ucenika koji je selektovan i izbrisi njegov red
procedure TForm2.Button6Click(Sender: TObject);
	begin
    if not (Ucenici.ItemIndex=-1) then  //Provera da li je ucenik selektovan
      begin
		    DeleteCol(StringGrid1,Ucenici.ItemIndex+1);
		    Ucenici.Items.Delete(Ucenici.ItemIndex);
      end
	end;

procedure TForm2.sad1Click(Sender: TObject);
	var brojac1,brojac2,brojacjed,brojacnul : integer;
      pregledan : Bool;
	begin
		brojacjed:=0;
		brojacnul:=0;
		for brojac1:=1 to StringGrid1.RowCount do
      begin
        pregledan:=false;
		    for brojac2:=1 to StringGrid1.ColCount-1 do
			    if (StringGrid1.Cells[brojac2,brojac1]='1') then brojacjed:=brojacjed+1
			    else if (StringGrid1.Cells[brojac2,brojac1]='0') AND (pregledan=false) then
          begin
          brojacnul:=brojacnul+1;
          pregledan:=true;
          end;

      end;
      showmessage('Broj jedinica je : ' + Inttostr(brojacjed)+ ', a broj neocenjenih je '+inttostr(brojacnul));
      IzracunajProsek(StringGrid1);
  end;

procedure TForm2.asdClick(Sender: TObject);
	var brojacRow,brojacCol,brojac3 : integer;
      Poruka : string; //Ovde ce biti poruka u kojoj pisu svi neocenjeni ucenici
      pregledan : bool; // Broji ucenika samo jednom
	begin
  Neocenjeni.Clear; // U slucaju da lista nije prazna isprazni je
		for brojacRow:=1 to StringGrid1.RowCount do
      begin
      pregledan:=false;
		  for brojacCol:=1 to StringGrid1.ColCount do
			  if (StringGrid1.Cells[brojacCol,brojacRow]='0') AND (pregledan=false) then
          begin
            pregledan:=true;
            Neocenjeni.Add(IntToStr(BrojacRow));
          end;
      end;
		for brojac3:=1 to Neocenjeni.Count do Poruka:=Poruka+'Ucenik '+StringGrid1.Cells[0,StrToint(Neocenjeni.Strings[brojac3-1])];
  showmessage(Poruka);
	end;

procedure TForm2.Izracunajprosek1Click(Sender: TObject);
  begin
  IzracunajUspeh(StringGrid1);
  end;

procedure TForm2.Izracunajprosekodeljenja1Click(Sender: TObject);
var brojac : integer;
    uspeh : real;
begin
IzracunajUspeh(StringGrid1);
uspeh:=0;
for brojac:=1 to StringGrid1.RowCount-1 do uspeh:=uspeh+StrToFloat(StringGrid1.Cells[Predmeti.Items.IndexOf('Uspeh')+1,brojac]);
uspeh:=uspeh/(StringGrid1.RowCount-1-Neocenjeni.Count);
showmessage(FloatToStr(uspeh));
end;

procedure TForm2.IzracunajProsek2Click(Sender: TObject);
begin
IzracunajProsek(StringGrid1);
end;

end.
