package controller;

import connector.ConnectionMaker;
import model.OnBoardDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class OnBoardController {
    private Connection connection;

    private final int PAGE_SIZE = 6;

    public OnBoardController(ConnectionMaker connectionMaker) {
        this.connection = connectionMaker.makeConnection();
    }

    public void insert(OnBoardDTO onBoardDTO) {
        String query = "INSERT INTO `onboard` (`film_id`, `theater_id`, `runningTime`) VALUES (?, ?, ?)";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, onBoardDTO.getFilmId());
            pstmt.setInt(2, onBoardDTO.getTheaterId());
            pstmt.setString(3, onBoardDTO.getRunningTime());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public OnBoardDTO selectOne(int id) {
        OnBoardDTO onBoardDTO = null;
        String query = "SELECT * FROM `onboard` WHERE `id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();

            if (resultSet.next()){
                onBoardDTO = new OnBoardDTO();
                onBoardDTO.setId(resultSet.getInt("id"));
                onBoardDTO.setFilmId(resultSet.getInt("film_id"));
                onBoardDTO.setTheaterId(resultSet.getInt("theater_id"));
                onBoardDTO.setRunningTime(resultSet.getString("runningTime"));
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return onBoardDTO;
    }

    public ArrayList<OnBoardDTO> selectTheaterAll(int theaterId) {
        ArrayList<OnBoardDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `onboard` WHERE `theater_id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, theaterId);

            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()){
                OnBoardDTO onBoardDTO = new OnBoardDTO();
                onBoardDTO.setId(resultSet.getInt("id"));
                onBoardDTO.setFilmId(resultSet.getInt("film_id"));
                onBoardDTO.setTheaterId(resultSet.getInt("theater_id"));
                onBoardDTO.setRunningTime(resultSet.getString("runningTime"));

                list.add(onBoardDTO);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public ArrayList<OnBoardDTO> selectFilmAll(int filmId) {
        ArrayList<OnBoardDTO> filmList = new ArrayList<>();

        String query = "SELECT * FROM `onboard` WHERE `film_id` = ? ORDER BY `theater_id`";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, filmId);

            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()){
                OnBoardDTO on = new OnBoardDTO();
                on.setId(resultSet.getInt("id"));
                on.setFilmId(resultSet.getInt("film_id"));
                on.setTheaterId(resultSet.getInt("theater_id"));
                on.setRunningTime(resultSet.getString("runningTime"));

                filmList.add(on);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        }
        return filmList;

    }

    public ArrayList<OnBoardDTO> selectAll(int pageNo) {
        ArrayList<OnBoardDTO> list = new ArrayList<>();

        String query = "SELECT DISTINCT(`film_id`) FROM `onboard` LIMIT ?, ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, (pageNo - 1) * PAGE_SIZE);
            pstmt.setInt(2, PAGE_SIZE);

            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()){
                OnBoardDTO onBoardDTO = new OnBoardDTO();
                onBoardDTO.setFilmId(resultSet.getInt("film_id"));

                list.add(onBoardDTO);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }


    public void update(OnBoardDTO onBoardDTO) {
        String query = "UPDATE `onboard` SET `film_id` = ?, `theater_id` = ? , `runningTime` = ? WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, onBoardDTO.getFilmId());
            pstmt.setInt(2, onBoardDTO.getTheaterId());
            pstmt.setString(3, onBoardDTO.getRunningTime());
            pstmt.setInt(4, onBoardDTO.getId());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "DELETE FROM `onboard` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int countTotalPage() {
        int totalPage = 0;
        String query = "SELECT COUNT(DISTINCT(`film_id`)) FROM `onboard`";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();
            int count = 0;
            if (resultSet.next()) {
                count = resultSet.getInt(1);
            }

            totalPage = count / PAGE_SIZE;
            if (count % PAGE_SIZE != 0) {
                totalPage++;
            }

            pstmt.close();
            resultSet.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalPage;
    }


}
