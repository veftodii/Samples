#include <cstdlib>
#include <iostream>
#include <iomanip>

using namespace std;
/* Clasa permite efectuarea operatiilor [adunare, scadere, inmultire] asupra matricileor  */
class Matrix
{
	private:
		int rows, cols;  // Dimensiunile matricii
		int **values;  // valorile insusi a matricii (pointer catre un pointer la tipul int)
		void CreateMatrix(int Rows, int Cols);  // alocarea dinamica a spatiului de memorie necesar
	public:
        string Name;  // pentru diferentierea mai uroara a instantelor de obiecte la depanarea programului
		Matrix(): rows(2), cols(2) {   // definirea unui constructor implicit ce seteaza dimensiunile initiale de [2 x 2]
            CreateMatrix(2, 2);
        }
        Matrix(int Rows, int Cols);  // constructor pentru definire matricei cu dimensiunile [m x n] 
		~Matrix();  // definirea destructorului clasei pentru eliberea memorie dinamice alocate de membrii acesteia in memoria HEAP
        void ReadValues();  // introducerea(citirea) datelor matricii de la intreare
        // urmatoarele 3 functii sunt "functii constante" si vor fi apelate ulterior doar de "obiecte constante"
        int GetRowsCount() const { return rows; };  // reintoarce numarul de rinduri a matricii
        int GetColsCount() const { return cols; };  // reintoarce numarul de coloane a matricii
        int GetItem(int Row, int Col) const { return values[Row][Col]; };  // intoarce elementul de pe pozitia (m,n) din matrice
        void SetItem(int Row, int Col, int Value) { values[Row][Col] = Value; };  // modifica elementul de pe pozitia (m,n) din matrice
        // supraincarcarea operatorilor aritmerici pentru a opera cu matricile
        Matrix& operator=(const Matrix& AMatrix);  // operatorul de atribuire (copie o matrice de la alta matrice)
        Matrix operator+(const Matrix& AMatrix);  // operatorul de adunare a doua matrici
        Matrix operator-(const Matrix& AMatrix);  // operatorul de scadere a doua matrici
        Matrix operator*(const Matrix& AMatrix);  // operatorul de inmultire a doua matrici
};  // incheierea clasei

Matrix::Matrix(int Rows, int Cols) {   // declarea externa a corpului constructorului
    CreateMatrix(Rows, Cols);
}

void Matrix::CreateMatrix(int Rows, int Cols) {
    // dimennsiunea maxima a matricii este de [5 x 5]
    if (Rows > 5) {
        this->rows = 5;
        cout << "Numarul maxim de linii este resetat la 5" << endl;
    }
    else this->rows = Rows;
    if (Cols > 5) {
        this->cols = 5;
        cout << "Numarul maxim de coloane este resetat la 5" << endl;			
    }
    else this->cols = Cols;
	
    // aloca dinamic spatiul de memorie necesar pentru matrice
    // prin mecanismul urmator se declara dinamic tablourile bidimensionale
    values = new int*[rows];  // obtinem adresa primului element dintr-un tablou de pointeri catre int
	for (int k = 0; k < rows; k++)
		values[k] = new int[cols];  // fiecare pointer din tabelul dat va pointa spre un tablou de tip int
};

Matrix::~Matrix() {
    // eliberam memoria ocupata de matrice, invers ordinii in care aceasta a fost alocata
    for (int k = 0; k < rows; k++)
        delete [] values[k];  // stergem mai intii tablourile de tip int spre care pointeaza tabloul de pointeri de tip int
    delete [] values;  // la urma stergem tablou de pointeri
}

void Matrix::ReadValues() {
    // citim toate elementele matricii de la tastatura
    for (int m = 0; m < rows; m++)
        for (int n = 0; n < cols; n++) {
            cout << "[" << m << ", " << n << "] = ";
            cin >> values[m][n];
        }
}

// parametrul AMatrix este constant ca metoda de securitate, deoarece nu se doreste modificarea continutului acestuia de catre functie
// functia intoarce o referinta catre un obiect, deoarece acesta deja este creat in memorie (instantiat)
Matrix& Matrix::operator=(const Matrix& AMatrix) {
    // atribuire este operatia de tipul:  a = b
    if (this != &AMatrix) {  // inainte de a folosi operatorul de atribuire, ne asiguram ca nu atribuim (copiem) un obiect tot catre dinsul
        for (int k = 0; k < rows; k++)   // ca si la destructor, eliberam memoria
            delete [] values[k];
        delete [] values;
        // si alocam alta conform noilor dimensiuni a matricii sursa, provenite in operatia de atribuire
        values = new int*[AMatrix.GetRowsCount()];
        for (int k = 0; k < AMatrix.GetRowsCount(); k++)
            values[k] = new int[AMatrix.GetColsCount()];
        }
        // dupa care copiem elementele matricii sursa (operandul drept) in operandul sting
        for (int m = 0; m < rows; m++)
            for (int n = 0; n < cols; n++) {
                values[m][n] = AMatrix.GetItem(m, n);
        // nu uitam sa ajustam noile dimensiuni ale matricii
        rows = AMatrix.GetRowsCount();
        cols = AMatrix.GetColsCount();    
    }
    return *this;  // intoarcem rezultatul; pointerul "this" este diferentiat pentru a obtine obiectul spre care el face referinta, dar nu adresa acestuia
}

// operatorii aritmetici trebuie sa intoarca o valoare, deaceia nu se intoarce referinta sau pointer !!
Matrix Matrix::operator+(const Matrix &AMatrix) {
    // sumarea/scaderea matricelor presupune ca ele au aceleasi dimensiuni
    if (rows != AMatrix.GetRowsCount() || cols != AMatrix.GetColsCount())
        throw string("Matricele au dimensiuni diferite !");  // aruncam o exceptie pentru a opri executia
    Matrix* result = new Matrix(rows, cols);  // cream o matrice temporara noua unde o sa salvam rezultatul
    for (int m = 0; m < rows; m++)
        for (int n = 0; n < cols; n++)
            (*result).SetItem(m, n, this->values[m][n] + AMatrix.GetItem(m, n));  // sumam elementele matricilor si le salvam in matricea rezultat
    return *result;  // intoarecem rezultatul; variabila result la iesirea din functie se distruge, dar deoarece am supraincarcat operatorul de atrubuire ' = '
                    // continutul acesteia se copie intr-o alta instanta intoarsa de functie
}

Matrix Matrix::operator-(const Matrix &AMatrix) {
    if (rows != AMatrix.GetRowsCount() || cols != AMatrix.GetColsCount())
        throw string("Matricele au dimensiuni diferite !");
    Matrix* result = new Matrix(rows, cols);
    for (int m = 0; m < rows; m++)
        for (int n = 0; n < cols; n++)
            (*result).SetItem(m, n, this->values[m][n] - AMatrix.GetItem(m, n));
    return *result;
}

Matrix Matrix::operator*(const Matrix &AMatrix) {
    int a;
    if (cols != AMatrix.GetRowsCount())
        throw string("Matricele au dimensiuni diferite !");
    Matrix* result = new Matrix(rows, cols);
    for (int m = 0; m < rows; m++)
        for (int k = 0; k < AMatrix.GetColsCount(); k++) {
            a = 0;
            for (int n = 0; n < cols; n++)
                a = a + values[m][n] * AMatrix.GetItem(n,k);
            (*result).SetItem(m, k, a);
        }
    return *result;
}

// aici este supraincarcat operatorul ' << ' pentru a afisa matricea la iesire (ecran)
ostream& operator<<(ostream& out, const Matrix &M) {
    for (int m = 0; m < M.GetRowsCount(); m++) {
        for (int n = 0; n < M.GetColsCount(); n++)
            out << setw(5) << M.GetItem(m, n);
        out << endl;  // salvam textul (mesajul) necesar in fluxul de iesire (variabila out)
    }
   return out;  // dupa care returnam acest flux de date
}

int main(int argc, char *argv[])  // functia main poate avea si paramatri pentru a citi parametrii introdusi de la linia de comanda la rularea aplicatiei
{
   Matrix M1, M2(2,2), M3;   // declaram instantele de obiecte, apelind diferiti constructori ai clasei "Matrix"
   M1.Name="M1";
   M2.Name="M2";
   M3.Name="M3";
   cout << "Introduceti datele matricii " << M1.Name << ":" << endl;
   M1.ReadValues();
   cout << "\nIntroduceti datele matricii " << M2.Name << ":" << endl;
   M2.ReadValues();
   try {
       M3 = M1 + M2;
       cout << "Suma matricelor:\n" << M3;
       M3 = M1 - M2;
       cout << "Diferenta matricelor:\n" << M3;
       M3 = M1 * M2;
       cout << "Produsul matricelor:\n" << M3;   
   }
   catch(const exception& e) {  // captam exceptiile primite intr-un bloc try{ ...} ... catch(...) {...}
       cout << e.what();
   }
//    system("pause");
   return EXIT_SUCCESS;  // functia main intoarce un rezultat, in cazul dat codul 0 (zero)
}
