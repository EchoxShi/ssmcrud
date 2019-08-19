<%--
  Created by IntelliJ IDEA.
  User: Mavis
  Date: 2019/8/14
  Time: 19:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%--web路径
    两种相对路径：
    不以/开头的是相对于当前文件
    以/开头的 是相对于当前服务器http://localhost:3306,所以需要加上项目名
    http://localhost:3306/ssmcrud

   --%>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());

    %>
    <%--引入 jQuery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap  引入样式-->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <%--引入  bootstarp 的js--%>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" ></script>
    <title>员工列表</title>
</head>
<body>

<!-- Modal   修改的  模态框-->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>

                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="f" checked="checked"> 女
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="m"> 男
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>
<!-- //Modal     模态框-->

<!-- Modal    添加的 模态框-->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>

                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="f" checked="checked"> 女
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="m"> 男
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- //Modal     模态框-->

<%--开始搭建显示页面--%>
<div class="container">
    <%--定义标题栏--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--数据表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>lastName</th>
                    <th>email</th>
                    <th>gender</th>
                    <th>deptName</th>
                    <th>操作</th>

                </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--f分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
<%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">


        </div>

    </div>


</div>

<%--要处理的数据--%>
<%--要处理的json数据======》
{"code":100,"msg":"处理成功！","extend":{"pageInfo":{"pageNum":1,"pageSize":5,"size":5,"startRow":1,"endRow":5,"total":1003,"pages":201,"list":[{"empId":1,"empName":"mavis","gender":"f","email":"1733168319@QQ.com","dId":1,"department":{"deptId":1,"deptName":"开发部"}},{"empId":3,"empName":"07413","gender":"f","email":"07413@QQ.com","dId":1,"department":{"deptId":1,"deptName":"开发部"}},{"empId":4,"empName":"6308d","gender":"f","email":"6308d@QQ.com","dId":1,"department":{"deptId":1,"deptName":"开发部"}},{"empId":5,"empName":"62f6f","gender":"f","email":"62f6f@QQ.com","dId":1,"department":{"deptId":1,"deptName":"开发部"}},{"empId":6,"empName":"3a32e","gender":"f","email":"3a32e@QQ.com","dId":1,"department":{"deptId":1,"deptName":"开发部"}}],"prePage":0,"nextPage":2,"isFirstPage":true,"isLastPage":false,"hasPreviousPage":false,"hasNextPage":true,"navigatePages":5,"navigatepageNums":[1,2,3,4,5],"navigateFirstPage":1,"navigateLastPage":5,"firstPage":1,"lastPage":5}}}
--%>

<script type="text/javascript" >

        var totalRecord,currentPage;
        //1 页面加载完成之后 直接发送一个ajax请求 ，要到分页数据
        $(function () {
           to_page(1);
        });

        //把跳转到某页抽取成一个方法
        function to_page(pn) {
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"pn="+pn,
                type:"GET",
                success:function (result) {
                    // console.log(result)
                    //1,解析并显示员工数据
                    build_emps_table(result);
                    //  2，解析并显示分页信息
                    build_page_info(result);
                    //    3 解析并显示分页条数据
                    build_page_nav(result);
                }
            });
        }

        //构建数据表格
        function build_emps_table(result) {
            //清空table表格
            $("#emps_table tbody").empty();
            //拿到所有的员工数据
            var emps = result.extend.pageInfo.list;
        //    遍历所有的员工数据
            $.each(emps,function (index,item) {
                // alert(item.empName)
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender=='m'?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                editBtn.attr("edit_id",item.empId);
                var deleBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

                deleBtn.attr("del-id",item.empId);
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleBtn);
                $("<tr></tr>")
                    .append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            });
        }

        //解析显示分页信息
        function build_page_info(result) {
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页，共"+result.extend.pageInfo.pages+"页,总共"+result.extend.pageInfo.total+"记录");
             totalRecord = result.extend.pageInfo.total;
            currentPage = result.extend.pageInfo.pageNum;
        }

        //解析显示分页条
        function build_page_nav(result) {
            //page_nav_area
            $("#page_nav_area").empty();
            var ul = $("<ul></ul>").addClass("pagination");
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

            if(result.extend.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else{
                //为元素添加翻页事件
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function () {
                    to_page(result.extend.pageInfo.prePage);
                });
            }

            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

            if(result.extend.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                //为元素添加翻页事件
                nextPageLi.click(function () {
                    to_page(result.extend.pageInfo.nextPage);
                });
                lastPageLi.click(function () {
                    to_page(result.extend.pageInfo.pages);
                });
            }

            ul.append(firstPageLi).append(prePageLi);

            $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
                var numLi = $("<li></li>").append($("<a></a>").append(item));

                if(result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }

                numLi.click(function () {
                    to_page(item);
                });
                ul.append(numLi);
            });
            ul.append(nextPageLi).append(lastPageLi);
            var navEle = $("<nav></nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        //点击新增按钮弹出模态框
        $("#emp_add_modal_btn").click(function () {
            //表单数据  和样式 重置
            reset_form("#empAddModal form");

            $("#dept_add_select").empty();
            //发送ajax请求，查出部门信息，显示在下拉列表中
            getDepts("#dept_add_select");
            //弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });

        //清空表单样式及数据
        function reset_form(ele) {
            $(ele)[0].reset();
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }

        // 查出部门信息，显示在下拉列表中
        function  getDepts(ele) {
            $.ajax({
                url:"${APP_PATH}/depts",
                type:"GET",
                success:function (result) {
                    //显示在下拉列表中
                    console.log(result);
                    $.each(result.extend.depts,function (index,item) {
                    var optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
                        optionEle.appendTo(ele);
                    });
                }
            });
        }

        //校验表单数据
        function validate_add_form(){
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
            if(!regName.test(empName)){
                show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
                return false;
            }else{
                show_validate_msg("#empName_add_input","success","");
                return true;
            }

            var email = $("#email_add_input").val();
            var regEmail = /^([a-z0-9_\\.-]+)@([\da-z\\.-]+)\.([a-z\\.]{2,6})$/;
            if(!regEmail.test(email)){
                //校验失败
                show_validate_msg("#email_add_input","error","邮箱格式不正确");
                return false;
            }else{
            //    校验成功
                show_validate_msg("#email_add_input","success","");
                return true;
            }
        }

        //显示校验信息
        function show_validate_msg(ele,status,msg){
            //清除当前元素的校验状态
            $(ele).parent().removeClass("has-error has-success");
            $(ele).next("span").text("");
            if("success"==status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);

            }else if("error"==status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        $("#empName_add_input").change(function () {
        //    发送ajax请求 校验用户名是否可用
            var empName= this.value;

            $.ajax({
                url:"${APP_PATH}/checkuser",
                data:{"empName":empName},
                type:"POST",
                success:function (result) {
                    if(result.code==100){
                        show_validate_msg("#empName_add_input","success","用户名可用11111");
                        $("#emp_save_btn").attr("ajax-va","success");
                    }else{
                        show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-va","error");

                    }
                }
            });
        });


        //给模态框中的save按钮绑定事件，
        // 发送ajax请求保存员工信息，并关闭模态框，来到最后一页显示信息
        $("#emp_save_btn").click(function () {
        //    1 模态框中填写的表单数据提交给 服务器进行保存
        //    11111先对提交的数据进行校验
            if(!validate_add_form()){
                return false;
            }
        //    1  判断之前的ajax用户名校验是否成功，如果成功
           if($(this).attr("ajax-va")=="error"){
               alert("aaaaaaaaaaaaaaa");
               return false;
           }

        //    2 发送ajax请求保存员工
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:$("#empAddModal form").serialize(),
                success:function (result) {

                    if(result.code == 100){
                        //    员工保存成功：
                        //    1 关闭模态框
                        $("#empAddModal").modal("hide");
                        //    2来到最后一页显示刚才保存的数据,可以把总记录数当成最后一页
                        to_page(totalRecord);
                    }else {
                        //显示错误信息
                        if(undefind !=result.extend.errorFileds.email){
                            show_validate_msg("#email_add_input","error",result.extend.errorFileds.email);

                        }
                        if(undefind !=result.extend.errorFileds.empName){
                            show_validate_msg("#empName_add_input","error",result.extend.errorFileds.empName);
                        }
                    }

                }

            });
        });



//        给编辑按钮绑定事件
    $(document).on("click",".edit_btn",function () {
    //    查出员工信息

            getEmp($(this).attr("edit_id"));
    //把编辑按钮上的ID值传递给 修改按钮
        $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));

    //    查出部门信息
        $("#empUpdateModal select").empty();
        getDepts("#empUpdateModal select");

    //    弹出模态框
        $("#empUpdateModal").modal({
           backdrop:"static"
        });
    });
    
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal  inpute[name=gender]").val([empData.gender]);
                $("#empUpdateModal  select").val([empData.dId]);

            }
        });
    }

//    点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //验证员工邮箱
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\\.-]+)@([\da-z\\.-]+)\.([a-z\\.]{2,6})$/;
        if(!regEmail.test(email)){
            //校验失败
            show_validate_msg("#email_update_input","error","邮箱格式不正确");
            return false;
        }else{
            //    校验成功
            show_validate_msg("#email_update_input","success","");
            //    发送ajax请求修改信息
            alert($(this).attr("edit_id"));
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function (result) {
                    $("#empUpdateModal").modal("hide");
                    to_page(currentPage);
                }
            });
        }
    });

        //单个删除
        $(document).on("click",".delete_btn",function () {
        //弹出是否删除确认框
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            alert(empName)
            var empId = $(this).attr("del-id");
            if(confirm("确认删除【"+empName+"】吗？")){
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    success:function (result) {
                    to_page(currentPage)
                    }
                })
            }
        });

//        全选  全不选
    $("#check_all").click(function () {
    //    attr 获取checked 是 undefined
    //    我们这些dom原生的属性 用prop获取 ，attr获取自定义属性的值
        $(".check_item").prop("checked",$(this).prop("checked"))
    });

    $(document).on("click",".check_item",function () {
        // 判断当前选中的元素是否是5个
        var flag= $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag)
    })

//    点击全部删除
    $("#emp_delete_all_btn").click(function () {

        var empNames  = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function () {
             empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
             del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });

        empNames =empNames.substring(0,empNames.length-1);
        del_idstr =del_idstr.substring(0,del_idstr.length-1);
        if(confirm("确认删除【"+empNames+"】？")){
        //    发送请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    })



</script>


</body>
</html>
