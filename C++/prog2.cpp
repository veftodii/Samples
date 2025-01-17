#include <iostream>
#include <cmath>

using namespace std;

// gasirea solutiilor ecuatiei patrate de forma  aX^2 + bX + c = 0
class Equation {
	// variabile private
	double a, b, c;  

	// variabile private utilizate in calcularea discriminantului si a radacinilor
	double discriminant;
	double positive_root;
	double negative_root;

	public:
		// definim un set de functii PUBLICE inline pentru a seta valoarea variabilelor PRIVATE
		void SetArg_A(const double value) { a = value; }
		void SetArg_B(const double value) { b = value; }
		void SetArg_C(const double value) { c = value; }
		// functia data este inline si intoarce valoare variabilei "discriminant"
		void Execute();  // declaram o funtie pentru a calcula ecuatia
		double GetDiscriminant() { return discriminant; }
		void CheckSolutionType();  // declaram prototipul unei functii pentru a verifica numarul de radacini a ecuatiei
		double GetPositiveRoot() { return positive_root; }
		double GetNegativeRoot() { return negative_root; }
};

// declaram in afara clasei corpul functiei declarate anterior
void Equation::Execute() {
	discriminant = (pow(b,2) - 4*a*c); // formula de calculare a discriminantului (expresia de sub radical)
	positive_root = (((-b) + sqrt(discriminant))/(2*a)); // prima radacina a ecuatiei calculind discriminantul positiv
	negative_root = (((-b) - sqrt(discriminant))/(2*a)); // a doua radacina utilizind discriminantul negativ
}

void Equation::CheckSolutionType() {
	// afisam diferite mesaje la iesire in functie de valoarea discriminatului,
	// care si va determina numarul de radacini a ecuatiei patrate
	if (discriminant == 0) {  // daca discriminantul = 0
		cout << "Ecuatia are o singura radacina.\n\n"; // aici la sfirsit se lasa 2 linii libere la iesire
	}
	else if (discriminant < 0) // parantezele {} pot lipsi cind urmeaza sa se execute o singura instructiune
		cout << "Ecuatia are 2 radacini complexe.\n\n";
	else {  // discriminant > 0
		cout << "Ecuatia are 2 radacini reale.\n\n";
	}
}

// functia main trebuie sa intoarca o valoare de tip int
// (principiul dat este definit de compilator si nu de standardele limbajului C\C++)
int main()
{
	double a; // declaram o variabila pentru a citi parametrii de intrare
	Equation Q1;  // declaram un obiect de tip Equation;
			      // acesta se va initializa prin chemarea constructorului sau implicit, declarat automat de compilator

	// citim parametrii (constantele) ecuatiei de la tastatura
	cout << "Rezolvarea ecuatie patrate de forma: aX^2 + bX + c = 0" << endl;
	cout << "\nIntroduceti o valoare pentru a: ";
	cin >> a;
	Q1.SetArg_A(a);  // transmitem valoare citita in variabilele clasei utilizind membrii acesteia
	cout << "\nIntroduceti o valoare pentru b: ";
	cin >> a;
	Q1.SetArg_B(a);	cout << "\nIntroduceti o valoare pentru c: ";
	cin >> a;
	Q1.SetArg_C(a);
	
	// rezolvam ecuatia
	Q1.Execute();

	// afisam valoarea discriminantului si trecem "cursorul text" din rind nou
	cout << "\n\nDiscriminantul este egal cu: " << Q1.GetDiscriminant() << endl;
	Q1.CheckSolutionType(); // verificam si afisam tipul radacinilor ecuatiei
	
	// afisam radacinile ecuatiei
	cout << "\n\nRadacinile ecuatiei patrate sunt x = ";
	cout << Q1.GetNegativeRoot();  // obtinem si afisam radacina negativa
	cout << ", ";
	cout << Q1.GetPositiveRoot() << endl;  // obtinem si afisam radacina positiva
	
	return 0;  // functia main trebuie sa intoarca o valoare
}
