package com.airbnb3.codesquad.airbnb3.config.jwt;

import io.jsonwebtoken.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;
import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticOAuthHamill.EXPIRE_TIME;


@Service
public class JwtService {

    private Logger logger = LoggerFactory.getLogger(JwtService.class);

    private String secretKey = "ThisIsAirbnb03SecretKey";
    private byte[] apiKeySecretBytes = DatatypeConverter.parseBase64Binary(secretKey);
    private SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;
    private final Key KEY = new SecretKeySpec(apiKeySecretBytes, signatureAlgorithm.getJcaName());


    public String makeJwt(String nickname, String name, String email) throws Exception {
        Date expireTime = new Date();
        expireTime.setTime(expireTime.getTime() + EXPIRE_TIME);

        Map<String, Object> headerMap = new HashMap<>();

        headerMap.put("typ","JWT");
        headerMap.put("alg","HS256");

        Map<String, Object> map= new HashMap<>();

        map.put("nickname", nickname);
        map.put("name", name);
        map.put("email", email);

        JwtBuilder builder = Jwts.builder().setHeader(headerMap)
                                 .setClaims(map)
                                 .setExpiration(expireTime)
                                 .signWith(signatureAlgorithm, KEY);

        return builder.compact();
    }

    public boolean checkJwt(String jwt) throws Exception {
        try {
            Claims claims = Jwts.parser().setSigningKey(DatatypeConverter.parseBase64Binary(secretKey))
                                .parseClaimsJws(jwt).getBody(); // 정상 수행된다면 해당 토큰은 정상토큰

            logger.info("expireTime :" + claims.getExpiration());
            logger.info("nickname :" + claims.get("nickname"));
            logger.info("name :" + claims.get("name"));
            logger.info("email :" + claims.get("email"));

            return true;
        } catch (ExpiredJwtException exception) {
            logger.info("토큰 만료");
            return false;
        } catch (JwtException exception) {
            logger.info("토큰 변조");
            return false;
        }
    }

    public Object getUserEmail(String jwt) throws RuntimeException {
        try {
            Claims claims = Jwts.parser().setSigningKey(DatatypeConverter.parseBase64Binary(secretKey))
                                .parseClaimsJws(jwt).getBody();
            return claims.get("email");
        } catch (Exception e) {
            return null;
        }
    }

    public Object getUserName(String jwt) throws RuntimeException {
        try {
            Claims claims = Jwts.parser().setSigningKey(DatatypeConverter.parseBase64Binary(secretKey))
                                .parseClaimsJws(jwt).getBody();
            return claims.get("name");
        } catch (Exception e) {
            return null;
        }
    }

    public Object getUserNickname(String jwt) throws RuntimeException {
        try {
            Claims claims = Jwts.parser().setSigningKey(DatatypeConverter.parseBase64Binary(secretKey))
                                .parseClaimsJws(jwt).getBody();
            return claims.get("nickname");
        } catch (Exception e) {
            return null;
        }
    }
}
