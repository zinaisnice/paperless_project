package com.example.paperless;

public interface NoticeService {
		
	/* noticeDetail.do / noticeUp.do */
	// [1개 공지사항 글] 을 리턴하는 메소드 선언
	NoticeDTO getNotice(int n_no, boolean isNoticeDetailForm);
	
	/* noticeUpProc.do */
	// [1개 공지사항] 를 수정 실행하고 수정 적용행의 개수를 리턴하는 메소드 선언
	int updateNotice(NoticeDTO noticeDTO);
	
	/* noticeDelProc */
	// [1개 공지사항] 를 삭제 실행하고 삭제 적용행의 개수를 리턴하는 메소드 선언
	int deleteNotice(NoticeDTO noticeDTO);	
	
	
}
