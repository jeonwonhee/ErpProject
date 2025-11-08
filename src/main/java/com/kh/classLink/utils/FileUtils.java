package com.kh.classLink.utils;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class FileUtils {

    private FileUtils() {

    }


    public static String saveFile(MultipartFile file, String path) {
        String originalName = file.getOriginalFilename();
        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        int randomNumber = (int)(Math.random() * 90000) + 10000;

        String ext = originalName.substring(originalName.lastIndexOf("."));

        String changeName = currentTime + randomNumber + ext;
        System.out.println("-------------------------");
        System.out.println(changeName);
        System.out.println(path);
        try {
            file.transferTo(new File(path + changeName));
        } catch (Exception e) {
            e.printStackTrace();
        }

        return changeName;

    }


    /**
     * 파일 복제
     * @param path
     * @param originalFileName
     * @return
     */
    public static String copyFile(String path, String originalFileName) {
        String ext = originalFileName.substring(originalFileName.lastIndexOf("."));
        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        int randomNumber = (int) (Math.random() * 90000) + 10000;
        String newFileName = currentTime + randomNumber + ext;

        File source = new File(path + originalFileName);
        File dest = new File(path + newFileName);

        try (FileInputStream fis = new FileInputStream(source);
             FileOutputStream fos = new FileOutputStream(dest)) {

            byte[] buffer = new byte[1024];
            int length;
            while ((length = fis.read(buffer)) > 0) {
                fos.write(buffer, 0, length);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return newFileName;
    }


}
