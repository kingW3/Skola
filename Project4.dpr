program Project4;

uses
  Forms,
  Unit4 in 'Unit4.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
