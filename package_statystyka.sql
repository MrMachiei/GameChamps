CREATE OR REPLACE PACKAGE statystyka IS
--funkcje
    --OGOLNE
        --ogolna liczba rozegranych gier w dany tytul
            FUNCTION IleRozgrywekGra(fTytul VARCHAR2)
            RETURN NATURAL;
        --ogolna liczba rozegranych gier gracza
            FUNCTION IleRozgrywekGracz(fImie VARCHAR2, fNazwisko VARCHAR2)
            RETURN NATURAL;
        --ogolna liczba rozegranych gier klubu
            FUNCTION IleRozgrywekKlub(fNazwa VARCHAR2)
            RETURN NATURAL;

    --GRACZ
        --liczba wygranych gracza
            FUNCTION IleWygranychGracz(fImie VARCHAR2, fNazwisko VARCHAR2)
            RETURN NATURAL;
        --liczba wygranych gracza w dany tytul
            FUNCTION IleWygranychGraczGra(fImie VARCHAR2, fNazwisko VARCHAR2, fTytul VARCHAR2)
            RETURN NATURAL;
        --procent wygranych gracza
            FUNCTION GraczProcentWygranych(fImie VARCHAR2, fNazwisko VARCHAR2)
            RETURN NUMBER;
    --KLUB
        --liczba wygranych klubu
            FUNCTION IleWygranychKlub(fNazwa VARCHAR2)
            RETURN NATURAL;
        --liczba wygranych klubu w dany tytul
            FUNCTION IleWygranychKlubGra(fNazwa VARCHAR2, fTytul VARCHAR2)
            RETURN NATURAL;
        --procent wygranych klubu
            FUNCTION KlubProcentWygranych(fNazwa VARCHAR2)
            RETURN NUMBER;
    --GRA
        --procent wygranych dla gracza
            FUNCTION GraProcentGracza(fTytul VARCHAR2, fImie VARCHAR2, fNazwisko VARCHAR2)
            RETURN NUMBER;
        --liczba rozgrywek w danej lokalizacji
            FUNCTION IleGierLokalizacja(fTytul VARCHAR2, fMiasto VARCHAR2, fObiekt VARCHAR2)
            RETURN NATURAL;
        --procent rozgrywek w danej lokalizacji
            FUNCTION GraProcentLokalizacji(fTytul VARCHAR2, fMiasto VARCHAR2, fObiekt VARCHAR2)
            RETURN NUMBER;
        --liczba gier turniejowych
            FUNCTION IleGierTurniejowych(fTytul VARCHAR2)
            RETURN NATURAL;

--exceptions
    exGraczNieIstnieje EXCEPTION;
    exKlubNieIstnieje EXCEPTION;
    exGraNieIstnieje EXCEPTION;
--wizania exceptions
    PRAGMA EXCEPTION_INIT(exGraczNieIstnieje, -20001);
    PRAGMA EXCEPTION_INIT(exKlubNieIstnieje, -20002);
    PRAGMA EXCEPTION_INIT(exGraNieIstnieje, -200003);
END statystyka;
/
COMMIT;
/
CREATE OR REPLACE PACKAGE BODY statystyka IS

    FUNCTION IleRozgrywekGra(fTytul VARCHAR2) 
    RETURN NATURAL IS
        vIleRozgrywek NATURAL;
        vIleTurniejowych NATURAL;
        vOgolem NATURAL;
    BEGIN
        SELECT COUNT(*) INTO vIleRozgrywek
        FROM rozgrywki
        WHERE gry_tytul = fTytul;

        SELECT COUNT(*) INTO vIleTurniejowych
        FROM rozgrywki_turniejowe
        WHERE gry_tytul = fTytul;

        vOgolem := vIleTurniejowych + vIleRozgrywek;

        RETURN vOgolem;
    END IleRozgrywekGra;

    FUNCTION IleRozgrywekGracz(fImie VARCHAR2, fNazwisko VARCHAR2)
    RETURN NATURAL IS
        vIleRozgrywek NATURAL;
        vIleTurniejowych NATURAL;
        vOgolem NATURAL;
    BEGIN
        SELECT COUNT(*) INTO vIleRozgrywek
        FROM rozgrywki
        WHERE (gracze_imie = fImie AND gracze_nazwisko = fNazwisko) OR (gracze_imie1 = fImie AND gracze_nazwisko1 = fNazwisko);

        SELECT COUNT(*) INTO vIleTurniejowych
        FROM rozgrywka_gracze_role
        WHERE imie_gracza = fImie AND nazwisko_gracza = fNazwisko;

        vOgolem := vIleTurniejowych + vIleRozgrywek;

        RETURN vOgolem;
    END IleRozgrywekGracz;

    FUNCTION IleRozgrywekKlub(fNazwa VARCHAR2)
    RETURN NATURAL IS
        vIleRozgrywek NATURAL;
    BEGIN
        SELECT COUNT(*) INTO vIleRozgrywek
        FROM rozgrywki_turniejowe
        WHERE (kluby_nazwa = fNazwa) OR (kluby_nazwa1 = fNazwa);

        RETURN vIleRozgrywek;
    END IleRozgrywekKlub;

    FUNCTION IleWygranychGracz(fImie VARCHAR2, fNazwisko VARCHAR2)
    RETURN NATURAL IS
        vIleWygranych NATURAL;
    BEGIN
        SELECT COUNT(*) INTO vIleWygranych
        FROM rozgrywki
        WHERE wygrywajacy_gracz = (fImie || ' ' || fNazwisko);

        RETURN vIleWygranych;
    END IleWygranychGracz;

    FUNCTION IleWygranychGraczGra(fImie VARCHAR2, fNazwisko VARCHAR2, fTytul VARCHAR2)
    RETURN NATURAL IS
        vIleWygranych NATURAL;
    BEGIN
        SELECT COUNT(*) INTO vIleWygranych
        FROM rozgrywki
        WHERE wygrywajacy_gracz = (fImie || ' ' || fNazwisko) AND gry_tytul = fTytul;

        RETURN vIleWygranych;
    END IleWygranychGraczGra;
    
    FUNCTION GraczProcentWygranych(fImie VARCHAR2, fNazwisko VARCHAR2)
    RETURN NUMBER IS
    vResult NUMBER(5,2);
    BEGIN
        vResult := IleWygranychGracz(fImie, fNazwisko) / IleRozgrywekGracz(fImie, fNazwisko);
        
        RETURN vResult;
    END GraczProcentWygranych;

    FUNCTION IleWygranychKlub(fNazwa VARCHAR2)
    RETURN NATURAL IS
        vIleWygranych NATURAL;
    BEGIN
        SELECT COUNT(*) INTO vIleWygranych
        FROM rozgrywki_turniejowe
        WHERE wygrywajacy_klub = fNazwa;

        RETURN vIleWygranych;
    END IleWygranychKlub;

    FUNCTION IleWygranychKlubGra(fNazwa VARCHAR2, fTytul VARCHAR2)
    RETURN NATURAL IS
        vIleWygranych NATURAL;
    BEGIN
        SELECT COUNT(*) INTO vIleWygranych
        FROM rozgrywki_turniejowe
        WHERE wygrywajacy_klub = fNazwa AND gry_tytul = fTytul;

        RETURN vIleWygranych;
    END IleWygranychKlubGra;
    
    FUNCTION KlubProcentWygranych(fNazwa VARCHAR2)
    RETURN NUMBER IS
    vResult NUMBER(5,2);
    BEGIN
        vResult := IleWygranychKlub(fNazwa) / IleRozgrywekKlub(fNazwa) * 100;
        
        RETURN vResult;
    END KlubProcentWygranych;
    
    FUNCTION GraProcentGracza(fTytul VARCHAR2, fImie VARCHAR2, fNazwisko VARCHAR2)
    RETURN NUMBER IS
    vWynik NUMBER(5,2);
    BEGIN
        vWynik := IleWygranychGraczGra(fImie, fNazwisko, fTytul) / IleRozgrywekGra(fTytul) * 100;
    END GraProcentGracza;

    FUNCTION IleGierLokalizacja(fTytul VARCHAR2, fMiasto VARCHAR2, fObiekt VARCHAR2)
    RETURN NATURAL IS
    vIleGier NATURAL;
    vIleTurniejowych NATURAL;
    vIle NATURAL;
    BEGIN
        SELECT COUNT(*) INTO vIleGier
        FROM rozgrywki
        WHERE lokalizacje_miasto = fMiasto AND lokalizacje_obiekt = fObiekt;

        SELECT COUNT(*) INTO vIleTurniejowych
        FROM rozgrywki_turniejowe r INNER JOIN turnieje t ON r.turnieje_nazwa = t.nazwa
        WHERE t.lokalizacje_miasto= fMiasto AND t.lokalizacje_obiekt = fObiekt;

        vIle := vIleGier + vIleTurniejowych;
        return vIle;
    END IleGierLokalizacja;
            
    FUNCTION GraProcentLokalizacji(fTytul VARCHAR2, fMiasto VARCHAR2, fObiekt VARCHAR2)
    RETURN NUMBER IS
    vIle NUMBER(5,2);
    BEGIN
        vIle := IleRozgrywekGra(fTytul) / IleGierLokalizacja(fTytul, fMiasto, fObiekt) * 100;
        return vIle;
    END GraProcentLokalizacji;
         

    FUNCTION IleGierTurniejowych(fTytul VARCHAR2)
    RETURN NATURAL IS
    vIle NATURAL;
    BEGIN
        SELECT COUNT(*) INTO vIle
        FROM rozgrywki_turniejowe
        WHERE gry_tytul = fTytul;

        return vIle;
    END IleGierTurniejowych;
     
END statystyka;
/
COMMIT;

--TYPE tDane IS RECORD(
--   nazwisko pracownicy.nazwisko%TYPE,
--   etat pracownicy.etat%TYPE);