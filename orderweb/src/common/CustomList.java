package common;

public class CustomList {
	public String customName;
	public int customCode;

	public CustomList(int customCode, String customName) {
		this.customCode = customCode;
		this.customName = customName;
	}
	public CustomList(String customName) {

		this.customName = customName;
	}
	public int getCustomCode() {
		return customCode;
	}
	public String getCustomName() {
		return customName;
	}
}