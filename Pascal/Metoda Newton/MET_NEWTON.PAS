{$N+}
program Newton;

uses crt;

var
  a, b, eps: double;
  k, n: integer;
  x, x0: double;

{ functia de calcul }
function f(x: double): double;
begin
  f := x*x - 5*x + 4;
end;

function df(x: double): double;
begin
  df := 2*x - 5;
end;

function df2(x: double): double;
begin
  df2 := 2;
end;

function sign(x: double): integer;
begin
  if x < 0 then sign := -1
  else if x = 0 then sign := 0
  else sign := 1;
end;

procedure ShowResult(x: double);
begin
  writeln('Numarul de iteratii efectuat:  k = ', k);
  writeln('Radacina se afla in intervalul:  [', a:0:4, ', ', b:0:4, ']');
  writeln('Radacina ecuatiei:  x = ', x);
  writeln('Valoarea functiei:  f(', x:0:4, ') = ', f(x));
end;

begin
  clrscr;
  writeln('Functia este:  f(x) = x*x - 5*x + 4'); writeln;
  writeln('Introduceti intervalul de cautare a radacinilor [a, b]:');
  write('a = '); readln(a);
  write('b = '); readln(b);
  write('Introduceti valoarea erorii maxim admisibile eps: '); readln(eps);
  write('Introduceti numarul maxim de iteratii: '); readln(n);
  writeln;

  k := 0;
  if f(a) = 0 then
  begin
    ShowResult(a);
    readln;
    exit;
  end;

  if f(b) = 0 then
  begin
    ShowResult(b);
    readln;
    exit;
  end;

  if not ((sign(df(a)) = sign(df(b))) and (sign(df2(a)) = sign(df2(b)))) then
  begin
    writeln('Ecuatia nu are solutii reale in acest interval !');
    readln;
    exit;
  end;

  if sign(f(a)) = sign(df2(a)) then x0 := a
  else x0 := b;
  x := x0;

  while true do
  begin
    x0 := x;
    x := x0 - f(x0)/df(x0);
    inc(k);
    if abs(x - x0) < eps then break;
  end;

  ShowResult(x);
  readln;
end.