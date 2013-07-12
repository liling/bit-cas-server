<%@ page contentType="text/html; charset=UTF-8" %>
<%--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License.  You may obtain a
    copy of the License at the following location:

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.

--%>
<jsp:directive.include file="includes/top.jsp" />

<c:if test="${not pageContext.request.secure}">
<div id="msg" class="errors">
    <h2>Non-secure Connection</h2>
    <p>You are currently accessing CAS over a non-secure connection.  Single Sign On WILL NOT WORK.  In order to have single sign on work, you MUST log in over HTTPS.</p>
</div>
</c:if>

  <div class="box fl-panel" id="login">
			<form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" htmlEscape="true">
                  <form:errors path="*" id="msg" cssClass="errors" element="div" />
                <!-- <spring:message code="screen.welcome.welcome" /> -->
                    <h2><spring:message code="screen.welcome.instructions" /></h2>
                    <div class="row fl-controls-left">
                        <label for="username" class="fl-label"><spring:message code="screen.welcome.label.netid" /></label>
						<c:if test="${not empty sessionScope.openIdLocalId}">
						<strong>${sessionScope.openIdLocalId}</strong>
						<input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}" />
						</c:if>

						<c:if test="${empty sessionScope.openIdLocalId}">
						<spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
						<form:input cssClass="required osk-trigger" cssErrorClass="erro osk-triggerr" id="username" size="25" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" htmlEscape="true" />
						</c:if>
                    </div>
                    <div class="row fl-controls-left">
                        <label for="password" class="fl-label"><spring:message code="screen.welcome.label.password" /></label>
						<%--
						NOTE: Certain browsers will offer the option of caching passwords for a user.  There is a non-standard attribute,
						"autocomplete" that when set to "off" will tell certain browsers not to prompt to cache credentials.  For more
						information, see the following web page:
						http://www.geocities.com/technofundo/tech/web/ie_autocomplete.html
						--%>
						<spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
						<form:password cssClass="required osk-trigger" cssErrorClass="error osk-trigger" id="password" size="25" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" />
                    </div>
                    <div class="row remember">
                        <input type="checkbox" name="rememberMe" id="rememberMe" value="true" tabindex="3"/>
                        <label for="rememberMe"><spring:message code="screen.welcome.label.remember" /></label>
                    </div>
                    <div class="row check">
                        <input id="warn" name="warn" value="true" tabindex="3" accesskey="<spring:message code="screen.welcome.label.warn.accesskey" />" type="checkbox" />
                        <label for="warn"><spring:message code="screen.welcome.label.warn" /></label>
                    </div>
                    <div class="row btn-row">
						<input type="hidden" name="lt" value="${loginTicket}" />
						<input type="hidden" name="execution" value="${flowExecutionKey}" />
						<input type="hidden" name="_eventId" value="submit" />

                        <input class="btn-submit" name="submit" accesskey="l" value="<spring:message code="screen.welcome.button.login" />" tabindex="4" type="submit" />
                        <input class="btn-reset" name="reset" accesskey="c" value="<spring:message code="screen.welcome.button.clear" />" tabindex="5" type="reset" />
                        <a href="https://login.bit.edu.cn/profile/passwords/recovery"><spring:message code="screen.welcome.button.reset.password" /></a>
                    </div>
            </form:form>
          </div>
            <div id="sidebar">
				<div class="sidebar-content">
              <img src="images/secrecy-icon.png" alt="图标" style="float: right"/>
              <h2><spring:message code="bit.account.teacher.title" text="教职员工用户名密码" /></h2>
              <p><spring:message code="bit.account.teacher.description" text="教职员工用户名为十位工号，初始密码为身份证件号后六位（其中字母为小写）或八位数字组成的出生日期。" /></p>
              <h2><spring:message code="bit.account.student.title" text="学生用户名密码" /></h2>
              <p><spring:message code="bit.account.student.description" text="学生用户名为学号，初始密码为身份证号后六位，其中字母均为小写。若您登记的个人信息中没有身份证号，则密码为八位班号或出生日期。" /></p>

                <p class="fl-panel fl-note fl-bevel-white fl-font-size-80"><spring:message code="screen.welcome.security" /></p>
                <div id="list-languages" class="fl-panel">
                <%final String queryString = request.getQueryString() == null ? "" : request.getQueryString().replaceAll("&locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]|^locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]", "");%>
					<c:set var='query' value='<%=queryString%>' />
                    <c:set var="xquery" value="${fn:escapeXml(query)}" />
                  <h3>Languages:</h3>
                  <c:choose>
                     <c:when test="${not empty requestScope['isMobile'] and not empty mobileCss}">
                        <form method="get" action="login?${xquery}">
                           <select name="locale">
                               <option value="zh_CN">简体中文</option>
                               <option value="en">English</option>
                           </select>
                           <input type="submit" value="Switch">
                        </form>
                     </c:when>
                     <c:otherwise>
                        <c:set var="loginUrl" value="login?${xquery}${not empty xquery ? '&' : ''}locale=" />
						<ul
							><li class="first"><a href="${loginUrl}zh_CN">简体中文</a></li
							><li class="last"><a href="${loginUrl}en">English</a></li
						></ul>
                     </c:otherwise>
                   </c:choose>
                </div>
				</div>
            </div>
<jsp:directive.include file="includes/bottom.jsp" />
