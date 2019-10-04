package com.shiyanlou.vhr.controller;

import com.shiyanlou.vhr.bean.RespBean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class RegLoginController {

    @RequestMapping("/login_p")
    public String login(){
        return "redirect:index.html";
    }

}
