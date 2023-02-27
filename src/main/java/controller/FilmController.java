package controller;

import connector.ConnectionMaker;
import model.FilmDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class FilmController {
    private Connection connection;

    private final int PAGE_SIZE = 8;

    public FilmController(ConnectionMaker connectionMaker){
        this.connection = connectionMaker.makeConnection();
    }

    public void insert(FilmDTO filmDTO){
        String query = "INSERT INTO `film`(`title`, `summary`, `rating`, `images`) VALUES (?, ?, ?,?)";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, filmDTO.getTitle());
            pstmt.setString(2, filmDTO.getSummary());
            pstmt.setString(3, filmDTO.getRating());
            pstmt.setString(4, filmDTO.getImages());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<FilmDTO> selectPageALl(int pageNo){
        ArrayList<FilmDTO> temp = new ArrayList<>();
        String query = "SELECT * FROM `film` ORDER BY `film`.`id` LIMIT ?, ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, (pageNo - 1) * PAGE_SIZE);
            pstmt.setInt(2, PAGE_SIZE);

            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()){
                FilmDTO filmDTO = new FilmDTO();
                filmDTO.setId(resultSet.getInt("id"));
                filmDTO.setTitle(resultSet.getString("title"));
                filmDTO.setSummary(resultSet.getString("summary"));
                filmDTO.setRating(resultSet.getString("rating"));
                filmDTO.setImages(resultSet.getString("images"));

                temp.add(filmDTO);
            }

            pstmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        }

        return temp;
    }

    public ArrayList<FilmDTO> selectAll(){
        ArrayList<FilmDTO> temp = new ArrayList<>();
        String query = "SELECT * FROM `film` ORDER BY `film`.`id`";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);

            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()){
                FilmDTO filmDTO = new FilmDTO();
                filmDTO.setId(resultSet.getInt("id"));
                filmDTO.setTitle(resultSet.getString("title"));
                filmDTO.setSummary(resultSet.getString("summary"));
                filmDTO.setRating(resultSet.getString("rating"));
                filmDTO.setImages(resultSet.getString("images"));

                temp.add(filmDTO);
            }

            pstmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        }

        return temp;
    }

    public FilmDTO selectOne(int id){
        FilmDTO filmDTO = null;
        String query = "SELECT * FROM `film` WHERE `id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();

            if (resultSet.next()){
                filmDTO = new FilmDTO();
                filmDTO.setId(resultSet.getInt("id"));
                filmDTO.setTitle(resultSet.getString("title"));
                filmDTO.setSummary(resultSet.getString("summary"));
                filmDTO.setRating(resultSet.getString("rating"));
                filmDTO.setImages(resultSet.getString("images"));
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return filmDTO;
    }

    public void update(FilmDTO filmDTO){
        String query = "UPDATE `film` SET `title` = ?, `summary` = ? , `rating` = ?, images = ? WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, filmDTO.getTitle());
            pstmt.setString(2, filmDTO.getSummary());
            pstmt.setString(3, filmDTO.getRating());
            pstmt.setString(4, filmDTO.getImages());
            pstmt.setInt(5, filmDTO.getId());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id){
        String query = "DELETE FROM `film` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<FilmDTO> search(String title){
        ArrayList<FilmDTO> temp = new ArrayList<>();
        String query = "SELECT * FROM `film` WHERE `title` LIKE ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, "%"+title+"%");

            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()){
                FilmDTO filmDTO = new FilmDTO();
                filmDTO.setId(resultSet.getInt("id"));
                filmDTO.setTitle(resultSet.getString("title"));
                filmDTO.setSummary(resultSet.getString("summary"));
                filmDTO.setRating(resultSet.getString("rating"));
                filmDTO.setImages(resultSet.getString("images"));

                temp.add(filmDTO);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return temp;
    }

    public int countTotalPage() {
        int totalPage = 0;
        String query = "SELECT COUNT(*) FROM `film`";
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
