package common;

public class ErrorStorage {
  static int errorCode = 0;
  static String errorMesseage001 = "ERROR CODE 001 : 入力された商品コードは既に選択済みです";
  static String errorMesseage002 = "ERROR CODE 002 : 商品コードや数量に入力できるのは数値のみです";
  static String errorMesseage003 = "ERROR CODE 003 : 商品選択確定を行うには、受注選択をする必要があります";
  static String errorMesseage004 = "ERROR CODE 004 : 入力された年月日は存在しません";
  static String errorMesseage005 = "ERROR CODE 005 : 検索された文字に該当する受注記録は存在しません";
  
  
  public static int getErrorCode(){
	  return errorCode;
  }
  public void setErrorCode(int errorCode) {
	  this.errorCode = errorCode;
  }
  public static String getErrorMesseage001() {
		return errorMesseage001;
  }
  public static String getErrorMesseage002(){
	  return errorMesseage002;
  }
  public static String getErrorMesseage003(){
	  return errorMesseage003;
  }
  public static String getErrorMesseage004(){
	  return errorMesseage004;
  }
  public static String getErrorMesseage005(){
	  return errorMesseage005;
  }

}
