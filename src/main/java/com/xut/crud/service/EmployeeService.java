package com.xut.crud.service;

import com.xut.crud.bean.Employee;
import com.xut.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @描述 $
 * @创建人 YK
 * @创建时间
 */
@Service
public class EmployeeService {
    @Autowired//自动装载
    EmployeeMapper employeeMapper;

    //查询所有员工
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }
}
