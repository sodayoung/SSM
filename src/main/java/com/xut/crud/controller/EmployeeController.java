package com.xut.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xut.crud.bean.Employee;
import com.xut.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @描述 $
 * @创建人 YK
 * @创建时间
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /*查询员工数据*/
    @RequestMapping("/emps")
    public String getAll(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        //引入分页插件
        PageHelper.startPage(pn,5);//从pn页开始查，每页5条数据

        List<Employee> emps = employeeService.getAll();
        PageInfo page = new PageInfo(emps,5);//连续显示5页
        model.addAttribute("pageInfo",page);

        return "list";
    }
}
