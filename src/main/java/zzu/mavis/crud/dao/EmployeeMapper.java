package zzu.mavis.crud.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import zzu.mavis.crud.bean.Employee;
import zzu.mavis.crud.bean.EmployeeExample;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);

    Employee selectByPrimaryKey(Integer empId);

//新定义的 带部门信息一起查
    List<Employee> selectByExampleWithDept(EmployeeExample example);
//新定义的 带部门信息一起查

    Employee selectByPrimaryKeyWithDept(Integer empId);



    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);
}