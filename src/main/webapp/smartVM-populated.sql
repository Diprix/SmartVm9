drop schema if exists diprimio;

create database IF NOT exists diprimio;
use diprimio;

CREATE TABLE diprimio.user (
                               iduser INT NOT NULL auto_increment,
                               name VARCHAR(45) NULL,
                               phone VARCHAR(45) NOT NULL,
                               credit double DEFAULT 0.00,
                               email VARCHAR(45) NOT NULL unique,
                               user_type VARCHAR(45) DEFAULT "customer",
                               password VARCHAR(45) NULL,
                               PRIMARY KEY (iduser));


CREATE TABLE diprimio.machine (
                                  idmachine INT NOT NULL,
                                  type VARCHAR(45) NULL,
                                  status VARCHAR(45) NULL,
                                  credit double DEFAULT 0.00,
                                  position VARCHAR(45) NULL,
                                  PRIMARY KEY (idmachine));




CREATE TABLE diprimio.product (
                                  idproduct INT NOT NULL,
                                  description VARCHAR(255) NULL,
                                  price DOUBLE NULL,
                                  PRIMARY KEY (idproduct));

CREATE TABLE diprimio.stock (
                                idstock INT NOT NULL AUTO_INCREMENT,
                                quantity INT NULL DEFAULT 0,
                                selection VARCHAR(2) NOT NULL,
                                ref_product INT NOT NULL,
                                ref_machine INT NOT NULL,
                                PRIMARY KEY (idstock),
                                INDEX link_machine_idx (ref_machine ASC),
                                INDEX link_product_idx (ref_product ASC),
                                CONSTRAINT link_machine
                                    FOREIGN KEY (ref_machine)
                                        REFERENCES diprimio.machine (idmachine)
                                        ON DELETE NO ACTION
                                        ON UPDATE NO ACTION,
                                CONSTRAINT link_product
                                    FOREIGN KEY (ref_product)
                                        REFERENCES diprimio.product (idproduct)
                                        ON DELETE NO ACTION
                                        ON UPDATE NO ACTION);

CREATE TABLE diprimio.transaction (
                                      idtransaction INT AUTO_INCREMENT,
                                      ref_selection INT NOT NULL,
                                      date_transaction DATE DEFAULT NULL,
                                      cod_user INT NOT NULL,
                                      cod_machine INT NOT NULL,
                                      amount double DEFAULT 0.00,
                                      PRIMARY KEY (idtransaction),


    /*UNIQUE INDEX ref_selection_UNIQUE (ref_selection ASC),*/

                                      KEY selection_idx (cod_user),
                                      KEY selection_machine_idx (cod_machine),
                                      CONSTRAINT selection_machine FOREIGN KEY (cod_machine)
                                          REFERENCES machine (idmachine),
                                      CONSTRAINT selection_user FOREIGN KEY (cod_user)
                                          REFERENCES user (iduser)/*,
    CONSTRAINT link_selection FOREIGN KEY (ref_selection)
        REFERENCES diprimio.stock (idstock)*/

                                          ON DELETE NO ACTION ON UPDATE NO ACTION
);


/* Popolamento tabelle DEMO */


insert into machine(idMachine, type, status, position) values
                                                           ("1234", "snack", "ready", "Viale delle Scienze, Edificio 6, Palermo"),
                                                           ("5678", "drint", "off", "Viale delle Scienze, Edificio 18, Palermo"),
                                                           ("0", "virtual", "off", null),
                                                           ("2468", "snack", "ready", "Viale delle Scienze, Edificio 2, Palermo");

insert into user(name, phone, credit, email, user_type, password) values
                                                                      ("Mario Rossi", "3552645789", 5.44, "mario.rossi@hotmail.it", "CUSTOMER", "password"),
                                                                      ("Luigi Verdi", "3552645789", 125, "luigi.verdi@smartvm.it", "ADMIN", "password"),
                                                                      ("Gianluca Bianchi", "3552645789", 2.44, "gianluca.bianchi@gmail.it", "TECHNICAL", "password");

insert into product(idproduct, description, price) values
                                                       (0, "RICARICA", 0),
                                                       (1236, "Patatine Piccanti", 0.5),
                                                       (3871, "Patatine Classiche", 0.5),
                                                       (6971, "Cioccolato Fondente", 0.6),
                                                       (3684, "Acqua Frizzante", 0.4),
                                                       (6985, "Krapfen", 0.7),
                                                       (3674, "Acqua Minerale", 0.5),
                                                       (3655, "Hamburger", 0.5),
                                                       (1648, "Cocacola", 0.8),
                                                       (3195, "Burritos Vegetariano", 1),
                                                       (6987, "Birra 0.5", 1.2),
                                                       (7536, "Pancake", 1.2),
                                                       (3412, "Cheesecake", 0.6),
                                                       (3179, "Biscotti Cocco", 0.6),
                                                       (3171, "Tamezzino Tonno", 1),
                                                       (8197, "Sandwich", 1),
                                                       (1761, "Hot Dog", 1),
                                                       (5612, "Taco Chili", 1),
                                                       (5146, "Donuts Cioccolato", 1),
                                                       (7568, "Panino Mortadella", 1),

                                                       (9846, "Caffe Corto", 0.4),
                                                       (9854, "Caffe Lungo", 0.5),
                                                       (9853, "Caffe DEK", 0.6),
                                                       (9785, "Cioccolata", 0.5),
                                                       (9154, "The", 0.5);

insert into stock(quantity, selection, ref_product, ref_machine) values
                                                                     (0, "0", 0, 0),
                                                                     (10, "A1", 1236, 1234),
                                                                     (10, "A2", 3871, 1234),
                                                                     (10, "A3", 6971, 1234),
                                                                     (10, "B4", 3674, 1234),
                                                                     (1, "B5", 1648, 1234),
                                                                     (4, "B6", 6987, 1234),
                                                                     (1, "C7", 3171, 1234),
                                                                     (10, "C8", 5612, 1234),
                                                                     (10, "C9", 5146, 1234),

                                                                     (10, "A1", 3684, 2468),
                                                                     (4, "A2", 6985, 2468),
                                                                     (1, "C7", 3655, 2468),
                                                                     (10, "B4", 3195, 2468),
                                                                     (5, "A3", 7536, 2468),
                                                                     (10, "B6", 3412, 2468),
                                                                     (10, "B5", 3179, 2468),
                                                                     (8, "C8", 8197, 2468),
                                                                     (8, "C9", 1761, 2468),


                                                                     (10, "A1", 9846, 5678),
                                                                     (10, "A2", 9854, 5678),
                                                                     (10, "A3", 9853, 5678),
                                                                     (10, "B4", 9785, 5678),
                                                                     (10, "B5", 9154, 5678);