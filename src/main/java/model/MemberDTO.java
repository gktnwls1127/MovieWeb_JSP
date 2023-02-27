package model;

import lombok.Data;

@Data
public class MemberDTO {
    private int id;
    private String username;
    private String password;
    private String nickname;
    private int level;
    private int upgradeLevel;

}
