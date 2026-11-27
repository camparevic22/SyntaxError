7CREATE TABLE staniste (
    idStaniste BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    naziv VARCHAR(30) NOT NULL UNIQUE,
    tipStanista TEXT NOT NULL,
    opis TEXT NOT NULL,
    geografskaSirina DOUBLE PRECISION NOT NULL,
    geografskaDuzina DOUBLE PRECISION NOT NULL,
    povrsina DOUBLE PRECISION NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dron (
    dronId BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    model VARCHAR(50) NOT NULL UNIQUE,
    proizvodjac TEXT NOT NULL,
    datumNabavke DATE NOT NULL,
    status INTEGER NOT NULL
);

CREATE TABLE korisnik (
    idKorisnika BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ime TEXT NOT NULL,
    prezime TEXT NOT NULL,
    mail TEXT NOT NULL UNIQUE,
    korisnickoIme TEXT NOT NULL UNIQUE,
    lozinka TEXT NOT NULL,
    uloga TEXT NOT NULL
);

CREATE TABLE misija (
    idMisije BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    naziv TEXT NOT NULL,
    datum DATE NOT NULL,
    vremePocetka TIME NOT NULL,
    vremeZavrsetka TIME NOT NULL,
    visinaLeta DOUBLE PRECISION NOT NULL,
    status INTEGER NOT NULL,
    stanisteId BIGINT NOT NULL REFERENCES staniste(idStaniste),
    dronId BIGINT NOT NULL REFERENCES dron(dronId),
    korisnikId BIGINT NOT NULL REFERENCES korisnik(idKorisnika)
);

CREATE TABLE snimak (
    idSnimak BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nazivFajla TEXT NOT NULL,
    putanjaFajla TEXT NOT NULL,
    datumSnimanja DATE NOT NULL,
    vremeSnimanja TIME NOT NULL,
    geografskaSirina DOUBLE PRECISION NOT NULL,
    geografskaDuzina DOUBLE PRECISION NOT NULL,
    nadmorskaVisina DOUBLE PRECISION,
    misijaId BIGINT NOT NULL REFERENCES misija(idMisije)
);

CREATE TABLE prijava (
    idPrijava BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    naslov TEXT NOT NULL,
    opis TEXT NOT NULL,
    datumPrijave TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    geografskaSirina DOUBLE PRECISION NOT NULL,
    geografskaDuzina DOUBLE PRECISION NOT NULL,
    status INTEGER NOT NULL,
    korisnikId BIGINT NOT NULL REFERENCES korisnik(idKorisnika)
);

CREATE TABLE analiza (
    idAnaliza BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    datumAnalize TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipPromene TEXT NOT NULL,
    opisRezultata TEXT NOT NULL,
    nivoPouzdanosti DOUBLE PRECISION,
    snimakId BIGINT NOT NULL REFERENCES snimak(idSnimak),
    korisnikId BIGINT REFERENCES korisnik(idKorisnika)
);

CREATE TABLE zadatak (
    idZadatak BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    naziv TEXT NOT NULL,
    opis TEXT NOT NULL,
    prioritet INTEGER NOT NULL,
    status INTEGER NOT NULL,
    datumKreiranja TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    rok DATE,
    analizaId BIGINT REFERENCES analiza(idAnaliza),
    korisnikId BIGINT REFERENCES korisnik(idKorisnika)
);

CREATE TABLE izvestaj (
    idIzvestaj BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    datumIzrade TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    naslov TEXT NOT NULL,
    sadrzaj TEXT NOT NULL,
    stanisteId BIGINT NOT NULL REFERENCES staniste(idStaniste),
    korisnikId BIGINT NOT NULL REFERENCES korisnik(idKorisnika)
);