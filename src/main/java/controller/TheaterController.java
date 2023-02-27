package controller;

import connector.ConnectionMaker;
import model.TheaterDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TheaterController {
    private Connection connection;
    public TheaterController(ConnectionMaker connectionMaker){
        this.connection = connectionMaker.makeConnection();
    }

    public void insert(TheaterDTO theaterDTO){
        String query = "INSERT INTO `theater` (`theaterName`, `theaterPlace`, `theaterNumber`) VALUES (?, ?, ?)";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, theaterDTO.getTheaterName());
            pstmt.setString(2, theaterDTO.getTheaterPlace());
            pstmt.setString(3, theaterDTO.getTheaterNumber());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public TheaterDTO selectOne(int id){
        TheaterDTO theaterDTO = null;
        String query = "SELECT * FROM `theater` WHERE `id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();

            if (resultSet.next()){
                theaterDTO = new TheaterDTO();
                theaterDTO.setId(resultSet.getInt("id"));
                theaterDTO.setTheaterName(resultSet.getString("theaterName"));
                theaterDTO.setTheaterPlace(resultSet.getString("theaterPlace"));
                theaterDTO.setTheaterNumber(resultSet.getString("theaterNumber"));
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return theaterDTO;
    }

    public ArrayList<TheaterDTO> selectAll(){
        ArrayList<TheaterDTO> list = new ArrayList<>();

        String query = "SELECT * FROM `theater` ORDER BY `theater`.`id`";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()){
                TheaterDTO theaterDTO = new TheaterDTO();
                theaterDTO.setId(resultSet.getInt("id"));
                theaterDTO.setTheaterName(resultSet.getString("theaterName"));
                theaterDTO.setTheaterPlace(resultSet.getString("theaterPlace"));
                theaterDTO.setTheaterNumber(resultSet.getString("theaterNumber"));

                list.add(theaterDTO);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public void update(TheaterDTO theaterDTO){
        String query = "UPDATE `theater` SET `theaterName` = ?, `theaterPlace` = ? , `theaterNumver` = ? WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, theaterDTO.getTheaterName());
            pstmt.setString(2, theaterDTO.getTheaterPlace());
            pstmt.setString(3, theaterDTO.getTheaterNumber());
            pstmt.setInt(4, theaterDTO.getId());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id){
        String query = "DELETE FROM `theater` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


}
