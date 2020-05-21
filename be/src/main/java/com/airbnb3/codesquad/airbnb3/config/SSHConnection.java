package com.airbnb3.codesquad.airbnb3.config;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

import java.util.Properties;

public class SSHConnection {
//    // SSH 연결을 할 IP주소 (EC2 주소)
//    private final static String HOST = "3.34.93.158";
//    // SSH 연결에 필요한 포트 번호 (DEFAULT = 22)
//    private final static Integer PORT = 22;
//    // SSH 연결에 필요한 USER_ID (KeyPair 접속 방법이 아닌, USER ID,PW 접속 방법으로 접속하여야 한다.)
//    private final static String SSH_USER = "airbnb";
//    // SSH 연결에 필요한 USER_PW
//    private final static String SSH_PW = "12341234";
//
//    private Session session;
//
//    public void closeSSH() {
//        session.disconnect();
//    }
//
//    public SSHConnection() {
//        try {
//            Properties config = new Properties();
//            config.put("StrictHostKeyChecking","no");
//            JSch jSch = new JSch();
//            session = jSch.getSession(SSH_USER,HOST,PORT);
//            session.setPassword(SSH_PW);
//            session.setConfig(config);
//            session.connect();
//            // 127.0.0.1/3316 으로 접근한 포트를 연결 HOST/3306으로 포워딩
//            session.setPortForwardingL(3316,"3.34.93.158",3306);
//        } catch (JSchException e) {
//            e.printStackTrace();
//        }
//    }
}
