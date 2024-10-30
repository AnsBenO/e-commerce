<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <title>e-commerce Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/output.css">

</head>

<body class="bg-gray-50">

<%@ include file="/WEB-INF/fragments/nav.jsp" %>

    <!-- Welcome Message -->
    <div class="container mx-auto text-center mt-20">
        <h2 class="text-4xl font-bold text-gray-800">Welcome to the e-commerce website!</h2>
        <p class="mt-6 text-lg text-gray-600">Browse our collection of categories and products.</p>

        <div class="mt-10">
            <a href="${pageContext.request.contextPath}/categories" 
               class="bg-teal-500 text-white px-6 py-3 rounded-lg hover:bg-teal-600 mr-4">
                Explore Categories
            </a>
            <a href="${pageContext.request.contextPath}/products" 
               class="bg-teal-500 text-white px-6 py-3 rounded-lg hover:bg-teal-600">
                View products
            </a>
        </div>
    </div>
</body>

</html>