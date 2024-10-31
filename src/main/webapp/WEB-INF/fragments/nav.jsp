
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<fmt:setLocale value="${param.language != null ? param.language : 'en'}" />
<fmt:setBundle basename="bundles.bundle" var="lang" />

 <!-- Navigation Bar -->
    <nav class="bg-teal-500 p-4 text-white shadow-md">
        <div class="container mx-auto flex justify-between">
            <h1 class="text-xl font-bold">
                <a href="${pageContext.request.contextPath}/">
                    e-commerce
                </a>
            
            </h1>
            <div class="flex justify-between items-center min-w-80">
                <div class="flex items-center justify-between gap-4">
                    <a href="categories" 
                       class="mr-4 hover:text-teal-300"><fmt:message key="categories.title" bundle="${lang}" /></a>
                    <a href="products" 
                       class="hover:text-teal-300"><fmt:message key="products.title" bundle="${lang}" /></a>
                
                </div>
                    <form action="" method="get" class="inline">
                        <select name="language" onchange="this.form.submit()" class="bg-white text-black border border-gray-300 rounded-md p-2">
                            <option value="en" ${param.language == 'en' ? 'selected' : ''}>English</option>
                            <option value="es" ${param.language == 'es' ? 'selected' : ''}>Español</option>
                        </select>
                    </form>
            </div>
        </div>
    </nav>

