<%@ page import="com.overwatch.Hero" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="player" value="${player}"/>
<c:set var="comp" value="${player.getCompStat()}"/>
<c:choose>
    <c:when test="${comp.size() < 4}">
        <h2 class="standard-white">No Competitive Stats</h2>
    </c:when>
    <c:otherwise>
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="statBox gamesWon">
                        <div class="statBoxContent">
                            <h1 class="card-heading italic-white">${comp.get(0).value}</h1>
                            <p class="card-copy standard-white">${comp.get(0).title}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="statBox fire">
                        <div class="statBoxContent">
                            <h1 class="card-heading italic-white">${comp.get(1).value}</h1>
                            <p class="card-copy standard-white">${comp.get(1).title}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="statBox objectiveTime">
                        <div class="statBoxContent">
                            <h1 class="card-heading italic-white">${comp.get(2).value}</h1>
                            <p class="card-copy standard-white">${comp.get(2).title}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="statBox timePlayed">
                        <div class="statBoxContent">
                            <h1 class="card-heading italic-white">${comp.get(3).value}</h1>
                            <p class="card-copy standard-white">${comp.get(3).title}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>