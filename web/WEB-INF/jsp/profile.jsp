<%@ page import="com.overwatch.Hero" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="player" value="${player}"/>
<div id="player-info" style="display: none;" class="search-header">
    <div class="jumbotron player-jumbo">
        <div class="row">
            <div class="col-md-5">
                <div class="row" style="margin: 20% 0;">
                    <h1 class="italic-white" style="display: inline-block"><img width="80px" height="80px" src="${player.getPortrait()}"> ${player.getName()} </h1>
                    <!--<div style="display: inline-block">
                    <div class="player-level">
                        <div class="u-vertical-center">${player.getLevel()}</div>
                        <div class="player-rank"></div>
                    </div>
                </div>-->
                </div>
            </div>
            <div class="col-md-7">
                <ul class="nav nav-pills">
                    <li role="presentation" class="active"><a href="#quick" aria-controls="quick" role="tab" data-toggle="tab">Quickplay</a></li>
                    <li role="presentation"><a href="#comp" aria-controls="comp" role="tab" data-toggle="tab">Competitive</a></li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane fade in active scroll" id="quick" style="max-height: 500px; overflow-y: auto">
                        <c:set var="quick" value="${player.getQuickStat()}"/>
                        <c:if test="${quick.size() != 4}">
                            <h2 class="standard-white">No Quickplay Stats</h2>
                        </c:if>
                        <c:if test="${quick.size() == 4}">
                            <div class="container">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="statBox">
                                            <div class="statBoxContent">
                                                <h1 class="card-heading italic-white">${quick.get(0).value}</h1>
                                                <p class="card-copy standard-white">${quick.get(0).title}</p>
                                            </div>
                                        </div>
                                        <div class="statBox">
                                            <div class="statBoxContent">
                                                <h1 class="card-heading italic-white">${quick.get(1).value}</h1>
                                                <p class="card-copy standard-white">${quick.get(1).title}</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="statBox">
                                            <div class="statBoxContent">
                                                <h1 class="card-heading italic-white">${quick.get(2).value}</h1>
                                                <p class="card-copy standard-white">${quick.get(2).title}</p>
                                            </div>
                                        </div>
                                        <div class="statBox">
                                            <div class="statBoxContent">
                                                <h1 class="card-heading italic-white">${quick.get(3).value}</h1>
                                                <p class="card-copy standard-white">${quick.get(3).title}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    <div role="tabpanel" class="tab-pane fade scroll" id="comp" style="max-height: 500px; overflow-y: auto">
                        <c:set var="comp" value="${player.getCompStat()}"/>
                        <c:if test="${comp.size() != 4}">
                            <h2 class="standard-white">No Competitive Stats</h2>
                        </c:if>
                        <c:if test="${comp.size() == 4}">
                            <div class="container">
                                <div class="row">
                                    <h1 class="standard-white">${comp.get(0).getTitle()}: ${comp.get(0).getValue()}</h1>
                                    <h1 class="standard-white">${comp.get(1).getTitle()}: ${comp.get(1).getValue()}</h1>
                                </div>
                                <div class="row">
                                    <h1 class="standard-white">${comp.get(2).getTitle()}: ${comp.get(2).getValue()}</h1>
                                    <h1 class="standard-white">${comp.get(3).getTitle()}: ${comp.get(3).getValue()}</h1>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            <hr>
        </div>

        <div class="row">
            <h1 class="italic-white">Hero Stats</h1>
                <c:set var="topQuickHeroes" value="${player.getTopQuickHeroes()}"/>
                <c:set var="quick" value="quickplay"/>
                <div class="container">
                    <script>
                        var hours = [];
                        var heroes = [];
                    </script>
                    <c:forEach items="${topQuickHeroes}" var="hero">
                        <div id="accordion">
                            <div class="progress" data-toggle="collapse" data-target="#collapse${hero.heroClass}" data-parent="#accordion">
                                <div class="progress-bar hero ${hero.heroClass}" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" >
                                    <span class="form-group italic-white"><img class="hero-img" src="${hero.img}">${hero.hero}: ${hero.played}</span>
                                </div>
                            </div>
                            <div id="collapse${hero.heroClass}" class="panel-collapse collapse">
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
                                                            <c:set var="heroGeneralStats" value="${player.getHeroGeneralStats(hero.heroClass, quick)}"/>
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
                                                            <c:set var="heroAverageStats" value="${player.getHeroAverageStats(hero.heroClass, quick)}"/>
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
                                                            <c:set var="heroSpecificStats" value="${player.getHeroSpecificStats(hero.heroClass, quick)}"/>
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
                            hours.push(${hero.hours});
                            heroes.push("${hero.heroClass}");
                        </script>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var border = "${player.getBorder()}";
    var rank = "${player.getRank()}";
    jQuery(".player-level").css("background-image","url("+border+")");
    jQuery(".player-rank").css("background-image","url("+rank+")");
    /**
    jQuery(".panel-collapse .heroStats").each(function(){
        var color = jQuery(this).css("background-color");
        color = color.substring(0, color.length-1);
        color += ", 0.5)";
        color = color.substring(0,3) + "a" + color.substring(3, color.length);
        jQuery(this).css("background-color", color);
    });
     **/

    var topHours = "${player.getMostQuickHours()}";
    hours.forEach(function(played, i){
        var offset = (played/topHours)*100;
        var progress = jQuery(".progress ."+heroes[i]);
        progress.attr("aria-valuenow", offset);
        progress.css("width", offset+"%");
    });

    jQuery(".panel-body td").each(function(i, obj) {
        obj = jQuery(obj);
        obj.text(obj.text().replace(/_/g, " ").replace(/average/g, ""));
    });

    jQuery(".value").each(function(i, obj) {
        obj = jQuery(obj);
        var text = obj.text();
        var decLoc = text.indexOf('.');
        var num = parseFloat(text);
        var reg = /0+/;
        var postDec = text.substring(decLoc + 1, text.length);
        if(reg.test(postDec)){
            obj.text(text.substring(0, decLoc));
        } else {
            obj.text(num.toFixed(2))
        }
    });
</script>