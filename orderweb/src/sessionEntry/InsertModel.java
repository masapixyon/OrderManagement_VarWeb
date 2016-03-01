package sessionEntry;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;

import common.DBconnetion;

public class InsertModel {
	static Connection conn = null;
	static PreparedStatement stmt = null;
	static Statement stmtC = null;

	/*********
     * order_titleに登録
	 * @param rQuantity 
	 * @param rItemCode 
     ********/

	public static void insertOT(Calendar cal, int customCode, String salesCode,
			double amountOfMoney, double totalTax, double reqestMoney, ArrayList<ItemOrderList> itemOrderList) {
		try {
			Connection conn = DBconnetion.connectDatabase();
			stmt = conn.prepareStatement( "insert into order_title(order_date,custom_c,sales_c,total_amount,sales_tax,bill) values(?,?,?,?,?,?)", stmt.RETURN_GENERATED_KEYS );

			Date date = new java.sql.Date( cal.getTime().getTime() );
			
			
			stmt.setDate( 1, date );
			stmt.setInt( 2, customCode );
			stmt.setString( 3, salesCode );
			stmt.setDouble( 4, amountOfMoney );      //合計金額
			stmt.setDouble( 5, totalTax );      //消費税額
			stmt.setDouble( 6, reqestMoney );        //請求金額		
			stmt.execute();
			
			ResultSet orderCode = stmt.getGeneratedKeys();
			orderCode.next();
			stmt = conn.prepareStatement( "insert into order_detail(order_no,item_c,quantity) values(?,?,?);" );
			
			int i = 0;
			for (ItemOrderList it : itemOrderList) {
				stmt.setInt(1, orderCode.getInt(1));
				stmt.setInt(2, it.getItemCode());
				stmt.setInt(3, it.getItemQuantity());
				stmt.executeUpdate();
				i++;
			}
		}
		catch (SQLException ex) {
			System.out.println("エラーコード：" + ex.getErrorCode());
			System.out.println("SQL状態：" + ex.getSQLState());
			ex.printStackTrace();
		}
		try {
			if (stmt != null) {
				stmt.close();
			}
		}catch (SQLException ex) {
			ex.printStackTrace();
		}
		try {
			if (conn != null) {
				conn.close();
			}
		}catch (SQLException ex) {
			ex.printStackTrace();
		}
	}
}