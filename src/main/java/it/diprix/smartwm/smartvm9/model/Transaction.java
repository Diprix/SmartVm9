package it.diprix.smartwm.smartvm9.model;

import java.sql.Date;

public class Transaction {

    private int idTransaction;
    private int idProduct;
    private int idUser;
    private Date date;
    private int idMachine;
    private double amount;

    public Transaction() {}

    public Transaction(int idTransaction, int idProduct, int idUser, Date date, int idMachine, double amount) {
        this.idTransaction = idTransaction;
        this.idProduct = idProduct;
        this.idUser = idUser;
        this.date = date;
        this.idMachine = idMachine;
        this.amount = amount;
    }

    public int getIdTransaction() {
        return idTransaction;
    }

    public void setIdTransaction(int idTransaction) {
        this.idTransaction = idTransaction;
    }

    public int getIdProduct() {
        return idProduct;
    }

    public void setIdProduct(int idProduct) {
        this.idProduct = idProduct;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getIdMachine() {
        return idMachine;
    }

    public void setIdMachine(int idMachine) {
        this.idMachine = idMachine;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    @Override
    public String toString() {
        return "Transaction{" +
                "idTransaction=" + idTransaction +
                ", idProduct=" + idProduct +
                ", idUser=" + idUser +
                ", date=" + date +
                ", idMachine=" + idMachine +
                ", amount=" + amount +
                '}';
    }
}

