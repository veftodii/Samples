IDE: Borland Pascal 7.0 (Turbo Pascal 3.0)
------------------------------------------
Sunt restrictii daca lipseste fisierul de intrare, daca nu ai introdus corect datele de intrare - perechi de "numar - caracter" sau "caracter".
Liinile goale vor fi ignorate, aplicatia se va opri la prima linie care nu satisface conditiile necesare la datele de intrare. Toate mesajele de eroare, finisare vor fi afisate.
Nu este restrictie la litere. Poti introduce orice caracter de la tastatura, litere majuscule, minuscule, simboluri, etc.
In fisierul de iesire trebuie sa fie toate sirurile extinse conform originalului.
Este posibil ca cautarea prezentei fisierului pe disc (functia FindFirst) sa nu fie in alte compilatoare!

Numele fisierelor utilizate, inclusiv adresa acestora (lipseste cind fisierul este in acelasi directoriu cu codul sursa sau exe-ul daca programul este compilat final ca executabil) este la inceputul programului in constantele "InFile" si "OutFile". Valoarea acestora poate fi modificata.