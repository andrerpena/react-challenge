--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.5.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET search_path = public, pg_catalog;

--
-- Name: ptu; Type: TEXT SEARCH CONFIGURATION; Schema: public; Owner: postgres
--

CREATE TEXT SEARCH CONFIGURATION ptu (
    PARSER = pg_catalog."default" );

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR asciiword WITH portuguese_stem;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR word WITH unaccent, portuguese_stem;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR numword WITH simple;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR email WITH simple;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR url WITH simple;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR host WITH simple;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR sfloat WITH simple;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR version WITH simple;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR hword_numpart WITH simple;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR hword_part WITH unaccent, portuguese_stem;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR hword_asciipart WITH portuguese_stem;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR numhword WITH simple;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR asciihword WITH portuguese_stem;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR hword WITH unaccent, portuguese_stem;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR url_path WITH simple;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR file WITH simple;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR "float" WITH simple;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR "int" WITH simple;

ALTER TEXT SEARCH CONFIGURATION ptu
    ADD MAPPING FOR uint WITH simple;


ALTER TEXT SEARCH CONFIGURATION ptu OWNER TO postgres;

--
-- Name: su; Type: TEXT SEARCH CONFIGURATION; Schema: public; Owner: postgres
--

CREATE TEXT SEARCH CONFIGURATION su (
    PARSER = pg_catalog."default" );

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR asciiword WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR word WITH unaccent, simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR numword WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR email WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR url WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR host WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR sfloat WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR version WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR hword_numpart WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR hword_part WITH unaccent, simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR hword_asciipart WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR numhword WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR asciihword WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR hword WITH unaccent, simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR url_path WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR file WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR "float" WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR "int" WITH simple;

ALTER TEXT SEARCH CONFIGURATION su
    ADD MAPPING FOR uint WITH simple;


ALTER TEXT SEARCH CONFIGURATION su OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: geo_city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE geo_city (
    id integer NOT NULL,
    geonameid integer NOT NULL,
    name character varying(100) NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    stateid integer,
    population integer NOT NULL
);


ALTER TABLE geo_city OWNER TO postgres;

--
-- Name: geo_state; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE geo_state (
    id integer NOT NULL,
    geonameid integer NOT NULL,
    population integer NOT NULL,
    name character varying(100) NOT NULL,
    shortname character varying(2) NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL
);


ALTER TABLE geo_state OWNER TO postgres;

--
-- Name: geo_states_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE geo_states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geo_states_id_seq OWNER TO postgres;

--
-- Name: geo_states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE geo_states_id_seq OWNED BY geo_state.id;


--
-- Name: get_city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE get_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE get_city_id_seq OWNER TO postgres;

--
-- Name: get_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE get_city_id_seq OWNED BY geo_city.id;


--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE notification (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    read boolean DEFAULT false NOT NULL,
    type smallint NOT NULL,
    data json NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE notification OWNER TO postgres;

--
-- Name: COLUMN notification.read; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notification.read IS 'Whether or not the user has read the notification';


--
-- Name: COLUMN notification.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notification.type IS 'Notification type. This is an enum/const that will be defined in code';


--
-- Name: COLUMN notification.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notification.user_id IS 'The user the notification is for';


--
-- Name: notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notification_id_seq OWNER TO postgres;

--
-- Name: notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE notification_id_seq OWNED BY notification.id;


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_id_seq OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "user" (
    id integer DEFAULT nextval('user_id_seq'::regclass) NOT NULL,
    display_name character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    photo_url character varying(255),
    oauth_profiles json
);


ALTER TABLE "user" OWNER TO postgres;

--
-- Name: COLUMN "user".oauth_profiles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN "user".oauth_profiles IS 'A JSON containing information returned by OAuth providers';


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY geo_city ALTER COLUMN id SET DEFAULT nextval('get_city_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY geo_state ALTER COLUMN id SET DEFAULT nextval('geo_states_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notification ALTER COLUMN id SET DEFAULT nextval('notification_id_seq'::regclass);


--
-- Name: geo_city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY geo_city
    ADD CONSTRAINT geo_city_pkey PRIMARY KEY (id);


--
-- Name: geo_states_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY geo_state
    ADD CONSTRAINT geo_states_pkey PRIMARY KEY (id);


--
-- Name: notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: user_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_unique UNIQUE (email);


--
-- Name: user_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_id_pk PRIMARY KEY (id);


--
-- Name: geo_city_geonameid_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX geo_city_geonameid_uindex ON geo_city USING btree (geonameid);


--
-- Name: geo_city_name_tsindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX geo_city_name_tsindex ON geo_city USING gin (to_tsvector('su'::regconfig, (name)::text));


--
-- Name: geo_states_geoNameId_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "geo_states_geoNameId_uindex" ON geo_state USING btree (geonameid);


--
-- Name: geo_states_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX geo_states_id_uindex ON geo_state USING btree (id);


--
-- Name: geo_states_name_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX geo_states_name_uindex ON geo_state USING btree (name);


--
-- Name: get_city_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX get_city_id_uindex ON geo_city USING btree (id);


--
-- Name: user_email_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_email_uindex ON "user" USING btree (email);


--
-- Name: geo_city_geo_state_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY geo_city
    ADD CONSTRAINT geo_city_geo_state_id_fk FOREIGN KEY (stateid) REFERENCES geo_state(id);


--
-- Name: notification_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_user_id_fk FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

