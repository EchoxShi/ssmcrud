package zzu.mavis.crud.test;
/*
* 使用Spring 的单元测试模块，帮我们测试crud请求的正确性
* */


import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import zzu.mavis.crud.bean.Employee;

import java.sql.SQLOutput;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MvcTest {
//传入springmvc的IOC，可以自动装配 但是？？
    @Autowired
    WebApplicationContext context;
//    虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;

    @Before
    public void init(){
         mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
        System.out.println(mockMvc);
    }
    @Test
    public void testPage() throws Exception {
//        模拟get请求  得到结果
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();

//        请求成功以后，请求域中会有pageInfo，我们可以取出pageinfo  进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");


//        查看pageinfo的各个信息
        System.out.println("当前页码"+pageInfo.getPageNum());
        System.out.println("总页数"+pageInfo.getPages());
        System.out.println("每页大小"+pageInfo.getPageSize());
        System.out.println("总记录数"+pageInfo.getTotal());
        System.out.println("每次显示几个页码");
        int[] navigatepageNums = pageInfo.getNavigatepageNums();
        for(int i :navigatepageNums){
            System.out.println("======"+i);
        }

//查看员工的数据
        List<Employee> list = pageInfo.getList();
        for(Employee employee:list){
            System.out.println("ID:"+employee.getEmpId()+"===>"+"name:"+employee.getEmpName());

        }
    }
}
