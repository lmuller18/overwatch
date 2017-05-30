package com.overwatch;

import com.google.gson.*;
import com.google.gson.reflect.TypeToken;

import javax.print.DocFlavor;
import java.io.*;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Class to search Overwatch API for player information
 */
public class Overwatch {

    private JsonObject statsObj;
    private JsonObject profileObj;
    private JsonObject heroObj;
    private String name;
    private String code;
    private String region;
    private String platform;
    private double mostCompHours = 0;
    private double mostQuickHours = 0;

    public boolean getPlayer(String name, String code, String region, String platform){
        try{
            this.name = name;
            this.code = code;
            this.region = region;
            this.platform = platform;
            boolean statsSuccess = retrieveData("stats", name, code, region, platform);
            boolean profileSuccess = retrieveData("profile", name, code, region, platform);
            boolean heroSuccess = retrieveData("hero", name, code, region, platform);
            if(!statsSuccess || !profileSuccess || !heroSuccess){
                return false;
            }
        } catch (IOException ex){
            ex.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean retrieveData(String obj, String name, String code, String region, String platform) throws IOException{
        String playerInfo = "";
        URL url;
        if(obj.equals("hero")){
            url = new URL("https://owapi.net/api/v3/u/"+name+"-"+code+"/heroes");
        }
        else {
            url = new URL("https://ancient-coast-85091.herokuapp.com/"+obj+"/"+platform+"/"+region+"/"+name+"-"+code+"");
        }
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        if(obj.equals("hero"))
            conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.95 Safari/537.11");
        conn.setRequestProperty("Accept", "application/json");

        try{
            BufferedReader br;
            br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String output;
            while ((output = br.readLine()) != null){
                playerInfo += output;
            }
            br.close();
            conn.disconnect();
        } catch (FileNotFoundException ex){
            return false;
        }

        JsonParser jsonParser = new JsonParser();
        JsonElement element = jsonParser.parse(playerInfo);

        JsonObject temp = element.getAsJsonObject();
        if(temp == null){
            return false;
        }
        if(obj.equals("stats")){
            statsObj = element.getAsJsonObject();
        } else if (obj.equals("profile")){
            profileObj = element.getAsJsonObject();
        } else {
            heroObj = element.getAsJsonObject().get(region).getAsJsonObject();
        }
        return true;
    }

    public int getLevel(){
        try {
            return Integer.parseInt(statsObj.get("level").toString());
        } catch (IllegalArgumentException ex){
            return -99;
        }
    }

    public String getName(){
        return statsObj.get("username").toString().replace("\"", "");
    }

    public String getPortrait(){
        return statsObj.get("portrait").toString().replace("\"", "");
    }

    public String getBorder(){
        return profileObj.get("levelFrame").toString().replace("\"", "");
    }

    public String getRank(){
        return profileObj.get("star").toString().replace("\"", "");
    }

    public double getMostQuickHours(){
        return this.mostQuickHours;
    }

    public double getMostCompHours(){
        return this.mostCompHours;
    }

    public void setMostQuickHours(double hours){
        this.mostQuickHours = hours;
    }

    public void setMostCompHours(double hours){
        this.mostCompHours = hours;
    }

    public Map<String, String> getHeroStats(String hero, String type, String statType){
        Map<String, String> heroMap;
        try{
            JsonObject heroStats = heroObj.get("heroes").getAsJsonObject();
            heroStats = heroStats.get("stats").getAsJsonObject();
            heroStats = heroStats.get(type).getAsJsonObject();
            heroStats = heroStats.get(hero.toLowerCase()).getAsJsonObject();
            heroStats = heroStats.get(statType).getAsJsonObject();

            Type t = new TypeToken<Map<String, String>>(){}.getType();
            heroMap = new Gson().fromJson( new Gson().toJson(heroStats), t);
            if(heroMap == null){
                heroMap = new HashMap<>();
                heroMap.put("Hello", "test");
            }
        } catch (NullPointerException ex){
            heroMap = new HashMap<>();
            heroMap.put("Hello", "test");
        }

        return heroMap;
    }

    public Map<String, String> getHeroAverageStats(String hero, String type){
        Map<String, String> heroMap;
        heroMap = getHeroStats(hero, type, "average_stats");
        return heroMap;
    }

    public Map<String, String> getHeroGeneralStats(String hero, String type){
        Map<String, String> heroMap;
        heroMap = getHeroStats(hero, type, "general_stats");
        return heroMap;
    }

    public Map<String, String> getHeroSpecificStats(String hero, String type){
        Map<String, String> heroMap;
        heroMap = getHeroStats(hero, type, "hero_stats");
        return heroMap;
    }

    public List<Hero> getTopQuickHeroes(){
        List<Hero> heroes = new Gson().fromJson(statsObj.get("stats").getAsJsonObject().get("top_heroes").getAsJsonObject().get("quickplay"), new TypeToken<List<Hero>>() {}.getType());
        //List<Hero> heroes = new Gson().fromJson(heroObj.get("heroes").getAsJsonObject().get("playtime").getAsJsonObject().get("quickplay"), new TypeToken<List<Hero>>() {}.getType());
        for(Hero h : heroes){
            h.updateHours(true, this);
            h.updateHeroClass();
        }
        //heroes.sort(new HeroPlayTimeComparator());
        return heroes;
    }

    public List<Hero> getTopCompHeroes(){
        List<Hero> heroes = new Gson().fromJson(statsObj.get("stats").getAsJsonObject().get("top_heroes").getAsJsonObject().get("competitive"), new TypeToken<List<Hero>>() {}.getType());
        for(Hero h : heroes){
            h.updateHours(false, this);
            h.updateHeroClass();
        }
        return heroes;
    }

    public List<Stat> getQuickCombatStats(){
        List<Stat> combatStat = new Gson().fromJson(statsObj.get("stats").getAsJsonObject().get("combat").getAsJsonObject().get("quickplay"), new TypeToken<List<Stat>>() {}.getType());
        return combatStat;
    }

    public List<Stat> getCompCombatStats(){
        return new Gson().fromJson(statsObj.get("stats").getAsJsonObject().get("combat").getAsJsonObject().get("competitive"), new TypeToken<List<Stat>>() {}.getType());
    }

    public List<Stat> getAverageQuickStats(){
        List<Stat> combatStat = new Gson().fromJson(statsObj.get("stats").getAsJsonObject().get("average").getAsJsonObject().get("quickplay"), new TypeToken<List<Stat>>() {}.getType());
        return combatStat;
    }

    public List<Stat> getAverageCompStats(){
        return new Gson().fromJson(statsObj.get("stats").getAsJsonObject().get("average").getAsJsonObject().get("competitive"), new TypeToken<List<Stat>>() {}.getType());
    }

    public List<Stat> getBestQuickStats(){
        List<Stat> combatStat = new Gson().fromJson(statsObj.get("stats").getAsJsonObject().get("best").getAsJsonObject().get("quickplay"), new TypeToken<List<Stat>>() {}.getType());
        return combatStat;
    }

    public List<Stat> getBestCompStats(){
        return new Gson().fromJson(statsObj.get("stats").getAsJsonObject().get("best").getAsJsonObject().get("competitive"), new TypeToken<List<Stat>>() {}.getType());
    }

    public List<Stat> getQuickStat(){
        return new Gson().fromJson(statsObj.get("stats").getAsJsonObject().get("game").getAsJsonObject().get("quickplay"), new TypeToken<List<Stat>>() {}.getType());
    }

    public List<Stat> getCompStat(){
        return new Gson().fromJson(statsObj.get("stats").getAsJsonObject().get("game").getAsJsonObject().get("competitive"), new TypeToken<List<Stat>>() {}.getType());
    }
}
