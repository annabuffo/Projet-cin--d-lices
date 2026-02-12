-----------------------------------
--Table : public.utilisateur
-----------------------------------

CREATE TABLE public."utilisateur" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    email TEXT,
    passeword TEXT,
    pseudo TEXT,
    role TEXT,
    date_inscriptionn TIMESTAMP
);

-----------------------------------
--Table : public.recette
-----------------------------------

CREATE TABLE public."recette" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_user ,
    id_categorie,
    title VARCHAR(255) NOT NULL, 
    description VARCHAR(255) NOT NULL,
    ingredients TEXT,
    instructions TEXT,
    image,
    temps_préparation,
    temps_cuisson,
    portions,
    difficultes,
    publiee TIMESTAMP,
    date_creation TIMESTAMP,
    date_modification TIMESTAMP
);

-----------------------------------
--Table : public.categorie
-----------------------------------

CREATE TABLE public."catégorie" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom TEXT,
    description TEXT
);

-----------------------------------
--Table : public.film
-----------------------------------

CREATE TABLE public."film" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    annee ,
    type BOOLEAN,
    affiche_url TEXT,
    tmbd_id INTEGER NOT NULL 
);

-----------------------------------
--Table : public.favori (optionnel)
-----------------------------------
CREATE TABLE public."favori" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_ajout TIMESTAMP
);

-----------------------------------------
--Table : public.commentaire (optionnel)
-----------------------------------------

CREATE TABLE public."commentaire" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    contenu TEXT,
    approuve BOOLEAN,
    date_creation TIMESTAMP
);

-----------------------------------
--Table : public.note (optionnel)
-----------------------------------

CREATE TABLE public."note" (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    valeur BOOLEAN,
    date_creation TIMESTAMP
)


------------------------------------------------------------
--Table : public.utilisateur_has_recette (association many to many)
---------------------------------------

CREATE TABLE public.utilisateur_has_recette (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_utilisateur INTEGER NOT NULL,
    id_recette INTEGER NOT NULL,

    CONSTRAINT fk_cht_recette
    FOREIGN KEY (id_recette)
    REFERENCES public.recette(id)
    ON DELETE CASCADE,

    CONSTRAINT fk_cht_utilisateur
    FOREIGN KEY (id_utilisateur)
    REFERENCES public.utilisateur(id)
    ON DELETE CASCADE,
);

---------------------------------------
--Table : public.recette_has_categorie (association many to many)
---------------------------------------

CREATE TABLE public.recette_has_categorie (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_recette INTEGER NOT NULL,
    id_categorie INTEGER NOT NULL,

    CONSTRAINT fk_cht_categorie
        FOREIGN KEY (id_categorie)
        REFERENCES public.categorie(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_cht_recette
        FOREIGN KEY (id_recette)
        REFERENCES public.recette(id)
        ON DELETE CASCADE,

    CONSTRAINT uq_cht_categorie_recette UNIQUE (categotie_id, recette_id)
);


------------------------------------------------------------
--Table : public.recette_has_film (association many to many)
---------------------------------------

CREATE TABLE public.recette_has_film (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_recette INTEGER NOT NULL,
    id_film INTEGER NOT NULL,

    CONSTRAINT fk_cht_film
        FOREIGN KEY (id_film)
        REFERENCES public.film(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_cht_recette
        FOREIGN KEY (id_recette)
        REFERENCES public.recette(id)
        ON DELETE CASCADE,

    CONSTRAINT up_cht_film_recette UNIQUE (film_id, recette_id)
);

------------------------------------------------------------
--Table : public.utilisateur_has_favori (OPTIONNEL)
---------------------------------------

CREATE TABLE public.utilisateur_has_favori (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_utilisateur INTEGER NOT NULL,
    id_favori INTEGER NOT NULL,

    CONSTRAINT fk_cht_favori
        FOREIGN KEY (id_favori)
        REFERENCES public.favori(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_cht_utilisateur
        FOREIGN KEY (id_utilisateur)
        REFERENCES public.utilisateur(id)
        ON DELETE CASCADE,
    
    CONSTRAINT up_cht_favori_utilisateur UNIQUE (favori_id, utilisateur_id)
);

------------------------------------------------------------
--Table : public.recette_has_favori (OPTIONNEL)
---------------------------------------

CREATE TABLE public.recette_has_favori (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_recette INTEGER NOT NULL,
    id_favori INTEGER NOT NULL,

    CONSTRAINT fk_cht_favori
        FOREIGN KEY (id_favori)
        REFERENCES public.favori(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_cht_recette
        FOREIGN KEY (id_recette)
        REFERENCES public.recette(id)
        ON DELETE CASCADE,

    CONSTRAINT up_cht_favori_recette UNIQUE (favori_id, recette_id)
);

------------------------------------------------------------
--Table : public.utilistauer_has_favori (OPTIONNEL)
---------------------------------------

CREATE TABLE public.utilisateur_has_favori (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_utilisatuer INTEGER NOT NULL,
    id_favori INTEGER NOT NULL,

    CONSTRAINT fk_cht_favori
        FOREIGN KEY (id_favori)
        REFERENCES public.favori(id)
        ON DELETE CASCADE,
    
    CONSTRAINT fk_cht_utiisateur
        FOREIGN KEY (id_utilisateur)
        REFERENCES public.utilisateur(id)
        ON DELETE CASCADE,

    CONSTRAINT up_cht_favori_utilisateur UNIQUE (favori_id, utilisateur_id)
);

------------------------------------------------------------
--Table : public.recette_has_commentaire (OPTIONNEL)
---------------------------------------

CREATE TABLE public.recette_has_commentaire (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_recette INTEGER NOT NULL,
    id_commentaire INTEGER NOT NULL,

    CONSTRAINT fk_cht_commentaire
        FOREIGN KEY (id_commentaire)
        REFERENCES public.commentaire(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_cht_recette
        FOREIGN KEY (id_recette)
        REFERENCES public.recette(id)
        ON DELETE CASCADE,

    CONSTRAINT up_cht_commentaire_recette UNIQUE (commentaire_id, recette_id)
);

------------------------------------------------------------
--Table : public.utilisateur_has_note (OPTIONNEL)
---------------------------------------

CREATE TABLE public.utilisateur_has_note (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_utilisateur INTEGER NOT NULL,
    id_note INTEGER NOT NULL,

    CONSTRAINT fk_cht_note
        FOREIGN KEY (id_note)
        REFERENCES public.note(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_cht_utilisateur
        FOREIGN KEY (id_utilisateur)
        REFERENCES public.utilisateur(id)
        ON DELETE CASCADE,

     CONSTRAINT up_cht_note_utilisateur UNIQUE (note_id, utilisateur_id)
);

------------------------------------------------------------
--Table : public.recette_has_note (OPTIONNEL)
---------------------------------------

CREATE TABLE public.recette_has_note (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_recette INTEGER NOT NULL,
    id_note INTEGER NOT NULL,

    CONSTRAINT fk_cht_recette
        FOREIGN KEY (id_recette)
        REFERENCES public.recette(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_cht_note
        FOREIGN KEY (id_note)
        REFERENCES public.note(id)
        ON DELETE CASCADE,

    CONSTRAINT up_cht_recette_note UNIQUE (recette_id, note_id)
);