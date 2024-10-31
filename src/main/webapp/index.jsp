<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${param.language != null ? param.language : 'en'}" />
<fmt:setBundle basename="bundles.bundle" var="lang" />
<html lang="${param.language}">
<head>
    <title><fmt:message key="ecommerce.title.home" bundle="${lang}" /></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/output.css">
</head>

<body class="bg-gray-50">
<%@ include file="/WEB-INF/fragments/nav.jsp" %>

    <!-- Welcome Message -->
    <div class="container mx-auto text-center mt-20">
        <h2 class="text-4xl font-bold text-gray-800"><fmt:message key="welcome.title" bundle="${lang}" /></h2>
        <p class="mt-6 text-lg text-gray-600"><fmt:message key="welcome.message" bundle="${lang}" /></p>

        <div class="mt-10">
            <a href="${pageContext.request.contextPath}/categories" 
               class="bg-teal-500 text-white px-6 py-3 rounded-lg hover:bg-teal-600 mr-4">
                <fmt:message key="welcome.categories" bundle="${lang}" />
            </a>
            <a href="${pageContext.request.contextPath}/products" 
               class="bg-teal-500 text-white px-6 py-3 rounded-lg hover:bg-teal-600">
                <fmt:message key="welcome.products" bundle="${lang}" />
            </a>
        </div>
    </div>
</body>

</html>

