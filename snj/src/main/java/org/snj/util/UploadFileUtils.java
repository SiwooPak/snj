package org.snj.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;
//업로드파일 클래스
public class UploadFileUtils {
	// 로그 기록 변수.
	private static final Logger logger =
			LoggerFactory.getLogger(UploadFileUtils.class);
	
	//파일의 경로, 이름, 데이터를 받는 함수.
	public static String uploadFile(String uploadPath, String originalName,
									byte[] fileData) throws Exception{
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() + "_" + originalName;
		String savedPath = calcPath(uploadPath);
		File target = new File(uploadPath+savedPath, savedName);
		FileCopyUtils.copy(fileData, target);
		
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		String uploadedFileName = null;
		
		if(MediaUtils.getMediaType(formatName) != null) {
			uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName);
		}else {
			uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		
		return uploadedFileName;
	}
	
	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception {
		String iconName = uploadPath + path + File.separator + fileName;
		
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}

	//년월일 경로생성.
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1); 
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		makeDir(uploadPath, yearPath, monthPath, datePath);
		logger.info(datePath);
		return datePath;
	}
	
	//년월일 경로를 받아서 폴더 생성.
	private static void makeDir(String uploadPath, String... paths ) {
		if(new File(uploadPath+paths[paths.length-1]).exists())
			return;
		for(String path : paths) {
			File dirPath = new File(uploadPath + path);
			if(! dirPath.exists()) {
				dirPath.mkdirs();
			}
		}
	}
	
	//썸네일 생성 함수.
	private static String makeThumbnail(String uploadPath, String path,
										String fileName) throws Exception {
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath+path,fileName));
		// 썸네일 이미지의 너비와 높이.
		int dw = 240, dh = 225; 
		// 원본 이미지의 너비와 높이 입니다. 
		int ow = sourceImg.getWidth(); 
		int oh = sourceImg.getHeight(); 
		// 원본 너비를 기준으로 하여 썸네일의 비율로 높이를 계산합니다. 
		int nw = ow; 
		int nh = (ow * dh) / dw;
		// 계산된 높이가 원본보다 높다면 crop이 안되므로
		// 원본 높이를 기준으로 썸네일의 비율로 너비 계산.
		if(nh > oh) { 
			nw = (oh * dw) / dh; nh = oh; 
		}
		
		BufferedImage cropImg = Scalr.crop(sourceImg, (ow-nw)/2, (oh-nh)/2, nw, nh);
		BufferedImage destImg = Scalr.resize(cropImg, dw, dh);
		String thumbnailName =
				uploadPath + path + File.separator + "s_" + fileName;
		File newFile = new File(thumbnailName);
		String formatName =
				fileName.substring(fileName.lastIndexOf(".")+1);
		
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
}
