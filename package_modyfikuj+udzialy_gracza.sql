

------------------------------------------------------------------------
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

------------------------------------------------------------------------
------------------------------------------------------------------------

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

------------------------------------------------------------------------
------------------------------------------------------------------------