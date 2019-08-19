package zzu.mavis.crud.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import zzu.mavis.crud.bean.Employee;
import zzu.mavis.crud.bean.EmployeeExample;
import zzu.mavis.crud.dao.EmployeeMapper;

import java.security.PublicKey;
import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;


    public void deleteBatch(List<Integer> ids){
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
//        delete from xxx where emp_id in (1,2,3)
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
    public  void  deleteEmo(Integer id){
        employeeMapper.deleteByPrimaryKey(id);
    }
    public  boolean checkuser(String username){
        EmployeeExample example= new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        System.out.println(username);
        criteria.andEmpNameEqualTo(username);
        long l = employeeMapper.countByExample(example);

        return l==0;
    }

    /*查询所有员工
    *
    * */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }
}
