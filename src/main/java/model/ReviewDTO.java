package model;

import lombok.Data;

@Data
public class ReviewDTO {
    private int id;
    private int writerId;
    private int filmId;
    private int score;
    private String review;

}
