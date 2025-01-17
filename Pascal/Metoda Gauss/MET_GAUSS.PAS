{$N+}
program Gauss;

uses crt;

var
  A, A1: array[1..20, 1..20] of real;
  B, B1, X: array[1..20] of real;
  u: double;
  i, j, k, n: integer;

procedure ShowSolutie;
var
  i1, j1: integer;
begin
  clrscr;
  writeln('Sistemul de ecuatii initial este:');
  for i1 := 1 to n do
  begin
    for j1 := 1 to n do
      if j1 = 1 then write(A[i1,j1]:0:2, '*X', j1, ' ')
      else if A[i1,j1] >= 0 then write('+ ', A[i1,j1]:0:2, '*X', j1, ' ')
      else write('- ', abs(A[i1,j1]):0:2, '*X', j1, ' ');
    writeln('= ', B[i1]:0:2);
  end;
  writeln;
  writeln('Vectorul solutie X este:');
  write('X = [');
  for i1 := 1 to n do
    if i1 = n then write(X[i1]:0:2, ']')
    else write(X[i1]:0:2, ', ');
end;

procedure ShowPivot;
var
  i1, j1: integer;
begin
  writeln; writeln('Matricea pivot este:');
  for i1 := 1 to n do
  begin
    for j1 := 1 to n do
      if j1 = 1 then write(A1[i1,j1]:0:2, '*X', j1, ' ')
      else if A1[i1,j1] >= 0 then write('+ ', A1[i1,j1]:0:2, '*X', j1, ' ')
      else write('- ', abs(A1[i1,j1]):0:2, '*X', j1, ' ');
    writeln('= ', B1[i1]:0:2);
  end;
end;

begin
  clrscr;
  writeln('Sistemul de ecuatii este de forma:  A * X = B, unde A, X, B sunt matrici');
  writeln;
  write('Introduceti numarul de ecuatii (necunoscute): '); readln(n);
  if n <= 0 then
  begin
    writeln;
    writeln('"n" trebuie sa fie mai mare ca zero !');
    readln;
    exit;
  end;
  writeln('Introduceti coeficientii necunoscutelor (matricea A):');
  for i := 1 to n do
    for j := 1 to n do
    begin
      write('A[', i, ', ', j, '] = '); readln(A[i,j]);
    end;
  writeln;
  writeln('Introduceti termenii liberi (vectorul-coloana B):');
  for i := 1 to n do
  begin
    write('B[', i, '] = '); readln(B[i]);
  end;
  { efectuam o copie a matricelor initiale }
  for i := 1 to n do X[i] := 0;
  for i := 1 to n do
    for j := 1 to n do A1[i,j] := A[i,j];
  for i := 1 to n do B1[i] := B[i];

  { se efectueaza zero sub diagonala principala }
  clrscr;
  if n > 1 then
    for i := 1 to n - 1 do
    begin
      { se efectueaza pivotarea partiala a matricii }
      if A1[i,i] = 0 then
      begin
        for j := i + 1 to n do
          if j = i + 1 then
          begin
            u := abs(A1[j,i]);
            k := j;
          end
          else if u < A1[j,i] then
          begin
            u := A1[j,i];
            k := j;
          end;
        if u <> 0 then
        begin
          { schimbam cu locul liniile (ecuatiile) i cu m }
          for j := 1 to n do
          begin
            u := A1[i,j];
            A1[i,j] := A1[k,j];
            A1[k,j] := u;
          end;
        end
        else
        begin
          ShowSolutie;
          writeln;
          writeln('Posibil nu se poate face zero sub diagonala principala !');
          readln;
          exit;
        end;
      end;

      { calculam coeficentii matricii intermediare }
      for j := i + 1 to n do
      begin
        u := A1[j,i] / A1[i,i];
        A1[j,i] := 0;
        for k := i + 1 to n do
          A1[j,k] := A1[j,k] - u * A1[i,k];
        B1[j] := B1[j] - B1[i] * u;
      end;
      { daca nu se doreste afisarea matricelor pivot obtinute se pot comenta urmatoarele 2 linii }
      ShowPivot;
      readln;
    end;

  if A1[n,n] <> 0 then
  begin
    { calculam vectorul solutie X }
    for i := n downto 1 do
    begin
      u := 0;
      for j := i + 1 to n do u := u + A1[i,j]*X[j];
      X[i] := (B1[i] - u) / A1[i,i];
    end;
  end;

  ShowSolutie;
  readln;
end.