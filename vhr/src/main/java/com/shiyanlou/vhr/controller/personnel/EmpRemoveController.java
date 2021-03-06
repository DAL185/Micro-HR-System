package com.shiyanlou.vhr.controller.personnel;

import com.shiyanlou.vhr.bean.EmpMove;
import com.shiyanlou.vhr.bean.RespBean;
import com.shiyanlou.vhr.service.PersonnelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/personnel/remove")
public class EmpRemoveController {

    @Autowired
    PersonnelService personnelService;

    @RequestMapping(value = "/move",method = RequestMethod.POST)
    public RespBean addEmpMove(EmpMove empMove){
        if(personnelService.addEmpMove(empMove)==1 && personnelService.updateDepIdAndJobId(empMove)==1){
            return RespBean.ok("Add successfully");
        }
        return RespBean.error("Add failed");
    }

    @RequestMapping(value = "/move",method = RequestMethod.PUT)
    public RespBean updateEmpMove(EmpMove empMove){
        if(personnelService.updateEmpMove(empMove)==1 && personnelService.updateDepIdAndJobId(empMove)==1){
            return RespBean.ok("Successfully modified");
        }
        return RespBean.error("Fail to modify");
    }

    @RequestMapping(value = "/move",method = RequestMethod.GET)
    public List<EmpMove> getAllEmpMove(){
        return personnelService.getAllEmpMove();
    }

}
