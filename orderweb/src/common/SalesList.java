package common;

public class SalesList {
	public String salesCode;
	public String salesName;
	
	public SalesList(String salesCode, String salesName) {
		this.salesCode = salesCode;
		this.salesName = salesName;
	}
	public String getSalesCode() {
		return salesCode;
	}
	public String getSalesName() {
		return salesName;
	}
}