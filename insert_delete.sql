create or replace package zarzadzanie is
--INSERT
    --1
    procedure dodajAutoraGry(pImie varchar2, pNazwisko varchar2);
    --2
    procedure dodajCzlonkaKlubu(pRola varchar2, pNazwaKlubu varchar2, pImie varchar2, pNazwisko varchar2, 
                                pData in date default current_date, pIdCzlonka number);
    --3
    procedure dodajDodatek(pPodtytul varchar2, pTytulGry varchar2);
    --4
    procedure dodajOceneGracza(pOcena number, pTytulGry varchar2, pImie varchar2, 
                                pNazwisko varchar2, pIdGracza number);
    --5
    procedure dodajGracza(pImie varchar2, pNazwisko varchar2);
    --6
    procedure dodajGre(pTytul varchar2, pImieAutora varchar2, 
                        pNazwiskoAutora varchar2, pGatunek varchar2);
    --7
    procedure dodajKlub(pNazwa varchar2);
    --8
    procedure dodajLokalizacje(pMiasto varchar2, pObiekt varchar2);
    --9
    procedure dodajPatrona(pNazwa varchar2);
    --10
    procedure dodajPatronaWydarzenia(pNazwaWydarzenia varchar2, pNazwaPatrona varchar2);
    --11
    procedure dodajRoleWRozgrywce(pRola varchar2, pNazwaWydarzenia varchar2, pImieGracza varchar2,
                                    pNazwiskoGracza varchar2, pNazwaKlubu1 varchar2,
                                    pNazwaKlubu2 varchar2, pNazwaTurnieju varchar2, pIdRozgrywki number,
                                    pIdCzlonkaKlubu number, pData date default current_date);
    --12
    procedure dodajRozgrywke(pTytulGry varchar2, pImieGracza1 varchar2, pNazwiskoGracza1 varchar2, pImieGracza2 varchar2, 
                                pNazwiskoGracza2 varchar2, pMiasto varchar2, pObiekt varchar2, pIdGracza1 varchar2, 
                                pIdGracza2 varchar2, pData date default current_date, pWygrywajacy varchar2);                      
    --13
    procedure dodajRozgrywkeTurnejowa(pNazwaKlubu1 varchar2, pNazwaKlubu2 varchar2, pNazwaTurnieju varchar2, pIdKlubu1 natural, 
                                        pIdKlubu2 natural, pData date default current_date, pWygrywajacyKlub varchar2);                          
    --14
    procedure dodajTurniej(pNazwa varchar2, pNazwaWydarzenia varchar2,
                            pMiasto varchar2, pObiekt varchar2);                 
    --15
    procedure dodajTypGry(pGatunek varchar2, pGatunekDodatkowy varchar2);
    --16
    procedure dodajWlascicielaGry(pImie varchar2, pNazwisko varchar2, pNazwaKlubu varchar2,
                                    pTytulGry varchar2, pKosztZakupu float);
    --17
    procedure dodajWydarzenie(pNazwa varchar2, pOrganizator varchar2);
    
--DELETE
    --1
    procedure usunAutoraGry(pImie varchar2, pNazwisko varchar2);
end dodawanie;
/
create or replace package body zarzadzanie is
--INSERT
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
    
    --8
    procedure dodajLokalizacje(pMiasto varchar2, pObiekt varchar2) is
    begin
        insert into lokalizacje values (pMiasto, pObiekt);
    end;
    
    --9
    procedure dodajPatrona(pNazwa varchar2) is
    begin
        insert into patroni_medialni values (pNazwa);
    end;
    
    --10
    procedure dodajPatronaWydarzenia(pNazwaWydarzenia varchar2, pNazwaPatrona varchar2) is
    begin
        insert into patroni_wydarzenia values (pNazwaWydarzenia, pNazwaPatrona);
    end;
    
    --11
    procedure dodajRoleWRozgrywce(pRola varchar2, pNazwaWydarzenia varchar2, pImieGracza varchar2,
                                    pNazwiskoGracza varchar2, pNazwaKlubu1 varchar2,
                                    pNazwaKlubu2 varchar2, pNazwaTurnieju varchar2, pIdRozgrywki number,
                                    pIdCzlonkaKlubu number, pData date default current_date) is
    begin
        insert into rozgrywka_gracze_role (rola, nazwa, imie_gracza, nazwisko_gracza, nazwa_klubu_1, nazwa_klubu_2, 
                                            nazwa_turnieju, id_rozgrywki_turniejowej, czlonkowie_klubu_czlonek_id, data) 
        values (pRola, pNazwaWydarzenia, pImieGracza, pNazwiskoGracza, pNazwaKlubu1, pNazwaKlubu2, pNazwaTurnieju,
                pIdRozgrywki, pIdCzlonkaKlubu, pData);
    end;
    
    --12
    procedure dodajRozgrywke(pTytulGry varchar2, pImieGracza1 varchar2, pNazwiskoGracza1 varchar2, pImieGracza2 varchar2, 
                                pNazwiskoGracza2 varchar2, pMiasto varchar2, pObiekt varchar2, pIdGracza1 varchar2, 
                                pIdGracza2 varchar2, pData date default current_date, pWygrywajacy varchar2) is
    begin
        insert into rozgrywki (gry_tytul, gracze_imie, gracze_nazwisko, gracze_imie1, gracze_nazwisko1, lokalizacje_miasto,
                                lokalizacje_obiekt, gracze_gracz_id, gracze_gracz_id1, rozgrywka_id, data, wygrywajacy_gracz)
        values (pTytulGry, pImieGracza1, pNazwiskoGracza1, pImieGracza2, pNazwiskoGracza2, pMiasto, pObiekt, pIdGracza1,
                pIdGracza2, rozgrywka_rozgrywka_id_seq.nextval, pData, pWygrywajacy);
    end;
    
    --13
    procedure dodajRozgrywkeTurnejowa(pNazwaKlubu1 varchar2, pNazwaKlubu2 varchar2, pNazwaTurnieju varchar2, pIdKlubu1 natural, 
                                        pIdKlubu2 natural, pData date default current_date, pWygrywajacyKlub varchar2) is
    begin
        insert into rozgrywki_turniejowe (kluby_nazwa, kluby_nazwa1, turnieje_nazwa, kluby_klub_id, kluby_klub_id1, rozgrywka_turniej_id, data, wygrywajacy_klub)
        values (pNazwaKlubu1, pNazwaKlubu2, pNazwaTurnieju, pIdKlubu1, pIdKlubu2, rozgrywka_turniej_rozgrywka_tu.nextval, pData, pWygrywajacyKlub);
    end;
    
    --14
    procedure dodajTurniej(pNazwa varchar2, pNazwaWydarzenia varchar2,
                            pMiasto varchar2, pObiekt varchar2) is
    begin
        insert into turnieje values (pNazwa, pNazwaWydarzenia, pMiasto, pObiekt);
    end;
    
    --15
    procedure dodajTypGry(pGatunek varchar2, pGatunekDodatkowy varchar2) is
    begin
        insert into typy_gry values (pGatunek, pGatunekDodatkowy);
    end;
    
    --16
    procedure dodajWlascicielaGry(pImie varchar2, pNazwisko varchar2, pNazwaKlubu varchar2,
                                    pTytulGry varchar2, pKosztZakupu float) is
    begin
        insert into wlasciciele_gry values (pImie, pNazwisko, pNazwaKlubu,
                                            pTytulGry, pKosztZakupu);
    end;
    
    --17
    procedure dodajWydarzenie(pNazwa varchar2, pOrganizator varchar2) is
    begin
        insert into wydarzenia values (pNazwa, pOrganizator);
    end;
    
--DELETE
    --1
    procedure usunAutoraGry(pImie varchar2, pNazwisko varchar2);
    
end dodawanie;

--begin
--    dodawanie.dodajAutoraGry('Maciej', 'Walczykowski');
--    dodawanie.dodajCzlonkaKlubu('Gandalf', 'Kosteczka', 'Aga', 'Klimek', 10);
--    dodawanie.dodajDodatek('Zycie', 'Sagrada');
--    dodawanie.dodajOceneGracza(10, 'Sagrada', 'Aga', 'Klimek', 10);
--    dodawanie.dodajGracza('Aga', 'Klimek');
--    dodawanie.dodajGre('Sagrada', 'Maciej', 'Walczykowski', 'RPG');
--    dodawanie.dodajKlub('Kosteczka');
--    dodawanie.dodajLokalizacje('Poznan', 'MTP');
--    dodawanie.dodajPatrona('Kulczyk');
--    dodawanie.dodajPatronWydarzenia('Pyrkon', 'Kulczyk');
--    dodawanie.dodajRoleWRozgrywce('Gandalf', 'Pyrkon', 'Aga', 'Klimek', 'Kosteczka', 'Klub2', 'Turniej A', 10, 10);
--end;




