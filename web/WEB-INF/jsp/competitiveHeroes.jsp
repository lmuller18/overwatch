<%@ page import="com.overwatch.Hero" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="player" value="${player}"/>
<c:set var="topCompHeroes" value="${player.getTopCompHeroes()}"/>
<c:set var="comp" value="competitive"/>
<script>
    var compHours = [];
    var compHeroes = [];
</script>
<c:forEach items="${topCompHeroes}" var="hero">
    <div>
        <div class="progress" data-toggle="collapse" data-target="#collapseComp${hero.heroClass}" data-parent="#accordion">
            <div class="progress-bar hero ${hero.heroClass}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" >
                <span class="form-group italic-white"><img class="hero-img" src="${hero.img}">${hero.hero}: ${hero.played}</span>
            </div>
        </div>
        <div id="collapseComp${hero.heroClass}" class="panel-collapse collapse">
            <div class="panel-body">
                <div id="statCarousel${hero.heroClass}" class="carousel slide" data-interval="false" data-ride="carousel" >
                    <!-- Wrapper for slides -->
                    <div class="carousel-inner" role="listbox">
                        <div class="item">
                            <div class="panel panel-stat">
                                <div class="panel-heading italic-white">
                                    <!-- Controls -->
                                    <a class="carousel-left" href="#statCarousel${hero.heroClass}" role="button" data-slide="prev">
                                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                    <a class="carousel-right" href="#statCarousel${hero.heroClass}" role="button" data-slide="next">
                                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                    <div align="center"> General Stats </div>
                                </div>
                                <div class="table-holder scroll">
                                    <table class="table">
                                        <c:set var="heroGeneralStats" value="${player.getHeroGeneralStats(hero.heroClass, comp)}"/>
                                        <c:if test="${heroGeneralStats != null}">
                                            <c:forEach items="${heroGeneralStats}" var="heroStat">
                                                <tr>
                                                    <td class="italic-white"> ${heroStat.key}</td>
                                                    <td class="standard-white text-right value">${heroStat.value}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="panel panel-stat">
                                <div class="panel-heading italic-white">
                                    <!-- Controls -->
                                    <a class="carousel-left" href="#statCarousel${hero.heroClass}" role="button" data-slide="prev">
                                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                    <a class="carousel-right" href="#statCarousel${hero.heroClass}" role="button" data-slide="next">
                                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                    <div align="center"> Average Stats </div>
                                </div>
                                <div class="table-holder scroll">
                                    <table class="table average">
                                        <c:set var="heroAverageStats" value="${player.getHeroAverageStats(hero.heroClass, comp)}"/>
                                        <c:if test="${heroAverageStats != null}">
                                            <c:forEach items="${heroAverageStats}" var="heroAvgStat">
                                                <tr>
                                                    <td class="italic-white"> ${heroAvgStat.key}</td>
                                                    <td class="standard-white text-right value">${heroAvgStat.value}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="item active">
                            <div class="panel panel-stat">
                                <div class="panel-heading italic-white">
                                    <!-- Controls -->
                                    <a class="carousel-left" href="#statCarousel${hero.heroClass}" role="button" data-slide="prev">
                                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                    <a class="carousel-right" href="#statCarousel${hero.heroClass}" role="button" data-slide="next">
                                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                    <div align="center"> Specific Stats </div>
                                </div>
                                <div class="table-holder scroll">
                                    <table class="table">
                                        <c:set var="heroSpecificStats" value="${player.getHeroSpecificStats(hero.heroClass, comp)}"/>
                                        <c:if test="${heroSpecificStats != null}">
                                            <c:forEach items="${heroSpecificStats}" var="heroSpecStat">
                                                <tr>
                                                    <td class="italic-white"> ${heroSpecStat.key}</td>
                                                    <td class="standard-white text-right value">${heroSpecStat.value}</td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <hr class="divider">
    <script>
        compHours.push(${hero.hours});
        compHeroes.push("${hero.heroClass}");
    </script>
</c:forEach>