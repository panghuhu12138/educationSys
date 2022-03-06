package Utils;

import sun.misc.BASE64Decoder;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * 工具类
 *
 * @author wuxb
 */
public class Util {

    /**
     * 身份证验证码 15位
     */
    private static final String REG_ID_15 =
            "^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]$";
    /**
     * 身份证验证码 18 位
     */
    private static final String REG_ID_18 =
            "^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";

    /**
     * 数字与字母组合
     */
    private static final String REG_STR_NUM = "^[A-Za-z0-9]+$";

    private Util() {
    }

    /**
     * 判断对象是否为空
     *
     * @param o 对象
     * @return boolean
     */
    public static boolean n(final Object o) {
        return null == o || n(o.toString());
    }

    /**
     * 判断字符串是否为空
     *
     * @param s 字符串
     * @return boolean
     */
    public static boolean n(final String s) {
        return null == s || s.trim().isEmpty() || "null".equalsIgnoreCase(s.trim());
    }

    /**
     * 判断数组是否为空
     *
     * @param o 数组
     * @return boolean
     */
    public static <T> boolean n(final T[] o) {
        return null == o || 0 == o.length;
    }

    /**
     * 判断集合是否为空
     *
     * @param c Collection集合
     * @return boolean
     */
    public static boolean n(final Collection<?> c) {
        return null == c || c.isEmpty();
    }

    /**
     * 判断map是否为空
     *
     * @param m Map集合
     * @return boolean
     */
    public static boolean n(final Map<?, ?> m) {
        return null == m || m.isEmpty();
    }

    /**
     * 生成uuid，移除"-"
     *
     * @return uuid
     */
    public static String uuid() {
        return uuid$().replaceAll("-", "");
    }

    /**
     * 生成uuid
     *
     * @return uuid
     */
    public static String uuid$() {
        return UUID.randomUUID().toString();
    }

    /**
     * 移除字符串前后空格
     * <p>
     * 12288 为全角空格  ASCII值
     *
     * @param s
     * @return
     */
    public static String trim(final String s) {
        return n(s) ? "" : s.replaceAll(((char) 12288) + "", "").trim();
    }

    /**
     * 请求转参数转map,大小写敏感
     *
     * @param request 请求对象
     * @return Map
     */
    public static Map<String, Object> paramToMap(final HttpServletRequest request) {
        if (n(request)) {
            return new HashMap<>(16);
        }
        Map<String, Object> params = new HashMap<>(16);
        Map<String, String[]> map = request.getParameterMap();
        map.forEach((k,
                     v) -> params.put(k, Stream.of(request.getParameterValues(k)).collect(Collectors.joining(","))));
        return params;
    }

    /**
     * 身份证卡号中间用*号处理
     *
     * @param cardNum
     * @return
     */
    public static String formatCardNum(String cardNum) {
        if (Util.n(cardNum) || cardNum.length() != 18) {
            return cardNum;
        }
        return new StringBuilder(cardNum).replace(6, 14, "********").toString();
    }

    /**
     * 金钱格式化
     *
     * @param money
     * @return 99, 999, 999.11
     */
    public static String moneyFormat(double money) {
        return NumberFormat.getInstance().format(money);
    }

    /**
     * 获取正确的IP地址
     */
    public static String getIp(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (ip.contains(",")) {
            return ip.split(",")[0];
        }
        return ip;
    }

    /**
     * @return
     */
    public static List<String> niandu() {
        return validNiandu();
//        return Arrays.asList(String.valueOf(LocalDate.now().getYear() - 2),
//                String.valueOf(LocalDate.now().getYear() - 1), String.valueOf(LocalDate.now().getYear()),
//                String.valueOf(LocalDate.now().getYear() + 1), String.valueOf(LocalDate.now().getYear() + 2));
    }

    /**
     * @return
     */
    public static List<String> validNiandu() {

        final int startYear = 2018;
        final int nowYear = LocalDate.now().getYear();

        int len = nowYear - startYear;

        List<String> niandus = new ArrayList<>(5);
        for (int i = 0; i <= len; i++) {
            niandus.add(String.valueOf(nowYear - i));
        }
        return niandus;
    }

    // 对象转字符串，对象为空默认""
    public static String sNull(Object o) {
        if (o == null) {
            return "";
        } else {
            return o.toString();
        }
    }

    // 对象转字符串，对象为空默认"0"
    public static String sNull0(Object o) {
        if (o == null) {
            return "0";
        } else {
            return o.toString();
        }
    }

    /**
     * 身份证验证
     *
     * @param id
     * @return
     */
    public static boolean validId(String id) {
        if (n(id)) {
            return false;
        }
        if (id.length() == 15) {
            return id.matches(REG_ID_15);
        }
        return id.matches(REG_ID_18);
    }

    /**
     * 防止数据过长,截断数据
     *
     * @param data   数据
     * @param length 需要保留几个字符
     */
    public static String subName(Object data, Integer length) {
        String result = Util.sNull(data);

        if (result == null) {
            return "";
        }

        if (result.length() == length) {
            return result;
        }

        return result.substring(0, length - 1) + "..";
    }

    /**
     * 金额用逗号隔开
     *
     * @param data   数据
     * @param length 指定保留几位小数
     */
    public static String formatTosepara(String data, Integer length) {
        if (length == null || length.equals(0)) {
            length = 4;
        }
        return formatToseparaStatic(data, length);
    }

    /**
     * 金额用逗号隔开，默认保留四位
     *
     * @param data 数据
     */
    public static String formatTosepara(String data) {
        return formatToseparaStatic(data, 4);
    }

    /**
     * 验证字符串是否是数字与字母组合
     *
     * @param s 字符串
     * @return
     */
    public static boolean validStrNum(final String s) {
        return Util.n(s) ? false : s.matches(REG_STR_NUM);
    }

    private static String formatToseparaStatic(String data, Integer length) {
        data = sNull0(data);

        Double d = Double.parseDouble(data);

        if (d.equals(new Double(0))) {
            return "0";
        }

        StringBuilder l = new StringBuilder();
        for (int i = 0; i < length; i++) {
            l.append("0");
        }

        DecimalFormat df = new DecimalFormat("#,###." + l.toString());
        return df.format(d);
    }

    /**
     * 数字字符串格式化补位
     *
     * @param size   长度
     * @param mumber 数字
     * @return
     */
    public static String formatString(int size, int mumber) {
        return String.format("%0" + size + "d", mumber);
    }

    /**
     * 身份证脱敏处理
     *
     * @param idCardNumber 身份证
     * @return
     */
    public static String idHandle(String idCardNumber) {
        if (!StringUtil.isNullOrEmpty(idCardNumber) || (idCardNumber.length() < 8)) {
            return idCardNumber;
        }
        return idCardNumber.replaceAll("(?<=\\w{3})\\w(?=\\w{4})", "*");//这个模式的例子 321***********8610
        // 隐藏11-16位
//        return idCardNumber.replaceAll("(\\w{10})\\w*(\\w{2})", "$1******$2");//这个模式的例子 3211811990******10
    }

    /**
     * 将列表中的查询条件进行封装
     */
    public static Map<String,Object> paramToMapNew(HttpServletRequest request) {
        Map<String, Object> params = paramToMap(request);
        //取列表表单的数据
        String formParamData="formParamData";
        if (params.containsKey(formParamData)) {
            String[] formData = StringUtil.sNull(params.get(formParamData)).split("&");
            for (String param : formData) {
                String[] split = param.split("=");
                String  key = split[0];
                if(split.length==2)
                {
                    String  value = split[1];
                    params.put(key,value);
                }
            }
            params.remove(formParamData);
        }
        return params;
    }

    /**
     * 对js用base64编码过的字符串，用java的base64解码
     * @param source js用base64编码过的字符串
     * @return java的base64解码后的字符串
     */
    public static String parseChineseByBase64(String source) {
        if(!StringUtil.isNullOrEmpty(source)) return "";
        String result = "";
        try {
            result =  new String(new BASE64Decoder().decodeBuffer(source), "utf-8");
        }catch (Exception e){
            e.printStackTrace();
            result = source;
        }

        return result;
    }

    /**
     * 判断是否是对应的格式的日期字符串
     * @param dateStr
     * @param datePattern
     * @return
     */
    public static boolean isRightDateStr(String dateStr,String datePattern){
        DateFormat dateFormat  = new SimpleDateFormat(datePattern);
        try {
            //采用严格的解析方式，防止类似 “2017-05-35” 类型的字符串通过
            dateFormat.setLenient(false);
            dateFormat.parse(dateStr);
            Date date = (Date)dateFormat.parse(dateStr);
            //重复比对一下，防止类似 “2017-5-15” 类型的字符串通过
            String newDateStr = dateFormat.format(date);
            if(dateStr.equals(newDateStr)){
                return true;
            }else {
//                LOGGER.error("字符串dateStr:{}， 不是严格的 datePattern:{} 格式的字符串",dateStr,datePattern);
                return false;
            }
        } catch (Exception e) {
//            LOGGER.error("字符串dateStr:{}，不能按照 datePattern:{} 样式转换",dateStr,datePattern);
            return false;
        }
    }
}
