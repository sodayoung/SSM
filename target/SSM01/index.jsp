<%@ page import="com.github.pagehelper.PageInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="com.xut.crud.bean.Employee" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/7
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
        System.out.println(basePath);
        pageContext.setAttribute("path", request.getContextPath());

    %>
</head>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery-1.8.3.js"></script>
<link href="<%=basePath%>/static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
<script type="text/javascript" src="<%=basePath%>/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
<body>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>序号</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>



                </tbody>
            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>

        <%--分页信息条--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    //页面加载完成，发送ajax
    $(function () {
        $.ajax({
            url:"${path}/emps",//请求服务器地址
            data:"pn=1",        //带的参数
            type:"get",         //请求方式
            success:function (result) { //回调函数
                //console.log(result);
                //1、解析显示员工数据
                build_emps_table(result);
                //2、解析显示分页信息
                build_page_info(result);
                //3、显示分页条信息
                build_page_nav(result);
            }
        });
    });

    function build_emps_table(result) {
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            //alert(item.empName);
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);

            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");

            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            //apend方法返回的还是自己
            $("<tr></tr>").append(empIdTd).append(empNameTd).append(genderTd)
                .append(emailTd).append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");



        })
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页,总共"+
            result.extend.pageInfo.pages+"页,总"+result.extend.pageInfo.total+"条记录")
    }

    //解析显示分页条
    function build_page_nav(result) {
       var ul = $("<ul></ul>").addClass("pagination");
       var firstPageLi = $("<li></li>").append($("<a></a>").append("首页")).attr("href","#");
       var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
       var lastPageLi = $("<li></li>").append($("<a></a>").append("末页")).attr("href","#");
       var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
       //添加首页和前一页
       ul.append(firstPageLi).append(prePageLi);


       $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
           var numLi = $("<li></li>").append($("<a></a>").append(item));
           ul.append(numLi);
       })

        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
</script>

</body>
</html>
