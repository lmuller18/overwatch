<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<link href="http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="static/css/OverwatchStyles.css">
<link rel="stylesheet" href="static/css/Heroes.css">
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>

<html>
    <head>
        <title>Overwatch</title>
        <link rel="shortcut icon" href="static/images/favicon.ico" type="image/x-icon">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    </head>
    <body>
    <jsp:include page="WEB-INF/jsp/navbar.jsp" />
   <!-- <img align=center src="/static/images/logo.png">-->
    <c:if test="${searched == true}">
        <c:choose>
            <c:when test="${view == 'standard'}">
                <jsp:include page="WEB-INF/jsp/player-basic.jsp" />
            </c:when>
            <c:when test="${view == 'advanced'}">
                <jsp:include page="WEB-INF/jsp/profile.jsp" />
            </c:when>
        </c:choose>
    </c:if>

   <div id="search-header" class="search-header">
       <div class="container">
           <div class="row">
               <div class="col-lg-12">
                   <div class="search-container">
                       <div class="jumbotron main-jumbo">
                           <form name="searchForm" method="POST" action="${pageContext.request.contextPath}/search">
                               <label class="mr-sm-2" for="playerName">Username</label>
                               <input id="playerName" type="text" name="playerName" class="form-control">
                               <label class="mr-sm-2" for="playerCode">Battlenet Code</label>
                               <input id="playerCode" type="text" name="playerCode" class="form-control">
                               <label class="mr-sm-2" for="regionSelect">Region</label>
                               <select class="form-control" name="region" id="regionSelect">
                                   <option value="us">US</option>
                                   <option value="eu">EU</option>
                                   <option value="kr">KR</option>
                                   <option value="cn">CN</option>
                                   <option value="global">Global</option>
                               </select>
                               <label class="mr-sm-2" for="platformSelect">Platform</label>
                               <select class="form-control" name="platform" id="platformSelect" onchange="checkRegions()">
                                   <option value="pc">PC</option>
                                   <option value="xbl">XBL</option>
                                   <option value="psn">PSN</option>
                               </select>
                               <label class="mr-sm-2" for="viewSelect">Profile View</label>
                               <select class="form-control" name="view" id="viewSelect">
                                   <option value="standard">Standard</option>
                                   <option value="advanced">Advanced</option>
                               </select><br>
                               <button id="searchButton" type="submit" class="btn btn-primary" style="width: 100%">Search</button><br>
                           </form>
                           <div id="errorNotFound" align="center" class="alert alert-danger alert-dismissible" style="display: none">
                               <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                               <strong>Error: </strong> Player not found.
                           </div>
                           <div id="error" align="center" class="alert alert-danger alert-dismissible" style="display: none">
                               <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                               <strong>Error: </strong> Please search again.
                           </div>
                       </div>
                   </div>
               </div>
           </div>
       </div>
       <!-- /.container -->
   </div>

    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.7.5/js/bootstrap-select.min.js"></script>
    </body>
    <script>
        <c:if test="${notFound}">
            jQuery("#errorNotFound").slideDown();
        </c:if>

        <c:if test="${error}">
            jQuery("#error").slideDown();
        </c:if>

        <c:if test="${searched != null}">
            jQuery("#search-header").slideUp('slow',function() {
                jQuery("#player-info").slideDown('slow')
            });
        </c:if>

        jQuery("#backToSearch").click(function(){
            jQuery("#player-info").slideUp('slow',function() {
                jQuery("#search-header").slideDown('slow')
            });
        });
        checkRegions();
        function checkRegions(){
            var select = jQuery("#platformSelect");
            if(select.val()=="pc"){
                jQuery("label[for=playerCode], #playerCode, label[for=regionSelect], #regionSelect").slideDown();
            }else{
                jQuery("label[for=playerCode], #playerCode, label[for=regionSelect], #regionSelect").slideUp();
            }

        }
    </script>
</html>
