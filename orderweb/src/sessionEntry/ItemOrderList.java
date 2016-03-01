package sessionEntry;

public class ItemOrderList {
	private int itemCode;
	private String itemName;
	private double price;
	private int itemQuantity;
	private double amountOfMoney;
	private double taxIncluded;
	
	private double totalMoney;
	private double totalTax;
	private double reqestMoney;

	public ItemOrderList(int itemCode, String itemName, double price, int itemQuantity, 
			double amountOfMoney, double taxIncluded,
			double totalMoney, double totalTax, double reqestMoney) {
		this.itemCode = itemCode;
		this.itemName = itemName;
		this.price = price;
		this.itemQuantity = itemQuantity;
		this.amountOfMoney = amountOfMoney;
		this.taxIncluded = taxIncluded;
		this.totalMoney = totalMoney;
		this.totalTax = totalTax;
		this.reqestMoney = reqestMoney;
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
	public int getItemQuantity(){
		return itemQuantity;
	}

	public double getAmountOfMoney() {
		return amountOfMoney;
	}              
	public double getTaxIncluded() {
		return taxIncluded;
	}
	
	public double getTotalMoney() {
		return totalMoney;
	}

	public double getTotalTax() {
		return totalTax;
	}

	public double getReqestMoney() {
		return reqestMoney;
	}



}
