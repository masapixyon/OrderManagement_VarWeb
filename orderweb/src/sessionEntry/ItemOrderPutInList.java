package sessionEntry;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import common.SelectModel;
import common.ItemList;

public class ItemOrderPutInList {
	String itemName;
	int itemCode;
	double itemPrice;
	
	int itemOrderCode;
	static int errorCode;
	
	double totalMoney = 0.0;
	double totalTax = 0.0;
	double reqestMoney = 0.0;
	
	static ArrayList<ItemOrderList> itemOrderList = new ArrayList<ItemOrderList>();
	
	public ArrayList<ItemOrderList> getItemOrderList(HttpServletRequest request) {
		
		SelectModel itemCodeSearchModel = (SelectModel) request.getAttribute("itemCodeSearchModel");
		
		if(itemCodeSearchModel != null){
			ArrayList<ItemList> itemList = itemCodeSearchModel.getItemListResults();
			outside: for (ItemList item : itemList) {

				//商品コード重複時にブレイク
				//itemOrderListのitemCodeとitemListのitemCodeが同じ場合addしない
				errorCode = 0;
				for (ItemOrderList itemOrder : itemOrderList) {
					int itemOrderCode = itemOrder.getItemCode();
					if(item.getItemCode() != itemOrderCode){
						errorCode = 0;
					}else if (item.getItemCode() == itemOrderCode){
						errorCode = 1;
						break outside;
					}
				}


				itemCode = item.getItemCode();
				itemName = item.getItemName();
				itemPrice = item.getItemPrice();

				String tempItemQuantity = request.getParameter( "quantity" );
				int itemQuantity = Integer.parseInt(tempItemQuantity);
				double amountOfMoney = Math.floor(itemPrice * itemQuantity); 
				double taxIncluded = Math.floor(((amountOfMoney  * 0.08 ) + amountOfMoney));


				//合計金額,消費税金額,請求金額の足し掛け
				//これら3つはaddする前の初期値
				totalMoney = amountOfMoney;
				totalTax = (taxIncluded - amountOfMoney);
				reqestMoney = taxIncluded;

				for (ItemOrderList iol : itemOrderList) {
					totalMoney = iol.getTotalMoney() + amountOfMoney;
					totalTax = iol.getTotalTax() + (taxIncluded-amountOfMoney);
					reqestMoney = iol.getReqestMoney() + (taxIncluded);
				}

				ItemOrderList IOL = new ItemOrderList(itemCode, itemName, itemPrice,itemQuantity,amountOfMoney, taxIncluded, 
						totalMoney, totalTax, reqestMoney);
				itemOrderList.add( IOL );
			}
		}

		return itemOrderList;
	}
	public static ArrayList<ItemOrderList> getList() {
		return itemOrderList;
	}
	public static int getErrorCode() {
		return errorCode;
	}
}
