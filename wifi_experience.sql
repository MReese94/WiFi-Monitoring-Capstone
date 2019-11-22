PGDMP         )            
    w            wifi_experience    11.5 (Debian 11.5-1+deb10u1)    11.5     a           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            b           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            c           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            d           1262    16385    wifi_experience    DATABASE     �   CREATE DATABASE wifi_experience WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE wifi_experience;
             postgres    false                        2615    16386    wifi_experience    SCHEMA        CREATE SCHEMA wifi_experience;
    DROP SCHEMA wifi_experience;
             node    false            �            1255    16387    notify_event()    FUNCTION     }  CREATE FUNCTION public.notify_event() RETURNS trigger
    LANGUAGE plpgsql
    AS $$    DECLARE 
        data json;
        notification json;
    
    BEGIN
        -- Contruct the notification as a JSON string.
        notification = json_build_object(
                          'table',TG_TABLE_NAME,
                          'action', TG_OP,
                          'data', data);
        
                        
        -- Execute pg_notify(channel, notification)
        PERFORM pg_notify('live_update',notification::text);
        
        -- Result is ignored since this is an AFTER trigger
		RETURN data;
    END;
    
$$;
 %   DROP FUNCTION public.notify_event();
       public       postgres    false            �            1259    24646    ssid    TABLE     �  CREATE TABLE wifi_experience.ssid (
    network_id integer NOT NULL,
    network_name character varying NOT NULL,
    frequency character varying NOT NULL,
    address character varying NOT NULL,
    encryption character varying NOT NULL,
    signal_level smallint NOT NULL,
    channel character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    mac character varying
);
 !   DROP TABLE wifi_experience.ssid;
       wifi_experience         node    false    6            �            1259    24672    realtime_view    VIEW     �   CREATE VIEW public.realtime_view AS
 SELECT ssid.network_id,
    ssid.network_name,
    ssid.frequency,
    ssid.address,
    ssid.encryption,
    ssid.signal_level,
    ssid.channel,
    ssid.created_at,
    ssid.mac
   FROM wifi_experience.ssid;
     DROP VIEW public.realtime_view;
       public       postgres    false    198    198    198    198    198    198    198    198    198            �            1259    24644    ssid_network_id_seq    SEQUENCE     �   CREATE SEQUENCE wifi_experience.ssid_network_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE wifi_experience.ssid_network_id_seq;
       wifi_experience       node    false    198    6            e           0    0    ssid_network_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE wifi_experience.ssid_network_id_seq OWNED BY wifi_experience.ssid.network_id;
            wifi_experience       node    false    197            �
           2604    24649    ssid network_id    DEFAULT     �   ALTER TABLE ONLY wifi_experience.ssid ALTER COLUMN network_id SET DEFAULT nextval('wifi_experience.ssid_network_id_seq'::regclass);
 G   ALTER TABLE wifi_experience.ssid ALTER COLUMN network_id DROP DEFAULT;
       wifi_experience       node    false    198    197    198            ^          0    24646    ssid 
   TABLE DATA               �   COPY wifi_experience.ssid (network_id, network_name, frequency, address, encryption, signal_level, channel, created_at, mac) FROM stdin;
    wifi_experience       node    false    198   �       f           0    0    ssid_network_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('wifi_experience.ssid_network_id_seq', 131997, true);
            wifi_experience       node    false    197            �
           2606    24655    ssid ssid_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY wifi_experience.ssid
    ADD CONSTRAINT ssid_pkey PRIMARY KEY (network_id);
 A   ALTER TABLE ONLY wifi_experience.ssid DROP CONSTRAINT ssid_pkey;
       wifi_experience         node    false    198            �
           2620    24656    ssid live_notify_event    TRIGGER     �   CREATE TRIGGER live_notify_event AFTER INSERT OR UPDATE ON wifi_experience.ssid FOR EACH STATEMENT EXECUTE PROCEDURE public.notify_event();
 8   DROP TRIGGER live_notify_event ON wifi_experience.ssid;
       wifi_experience       node    false    198    200            ^      x������ � �     