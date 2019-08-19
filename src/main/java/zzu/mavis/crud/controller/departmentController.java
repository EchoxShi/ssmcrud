package zzu.mavis.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import zzu.mavis.crud.bean.Department;
import zzu.mavis.crud.bean.Employee;
import zzu.mavis.crud.bean.Msg;
import zzu.mavis.crud.service.DepartmentService;
import zzu.mavis.crud.service.EmployeeService;

import java.util.List;

/*
* 处理和部门有关的请求
*
* */
@Controller
public class departmentController {

    @Autowired
    public DepartmentService departmentService;

//    返回所有的部门信息
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> depts = departmentService.getDepts();

        return Msg.success().add("depts",depts);
    }


}
