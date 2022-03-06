package Utils;

import org.apache.commons.lang3.StringUtils;


public class ApiResult {
	
    private final Integer reCorde;
    private final Object data;
    private final String msg;

    private ApiResult(ResultCodeEnum reCode, Object data) {
        this.reCorde = reCode.flag;
        this.data = data;
        this.msg = reCode.name();
    }

    private ApiResult(ResultCodeEnum reCode, String msg, Object data) {
        this.reCorde = reCode.flag;
        this.data = data;
        this.msg = StringUtils.isBlank(msg) ? reCode.name() : msg;
    }

    public int getCode() {
        return this.reCorde;
    }

    public String getMsg() {
        return this.msg;
    }

    public Object getData() {
        return data;
    }

    public static final ApiResult success() {
        return new ApiResult(ResultCodeEnum.成功, null);
    }

    public static final ApiResult success(Object data) {
        return new ApiResult(ResultCodeEnum.成功, data);
    }

    public static final ApiResult failed(ResultCodeEnum reCode) {
        return new ApiResult(reCode, null);
    }

	public static final ApiResult failed(String msg) {
		return new ApiResult(ResultCodeEnum.系统异常, msg, null);
	}
	
	public static final ApiResult failed() {
		return failed(ResultCodeEnum.系统异常.name());
	}

    public static final ApiResult failed(ResultCodeEnum reCode, String msg) {
        return new ApiResult(reCode, msg, null);
    }

    public static final ApiResult failed(ResultCodeEnum reCode, String msg, Object data) {
        return new ApiResult(reCode, msg, data);
    }
}
