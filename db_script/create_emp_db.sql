-- Table: public.employees

-- DROP TABLE public.employees;

CREATE TABLE public.employees
(
    name text COLLATE pg_catalog."default" NOT NULL,
    title text COLLATE pg_catalog."default" NOT NULL,
    department text COLLATE pg_catalog."default" NOT NULL,
    location text COLLATE pg_catalog."default" NOT NULL,
    emp_image text COLLATE pg_catalog."default",
    id integer NOT NULL DEFAULT nextval('employees_id_seq'::regclass)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.employees
    OWNER to postgres;