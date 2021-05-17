package com.ncncn.task;

import com.ncncn.domain.BarcodeInfoVO;
import com.ncncn.mapper.GifticonMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

@Log4j
@Component
public class FileCheckTask {


    @Setter(onMethod_ = {@Autowired})
    private GifticonMapper gifticonMapper;

    private String getFolderYesterDay() {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Calendar cal = Calendar.getInstance();

        cal.add(Calendar.DATE, -1);

        String str = sdf.format(cal.getTime());

        return str.replace("-", File.separator);
    }

    // 매일 0시 1분에 DB에 없는 바코드이미지 삭제
    @Scheduled(cron = "0 1 0 * * ?")
    public void checkFiles() {

        log.warn("File Check Task run......................");

        try {
            // 어제 등록된 기프티콘 이미지 목록
            List<BarcodeInfoVO> fileList = gifticonMapper.getYesterdayBarcodeImageInfo();
            List<Path> fileListPaths = fileList.stream().
                    map(vo -> Paths.get("/Users/asdddq/upload/barcode",
                            vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName())).collect(Collectors.toList());


            // thumbnail
            fileList.stream()
                    .map(vo -> Paths.get("/Users/asdddq/upload/barcode",
                            vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName())).collect(Collectors.toList());

            log.warn("===========================================================");

            fileListPaths.forEach(p -> log.warn(p));

            //  files in yesterday directory
            File targetDir = Paths.get("/Users/asdddq/upload/barcode",
                    getFolderYesterDay()).toFile();

            File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);

            log.warn("---------------------------------------------------");

            // 업로드된 바코드 이미지 파일 중 DB에 없는 것들 삭제
            for (File file : removeFiles) {
                log.warn(file.getAbsolutePath());
                file.delete();
            }
        } catch (Exception e) {
            e.printStackTrace();
            log.warn("잉여 이미지파일 삭제 과정에서 오류가 발생했습니다. 이미지파일 목록을 확인해주세요.");
        }
    }
}
