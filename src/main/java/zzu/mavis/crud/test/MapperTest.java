package zzu.mavis.crud.test;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import zzu.mavis.crud.bean.Department;
import zzu.mavis.crud.bean.Employee;
import zzu.mavis.crud.dao.DepartmentMapper;
import zzu.mavis.crud.dao.EmployeeMapper;

import java.util.UUID;

/**
 * 测试dao层的工作
 *1 导入spring  test的包
 * 2 用ContextConfigration 注解指出spring配置文件的位置
 *  3  用什么组件 直接autowired
 */


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSessionTemplate sqlSession;


    @Test
    public void test01(){
//        System.out.println(departmentMapper);

        //测试插入
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
        //生成员工数据，测试员工插入
//        employeeMapper.insertSelective(new Employee(null,"mavis","f","1733168319@QQ.com",1));

        //批量插入
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        System.out.println(employeeMapper.getClass());
        System.out.println(EmployeeMapper.class);
        for (int j=0;j<1;j++){
            String name= UUID.randomUUID().toString().substring(0,5);
            mapper.insertSelective(new Employee(null,name,"f",name+"@QQ.com",1));
        }

    }
}
