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
                                        pIdKlubu2 natural, pTytulGry varchar, pData date default current_date, pWygrywajacyKlub varchar2);                          
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
    --2
    procedure usunCzlonkaKlubu(pIdCzlonka number);
    --3
    procedure usunDodatek(pPodtytul varchar2);
    --4
    procedure usunOceneGracza(pOcena number, pTytulGry varchar2, pImie varchar2, pNazwisko varchar2);
    --5
    procedure usunGracza(pImie varchar2, pNazwisko varchar2);
    --6
    procedure usunGre(pTytul varchar2);
    --7
    procedure usunKlub(pNazwa varchar2);
    --8
    procedure usunLokalizacje(pMiasto varchar2, pObiekt varchar2);
    --9
    procedure usunPatrona(pNazwa varchar2);
    --10
    procedure usunPatronaWydarzenia(pNazwaWydarzenia varchar2, pNazwaPatrona varchar2);
    --14
    procedure usunTurniej(pNazwa varchar2);                 
    --15
    procedure usunTypGry(pGatunek varchar2);
    --16
    procedure usunWlascicielaGry(pImie varchar2, pNazwisko varchar2);
    --17
    procedure usunWydarzenie(pNazwa varchar2);
    
    --init exceptions
    exIdNieIstnieje exception;
    exNazwaNieIstnieje exception;
    pragma exception_init(exIdNieIstnieje, -21234);
    pragma exception_init(exNazwaNieIstnieje, -22234);
end zarzadzanie;
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
    end dodajGre;
    
    --7
    procedure dodajKlub(pNazwa varchar2) is
    begin
        insert into kluby values (klub_klub_id_seq.nextval, pNazwa);
    end dodajKlub;
    
    --8
    procedure dodajLokalizacje(pMiasto varchar2, pObiekt varchar2) is
    begin
        insert into lokalizacje values (pMiasto, pObiekt);
    end dodajLokalizacje;
    
    --9
    procedure dodajPatrona(pNazwa varchar2) is
    begin
        insert into patroni_medialni values (pNazwa);
    end dodajPatrona;
    
    --10
    procedure dodajPatronaWydarzenia(pNazwaWydarzenia varchar2, pNazwaPatrona varchar2) is
    begin
        insert into patroni_wydarzenia values (pNazwaWydarzenia, pNazwaPatrona);
    end dodajPatronaWydarzenia;
    
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
    end dodajRoleWRozgrywce;
    
    --12
    procedure dodajRozgrywke(pTytulGry varchar2, pImieGracza1 varchar2, pNazwiskoGracza1 varchar2, pImieGracza2 varchar2, 
                                pNazwiskoGracza2 varchar2, pMiasto varchar2, pObiekt varchar2, pIdGracza1 varchar2, 
                                pIdGracza2 varchar2, pData date default current_date, pWygrywajacy varchar2) is
    begin
        insert into rozgrywki (gry_tytul, gracze_imie, gracze_nazwisko, gracze_imie1, gracze_nazwisko1, lokalizacje_miasto,
                                lokalizacje_obiekt, gracze_gracz_id, gracze_gracz_id1, rozgrywka_id, data, wygrywajacy_gracz)
        values (pTytulGry, pImieGracza1, pNazwiskoGracza1, pImieGracza2, pNazwiskoGracza2, pMiasto, pObiekt, pIdGracza1,
                pIdGracza2, rozgrywka_rozgrywka_id_seq.nextval, pData, pWygrywajacy);
    end dodajRozgrywke;
    
    --13
    procedure dodajRozgrywkeTurnejowa(pNazwaKlubu1 varchar2, pNazwaKlubu2 varchar2, pNazwaTurnieju varchar2, pIdKlubu1 natural, 
                                        pIdKlubu2 natural, pTytulGry varchar, pData date default current_date, pWygrywajacyKlub varchar2) is
    begin
        insert into rozgrywki_turniejowe (kluby_nazwa, kluby_nazwa1, turnieje_nazwa, kluby_klub_id, kluby_klub_id1, 
                                            gry_tytul, rozgrywka_turniej_id, data, wygrywajacy_klub)
        values (pNazwaKlubu1, pNazwaKlubu2, pNazwaTurnieju, pIdKlubu1, pIdKlubu2, pTytulGry, rozgrywka_turniej_rozgrywka_tu.nextval, pData, pWygrywajacyKlub);
    end dodajRozgrywkeTurnejowa;
    
    --14
    procedure dodajTurniej(pNazwa varchar2, pNazwaWydarzenia varchar2,
                            pMiasto varchar2, pObiekt varchar2) is
    begin
        insert into turnieje values (pNazwa, pNazwaWydarzenia, pMiasto, pObiekt);
    end dodajTurniej;
    
    --15
    procedure dodajTypGry(pGatunek varchar2, pGatunekDodatkowy varchar2) is
    begin
        insert into typy_gry values (pGatunek, pGatunekDodatkowy);
    end dodajTypGry;
    
    --16
    procedure dodajWlascicielaGry(pImie varchar2, pNazwisko varchar2, pNazwaKlubu varchar2,
                                    pTytulGry varchar2, pKosztZakupu float) is
    begin
        insert into wlasciciele_gry values (pImie, pNazwisko, pNazwaKlubu,
                                            pTytulGry, pKosztZakupu);
    end dodajWlascicielaGry;
    
    --17
    procedure dodajWydarzenie(pNazwa varchar2, pOrganizator varchar2) is
    begin
        insert into wydarzenia values (pNazwa, pOrganizator);
    end dodajWydarzenie;
    
--DELETE
    --1
    procedure usunAutoraGry(pImie varchar2, pNazwisko varchar2) is
    begin
        delete from autorzy_gry where imie = pImie and nazwisko = pNazwisko;
        
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exNazwaNieIstnieje;
        end if;
    exception
        when exNazwaNieIstnieje then
            dbms_output.put_line('Podane imie i nazwisko autora gry nie istnieja');
    end usunAutoraGry;
    
    --2
    procedure usunCzlonkaKlubu(pIdCzlonka number) is
    begin
        delete from czlonkowie_klubu where czlonek_id = pIdCzlonka;
        
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exIdNieIstnieje;
        end if;
    exception
        when exIdNieIstnieje then
            dbms_output.put_line('Podane id czlonka klubu nie istnieje');
    end usunCzlonkaKlubu;
    
    --3
    procedure usunDodatek(pPodtytul varchar2) is
    begin
        delete from dodatki where podtytul = pPodtytul;
        
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exNazwaNieIstnieje;
        end if;
    exception
        when exNazwaNieIstnieje then
            dbms_output.put_line('Podany tytul dodatku nie istnieje');
    end usunDodatek;
    
    --4
    procedure usunOceneGracza(pOcena number, pTytulGry varchar2, 
                                pImie varchar2, pNazwisko varchar2) is
    begin
        delete from gracz_gry_oceny where ocena = pOcena and gry_tytul = pTytulGry
                                        and gracze_imie = pImie and gracze_nazwisko = pNazwisko;
                                            
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exNazwaNieIstnieje;
        end if;
    exception
        when exNazwaNieIstnieje then
            dbms_output.put_line('Podana ocena gry nie istnieje');
    end usunOceneGracza;
    
    --5
    procedure usunGracza(pImie varchar2, pNazwisko varchar2) is
    begin
        delete from gracze where imie = pImie and nazwisko = pNazwisko;
        
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exNazwaNieIstnieje;
        end if;
    exception
        when exNazwaNieIstnieje then
            dbms_output.put_line('Podane imie i nazwisko gracza nie istnieja');
    end usunGracza;
     
     --6
     procedure usunGre(pTytul varchar2) is
     begin
        delete from gry where tytul = pTytul;
        
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exNazwaNieIstnieje;
        end if;
    exception
        when exNazwaNieIstnieje then
            dbms_output.put_line('Podany tytul gry nie istnieje');
     end usunGre;
     
     --7
     procedure usunKlub(pNazwa varchar2) is
     begin
        delete from kluby where nazwa = pNazwa;
        
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exNazwaNieIstnieje;
        end if;
    exception
        when exNazwaNieIstnieje then
            dbms_output.put_line('Podana nazwa klubu nie istnieje');
     end usunKlub;
     
     --8
     procedure usunLokalizacje(pMiasto varchar2, pObiekt varchar2) is
     begin
        delete from lokalizacje where miasto = pMiasto and obiekt = pObiekt;
        
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exNazwaNieIstnieje;
        end if;
    exception
        when exNazwaNieIstnieje then
            dbms_output.put_line('Podana lokalizacja nie istnieje');
     end usunLokalizacje;
     
     --9
     procedure usunPatrona(pNazwa varchar2) is
     begin
        delete from patroni_medialni where nazwa = pNazwa;
        
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exNazwaNieIstnieje;
        end if;
    exception
        when exNazwaNieIstnieje then
            dbms_output.put_line('Podana nazwa patrona medialnego nie istnieje');
     end usunPatrona;
     
     --10
    procedure usunPatronaWydarzenia(pNazwaWydarzenia varchar2, pNazwaPatrona varchar2) is
    begin
        delete from patroni_wydarzenia where wydarzenia_nazwa = pNazwaWydarzenia
                                            and patroni_medialni_nazwa = pNazwaPatrona;
        
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exNazwaNieIstnieje;
        end if;
    exception
        when exNazwaNieIstnieje then
            dbms_output.put_line('Podana nazwa patrona wydarzenia nie istnieje');
    end usunPatronaWydarzenia;
    
    --14
    procedure usunTurniej(pNazwa varchar2) is
    begin
        delete from turnieje where nazwa = pNazwa;
        
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exNazwaNieIstnieje;
        end if;
    exception
        when exNazwaNieIstnieje then
            dbms_output.put_line('Podana nazwa turnieju nie istnieje');
    end usunTurniej;

    --15
    procedure usunTypGry(pGatunek varchar2) is
    begin
        delete from typy_gry where gatunek = pGatunek;
        
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exNazwaNieIstnieje;
        end if;
    exception
        when exNazwaNieIstnieje then
            dbms_output.put_line('Podana nazwa typu gry nie istnieje');
    end usunTypGry;
    
    --16
    procedure usunWlascicielaGry(pImie varchar2, pNazwisko varchar2) is
    begin
        delete from wlasciciele_gry where gracze_imie = pImie and gracze_nazwisko = pNazwisko;
        
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exNazwaNieIstnieje;
        end if;
    exception
        when exNazwaNieIstnieje then
            dbms_output.put_line('Podane imie i nazwisko wlasciciela gry nie istnieje');
    end usunWlascicielaGry;
    
    --17
    procedure usunWydarzenie(pNazwa varchar2) is
    begin
        delete from wydarzenia where nazwa = pNazwa;
        
        if sql%notfound then
            dbms_output.put_line('Nie usunieto zadnego rekordu');
            raise exNazwaNieIstnieje;
        end if;
    exception
        when exNazwaNieIstnieje then
            dbms_output.put_line('Podana nazwa wydarzenia gry nie istnieje');
    end usunWydarzenie;
end zarzadzanie;
