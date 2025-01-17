{Puterea}
{$N+}
program Puterea;

uses crt, windos;

const
  InFile = 'date.in';
  OutFile = 'date.out';
  ContinueMsg = 'Tastati "ENTER" pentru a continua ...';

type
  TFile = text;

var
  N: longint;
  A: real;

function Power(AValue: real; AExp: integer): extended;
var
  Result: extended;
  k, FExp: integer;
begin
  if (AValue = 0) and (AExp = 0) then
  begin
    {NaN - Not a number}
    writeln('Function Power(0, 0) call returned an NaN value !');
    writeln; write(ContinueMsg);
    readln;
    halt(0);
  end
  else if AExp = 0 then Result := 1
  else
  begin
    FExp := abs(AExp);
    Result := 1;
    for k := 1 to FExp do
      Result := Result * AValue;
    if AExp < 0 then Result := 1.0 / Result;
  end;
  Power := Result;
end;

function ReadDataFromFile: longint;
var
  FNumber: longint;
  FFile: TFile;
  FSearchRec: TSearchRec;
begin
  FindFirst(InFile, faArchive, FSearchRec);
  if DosError = 18 then
  begin
    writeln('Fisierul de intrare "', InFile, '" nu a fost gasit !');
    writeln; write(ContinueMsg);
    readln;
    halt;
  end
  else if DosError <> 0 then
  begin
    write('A aparut o eroare !');
    writeln; write(ContinueMsg);
    readln;
    halt;
  end;

  Assign(FFile, InFile);
  reset(FFile);
  readln(FFile, FNumber);
  if (FNumber < 1) or (FNumber > power(10,9)) then
  begin
    writeln(InFile, ': ', FNumber);
    writeln('Numarul natural din fisierul de intrare "', InFile, '" trebuie sa apartina intervalului [1, 10^9] !');
    writeln; write(ContinueMsg);
    readln;
    halt;
  end;
  close(FFile);
  writeln('Datele de intrare s-au citit cu succes din fisierul "', InFile, '".');
  ReadDataFromFile := FNumber;
end;

procedure SaveDataToFile(AValue: longint);
var
  FFile: TFile;
begin
  Assign(FFile, OutFile);
  rewrite(FFile);
  write(FFile, AValue);
  close(FFile);
  writeln; writeln('Datele de iesire s-au salvat cu succes in fisierul "', OutFile, '".');
end;

begin
  clrscr;
  A := ReadDataFromFile;
  N := 1;
  while N <= A do
  begin
    if Frac(power(N, N) / A) = 0 then break;
    N := N + 1;
  end;
  SaveDataToFile(N);
  writeln; writeln;
  writeln('A = ', A:0:0);
  writeln('N = ', N);
  writeln; write(ContinueMsg);
  readln;
end.