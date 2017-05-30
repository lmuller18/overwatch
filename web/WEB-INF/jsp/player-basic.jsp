<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="player" value="${player}"/>
<div id="player-info" style="display: none;" class="search-header">
    <div class="jumbotron player-jumbo">
        <div class="row">
            <div class="col-md-5">
                <h1 class="italic-orange"><img src="${player.getPortrait()}"> ${player.getName()}: ${player.getLevel()}</h1>
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
                                        <h3 class="standard-white">${quick.get(0).title}: ${quick.get(0).value}</h3>
                                        <h3 class="standard-white">${quick.get(1).title}: ${quick.get(1).value}</h3>
                                    </div>
                                    <div class="col-sm-6">
                                        <h3 class="standard-white">${quick.get(2).getTitle()}: ${quick.get(2).getValue()}</h3>
                                        <h3 class="standard-white">${quick.get(3).getTitle()}: ${quick.get(3).getValue()}</h3>
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
            <div class="col-md-4">
                <h1 class="italic-white">Hero Stats</h1>
                <ul class="nav nav-pills">
                    <li role="presentation" class="active"><a href="#heroesQuick" aria-controls="heroesQuick" role="tab" data-toggle="tab">Quickplay</a></li>
                    <li role="presentation"><a href="#heroesComp" aria-controls="heroesComp" role="tab" data-toggle="tab">Competitive</a></li>
                </ul>

                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane fade in active scroll" id="heroesQuick" style="max-height: 500px; overflow-y: auto">
                        <c:set var="topQuickHeroes" value="${player.getTopQuickHeroes()}"/>
                        <div class="container">
                            <c:forEach items="${topQuickHeroes}" var="hero">
                                <div class="row">
                                    <h1 class="italic-orange">
                                        <img src="${hero.img}">
                                            ${hero.hero}
                                    </h1>
                                    <h2 class="standard-white">${hero.played}</h2>
                                </div>
                                <hr class="divider">
                            </c:forEach>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade scroll" id="heroesComp" style="max-height: 500px; overflow-y: auto">
                        <c:set var="topCompHeroes" value="${player.getTopCompHeroes()}"/>
                        <div class="container">
                            <c:forEach items="${topCompHeroes}" var="hero">
                                <div class="row">
                                    <h1 class="italic-orange">
                                        <img src="${hero.img}">
                                            ${hero.hero}
                                    </h1>
                                    <h2 class="standard-white">${hero.played}</h2>
                                </div>
                                <hr class="divider">
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <h1 class="italic-white">Combat Stats</h1>
                <ul class="nav nav-pills">
                    <li role="presentation" class="active"><a href="#combatQuick" aria-controls="combatQuick" role="tab" data-toggle="tab">Quickplay</a></li>
                    <li role="presentation"><a href="#combatComp" aria-controls="combatComp" role="tab" data-toggle="tab">Competitive</a></li>
                </ul>

                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane fade in active scroll" id="combatQuick" style="max-height: 500px; overflow-y: auto">
                        <c:set var="quickCombat" value="${player.getQuickCombatStats()}"/>
                        <div class="container">
                            <c:if test="${quickCombat.size() == 0}">
                                <h2 class="italic-white">No Quickplay Stats</h2>
                            </c:if>
                            <c:if test="${quickCombat.size() != 0}">
                                <c:forEach items="${quickCombat}" var="combat">
                                    <div class="row">
                                        <h1 class="italic-orange">${combat.title}: </h1>
                                        <h2 class="standard-white">${combat.value}</h2>
                                    </div>
                                    <hr class="divider">
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade scroll" id="combatComp" style="max-height: 500px; overflow-y: auto">
                        <c:set var="compCombat" value="${player.getCompCombatStats()}"/>
                        <div class="container">
                            <c:if test="${compCombat.size() == 0}">
                                <h2 class="italic-white">No Competitive Stats</h2>
                            </c:if>
                            <c:if test="${compCombat.size() != 0}">
                                <c:forEach items="${compCombat}" var="combat">
                                    <div class="row">
                                        <h1 class="italic-orange">${combat.title}</h1>
                                        <h2 class="standard-white">${combat.value}</h2>
                                    </div>
                                    <hr class="divider">
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <h1 class="italic-white">Milestones</h1>
                <ul class="nav nav-pills">
                    <li role="presentation" class="active"><a href="#averageQuick" aria-controls="averageQuick" role="tab" data-toggle="tab">Quickplay Averages</a></li>
                    <li role="presentation"><a href="#bestQuick" aria-controls="bestQuick" role="tab" data-toggle="tab">Quickplay Bests</a></li>
                    <li role="presentation"><a href="#averageComp" aria-controls="averageComp" role="tab" data-toggle="tab">Competitive Averages</a></li>
                    <li role="presentation"><a href="#bestComp" aria-controls="bestComp" role="tab" data-toggle="tab">Competitive Bests</a></li>
                </ul>

                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane fade in active scroll" id="averageQuick" style="max-height: 500px; overflow-y: auto">
                        <c:set var="averageQuick" value="${player.getAverageQuickStats()}"/>
                        <div class="container">
                            <c:if test="${averageQuick.size() == 0}">
                                <h2 class="italic-white">No Quickplay Stats</h2>
                            </c:if>
                            <c:if test="${averageQuick.size() != 0}">
                                <c:forEach items="${averageQuick}" var="stat">
                                    <div class="row">
                                        <h1 class="italic-orange">${stat.title}: </h1>
                                        <h2 class="standard-white">${stat.value}</h2>
                                    </div>
                                    <hr class="divider">
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade active scroll" id="bestQuick" style="max-height: 500px; overflow-y: auto">
                        <c:set var="bestQuick" value="${player.getBestQuickStats()}"/>
                        <div class="container">
                            <c:if test="${bestQuick.size() == 0}">
                                <h2 class="italic-white">No Quickplay Stats</h2>
                            </c:if>
                            <c:if test="${bestQuick.size() != 0}">
                                <c:forEach items="${bestQuick}" var="stat">
                                    <div class="row">
                                        <h1 class="italic-orange">${stat.title}: </h1>
                                        <h2 class="standard-white">${stat.value}</h2>
                                    </div>
                                    <hr class="divider">
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade scroll" id="averageComp" style="max-height: 500px; overflow-y: auto">
                        <c:set var="averageComp" value="${player.getAverageCompStats()}"/>
                        <div class="container">
                            <c:if test="${averageComp.size() == 0}">
                                <h2 class="italic-white">No Competitive Stats</h2>
                            </c:if>
                            <c:if test="${averageComp.size() != 0}">
                                <c:forEach items="${averageComp}" var="stat">
                                    <div class="row">
                                        <h1 class="italic-orange">${stat.title}</h1>
                                        <h2 class="standard-white">${stat.value}</h2>
                                    </div>
                                    <hr class="divider">
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane fade scroll" id="bestComp" style="max-height: 500px; overflow-y: auto">
                        <c:set var="bestComp" value="${player.getBestCompStats()}"/>
                        <div class="container">
                            <c:if test="${bestComp.size() == 0}">
                                <h2 class="italic-white">No Competitive Stats</h2>
                            </c:if>
                            <c:if test="${bestComp.size() != 0}">
                                <c:forEach items="${bestComp}" var="stat">
                                    <div class="row">
                                        <h1 class="italic-orange">${stat.title}</h1>
                                        <h2 class="standard-white">${stat.value}</h2>
                                    </div>
                                    <hr class="divider">
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>