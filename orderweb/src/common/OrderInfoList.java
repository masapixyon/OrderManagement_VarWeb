package common;

import java.sql.Date;

public class OrderInfoList {
	private int OrderNumber;
	private Date OrderDate;
	private String CustomName;
	private int CustomCode;
	private String SalesName;
	private String SalesCode;
	private double totalMoney;
	private double tax;
	private double requestMoney;
	

	public OrderInfoList(int OrderNumber, Date OrderDate, String CustomName, 
                       int CustomCode, String SalesName, String SalesCode,
                       double totalMoney, double tax, double requestMoney) {
		this.OrderNumber = OrderNumber;
		this.OrderDate = OrderDate;
		this.CustomName = CustomName;
		this.CustomCode = CustomCode;
		this.SalesName = SalesName;
		this.SalesCode = SalesCode;
		this.totalMoney = totalMoney;
		this.tax = tax;
		this.requestMoney = requestMoney;
	}

	public int getOrderNumber() {
		return OrderNumber;
	}

	public Date getOrderDate() {
		return OrderDate;
	}

	public String getCustomName() {
		return CustomName;
	}

	public int getCustomCode() {
		return CustomCode;
	}

	public String getSalesName() {
		return SalesName;
	}

	public String getSalesCode() {
		return SalesCode;
	}
	
	public double getTotalMoney() {
		return totalMoney;
	}

	public double getTax() {
		return tax;
	}

	public double getRequestMoney() {
		return requestMoney;
	}

}