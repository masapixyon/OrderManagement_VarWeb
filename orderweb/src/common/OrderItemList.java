package common;

public class OrderItemList {
	private int ItemCode;
	private String ItemName;
	private int ItemQuantity;
	private double price;

	public OrderItemList(int ItemCode, String ItemName, int ItemQuantity, double price) {
		this.ItemCode = ItemCode;
		this.ItemName = ItemName;
		this.ItemQuantity = ItemQuantity;
		this.price = price;
	}

	public int getItemCode() {
		return ItemCode;
	}

	public String getItemName() {
		return ItemName;
	}

	public int getItemQuantity() {
		return ItemQuantity;
	}
	
	public double getItemPrice() {
		return price;
	}

}

