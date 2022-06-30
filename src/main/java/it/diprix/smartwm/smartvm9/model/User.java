package it.diprix.smartwm.smartvm9.model;

import java.text.DecimalFormat;

public class User {
    private int iduser;
    private String name;
    private String phone;
    private double credit;
    private String email;
    private String user_type;

    public User(){}

    public User(int iduser, String name,String phone, double credit, String email, String user_type) {
        this.iduser = iduser;
        this.name = name;
        this.phone = phone;
        this.credit = credit;
        this.email = email;
        this.user_type = user_type;
    }

    public int getIduser() {
        return iduser;
    }

    public void setIduser(int iduser) {
        this.iduser = iduser;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUser_type() {
        return user_type;
    }

    public void setUser_type(String user_type) {
        this.user_type = user_type;
    }


    public String userIdToString() {
        return "" + iduser;
    }

    public double increaseCredit(double reload){

        double currentCredit = getCredit();
        double newCredit = currentCredit + reload;

        String s = new DecimalFormat("#.##").format(newCredit);

        newCredit = Double.parseDouble(s.replace(",", "."));

        return newCredit;
    }

    public String parseCredit() {
        String amountString = ""+this.credit;
        amountString = amountString.replace(".", ",");
        amountString = amountString + "0";
        return amountString;
    }
}
