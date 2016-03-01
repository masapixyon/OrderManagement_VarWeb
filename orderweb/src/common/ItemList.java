package common;

public class ItemList {
    private int itemCode;
    private String itemName;
    private double price;
	public ItemList(int itemCode, String itemName, double price) {
        this.itemCode = itemCode;
        this.itemName = itemName;
        this.price = price;
	}

	public int getItemCode() {
		return itemCode;
	}
	
	public String getItemName() {
		return itemName;
	}
	public double getItemPrice() {
	    return price;
    }
}
