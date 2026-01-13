-- =========================================================
-- LaCantina FULL RESET (phpMyAdmin ready)
-- Drops + creates DB and tables + inserts seed data
-- =========================================================

SET FOREIGN_KEY_CHECKS = 0;

-- (Opzionale ma consigliato)
CREATE DATABASE IF NOT EXISTS LaCantina
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_general_ci;

USE LaCantina;

-- =========================================================
-- TABLE: fornitori
-- =========================================================
DROP TABLE IF EXISTS fornitori;
CREATE TABLE fornitori (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(450) NOT NULL,
  citta VARCHAR(450) NOT NULL,
  provincia VARCHAR(450) NOT NULL,
  indirizzo VARCHAR(450) NOT NULL,
  anno_nascita INT NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO fornitori (id, nome, citta, provincia, indirizzo, anno_nascita) VALUES
(1,'LemonGroup','Amalfi','Salerno','via Campagna n.11',1860),
(2,'AnticoUliveto','Trentinara','Salerno','via Campagna n.11',1920),
(3,'AnticoVinaio','CastelFranco in Miscano','Salerno','via Campagna n.12',1940);

-- =========================================================
-- TABLE: utenti
-- =========================================================
DROP TABLE IF EXISTS utenti;
CREATE TABLE utenti (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  password VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY email_UNIQUE (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO utenti (id, nome, email, password) VALUES
(1,'gabriele','gabriele.cicalese2004@gmail.com','1234'),
(2,'admin','admin@lacantina.it','1234'),
(3,'FarbizioGrazioso','fabrizio.grazioso@gmail.com','1234');

-- =========================================================
-- TABLE: prodotti
-- =========================================================
DROP TABLE IF EXISTS prodotti;
CREATE TABLE prodotti (
  id INT NOT NULL AUTO_INCREMENT,
  id_fornitore INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  descrizione LONGTEXT NOT NULL,
  categoria VARCHAR(200) NOT NULL,
  stock INT NOT NULL,
  prezzo DOUBLE NOT NULL,
  immagine VARCHAR(45) NOT NULL,
  stato VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  KEY id_fornitore (id_fornitore),
  CONSTRAINT prodotti_ibfk_1
    FOREIGN KEY (id_fornitore) REFERENCES fornitori (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO prodotti (id, id_fornitore, nome, descrizione, categoria, stock, prezzo, immagine, stato) VALUES
(12,2,'olio extravergine d''oliva 500ml','Bottiglia in vetro di olio extravergine d''oliva da 500ml lavorato presso il frantoio LaCantina','olio-extravergine-oliva',47,11,'olioEVO1L.png','attivo'),
(13,3,'vino rosso 500ml','Bottiglia in vetro di vino rosso del Beneventano da 500ml lavorato presso LaCantina','vino-rosso',32,11,'vinoRosso.png','attivo'),
(14,3,'vino bianco 500ml','Bottiglia in vetro di vino bianco del Beneventano da 500ml lavorato presso LaCantina','vino-bianco',28,8,'vinoBianco.png','attivo'),
(15,2,'Limoncello  500ml','Bottiglia in vetro di limoncello di Amalfi da 500ml lavorato presso LaCantina','limoncello',36,8,'limoncello.png','attivo'),
(16,2,'olio extravergine d''oliva 1L','Bottiglia in vetro di olio extravergine d''oliva da 500ml lavorato presso il frantoio LaCantina','olio-extravergine-oliva',5,20,'olioEVO1L.png','attivo'),
(17,1,'d','d','olio-extravergine-oliva',2,2,'s.jpg','inattivo');

-- =========================================================
-- TABLE: riga_ordini
-- =========================================================
DROP TABLE IF EXISTS riga_ordini;
CREATE TABLE riga_ordini (
  id INT NOT NULL AUTO_INCREMENT,
  numero_ordini INT NOT NULL,
  prezzo_totale FLOAT NOT NULL,
  stato_ordine VARCHAR(50) NOT NULL,
  indirizzo VARCHAR(450) NOT NULL,
  cap VARCHAR(5) NOT NULL,
  citta VARCHAR(450) NOT NULL,
  provincia VARCHAR(450) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO riga_ordini (id, numero_ordini, prezzo_totale, stato_ordine, indirizzo, cap, citta, provincia) VALUES
(14,3,60,'attesa di conferma','312312','12122','123121','2131'),
(15,1,20,'attesa di conferma','32423','4242','424','242'),
(16,1,20,'annullato','2423','42424','24242','24242'),
(17,1,30,'attesa di conferma','q','532','q','q'),
(18,1,10,'attesa di conferma','393939393939393939','84016','Nocera Superiore','Salerno'),
(19,2,120,'attesa di conferma','3333333','3','3','3'),
(20,2,40,'attesa di conferma','s','s','s','SALIERN'),
(21,2,60,'attesa di conferma','w','2','2','2'),
(22,2,120,'attesa di conferma','2','2','2','2'),
(23,1,10,'attesa di conferma','1','12312','1212','1'),
(24,2,40,'attesa di conferma','423423','3','3','3'),
(25,1,10,'attesa di conferma','1234567890212345','12345','nocera supoeriore','mialo'),
(26,2,30,'preso in carico','Via Giovanni nicotera, 17','12341','nocera','salerno');

-- =========================================================
-- TABLE: ordini
-- =========================================================
DROP TABLE IF EXISTS ordini;
CREATE TABLE ordini (
  id INT NOT NULL AUTO_INCREMENT,
  id_utente INT NOT NULL,
  id_prodotto INT NOT NULL,
  id_riga_ordine INT NOT NULL,
  quantity INT NOT NULL,
  prezzo_acquisto DOUBLE NOT NULL,
  data_ordine VARCHAR(450) NOT NULL,
  PRIMARY KEY (id),
  KEY id_utente (id_utente),
  KEY id_prodotto (id_prodotto),
  KEY id_riga_ordine (id_riga_ordine),
  CONSTRAINT ordini_ibfk_1
    FOREIGN KEY (id_utente) REFERENCES utenti (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT ordini_ibfk_2
    FOREIGN KEY (id_prodotto) REFERENCES prodotti (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT ordini_ibfk_3
    FOREIGN KEY (id_riga_ordine) REFERENCES riga_ordini (id)
    ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO ordini (id, id_utente, id_prodotto, id_riga_ordine, quantity, prezzo_acquisto, data_ordine) VALUES
(25,1,13,14,2,20,'03/01/2026'),
(26,1,14,14,2,20,'03/01/2026'),
(41,1,14,24,2,20,'10/01/2026'),
(42,1,15,24,2,20,'10/01/2026'),
(43,1,14,25,1,10,'10/01/2026'),
(44,1,14,26,2,20,'10/01/2026'),
(45,1,15,26,1,10,'10/01/2026');

SET FOREIGN_KEY_CHECKS = 1;
