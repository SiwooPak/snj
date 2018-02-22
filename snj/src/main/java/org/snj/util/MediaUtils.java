package org.snj.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;
//업로드 파일이 이미지 인지 아닌지 이미지도 JPEG,GIF,PNG만 구분하게 했음.
public class MediaUtils {
	private static Map<String, MediaType> mediaMap;
	
	static {
		mediaMap = new HashMap<String, MediaType>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}
	
	public static MediaType getMediaType(String type) {
		return mediaMap.get(type.toUpperCase());
	}
}
