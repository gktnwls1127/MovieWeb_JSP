package controller;

import connector.ConnectionMaker;
import model.FilmDTO;
import model.ReviewDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ReviewController {

    private Connection connection;

    public ReviewController(ConnectionMaker connectionMaker){
        this.connection = connectionMaker.makeConnection();
    }

    public void insert(ReviewDTO reviewDTO){
        String query = "INSERT INTO `review`(`writer_id`, `film_id`, `score`, `review`) VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1,reviewDTO.getWriterId());
            pstmt.setInt(2, reviewDTO.getFilmId());
            pstmt.setInt(3, reviewDTO.getScore());
            pstmt.setString(4, reviewDTO.getReview());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<ReviewDTO> selectAll(int filmId){
        ArrayList<ReviewDTO> temp = new ArrayList<>();
        String query = "SELECT * FROM `review` WHERE `film_id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, filmId);

            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()){
                ReviewDTO reviewDTO = new ReviewDTO();
                reviewDTO.setId(resultSet.getInt("id"));
                reviewDTO.setWriterId(resultSet.getInt("writer_id"));
                reviewDTO.setFilmId(resultSet.getInt("film_id"));
                reviewDTO.setScore(resultSet.getInt("score"));
                reviewDTO.setReview(resultSet.getString("review"));

                temp.add(reviewDTO);
            }

            pstmt.close();
        } catch (SQLException e){
            e.printStackTrace();
        }

        return temp;
    }

    public ReviewDTO selectOne(int id){
        ReviewDTO reviewDTO = null;
        String query = "SELECT * FROM `review` WHERE `id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();

            if (resultSet.next()){
                reviewDTO = new ReviewDTO();
                reviewDTO.setId(resultSet.getInt("id"));
                reviewDTO.setWriterId(resultSet.getInt("writer_id"));
                reviewDTO.setFilmId(resultSet.getInt("film_id"));
                reviewDTO.setScore(resultSet.getInt("score"));
                reviewDTO.setReview(resultSet.getString("review"));
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviewDTO;
    }

    public void update(ReviewDTO reviewDTO){
        String query = "UPDATE `review` SET `score` = ?, `review` = ? WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, reviewDTO.getScore());
            pstmt.setString(2, reviewDTO.getReview());
            pstmt.setInt(3, reviewDTO.getId());

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id){
        String query = "DELETE FROM `review` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();

            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean validateReview(int filmId, int writerId){
        return selectOne(filmId, writerId) == null;
    }

    public ReviewDTO selectOne(int filmId, int writerId){
        for (ReviewDTO r : selectAll(filmId)){
            if (r.getWriterId() == writerId){
                return new ReviewDTO();
            }
        }
        return null;
    }

    public double calculateAverage(ArrayList<ReviewDTO> list){
        int sum = 0;
        for (ReviewDTO r : list){
            sum += r.getScore();
        }

        double result = (double) sum / list.size();
        return Math.round(result * 100) / 100.0;
    }


}
