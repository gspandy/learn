<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>单点登录认证系统</title>
</head>
<body id="cas">
<c:if test="${not pageContext.request.secure}">
    <div id="msg">
        <h2>非安全连接</h2>

        <p>您正在通过非安全连接访问单点登录系统。单点登录将无法正常工作。为了单点登录正常工作，你必须通过HTTPS登录。</p>
    </div>
</c:if>

<form:form method="post" id="fm1" commandName="${commandName}" htmlEscape="true">

    <form:errors path="*" id="msg" cssClass="errors" element="div" htmlEscape="false"/>

    <h2><spring:message code="screen.welcome.instructions"/></h2>

    <div>
        <label for="username">用户名:</label>
        <input id="username" name="username" type="text" value=""/>
    </div>
    <div>
        <label for="password">密码:</label>
        <input id="password" name="password" type="password" value=""/>
    </div>
    <div>
        <label for="custom">自定义:</label>
        <input id="custom" name="custom" type="text" value=""/>
    </div>
    <div>
        <input id="warn" name="warn" value="true" type="checkbox"/>
        <label for="warn">转向其他站点前提示我。</label>
    </div>
    <div>
        <input type="hidden" name="lt" value="${loginTicket}"/>
        <input type="hidden" name="execution" value="${flowExecutionKey}"/>
        <input type="hidden" name="_eventId" value="submit"/>
        <input name="submit" value="登录" type="submit"/>
        <input name="reset" value="重置" type="reset"/>
    </div>
</form:form>

<%final String queryString = request.getQueryString() == null ? "" : request.getQueryString().replaceAll("&locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]|^locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]", "");%>
<c:set var='query' value='<%=queryString%>'/>
<c:set var="xquery" value="${fn:escapeXml(query)}"/>
<c:set var="loginUrl" value="login?${xquery}${not empty xquery ? '&' : ''}locale="/>
<ul>
    <li><a href="${loginUrl}zh_CN">简体中文</a></li>
    <li><a href="${loginUrl}en">English</a></li>
</ul>
</body>
</html>
