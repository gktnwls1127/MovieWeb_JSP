package model;

import lombok.Data;

@Data
public class OnBoardDTO {
    private int id;
    private int filmId;
    private int theaterId;
    private String runningTime;

}
