<%@ page import="com.overwatch.Hero" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="player" value="${player}"/>
<div id="player-info" style="display: none;" class="search-header">
    <div class="jumbotron player-jumbo">
        <div class="row">
            <h1 class="italic-white" style="display: inline-block"><img width="80px" height="80px" src="${player.getPortrait()}"> ${player.getName()} </h1>
            <!--<div style="display: inline-block">
            <div class="player-level">
                <div class="u-vertical-center"></div>
                <div class="player-rank"></div>
            </div>-->
        </div>
        <div class="row">
            <div id="quick" class="quick" style="max-height: 500px; overflow-y: auto">
                <jsp:include page="quickplayPlayer.jsp" />
            </div>
            <div id="comp" class="comp" style="max-height: 500px; overflow-y: auto; display: none;">
                <jsp:include page="competitivePlayer.jsp" />
            </div>
        </div>
        <div class="row">
            <div align="right">
                <input id="modeChange" type="checkbox" checked>
            </div>
        </div>
        <hr>

        <div class="row">
            <h1 class="italic-white">Hero Stats</h1>
            <div class="container accordion quick">
                <jsp:include page="quickplayHeroes.jsp" />
            </div>
            <div class="container accordion comp" style="display: none">
                <jsp:include page="competitiveHeroes.jsp" />
            </div>
        </div>
    </div>
</div>

<script>
    jQuery(function() {
        jQuery('#modeChange').bootstrapToggle({
            on: 'Quickplay',
            off: 'Competitive'
        });
    });
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

    var topQuickHours = "${player.getMostQuickHours()}";
    quickHours.forEach(function(played, i){
        var offset = (played/topQuickHours)*100;
        var progress = jQuery(".quick .progress ."+quickHeroes[i]);
        progress.attr("aria-valuenow", offset);
        progress.css("width", offset+"%");
    });

    var topCompHours = "${player.getMostCompHours()}";
    compHours.forEach(function(played, i){
        var offset = (played/topCompHours)*100;
        var progress = jQuery(".comp .progress ."+compHeroes[i]);
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

    jQuery('#modeChange').change(function() {
        if(jQuery(this).prop('checked')){
            jQuery(".comp").each(function () {
                jQuery(this).slideUp( function() {
                    jQuery(".quick").each(function () {
                        jQuery(this).slideDown();
                    });
                });
            });
        } else {
            jQuery(".quick").each(function () {
                jQuery(this).slideUp( function() {
                    jQuery(".comp").each(function () {
                        jQuery(this).slideDown();
                    });
                });
            });
        }
    });
</script>