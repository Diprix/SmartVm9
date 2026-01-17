package it.diprix.smartwm.smartvm9.model;

public class MachineProduct {
    private int productID;
    private String description;
    private double price;
    private int qty;
    private String selection;

    public MachineProduct() {}

    public MachineProduct(int productID, String description, double price, int qty, String selection) {
        this.productID = productID;
        this.description = description;
        this.price = price;
        this.qty = qty;
        this.selection = selection;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public String getSelection() {
        return selection;
    }

    public void setSelection(String selection) {
        this.selection = selection;
    }
}
