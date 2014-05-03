
CREATE TABLE adottanti (
    id integer DEFAULT nextval(('adozioniid')) NOT NULL,
    idanagrafe integer NOT NULL,
    idbambino integer NOT NULL,
    anno integer NOT NULL,
    p1 integer DEFAULT 0 NOT NULL,
    p2 integer DEFAULT 0 NOT NULL,
    p3 integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 1260 (class 1259 OID 35976)
-- Dependencies: 1637 1638 5
-- Name: anagrafe; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE anagrafe (
    id integer DEFAULT nextval(('anagrafeid')) NOT NULL,
    nome character varying(40) NOT NULL,
    indirizzo character varying(60) NOT NULL,
    cap character varying(10) NOT NULL,
    citta character varying(60) NOT NULL,
    nazione character varying(30) NOT NULL,
    telefono character varying(25),
    cellulare character varying(25),
    email character varying(30),
    codfiscale character varying(25),
    cognome character varying(50),
    posta boolean DEFAULT true
);


--
-- TOC entry 1268 (class 1259 OID 44317)
-- Dependencies: 1641 5
-- Name: bambino; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bambino (
    id integer DEFAULT nextval(('bambinoid')) NOT NULL,
    nome character varying(100) NOT NULL,
    sesso character varying(1) NOT NULL,
    indirizzo character varying(100),
    citta character varying(60),
    nazione character varying(70),
    datanascita date,
    scuola character varying(70),
    descrizione text
);


--
-- TOC entry 1259 (class 1259 OID 35974)
-- Dependencies: 5
-- Name: adozioniid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE adozioniid
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1762 (class 0 OID 0)
-- Dependencies: 1259
-- Name: adozioniid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('adozioniid', 20, true);


--
-- TOC entry 1257 (class 1259 OID 35970)
-- Dependencies: 5
-- Name: anagrafeid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE anagrafeid
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1763 (class 0 OID 0)
-- Dependencies: 1257
-- Name: anagrafeid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('anagrafeid', 388, true);


--
-- TOC entry 1245 (class 1259 OID 35888)
-- Dependencies: 1628 5
-- Name: anno; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE anno (
    anno integer NOT NULL,
    chiuso boolean DEFAULT false NOT NULL
);


--
-- TOC entry 1263 (class 1259 OID 36005)
-- Dependencies: 1639 5
-- Name: azionista; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE azionista (
    id integer DEFAULT nextval(('azionistaid')) NOT NULL,
    anno integer NOT NULL,
    importo integer NOT NULL,
    note text
);


--
-- TOC entry 1262 (class 1259 OID 36003)
-- Dependencies: 5
-- Name: azionistaid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE azionistaid
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1764 (class 0 OID 0)
-- Dependencies: 1262
-- Name: azionistaid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('azionistaid', 1, false);


--
-- TOC entry 1271 (class 1259 OID 52512)
-- Dependencies: 1646 5
-- Name: bambinoanno; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bambinoanno (
    id integer DEFAULT nextval(('bambinoannoid')) NOT NULL,
    idbambino integer NOT NULL,
    anno integer NOT NULL,
    note text,
    costo int4 NOT NULL DEFAULT 0
);


--
-- TOC entry 1273 (class 1259 OID 52539)
-- Dependencies: 1369 5
-- Name: bambiniliberi; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW bambiniliberi AS
    SELECT DISTINCT b.id, b.nome, b.sesso, b.citta, b.nazione, b.scuola, ba.anno, ba.costo
   FROM bambinoanno ba, bambino b, adottanti a
  WHERE b.id = ba.idbambino AND NOT (b.id IN ( SELECT adottanti.idbambino
           FROM adottanti
          WHERE adottanti.anno = ba.anno))
  ORDER BY b.id, b.nome, b.sesso, b.citta, b.nazione, b.scuola, ba.anno, ba.costo;


--
-- TOC entry 1272 (class 1259 OID 52519)
-- Dependencies: 5
-- Name: bambinoannoid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE bambinoannoid
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1765 (class 0 OID 0)
-- Dependencies: 1272
-- Name: bambinoannoid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('bambinoannoid', 22, true);


--
-- TOC entry 1274 (class 1259 OID 52557)
-- Dependencies: 1370 5
-- Name: bambinoannoview; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW bambinoannoview AS
    SELECT b.id, b.nome, b.sesso, b.indirizzo, b.citta, b.nazione, b.datanascita, b.scuola, b.descrizione, ba.anno, ba.costo
   FROM bambinoanno ba, bambino b
  WHERE ba.idbambino = b.id
  ORDER BY b.id;


--
-- TOC entry 1258 (class 1259 OID 35972)
-- Dependencies: 5
-- Name: bambinoid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE bambinoid
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1766 (class 0 OID 0)
-- Dependencies: 1258
-- Name: bambinoid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('bambinoid', 6, true);



--
-- TOC entry 1270 (class 1259 OID 52509)
-- Dependencies: 1368 5
-- Name: adottantiview; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW adottantiview AS
SELECT a.id, a.idanagrafe, an.cognome, an.nome, a.idbambino, b.nome AS nomebambino, a.anno, a.p1, a.p2, a.p3, ba.costo
   FROM anagrafe an, adottanti a, bambino b, bambinoanno ba
  WHERE an.id = a.idanagrafe AND b.id = a.idbambino AND ba.anno = a.anno AND ba.idbambino = a.idbambino;



--
-- TOC entry 1278 (class 1259 OID 60778)
-- Dependencies: 1647 5
-- Name: categorienews; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE categorienews (
    id integer DEFAULT nextval(('categorienewsid')) NOT NULL,
    nome character varying(50),
    descrizione text
);


--
-- TOC entry 1277 (class 1259 OID 60776)
-- Dependencies: 5
-- Name: categorienewsid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categorienewsid
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1767 (class 0 OID 0)
-- Dependencies: 1277
-- Name: categorienewsid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categorienewsid', 2, true);


--
-- TOC entry 1246 (class 1259 OID 35891)
-- Dependencies: 1629 1630 5
-- Name: conto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE conto (
    id integer DEFAULT nextval(('contoid')) NOT NULL,
    gruppo integer,
    nome character varying(100) NOT NULL,
    mostra boolean DEFAULT true
);


--
-- TOC entry 1247 (class 1259 OID 35895)
-- Dependencies: 1631 5
-- Name: gruppo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gruppo (
    id integer DEFAULT nextval(('gruppoid')) NOT NULL,
    tipo smallint NOT NULL,
    nome character varying(100) NOT NULL
);


--
-- TOC entry 1248 (class 1259 OID 35898)
-- Dependencies: 1364 5
-- Name: contogruppo; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW contogruppo AS
    SELECT c.id, c.nome AS nomeconto, c.gruppo, g.nome AS nomegruppo, g.tipo, c.mostra FROM conto c, gruppo g WHERE (c.gruppo = g.id) ORDER BY g.tipo, c.gruppo, c.id;


--
-- TOC entry 1249 (class 1259 OID 35901)
-- Dependencies: 5
-- Name: contoid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contoid
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1768 (class 0 OID 0)
-- Dependencies: 1249
-- Name: contoid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('contoid', 14, true);


--
-- TOC entry 1296 (class 1259 OID 60895)
-- Dependencies: 1655 5
-- Name: download; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE download (
    id integer DEFAULT nextval(('downloadid')) NOT NULL,
    nome character varying(100) NOT NULL,
    src character varying(100) NOT NULL,
    idnews integer NOT NULL,
    idtipofile integer NOT NULL
);


--
-- TOC entry 1290 (class 1259 OID 60855)
-- Dependencies: 5
-- Name: downloadid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE downloadid
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1769 (class 0 OID 0)
-- Dependencies: 1290
-- Name: downloadid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('downloadid', 1, false);


--
-- TOC entry 1295 (class 1259 OID 60885)
-- Dependencies: 1654 5
-- Name: eventi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE eventi (
    id integer DEFAULT nextval(('eventiid')) NOT NULL,
    titolo character varying(200) NOT NULL,
    luogo character varying(200) NOT NULL,
    data date NOT NULL,
    idnews integer NOT NULL,
    ora character varying(100) NOT NULL
);


--
-- TOC entry 1284 (class 1259 OID 60843)
-- Dependencies: 5
-- Name: eventiid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE eventiid
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1770 (class 0 OID 0)
-- Dependencies: 1284
-- Name: eventiid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('eventiid', 1, false);


--
-- TOC entry 1275 (class 1259 OID 60758)
-- Dependencies: 5
-- Name: famiglia; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE famiglia (
    id1 integer NOT NULL,
    id2 integer NOT NULL
);


--
-- TOC entry 1250 (class 1259 OID 35903)
-- Dependencies: 1632 1633 1634 5
-- Name: scrittura; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE scrittura (
    id integer DEFAULT nextval(('scritturaid')) NOT NULL,
    data date NOT NULL,
    descrizione text,
    importo real NOT NULL,
    automatico boolean DEFAULT false,
    dare integer NOT NULL,
    avere integer NOT NULL,
    anno integer DEFAULT 2002
);


--
-- TOC entry 1251 (class 1259 OID 35911)
-- Dependencies: 1365 5
-- Name: gruppibloccati; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW gruppibloccati AS
    SELECT DISTINCT g.id FROM gruppo g, conto c, scrittura s WHERE ((g.id = c.gruppo) AND ((c.id = s.dare) OR (c.id = s.avere))) ORDER BY g.id;


--
-- TOC entry 1252 (class 1259 OID 35914)
-- Dependencies: 5
-- Name: gruppoid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE gruppoid
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1771 (class 0 OID 0)
-- Dependencies: 1252
-- Name: gruppoid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('gruppoid', 8, true);


--
-- TOC entry 1294 (class 1259 OID 60866)
-- Dependencies: 1653 5
-- Name: high; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE high (
    id integer DEFAULT nextval(('highid')) NOT NULL,
    data date NOT NULL,
    testo text NOT NULL,
    idnews integer NOT NULL,
    visibile integer NOT NULL
);


--
-- TOC entry 1285 (class 1259 OID 60845)
-- Dependencies: 5
-- Name: highid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE highid
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1772 (class 0 OID 0)
-- Dependencies: 1285
-- Name: highid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('highid', 1, false);


--
-- TOC entry 1282 (class 1259 OID 60824)
-- Dependencies: 1649 5
-- Name: immagini; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE immagini (
    id integer DEFAULT nextval(('immaginiid')) NOT NULL,
    nome character varying(40) NOT NULL,
    img character varying(80) NOT NULL,
    imggrande character varying(80),
    tipo integer
);


--
-- TOC entry 1281 (class 1259 OID 60822)
-- Dependencies: 5
-- Name: immaginiid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE immaginiid
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1773 (class 0 OID 0)
-- Dependencies: 1281
-- Name: immaginiid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('immaginiid', 1, false);


--
-- TOC entry 1253 (class 1259 OID 35916)
-- Dependencies: 5
-- Name: movid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE movid
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1774 (class 0 OID 0)
-- Dependencies: 1253
-- Name: movid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('movid', 3, true);


--
-- TOC entry 1254 (class 1259 OID 35918)
-- Dependencies: 1635 5
-- Name: movimenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE movimenti (
    id integer DEFAULT nextval(('movid')) NOT NULL,
    descrizione text,
    dare integer NOT NULL,
    avere integer NOT NULL,
    nome character varying(100) NOT NULL
);


--
-- TOC entry 1280 (class 1259 OID 60787)
-- Dependencies: 1648 5
-- Name: news; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE news (
    id integer DEFAULT nextval(('newsid')) NOT NULL,
    titolo character varying(200) NOT NULL,
    sottotitolo text,
    testo text NOT NULL,
    tipo integer NOT NULL,
    data date NOT NULL,
    home character varying(10) NOT NULL,
    "user" character varying(20) NOT NULL
);


--
-- TOC entry 1279 (class 1259 OID 60785)
-- Dependencies: 5
-- Name: newsid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE newsid
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1775 (class 0 OID 0)
-- Dependencies: 1279
-- Name: newsid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('newsid', 1, false);


--
-- TOC entry 1283 (class 1259 OID 60829)
-- Dependencies: 5
-- Name: newsimg; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE newsimg (
    idnews integer NOT NULL,
    idimg integer NOT NULL
);


--
-- TOC entry 1293 (class 1259 OID 60863)
-- Dependencies: 1652 5
-- Name: newsletter; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE newsletter (
    id integer DEFAULT nextval(('newsletterid')) NOT NULL,
    email character varying(80) NOT NULL
);


--
-- TOC entry 1286 (class 1259 OID 60847)
-- Dependencies: 5
-- Name: newsletterid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE newsletterid
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1776 (class 0 OID 0)
-- Dependencies: 1286
-- Name: newsletterid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('newsletterid', 1, false);


--
-- TOC entry 1264 (class 1259 OID 36071)
-- Dependencies: 5
-- Name: socio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE socio (
    id integer NOT NULL,
    tessera integer NOT NULL,
    note text
);


--
-- TOC entry 1267 (class 1259 OID 36122)
-- Dependencies: 1367 5
-- Name: nonsoci; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW nonsoci AS
    SELECT a.id, a.cognome, a.nome, a.citta FROM anagrafe a WHERE (NOT (a.id IN (SELECT socio.id FROM socio)));


--
-- TOC entry 1265 (class 1259 OID 36090)
-- Dependencies: 1640 5
-- Name: pagamentosoci; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pagamentosoci (
    tessera integer NOT NULL,
    anno integer NOT NULL,
    importo integer NOT NULL,
    id integer DEFAULT nextval(('pagamentoid')) NOT NULL
);


--
-- TOC entry 1276 (class 1259 OID 60772)
-- Dependencies: 1371 5
-- Name: pagamenti; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW pagamenti AS
    SELECT p.id AS idp, a.id, a.nome, a.cognome, a.indirizzo, a.cap, a.citta, a.nazione, a.email, a.telefono, a.codfiscale, s.tessera, p.anno, p.importo, s.note, a.posta FROM anagrafe a, socio s, pagamentosoci p WHERE ((a.id = s.id) AND (s.tessera = p.tessera));


--
-- TOC entry 1261 (class 1259 OID 35991)
-- Dependencies: 5
-- Name: pagamentoid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pagamentoid
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1777 (class 0 OID 0)
-- Dependencies: 1261
-- Name: pagamentoid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pagamentoid', 341, true);


--
-- TOC entry 1297 (class 1259 OID 60910)
-- Dependencies: 1656 5
-- Name: progetti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE progetti (
    id integer DEFAULT nextval(('progettiid')) NOT NULL,
    titolo character varying(150) NOT NULL,
    sottotitolo character varying(200) NOT NULL,
    testo text NOT NULL,
    inizio character varying(30) NOT NULL,
    fine character varying(30) NOT NULL,
    luogo character varying(40) NOT NULL,
    home character varying(10) NOT NULL,
    idregione integer NOT NULL,
    idimgluogo integer NOT NULL,
    realizzato integer NOT NULL
);


--
-- TOC entry 1287 (class 1259 OID 60849)
-- Dependencies: 5
-- Name: progettiid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE progettiid
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1778 (class 0 OID 0)
-- Dependencies: 1287
-- Name: progettiid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('progettiid', 1, false);


--
-- TOC entry 1298 (class 1259 OID 60928)
-- Dependencies: 5
-- Name: progettiimg; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE progettiimg (
    idprogetto integer NOT NULL,
    idimg integer NOT NULL
);


--
-- TOC entry 1291 (class 1259 OID 60857)
-- Dependencies: 1650 5
-- Name: regioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE regioni (
    id integer DEFAULT nextval(('regioniid')) NOT NULL,
    regione character varying(80) NOT NULL
);


--
-- TOC entry 1288 (class 1259 OID 60851)
-- Dependencies: 5
-- Name: regioniid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE regioniid
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1779 (class 0 OID 0)
-- Dependencies: 1288
-- Name: regioniid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('regioniid', 1, false);


--
-- TOC entry 1255 (class 1259 OID 35924)
-- Dependencies: 5
-- Name: scritturaid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE scritturaid
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1780 (class 0 OID 0)
-- Dependencies: 1255
-- Name: scritturaid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('scritturaid', 235, true);


--
-- TOC entry 1266 (class 1259 OID 36119)
-- Dependencies: 1366 5
-- Name: soci; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW soci AS
    SELECT a.id, a.nome, a.cognome, a.indirizzo, a.cap, a.citta, a.nazione, s.tessera FROM anagrafe a, socio s WHERE (a.id = s.id);


--
-- TOC entry 1292 (class 1259 OID 60860)
-- Dependencies: 1651 5
-- Name: tipofile; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipofile (
    id integer DEFAULT nextval(('tipofileid')) NOT NULL,
    tipo character varying(80) NOT NULL,
    estensione character varying(30) NOT NULL,
    icona character varying(100)
);


--
-- TOC entry 1289 (class 1259 OID 60853)
-- Dependencies: 5
-- Name: tipofileid; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipofileid
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 1781 (class 0 OID 0)
-- Dependencies: 1289
-- Name: tipofileid; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipofileid', 1, false);


--
-- TOC entry 1256 (class 1259 OID 35926)
-- Dependencies: 1636 5
-- Name: user; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "user" (
    username character varying(20) NOT NULL,
    "password" character varying(15) NOT NULL,
    tipo smallint DEFAULT 1 NOT NULL
);


--
-- TOC entry 1743 (class 0 OID 44326)
-- Dependencies: 1269
-- Data for Name: adottanti; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO adottanti (id, idanagrafe, idbambino, anno, p1, p2, p3) VALUES (13, 23, 2, 2005, 0, 120, 12);
INSERT INTO adottanti (id, idanagrafe, idbambino, anno, p1, p2, p3) VALUES (16, 337, 2, 2004, 890, 0, 1);
INSERT INTO adottanti (id, idanagrafe, idbambino, anno, p1, p2, p3) VALUES (18, 27, 2, 2006, 0, 70, 0);
INSERT INTO adottanti (id, idanagrafe, idbambino, anno, p1, p2, p3) VALUES (15, 106, 1, 2006, 3000, 300, 60);
INSERT INTO adottanti (id, idanagrafe, idbambino, anno, p1, p2, p3) VALUES (19, 5, 2, 2009, 1999, 0, 0);
INSERT INTO adottanti (id, idanagrafe, idbambino, anno, p1, p2, p3) VALUES (20, 280, 2, 2010, 0, 0, 0);


--
-- TOC entry 1738 (class 0 OID 35976)
-- Dependencies: 1260
-- Data for Name: anagrafe; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (215, 'Nicoli Tania', 'Via Vittorio Veneto', '21027', 'ISPRA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (295, 'Baranzini Rolo Baranzini', 'C.so Portaromana 106', '20122', 'MILANO', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (321, 'Busnardo Giulio e Gabriella', 'Via Mazzini 10', '21021', 'ANGERA (VA)', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (322, 'Forni Francesca', 'via Mario Greppi 56', '21021', 'ANGERA (VA)', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (323, 'Tofano Severino', 'via Bari 24', '21021', 'ANGERA (VA)', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (324, 'Bonvini Tina', 'via Ungheria 9', '21021', 'ANGERA(VA)', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (25, 'Cinzio', 'Via Como 14', '21021', 'ANGERA (VA)', 'Italy', '0331/931310', ' ', ' ', 'MRZCNZ54R30L682R', 'Merzagora', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (27, 'Antonella', 'Via Bordini', '21021', 'ANGERA (VA)', 'Italy', '0331/930605', ' ', ' ', 'BRVNNL63P65I819E', 'Brovelli', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (10, 'Silvestro', 'Via  Arno   1', '21021', 'ANGERA (VA)', 'Italy', '0331/931045', ' ', 'larix@working.it', 'BRVSVS49B16A290S', 'Brovelli', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (106, 'Renata', 'Via Monte Rosa 21', '21021', 'ANGERA (VA)', 'Italy', '0331/930486', ' ', ' ', 'PLTLGU18D15F205W', 'Andrini', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (337, 'Uboldi Maria', 'V.le Repubblica 8', '21021', 'ANGERA', ' Italia', ' ', ' ', ' ', ' ', 'fdcs', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (23, 'Giovanni', 'Via Risorgimento 5', '21052', 'BUSTO ARSIZIO (VA)', 'Italy', '0331/539149-323265', ' ', 'dario.paracchini@tin.it', 'PRCGNN42B13B900T', 'Paracchini', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (375, 'tete', 'prova', ' 21021', 'Angera', 'Ita', ' ', ' ', ' ', ' ', 'Zaninetta', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (5, 'Paolo', 'Via Solari 2', '21021', 'ANGERA (VA)', 'Italy', '0331/931092', ' 329', ' ', 'ZNNPLA79D01A290T', 'Zaninetta', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (359, 'Michele', 'Via Fornetto 17', '21021', 'ANGERA', ' Italia', ' ', ' ', ' ', ' ', 'De Lucchi', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (221, 'Brovelli Pierfranco', 'Via Car� 2', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (380, 'kjj', 'molk', 'j', 'jnkl', 'cds', '', '', '', '', 'lk', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (24, 'Fabio', 'Via Piave 5/a', '21020', 'RANCO (VA)', 'Italy', '0331/975052', ' ', ' ', 'FRNFBA58T25L682O', 'Franzetti', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (376, 'Zaninetta pippo', 'ciaoo', '21021', 'Angera', 'ita', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (7, 'Laura', 'Via Mario greppi', '21021', 'ANGERA (VA)', 'Italy', '0331/969279', ' ', ' ', 'BRNLRA69M67A290G', 'Baranzini', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (37, 'Rossotti Carla', 'Via Per Barza', '21021', 'ANGERA (VA)', 'Italy', '0331/931941', ' ', 'rossotti.mandirola@libero.it', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (40, 'Rossotti Carla', 'Via Fornaci 4', '21021', 'ANGERA (VA)', 'Italy', '0331/931941', ' ', 'rossotti.mandirola@libero.it', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (48, 'Lucchini Wanda', 'Via Po  10/C', '21021', 'ANGERA (VA)', 'Italy', '0335/5851308', ' ', 'shot@skylink.it', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (15, 'Maffini Nadia', 'Via Invalle, 8', '21021', 'ANGERA (VA)', 'Italy', '0331/931111', '3381239497', 'nadia.maffini@libero.it', 'MFFNDA56R47A290P', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (94, 'Ponti Barbara', 'Viale Casiraghi 40', '20099', 'SESTO SAN GIOVANNI (MI)', 'Italy', '02/22470934', ' ', 'DALEVANT@TIN.IT', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (130, 'Don Franco Brovelli', 'C.so Venezia, 8 Ist.Paolo IV', '20100', 'MILANO', 'Italy', ' ', ' ', 'Socio onorario', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (137, 'Lenzi Loretta', 'Via Cesare Battisti 10', '40123', 'BOLOGNA', 'Italy', ' ', ' ', 'Socio Onorario', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (140, 'Viapiana Claudio', 'Via Cesare Battisti 10', '40123', 'BOLOGNA', 'Italy', ' ', ' ', 'Socio Onorario', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (141, 'Don Rino Villa', 'Vicolo Parrocchiale', '21021', 'ANGERA', 'Italy', ' ', ' ', 'Socio Onorario', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (93, 'Fossati Sergio', ' ', ' ', '1707 SUCAT PARANAQUE Metro MANILA', 'PHILIPPINES', ' ', ' ', 'socio onorario', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (301, 'Binda Amalia', ' ', ' ', '', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (46, 'Bonvini Giancarlo', 'Via Ungheria', '21021', 'ANGERA (VA)', 'Italy', '0331/931179', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (47, 'Alvod Annalisa', 'Via Milano 52', '21021', 'ANGERA (VA)', 'Italy', '0331/930967', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (63, 'Brentan Sergio e Renata', 'Via Milano 32', '21021', 'ANGERA (VA)', 'Italy', '0331/930550', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (64, 'Ponzio Francesco', 'Via Altinada', '21021', 'ANGERA (VA)', 'Italy', '0331/931375', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (67, 'Sanvito Giancarlo', 'Via San Martino 19', '21021', 'ANGERA (VA)', 'Italy', '0331/930166', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (69, 'Volontè Bassetti Caterina', 'Via Madonnina  16', '21021', 'ANGERA (VA)', 'Italy', '0331/931832', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (87, 'Zocchi Anna Maria', 'Via Mameli 14', '21052', 'BUSTO ARSIZIO(VA)', 'Italy', '0331/628315', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (88, 'Cueroni Fernanda', 'Via Verbano  7', '21027', 'ISPRA (VA)', 'Italy', '0332/780409', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (89, 'Balzarini Bruno', 'Via Verbano  7', '21027', 'ISPRA(VA)', 'Italy', '0332/780409', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (90, 'De Cherubini Giuliana', 'Via Stazione 23', '21025', 'COMERIO(VA)', 'Italy', '0332/743802', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (91, 'De Cherubini Antonio', 'Via Stazione 23', '21025', 'COMERIO(VA)', 'Italy', '0332/743802', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (95, 'Levantini Dario', 'Viale Casiraghi 40', '20099', 'SESTO SAN GIOVANNI (MI)', 'Italy', '02/22470934', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (121, 'Brughera Tiziana', 'Via Roma 19', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (135, 'Ghirardi Mottarini Fiorella', 'Via Dei Pini  8', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (144, 'Nico'' Maria Rosa', 'Via Banetti 8', '21027', 'ISPRA', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (168, 'Bielli Elena', 'Via Milano 16', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (170, 'Frontini Agnese e fam.', 'Via Ticino 12', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (174, 'Cadario Enrica', 'Via Mazzini 7', '21027', 'ISPRA', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (182, 'Sghirinzetti Ezio', 'Via don Gnocchi', '20148', 'MILANO', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (198, 'Lombardi Beatrice', 'Via Roma 53', '21010', 'Portovaltravaglia', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (202, 'Della Chiesa Sergio', 'P.za Garibaldi 24', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (204, 'Alfinito Antonio', 'Via Altinada 41', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (205, 'Calvi Gina e Rosi', 'Via Marconi 12', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (330, 'Dimitri Stella', 'Via Beatrice d''Este', '20140', 'MILANO', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (206, 'Maffini  Assunta', 'Via San Martino 69', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (207, 'Avignano Laura', 'Via Madonnina', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (208, 'Forni Graziano', 'Via M. Greppi 56', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (210, 'Manni Luigi', 'Via Toscanini 4', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (211, 'Mortella Giorgio e Anna', 'Via Invalle 8', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (213, 'Cebrelli Gianfranco', 'Via Varesina', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (214, 'Forni Anna', 'Via M. Greppi', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (216, 'Soma', 'Via Milano 37', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (217, 'Mira Pierangela', 'Via Milano 103', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (218, 'Ferrari Stefano', 'Via Castello 15', '21020', 'RANCO (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (219, 'Imperial Maria Luisa', 'Via Marte 4', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (220, 'Fassina Elisa', 'Via Aldo Moro', '21027', 'ISPRA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (222, 'Pola Ileana e Lorenzo', 'Via Varesina 56', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (224, 'Tognoli Daniela', 'Via M. Greppi 3', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (225, 'De Micheli Sandra', 'Cascina Ronco 1', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (226, 'Cotignoli Silvana', 'Via Borromeo 1', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (227, 'Zago Norma e Filiberto', 'Via Piazzi', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (229, 'Forni Pier Mario', 'Via M. Greppi 44', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (230, 'Marras Barbara', 'Via Trento 9', '21020', 'TAINO (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (231, 'Negri Ernesto e Pierangela', 'Via Martiri della Libertà', '21014', 'LAVENO (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (232, 'Cocconi Piera e fam.', 'Via Como', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (233, 'Giombelli Marco', 'Via M. Greppi 83', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (234, 'Brovelli  Giampiero', 'Via Lungolago', '21020', 'RANCO(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (235, 'Farinella Nadia', ' Via Cilea', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (236, 'Costa Carla', 'Via Solferino 7', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (237, 'Soprano', 'Via Mazzini 75', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (238, 'Freidhof', 'Via Alberto', '21020', 'RANCO(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (239, 'Peretti Giannina', 'Via Mario Greppi 34', '21020', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (240, 'Brovelli Ida', 'Via Arno 1', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (241, 'Ponti Federica e Gabriella', 'Via solferino', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (242, 'Barale Anna', 'Via Altinada 59', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (244, 'Frezzato Franco', 'Via S.Rocco 7', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (245, 'Crippa Mario', 'V.le C.Battisti 109', '20057', 'VEDANO AL LAMBRO(MI)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (246, 'Fossati Renato', 'Via Mauro Macchi 58', '20124', 'MILANO', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (247, 'Mascheroni Angelo e Orazio', 'Via Colombo 8', '20096', 'PIOLTELLO(MI)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (212, 'Grossi Luigi', 'Via Paletta 14', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', 'G', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (248, 'Perlini Stefano e Carla', 'Via Trento 8', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (249, 'Corti Anselmo  e Claudia', 'Via Volta 12', '22057', 'OLGINATE(CO)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (250, 'Puricelli Sara', 'Via Lecco 164', '20052', 'MONZA (MI)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (251, 'Maggi Matteo', 'Via Marconi 10', '29027', 'PODENZANO(PC)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (252, 'Sartori Barbara', 'Via IV Novembre', '29027', 'PODENZANO(PC)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (253, 'Invernizzi Antonio', 'Via Movedo 10', '23900', 'LECCO', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (254, 'Aondio Severo', 'V.Asilo Monumento 18', '23900', 'LECCO', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (255, 'Mazzoni Giovanni', 'Via Scotti 18', '29027', 'PODENZANO(PC)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (256, 'Ronda Giovanna', 'Via Principale 10', '29028', 'FOLIGNANO(PC)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (257, 'Vallelunga Raffaele', 'Via A.Scrivo 9', '88029', 'SERRA S.BRUNO', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (259, 'Panzeri Carlo e Dalida', 'Via Manzoni 65', '23804', 'MONTE MORENZO(LC)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (260, 'Confalonieri Carolina', 'Via Toscana 28', '20043', 'ARCORE(MI)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (261, 'Aondio Graziella', 'Via Gambate 22/a', '23854', 'OLGINATE(LC)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (262, 'Crippa Cinzia', 'Via Gambate 52', '23854', 'OLGINATE(LC)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (264, 'Campagnoli Patrizia', 'Via Vialba 13/b', '20026', 'NOVATE MILANESE(MI)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (265, 'Bonalume Rosella', 'Via Cascina Immacolata', '23877', 'PADERNO D''ADDA', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (266, 'Binda Laura', 'Via del Zerto 2', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (267, 'Rossi Eliana', 'Via Vittorio Veneto 32', '21028', 'TRAVEDONA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (268, 'Palma Chiara', 'Via delle Betulle 2', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (269, 'Cassani Elisabetta', 'Vicolo Vira', '21034', 'COCQUIO TR:(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (270, 'Motta Angelo', 'Via Madonnina del Grappa 28', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (271, 'Zanarella Mario', 'Via L.da Vinci 1', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (272, 'Ghiringhelli Nicoletta', 'Via Corte 14', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (273, 'Palma Silvana (Gr.Miss.)', 'Via Marconi 52', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (274, 'Simonetta Ines', 'Via Girolo', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (275, 'Soma Fabiola', 'Via Milano 35', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (276, 'Sessa Giovanni', 'Via Europa 45', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (277, 'Keller Silvia', 'Via dei Castagni  5', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (278, 'Soc.Ispra Calcio', 'Piazzale Olimpia', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (279, 'Peroni Felice', 'Via Lavorascio  26', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (281, 'Soma Emanuela', 'Via Cavour  6', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (282, 'Facelli Ivana', 'Via Verbano  7', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (283, 'Zardoni Graziella', 'P.zza Parrocchiale 20', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (284, 'Baranzini Bruna', 'Via S. Martino 46', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (285, 'Costantini Nicoletta', 'Via Ondoli 14', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (286, 'Buratti Anna', 'Via Asciesa  11', '20081', 'ABBIATEGRASSO(MI)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (287, 'Gallivanoni Daniela', 'Via Dell''Usignolo  34', '21052', 'BUSTO ARSIZIO(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (288, 'Contarini Floriana', 'Via Genova 20', '21052', 'BUSTO ARSIZIO(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (290, 'Tonella Marcella', 'Via Marte 7', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (291, 'Boesso Anna Maria', 'Via Bicocca 28', '21100', 'VARESE', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (293, 'CL.V Elementare Angera', 'Hope', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (294, 'Melosi Piero', 'Via Pacini 14', '21021', 'MILANO', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (296, 'Perlini Giuseppina', 'Via Roma 19', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (297, 'Manni Vittorio', 'Via Verdi 1', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (298, 'Nicò Mariarosa', 'Via Banetti 12', '21027', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (299, 'Bassetti Rita e figli', 'Via Madonnina 20', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (300, 'Villa Carmelina', 'Vicolo Parrocchiale', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (302, 'Mion  Saturnia', 'Via S.Isidoro', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (303, 'Del Grande fam.', 'ViaS.Isidoro', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (304, 'Rampa Emilia', 'Via Mottava', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (305, 'Piasenta', 'Via Colonna 6', '21100', 'VARESE', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (306, 'Tonella Luca e Giovanna', 'Via Prato Chiuso 15', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (307, 'Grossi Nello', 'Via Capricorno', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (308, 'Piasini Elena', 'Via Archimede  10', '21052', 'BUSTO ARSIZIO(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (309, 'Jole e Antonella Spitaleri', 'Via Verga 28', '21100', 'VARESE', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (311, 'Barbati', 'Via Diaz', '21021', 'ANGERA', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (312, 'Baranzini Ernesto', 'Via Castabbio 4', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (313, 'Genoni Mario', 'Via Fasana 17', '28021', 'BORGOMANERO(NO)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (314, 'Magnani Anna', 'Via Montanara 3', '21100', 'VARESE', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (315, 'Ghiringhelli Luigi', 'Via Europa 3', '21020', 'TAINO (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (317, 'Pari Cristiana', 'Via Angera 37', '21018', 'SESTO CALENDE(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (319, 'Piazzi Rosa', 'Via Altinada 2', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (320, 'Fam. Bernasconi', 'Via Procaccini 24', '21100', 'VARESE', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (347, 'Della Chiesa fam.', 'Pzza Garibaldi', '21021', 'ANGERA', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (349, 'Baranzini Serena', 'Via Campo dei Fiori', '21021', 'ANGERA', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (351, 'Colzani Carla', 'Via Galilei 18', '21020', 'TAINO', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (373, 'Ghiringhelli Ivana', 'Via Trento, 20', '21023', 'Besozzo (VA)', 'Ita', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (374, 'Barboni Luca', 'Via Lunga, 15', '21020', 'Brebbia (VA)', 'Ita', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (192, 'Zorloni Graziella', 'Via Ferravilla 34', ' ', 'VARESE', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (289, 'Vanetti Fausto e Antonella', 'Via Besozzi  1/a', ' ', 'SANGIANO(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (292, 'CL..V Elementare Angera', 'Hope', ' ', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (348, 'Bardelli Anna', 'Via Besozzi 1/a', ' ', 'SANGIANO', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (316, 'Bonato Amalia', ' ', ' ', 'GENOVA', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (183, 'Merla Anna', 'via Milano', '21021', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (173, 'Anedda M.Luisa', 'Via Uponne 34', '21020', 'RANCO', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (185, 'Tonelli Anna Rita', 'Viale Gramsci 1', '20099', 'SESTO SAN GIOVANNI', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (187, 'Brovelli Lidia Fontana', 'Via Diaz 11', '21021', 'ANGERA(VA)', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (326, 'Colombo Mariangela', 'Via Giardini 5', '20038', 'SEREGNO (MI)', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (327, 'Brovelli Maria', 'Via Invalle 12', '21021', 'ANGERA (VA)', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (328, 'De Donatis Artuffo Concetta', 'Via A.Moro 6', '21021', 'ANGERA (VA)', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (329, 'Diano Desire'' e Nicola', 'Via Arena 5', '21021', 'ANGERA (VA)', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (331, 'Fassina Maria', 'Via Barech 13', '21021', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (332, 'Ferrari Samuele e Carlo', 'Via Torriani 12', '21021', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (334, 'Monteggia Maria Luisa', 'Via Mazzini 18', '21021', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (335, 'Proserpio Marina', 'Via Cavour 12', '21021', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (336, 'Saggin Avelino', 'Via Marconi 12', '21021', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (338, 'Vanetti Franca', 'Via Alberto 37', '21020', 'RANCO', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (339, 'Vavassori Irene', 'Via Parini 11', '21021', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (340, 'Zago Antonietta', 'Via Colonia Solare', '21021', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (342, 'Dal Molin Pierluigi', 'Pzza Parrocchiale 20', '21021', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (343, 'Parnisari Pierluigi', 'Cna Parnisari', '21021', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (344, 'Zagonel Giampaolo', 'Via Bologna', '21021', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (345, 'don Franco', 'parrocchia di Ispra', '21027', 'ISPRA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (346, 'Bardelli Ettore', 'Via Ariete 10 A', '21021', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (353, 'Soma Fausta', 'Via Prati secchi 4', '21027', 'ISPRA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (354, 'Saggin Angelo', 'Via Torino 13', '21021', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (355, 'Fam. Zorzi Santo', 'Via Bevilacqua 10', '25064', 'Gussago (Brescia)', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (356, 'Panteghini Bazzani', 'Via Acquafredda 24', '25064', 'Gussago (Brescia)', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (357, 'Ghirri Antonietta', 'Via Alfieri 16', '25100', 'BRESCIA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (358, 'Colombo Lucia', 'Via Pacini 60', '20131', 'MILANO', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (369, 'Del Torchio Marco', 'Via', '21021', 'Angera (VA)', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (370, 'Del Torchio Francesco', 'via Via Veneto', '21021', 'Sesto Calende', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (186, 'Barboni Maria Cristina', 'Via Cucchiari 9', ' ', 'MILANO', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (201, 'Berrini Ersilia', 'Via Torriani 6', ' ', 'ANGERA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (365, 'Zaninetta Stefano', 'Via invalle, 8', '21021', 'ANGERA (VA)', 'Italy', '0331931111', '3298156960', 'zanitete@libero.it', 'ZNNSFN83P20A290N', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (310, 'Calcio lunedì', 'P. hope', ' ', '', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (184, 'Geronico Cristina', ' ', '21020', 'RANCO', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (11, 'Musto Teresa', 'Piazza Margherita 16', '80145', 'NAPOLI', 'Italy', '081/5854984', NULL, ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (16, 'Ulgelmo Antonella', 'Via Trento  6', '21021', 'ANGERA (VA)', 'Italy', '0331/960201', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (6, 'Del Torchio Giovanni', 'Via Mario Greppi', '21021', 'ANGERA (VA)', 'Italy', '0331/960279', ' ', ' ', 'DLTGNN69H24A290I', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (8, 'Breganze Giovanni', 'Via Firenze 1', '21021', 'ANGERA (VA)', 'Italy', '0331/931226', ' ', ' ', 'BRGGNN51S08A290B', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (17, 'Geronico Chiara', 'Via Piave 5/a', '21021', 'RANCO (VA)', 'Italy', '0331/975052', ' ', ' ', 'GRNCHR58H52L682T', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (29, 'Gonti Adriana', 'Via Piave', '21021', 'ANGERA (VA)', 'Italy', '0331/931306', ' ', ' ', 'GNTDRN54C69A290A', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (30, 'Baranzini Lorenza', 'Via M.Greppi 8', '21021', 'ANGERA (VA)', 'Italy', '0338/5045545', ' ', ' ', 'BRNLNZ72T64E734S', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (38, 'Tognoli Valeria', 'Via Campaccino 40', '21021', 'ANGERA (VA)', 'Italy', '0331/931305', ' ', ' ', 'TGNVLR52R45D869P', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (39, 'Gonti Eloisa', 'Via Barech 6', '21021', 'ANGERA (VA)', 'Italy', '0331/960407', ' ', ' ', 'GNTLSE70C56A290W', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (41, 'Brovelli Daniela', 'Via Emilia  2', '21021', 'ANGERA (VA)', 'Italy', '0331/931013', ' ', ' ', 'BRVDNL55M63A290V', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (42, 'Crenna Gabriella', 'Via Crosa  9', '21021', 'ANGERA (VA)', 'Italy', '0331/931962', ' ', ' ', 'CRNGRL49P63L682K', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (43, 'Poltronieri Anna', 'Via Monterosa 21', '21021', 'ANGERA (VA)', 'Italy', '0348/3232684', ' ', ' ', 'PLTNNA50B67A290I', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (45, 'Alessandrini Pina', 'Via dei Mille  3333', '21021', 'ANGERA (VA)', 'Italy', '0331/960278', ' ', ' ', 'LSSGPP44L63Z315F', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (49, 'Lucchini Mario', 'Via Napoli  28', '21021', 'ANGERA (VA)', 'Italy', '0331/931436', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (57, 'Merzagora Giuseppina', 'Via Europa   8', '21021', 'ANGERA (VA)', 'Italy', '0331/931371', ' ', ' ', 'MRZGPP38A60A290Q', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (51, 'Lucchini Valentina', 'Via Napoli 28', '21021', 'ANGERA (VA)', 'Italy', '0331/931436', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (52, 'Lucchini Raffaella', 'Via  Uponne', '21020', 'RANCO(VA)', 'Italy', '0331/931436', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (65, 'Omarini Bassetti Graziella', 'Via Madonnina  16', '21021', 'ANGERA (VA)', 'Italy', '0331/931832', ' ', ' ', 'BSSMGR46T48B390F', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (66, 'Del Torchio Giuseppe', '"Via M. Greppi', '21021', 'ANGERA (VA)', 'Italy', '0331/957693', ' ', ' ', 'DLTGPP38H05L682K', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (68, 'Zaninetta Rosaria', 'Via Firenze', '21021', 'ANGERA (VA)', 'Italy', '0331/931226', ' ', ' ', 'ZNNRMR55H48A290Z', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (53, 'Baranzini Regina', 'Via Napoli  28', '21021', 'ANGERA (VA)', 'Italy', '0331/931436', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (54, 'Baranzini Carlo', 'Via M. Greppi  70', '21021', 'ANGERA (VA)', 'Italy', '0331/930186', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (61, 'Brovelli Marta', 'Via XXV Aprile', '21020', 'MERCALLO(VA))', 'Italy', '0331/968846', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (75, 'Gallo Francesco', 'Via Provinciale  49', '21020', 'MORNAGO(VA)', 'Italy', '0331/903565', ' ', ' ', 'GLLFNC43H10A429Q', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (76, 'Brizzi Laura in Gallo', 'Via Provinciale  49', '21020', 'MORNAGO(VA)', 'Italy', '0331/903565', ' ', ' ', 'BRZLRA48B67F205S', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (77, 'Amici Anna', 'Via Monterosa', '21021', 'ANGERA (VA)', 'Italy', '0331/931257', ' ', ' ', 'MCANMR52T58A290H', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (78, 'Ghiringhelli Roberto', 'Località Corte 12', '21021', 'ANGERA (VA)', 'Italy', '0331/957114', ' ', ' ', 'GHRRRT62B16L682Q', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (79, 'Colombo Sara', 'Via Don Corti  3', '21020', 'VILLADOSIA', 'Italy', '0332/945180', ' ', ' ', 'CNSSRA78L58L682S', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (80, 'Colombo Davide', 'Via Don Corti 3', '21020', 'VILLADOSIA', 'Italy', '0332/945180', ' ', ' ', 'CLMDVD71M18B639Q', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (81, 'Colombo Dario', 'Via Don Corti  3', '21020', 'VILLADOSIA', 'Italy', '0332/945180', ' ', ' ', 'CLMDSL70M07H792U', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (82, 'Lucchi Cogo Chiara', 'Via Davide Fè', '21020', 'VILLADOSIA   Di CASALE LITTA', 'Italy', '0332/945069', ' ', ' ', 'LCCCLR30D59B875K', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (83, 'Lucchi Cogo Rosa', 'Via Davide Fè', '21020', 'VILLADOSIA DI CASALE LITTA', 'Italy', '0332/945069', ' ', ' ', 'LCCRSO34S42B875W', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (84, 'Colombo Vittorino', 'Via Don Corti 3', '21020', 'CASALE LITTA pr. VILLADOSIA(VA)', 'Italy', '0332/945298', ' ', ' ', 'CLMVTR37B25B875Z', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (85, 'Borgomaneri Angela in Colombo', 'Via Don Corti 3', '21020', 'CASALE LITTA pr.VILLADOSIA(VA)', 'Italy', '0332/945180', ' ', ' ', 'BRGNGL35P45D869W', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (86, 'Famiglia Barboni', 'Via S. Rocco 23', '21020', 'BREBBIA(VA)', 'Italy', '0332/770326', ' ', ' ', 'BRBNGL70P67A290K', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (92, 'Bargolini Teresa', 'Via T.Bonenti 14', '21020', 'TAINO (VA)', 'Italy', '0331/957693', ' ', ' ', 'BRGTRS35L54E314Y', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (62, 'Balconi Carluccio', 'Via Padova 14', '21021', 'ANGERA (VA)', 'Italy', '0331/930395', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (96, 'Berrini Mauro', 'Via Torriani 1', '21021', 'ANGERA (VA)', 'Italy', '0331/930233', ' ', ' ', 'BRRMRA58L18L682Z', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (56, 'Peretti Francesca', 'Via Crosa   3', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (59, 'Baranzini Ida', 'Via Vicenza', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (71, 'Cadau Giovanna', 'Via Roma', '09090', 'SIMALA(OR)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (105, 'Comotti don Carlo', 'Via Aldo Moro 3', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (107, 'Giovannella Anna Maria', 'Via Mario Greppi', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (110, 'Barboni Annalisa', 'Via Varesina 46', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (112, 'Torno Luisa', 'Via Mazzini 17', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (114, 'Titta Giacomina', 'Via Milano 12', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (55, 'Maccacaro Ficicchia Anna', 'Via Cadorna  5', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', 'MCCNNA24R49I441R', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (60, 'Brovelli Carla', 'Via Genova 13', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', 'BRVCRL30A47A290', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (70, 'Gonti Luigi', 'Via Piave', '21100', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', 'GNTLGU27S23H276Z', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (72, 'Freri Gonti Antonietta', 'Via Piave', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', 'FRRNNT28L71H314T', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (108, 'Negri Carla', 'Via Cavour 8', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', 'NGRCRL29B44F093A', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (109, 'Bardelli Giulio', 'Via Matteotti 27', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', 'BRDGLI13B09A290D', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (111, 'Cerutti Pinolini Carla', 'Via Milite Ignoto 49', '21021', 'ISPRA(VA)', 'Italy', ' ', ' ', ' ', 'CRTCRL20E52A290S', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (113, 'D''Alimonte Panfilo', 'P.za Parocchiale', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', 'DLMPFL26D05H425H', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (115, 'Dal Lago Ivana', 'Via Trieste 1', '21021', 'ANGERA', 'Italy', ' ', ' ', ' ', 'DLLVNI35T52F205A', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (117, 'Cappiello Rosina', 'Via Val Castellana', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', 'CPPRSN37B59F104F', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (122, 'Buscaglia Amelia', 'Via Vittorio Veneto', '21028', 'TRAVEDONA M.', 'Italy', ' ', ' ', ' ', 'BSCMLA33D69G703J', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (123, 'Zoia Edoardo', 'Via Milano 2', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', 'ZOIDRD55D26Z751G', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (124, 'Forni Gabriella', 'Via Prato Reale 2', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', 'FRNMGB60E58A290L', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (125, 'Vesco Maria Luigia', 'Via Prato Reale 2', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', 'VSCMLG30M63A290E', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (126, 'Langè Marta', 'Via Bruschera', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', 'LNGMRT58P55A290Y', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (127, 'Brovelli Luisa', 'Via Marconi 6', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', 'BRVLGU41B64A290J', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (128, 'Salvi  Antonio', 'Via Pascoli  15', '20057', 'VEDANO AL LAMBRO(MI)', 'Italy', ' ', ' ', ' ', 'SLVNTN42P30H211A', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (132, 'Zonca Laura', 'Via A Piazzi', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', 'ZNCLRA40B50G349J', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (133, 'Rossi Gisella', 'Via Roma 54', '22070', 'BREGAZZO CON FIGLIARO(CO)', 'Italy', ' ', ' ', ' ', 'BNDGLL39R62E367G', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (142, 'Moretto Paolo', 'Via Galilei 19', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', 'MRTPLA73M12A290X', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (143, 'Ghiringhelli Donata', 'Via Tripoli 6', '21020', 'BREBBIA(VA)', 'Italy', ' ', ' ', ' ', 'GHRDTM57M51L682L', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (146, 'Cucchiara Bardelli Ercolina', 'Via Como 10', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', 'BRDRLN22R59F703Y', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (148, 'Brovelli Giorgio', 'Via Repubblica 15', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', 'BRVGRG34A13A290E', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (151, 'Limbiati Ettore', 'Via Mazzini 23', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', 'LMBTTR56E12A290L', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (152, 'Baranzini Franco', 'Via Rocca 3', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', 'BRNFNC56D03A290I', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (153, 'Castoldi Giovanni', 'Via Monte Grappa 11', '20057', 'VEDANO AL LAMBRO(MI)', 'Italy', ' ', ' ', ' ', 'CSTGNN43R31L704G', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (154, 'Brovelli Monica', 'Via Rocca 3', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', 'BRVMNC59A64L682I', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (155, 'Manfredi Mario', 'Via Bruschera', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', 'MNFMRA58P28L682S', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (156, 'Riganti Marta', 'Via Zanfranconi 26', '21100', 'VARESE', 'Italy', ' ', ' ', ' ', 'RGNMRT60H57L682K', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (158, 'Tonesi Elisa', 'Via Per Ranco', '21021', 'ANGERA(VA)', 'Italy', ' ', ' ', ' ', 'TNSLSE35A61S690O', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (166, 'Zanini Ombretta', 'Via Del Tasso 4', '21027', 'ISPRA VA)', 'Italy', ' ', ' ', ' ', 'ZNNART71A45L682F', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (223, 'Mondani', 'Via Prato Chiuso', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (188, 'Sanatelli Renata', 'Via Castello inf 7', '21020', 'RANCO (Va)', ' ', ' ', ' ', ' ', 'SNTRNT64E41D9460', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (194, 'Brovelli Anna Maria', 'Via Bicocca  28', '21100', 'VARESE', ' ', ' ', ' ', ' ', 'BRVNMR47C52A290R', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (196, 'Mezzina Nicoletta', 'Via Stella 1', '21021', 'VARESE', ' ', ' ', ' ', ' ', 'ZNCLRA40B504349J', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (190, 'Scolari Giampietro', 'Via Roma 2', '21020', 'RANCO', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (193, 'Cueroni Maria Luisa', 'Via del Tasso 4', '21027', 'ISPRA', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (199, 'Carletto Vittorio', 'Via Angera 58', '21018', 'Sesto Calende', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (200, 'Rossi Giampiero', 'Via Genova 5', '21021', 'ANGERA  (VA)', ' ', ' ', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (9, 'Bertolli Daniela', 'Via Pesaro 4', '21021', 'ANGERA (VA)', 'Italy', '0331/930634', ' ', 'dbertolli@tin.it', 'BRTDLM63R47D869Q', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (14, 'Franzetti Federica', 'Via Bologna 17', '21021', 'ANGERA (VA)', 'Italy', '0331/930787', ' ', 'federicafranzetti@virgilio.it', 'FRNFRC76P60A290J', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (28, 'Del Torchio Giovanni e fam', 'Via Solari 4', '21021', 'ANGERA (VA)', 'Italy', '0331/930402', ' ', 'giandodt@tin.it', 'DLTGDM45D07A290G', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (31, 'Pasini Paola', 'V.Veneto, 2', '21018', 'SESTO CALENDE (VA)', 'Italy', '0331/924702', ' ', 'PAOLA.PASINI@JRC.ORG', 'PSNPLA44L46C623S', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (32, 'Bezzolato Giovanni', 'Via Piave 24', '21021', 'ANGERA (VA)', 'Italy', '0331/931306', ' ', 'francybezzo@libero.it', 'BZZGNN47H24E709R', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (35, 'Baranzini Massimo', 'Via Po  10', '21021', 'ANGERA (VA)', 'Italy', '0338/7493958', ' ', 'galeazzi@id.it', 'BRNMSM66L20A429D', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (36, 'Pelusio Fabio', 'Via Cervino 9', '21021', 'ANGERA (VA)', 'Italy', '0331/932015', ' ', 'BENELLI@ASARVA.ORG', 'PLSFBA64R05L682G', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (44, 'Merla Carla', 'Via Milano  18', '21021', 'ANGERA (VA)', 'Italy', '0331/930001', ' ', 'costa@mail1tread.net', 'MRLCRL47S67A290W', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (50, 'Lucchini Daniele', 'Via Genova 11', '21021', 'ANGERA (VA)', 'Italy', '0335/6284422', ' ', 'sho@skylik.it', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (58, 'Gumier Elisa', 'Via Po  10', '21021', 'ANGERA (VA)', 'Italy', '0331/960447', ' ', 'baranziniantonio@libero.it', 'GMRLSE45D53I688P', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (73, 'Gonti Giovanni', 'Via Rosnati 8/a', '21032', 'CARAVATE(VA)', 'Italy', '0332/603923', ' ', 'GIOVANNI.GONTI@LIBERO.IT', 'GNTGNN58C25A290H', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (74, 'Bonora Sonia', 'Via Rosnati 8/a', '21032', 'CARAVATE(VA)', 'Italy', '0332/603923', ' ', 'GIOVANNI.GONTI@LIBERO.IT', 'BNRSLC61A51H829M', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (97, 'Merli Franco', 'Via Piave 7', '21021', 'ANGERA (VA)', 'Italy', '0331/931802', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (98, 'Monti Marilena', 'Via Piave 7', '21021', 'ANGERA (VA)', 'Italy', '0331/931802', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (102, 'Signorelli Augusta', 'Via Vignella 4', '21027', 'ISPRA (VA)', 'Italy', '0332/781760', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (103, 'Bassetti Anna Maria', 'Via XXV Aprile', '21021', 'TAINO(VA)', 'Italy', '0331/956782', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (138, 'Forni Fausta', 'Via Giove  5', '21021', 'ANGERA (VA)', 'Italy', '0331931308', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (145, 'Invernizzi Carla', 'Via Matteotti 32', '21021', 'ANGERA(VA)', 'Italy', '0331930918', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (116, 'Brovelli Italo', 'Via Matteotti', '21021', 'ANGERA (VA)', 'Italy', '0331/931261', ' ', ' ', 'BRVILI31T14A290B', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (118, 'Levasseur Angela', 'P.za Volta 2', '21021', 'ANGERA (VA)', 'Italy', '0331/931194', ' ', ' ', 'BRVNGL40C56L682J', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (119, 'Costantini Fabio', 'Via Milano 18', '21021', 'ANGERA (VA)', 'Italy', '0331 930001', ' ', ' ', 'CSTFBA70D13A290L', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (120, 'Zaninetta Giampiero', 'Via Piazzi 14', '21021', 'ANGERA (VA)', 'Italy', '0331/930055', ' ', ' ', 'ZNNPRM20M17L219O', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (129, 'Demetri Donata', 'Via Campo dei Fiori 14', '20020', 'MAGNAGO(MI)', 'Italy', '0331 659074', ' ', ' ', 'DMTDNT70P58B300Y', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (131, 'Del Torchio Mariuccia e Brovelli Pino', 'via Medaglie D''Oro', '21100', 'VARESE', 'Italy', '0332 289192', ' ', ' ', 'DLTMLM29P68F5229', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (134, 'Amerio Cristina', 'Via Europa 39', '21027', 'ISPRA(VA)', 'Italy', '0332 781865', ' ', ' ', 'MRACST73H59A290R', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (136, 'Benda Marina', 'Via F.lli Cervi Residenza Ponti', '20090', 'SEGRATE (MI)', 'Italy', '02 26413033', ' ', ' ', 'BNDMRN46D46E367Y', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (139, 'Muttarini Emilio', 'V.le Suzzani', '20141', 'MILANO', 'Italy', '02 6437329', ' ', ' ', 'MTTMLE46S30F205V', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (164, 'Lovati Augusto', 'Via Per Ranco 104', '21021', 'ANGERA  VA', 'Italy', '0331 960189', ' ', 'lovati@tread.it', 'LVTGST65E29B300H', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (165, 'Galli D'' Angelo Micaela', 'Via Per Ranco 104', '21021', 'ANGERA  VA', 'Italy', '0331 960189', ' ', 'lovati@tread.it', 'GLLMCL67B47F205U', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (180, 'Talamona Langè Antonietta', 'Via Roma', '21021', 'ANGERA (VA)', 'Italy', '0331 930189', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (181, 'Tonella Pintini Luisa', 'Via Campaccio 2', '21021', 'ANGERA (VA)', 'Italy', '0331 930824', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (159, 'Fattoretto Anna', 'Piazza Garibaldi 1', '21021', 'ANGERA (VA)', 'Italy', '0331 932030', ' ', ' ', 'FTTMMA66L43I819I', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (160, 'Boari Fontana Valeria', 'Via Diaz 11', '21021', 'ANGERA', 'Italy', '0331 931320', ' ', ' ', 'BROVLR59H56M067A', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (161, 'Innocenti Pierluigi', 'Via Altinada  37', '21021', 'ANGERA  VA', 'Italy', '0331 930567', ' ', ' ', 'NNCPLG39B20I628W', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (169, 'D''Alimonte Antonio', 'Via Trento 6', '21021', 'ANGERA (VA)', 'Italy', '0331 960201', ' ', ' ', 'DLMNTN54P18H425R', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (171, 'Mobiglia Gianangelo', 'Via Bologna', '21021', 'ANGERA (VA)', 'Italy', '0331 931430', ' ', ' ', 'MBGGNG43B12A290V', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (176, 'Carletto Alessandro', 'Via Angera 60', '21018', 'SESTO  CALENDE', 'Italy', '0331 911270', ' ', ' ', 'CRNLSN26S07H783L', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (177, 'Monti Fernando', 'Via S. Giorgio 3', '21018', 'SESTO CALENDE', 'Italy', '0331 920 043', ' ', ' ', 'MNTFNN33A21F205P', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (178, 'Ponti Vittorio', 'Via P. Martire', '21021', 'ANGERA (VA)', 'Italy', '0331 930283', ' ', ' ', 'PNTVTR31S05A290A', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (179, 'Ravasi Alvinio', 'Via Matteotti', '21021', 'ANGERA (VA)', 'Italy', '0331 931672', ' ', ' ', 'RVSLNF56R04A290Y', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (366, 'Soldati Marco', 'Via Altinada, 53', '21021', 'Angera (VA)', ' ', '0331/931446', ' ', 'marcsolda@libero.it', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (367, 'Marzetta Flavia', 'Via Campaccino, 12', '21021', 'Angera (VA)', ' ', '0331/931457', ' ', 'fla_@virgilio.it', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (333, 'Corti Limbiati Carmela', 'Via Mazzini 23', '21021', 'ANGERA', ' ', '0331/930627', ' ', ' ', 'CRTCML33P57G856R', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (352, 'Gadiva Giorgio', 'Via Mario Mreppi 36', '21021', 'ANGERA', ' ', '0331 931646', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (362, 'Ponti Rosanna', 'Via Castabbio 4', '21021', 'ANGERA (VA)', ' ', '0331/930659', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (361, 'Costantini Monica', 'Via Milano 18', '21021', 'ANGERA (VA)', ' ', '0331/930001', ' ', 'monica_costantini@tin.it', 'CSTMNC74P57A290C', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (363, 'Parnisari Raffaella', 'Via S.Isidoro 23 - Barzola', '21021', 'ANGERA (VA)', ' ', '0331/957182', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (364, 'Parnisari Silvano', 'Via S.Isidoro 23 - Barzola', '21021', 'ANGERA (VA)', ' ', '0331/957182', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (368, 'Borsa Paola', 'Via Campaccino, 32', '21021', 'Angera (VA)', ' ', '0331/931177', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (371, 'Zaninetta Marta', 'Via Invalle', '21021', 'ANGERA   (VA)', ' ', '0331931111', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (157, 'Aries Simona', 'Via Puccini  4', ' ', 'BREBBIA (VA)', 'Italy', ' ', ' ', 'SIMONA ARIES@mail.wirpool.com', 'RSASMN70L56L682A', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (360, 'Boni Chiara', 'Via Rovedana 8', ' ', 'Musadino di Portovaltravaglia (VA)', 'Ita', ' ', ' ', 'claireboni@yahoo.it', 'BNOCHR70M67L682B', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (195, 'Gonti Don Mario', 'Via Manzoni  6', ' ', 'LAINATE', ' ', ' ', ' ', 'GONTI@LIBERO.IT', 'GNTMRA64A04A290C', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (26, 'Attilio', 'Via Invalle 8', '21021', 'ANGERA (VA)', 'Italy', '0331/931111', '3394697474', 'nadia.maffini@libero.it', 'ZNNTTL52L18A290Y', 'Zaninetta', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (12, 'Lorenzo', 'Via Pesaro  4', '21021', 'ANGERA (VA)', 'Italy', '0331/930634', ' ', 'l.ghiri@virgilio.it', 'GHRLNZ62S16L682O', 'Ghiringhelli', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (13, 'Gabriella', 'Via Castabbio  4', '21021', 'ANGERA (VA)', 'Italy', '0331/930467', ' ', ' ', 'BRNGRL56P64A290K', 'Baranzini', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (99, 'Wossen Andreas', 'Via T. Bonenti 14', '21020', 'TAINO (VA)', 'Italy', '0331/957379', ' ', 'paola@alesco.it', 'VSSNRS62C07E734V', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (100, 'Lamorte Alessandro', 'Via Merzagora 7', '21021', 'ANGERA (VA)', 'Italy', '0331/960386', ' ', 'lalex@tread.it', 'LMRLSN66R26A429I', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (101, 'Doridoni Alessandra', 'Via Bologna 17', '21021', 'ANGERA (VA)', 'Italy', '0331/931485', ' ', 'FRANZETTILORENZO@VIRGILIO.IT', 'DRDLSD73P55A290T', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (104, 'Soldati Emilio', 'Via Altinada 53', '21021', 'ANGERA (VA)', 'Italy', '0331/931446', ' ', ' ', 'SLDMLE50H22L682W', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (147, 'Cantabene Carlo', 'Via Capo Palinuro 3', '20142', 'MILANO', 'Italy', '02 89121263', ' ', ' ', 'CNTCLG46L10A290C', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (167, 'Gregorelli Fausta Argento', 'Via varesina 22', '21021', 'ANGERA', 'Italy', '0331 930943', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (149, 'Fasola Paolo', 'Via P. Martire 29', '21021', 'ANGERA (VA)', 'Italy', '0331 931729', ' ', ' ', 'FSLPLA62T26F205V', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (150, 'Paracchini Riccardo', 'Via Pergolesi 2', '21052', 'BUSTO ARSIZIO(VA)', 'Italy', '0331 625533', ' ', ' ', 'PRCRCR36L03A290Z', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (172, 'Moroni Luisa', 'Via Azalee 11', '20141', 'MILANO', 'Italy', '02 48303176', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (175, 'Ferrari Gabriella', 'Via Romanssur Risere 37', '21100', 'VARESE', 'Italy', '0332 789867', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (203, 'Perlini Sandra', 'Via per Ranco 7', '21021', 'ANGERA (VA)', 'Italy', '0331/930412', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (228, 'Bascialla Marisa', 'Via Adda 10', '21021', 'ANGERA (VA)', 'Italy', '0331/931570', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (243, 'Colombo Luca e Monica', 'Via del Sole', '21021', 'ANGERA(VA)', 'Italy', '0331 960055', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (20, 'Daniela', 'Prato Reale', '21021', 'ANGERA (VA)', 'Italy', '0331/930075', ' ', ' ', 'FRNDNL57S67L682W', 'Forni', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (21, 'Laura', 'Via Roma 19', '21021', 'ANGERA (VA)', 'Italy', '0331/930090', ' ', ' ', 'SGNLRA73B60A290V', 'Signorelli', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (377, 'rv', 'vrt', 'vrs', 'vr', 'vt', '', '', '', '', 'vvr', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (341, 'Sanchez Perez de Lara Ramon', 'C/De la Cruz n°2', '11160', 'BARBATE/CADIZ', 'ESPANA', '0034-956432738', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (34, 'Stefania', 'Via Palizzi 40', '80127', 'NAPOLI', 'Italy', '081/5787252', ' ', ' ', ' ', 'Ascione', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (318, 'Luca', 'Via Uponne 34', '21020', 'RANCO (VA)', 'Italy', '0331 976578', ' ', 'luca.nizzetto@tin.it', 'NZZLCU75A10A290O', 'Nizzetto', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (325, 'Colombo Lucia', 'Via Pacini 60', '20131', 'MILANO', ' ', '0248701109', ' ', ' ', ' ', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (372, 'De Micheli Monteggia Sandra', 'Via Cascina Ronco, 1', '21021', 'Angera (VA)', 'ITA', '0331931384', ' ', ' ', 'DMCSDR31P621219H', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (163, 'Zamponi Ada Lovati', 'Via Giorgetti 20', ' ', 'GORLA MAGGIORE  VA', 'Italy', '0331 618388', ' ', ' ', 'ZMPDAA38B42O745Y', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (191, 'Zocchi  Amore Gabriella', 'Via Unità d''Italia 77', ' ', 'OLGIATE OLONA', 'Italy', '0331 375820', ' ', ' ', 'zccmgb46t47b300n', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (162, 'Prisciandaro Vittoria', 'Via dei Colli Portuensi 87', ' ', 'ROMA', 'Italy', '06 53272602', ' ', 'viprisciandaro@stpauls.it', 'PRSVTR64P53F839K', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (189, 'Dal Bon Fabio', 'Via Cavour 4', '21027', 'ISPRA', ' ', '0332/780630', ' ', 'fdalbon@yahoo.com', 'DLBFBA63B10L781B', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (197, 'Grisoni Anna', 'Via F. Filzi 39', '21020', 'TAINO', ' ', '0331/956326', ' ', 'annagrisoni@libero.it', 'GRSNMR45A58A429H', '', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (33, 'Antonio', 'Via Piemonte', '21027', 'ISPRA (VA)', 'Italy', '0332/780327', ' ', ' ', 'SPNNTN38L24L407Y', 'Sponchiado', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (381, 'hrt', 'hrt', 'hrt', 'hrt', 'hrt', '', '', '', '', 'hyrt', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (382, 'muy', 'iut', 'ity', 'kti', 'kt', '', '', '', '', ',myu', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (383, 'kty', 'kti', 'tiky', 'tyi', 'ktiy', '', '', '', '', 'kty', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (384, 'jty', 'jyt', 'jty', 'jty', 'juty', '', '', '', '', 'juyu', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (385, 'uyr', 'jury', 'jr', 'jru', 'jrut', '', '', '', '', 'yu', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (386, 'jur', 'jury', 'rj', 'jrujru', 'jru', '', '', '', '', 'jut', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (209, 'Francesca', 'Via Puccini 10', '21021', 'ANGERA (VA)', 'Italy', ' ', ' ', ' ', ' ', 'Zito', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (1, 'Lorenzo', 'Via Bologna 17', '21021', 'ANGERA (VA)', 'Italy', '0331/931485', ' ', 'FRANZETTILORENZO@VIRGILIO.IT', 'FRNLNZ71C17A290G', 'Franzetti', false);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (3, 'Elena', 'Via Cervino  9', '21021', 'ANGERA (VA)', 'Italy', '0331/932015', ' ', ' ', 'BNLLGL68M58A290E', 'Benelli', false);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (19, 'Rolando', 'Bolicon-Turno', ' ', 'DIPOLOG CITY', 'Philippines', '0063652125555', ' ', 'rolysnof@mozcom.com', 'DLTRND58S14L682Y', 'Del Torchio', false);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (22, 'Mirto', 'Via Per Ranco', '21021', 'ANGERA (VA)', 'Italy', '0331/930336', ' ', ' ', 'BNOMRT36R10H330A', 'Boni', false);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (388, 'eee', 'ee', 'ee', 'eee', 'eee', '', '', '', '', 'ee', false);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (4, 'Isa', 'Via Solari', '21021', 'ANGERA (VA)', 'Italy', '0331/931092', ' ', ' ', 'DLTMLS34H49A961Q', 'Del Torchio', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (2, 'Enrico', 'Via Bordini  5', '21021', 'ANGERA (VA)', 'Italy', '0331/930605', ' ', ' ', 'PSCNRC61P21A290H', 'Piscia', false);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (263, 'Comi', 'Via Don Novati 7', '23854', 'OLGINATE(LC)', 'Italy', ' ', ' ', ' ', ' ', 'Tea Corti', false);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (18, 'Giovanni', 'Via Solari', '21021', 'ANGERA (VA)', 'Italy', '0331/931092', ' ', 'tinotia@libero.it', 'ZNNGNN50P07A290N', 'Zaninetta', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (280, 'Ass.NESSUNO ESCLUSO', 'Circolo Fam.Via Vittorio V.', ' 2121', 'CARNAGO', 'Italy', ' ', ' ', ' ', ' ', 'eee', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (350, 'Valsecchi Paolina', 'Via Milite Ignoto 48', '21027', 'ISPRA', 'Italy', ' ', ' ', ' ', ' ', 'fds', true);
INSERT INTO anagrafe (id, nome, indirizzo, cap, citta, nazione, telefono, cellulare, email, codfiscale, cognome, posta) VALUES (258, 'Franco', 'Safa Cisterne S.DA', '29010', 'CALENDASCO(PC)', 'Italy', ' ', ' ', ' ', ' ', 'Molinari', true);


--
-- TOC entry 1732 (class 0 OID 35888)
-- Dependencies: 1245
-- Data for Name: anno; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO anno (anno, chiuso) VALUES (2006, false);
INSERT INTO anno (anno, chiuso) VALUES (2005, false);
INSERT INTO anno (anno, chiuso) VALUES (2003, true);
INSERT INTO anno (anno, chiuso) VALUES (2001, true);
INSERT INTO anno (anno, chiuso) VALUES (2002, true);
INSERT INTO anno (anno, chiuso) VALUES (2004, true);


--
-- TOC entry 1739 (class 0 OID 36005)
-- Dependencies: 1263
-- Data for Name: azionista; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1742 (class 0 OID 44317)
-- Dependencies: 1268
-- Data for Name: bambino; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO bambino (id, nome, sesso, indirizzo, citta, nazione, datanascita, scuola, descrizione) VALUES (2, 'Michela Rossi', 'F', 'via invalle, 8', 'Sibuco', 'Filippine', '2000-04-10', 'Elementare', 'hippo');
INSERT INTO bambino (id, nome, sesso, indirizzo, citta, nazione, datanascita, scuola, descrizione) VALUES (1, 'josuellen', 'M', 'via napoli, 18', 'zamboanga city', 'Filippine', '1999-11-12', 'ElementareM', 'kiwi!!');


--
-- TOC entry 1744 (class 0 OID 52512)
-- Dependencies: 1271
-- Data for Name: bambinoanno; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO bambinoanno (id, idbambino, anno, note) VALUES (1, 1, 2005, NULL);
INSERT INTO bambinoanno (id, idbambino, anno, note) VALUES (2, 1, 2006, NULL);
INSERT INTO bambinoanno (id, idbambino, anno, note) VALUES (4, 2, 2006, NULL);
INSERT INTO bambinoanno (id, idbambino, anno, note) VALUES (5, 2, 2005, NULL);
INSERT INTO bambinoanno (id, idbambino, anno, note) VALUES (13, 1, 1992, '');
INSERT INTO bambinoanno (id, idbambino, anno, note) VALUES (14, 1, 1991, '');
INSERT INTO bambinoanno (id, idbambino, anno, note) VALUES (16, 1, 1993, '');
INSERT INTO bambinoanno (id, idbambino, anno, note) VALUES (20, 2, 2007, '');
INSERT INTO bambinoanno (id, idbambino, anno, note) VALUES (21, 2, 2009, '');
INSERT INTO bambinoanno (id, idbambino, anno, note) VALUES (22, 2, 2010, '');


--
-- TOC entry 1746 (class 0 OID 60778)
-- Dependencies: 1278
-- Data for Name: categorienews; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO categorienews (id, nome, descrizione) VALUES (1, 'ccc', 'ccsds');
INSERT INTO categorienews (id, nome, descrizione) VALUES (2, 'ds', 'fdsd');


--
-- TOC entry 1733 (class 0 OID 35891)
-- Dependencies: 1246
-- Data for Name: conto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO conto (id, gruppo, nome, mostra) VALUES (11, 6, 'ciaocicaociaocia', true);
INSERT INTO conto (id, gruppo, nome, mostra) VALUES (12, 7, 'ciaociacaiciaicicarfkjjrbhyukjnre,akvwe', true);
INSERT INTO conto (id, gruppo, nome, mostra) VALUES (13, 1, 'viikiiii', true);
INSERT INTO conto (id, gruppo, nome, mostra) VALUES (1, 1, 'Cassa', true);
INSERT INTO conto (id, gruppo, nome, mostra) VALUES (3, 2, 'Banca Intesa', true);
INSERT INTO conto (id, gruppo, nome, mostra) VALUES (14, 8, 'conto passività', true);
INSERT INTO conto (id, gruppo, nome, mostra) VALUES (6, 1, 'nuovo', true);
INSERT INTO conto (id, gruppo, nome, mostra) VALUES (9, 2, 'nuovo', false);


--
-- TOC entry 1755 (class 0 OID 60895)
-- Dependencies: 1296
-- Data for Name: download; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1754 (class 0 OID 60885)
-- Dependencies: 1295
-- Data for Name: eventi; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1745 (class 0 OID 60758)
-- Dependencies: 1275
-- Data for Name: famiglia; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO famiglia (id1, id2) VALUES (5, 4);
INSERT INTO famiglia (id1, id2) VALUES (5, 18);
INSERT INTO famiglia (id1, id2) VALUES (24, 20);
INSERT INTO famiglia (id1, id2) VALUES (24, 134);
INSERT INTO famiglia (id1, id2) VALUES (2, 173);


--
-- TOC entry 1734 (class 0 OID 35895)
-- Dependencies: 1247
-- Data for Name: gruppo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO gruppo (id, tipo, nome) VALUES (1, 1, 'CASSA');
INSERT INTO gruppo (id, tipo, nome) VALUES (2, 2, 'BANCA');
INSERT INTO gruppo (id, tipo, nome) VALUES (6, 1, '123');
INSERT INTO gruppo (id, tipo, nome) VALUES (7, 3, 'bohhh');
INSERT INTO gruppo (id, tipo, nome) VALUES (8, 4, 'passività prima');


--
-- TOC entry 1753 (class 0 OID 60866)
-- Dependencies: 1294
-- Data for Name: high; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1748 (class 0 OID 60824)
-- Dependencies: 1282
-- Data for Name: immagini; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1736 (class 0 OID 35918)
-- Dependencies: 1254
-- Data for Name: movimenti; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO movimenti (id, descrizione, dare, avere, nome) VALUES (1, 'Offerte varie per pozzo in guatemala', 3, 3, 'Offerte guatemalaaa');
INSERT INTO movimenti (id, descrizione, dare, avere, nome) VALUES (3, 'pizza e fichi e mortadella e champagne!!!!!!!!!!!!!!!!', 1, 11, 'pizza e fiichi');


--
-- TOC entry 1747 (class 0 OID 60787)
-- Dependencies: 1280
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1749 (class 0 OID 60829)
-- Dependencies: 1283
-- Data for Name: newsimg; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1752 (class 0 OID 60863)
-- Dependencies: 1293
-- Data for Name: newsletter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1741 (class 0 OID 36090)
-- Dependencies: 1265
-- Data for Name: pagamentosoci; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (1, 1999, 330000, 1);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (1, 2000, 1, 2);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (2, 1999, 100000, 3);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (2, 2000, 200000, 4);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (3, 2000, 50000, 6);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (4, 1999, 500000, 7);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (4, 2000, 500000, 8);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (5, 1999, 100000, 9);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (5, 2000, 100000, 10);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (6, 1999, 100000, 11);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (6, 2000, 100000, 12);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (7, 1999, 100000, 13);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (7, 2000, 100000, 14);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (8, 2000, 100000, 16);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (9, 1999, 100000, 17);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (10, 1999, 50000, 19);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (11, 1999, 50000, 20);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (11, 2000, 50000, 21);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (12, 1999, 50000, 23);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (12, 2000, 50000, 24);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (13, 1999, 100000, 25);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (14, 1999, 100000, 26);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (14, 2000, 50000, 27);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (15, 1999, 50000, 28);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (15, 2000, 50000, 29);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (17, 1999, 50000, 32);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (17, 2000, 50000, 33);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (18, 1999, 50000, 34);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (18, 2000, 100000, 35);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (19, 1999, 50000, 36);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (19, 2000, 50000, 37);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (20, 1999, 50000, 38);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (20, 2000, 50000, 39);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (21, 1999, 50000, 40);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (21, 2000, 50000, 41);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (22, 1999, 100000, 42);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (23, 1999, 100000, 43);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (23, 2000, 100000, 44);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (24, 1999, 50000, 45);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (24, 2000, 50000, 46);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (25, 1999, 50000, 47);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (25, 2000, 50000, 48);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (26, 1999, 50000, 49);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (26, 2000, 50000, 50);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (27, 1999, 50000, 51);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (27, 2000, 50000, 52);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (28, 1999, 50000, 53);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (28, 2000, 50000, 54);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (29, 1999, 50000, 55);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (29, 2000, 100000, 56);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (30, 1999, 200000, 57);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (30, 2000, 300000, 58);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (31, 1999, 100000, 59);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (31, 2000, 100000, 60);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (32, 1999, 100000, 61);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (32, 2000, 100000, 62);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (33, 1999, 100000, 63);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (33, 2000, 100000, 64);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (34, 1999, 100000, 65);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (34, 2000, 100000, 66);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (35, 1999, 100000, 67);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (35, 2000, 100000, 68);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (36, 1999, 50000, 69);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (36, 2000, 50000, 70);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (37, 1999, 100000, 71);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (38, 1999, 100000, 72);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (38, 2000, 50000, 73);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (39, 1999, 100000, 74);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (39, 2000, 100000, 75);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (40, 1999, 100000, 76);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (40, 2000, 100000, 77);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (41, 1999, 100000, 78);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (41, 2000, 100000, 79);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (42, 1999, 100000, 80);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (42, 2000, 50000, 81);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (43, 1999, 100000, 82);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (44, 1999, 100000, 83);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (44, 2000, 100000, 84);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (45, 1999, 100000, 85);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (45, 2000, 100000, 86);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (46, 1999, 100000, 87);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (46, 2000, 100000, 88);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (47, 1999, 100000, 89);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (47, 2000, 50000, 90);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (48, 1999, 100000, 91);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (48, 2000, 100000, 92);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (49, 1983, 150, 93);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (49, 1990, 45, 94);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (49, 2003, 1999, 95);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (50, 1999, 100000, 97);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (51, 1999, 50000, 98);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (51, 2000, 50000, 99);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (52, 1999, 100000, 100);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (52, 2000, 100000, 101);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (53, 1999, 100000, 102);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (53, 2000, 100000, 103);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (54, 1999, 100000, 104);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (54, 2000, 100000, 105);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (55, 1999, 100000, 106);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (55, 2000, 100000, 107);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (56, 1999, 100000, 108);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (56, 2000, 100000, 109);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (57, 1999, 100000, 110);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (57, 2000, 100000, 111);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (58, 1999, 100000, 112);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (58, 2000, 50000, 113);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (59, 1999, 50000, 114);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (60, 1999, 50000, 115);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (60, 2000, 50000, 116);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (61, 1999, 50000, 117);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (62, 1999, 50000, 118);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (62, 2000, 50000, 119);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (63, 1999, 50000, 120);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (63, 2000, 50000, 121);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (64, 1999, 50000, 122);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (64, 2000, 150000, 123);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (65, 1999, 50000, 124);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (65, 2000, 50000, 125);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (66, 1999, 50000, 126);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (66, 2000, 50000, 127);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (67, 1999, 50000, 128);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (67, 2000, 50000, 129);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (68, 1999, 50000, 130);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (68, 2000, 50000, 131);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (69, 1999, 50000, 132);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (69, 2000, 50000, 133);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (70, 1999, 100000, 134);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (70, 2000, 100000, 135);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (71, 1999, 100000, 136);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (72, 1999, 50000, 137);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (73, 1999, 50000, 138);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (73, 2000, 50000, 139);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (74, 1999, 50000, 140);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (74, 2000, 50000, 141);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (76, 1999, 50000, 142);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (76, 2000, 50000, 143);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (77, 1999, 50000, 144);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (77, 2000, 1, 145);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (78, 1999, 50000, 146);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (78, 2000, 50000, 147);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (79, 1999, 50000, 148);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (79, 2000, 50000, 149);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (80, 1999, 50000, 150);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (80, 2000, 50000, 151);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (81, 1999, 50000, 152);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (82, 1999, 50000, 153);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (83, 1999, 50000, 154);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (84, 1999, 100000, 155);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (84, 2000, 100000, 156);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (85, 1999, 50000, 157);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (85, 2000, 50000, 158);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (86, 1999, 50000, 159);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (86, 2000, 50000, 160);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (87, 1999, 100000, 161);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (87, 2000, 50000, 162);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (88, 1999, 50000, 163);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (88, 2000, 50000, 164);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (89, 1999, 50000, 165);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (90, 1999, 50000, 166);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (90, 2000, 50000, 167);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (91, 1999, 50000, 168);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (91, 2000, 50000, 169);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (92, 1999, 50000, 170);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (92, 2000, 100000, 171);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (93, 1999, 100000, 172);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (93, 2000, 50000, 173);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (94, 1999, 50000, 174);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (95, 1999, 50000, 175);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (95, 2000, 50000, 176);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (96, 1999, 50000, 177);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (96, 2000, 50000, 178);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (97, 1999, 50000, 179);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (97, 2000, 50000, 180);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (98, 1999, 100000, 181);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (98, 2000, 100000, 182);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (101, 1999, 100000, 183);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (102, 1999, 100000, 184);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (103, 1999, 110000, 185);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (104, 1999, 50000, 186);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (105, 1999, 50000, 187);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (107, 1999, 50000, 190);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (108, 1999, 50000, 191);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (108, 2000, 50000, 192);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (110, 1999, 100000, 193);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (110, 2000, 100000, 194);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (113, 1999, 100000, 195);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (113, 2000, 50000, 196);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (114, 1999, 500000, 197);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (114, 2000, 500000, 198);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (115, 1999, 50000, 199);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (115, 2000, 50000, 200);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (116, 1999, 50000, 201);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (116, 2000, 50000, 202);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (117, 1999, 100000, 203);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (117, 2000, 50000, 204);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (118, 1999, 50000, 205);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (118, 2000, 50000, 206);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (119, 1999, 100000, 207);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (119, 2000, 100000, 208);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (120, 1999, 100000, 209);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (120, 2000, 50000, 210);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (121, 1999, 100000, 211);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (122, 1999, 100000, 212);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (122, 2000, 100000, 213);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (123, 1999, 50000, 214);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (124, 1999, 50000, 215);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (124, 2000, 100000, 216);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (125, 1999, 200000, 217);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (126, 1999, 50000, 218);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (126, 2000, 50000, 219);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (127, 1999, 50000, 220);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (127, 2000, 50000, 221);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (128, 1999, 100000, 222);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (128, 2000, 100000, 223);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (129, 1999, 50000, 224);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (130, 1999, 50000, 225);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (130, 2000, 50000, 226);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (131, 1999, 50000, 227);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (131, 2000, 50000, 228);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (132, 1999, 50000, 229);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (132, 2000, 50000, 230);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (133, 1999, 50000, 231);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (133, 2000, 50000, 232);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (134, 1999, 50000, 233);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (135, 2000, 50000, 234);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (136, 1999, 100000, 235);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (136, 2000, 100000, 236);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (137, 1999, 100000, 237);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (137, 2000, 100000, 238);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (138, 1999, 50000, 239);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (139, 1999, 50000, 240);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (139, 2000, 50000, 241);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (140, 1999, 100000, 242);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (140, 2000, 50000, 243);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (141, 1999, 100000, 244);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (141, 2000, 50000, 245);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (142, 1999, 50000, 246);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (143, 1999, 50000, 247);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (143, 2000, 50000, 248);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (144, 1999, 50000, 249);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (144, 2000, 50000, 250);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (145, 1999, 50000, 251);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (146, 1999, 50000, 252);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (147, 1999, 100000, 253);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (147, 2000, 100000, 254);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (148, 1999, 50000, 255);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (149, 1999, 50000, 256);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (150, 2000, 200000, 257);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (151, 1999, 50000, 258);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (151, 2000, 50000, 259);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (152, 1999, 50000, 260);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (152, 2000, 50000, 261);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (153, 1999, 50000, 262);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (153, 2000, 50000, 263);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (154, 1999, 50000, 264);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (155, 1999, 50000, 265);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (156, 1999, 50000, 266);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (156, 2000, 50000, 267);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (157, 1999, 250000, 268);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (157, 2000, 100000, 269);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (158, 1999, 100000, 270);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (158, 2000, 50000, 271);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (160, 1999, 50000, 274);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (160, 2000, 50000, 275);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (161, 1999, 50000, 276);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (162, 1999, 100000, 277);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (162, 2000, 50000, 278);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (164, 1999, 100000, 280);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (165, 1999, 50000, 281);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (165, 2000, 50000, 282);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (166, 1999, 50000, 283);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (166, 2000, 50000, 284);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (167, 2000, 50000, 285);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (168, 2000, 50000, 286);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (170, 2000, 100000, 288);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (173, 2000, 100000, 291);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (175, 2000, 50000, 293);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (176, 2000, 50000, 294);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (177, 2000, 100000, 295);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (179, 2000, 100000, 296);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (184, 2000, 50000, 301);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (187, 2000, 100000, 304);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (195, 2000, 50000, 306);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (10, 2006, 26, 309);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (12, 2006, 50, 310);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (6, 1998, 122121, 318);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (8, 2006, 50, 319);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (300, 2006, 15, 321);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (14, 2006, 673, 324);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (3, 2006, 87, 325);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (25, 2006, 554, 327);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (2, 2006, 68, 328);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (18, 2006, 90, 329);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (191, 2006, 123, 330);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (11, 2009, 12, 331);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (19, 2009, 11, 332);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (6, 2009, 3, 333);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (2, 2009, 22, 334);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (196, 1999, 34, 335);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (13, 2009, 112, 336);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (208, 2000, 19, 339);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (209, 1999, 1999, 340);
INSERT INTO pagamentosoci (tessera, anno, importo, id) VALUES (210, 1998, 182, 341);


--
-- TOC entry 1756 (class 0 OID 60910)
-- Dependencies: 1297
-- Data for Name: progetti; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1757 (class 0 OID 60928)
-- Dependencies: 1298
-- Data for Name: progettiimg; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1750 (class 0 OID 60857)
-- Dependencies: 1291
-- Data for Name: regioni; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1735 (class 0 OID 35903)
-- Dependencies: 1250
-- Data for Name: scrittura; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO scrittura (id, data, descrizione, importo, automatico, dare, avere, anno) VALUES (222, '2001-03-01', 'ma daaai', 12, false, 9, 1, 2001);
INSERT INTO scrittura (id, data, descrizione, importo, automatico, dare, avere, anno) VALUES (225, '2006-02-24', 'pizza e fichi e mortadella e champagne!', 111, false, 1, 1, 2006);
INSERT INTO scrittura (id, data, descrizione, importo, automatico, dare, avere, anno) VALUES (218, '2001-01-16', 'Offerte varie per pozzo in guatemalafreeeeeeeeeeeeee eeeeeeeeeeeeee eeeeeeeeeeeee eeeeeeeeeee eeeeeegfveargv gbvge sgvhjebnvc wfberawhjvcknreav eraivjhnreic ewuifhnewrfcjrenw', 33.799999, false, 1, 3, 2001);
INSERT INTO scrittura (id, data, descrizione, importo, automatico, dare, avere, anno) VALUES (226, '2004-02-24', 'Offerte varie per pozzo in guatemala', 54, false, 1, 3, 2004);
INSERT INTO scrittura (id, data, descrizione, importo, automatico, dare, avere, anno) VALUES (223, '2002-01-03', 'Offerte varie per pozzo in guatemala', 13500, false, 3, 6, 2002);
INSERT INTO scrittura (id, data, descrizione, importo, automatico, dare, avere, anno) VALUES (228, '2006-02-26', 'Offerte varie per pozzo in guatemala', 12, false, 11, 13, 2006);
INSERT INTO scrittura (id, data, descrizione, importo, automatico, dare, avere, anno) VALUES (229, '2006-02-26', 'pizza e fichi e mortadella e champagne!!!!!!!!!!!!!!!!', 190, false, 11, 6, 2006);
INSERT INTO scrittura (id, data, descrizione, importo, automatico, dare, avere, anno) VALUES (231, '2006-02-26', 'Offerte varie per pozzo in guatemala', 7, false, 3, 3, 2006);
INSERT INTO scrittura (id, data, descrizione, importo, automatico, dare, avere, anno) VALUES (232, '2006-02-26', 'pizza e fichi e mortadella e champagne!!!!!!!!!!!!!!!!', 99, false, 1, 11, 2006);
INSERT INTO scrittura (id, data, descrizione, importo, automatico, dare, avere, anno) VALUES (233, '2006-02-26', 'Offerte varie per pozzo in guatemala', 67445, false, 9, 3, 2006);
INSERT INTO scrittura (id, data, descrizione, importo, automatico, dare, avere, anno) VALUES (235, '2006-03-01', 'pizza e fichi e mortadella e champagne!!!!!!!!!!!!!!!!', 6987.6699, false, 1, 11, 2006);


--
-- TOC entry 1740 (class 0 OID 36071)
-- Dependencies: 1264
-- Data for Name: socio; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO socio (id, tessera, note) VALUES (1, 20, '');
INSERT INTO socio (id, tessera, note) VALUES (2, 21, '');
INSERT INTO socio (id, tessera, note) VALUES (3, 23, '');
INSERT INTO socio (id, tessera, note) VALUES (4, 24, '');
INSERT INTO socio (id, tessera, note) VALUES (5, 11, '');
INSERT INTO socio (id, tessera, note) VALUES (6, 26, '');
INSERT INTO socio (id, tessera, note) VALUES (7, 27, '');
INSERT INTO socio (id, tessera, note) VALUES (8, 36, '');
INSERT INTO socio (id, tessera, note) VALUES (9, 37, '');
INSERT INTO socio (id, tessera, note) VALUES (10, 25, '');
INSERT INTO socio (id, tessera, note) VALUES (11, 28, '');
INSERT INTO socio (id, tessera, note) VALUES (12, 13, '');
INSERT INTO socio (id, tessera, note) VALUES (13, 14, '');
INSERT INTO socio (id, tessera, note) VALUES (14, 15, '');
INSERT INTO socio (id, tessera, note) VALUES (15, 29, '');
INSERT INTO socio (id, tessera, note) VALUES (16, 17, '');
INSERT INTO socio (id, tessera, note) VALUES (17, 18, '');
INSERT INTO socio (id, tessera, note) VALUES (18, 19, '');
INSERT INTO socio (id, tessera, note) VALUES (19, 1, '');
INSERT INTO socio (id, tessera, note) VALUES (20, 2, '');
INSERT INTO socio (id, tessera, note) VALUES (22, 4, '');
INSERT INTO socio (id, tessera, note) VALUES (23, 5, '');
INSERT INTO socio (id, tessera, note) VALUES (24, 6, '');
INSERT INTO socio (id, tessera, note) VALUES (25, 7, '');
INSERT INTO socio (id, tessera, note) VALUES (26, 8, '');
INSERT INTO socio (id, tessera, note) VALUES (27, 12, '');
INSERT INTO socio (id, tessera, note) VALUES (28, 16, '');
INSERT INTO socio (id, tessera, note) VALUES (29, 31, '');
INSERT INTO socio (id, tessera, note) VALUES (30, 32, '');
INSERT INTO socio (id, tessera, note) VALUES (31, 33, '');
INSERT INTO socio (id, tessera, note) VALUES (32, 35, '');
INSERT INTO socio (id, tessera, note) VALUES (33, 9, '');
INSERT INTO socio (id, tessera, note) VALUES (34, 10, '');
INSERT INTO socio (id, tessera, note) VALUES (35, 38, '');
INSERT INTO socio (id, tessera, note) VALUES (36, 39, '');
INSERT INTO socio (id, tessera, note) VALUES (37, 40, '');
INSERT INTO socio (id, tessera, note) VALUES (38, 41, '');
INSERT INTO socio (id, tessera, note) VALUES (39, 43, '');
INSERT INTO socio (id, tessera, note) VALUES (40, 44, '');
INSERT INTO socio (id, tessera, note) VALUES (41, 45, '');
INSERT INTO socio (id, tessera, note) VALUES (42, 46, '');
INSERT INTO socio (id, tessera, note) VALUES (43, 47, '');
INSERT INTO socio (id, tessera, note) VALUES (44, 48, '');
INSERT INTO socio (id, tessera, note) VALUES (45, 49, '');
INSERT INTO socio (id, tessera, note) VALUES (46, 50, '');
INSERT INTO socio (id, tessera, note) VALUES (47, 51, '');
INSERT INTO socio (id, tessera, note) VALUES (48, 52, '');
INSERT INTO socio (id, tessera, note) VALUES (49, 53, '');
INSERT INTO socio (id, tessera, note) VALUES (50, 54, '');
INSERT INTO socio (id, tessera, note) VALUES (51, 55, '');
INSERT INTO socio (id, tessera, note) VALUES (52, 56, '');
INSERT INTO socio (id, tessera, note) VALUES (53, 57, '');
INSERT INTO socio (id, tessera, note) VALUES (54, 58, '');
INSERT INTO socio (id, tessera, note) VALUES (55, 59, '');
INSERT INTO socio (id, tessera, note) VALUES (56, 60, '');
INSERT INTO socio (id, tessera, note) VALUES (57, 61, '');
INSERT INTO socio (id, tessera, note) VALUES (58, 62, '');
INSERT INTO socio (id, tessera, note) VALUES (59, 63, '');
INSERT INTO socio (id, tessera, note) VALUES (60, 65, '');
INSERT INTO socio (id, tessera, note) VALUES (61, 66, '');
INSERT INTO socio (id, tessera, note) VALUES (62, 67, '');
INSERT INTO socio (id, tessera, note) VALUES (63, 68, '');
INSERT INTO socio (id, tessera, note) VALUES (64, 69, '');
INSERT INTO socio (id, tessera, note) VALUES (65, 70, '');
INSERT INTO socio (id, tessera, note) VALUES (66, 71, '');
INSERT INTO socio (id, tessera, note) VALUES (67, 72, '');
INSERT INTO socio (id, tessera, note) VALUES (68, 73, '');
INSERT INTO socio (id, tessera, note) VALUES (69, 74, '');
INSERT INTO socio (id, tessera, note) VALUES (70, 76, '');
INSERT INTO socio (id, tessera, note) VALUES (71, 77, '');
INSERT INTO socio (id, tessera, note) VALUES (72, 78, '');
INSERT INTO socio (id, tessera, note) VALUES (73, 79, '');
INSERT INTO socio (id, tessera, note) VALUES (74, 80, '');
INSERT INTO socio (id, tessera, note) VALUES (75, 81, '');
INSERT INTO socio (id, tessera, note) VALUES (76, 82, '');
INSERT INTO socio (id, tessera, note) VALUES (77, 83, '');
INSERT INTO socio (id, tessera, note) VALUES (78, 84, '');
INSERT INTO socio (id, tessera, note) VALUES (79, 85, '');
INSERT INTO socio (id, tessera, note) VALUES (80, 86, '');
INSERT INTO socio (id, tessera, note) VALUES (81, 87, '');
INSERT INTO socio (id, tessera, note) VALUES (82, 88, '');
INSERT INTO socio (id, tessera, note) VALUES (83, 89, '');
INSERT INTO socio (id, tessera, note) VALUES (84, 90, '');
INSERT INTO socio (id, tessera, note) VALUES (85, 91, '');
INSERT INTO socio (id, tessera, note) VALUES (86, 92, '');
INSERT INTO socio (id, tessera, note) VALUES (87, 93, '');
INSERT INTO socio (id, tessera, note) VALUES (88, 94, '');
INSERT INTO socio (id, tessera, note) VALUES (89, 95, '');
INSERT INTO socio (id, tessera, note) VALUES (90, 96, '');
INSERT INTO socio (id, tessera, note) VALUES (91, 97, '');
INSERT INTO socio (id, tessera, note) VALUES (92, 98, '');
INSERT INTO socio (id, tessera, note) VALUES (93, 100, '');
INSERT INTO socio (id, tessera, note) VALUES (94, 101, '');
INSERT INTO socio (id, tessera, note) VALUES (95, 102, '');
INSERT INTO socio (id, tessera, note) VALUES (96, 103, '');
INSERT INTO socio (id, tessera, note) VALUES (97, 104, '');
INSERT INTO socio (id, tessera, note) VALUES (98, 105, '');
INSERT INTO socio (id, tessera, note) VALUES (100, 107, '');
INSERT INTO socio (id, tessera, note) VALUES (101, 108, '');
INSERT INTO socio (id, tessera, note) VALUES (102, 109, '');
INSERT INTO socio (id, tessera, note) VALUES (103, 110, '');
INSERT INTO socio (id, tessera, note) VALUES (104, 156, '');
INSERT INTO socio (id, tessera, note) VALUES (105, 207, '');
INSERT INTO socio (id, tessera, note) VALUES (106, 127, '');
INSERT INTO socio (id, tessera, note) VALUES (107, 135, '');
INSERT INTO socio (id, tessera, note) VALUES (108, 75, '');
INSERT INTO socio (id, tessera, note) VALUES (109, 113, '');
INSERT INTO socio (id, tessera, note) VALUES (110, 194, '');
INSERT INTO socio (id, tessera, note) VALUES (111, 140, '');
INSERT INTO socio (id, tessera, note) VALUES (112, 186, '');
INSERT INTO socio (id, tessera, note) VALUES (113, 125, '');
INSERT INTO socio (id, tessera, note) VALUES (114, 205, '');
INSERT INTO socio (id, tessera, note) VALUES (115, 114, '');
INSERT INTO socio (id, tessera, note) VALUES (116, 126, '');
INSERT INTO socio (id, tessera, note) VALUES (117, 115, '');
INSERT INTO socio (id, tessera, note) VALUES (118, 122, '');
INSERT INTO socio (id, tessera, note) VALUES (119, 147, '');
INSERT INTO socio (id, tessera, note) VALUES (120, 132, '');
INSERT INTO socio (id, tessera, note) VALUES (121, 145, '');
INSERT INTO socio (id, tessera, note) VALUES (122, 116, '');
INSERT INTO socio (id, tessera, note) VALUES (123, 117, '');
INSERT INTO socio (id, tessera, note) VALUES (124, 123, '');
INSERT INTO socio (id, tessera, note) VALUES (125, 124, '');
INSERT INTO socio (id, tessera, note) VALUES (126, 136, '');
INSERT INTO socio (id, tessera, note) VALUES (127, 118, '');
INSERT INTO socio (id, tessera, note) VALUES (128, 162, '');
INSERT INTO socio (id, tessera, note) VALUES (129, 121, '');
INSERT INTO socio (id, tessera, note) VALUES (130, 112, '');
INSERT INTO socio (id, tessera, note) VALUES (131, 187, '');
INSERT INTO socio (id, tessera, note) VALUES (132, 206, '');
INSERT INTO socio (id, tessera, note) VALUES (133, 139, '');
INSERT INTO socio (id, tessera, note) VALUES (134, 129, '');
INSERT INTO socio (id, tessera, note) VALUES (135, 173, '');
INSERT INTO socio (id, tessera, note) VALUES (136, 128, '');
INSERT INTO socio (id, tessera, note) VALUES (137, 150, '');
INSERT INTO socio (id, tessera, note) VALUES (138, 202, '');
INSERT INTO socio (id, tessera, note) VALUES (139, 155, '');
INSERT INTO socio (id, tessera, note) VALUES (140, 200, '');
INSERT INTO socio (id, tessera, note) VALUES (141, 250, '');
INSERT INTO socio (id, tessera, note) VALUES (142, 131, '');
INSERT INTO socio (id, tessera, note) VALUES (143, 159, '');
INSERT INTO socio (id, tessera, note) VALUES (144, 177, '');
INSERT INTO socio (id, tessera, note) VALUES (145, 171, '');
INSERT INTO socio (id, tessera, note) VALUES (146, 170, '');
INSERT INTO socio (id, tessera, note) VALUES (147, 119, '');
INSERT INTO socio (id, tessera, note) VALUES (148, 167, '');
INSERT INTO socio (id, tessera, note) VALUES (149, 148, '');
INSERT INTO socio (id, tessera, note) VALUES (150, 120, '');
INSERT INTO socio (id, tessera, note) VALUES (151, 163, '');
INSERT INTO socio (id, tessera, note) VALUES (152, 133, '');
INSERT INTO socio (id, tessera, note) VALUES (153, 158, '');
INSERT INTO socio (id, tessera, note) VALUES (154, 134, '');
INSERT INTO socio (id, tessera, note) VALUES (155, 137, '');
INSERT INTO socio (id, tessera, note) VALUES (156, 141, '');
INSERT INTO socio (id, tessera, note) VALUES (157, 138, '');
INSERT INTO socio (id, tessera, note) VALUES (158, 130, '');
INSERT INTO socio (id, tessera, note) VALUES (159, 142, '');
INSERT INTO socio (id, tessera, note) VALUES (160, 144, '');
INSERT INTO socio (id, tessera, note) VALUES (161, 146, '');
INSERT INTO socio (id, tessera, note) VALUES (162, 149, '');
INSERT INTO socio (id, tessera, note) VALUES (163, 151, '');
INSERT INTO socio (id, tessera, note) VALUES (164, 152, '');
INSERT INTO socio (id, tessera, note) VALUES (165, 153, '');
INSERT INTO socio (id, tessera, note) VALUES (166, 165, '');
INSERT INTO socio (id, tessera, note) VALUES (167, 160, '');
INSERT INTO socio (id, tessera, note) VALUES (168, 197, '');
INSERT INTO socio (id, tessera, note) VALUES (169, 34, '');
INSERT INTO socio (id, tessera, note) VALUES (170, 64, '');
INSERT INTO socio (id, tessera, note) VALUES (171, 42, '');
INSERT INTO socio (id, tessera, note) VALUES (172, 154, '');
INSERT INTO socio (id, tessera, note) VALUES (173, 176, '');
INSERT INTO socio (id, tessera, note) VALUES (174, 172, '');
INSERT INTO socio (id, tessera, note) VALUES (175, 161, '');
INSERT INTO socio (id, tessera, note) VALUES (176, 164, '');
INSERT INTO socio (id, tessera, note) VALUES (177, 166, '');
INSERT INTO socio (id, tessera, note) VALUES (178, 22, '');
INSERT INTO socio (id, tessera, note) VALUES (179, 30, '');
INSERT INTO socio (id, tessera, note) VALUES (180, 157, '');
INSERT INTO socio (id, tessera, note) VALUES (181, 143, '');
INSERT INTO socio (id, tessera, note) VALUES (182, 168, '');
INSERT INTO socio (id, tessera, note) VALUES (183, 199, '');
INSERT INTO socio (id, tessera, note) VALUES (184, 180, '');
INSERT INTO socio (id, tessera, note) VALUES (185, 211, '');
INSERT INTO socio (id, tessera, note) VALUES (186, 204, '');
INSERT INTO socio (id, tessera, note) VALUES (187, 174, '');
INSERT INTO socio (id, tessera, note) VALUES (188, 175, '');
INSERT INTO socio (id, tessera, note) VALUES (189, 179, '');
INSERT INTO socio (id, tessera, note) VALUES (190, 182, '');
INSERT INTO socio (id, tessera, note) VALUES (191, 181, '');
INSERT INTO socio (id, tessera, note) VALUES (192, 184, '');
INSERT INTO socio (id, tessera, note) VALUES (193, 203, '');
INSERT INTO socio (id, tessera, note) VALUES (194, 183, '');
INSERT INTO socio (id, tessera, note) VALUES (195, 185, '');
INSERT INTO socio (id, tessera, note) VALUES (196, 193, '');
INSERT INTO socio (id, tessera, note) VALUES (197, 169, '');
INSERT INTO socio (id, tessera, note) VALUES (198, 195, '');
INSERT INTO socio (id, tessera, note) VALUES (199, 201, '');
INSERT INTO socio (id, tessera, note) VALUES (200, 198, '');
INSERT INTO socio (id, tessera, note) VALUES (204, 233, 'tete');
INSERT INTO socio (id, tessera, note) VALUES (221, 226, '');
INSERT INTO socio (id, tessera, note) VALUES (300, 221, '');
INSERT INTO socio (id, tessera, note) VALUES (301, 218, '');
INSERT INTO socio (id, tessera, note) VALUES (333, 229, '');
INSERT INTO socio (id, tessera, note) VALUES (360, 222, '');
INSERT INTO socio (id, tessera, note) VALUES (361, 220, '');
INSERT INTO socio (id, tessera, note) VALUES (363, 224, '');
INSERT INTO socio (id, tessera, note) VALUES (364, 225, '');
INSERT INTO socio (id, tessera, note) VALUES (366, 214, '');
INSERT INTO socio (id, tessera, note) VALUES (367, 215, '');
INSERT INTO socio (id, tessera, note) VALUES (368, 228, '');
INSERT INTO socio (id, tessera, note) VALUES (370, 219, '');
INSERT INTO socio (id, tessera, note) VALUES (371, 216, '');
INSERT INTO socio (id, tessera, note) VALUES (372, 227, '');
INSERT INTO socio (id, tessera, note) VALUES (373, 230, '');
INSERT INTO socio (id, tessera, note) VALUES (374, 231, '');
INSERT INTO socio (id, tessera, note) VALUES (21, 3, 'ciao');
INSERT INTO socio (id, tessera, note) VALUES (359, 300, '');
INSERT INTO socio (id, tessera, note) VALUES (318, 301, '');
INSERT INTO socio (id, tessera, note) VALUES (377, 304, '');
INSERT INTO socio (id, tessera, note) VALUES (337, 390, '');
INSERT INTO socio (id, tessera, note) VALUES (381, 99, '');
INSERT INTO socio (id, tessera, note) VALUES (382, 106, '');
INSERT INTO socio (id, tessera, note) VALUES (383, 111, '');
INSERT INTO socio (id, tessera, note) VALUES (384, 178, '');
INSERT INTO socio (id, tessera, note) VALUES (385, 189, '');
INSERT INTO socio (id, tessera, note) VALUES (386, 188, '');
INSERT INTO socio (id, tessera, note) VALUES (209, 191, '');
INSERT INTO socio (id, tessera, note) VALUES (388, 190, '');
INSERT INTO socio (id, tessera, note) VALUES (263, 192, '');
INSERT INTO socio (id, tessera, note) VALUES (280, 196, '');
INSERT INTO socio (id, tessera, note) VALUES (350, 208, '');
INSERT INTO socio (id, tessera, note) VALUES (258, 209, '');
INSERT INTO socio (id, tessera, note) VALUES (212, 210, '');


--
-- TOC entry 1751 (class 0 OID 60860)
-- Dependencies: 1292
-- Data for Name: tipofile; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 1737 (class 0 OID 35926)
-- Dependencies: 1256
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "user" (username, "password", tipo) VALUES ('tili52', '180752', 2);
INSERT INTO "user" (username, "password", tipo) VALUES ('fabio', 'costa', 1);
INSERT INTO "user" (username, "password", tipo) VALUES ('admin', 'fla___84', 3);


--
-- TOC entry 1678 (class 2606 OID 44333)
-- Dependencies: 1269 1269
-- Name: adottanti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY adottanti
    ADD CONSTRAINT adottanti_pkey PRIMARY KEY (id);


--
-- TOC entry 1670 (class 2606 OID 35981)
-- Dependencies: 1260 1260
-- Name: anagrafe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY anagrafe
    ADD CONSTRAINT anagrafe_pkey PRIMARY KEY (id);


--
-- TOC entry 1658 (class 2606 OID 35929)
-- Dependencies: 1245 1245
-- Name: anno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY anno
    ADD CONSTRAINT anno_pkey PRIMARY KEY (anno);


--
-- TOC entry 1676 (class 2606 OID 44324)
-- Dependencies: 1268 1268
-- Name: bambino_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bambino
    ADD CONSTRAINT bambino_pkey PRIMARY KEY (id);


--
-- TOC entry 1680 (class 2606 OID 52518)
-- Dependencies: 1271 1271
-- Name: bambinoanno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bambinoanno
    ADD CONSTRAINT bambinoanno_pkey PRIMARY KEY (id);


--
-- TOC entry 1684 (class 2606 OID 60784)
-- Dependencies: 1278 1278
-- Name: categorienews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categorienews
    ADD CONSTRAINT categorienews_pkey PRIMARY KEY (id);


--
-- TOC entry 1660 (class 2606 OID 35931)
-- Dependencies: 1246 1246
-- Name: conto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conto
    ADD CONSTRAINT conto_pkey PRIMARY KEY (id);


--
-- TOC entry 1702 (class 2606 OID 60899)
-- Dependencies: 1296 1296
-- Name: download_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY download
    ADD CONSTRAINT download_pkey PRIMARY KEY (id);


--
-- TOC entry 1700 (class 2606 OID 60889)
-- Dependencies: 1295 1295
-- Name: eventi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY eventi
    ADD CONSTRAINT eventi_pkey PRIMARY KEY (id);


--
-- TOC entry 1682 (class 2606 OID 60761)
-- Dependencies: 1275 1275 1275
-- Name: famiglia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY famiglia
    ADD CONSTRAINT famiglia_pkey PRIMARY KEY (id2, id1);


--
-- TOC entry 1662 (class 2606 OID 35933)
-- Dependencies: 1247 1247
-- Name: gruppo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gruppo
    ADD CONSTRAINT gruppo_pkey PRIMARY KEY (id);


--
-- TOC entry 1698 (class 2606 OID 60873)
-- Dependencies: 1294 1294
-- Name: high_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY high
    ADD CONSTRAINT high_pkey PRIMARY KEY (id);


--
-- TOC entry 1688 (class 2606 OID 60828)
-- Dependencies: 1282 1282
-- Name: immagini_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY immagini
    ADD CONSTRAINT immagini_pkey PRIMARY KEY (id);


--
-- TOC entry 1666 (class 2606 OID 35935)
-- Dependencies: 1254 1254
-- Name: movimenti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY movimenti
    ADD CONSTRAINT movimenti_pkey PRIMARY KEY (id);


--
-- TOC entry 1686 (class 2606 OID 60801)
-- Dependencies: 1280 1280
-- Name: news_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- TOC entry 1690 (class 2606 OID 60832)
-- Dependencies: 1283 1283 1283
-- Name: newsimg_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY newsimg
    ADD CONSTRAINT newsimg_pkey PRIMARY KEY (idnews, idimg);


--
-- TOC entry 1696 (class 2606 OID 60880)
-- Dependencies: 1293 1293
-- Name: newsletter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY newsletter
    ADD CONSTRAINT newsletter_pkey PRIMARY KEY (id);


--
-- TOC entry 1674 (class 2606 OID 36094)
-- Dependencies: 1265 1265
-- Name: pagamentosoci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pagamentosoci
    ADD CONSTRAINT pagamentosoci_pkey PRIMARY KEY (id);


--
-- TOC entry 1704 (class 2606 OID 60916)
-- Dependencies: 1297 1297
-- Name: progetti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY progetti
    ADD CONSTRAINT progetti_pkey PRIMARY KEY (id);


--
-- TOC entry 1706 (class 2606 OID 60931)
-- Dependencies: 1298 1298 1298
-- Name: progettiimg_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY progettiimg
    ADD CONSTRAINT progettiimg_pkey PRIMARY KEY (idprogetto, idimg);


--
-- TOC entry 1692 (class 2606 OID 60884)
-- Dependencies: 1291 1291
-- Name: regioni_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY regioni
    ADD CONSTRAINT regioni_pkey PRIMARY KEY (id);


--
-- TOC entry 1664 (class 2606 OID 35937)
-- Dependencies: 1250 1250
-- Name: scrittura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrittura
    ADD CONSTRAINT scrittura_pkey PRIMARY KEY (id);


--
-- TOC entry 1672 (class 2606 OID 36077)
-- Dependencies: 1264 1264
-- Name: socio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY socio
    ADD CONSTRAINT socio_pkey PRIMARY KEY (tessera);


--
-- TOC entry 1694 (class 2606 OID 60882)
-- Dependencies: 1292 1292
-- Name: tipofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipofile
    ADD CONSTRAINT tipofile_pkey PRIMARY KEY (id);


--
-- TOC entry 1668 (class 2606 OID 35939)
-- Dependencies: 1256 1256
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (username);


--
-- TOC entry 1715 (class 2606 OID 52570)
-- Dependencies: 1269 1669 1260
-- Name: adottanti_idanagrafe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY adottanti
    ADD CONSTRAINT adottanti_idanagrafe_fkey FOREIGN KEY (idanagrafe) REFERENCES anagrafe(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1716 (class 2606 OID 52575)
-- Dependencies: 1675 1268 1269
-- Name: adottanti_idbambino_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY adottanti
    ADD CONSTRAINT adottanti_idbambino_fkey FOREIGN KEY (idbambino) REFERENCES bambino(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1717 (class 2606 OID 52580)
-- Dependencies: 1271 1675 1268
-- Name: bambinoanno_idbambino_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bambinoanno
    ADD CONSTRAINT bambinoanno_idbambino_fkey FOREIGN KEY (idbambino) REFERENCES bambino(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1707 (class 2606 OID 35940)
-- Dependencies: 1246 1247 1661
-- Name: conto_gruppo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conto
    ADD CONSTRAINT conto_gruppo_fkey FOREIGN KEY (gruppo) REFERENCES gruppo(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1726 (class 2606 OID 60900)
-- Dependencies: 1280 1296 1685
-- Name: download_idnews_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY download
    ADD CONSTRAINT download_idnews_fkey FOREIGN KEY (idnews) REFERENCES news(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1727 (class 2606 OID 60905)
-- Dependencies: 1693 1296 1292
-- Name: download_idtipofile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY download
    ADD CONSTRAINT download_idtipofile_fkey FOREIGN KEY (idtipofile) REFERENCES tipofile(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1725 (class 2606 OID 60890)
-- Dependencies: 1685 1280 1295
-- Name: eventi_idnews_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY eventi
    ADD CONSTRAINT eventi_idnews_fkey FOREIGN KEY (idnews) REFERENCES news(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1718 (class 2606 OID 60762)
-- Dependencies: 1669 1275 1260
-- Name: famiglia_id1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY famiglia
    ADD CONSTRAINT famiglia_id1_fkey FOREIGN KEY (id1) REFERENCES anagrafe(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1719 (class 2606 OID 60767)
-- Dependencies: 1669 1275 1260
-- Name: famiglia_id2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY famiglia
    ADD CONSTRAINT famiglia_id2_fkey FOREIGN KEY (id2) REFERENCES anagrafe(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1724 (class 2606 OID 60874)
-- Dependencies: 1280 1685 1294
-- Name: high_idnews_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY high
    ADD CONSTRAINT high_idnews_fkey FOREIGN KEY (idnews) REFERENCES news(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1711 (class 2606 OID 35945)
-- Dependencies: 1254 1659 1246
-- Name: movimenti_avere_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movimenti
    ADD CONSTRAINT movimenti_avere_fkey FOREIGN KEY (avere) REFERENCES conto(id);


--
-- TOC entry 1712 (class 2606 OID 35950)
-- Dependencies: 1246 1659 1254
-- Name: movimenti_dare_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movimenti
    ADD CONSTRAINT movimenti_dare_fkey FOREIGN KEY (dare) REFERENCES conto(id);


--
-- TOC entry 1720 (class 2606 OID 60812)
-- Dependencies: 1683 1278 1280
-- Name: news_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY news
    ADD CONSTRAINT news_tipo_fkey FOREIGN KEY (tipo) REFERENCES categorienews(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1721 (class 2606 OID 60817)
-- Dependencies: 1280 1667 1256
-- Name: news_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY news
    ADD CONSTRAINT news_user_fkey FOREIGN KEY ("user") REFERENCES "user"(username) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1723 (class 2606 OID 60838)
-- Dependencies: 1687 1283 1282
-- Name: newsimg_idimg_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY newsimg
    ADD CONSTRAINT newsimg_idimg_fkey FOREIGN KEY (idimg) REFERENCES immagini(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1722 (class 2606 OID 60833)
-- Dependencies: 1283 1280 1685
-- Name: newsimg_idnews_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY newsimg
    ADD CONSTRAINT newsimg_idnews_fkey FOREIGN KEY (idnews) REFERENCES news(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1714 (class 2606 OID 36100)
-- Dependencies: 1265 1671 1264
-- Name: pagamentosoci_tessera_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pagamentosoci
    ADD CONSTRAINT pagamentosoci_tessera_fkey FOREIGN KEY (tessera) REFERENCES socio(tessera) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1729 (class 2606 OID 60922)
-- Dependencies: 1687 1282 1297
-- Name: progetti_idimgluogo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY progetti
    ADD CONSTRAINT progetti_idimgluogo_fkey FOREIGN KEY (idimgluogo) REFERENCES immagini(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1728 (class 2606 OID 60917)
-- Dependencies: 1297 1291 1691
-- Name: progetti_idregione_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY progetti
    ADD CONSTRAINT progetti_idregione_fkey FOREIGN KEY (idregione) REFERENCES regioni(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1731 (class 2606 OID 60937)
-- Dependencies: 1687 1298 1282
-- Name: progettiimg_idimg_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY progettiimg
    ADD CONSTRAINT progettiimg_idimg_fkey FOREIGN KEY (idimg) REFERENCES immagini(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1730 (class 2606 OID 60932)
-- Dependencies: 1298 1703 1297
-- Name: progettiimg_idprogetto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY progettiimg
    ADD CONSTRAINT progettiimg_idprogetto_fkey FOREIGN KEY (idprogetto) REFERENCES progetti(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1710 (class 2606 OID 36061)
-- Dependencies: 1250 1657 1245
-- Name: scrittura_anno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrittura
    ADD CONSTRAINT scrittura_anno_fkey FOREIGN KEY (anno) REFERENCES anno(anno) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1708 (class 2606 OID 35960)
-- Dependencies: 1250 1659 1246
-- Name: scrittura_avere_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrittura
    ADD CONSTRAINT scrittura_avere_fkey FOREIGN KEY (avere) REFERENCES conto(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1709 (class 2606 OID 35965)
-- Dependencies: 1250 1659 1246
-- Name: scrittura_dare_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrittura
    ADD CONSTRAINT scrittura_dare_fkey FOREIGN KEY (dare) REFERENCES conto(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1713 (class 2606 OID 36078)
-- Dependencies: 1669 1260 1264
-- Name: socio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY socio
    ADD CONSTRAINT socio_id_fkey FOREIGN KEY (id) REFERENCES anagrafe(id) ON UPDATE CASCADE ON DELETE CASCADE;

