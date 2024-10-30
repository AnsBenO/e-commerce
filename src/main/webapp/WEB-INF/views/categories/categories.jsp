<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ansbeno.entities.Category, java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/output.css">
  <title>Categories</title>
</head>
<body >

  <%@ include file="/WEB-INF/fragments/nav.jsp" %>
  <% List<Category> categories = (List<Category>) session.getAttribute("categories"); %>

  <div class="container mt-20 max-w-4xl mx-auto bg-white shadow-md rounded-lg p-6">
    <h1 class="text-2xl font-bold text-center mb-6 text-gray-800">Category Management</h1>

    <!-- Create Category Form -->
    <form action="categories" method="post" class="space-y-4">
      <div>
        <label class="block text-sm font-medium text-gray-700" for="categoryName" >Name</label>
        <input type="text" name="categoryName" 
               class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
               placeholder="Enter category name" />
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700" for="description">Description</label>
        <input type="text" name="description" 
               class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
               placeholder="Enter description" />
      </div>

      <button type="submit" 
              class="w-full bg-teal-600 text-white py-2 px-4 rounded-md hover:bg-teal-700 transition">Create</button>
    </form>

    <!-- Search Form -->
    <div class="my-6">
      <form action="categories" method="get" class="flex space-x-2">
        <input type="text" name="keyword" placeholder="Search..."
                  value="${param.keyword}" 
               class="flex-1 p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" />
        <button type="submit" 
                class="bg-teal-500 text-white px-4 py-2 rounded-md hover:bg-teal-600 transition">Search</button>
      </form>
    </div>

    <!-- Categories Table -->
    <table class="w-full border-collapse border border-gray-300 text-sm">
      <thead>
        <tr class="bg-gray-100">
          <th class="border p-3 text-left">ID</th>
          <th class="border p-3 text-left">Name</th>
          <th class="border p-3 text-left">Description</th>
          <th class="border p-3 text-left">Action</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${categories}" var="category">
        <tr class="hover:bg-gray-50">
          <td class="border p-3"> <a href="products?category=${category.getName()}" > ${category.getId()} </a></td>
          <td class="border p-3"> <a href="products?category=${category.getName()}" > ${category.getName()} </a></td>
          <td class="border p-3"> <a href="products?category=${category.getName()}" > ${category.getDescription()} </a></td>
          <td class="border p-3">
            <form action="categories" method="post" class="inline">
              <input getName()="deleteId" type="hidden" value="${category.getId()}" />
              <button type="submit" 
                      class="bg-red-500 text-white px-3 py-1 rounded-md hover:bg-red-600 transition">Delete</button>
            </form>
          </td>
        </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

</body>
</html>
