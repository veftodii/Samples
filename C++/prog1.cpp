#include <iostream>
#include <iomanip>

using namespace std;

struct TPoint { // declaram o structura pentru a defini un punt in plan geometric
    int X, Y;  // membri publici 
};

class TRectangle {
    public:
        int Width, Height;   // membri publici: lungimea, latimea
        int Left, Top, Right, Bottom;  // pozitia virfurilor dreptunghiului
    public:
        // defimin 3 constructori diferiti prin "supraincarcarea constructorilor"
        TRectangle(TPoint TopLeft, int Width, int Height);  // diferiti constructori pentru a initializa membrii clasei
        TRectangle(TPoint TopLeft, TPoint BottomRight);
        TRectangle(int Left, int Top, int Right, int Bottom);
        inline double Aria() { return Width * Height; };  // specificam ca functia de calculare a ariei este inline, adica compilatorul stie de "comportamentul" acesteia din timp la compilare
        long int Perimetrul();  // declaram prototipul unei functii pentru a calcula perimetrul
};

// scriem corpul propriu-zis al constructorilor
// observam adresarea variabilelor clasei utilizind pointerul "this"
// astfel facem diferentiere intre membrii (variabilele) clasei si variabilele locale ale functiei
// (constructorul este si el un fel de functie, doar ca nu intoarce valoare si trebuie declarat ca "public")
TRectangle::TRectangle(TPoint TopLeft, int Width, int Height) {
    this->Width = Width;  // initializam variabilele clasei prin atribuire de valori
    this->Height = Height;
    Left = TopLeft.X;  // adresarea elementelor structurii se face prin operatorul "."
    Top = TopLeft.Y;
}

TRectangle::TRectangle(TPoint TopLeft, TPoint BottomRight) {
    Left = TopLeft.X;
    Top = TopLeft.Y;
    Right = BottomRight.X;
    Bottom = BottomRight.Y;
    Width = Right - Left;
    Height = Bottom - Top;
}

TRectangle::TRectangle(int Left, int Top, int Right, int Bottom) {
    this->Left = Left;
    this->Top = Top;
    this->Right = Right;
    this->Bottom = Bottom;
    Width = this->Right - this->Left;
    Height = this->Bottom - this->Top;
}

long int TRectangle::Perimetrul() {
    return 2 * Width + 2 * Height;   // reintoarcem rezultatul unei expresii
}

// functia main poate avea si paramatri pentru a citi parametrii introdusi de la linia de comanda la rularea aplicatiei
int main(int argc, char *argv[]) {
    TPoint Point1 = {5,2};  // declaram 2 variabile de tip TPoint si le initializam cu valori "inline"
    TPoint Point2 = {12,7};
    TRectangle Rect1(5,10,20,30), Rect2(Point1, Point2);  // cream 2 instante (obiecte) de tip TRectangle; observam modul de apelare a diferitor constructori declarati anterior
    // afisam la iesire valorile membrilor celor 2 obiecte create: variabile, apeluri de functii pentru a efectua calculele necesare
    cout << "Coordonate Dreptunghi 1: " << "(" << Rect1.Left << "," << Rect1.Top << ") , (" << Rect1.Right << "," << Rect1.Bottom << ")" << endl;
    cout << "Arie Dreptunghi 1: " << Rect1.Aria() << endl;
    cout << "Perimetrul Dreptunghi 1: " << Rect1.Perimetrul() << endl;
    cout << "\n\nCoordonate Dreptunghi 2: " << "(" << Rect2.Left << "," << Rect2.Top << ") , (" << Rect2.Right << "," << Rect2.Bottom << ")" << endl;
    cout << "Arie Dreptunghi 2: " << Rect2.Aria() << endl;
    cout << "Perimetrul Dreptunghi 2: " << Rect2.Perimetrul() << endl;
    return EXIT_SUCCESS;  // functia main trebuie sa intoarca un rezultat, in cazul dat codul 0 (zero)
}
