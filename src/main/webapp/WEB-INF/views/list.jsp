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
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
        <%--数据表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>#</th>
                    <th>lastName</th>
                    <th>email</th>
                    <th>gender</th>
                    <th>deptName</th>
                    <th>操作</th>

                </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <td>${emp.empId}</td>
                        <td>${emp.empName}</td>
                        <td>${emp.email}</td>
                        <td>${emp.gender=="f"?"女":"男"}</td>
                        <td>${emp.department.deptName}</td>
                        <td>
                            <button  class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"/>
                                编辑</button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"/>
                                删除</button>

                        </td>

                    </tr>
                </c:forEach>

            </table>
        </div>
    </div>
        <%--显示分页信息--%>
    <div class="row">
        <div class="col-md-6">
        当前${pageInfo.pageNum}页，共${pageInfo.pages}页,总共${pageInfo.total}记录
        </div>

        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/emps?pn=1">首页</a> </li>

                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.prePage}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>


                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <%--如果是当前页码--%>
                        <c:if test="${page_Num==pageInfo.pageNum}">
                            <li class="active"><a href="#">${page_Num}</a></li>
                        </c:if>
                        <%--如果不是当前页码  就发送请求--%>
                        <c:if test="${page_Num!=pageInfo.pageNum}">
                            <li ><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
                        </c:if>

                    </c:forEach>

                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH}/emps?pn=${pageInfo.nextPage}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a> </li>

                </ul>
            </nav>

        </div>

    </div>


</div>

</body>
</html>
