<!DOCTYPE html>
<html>
  <head>
    <title>Customer Support</title>
  </head>
  <body>
    <header>
        <a href="<c:url value="/ticket/list" />"><h1>SSC Forum</h1></a>
          <ul>
            <security:authorize access="hasRole('ADMIN')"> 
              <li>
                  <a href="<c:url value="/user" />"><spring:message code="Manage.User" text="Manage User Accounts" /></a></li>
                </security:authorize>
            <li><a href="?lang=en_US">English</a></li>
            <li><a href="?lang=zh_HK"><spring:message code="Chinese.language" text="Chinese" /></a></li>
            <li><security:authorize access="isAnonymous()"><a href="/CourseDiscussionForum/login"><spring:message code="login" text="" /></a></security:authorize></li>
            <li><security:authorize access="isAnonymous()"><a href="/CourseDiscussionForum/create"><spring:message code="create.account" text="Create Account" /></a></security:authorize></li>  
            </ul>
          <security:authorize access="isAuthenticated()">
            <c:url var="logoutUrl" value="/logout"/>     
            <form action="${logoutUrl}" method="post">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              <input type="image" src="https://na.cx/i/7t082m7.png" class="imageresize" >
            </form>

          </security:authorize>
        </header>
    <br/><br/><br/><br/>
    <h2><spring:message code="Lecture.Cat" text="Lecture" /></h2>


    <security:authorize access="hasRole('ADMIN')"> 
      <a href="<c:url value="/poll/create" />"><spring:message code="Create.Poll" text="Create new poll" /></a>
    </security:authorize>
    <security:authorize access="isAuthenticated()">
      <a href="<c:url value="/ticket/create" />"><spring:message code="New.Post" text="New Post" /></a> 
    </security:authorize>  

    <a href="<c:url value="/ticket/listlecture" />"><spring:message code="Lecture.Cat" text="Lecture" /></a>
    <a href="<c:url value="/ticket/listlab" />"><spring:message code="Lab.Cat" text="Lab" /></a>
    <a href="<c:url value="/ticket/listother" />"><spring:message code="Other.Cat" text="Other" /></a> 
    <a href="<c:url value="/ticket/list" />"><spring:message code="All.post" text="All" /></a>


    <br /><br />
    <c:choose>
      <c:when test="${fn:length(ticketDatabase) == 0}">
        <i><spring:message code="zero.post" text="0 Post." /></i>
      </c:when>
      <c:otherwise>

        <c:forEach items="${ticketDatabase}" var="entry3">
          <c:if test="${entry3.categories == 'lecture'}" >
            <spring:message code="Post.arrange" text="Post #" />${entry3.id}:
            <a href="<c:url value="/ticket/view/${entry3.id}" />"> 
              <c:out value="${entry3.subject}" /></a>
            <spring:message code="Post.owner" text="(Post by: " /><c:out value="${entry3.customerName}" />)     
            <security:authorize access="isAuthenticated()">
              <security:authorize access="hasRole('ADMIN') or principal.username=='${entry3.customerName}'">            
                [<a href="<c:url value="/ticket/edit/${entry3.id}" />"><spring:message code="Edit.post" text="Edit" /></a>]
              </security:authorize>
            </security:authorize>  
            <security:authorize access="hasRole('ADMIN')">            
              [<a href="<c:url value="/ticket/delete/${entry3.id}" />"><spring:message code="Del.post" text="Delete" /></a>]
            </security:authorize>
            <hr>
          </c:if>  
        </c:forEach>
      </c:otherwise>
    </c:choose>
            
            <br>      
    <c:choose>
      <c:when test="${fn:length(pollTicketDatabase) == 0}">

      </c:when>
      <c:otherwise>
        <c:forEach items="${pollTicketDatabase}" var="entry5">
          <spring:message code="Poll.no" text="Poll #" />${entry5.key}: 
          <security:authorize access="isAuthenticated()"><a href="<c:url value="/poll/view/${entry5.key}" />"> 
              <c:out value="${entry5.value.pollSubject}" /></a>
            </security:authorize>
            <security:authorize access="isAnonymous()"><a href="<c:url value="/poll/viewresult/${entry5.key}" />"> 
              <c:out value="${entry5.value.pollSubject}" /></a>
            </security:authorize>
          <br>
        </c:forEach>
      </c:otherwise>  
    </c:choose>
  </body>
</html>