--
-- PostgreSQL database dump
--

\restrict isci06ccT1iLmpdfsOiobEUQRe36uVnGNRXbeKpzjJftak0QI1GzBzzdS3c1S44

-- Dumped from database version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: profesionales; Type: TABLE; Schema: public; Owner: turnero_app
--

CREATE TABLE public.profesionales (
    id integer NOT NULL,
    nombre character varying(120) NOT NULL,
    especialidad character varying(80) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.profesionales OWNER TO turnero_app;

--
-- Name: profesionales_id_seq; Type: SEQUENCE; Schema: public; Owner: turnero_app
--

CREATE SEQUENCE public.profesionales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.profesionales_id_seq OWNER TO turnero_app;

--
-- Name: profesionales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turnero_app
--

ALTER SEQUENCE public.profesionales_id_seq OWNED BY public.profesionales.id;


--
-- Name: turnos; Type: TABLE; Schema: public; Owner: turnero_app
--

CREATE TABLE public.turnos (
    id integer NOT NULL,
    profesional_id integer NOT NULL,
    paciente_nombre character varying(120) NOT NULL,
    paciente_email character varying(160) NOT NULL,
    fecha_hora timestamp with time zone NOT NULL,
    estado character varying(20) DEFAULT 'reservado'::character varying NOT NULL,
    notas character varying(500) DEFAULT ''::character varying NOT NULL,
    creado_en timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT estado_valido CHECK (((estado)::text = ANY ((ARRAY['reservado'::character varying, 'confirmado'::character varying, 'atendido'::character varying, 'cancelado'::character varying])::text[])))
);


ALTER TABLE public.turnos OWNER TO turnero_app;

--
-- Name: turnos_id_seq; Type: SEQUENCE; Schema: public; Owner: turnero_app
--

CREATE SEQUENCE public.turnos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.turnos_id_seq OWNER TO turnero_app;

--
-- Name: turnos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: turnero_app
--

ALTER SEQUENCE public.turnos_id_seq OWNED BY public.turnos.id;


--
-- Name: profesionales id; Type: DEFAULT; Schema: public; Owner: turnero_app
--

ALTER TABLE ONLY public.profesionales ALTER COLUMN id SET DEFAULT nextval('public.profesionales_id_seq'::regclass);


--
-- Name: turnos id; Type: DEFAULT; Schema: public; Owner: turnero_app
--

ALTER TABLE ONLY public.turnos ALTER COLUMN id SET DEFAULT nextval('public.turnos_id_seq'::regclass);


--
-- Data for Name: profesionales; Type: TABLE DATA; Schema: public; Owner: turnero_app
--

COPY public.profesionales (id, nombre, especialidad, activo) FROM stdin;
1	Dra. Adriana Ferreyra	Clínica médica	t
2	Dr. Martín Quiroga	Traumatología	t
3	Lic. Paula Benítez	Nutrición	t
4	Dr. Esteban Roldán	Cardiología	t
5	Dra. Inés Colombo	Dermatología	f
\.


--
-- Data for Name: turnos; Type: TABLE DATA; Schema: public; Owner: turnero_app
--

COPY public.turnos (id, profesional_id, paciente_nombre, paciente_email, fecha_hora, estado, notas, creado_en) FROM stdin;
1	1	Rocío Almada	rocio.almada@ejemplo.com	2026-11-02 09:00:00+00	confirmado	Control anual	2026-10-29 18:30:46.460402+00
2	1	Julián Costa	julian.costa@ejemplo.com	2026-11-02 09:30:00+00	reservado		2026-10-29 18:30:46.462368+00
3	2	Mariana Tévez	mariana.tevez@ejemplo.com	2026-11-02 10:00:00+00	reservado	Dolor lumbar	2026-10-29 18:30:46.463628+00
4	3	Federico Ledesma	f.ledesma@ejemplo.com	2026-11-03 09:00:00+00	confirmado		2026-10-29 18:30:46.464705+00
5	4	Sofía Barrionuevo	sofia.b@ejemplo.com	2026-11-03 11:30:00+00	reservado	Trae electrocardiograma	2026-10-29 18:30:46.465715+00
6	2	Gonzalo Iturbe	gonzalo.iturbe@ejemplo.com	2026-11-04 10:30:00+00	cancelado	Reprograma	2026-10-29 18:30:46.466665+00
7	1	Lucía Maidana	lucia.maidana@ejemplo.com	2026-11-04 12:00:00+00	atendido		2026-10-29 18:30:46.467597+00
8	3	Ramiro Pérez	ramiro.perez@ejemplo.com	2026-11-05 09:30:00+00	reservado	Primera consulta	2026-10-29 18:30:46.468525+00
\.


--
-- Name: profesionales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turnero_app
--

SELECT pg_catalog.setval('public.profesionales_id_seq', 5, true);


--
-- Name: turnos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: turnero_app
--

SELECT pg_catalog.setval('public.turnos_id_seq', 8, true);


--
-- Name: profesionales profesionales_pkey; Type: CONSTRAINT; Schema: public; Owner: turnero_app
--

ALTER TABLE ONLY public.profesionales
    ADD CONSTRAINT profesionales_pkey PRIMARY KEY (id);


--
-- Name: turnos turnos_pkey; Type: CONSTRAINT; Schema: public; Owner: turnero_app
--

ALTER TABLE ONLY public.turnos
    ADD CONSTRAINT turnos_pkey PRIMARY KEY (id);


--
-- Name: idx_turnos_fecha; Type: INDEX; Schema: public; Owner: turnero_app
--

CREATE INDEX idx_turnos_fecha ON public.turnos USING btree (fecha_hora);


--
-- Name: idx_turnos_profesional; Type: INDEX; Schema: public; Owner: turnero_app
--

CREATE INDEX idx_turnos_profesional ON public.turnos USING btree (profesional_id, fecha_hora);


--
-- Name: idx_turnos_sin_superposicion; Type: INDEX; Schema: public; Owner: turnero_app
--

CREATE UNIQUE INDEX idx_turnos_sin_superposicion ON public.turnos USING btree (profesional_id, fecha_hora) WHERE ((estado)::text <> 'cancelado'::text);


--
-- Name: turnos turnos_profesional_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: turnero_app
--

ALTER TABLE ONLY public.turnos
    ADD CONSTRAINT turnos_profesional_id_fkey FOREIGN KEY (profesional_id) REFERENCES public.profesionales(id);


--
-- PostgreSQL database dump complete
--

\unrestrict isci06ccT1iLmpdfsOiobEUQRe36uVnGNRXbeKpzjJftak0QI1GzBzzdS3c1S44

