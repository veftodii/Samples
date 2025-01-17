{ Programul la practica instructiva }
Program Parc;

uses crt;

const
  MinRows = 3;
  MaxRows = 250;
  InFile = 'Parc.in';
  OutFile = 'Parc.out';
  ContinueMsg = 'Tastati "ENTER" pentru a continua ...';

type
  Binar = 0..1;
  Matrice = array[1..MaxRows, 1..MaxRows] of Binar;
  Vector = array[1..MaxRows] of Binar;
  TFile = text;

var
  M: Matrice;
  mRows: integer;
  mOption: integer;

function VerificaMatrice: integer;
begin
  if mRows = 0 then
  begin
    writeln; writeln('Introduceti mai intii matricea in fisier sau de la tastatura !');
    readln;
    VerificaMatrice := -1;
  end
  else
  VerificaMatrice := 0;
end;

procedure ShowMatrice;
var i, j: integer;
begin
  writeln('Elementele matricii sunt:');
  if VerificaMatrice < 0 then exit;
  for i := 1 to mRows do
  begin
    for j := 1 to mRows do
      write(M[i, j],' ');
    writeln;
  end;
end;

procedure SaveDataToFile;
var
  f: TFile;
  i, j: integer;
begin
  Assign(f, InFile);
  rewrite(f);
  writeln(f, mRows);
  for i := 1 to mRows do
  begin
    for j := 1 to mRows do
      if j = mRows then write(f, M[i, j])
      else write(f, M[i, j], ' ');
    if i < mRows then writeln(f);
  end;
  close(f);
  writeln; writeln('Datele de intrare s-au salvat cu succes in fisierul "', InFile, '".');
end;

procedure InputData;
var
  i, j, n: integer;
begin
  clrscr;
  write('Introduceti dimensiunea matricii (n x n): '); readln(n);
  if (n < MinRows) or (n > MaxRows) then
  begin
    writeln; writeln('Dimensiunea permisa este ', MinRows, ' <= n <= ', MaxRows, ' !');
    writeln; write(ContinueMsg);
    readln;
    exit;
  end;
  writeln('Introduceti elementele  matricii:');
  for i := 1 to n do
  begin
    for j := 1 to n do
      read(M[i, j]);
  end;
  mRows := n;
  SaveDataToFile;
  writeln; write(ContinueMsg);
  readln;
end;


function IntputDataFromFile: integer;
var
  i, j: integer;
  f: TFile;
begin
  clrscr;
  Assign(f, InFile);
  if not fileexists(InFile) then
  begin
   write('Fisierul de intrare "', InFile, '" nu a fost gasit !');
   IntputDataFromFile := -1; // an error occurred
   readln;
   exit;
  end;
  reset(f);
  readln(f, mRows);
  if (mRows < MinRows) or (mRows > MaxRows) then
  begin
     writeln('Dimensiunea permisa este ', MinRows, ' <= n <= ', MaxRows, ' !');
     IntputDataFromFile := -1; // an error ocurred
     readln;
     exit;
  end;
   for i := 1 to mRows do
   begin
    for j := 1 to mRows do
      read(f, M[i, j]);
   end;
   close(f);
   writeln('Datele de intrare s-au citit cu succes din fisier.');
   IntputDataFromFile :=0; // no error
end;

procedure ExtindeMatrice;
var
  l, c, i, j: integer;
  v, v2: Vector;
  r: integer;
begin
  clrscr;
  if VerificaMatrice < 0 then exit;
  writeln('Tastati 1 pentru a introduce o line deasupra (nord)');
  writeln('Tastati 2 pentru a introduce o line dedesupt (sud)');
  writeln; write('>> '); readln(l);
  if (l<>1) and (l<>2) then
  begin
    writeln; writeln('Ati introdus o valoare gresita');
    writeln; write(ContinueMsg);
    readln;
    exit;
  end;

  writeln;
  writeln('Tastati 1 pentru a introduce o coloana in stinga (vest)');
  writeln('Tastati 2 pentru a introduce o coloana (dreapta)');
  writeln; write('>> '); readln(c);
  if (c<>1) and (c<>2) then
  begin
    writeln; writeln('Ati introdus o valoare gresita');
    writeln; write(ContinueMsg);
    readln;
    exit;
  end;

  r := mrows+1;
  writeln;
  writeln('Introduceti valorile pentru linie (', r, ' elemente) :');
  for  i := 1 to r do  //numarul actual de rinduri +1
    read(v[i]);
     
  writeln('Introduceti valorile pentru coloana (', r, ' elemente) :');
  for i := 1 to r do
    read(v2[i]);
   
  if l = 1 then  // linie deaspra
  begin
    for i := mRows downto 1 do
      for j:= 1 to mRows do
        M[i+1,j] := M[i,j]; // mutam fiecare linie cu una mai jos

    for i:=1 to r do
      M[1,i] := v[i];
  end
  else
  begin
    for i:=1 to r do
      M[r,i] := v[i];  // adaugam linia la sfirsitul matricei
  end;

  if c = 1 then  // colana in stinga
  begin
    for j := mRows downto 1 do
      for i:= 1 to mRows do
        M[i,j+1] := M[i,j]; // mutam fiecare coloana in dreapta

    for i:=1 to r do
      M[i,1] := v2[i];
  end
  else
  begin
    for i:=1 to r do
      M[i,r] := v2[i];  // adaugam linia la sfirsitul matricei
  end;

  mRows := r;  // actualizam dimensiunea noua a matricii
  SaveDataToFile;
  writeln; write(ContinueMsg);
  readln;
end;

procedure ArieGroapa;
var
  i, j, k: integer;
begin
  clrscr;
  if VerificaMatrice < 0 then exit;
  k := 0;
  for i := 1 to mRows do
    for j := 1 to mRows do
      if M[i,j] = 1 then inc(k);  // k := k + 1;
  writeln('Aria gropii este: ', k);
  writeln; write(ContinueMsg);
  readln;
end;

procedure PosOfUnitHavingMinRoxIndex;
var
  i, j, row, col: integer;
label L1;
begin
  clrscr;
  if VerificaMatrice < 0 then exit;
  row := 0; col := 0;
  for i := 1 to mRows do
    for j := 1 to mRows do
      if M[i,j] = 1 then
      begin
        row := i;
        col := j;
        goto L1;
      end;

  L1:
  if row = 0 then
  begin
    writeln('Matricea nu contine unitati !');
  end
  else
  begin
    writeln('Pozitia unei unitatii a matricii cu indicele cel mai mic al liniei este: (', row, ', ', col, ')');
  end;
  writeln; writeln(ContinueMsg);
  readln;
end;

procedure TransformaZonaGroapa;
var
  row, col: integer;
begin
  clrscr;
  if VerificaMatrice < 0 then exit;
  writeln('Transformarea unei zone a gropii in zona accesibila'); writeln;
  write('Introduceti indicele liniei: '); readln(row);
  if (row < 1) or (row > mRows) then
  begin
    writeln('Indicele trebuie sa fie in intervalul 1 <= n <= ', mRows);
    writeln; writeln(ContinueMsg);
    readln;
    exit;
  end;
  write('Introduceti indicele coloanei: '); readln(col);
  if (col < 1) or (col > mRows) then
  begin
    writeln('Indicele trebuie sa fie in intervalul 1 <= n <= ', mRows);
    writeln; writeln(ContinueMsg);
    readln;
    exit;
  end;

  M[row, col] := 0;
  SaveDataToFile;
  writeln; writeln(ContinueMsg);
  readln;
end;

procedure IndiceColIntersectGroapa;
var
  i, j, contor, aux, tmp: integer;
  v: array[1..2, 1..MaxRows] of integer;
begin
  clrscr;
  if VerificaMatrice < 0 then exit;
  tmp := 0;
  for j := 1 to mRows do
  begin
    contor := 0;
    for i := 1 to mRows do
      if M[i,j] = 1 then
        inc(contor);
    if contor > 0 then
    begin
      inc(tmp);
      v[1, tmp] := j;
      v[2, tmp] := contor;
    end;
  end;

  // sortam vectorul cu indicele coloanelor si nr de unitati ale fiecarei coloane
  for i := 1 to tmp-1 do
    for j := i+1 to tmp do
      if v[2,i] > v[2,j] then
      begin
        aux:=v[2,i];
        v[2,i]:=v[2,j];
        v[2,j]:=aux;
       
        aux:=v[1,i];
        v[1,i]:=v[1,j];
        v[1,j]:=aux;
      end;
     
  if tmp = 0 then
  begin
    writeln('Matricea nu contine unitati !');
  end
  else
  begin
    writeln('Indicii coloanelor ce intersecteaza groapa, in ordine ascendenta a numarului de unitati sunt:');
    for i:=1 to tmp do write(v[1,i], ' ');
    writeln; writeln;
    writeln('Numarul de unitati a coloanelor este:');

    for i:=1 to tmp do write(v[2,i], ' ');
  end;
  writeln; writeln; write(ContinueMsg);
  readln;
end;

procedure FisierGroapaTxt;
var
  g: TFile;
  i, j, nrline: integer;
  f: TFile;
  s: string;
begin
  clrscr;
  if VerificaMatrice < 0 then exit;
  Assign(f, InFile);
  reset(f);
  assign(g, 'Groapa.txt');
  rewrite(g);
  for i := 1 to mRows do
    for j := 1 to mRows do
    begin
      if m[i,j] = 1 then
      begin
        nrline:=0;
        reset(f);
        while not eof(f) do
        begin
          readln(f,s);
          inc(nrline);
          if nrline - 1 = i then
          begin
            writeln(g,s);
            break;
          end;
        end;
        break;
      end;
    end;

  writeln('Liniile ce contin zone din cadrul gropii au fost copiate cu succes in fisierul "Groapa.txt".');
  writeln('Continutul fisierului "Groapa.txt" este:');
  close(g);
  reset(g);
  while not eof(g) do
  begin
    readln(g,s);
    writeln(s);
  end;
  writeln; writeln(ContinueMsg);
  readln;
  close(f);
  close(g);
end;

procedure SubMatriceNrMinElemente;
var
   i, j: integer;
   x1, y1, x2, y2: integer;
Label L1, L2, L3, L4;
begin
  clrscr;
  if VerificaMatrice < 0 then exit;
  // trebuie sa gasim colturile (x1, y1) din stinga-sus si (x2, y2) din dreapta de jos
  // in care se include submatricea ce contine in intregime groapa
  x1 := 0; y1 := 0;
  x2 := 0; y2 := 0;
  // cautam indicele liniei de sus
  for i := 1 to mRows do
    for j := 1 to mRows do
      if M[i, j] = 1 then
      begin
        x1 := i;
        goto L1;
      end;
  if x1 = 0 then
  begin
    writeln('Matricea nu contine unitati !');
    writeln; write(ContinueMsg);
    readln;
    exit;
  end;
L1:
  // cautam indicele liniei de jos
  for i := mRows downto x1 do
    for j := 1 to mRows do
      if M[i, j] = 1 then
      begin
        x2 := i;
        goto L2;
      end;
L2:
  // cautam indicele coloanei din stinga
  for j := 1 to mRows do
    for i := x1 to x2 do
      if M[i, j] = 1 then
      begin
        y1 := j;
        goto L3;
      end;
L3:
  // cautam indicele coloanei din dreapta
  for j := mRows downto y1 do
    for i := x1 to x2 do
      if M[i, j] = 1 then
      begin
        y2 := j;
        goto L4;
      end;
L4:
  // afisam submatricea
  writeln('Numarul de elemente a submatricii este: ', (x2 - x1 + 1) * (y2 - y1 + 1));
  writeln; writeln('Submatricea este:');
  for i := x1 to x2 do
  begin
    for j := y1 to y2 do write(M[i, j], ' ');
    writeln;
  end;
  writeln; write(ContinueMsg);
  readln;
end;


procedure  DeterminaCelMaiScurtDrum;
{ Directia miscarilor D1 .. D8 ca pe figura 2 din conditia problemei}
type TArray = array[1..2, 1..500] of integer;

  function DrumPrinStinga(var V: TArray): integer;
  var
    i1, j1, misc: integer;
    Mx: Matrice;
  begin
    // make a copy of original matrix
    for i1 := 1 to mRows do
      for j1 := 1 to mRows do
        Mx[i1, j1] := M[i1, j1];

    // [i1, j1] - current position
    // (V[1, misc], V[2, misc])  - previous position
    i1 := 1; j1 := 1;
    V[1,1] := 1; V[2,1] := 1; // save start possition
    misc := 0;  // numarul de miscari efectuate

    repeat
      if (i1 < mRows) and (j1 < mRows) and (Mx[i1 + 1, j1 + 1] = 0) {D4} then
      begin
        inc(i1); inc(j1);
        // daca ne-am intors pe pozitia precedenta, marcam drumul ca inaccesibil si cautam alta cale
        if (misc > 0) and (i1 = V[1, misc]) and (j1 = V[2, misc]) then
        begin
          dec(misc);
          Mx[i1 - 1, j1 - 1] := 1;
        end
        else
        begin
          inc(misc);
          V[1, misc + 1] := i1;
          V[2, misc + 1] := j1;
        end;
      end
      else if (j1 < mRows) and (Mx[i1, j1 + 1] = 0) {D3} then
      begin
        inc(j1);
        // daca ne-am intors pe pozitia precedenta, marcam drumul ca inaccesibil si cautam alta cale
        if (misc > 0) and (i1 = V[1, misc]) and (j1 = V[2, misc]) then
        begin
          dec(misc);
          Mx[i1, j1 - 1] := 1;
        end
        else
        begin
          inc(misc);
          V[1, misc + 1] := i1;
          V[2, misc + 1] := j1;
        end;
      end
      else if (i1 < mRows) and (j1 = mRows) and (Mx[i1 + 1, j1] = 0) {D5 pe marginea dreapta} then
      begin
        inc(i1);
        // daca ne-am intors pe pozitia precedenta, marcam drumul ca inaccesibil si cautam alta cale
        if (misc > 0) and (i1 = V[1, misc]) and (j1 = V[2, misc]) then
        begin
          dec(misc);
          Mx[i1 - 1, j1] := 1;
        end
        else
        begin
          inc(misc);
          V[1, misc + 1] := i1;
          V[2, misc + 1] := j1;
        end;
      end
      else if (i1 > 1) and (j1 < mRows) and (Mx[i1 - 1, j1 + 1] = 0) {D2} then
      begin
        dec(i1); inc(j1);
        // daca ne-am intors pe pozitia precedenta, marcam drumul ca inaccesibil si cautam alta cale
        if (misc > 0) and (i1 = V[1, misc]) and (j1 = V[2, misc]) then
        begin
          dec(misc);
          Mx[i1 + 1, j1 - 1] := 1;
        end
        else
        begin
          inc(misc);
          V[1, misc + 1] := i1;
          V[2, misc + 1] := j1;
        end;
      end
      else if (i1 > 1) and (Mx[i1 - 1, j1] = 0) {D1} then
      begin
        dec(i1);
        // daca ne-am intors pe pozitia precedenta, marcam drumul ca inaccesibil si cautam alta cale
        if (misc > 0) and (i1 = V[1, misc]) and (j1 = V[2, misc]) then
        begin
          dec(misc);
          Mx[i1 + 1, j1] := 1;
        end
        else
        begin
          inc(misc);
          V[1, misc + 1] := i1;
          V[2, misc + 1] := j1;
        end;
      end
      else if (i1 > 1) and (j1 > 1) and (Mx[i1 - 1, j1 - 1] = 0) {D8} then
      begin
        dec(i1); dec(j1);
        // daca ne-am intors pe pozitia precedenta, marcam drumul ca inaccesibil si cautam alta cale
        if (misc > 0) and (i1 = V[1, misc]) and (j1 = V[2, misc]) then
        begin
          dec(misc);
          Mx[i1 + 1, j1 + 1] := 1;
        end
        else
        begin
          inc(misc);
          V[1, misc + 1] := i1;
          V[2, misc + 1] := j1;
        end;
      end
      else // nu exista miscari
      begin
        i1 := 0; j1 := 0;
      end;
    until ((i1 = 0) or (i1 = mRows)) and ((j1 = 0) or (j1 = mRows));
    if (i1 = 0) and (j1 = 0) then DrumPrinStinga := 0
    else DrumPrinStinga := misc;
  end;

  function DrumPrinDreapta(var V: TArray): integer;
  var
    i1, j1, misc: integer;
    Mx: Matrice;
  begin
    // make a copy of original matrix
    for i1 := 1 to mRows do
      for j1 := 1 to mRows do
        Mx[i1, j1] := M[i1, j1];

    // [i1, j1] - current position
    // (V[1, misc], V[2, misc])  - previous position
    i1 := 1; j1 := 1;
    V[1,1] := 1; V[2,1] := 1; // save start possition
    misc := 0;  // numarul de miscari efectuate

    repeat
      if (i1 < mRows) and (j1 < mRows) and (M[i1 + 1, j1 + 1] = 0) {D4} then
      begin
        inc(i1); inc(j1);
        // daca ne-am intors pe pozitia precedenta, marcam drumul ca inaccesibil si cautam alta cale
        if (misc > 0) and (i1 = V[1, misc]) and (j1 = V[2, misc]) then
        begin
          dec(misc);
          Mx[i1 - 1, j1 - 1] := 1;
        end
        else
        begin
          inc(misc);
          V[1, misc + 1] := i1;
          V[2, misc + 1] := j1;
        end;
      end
      else if (i1 < mRows) and (M[i1 + 1, j1] = 0) {D5} then
      begin
        inc(i1);
        // daca ne-am intors pe pozitia precedenta, marcam drumul ca inaccesibil si cautam alta cale
        if (misc > 0) and (i1 = V[1, misc]) and (j1 = V[2, misc]) then
        begin
          dec(misc);
          Mx[i1 - 1, j1] := 1;
        end
        else
        begin
          inc(misc);
          V[1, misc + 1] := i1;
          V[2, misc + 1] := j1;
        end;
      end
      else if (i1 < mRows) and (j1 > 1) and (M[i1 + 1 , j1 - 1] = 0) {D6} then
      begin
        inc(i1); dec(j1);
        // daca ne-am intors pe pozitia precedenta, marcam drumul ca inaccesibil si cautam alta cale
        if (misc > 0) and (i1 = V[1, misc]) and (j1 = V[2, misc]) then
        begin
          dec(misc);
          Mx[i1 - 1, j1 + 1] := 1;
        end
        else
        begin
          inc(misc);
          V[1, misc + 1] := i1;
          V[2, misc + 1] := j1;
        end;
      end
      else if (i1 = mRows) and (j1 < mRows) and (M[i1, j1 + 1] = 0) {D3 pe mardinea de jos} then
      begin
        inc(j1);
        // daca ne-am intors pe pozitia precedenta, marcam drumul ca inaccesibil si cautam alta cale
        if (misc > 0) and (i1 = V[1, misc]) and (j1 = V[2, misc]) then
        begin
          dec(misc);
          Mx[i1, j1 - 1] := 1;
        end
        else
        begin
          inc(misc);
          V[1, misc + 1] := i1;
          V[2, misc + 1] := j1;
        end;
      end
      else if (j1 > 1) and (M[i1, j1 - 1] = 0) {D7} then
      begin
        dec(j1);
        // daca ne-am intors pe pozitia precedenta, marcam drumul ca inaccesibil si cautam alta cale
        if (misc > 0) and (i1 = V[1, misc]) and (j1 = V[2, misc]) then
        begin
          dec(misc);
          Mx[i1, j1 + 1] := 1;
        end
        else
        begin
          inc(misc);
          V[1, misc + 1] := i1;
          V[2, misc + 1] := j1;
        end;
      end
      else if (i1 > 1) and (j1 > 1) and (M[i1 - 1, j1 - 1] = 0) {D8} then
      begin
        dec(i1); dec(j1);
        // daca ne-am intors pe pozitia precedenta, marcam drumul ca inaccesibil si cautam alta cale
        if (misc > 0) and (i1 = V[1, misc]) and (j1 = V[2, misc]) then
        begin
          dec(misc);
          Mx[i1 + 1, j1 + 1] := 1;
        end
        else
        begin
          inc(misc);
          V[1, misc + 1] := i1;
          V[2, misc + 1] := j1;
        end;
      end
      else // nu exista miscari
      begin
        i1 := 0; j1 := 0;
      end;
    until ((i1 = 0) or (i1 = mRows)) and ((j1 = 0) or (j1 = mRows));
    if (i1 = 0) and (j1 = 0) then DrumPrinDreapta := 0
    else DrumPrinDreapta := misc;
  end;


var
  V: TArray;
  nmisc_st, nmisc_dr: integer;
  j: integer;
  f: TFile;
begin
  clrscr;
  if VerificaMatrice < 0 then exit;
  nmisc_st := 0; nmisc_dr := 0;
  
  // determinarea drumului prin stinga gropii
  nmisc_st := DrumPrinStinga(V);
  if nmisc_st = 0 then writeln('Nu sunt miscari disponibile prin stinga gropii !')
  else
  begin
    writeln('Numarul de miscari pentru ocolirea gropii prin stinga este: ', nmisc_st);
    writeln('Miscarea prin stinga gropii este disponobila prin urmatoarele pozitii:');
    for j := 1 to nmisc_st + 1 do
      if j = nmisc_st + 1 then write('|',V[1, j],',',V[2,j],'|')
      else write('|',V[1, j],',',V[2,j],'|-');
  end;

  // determinarea drumului prin dreapta gropii
  nmisc_dr := DrumPrinDreapta(V);
  writeln; writeln;
  if nmisc_dr = 0 then writeln('Nu sunt miscari disponibile prin dreapta gropii !')
  else
  begin
    writeln('Numarul de miscari pentru ocolirea gropii prin drepata este: ', nmisc_dr);
    writeln('Miscarea prin dreapta gropii este disponobila prin urmatoarele pozitii:');
    for j := 1 to nmisc_dr + 1 do
      if j = nmisc_dr + 1 then write('|',V[1, j],',',V[2,j],'|')
      else write('|',V[1, j],',',V[2,j],'|-');
  end;
  
  assign(f, OutFile);
  rewrite(f);
  write(f, nmisc_st, ' ', nmisc_dr);
  close(f);
  writeln; writeln; writeln('Datele de iesire s-au salvat cu succes in fisierul "', OutFile, '".');
  writeln; writeln; write(ContinueMsg);
  readln;
end;

procedure ShowMeniu;
begin
  clrscr;
  writeln('===============================================================================');
  writeln('                          ========  MENIU  ========               ');
  writeln('===============================================================================');
  writeln; writeln;
  writeln('   1. Extinde matricea.');
  writeln('   2. Transforma o zona a gropii in zona accesibila.');
  writeln('   3. Pozitia unei unitatii din matrice, cu cel mai mic indice al liniei.');
  writeln('   4. Aria gropii.');
  writeln('   5. Afiseaza indicii coloanelor ce intersecteaza groapa.');
  writeln('   6. Copiaza liniile din cadrul gropii in fisierul "Groapa.txt".');
  writeln('   7. Gaseste in matricea A o submatrice cu numarul minimal de elemente.');
  writeln('   8. Determinarea celui mai scurt drum.');
  writeln('   9. Introduce matricea de intrare (salvare in fisier).');
  writeln('  10. Afiseaza matricea.');

end;

//===============================================
//             PROGRAM  PRINCIPAL
//===============================================
begin
  mRows := 0;
  if IntputDataFromFile = 0 then
  begin
    writeln; writeln;
    ShowMatrice;
    writeln; write(ContinueMsg);
    readln;
  end
  else mRows := 0;

  repeat
    ShowMeniu;
    writeln; writeln;
    write('Selectati optiunea: '); readln(mOption);
    case mOption of
      1: ExtindeMatrice;
      2: TransformaZonaGroapa;
      3: PosOfUnitHavingMinRoxIndex;
      4: ArieGroapa;
      5: IndiceColIntersectGroapa;
      6: FisierGroapaTxt;
      7: SubMatriceNrMinElemente;
      8: DeterminaCelMaiScurtDrum;
      9: InputData;
     10: begin
           clrscr;
           ShowMatrice;
           writeln; write(ContinueMsg);
           readln;
         end;
      0: begin
           writeln; write('Programul sa finisat ...');
         end;
      else
      begin
        writeln; writeln('Optiune incorecta !');
        readln;
      end;
    end;
  until mOption = 0;
  readln;
end.