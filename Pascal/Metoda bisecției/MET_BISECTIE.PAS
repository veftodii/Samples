{$N+}
program Bisectie;

uses crt;

var
  a, b, eps: double;
  k, n: integer;
  c, y1, y2: double;

{ functia de calcul }
function f(x: double): double;
begin
  F := x*x - 5*x + 4;
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
  write('Introduceti numarul de iteratii maxim: '); readln(n);
  writeln;

  k := 0;
  y1 := f(a);
  if y1 = 0 then
  begin
    ShowResult(a);
    readln;
    exit;
  end;

  y2 := f(b);
  if y2 = 0 then
  begin
    ShowResult(b);
    readln;
    exit;
  end;

  y1 := y1*y2;
  if y1 >= 0 then
  begin
    writeln('y = f(', a:0:2,')*f(', b:0:2,') = ', y1:0:6);
    writeln('Ecuatia nu are solutii reale pentru y >= 0 !');
    readln;
    exit;
  end;

  while true do
  begin
    if sign(a) = sign(b) then
      c := a + (b - a) / 2.0
    else
      c := (a + b) / 2.0;
    inc(k);
    y1 := f(c);
    if (y1 = 0) or (abs(b - a) < 2*eps) then
    begin
      ShowResult(c);
      break;
    end;
    if sign(f(a)) = sign(y1) then a := c
    else b := c;
  end;


  readln;
end.