package com.example.paperless;

import java.util.List;
import java.util.Map;

public interface NoticeDAO {
	/* noticeList.do */
	// [검색한 공지사항 목록]을 리턴하는 메소드 선언
	List<Map<String,String>> getNoticeList(NoticeSearchDTO noticeSearchDTO);
	
	// [공지사항 목록]의 총 개수를 리턴하는 메소드 선언
	int getNoticeListAllTotCnt(NoticeSearchDTO noticeSearchDTO);
	
	// [검색한 공지사항 목록]의 총 개수를 리턴하는 메소드 선언
	int getNoticeListTotCnt(NoticeSearchDTO noticeSearchDTO);
	
	
	
	/* noticeRegProc.do */
	// [공지사항 입력 후 입력 적용 행의 개수]를 리턴하는 메소드 선언
	int insertNotice(NoticeDTO noticeDTO);
	
	
	
	
	/* noticeDetail.do */
	// 조회수를 1 증가하고 업데이트한 행의 개수를 얻는 메소드 선언
	int updateReadcount(int n_no);
	
	// [1개의 공지사항 정보]를 리턴하는 메소드 선언
	NoticeDTO getNotice(int n_no);
	
	// 해당 공지사항의 이전 공지사항
	NoticeDTO getBeforeNotice(int n_no);
	
	// 해당 공지사항의 다음 공지사항
	NoticeDTO getAfterNotice(int n_no);
	
	
	
	/* noticeUpProc.do */
	// [수정/삭제할 공지사항의 존재 개수]를 리턴하는 메소드 선언
	int getNoticeCnt(int n_no);
	
	// [수정 적용행의 개수]를 리턴하는 메소드 선언
	int updateNotice(NoticeDTO noticeDTO);
	
	
	
	/* noticeDelProc */
	// [삭제 적용행의 개수]를 리턴하는 메소드 선언
	int deleteNotice(int n_no);	
	
	
	
		
	
	// [공지사항 글] 내용을 비우는 업데이트를 하는 메소드 선언
	// int updateNoticeEmpty (NoticeDTO noticeDTO);
}
