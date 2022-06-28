package it.diprix.smartwm.smartvm9.model;

import java.util.List;

public class Machine {
    private int idMachine;
    private String type;
    private String status;
    private double credit;
    private List<MachineProduct> products;

    public Machine() {}

    public Machine(int idMachine, String type, String status, double credit, List<MachineProduct> products) {
        this.idMachine = idMachine;
        this.type = type;
        this.status = status;
        this.credit = credit;
        this.products = products;
    }

    public int getIdMachine() {
        return idMachine;
    }

    public void setIdMachine(int idMachine) {
        this.idMachine = idMachine;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public List<MachineProduct> getProducts() {
        return products;
    }

    public void setProducts(List<MachineProduct> products) {
        this.products = products;
    }
}
