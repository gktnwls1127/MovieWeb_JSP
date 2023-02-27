package model;

import lombok.Data;

@Data
public class FilmDTO {
    private int id;
    private String title;
    private String summary;
    private String rating;
    private String images;

}
