%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ten plik jest cz�ci� pakietu MPATTERN
%
% Autor: Piotr Bolek
% wersja: 0.5 (Jun 25, 2001)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Opis
====

Pakiet MPATTERN s�u�y do definiowania i u�ywania wype�nie� wzorkowych
w programie MetaPost. W pakiecie wykorzystywana jest dost�pna w j�zyku
PostScript Level 2 Wzorkowa Przestrze� Kolor�w (Pattern Color Space).

Zawarto��:
- mpattern.mp: makra dla programu MetaPost s�u��ce do  definiowania
  i u�ywania wzork�w.
- README: kr�tki opis po angielsku.
- README.PL: kr�tki opis po polsku.
- test.mp, test.tex, test.ps: przyk�ady u�ycia.

Spos�b u�ycia
=============

W pliku �r�d�owym nale�y na pocz�tku w��czy� poleceniem input plik
mpattern.mp, a nast�pnie przetworzy� plik standardowym programem
mpost. 

Interfejs u�ytkownika
=====================

Definiowanie wzorku
--------------------

Wzorki s� definiowane przy u�yciu konstrukcji:

beginpattern(<nazwa_wzorku>);
...
endpattern;

Parametr <nazwa_wzorku> jest nazw�, kt�ra s�u�y do identyfikacji
wzorku. Nazwa ta mo�e zawiera� litery i znaki podkre�lenia ,,_'', ale
nie mo�e zawiera� cyfr. NIE nale�y podawa� tej nazwy w cudzys�owach.

W definicji wzorku (w dowolnym miejscu mi�dzy beginpattern a
endpattern) mo�na poda� dodatkowe polecenia: 
- patternbbox(<pair>,<pair>)
- patternbbox((<numeric>,<numeric>,<numeric>,<numeric>) 
  Jawne podanie wsp�rz�dnych prostok�ta ograniczaj�cego kom�rk� wzorka

- patternxstep(<numeric>)
- patternystep(<numeric>)
- patternstep(<numeric>,<numeric>)
- patternstep(<pair>)
  Odst�py mi�dzy kom�rkami wzorka

- patterntransform(<transform>)
  Modyfikacja kszta�tu kom�rki wzorka

- patterncolor(0<= <numeric> <= 1)
  Jawne podanie koloru zwi�zanego z danym wzorkiem

Ka�dy wzorek jest tymczasowo zapisywany jako rysunek o du�ym numerze
(domy�lnie 999), ale je�li u�ytkownik wykorzysta ten numer do swojego
rysunku, to dla wzorku b�dzie u�yty najwi�kszy wolny numer mniejszy od
999.

U�ywanie wzorku
---------------

Do wykorzystania zdefiniowanego wzorku s�u�y makro dzia�aj�ce jak
operator dwuargumentowy (primary) withpattern. Spos�b u�ycie jest
nast�puj�cy:

<�cie�ka> withpattern <nazwa_wzorku>;

gdzie <�cie�ka> jest dowolnym wyra�eniem okre�laj�cym zamkni�t�
�cie�k�, a <nazwa_wzorku> jest nazw� podan� w definicji wzorku.

Przyk�ad
--------

Oto kod s�u��cy do narysowania dw�ch k�ek wype�nionych r�nymi
szachownicami.

input mpattern;

beginpattern(checker);
 d:=4mm;
 fill unitsquare scaled d;
 fill unitsquare scaled d shifted (d,d);
 patternbbox(0,0,2d,2d);
endpattern;

beginpattern(rotated_checker);
 fill unitsquare scaled 4mm rotated 45 withcolor .7white;
endpattern;

beginfig(11);
 path p;
 z1=(1cm,1cm);
 p=fullcircle scaled 3cm;
 fill p withpattern checker;
 unfill p shifted z1;
 fill p shifted z1 withpattern rotated_checker;
endfig;

Zasady rozpowszechniania
========================

Pakiet MPATTERN jest dobrem wsp�lnym (ang. ,,public domain''). W
przypadku modyfikacji lub redystrybucji pakietu mo�na stosowa� dowoln�
aktualn� licencj� GPL.

Problemy
========

06-2001: Mog� by� problemy z wype�nianiem wzorkami napis�w. Aktualne
	 rozwi�zanie jest prowizoryczne.

Zmiany
======

06-2001: Dzi�ki inspiracji tutorialem Piotra Strzelczyka na
	 konferencji BachoTeX'2001 wyeliminowana zosta�a konieczno��
	 postprocesingu z wykorzystaniem Perla. Podmiana kolor�w na
	 wzorki jest obecnie realizowana z wykorzystaniem s�ownik�w na
	 poziomie PostScriptu.

Kontakt z autorem
=================

e-mail: P.Bolek@gust.org.pl
