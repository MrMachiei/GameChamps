
------------------------------------------------------------------------
---------------------DODAWANIE +  USUWANIE REKORDOW---------------------
------------------------------------------------------------------------

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

------------------------------------------------------------------------
---------------------------MODYFIKACJA DANYCH---------------------------
------------------------------------------------------------------------

create or replace package modyfikuj is
    --------------------------------------------------------------------
    procedure autor(stareImie       in varchar2, 
                    stareNazwisko   in varchar2,
                    noweImie        in varchar2 default null, 
                    noweNazwisko    in varchar2 default null);
    --------------------------------------------------------------------
    procedure typ_gry(staryGatunek  in varchar2,
                      nowyGatunek   in varchar2,
                      nowyGatunekDodatkowy in varchar2);
    --------------------------------------------------------------------
    procedure gra(staraNazwa         in varchar2,
                  nowaNazwa          in varchar2 default null,
                  noweImieAutora     in varchar2 default null,
                  noweNazwiskoAutora in varchar2 default null,
                  nowyGatunekGry     in varchar2 default null);
    --------------------------------------------------------------------
    procedure dodatek(staryPodtytul  in varchar2,
                      staryTytulGry  in varchar2,
                      nowyPodtytul   in varchar2 default null,
                      nowyTytulGry   in varchar2 default null);
    --------------------------------------------------------------------
    procedure ocenaGry(imieGracza     in varchar2, 
                       nazwiskoGracza in varchar2,
                       tytulGry       in varchar2, 
                       nowaOcena      in natural);
    --------------------------------------------------------------------
    procedure rozgrywkaWygrany( idRozgrywki     in number, 
                                nowyWygrywajacy in varchar2);
    --------------------------------------------------------------------
    procedure rozgrywkaLokalizacja( idRozgrywki     in number, 
                                    nowaLokMiasto   in varchar2,
                                    nowaLokObiekt   in varchar2);
    --------------------------------------------------------------------
    procedure gracz(idGracza     in number, 
                    noweImie     in varchar2,
                    noweNazwisko in varchar2);
    --------------------------------------------------------------------
    procedure klub( idKlubu     in number,
                    nowaNazwa   in varchar2);
    --------------------------------------------------------------------
    procedure czlonekKlubu_rola( idCzlonka in number,
                                 nowaRola  in varchar2);
    --------------------------------------------------------------------
    procedure czlonekKlubu_data( idCzlonka in number,
                                 nowaData  in date);
    --------------------------------------------------------------------
    procedure lokalizacja(  stareMiasto in varchar2,
                            staryObiekt in varchar2,
                            noweMiasto  in varchar2 default null,
                            nowyObiekt  in varchar2 default null);
    --------------------------------------------------------------------
    procedure turniej( staraNazwa           in varchar2,
                       nowaNazwa            in varchar2,
                       nowaNazwaWydarzenia  in varchar2 default null,
                       nowaLokMiasto        in varchar2 default null,
                       nowaLokObiekt        in varchar2 default null);
    --------------------------------------------------------------------
    procedure wydarzenie( staraNazwa        in varchar2,
                          nowaNazwa         in varchar2,
                          nowyOrganizator   in varchar2 default null);
    --------------------------------------------------------------------
    procedure patronMedialny(staraNazwa in varchar2,
                             nowaNazwa  in varchar2);
    --------------------------------------------------------------------
end modyfikuj;

create or replace package body modyfikuj is
    --------------------------------------------------------------------
    procedure autor(stareImie       in varchar2, 
                    stareNazwisko   in varchar2,
                    noweImie        in varchar2 default null, 
                    noweNazwisko    in varchar2 default null) is
    begin
      update autorzy_gry
        set imie     = nvl(imie, noweImie),
            nazwisko = nvl(nazwisko, noweNazwisko)
        where imie like stareImie and nazwisko like stareNazwisko;
    end autor;
    --------------------------------------------------------------------
    procedure typ_gry(staryGatunek  in varchar2,
                      nowyGatunek   in varchar2,
                      nowyGatunekDodatkowy in varchar2) is
    begin
      update typy_gry
        set gatunek = nowyGatunek,
            gatunek_dodatkowy = nowyGatunekDodatkowy
        where gatunek like staryGatunek;
    end typ_gry;
    --------------------------------------------------------------------
    procedure gra(staraNazwa         in varchar2,
                  nowaNazwa          in varchar2 default null,
                  noweImieAutora     in varchar2 default null,
                  noweNazwiskoAutora in varchar2 default null,
                  nowyGatunekGry     in varchar2 default null) is
    begin
        update gry
            set tytul                = nvl(tytul, nowaNazwa),
                autorzy_gry_imie     = nvl(autorzy_gry_imie, noweImieAutora),
                autorzy_gry_nazwisko = nvl(autorzy_gry_nazwisko, noweNazwiskoAutora),
                typy_gry_gatunek     = nvl(typy_gry_gatunek, nowyGatunekGry)
            where tytul like staraNazwa;
    end gra;
    --------------------------------------------------------------------
    procedure dodatek(staryPodtytul  in varchar2,
                      staryTytulGry  in varchar2,
                      nowyPodtytul   in varchar2 default null,
                      nowyTytulGry   in varchar2 default null) is
    begin
      update dodatki
        set podtytul  = nvl(podtytul, nowyPodtytul),
            gry_tytul = nvl(gry_tytul, nowyTytulGry)
        where podtytul like staryPodtytul and gry_tytul like staryTytulGry;
    end dodatek;
    --------------------------------------------------------------------
    procedure ocenaGry(imieGracza     in varchar2, 
                       nazwiskoGracza in varchar2,
                       tytulGry       in varchar2, 
                       nowaOcena      in natural) is
    begin
        update gracz_gry_oceny
            set ocena = nowaOcena
        where   gry_tytul like tytulGry and
                gracze_imie like imieGracza and
                gracze_nazwisko like nazwiskoGracza;
    end ocenaGry;
    --------------------------------------------------------------------
    procedure rozgrywkaWygrany( idRozgrywki     in number, 
                                nowyWygrywajacy in varchar2) is
    begin
        update rozgrywki
            set wygrywajacy_gracz = nowyWygrywajacy
        where rozgrywka_id = idRozgrywki;
    end rozgrywkaWygrany;
    --------------------------------------------------------------------
    procedure rozgrywkaLokalizacja( idRozgrywki     in number, 
                                    nowaLokMiasto   in varchar2,
                                    nowaLokObiekt   in varchar2) is
    begin
        update rozgrywki
            set lokalizacje_miasto = nowaLokMiasto,
                lokalizacje_obiekt = nowaLokObiekt
        where rozgrywka_id = idRozgrywki;
    end rozgrywkaLokalizacja;
    --------------------------------------------------------------------
    procedure gracz(idGracza     in number, 
                    noweImie     in varchar2,
                    noweNazwisko in varchar2) is
    begin
        update gracze
            set imie     = noweImie,
                nazwisko = noweNazwisko
        where gracz_id = idGracza;
    end gracz;
    --------------------------------------------------------------------
    procedure klub( idKlubu     in number,
                    nowaNazwa   in varchar2) is
    begin
        update kluby
            set nazwa = nowaNazwa
        where klub_id = idKlubu;
    end klub;
    --------------------------------------------------------------------
    procedure czlonekKlubu_rola( idCzlonka in number,
                                 nowaRola in varchar2) is
    begin
        update czlonkowie_klubu
            set rola = nowaRola
        where czlonek_id = idCzlonka;
    end czlonekKlubu_rola;
    --------------------------------------------------------------------
    procedure czlonekKlubu_data( idCzlonka in number,
                                 nowaData  in date) is
    begin
        update czlonkowie_klubu
            set data_dolaczenia = nowaData
        where czlonek_id = idCzlonka;
    end czlonekKlubu_data;
    --------------------------------------------------------------------
    procedure lokalizacja(  stareMiasto in varchar2,
                            staryObiekt in varchar2,
                            noweMiasto  in varchar2 default null,
                            nowyObiekt  in varchar2 default null) is
    begin
        update lokalizacje
            set miasto = nvl(miasto, noweMiasto),
                obiekt = nvl(obiekt, nowyObiekt)
        where miasto like stareMiasto and obiekt like staryObiekt;
    end lokalizacja;
    --------------------------------------------------------------------
    procedure turniej( staraNazwa           in varchar2,
                       nowaNazwa            in varchar2,
                       nowaNazwaWydarzenia  in varchar2 default null,
                       nowaLokMiasto        in varchar2 default null,
                       nowaLokObiekt        in varchar2 default null) is
    begin
        update turnieje
            set nazwa               = nowaNazwa,
                wydarzenia_nazwa    = nvl(wydarzenia_nazwa, nowaNazwaWydarzenia),
                lokalizacje_miasto  = nvl(lokalizacje_miasto, nowaLokMiasto),
                lokalizacje_obiekt  = nvl(lokalizacje_obiekt, nowaLokObiekt)
        where nazwa like staraNazwa;
    end turniej;
    --------------------------------------------------------------------
    procedure wydarzenie( staraNazwa        in varchar2,
                          nowaNazwa         in varchar2,
                          nowyOrganizator   in varchar2 default null) is
    begin
        update wydarzenia
            set nazwa       = nowaNazwa,
                organizator = nvl(organizator, nowyOrganizator)
        where nazwa like staraNazwa;
    end wydarzenie;
    --------------------------------------------------------------------
    procedure patronMedialny(staraNazwa in varchar2,
                             nowaNazwa  in varchar2) is
    begin
        update patroni_medialni
            set nazwa = nowaNazwa
        where nazwa like staraNazwa;
    end patronMedialny;
    -------------------------------------------------------------------- 
end modyfikuj;

------------------------------------------------------------------------
------------------------------------------------------------------------

create or replace package udzial is
    -- procent gier rozegranych ze wszystkich posiadanych
    function rozegrane_w_posiadanych(imieGracza      varchar2,
                                     nazwiskoGracza  varchar2)
        return number;

    -- procent eventow, w ktorych gracz bral udzial
    function eventy(imieGracza      varchar2,
                    nazwiskoGracza  varchar2)
        return number;
end udzial;

------------------------------------------------------------------------
-----------------------FUNKCJE LICZACE STATYSTYKI-----------------------
------------------------------------------------------------------------

create or replace package body udzial is
    -- procent gier rozegranych ze wszystkich posiadanych
    function rozegrane_w_posiadanych(imieGracza      varchar2,
                                     nazwiskoGracza  varchar2)
        return number
    is 
        procentRozegranych number(4, 2);
        iloscPosiadanych natural;
        iloscRozeganych natural;
    begin
        select count(*)
            into iloscPosiadanych
        from wlasciciele_gry
        where gracze_imie like imieGracza and gracze_nazwisko like nazwiskoGracza;

        select count(*)
            into iloscRozeganych
        from rozgrywki
        where   (gracze_imie  like imieGracza and gracze_nazwisko  like nazwiskoGracza) or 
                (gracze_imie1 like imieGracza and gracze_nazwisko1 like nazwiskoGracza);

        if iloscPosiadanych = 0 then
            return 0;
        else
            return round(iloscRozeganych / iloscPosiadanych * 100, 2);
        end if; 
    end rozegrane_w_posiadanych;

    -- procent wydarzen, w ktorych gracz bral udzial
    function wydarzenia(imieGracza      varchar2,
                        nazwiskoGracza  varchar2)
        return number
    is 
        procentWydarzen number(4, 2);
        iloscUdzial     natural;
        iloscWszystkich natural;
    begin
        select count(*)
            into iloscWszystkich
        from wydarzenia;

        select count(*)
            into iloscUdzial
        from rozgrywka_gracze_role
            where imie_gracza like imieGracza and nazwisko_gracza like nazwiskoGracza;

        if iloscUdzial = 0 then
            return 0;
        else
            return round(iloscWszystkich / iloscUdzial * 100, 2);
        end if;
    end wydarzenia;
end udzial;

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
