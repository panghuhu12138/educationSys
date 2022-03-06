package Utils;


import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {
	/**
	 * 根据银行卡获取银行卡前6位数字
	 * */
	public static String getRegBankCardFrontSix(String bankcard){
		if(bankcard!=null&&!"".equals(bankcard.trim())){
			bankcard = bankcard.trim().replaceAll(" ", "").replaceAll("	", "");
			if(bankcard.length()>10){
				return bankcard.substring(0, 6);
			}
		}
		return null;
	}
	/**
	 * 根据银行卡获取银行卡后四位，其他*标识
	 * */
	public static String getRegBankCard(String bankcard){
		if(bankcard!=null&&!"".equals(bankcard.trim())){
			bankcard = bankcard.trim().replaceAll(" ", "").replaceAll("	", "");
			if(bankcard.length()>10){
				return "**** **** **** "+getBankCardLastFour(bankcard);
			}
		}
		return null;
	}
	/**
	 * 根据银行卡获取银行卡后四位
	 * */
	public static String getBankCardLastFour(String bankcard){
		if(bankcard!=null&&!"".equals(bankcard.trim())){
			bankcard = bankcard.trim().replaceAll(" ", "").replaceAll("	", "");
			if(bankcard.length()>10){
				return bankcard.substring(bankcard.length()-4, bankcard.length());
			}
		}
		return null;
	}
	public static String getRegCard(String card){
	if(card!=null&&!"".equals(card)){
		if(card.length()==15){
			return card.substring(0, 5)+"********"+card.substring(13);
		}
		if(card.length()==18){
			return card.substring(0, 5)+"***********"+card.substring(16);
		}
	}
	return null;
	}
	public static String getRegPhone(String phone){
		if(phone!=null&&!"".equals(phone)){
			if(phone.length()==11){
				return phone.substring(0,3)+"*****"+phone.substring(8);
			}
		}
		return null;	
		}
	public static String getRegMail(String email){
		if(email!=null&&!"".equals(email)){
		String first=email.split("@")[0];
		String last=email.split("@")[1];
		if(first!=null&&!"".equals(first)){
			if(first.length()<=3){
				return first.substring(0,1)+"***@"+last;
			}
			    return first.substring(0,3)+"***@"+last;
		}
		}
		return null;	
		}

	public static String concatStringtoUpperCase(String left, String right) {
		String newstr = left + right;

		return newstr.toUpperCase();
	}

	public static String completionStringtoUpperCase(String oldstr, int length) {
		String newstr = oldstr;
		String completion = "";
		if (newstr != null && !"".equals(newstr)) {
			for (int i = 0; i < length - newstr.length(); i++) {
				completion ="0"+ completion ;
			}
		}
		return completion+newstr.toUpperCase() ;
	}

	public static String sNull(Object str) {
		if (str == null) {
			return "";
		} else {
			return str.toString().trim();
		}
	}
	public static String isNull(Object str) {
		if (str == null) {
			return "";
		} else {
			return str.toString().replaceAll(" ", "");
		}
	}
//	public static String objectToJson(Object obj)
//	{
//		XStream xs=new XStream(new JsonHierarchicalStreamDriver());
//		
//		return xs.toXML(obj);
//	}
	public static boolean isNullOrEmpty(Object obj)
	{
		if (obj instanceof String) {
			if(obj!=null&&!"".equals(((String) obj).trim()))
			{
				return true;
			}
		}else if(obj!=null){
			return true;
		}
		return false;
	}
//	public static String buildRandomNumberID() {
//		Random rdm = new Random();
//		long ct = Math.abs(rdm.nextLong());
//		String nb = String.valueOf(ct);
//		String nm = (nb.substring(nb.length() - 4, nb.length()));
//		String id=(DateUtil.getDateTime("yyMMddkk")
//				+ nm);
//		return id;
//
//	}
	public static boolean compareIDS(String ids,String delim,String id)
	{
		StringTokenizer st=new StringTokenizer(ids,delim);
		while(st.hasMoreElements()){
			if(id.equals(st.nextElement())){
				return true;
			}
		}
		return false;
	}
	
	public    static String replaceBlank(String str) {
	      String dest = "";
	      if (str!=null) {
	          Pattern p = Pattern.compile("\\s*|\t|\r|\n");
	          Matcher m = p.matcher(str);
	          dest = m.replaceAll("");
	      }
	      return dest;
	  }
	
	/**
	 * 加密显示，如手机号显示前三位和后四位
	 * */
	public static String jmStr(int start,int end,String str){
		String rtnStr = null;
		if(str!=null&&(start+end)<=str.length()){
			String jm = "";
			for(int i=0;i<str.length()-start-end;i++){
				jm = jm + "*";
			}
			rtnStr = str.substring(0, start) + jm + str.substring(str.length()-end);
		}
		return rtnStr;
	}
	/**
	 * 获取uuid
	 * */
	public static String getUUID(){
		UUID uuid = UUID.randomUUID();
		return uuid.toString().replace("-", "");
	}
	
	/**
	 * 自动去掉double小数点后面多余的0,如1.20显示1.2
	 * */
	public static String formatDouble(Double num){
		String rtn = null;
		if(num==null){
			return null;
		}
		DecimalFormat df = new DecimalFormat("#.##");   
		rtn = df.format(num);
		return rtn;
	}
	
	public static void main(String[] args) throws ParseException {
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println(ft.format(DateUtil.daysAfter(new Date(),-6)));
		StringBuffer djxx = new StringBuffer("");
		System.out.println(djxx.length());
	}
	
	/**
	 * 获取中文数字
	 * @author 车文
	 * @date 2017年3月31日
	 * @param num
	 * @return
	 */
	public static String getChinaeseNum(Integer num){
		Map<Integer,String> map = new HashMap<Integer,String>();
		map.put(0, "零");
		map.put(1, "一");
		map.put(2, "二");
		map.put(3, "三");
		map.put(4, "四");
		map.put(5, "五");
		map.put(6, "六");
		map.put(7, "七");
		map.put(8, "八");
		map.put(9, "九");
		String chinaeseNum = "";
		if(num != null){
			chinaeseNum = map.get(num);
		}
		return chinaeseNum;
	}
}
