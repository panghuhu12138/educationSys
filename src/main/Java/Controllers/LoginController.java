package Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import utils.ApiResult;
import utils.ImgCheckCode;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;


@Controller
@RequestMapping("/login")
public class LoginController {

    ImgCheckCode imgCheckCode=new ImgCheckCode();

    //验证码存放session 名
    private static String CODE_SESSION_NAME = "imgCode";
    /*跳转到登录页面*/
    @RequestMapping("/loginpage")
    public String login(HttpServletRequest request, ModelMap modelMap) {
        modelMap.addAttribute("account", request.getParameter("account"));
        return "login";
    }

    /*刷新验证码*/
    @RequestMapping("/getCodeImg")
    public String executeImage() {
        return "image";
    }

    /*校验验证码*/
    @RequestMapping("/checkCaptcha")
    @ResponseBody
    public ApiResult checkCaptcha(HttpServletRequest request) {
        String code = request.getParameter("code");
        boolean codeCheck = imgCheckCode.checkCode(request, code, CODE_SESSION_NAME);
        if (codeCheck) {
            return ApiResult.success();
        } else {
            return ApiResult.failed();
        }
    }

    /*登录*/
    @RequestMapping("/loginIn")
    @ResponseBody
    public ApiResult logIn(HttpServletRequest request) {
        try {
            String account = request.getParameter("account");
            String password = request.getParameter("password");
            return ApiResult.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ApiResult.failed("系统异常！请联系管理员！");
        }
    }

}
