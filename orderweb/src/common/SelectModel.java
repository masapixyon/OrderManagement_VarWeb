package common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import common.DBconnetion;

public class SelectModel {
	private ArrayList<OrderInfoList> orderInfoList = new ArrayList<>();
	private ArrayList<OrderItemList> orderItemList = new ArrayList<>();
	private ArrayList<ItemList> itemList = new ArrayList<>();
	private ArrayList<CustomList> customList = new ArrayList<>();
	private ArrayList<SalesList> salesList = new ArrayList<>();
	private static PreparedStatement pstmt;
	private static ResultSet resultSet;
	private static Connection conn = null;
	private static Statement stmt = null;


	/**********
	 * 顧客検索
	 * @UseSession Search
	 ***********/
	
	public ArrayList<OrderInfoList> getOrderList(String customName) {
		try {
			conn = DBconnetion.connectDatabase();
			pstmt = conn.prepareStatement( "SELECT order_title.order_no, order_title.order_date, order_title.custom_c, order_title.total_amount, order_title.sales_tax, order_title.bill, custom.custom_nam, order_title.sales_c, sales.sales_nam "
					+ "FROM order_title, custom, sales WHERE (order_title.custom_c = custom.custom_c) AND (order_title.sales_c = sales.sales_c) AND custom.custom_nam LIKE ? ORDER BY order_no" );

			pstmt.setString( 1, "%" + customName + "%" );
			
			resultSet = pstmt.executeQuery();
			while ( resultSet.next() ) {
				OrderInfoList it = new OrderInfoList(
						resultSet.getInt("order_no"),
						resultSet.getDate("order_date"),
						resultSet.getString("custom_nam"),
						resultSet.getInt("custom_c"),
						resultSet.getString("sales_nam"),
						resultSet.getString("sales_c"),
						resultSet.getDouble("total_amount"),
						resultSet.getDouble("sales_tax"),
						resultSet.getDouble("bill"));
				orderInfoList.add( it );
			}
		}
		catch (SQLException ex) {
		System.out.println( "エラーコード：" + ex.getErrorCode() );
			System.out.println( "SQL状態：" + ex.getSQLState() );
			ex.printStackTrace();
		}
		try {
			if ( pstmt != null ) {
				pstmt.close();
			}
		}catch ( SQLException ex ) {
			ex.printStackTrace();
		}
		try {
			if ( resultSet != null ) {
				resultSet.close();
			}
		}catch ( SQLException ex ) {
			ex.printStackTrace();
		}
		return orderInfoList;
	}
	
	public ArrayList<OrderInfoList> getOrderInfoListResults(){
		return orderInfoList;
	}
	public boolean getJudgeToHaveOrderInfoList(){
		boolean errorJudge = true;
		if(orderInfoList.size() == 0){
			errorJudge = false;
		}
		return errorJudge;
	}
	
	
	/**********
	 * 顧客番号をパラメータに受注商品検索
	 * @UseSession Search
	 ***********/

	public ArrayList<OrderItemList> getOrderItemList(int orderNumber) {
		try {
			itemList.clear();
			Connection conn = DBconnetion.connectDatabase();
			pstmt = conn.prepareStatement( "SELECT order_detail.quantity,item.item_c, item.item_nam, item.price FROM order_title, order_detail, item "
					+ "WHERE (order_title.order_no = order_detail.order_no) AND (order_detail.item_c = item.item_c) AND order_title.order_no = ?");

			pstmt.setInt( 1, orderNumber );
			resultSet = pstmt.executeQuery();
			while ( resultSet.next() ) {
				OrderItemList item = new OrderItemList(
						resultSet.getInt( "item_c" ),
						resultSet.getString( "item_nam" ),
						resultSet.getInt( "quantity" ),
						resultSet.getDouble( "price" ));
				orderItemList.add( item );
			}
		}
		catch (SQLException ex) {
			System.out.println( "エラーコード：" + ex.getErrorCode() );
			System.out.println( "SQL状態：" + ex.getSQLState() );
			ex.printStackTrace();
		}
		try {
			if ( pstmt != null ) {
				pstmt.close();
			}
		}catch ( SQLException ex ) {
			ex.printStackTrace();
		}
		try {
			if ( resultSet != null ) {
				resultSet.close();
			}
		}catch ( SQLException ex ) {
			ex.printStackTrace();
		}
		return orderItemList;
	}
	public ArrayList<OrderItemList> getOrderItemListResults(){
		return orderItemList;
	}
	
	
	
	/********
	 * パラメータで商品検索
	 * @useSession entry
	 */
	public ArrayList<ItemList> getItemResult(int inItemCode) {
		try {

			Connection conn = DBconnetion.connectDatabase();
			itemList.clear();
			pstmt = conn.prepareStatement( "select item_nam,item_c,price from item where item_c = ?" );

			pstmt.setInt( 1, inItemCode );
			resultSet = pstmt.executeQuery();

			while ( resultSet.next() ) {
				ItemList si = new ItemList(
						resultSet.getInt( "item_c" ),
						resultSet.getString( "item_nam" ),
						resultSet.getDouble( "price" ));
				itemList.add( si );
			}
		}
		catch (SQLException ex) {     //SQLを実行したときに発生した例外事象
			System.out.println("エラーコード：" + ex.getErrorCode());
			System.out.println("SQL状態：" + ex.getSQLState());
			ex.printStackTrace();
		}

		finally {
			try {
				if (resultSet != null) {
					resultSet.close();
				}
			}
			catch (SQLException ex) {
				ex.printStackTrace();
			}
			try {
				if (stmt != null) {
					stmt.close();
				}
			}
			catch (SQLException ex) {
				ex.printStackTrace();
			}
			try {
				if (conn != null) {
					conn.close();
				}
			}
			catch (SQLException ex) {
				ex.printStackTrace();
			}

		}
		return itemList;
	}

	public ArrayList<ItemList> getItemListResults() {
		return itemList;
	}

	/********
	 * 商品検索
	 * @useSession entry
	 */
	public ArrayList<ItemList> getItemResult() {
		try {
			conn = common.DBconnetion.connectDatabase();
			stmt = conn.createStatement();     //データベース（SQL文）を管理する
			resultSet = stmt.executeQuery( "SELECT item_nam,item_c,price FROM item ORDER BY item_nam" );     //resultSetは検索結果

			while ( resultSet.next() ) {
				ItemList si = new ItemList(
						resultSet.getInt( "item_c" ),
						resultSet.getString( "item_nam" ),
						resultSet.getDouble( "price" ));
				itemList.add( si );
			}
		}
		catch (SQLException ex) {     //SQLを実行したときに発生した例外事象
			System.out.println("エラーコード：" + ex.getErrorCode());
			System.out.println("SQL状態：" + ex.getSQLState());
			ex.printStackTrace();
		}

		finally {
			try {
				if (resultSet != null) {
					resultSet.close();
				}
			}
			catch (SQLException ex) {
				ex.printStackTrace();
			}
			try {
				if (stmt != null) {
					stmt.close();
				}
			}
			catch (SQLException ex) {
				ex.printStackTrace();
			}
			try {
				if (conn != null) {
					conn.close();
				}
			}
			catch (SQLException ex) {
				ex.printStackTrace();
			}

		}
		return itemList;
	}





	/***********
	 *顧客名検索
	 *@useSession entry
	 */
	public ArrayList<CustomList> getCustomResult() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet resultSet = null;
		try {
			conn = DBconnetion.connectDatabase();
			stmt = conn.createStatement();     //データベース（SQL文）を管理する
			resultSet = stmt.executeQuery( "SELECT custom_nam,custom_c FROM custom" );

			while ( resultSet.next() ) {
				CustomList sc = new CustomList(
						resultSet.getInt( "custom_c"),
						resultSet.getString( "custom_nam" ) );
				customList.add( sc );
			}
		}
		catch (SQLException ex) {
			System.out.println("エラーコード：" + ex.getErrorCode());
			System.out.println("SQL状態：" + ex.getSQLState());
			ex.printStackTrace();
		}

		finally {
			try {
				if (resultSet != null) {
					resultSet.close();
				}
			}
			catch (SQLException ex) {
				ex.printStackTrace();
			}
			try {
				if (stmt != null) {
					stmt.close();
				}
			}
			catch (SQLException ex) {
				ex.printStackTrace();
			}
			try {
				if (conn != null) {
					conn.close();
				}
			}
			catch (SQLException ex) {
				ex.printStackTrace();
			}

		}
		return customList;
	}
	
	
	
	
	
	/***********
	 *担当者名検索
	 *@useSession entry
	 *@return 
	 */
	
	public ArrayList<SalesList> getSalesResult() {
		try {
			conn = DBconnetion.connectDatabase();
			stmt = conn.createStatement();
			resultSet = stmt.executeQuery( "SELECT sales_nam, sales_c FROM sales" );

			while ( resultSet.next() ) {
				SalesList ss = new SalesList(
						resultSet.getString( "sales_c"),
						resultSet.getString( "sales_nam" ) );
				salesList.add( ss );
			}
		}
		catch (SQLException ex) {      //SQLを実行したときに発生した例外事象
			System.out.println("エラーコード：" + ex.getErrorCode());
			System.out.println("SQL状態：" + ex.getSQLState());
			ex.printStackTrace();
		}

		finally {
			try {
				if (resultSet != null) {
					resultSet.close();
				}
			}
			catch (SQLException ex) {
				ex.printStackTrace();
			}
			try {
				if (stmt != null) {
					stmt.close();
				}
			}
			catch (SQLException ex) {
				ex.printStackTrace();
			}
			try {
				if (conn != null) {
					conn.close();
				}
			}
			catch (SQLException ex) {
				ex.printStackTrace();
			}

		}
		return salesList;
	}
}
