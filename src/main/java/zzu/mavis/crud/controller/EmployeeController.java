package zzu.mavis.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import zzu.mavis.crud.bean.Employee;
import zzu.mavis.crud.bean.Msg;
import zzu.mavis.crud.service.EmployeeService;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
* 处理员工crud
*
* */
@Controller
public class EmployeeController {
    @Autowired
    public EmployeeService employeeService;

/*
* 单个批量二合一
* 批量 1-2-3
* 单个1
* */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids") String ids){
//        批量删除
        if(ids.contains("-")){
            List<Integer> str_ids = new ArrayList<>();

            String[] split = ids.split("-");
            for(String id:split){
                str_ids.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(str_ids);
        }else{
//            单个删除
            employeeService.deleteEmo(Integer.parseInt(ids));

        }
        return Msg.success();
    }

//    更新
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }


//    查询
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee emp = employeeService.getEmp(id);
        return Msg.success().add("emp",emp);
    }

//    检查用户名是否可用
    @RequestMapping(value = "/checkuser",method = RequestMethod.POST)
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
//        先判断用户名是否是合法的表达式
        String regx= "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是");
        }
        boolean checkuser = employeeService.checkuser(empName);
        if(checkuser){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }


    @RequestMapping(value="/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            Map<String ,Object>  map= new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
           for(FieldError fieldError:fieldErrors){
               map.put(fieldError.getField(),fieldError.getDefaultMessage());
           }
            return Msg.fail().add("errorFields",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }
    /*
    * responsebody
    * 正常工作需要
    * Jackson包*/
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJSON(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        PageHelper.startPage(pn,5);
        List<Employee> employeeList=employeeService.getAll();
        PageInfo pageInfo = new PageInfo(employeeList,5);

        return Msg.success().add("pageInfo",pageInfo);
    }

//    这种传统的方式适合 b/s模式，而直接返回json 跟适合各种移动端，可扩展性强
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){

//        引入pagehelper分页查询
//        在查询前只需调用,传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
//        startpage后边紧跟的查询就是分页查询
        List<Employee> employeeList=employeeService.getAll();
//        还可以使用pageinfo对查询结果进行包装,还可以传入连续显示的页数
        PageInfo pageInfo = new PageInfo(employeeList,5);
//        只需要将封装了结果的pageinfo交给页面就可以了，因为他包含需要的所有分页信息
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }
}
