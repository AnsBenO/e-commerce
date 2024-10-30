<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ansbeno.entities.Product, java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Products</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/output.css">

</head>
<body>
  <% List<Product> products = (List<Product>) session.getAttribute("products"); %>
  <%@ include file="/WEB-INF/fragments/nav.jsp" %>
  
  <div class=" container max-w-4xl mx-auto bg-white shadow-md rounded-lg p-6">
    <h1 class="text-2xl font-bold text-center mb-6 text-gray-800">
    <c:choose>
      <c:when test="${param.category != null}">
                    Products for product: <span class="text-teal-600">${param.product}</span>
      </c:when>
      <c:otherwise>All Products</c:otherwise>
    </c:choose>
    </h1>

    <!-- Create product Form -->
    <form action="products" method="post" class="space-y-4">
      <div>
        <label class="block text-sm font-medium text-gray-700" for="productName" >Name</label>
        <input type="text" name="productName" 
               class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
               placeholder="Enter product name" />
      </div>
      
      <div>
        <label class="block text-sm font-medium text-gray-700" for="price">Price</label>
        <input type="text" name="price" 
               class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
               placeholder="Enter price" />
      </div>
      
      <div>
        <label class="block text-sm font-medium text-gray-700" for="quantity">Quantity</label>
        <input type="text" name="quantity" 
               class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
               placeholder="Enter quantity" />
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700" for="description">Description</label>
        <input type="text" name="description" 
               class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
               placeholder="Enter description" />
      </div>
      
      <div>
        <label class="block text-sm font-medium text-gray-700" for="image">Image URL</label>
        <input type="text" name="image" 
               class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
               placeholder="Enter image URL" />
      </div>

      <button type="submit" 
              class="w-full bg-teal-600 text-white py-2 px-4 rounded-md hover:bg-teal-700 transition">Create</button>
    </form>

    <!-- Search Form -->
    <div class="my-6 flex gap-2">
      <form action="products" method="get" class="basis-9/12 flex space-x-2">
        <input type="text" name="keyword" placeholder="Search..."
                  value="${param.keyword}" 
               class="flex-1 p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" />
        <button type="submit" 
                class="bg-teal-500 text-white px-4 py-2 rounded-md hover:bg-teal-600 transition">Search</button>
      </form>

      <form class="basis-3/12 flex space-x-2" action="products" method="get" onchange="this.submit()">
        <c:set var="categories" value="${sessionScope.categories}" />
        
       <select name="category" class="w-full text-center">
  <c:forEach var="category" items="${categories}">
    <option value="${category}" 
      <c:if test="${param.category == category}">selected</c:if>>
      ${category}
    </option>
  </c:forEach>
        </select>

      </form>
    </div>

    <!-- products Table -->
    <table class="w-full border-collapse border border-gray-300 text-sm">
      <thead>
        <tr class="bg-gray-100">
          <th class="border p-3 text-left">ID</th>
          <th class="border p-3 text-left">Name</th>
          <th class="border p-3 text-left">Price</th>
          <th class="border p-3 text-left">Quantity</th>
          <th class="border p-3 text-left">Description</th>
          <th class="border p-3 text-left">Image</th>
          <th class="border p-3 text-left">Action</th>
        </tr>
      </thead>
      <tbody>
        <% for (Product product : products) { %>
        <tr class="hover:bg-gray-50">
          <td class="border p-3"><%= product.getId() %></td>
          <td class="border p-3"><%= product.getName() %></td>
          <td class="border p-3"><%= product.getPrice() %></td>
          <td class="border p-3"><%= product.getQuantity() %></td>
          <td class="border p-3"><%= product.getDescription() %></td>
          <td class="border p-3"><img src="<%= product.getImage() %>" alt="<%= product.getName() %>" class="w-16 h-16 object-cover" /></td>
          <td class="border p-3">
            <form action="products" method="post" class="inline">
              <input name="deleteId" type="hidden" value="<%= product.getId() %>" />
              <button type="submit" 
                      class="bg-red-500 text-white px-3 py-1 rounded-md hover:bg-red-600 transition">Delete</button>
            </form>
          </td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
</body>
</html>

