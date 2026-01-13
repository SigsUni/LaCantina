SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS ordini;
DROP TABLE IF EXISTS riga_ordini;
DROP TABLE IF EXISTS prodotti;
DROP TABLE IF EXISTS fornitori;
DROP TABLE IF EXISTS utenti;

CREATE TABLE fornitori (
  id int NOT NULL AUTO_INCREMENT,
  nome varchar(450) NOT NULL,
  citta varchar(450) NOT NULL,
  provincia varchar(450) NOT NULL,
  indirizzo varchar(450) NOT NULL,
  anno_nascita int NOT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE fornitori AUTO_INCREMENT = 1;

CREATE TABLE utenti (
  id int NOT NULL AUTO_INCREMENT,
  nome varchar(45) NOT NULL,
  email varchar(45) NOT NULL,
  password varchar(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY email_UNIQUE (email)
);

ALTER TABLE utenti AUTO_INCREMENT = 1;

CREATE TABLE prodotti (
  id int NOT NULL AUTO_INCREMENT,
  id_fornitore int NOT NULL,
  nome varchar(45) NOT NULL,
  descrizione longtext NOT NULL,
  categoria varchar(200) NOT NULL,
  stock int NOT NULL,
  prezzo double NOT NULL,
  immagine varchar(45) NOT NULL,
  stato varchar(45) NOT NULL,
  PRIMARY KEY (id),
  KEY id_fornitore (id_fornitore),
  CONSTRAINT prodotti_ibfk_1 FOREIGN KEY (id_fornitore) REFERENCES fornitori (id)
);

ALTER TABLE prodotti  AUTO_INCREMENT = 12;

CREATE TABLE riga_ordini (
  id int NOT NULL AUTO_INCREMENT,
  numero_ordini int NOT NULL,
  prezzo_totale float NOT NULL,
  stato_ordine varchar(50) NOT NULL,
  indirizzo varchar(450) NOT NULL,
  cap varchar(5) NOT NULL,
  citta varchar(450) NOT NULL,
  provincia varchar(450) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE ordini (
  id int NOT NULL AUTO_INCREMENT,
  id_utente int NOT NULL,
  id_prodotto int NOT NULL,
  id_riga_ordine int NOT NULL,
  quantity int NOT NULL,
  prezzo_acquisto double NOT NULL,
  data_ordine varchar(450) NOT NULL,
  PRIMARY KEY (id),
  KEY id_utente (id_utente),
  KEY id_prodotto (id_prodotto),
  KEY id_riga_ordine (id_riga_ordine),
  CONSTRAINT ordini_ibfk_1 FOREIGN KEY (id_utente) REFERENCES utenti (id),
  CONSTRAINT ordini_ibfk_2 FOREIGN KEY (id_prodotto) REFERENCES prodotti (id),
  CONSTRAINT ordini_ibfk_3 FOREIGN KEY (id_riga_ordine) REFERENCES riga_ordini (id)
);

INSERT INTO fornitori(id,nome,citta,provincia,indirizzo,anno_nascita) VALUES
(1,'LemonGroup','Amalfi','Salerno','via Campagna 11',1860),
(2,'AnticoUliveto','Trentinara','Salerno','via Campagna 11',1920),
(3,'AnticoVinaio','CastelFranco in Miscano','Salerno','via Campagna 12',1940);


-- dopo CREATE TABLE utenti ...


-- Inserimento deterministico (ID fissi)
INSERT INTO utenti (id, nome, email, password) VALUES
(1,'gabriele','gabriele.cicalese2004@gmail.com','1234'),
(2,'admin','admin@lacantina.it','1234');


INSERT INTO prodotti(id,id_fornitore,nome,descrizione,categoria,stock,prezzo,immagine,stato) VALUES
(12,2,'olio EVO 500ml','desc','olio-extravergine-oliva',50,11,'olio.png','attivo'),
(13,3,'vino rosso 500ml','desc','vino-rosso',30,11,'vino.png','attivo'),
(14,3,'vino bianco 500ml','desc','vino-bianco',28,8,'vinoB.png','attivo');

SET FOREIGN_KEY_CHECKS=1;
