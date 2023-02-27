package connector;

import java.sql.Connection;
// Connection 자바가 제공하는 데이터베이스와 연결하는 통신을 객체화한 것

// 컴퓨터와 데이터베이스의 연결 담당 메소드 모음
public interface ConnectionMaker {
    public Connection makeConnection();
}
