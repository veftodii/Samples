{Sirul comprimat}
program SirComprimat;

uses crt, windos;

const
  InFile = 'sir.in';
  OutFile = 'sir.out';
  ContinueMsg = 'Tastati "ENTER" pentru a continua ...';
  Ord0 =  Ord('0');
  Ord9 =  Ord('9');

type
  TFile = text;
  TRawData = record
    DupeNumber: word;
    Value: char;
    StartPos, EndPos: byte;
  end;

var
  FInFile, FOutFile: TFile;
  FInLine: string[80];
  FSearchRec: TSearchRec;
  FRawData: TRawData;
  FLineNumber: longint;
  i, n, errorcode: integer;

function IsDigit(AChar: char): boolean;
var
  k: integer;
begin
  k := Ord(AChar);
  IsDigit := (Ord0 <= k) and (k <= Ord9);
end;

begin
  clrscr;
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

  Assign(FInFile, InFile);
  Assign(FOutFile, OutFile);
  reset(FInFile);
  rewrite(FOutFile);
  FLineNumber := 0;
  while not eof(FInFile) do
  begin
    readln(FInFile, FInLine);
    FLineNumber := FLineNumber + 1;
    if length(FInLine) > 80 then
    begin
      writeln('Lungimea maxima a liniilor in fisierul de intrare "', InFile, '" trebuie sa fie de 80 caractere !');
      writeln; write(ContinueMsg);
      close(FInFile);
      close(FOutFile);
      readln;
      halt;
    end;

    {prelucram linia si o extindem}
    n := length(FInLine);
    if n > 0 then
    begin
      FRawData.StartPos := 1;
      while FRawData.StartPos <= n do
      begin
        FRawData.DupeNumber := 0;
        FRawData.Value := #0;
        FRawData.EndPos := FRawData.StartPos;

        while (FRawData.EndPos <= n) and IsDigit(FInLine[FRawData.EndPos]) do
          FRawData.EndPos := FRawData.EndPos + 1;
        if FRawData.EndPos > n then
          FRawData.EndPos := FRawData.EndPos - 1;

        if not IsDigit(FInLine[FRawData.EndPos]) then
        begin
          FRawData.Value := FInLine[FRawData.EndPos];
          i := FRawData.EndPos - FRawData.StartPos;
          if i = 0 then
            FRawData.DupeNumber := 1
          else
            val(Copy(FInLine, FRawData.StartPos, i), FRawData.DupeNumber, errorcode);
        end;

        if (FRawData.Value = #0) or (FRawData.DupeNumber = 0) or (errorcode <> 0) then
        begin
          writeln('Fisierul de intrare "', InFile, '" contine date eronate pe linia ', FLineNumber, ' !');
          writeln; write(ContinueMsg);
          close(FInFile);
          close(FOutFile);
          readln;
          halt;
        end;

        for i := 1 to FRawData.DupeNumber do write(FOutFile, FRawData.Value);
        FRawData.StartPos := FRawData.EndPos + 1;
      end;
      writeln(FOutFile);
    end; {ENDIF [line processing]}
  end; {ENDWHILE [file processing]}

  close(FInFile);
  close(FOutFile);
  writeln('Au fost procesate ', FLineNumber,' linii din fisierul "', InFile, '".');
  writeln('Rezultatul cu sirurile desfasurate este in fisierul "', OutFile, '".');
  writeln; write(ContinueMsg);
  readln;
end.