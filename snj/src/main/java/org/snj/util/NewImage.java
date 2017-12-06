package org.snj.util;

import java.text.SimpleDateFormat;
import java.util.*;

public class NewImage {
	/**
     * 오늘,어제,그제 날짜 가져오기
     * @return List- 날짜들 저장
     * 새로운 글인 경우 제목 옆에 new 이미지 삽입.
     */
    public static List<String> getDay(){
    	// List에 넣을 제너릭 타입을 String으로 선언해서 객체 생성해줌
        List<String> list = new ArrayList<String>();
        
        // SimpleDateFormat객체를 만들면서 생성자 매개변수로 yyy-MM-dd를 넘겨줌
        SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
        
        Calendar cal = Calendar.getInstance(); // Calendar.getInstance()호출해서 객체생성
        for(int j = 0; j < 3; j++){ // 3번돌림
            list.add(sd.format(cal.getTime())); // list에 저장할건데 sd객체에 있는 format메소드에서 Calendar객체에 있는 getTime()메소드를 호출해서 저장 현재getTime은 오늘날짜임
            cal.add(Calendar.DATE, -1); //cal객체에 오늘날짜에서 -1에서 넣어줌(어제) 그래서 for문을 3번 돌면서 list에 오늘,어제,그제 날짜를 넣을수있음
        }
        
        return list; //getDay()메소드를 호출한 곳으로 리턴
    }
    /**
     * 등록날짜와 오늘,어제,그제날짜와 비교
     * @param regdate - 등록날짜
     * @return - true:오늘,어제,그제중 등록날짜와 같음
     *           false:오늘,어제,그제 날짜가 등록날짜와 다 다름
     */
    public static boolean compareDay(String regdate){
        boolean flag = false;
        // list에다가 getDay()메소드를 집어넣음(list로 리턴된 값이 같이 들어감) 
        List<String> list = getDay(); // getDay()호출
       
        if(regdate.equals(list.get(0))	  // regdate와 list에있는 0번째 인덱스에있는 값이 같냐 아니면(||)
           || regdate.equals(list.get(1))   //  1번째 인덱스와 같냐? 아니면(||)
           || regdate.equals(list.get(2))){ //  2번째 인덱스라도 같으면 flag 에 true를 담음
            flag = true;        		  // 0,1,2번째 인덱스중에 regdate와 같은 값이 1개라도 같으면 flag는 true가됨
        }
          
        return flag; // compareDay()메소드를 호출한 곳으로 리턴
    }
}
