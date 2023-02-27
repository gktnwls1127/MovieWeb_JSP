package controller;

import connector.ConnectionMaker;
import model.FilmDTO;
import model.MemberDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberController {

    private Connection connection;
    public MemberController(ConnectionMaker connectionMaker){
        this.connection = connectionMaker.makeConnection();
    }

    public boolean insert(MemberDTO memberDTO){
        String query = "INSERT INTO `member`(`username`, `password`, `nickname`) VALUES (?, ?, ?)";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, memberDTO.getUsername());
            pstmt.setString(2, memberDTO.getPassword());
            pstmt.setString(3, memberDTO.getNickname());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public MemberDTO auth(String username, String password){
        String query = "SELECT * FROM `member` WHERE `username` =? AND `password` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            ResultSet resultSet = pstmt.executeQuery();

            if (resultSet.next()){
                MemberDTO memberDTO = new MemberDTO();
                memberDTO.setId(resultSet.getInt("id"));
                memberDTO.setUsername(resultSet.getString("username"));
                memberDTO.setNickname(resultSet.getString("nickname"));
                memberDTO.setLevel(resultSet.getInt("level"));
                memberDTO.setUpgradeLevel(resultSet.getInt("upgradeLevel"));

                return memberDTO;
            }

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public void update(MemberDTO memberDTO){
        String query = "UPDATE `member` SET `password` = ?, `nickname` = ? WHERE `id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, memberDTO.getPassword());
            pstmt.setString(2, memberDTO.getNickname());
            pstmt.setInt(3, memberDTO.getId());

            pstmt.executeUpdate();

            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id){
        String query = "DELETE FROM `member` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();

            pstmt.close();

        } catch (SQLException e){
            e.printStackTrace();
        }
    }

    public ArrayList<MemberDTO> selectAll(){
        ArrayList<MemberDTO> temp = new ArrayList<>();
        String query = "SELECT * FROM `member` ORDER BY `member`.`id`";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);

            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()){
                MemberDTO memberDTO = new MemberDTO();
                memberDTO.setId(resultSet.getInt("id"));
                memberDTO.setUsername(resultSet.getString("username"));
                memberDTO.setNickname(resultSet.getString("nickname"));
                memberDTO.setLevel(resultSet.getInt("level"));
                memberDTO.setUpgradeLevel(resultSet.getInt("upgradeLevel"));

                temp.add(memberDTO);
            }

            pstmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        }

        return temp;
    }

    public MemberDTO selectOne(int id){
        MemberDTO memberDTO = null;
        String query = "SELECT * FROM `member` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()){
                memberDTO = new MemberDTO();
                memberDTO.setId(resultSet.getInt("id"));
                memberDTO.setUsername(resultSet.getString("username"));
                memberDTO.setNickname(resultSet.getString("nickname"));
                memberDTO.setLevel(resultSet.getInt("level"));
                memberDTO.setUpgradeLevel(resultSet.getInt("upgradeLevel"));

            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return memberDTO;
    }

    public ArrayList<MemberDTO> selectUpgrade(){
        ArrayList<MemberDTO> temp = new ArrayList<>();
        String query = "SELECT * FROM `member` WHERE `upgradeLevel` IS NOT NULL";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);

            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()){
                MemberDTO memberDTO = new MemberDTO();
                memberDTO.setId(resultSet.getInt("id"));
                memberDTO.setUsername(resultSet.getString("username"));
                memberDTO.setNickname(resultSet.getString("nickname"));
                memberDTO.setLevel(resultSet.getInt("level"));
                memberDTO.setUpgradeLevel(resultSet.getInt("upgradeLevel"));

                temp.add(memberDTO);
            }

            pstmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        }

        return temp;
    }

    public void rankUp(MemberDTO memberDTO) {
        String query = "UPDATE `member` SET `level` = ? WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, memberDTO.getUpgradeLevel());
            pstmt.setInt(2, memberDTO.getId());

            pstmt.executeUpdate();

            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
