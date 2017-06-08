package com.overwatch;

import com.sun.javaws.exceptions.InvalidArgumentException;

import java.util.Comparator;

/**
 * Class to contain all Overwatch Hero information
 */
public class Hero {
    private String hero;
    private String played;
    private String img;
    private double hours;
    private String heroClass;

    public String getHero() {
        return hero;
    }

    public String getPlayed() {
        return played;
    }

    public String getImg() {
        return img;
    }

    public double getHours(){
        return hours;
    }

    public String getHeroClass(){
        return heroClass;
    }

    public static double getMostQuickHours(Overwatch player){
        return player.getMostQuickHours();
    }

    public static double getMostCompHours(Overwatch player){
        return player.getMostCompHours();
    }

    public void setHero(String hero) {
        this.hero = hero.replace("\"", "");
    }

    public void setPlayed(String played) {
        this.played = played.replace("\"", "");
    }

    public void setImg(String img) {
        this.img = img.replace("\"", "");
    }

    public void setHeroClass(String heroClass){
        this.heroClass = heroClass;
    }

    public void setMostQuickHours(double hours, Overwatch player){
        player.setMostQuickHours(hours);
    }

    public void setMostCompHours(double hours, Overwatch player){
        player.setMostCompHours(hours);

    }

    public void updateHours(Boolean quick, Overwatch player){
        try{
            if(this.played.contains("minutes")){
                double toHours = Double.parseDouble(this.played.split(" ")[0]);
                this.hours = toHours/60;
            } else if (this.played.contains("seconds")) {
                double toHours = Double.parseDouble(this.played.split(" ")[0]);
                this.hours = toHours/3600;
            } else {
                this.hours = Double.parseDouble(this.played.split(" ")[0]);
            }
            if(quick){
                if(this.hours > getMostQuickHours(player)){
                    setMostQuickHours(this.hours, player);
                }
            } else {
                if(this.hours > getMostCompHours(player)){
                    setMostCompHours(this.hours, player);
                }
            }

        } catch (NumberFormatException ex){
            this.hours = 0;
        }

    }

    public void updateHeroClass(){
        switch (this.hero){
            case "LÃºcio":
                this.hero = "Lucio";
                break;
            case "TorbjÃ¶rn":
                this.hero = "Torbjorn";
                break;
        }
        String updated = this.hero.replace(".", "");
        updated = updated.replace(" ", "");
        updated = updated.replace(":", "");
        this.heroClass = updated;
    }
}

class HeroPlayTimeComparator implements Comparator<Hero> {
    public int compare(Hero h1, Hero h2) {
        return Double.compare(h1.getHours(), h2.getHours());
    }
}
