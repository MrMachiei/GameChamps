create or replace package dodawanie is
    procedure dodajAutoraGry(pImie varchar2, pNazwisko varchar2);
    procedure dodajCzlonkaKlubu(pRola varchar2, pNazwaKlubu varchar2, pImie varchar2, pNazwisko varchar2, 
                                pData in date default current_date, pIdCzlonka number);
    procedure dodajDodatek(pPodtytul varchar2, pTytulGry varchar2);
    procedure dodajOceneGracza(pOcena number, pTytulGry varchar2, pImie varchar2, 
                                pNazwisko varchar2, pIdGracza number);
    procedure dodajGracza(pImie varchar2, pNazwisko varchar2);
    procedure dodajGre(pTytul varchar2, pImieAutora varchar2, 
                        pNazwiskoAutora varchar2, pGatunek varchar2);
    procedure dodajKlub(pNazwa varchar2);
--    procedure dodajLokalizacje(pMiasto varchar2, pObiekt varchar2);
--    procedure dodajPatrona(pNazwa varchar2);
--    procedure dodajPatronaWydarzenia(pNazwaWudarzenia varchar2, pNazwaPatrona varchar2);
--    procedure dodajRoleWRozgrywce(pRola varchar2, pNazwa varchar2, pImieGracza varchar2,
--                                    pNazwiskoGracza varchar2, pNazwaKlubu1 varchar2,
--                                    pNazwaKlubu2 varchar2, pData date, pIdRozgrywki varchar2,
--                                    pNazwaTurnieju varchar2, pIdCzlonkaKlubu varchar2);
--    procedure dodajRozgrywke(pIdRozgrywki natural, pData date, pWygrywajacy varchar2,
--                                pTytulGry varchar2, pImieGracza1 varchar2, pNazwiskoGracza1 varchar2,
--                                pImieGracza2 varchar2, pNazwiskoGracza2 varchar2, pMiasto varchar2,
--                                pObiekt varchar2, pIdGracza1 varchar2, pIdGracza2 varchar2);
--    procedure dodajRozgrywkeTurnejowa(pIdRozgrywki natural, pData date, pWygrywajacyKlub varchar2,
--                                        pNazwaKlubu1 varchar2, pNazwaKlubu2 varchar2, pNazwaTurnieju varchar2,
--                                        pIdKlubu1 natural, pIdKlubu2 natural);
--    procedure dodajTurniej(pNazwa varchar2, pNazwaWydarzenia varchar2,
--                            pMiasto varchar2, pObiekt varchar2);
--    procedure dodajTypGry(pGatunek varchar2, pGatunekDodatkowy varchar2);
--    procedure dodajWlascicielaGry(pImie varchar2, pNazwisko varchar2, pNazwaKlubu varchar2,
--                                    pTytulGry varchar2, pKosztZakupu varchar2);
--    procedure dodajWydarzenie(pNazwa varchar2, pOrganizator varchar2);
--    
--    exNazwaNieIstnieje exception;
--    exIdNieIsnieje exception;
--    exIdDuplikat exception;
--    pragma EXCEPTION_INIT(exNazwaNieIstnieje, -21234);
--    pragma EXCEPTION_INIT(exIdNieIsnieje, -22234);
--    pragma EXCEPTION_INIT(exIdDuplikat, -00001);
end dodawanie;

create or replace package body dodawanie is
    --1
    procedure dodajAutoraGry(pImie varchar2, pNazwisko varchar2) is
    begin
        insert into autorzy_gry values (pImie, pNazwisko);
    end dodajAutoraGry;
    
    --2
    procedure dodajCzlonkaKlubu(pRola varchar2, pNazwaKlubu varchar2, pImie varchar2, pNazwisko varchar2, 
                                pData in date default current_date, pIdCzlonka number) is
    begin
        insert into czlonkowie_klubu (rola, data_dolaczenia, kluby_nazwa, 
                                        gracze_imie, gracze_nazwisko, czlonek_id)
        values (pRola, pData, pNazwaKlubu, pImie, pNazwisko, pIdCzlonka);
    end dodajCzlonkaKlubu;
    
    --3
    procedure dodajDodatek(pPodtytul varchar2, pTytulGry varchar2) is
    begin
        insert into dodatki values(pPodtytul, pTytulGry);
    end dodajDodatek;
    
    --4
    procedure dodajOceneGracza(pOcena number, pTytulGry varchar2, pImie varchar2, 
                                pNazwisko varchar2, pIdGracza number) is
    begin
        insert into gracz_gry_oceny values (pOcena, pTytulGry, pImie, 
                                            pNazwisko, pIdGracza);
    end dodajOceneGracza;
    
    --5
    procedure dodajGracza(pImie varchar2, pNazwisko varchar2) is
    begin
        insert into gracze values (gracz_gracz_id_seq.nextval, pImie, pNazwisko);
    end dodajGracza;
    
    --6
    procedure dodajGre(pTytul varchar2, pImieAutora varchar2, 
                        pNazwiskoAutora varchar2, pGatunek varchar2) is
    begin
        insert into gry values (pTytul, pImieAutora, pNazwiskoAutora, pGatunek);
    end;
    
    --7
    procedure dodajKlub(pNazwa varchar2) is
    begin
        insert into kluby values (klub_klub_id_seq.nextval, pNazwa);
    end;
end dodawanie;

begin
--    dodawanie.dodajAutoraGry('testowe imie', 'testowe nazwisko');
--    dodawanie.dodajCzlonkaKlubu('test rola', 'test klub', 'Aga', 'Kalafior', 10);
--    dodawanie.dodajDodatek('test gra', 'test dodatek');
--    dodawanie.dodajOceneGracza(10, 'tytul gry', 'test imie', 'test nazwisko', 10);
--    dodawanie.dodajGracza('Aga', 'Klimek');
--    dodawanie.dodajGre('terraformacja', 'A', 'Bee', 'RPG');
--    dodawanie.dodajKlub('Alleluja');
end;

select * from kluby;



