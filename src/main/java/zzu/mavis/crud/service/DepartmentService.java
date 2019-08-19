package zzu.mavis.crud.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import zzu.mavis.crud.bean.Department;
import zzu.mavis.crud.dao.DepartmentMapper;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;
    public List<Department> getDepts(){

        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;

    }

}
