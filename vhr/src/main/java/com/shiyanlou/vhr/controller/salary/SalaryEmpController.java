package com.shiyanlou.vhr.controller.salary;

import com.shiyanlou.vhr.bean.Employee;
import com.shiyanlou.vhr.bean.RespBean;
import com.shiyanlou.vhr.bean.Salary;
import com.shiyanlou.vhr.service.EmpService;
import com.shiyanlou.vhr.service.SalaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/salary/sobcfg")
public class SalaryEmpController {

    @Autowired
    SalaryService salaryService;
    @Autowired
    EmpService empService;

    @RequestMapping(value = "/", method = RequestMethod.PUT)
    public RespBean updateEmpSalary(Integer sid, Long eid) {
        if (salaryService.updateEmpSalary(sid, eid) == 1) {
            return RespBean.ok("Modify successfully!");
        }
        return RespBean.error("Modify failed!");
    }

    @RequestMapping(value = "/salaries", method = RequestMethod.GET)
    public List<Salary> salaries() {
        return salaryService.getAllSalary();
    }

    @RequestMapping(value = "/emp", method = RequestMethod.GET)
    public Map<String, Object> getEmployeeByPage(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer size) {
        Map<String, Object> map = new HashMap<>();
        List<Employee> employeeByPage = empService.getEmployeeByPageShort(page, size);
        Long count = empService.getCountByKeywords("", null, null, null, null, null, null, null);
        map.put("emps", employeeByPage);
        map.put("count", count);
        return map;
    }

}
