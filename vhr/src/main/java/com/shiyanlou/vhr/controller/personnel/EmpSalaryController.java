package com.shiyanlou.vhr.controller.personnel;

import com.shiyanlou.vhr.bean.AdjustSalary;
import com.shiyanlou.vhr.bean.RespBean;
import com.shiyanlou.vhr.service.PersonnelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/personnel/adjust")
public class EmpSalaryController {

    @Autowired
    PersonnelService personnelService;

    @RequestMapping(value = "/salary",method = RequestMethod.POST)
    public RespBean addAdjustSalary(AdjustSalary adjustSalary){
        if(personnelService.addAdjustSalary(adjustSalary)==1){
            return RespBean.ok("Added successfully");
        }
        return RespBean.error("Add failed");
    }

    @RequestMapping(value = "/salary",method = RequestMethod.GET)
    public List<AdjustSalary> getAllAdjustSalary(){
        return personnelService.getAllAdjustSalary();
    }

    @RequestMapping(value = "/salary",method = RequestMethod.PUT)
    public RespBean updateAdjustSalary(AdjustSalary adjustSalary){
        if(personnelService.updateAdjustSalary(adjustSalary)==1){
            return RespBean.ok("Update successfully");
        }
        return RespBean.error("Update failed");
    }

    @RequestMapping(value = "/salary/{ids}",method = RequestMethod.DELETE)
    public RespBean deleteAdjustSalary(@PathVariable String ids){
        if(personnelService.deleteAdjustSalary(ids)>=1){
            return RespBean.ok("Delete successfully");
        }
        return RespBean.error("Delete failed");
    }
}
