package com.example.test11_admin_jenkins;

import de.codecentric.boot.admin.server.config.EnableAdminServer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@EnableAdminServer
@SpringBootApplication
@Slf4j
public class Test11AdminApplication {

    public static void main(String[] args) {

        System.out.println("start app");
        log.info("----------- start app ----------");

        SpringApplication.run(Test11AdminApplication.class, args);

        System.out.println("start app");
        log.info("----------- start app ----------");
    }

}
