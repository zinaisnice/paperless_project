package com.example.paperless;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDAO noticeDAO;
	
	public NoticeDTO getNotice(int n_no, boolean isNoticeDetailForm) {
		
		if(isNoticeDetailForm) { /* noticeDetail.do */
			int updateCount = this.noticeDAO.updateReadcount(n_no);
			if(updateCount == 0) return null;
		}
		
		/* noticeDetail.do / noticeUp.do */
		NoticeDTO notice = this.noticeDAO.getNotice(n_no);
		
		return notice;
	}
	
	
	
	/* noticeUpProc.do */
	// [1개 공지사항] 를 수정 실행하고 수정 적용행의 개수를 리턴하는 메소드 선언
	public int updateNotice(NoticeDTO noticeDTO) {
		int noticeCnt = this.noticeDAO.getNoticeCnt(noticeDTO.getN_no());
		if(noticeCnt == 0)  return 0; 

		int updateNoticeCnt = this.noticeDAO.updateNotice(noticeDTO);
		return updateNoticeCnt;
		
	}
	
	
	/* noticeDelProc */
	// [1개 공지사항] 를 삭제 실행하고 삭제 적용행의 개수를 리턴하는 메소드 선언
	public int deleteNotice(NoticeDTO noticeDTO) {
		int noticeCnt = this.noticeDAO.getNoticeCnt(noticeDTO.getN_no());
		if(noticeCnt == 0) return 0;

		int deleteNoticeCnt = this.noticeDAO.deleteNotice(noticeDTO.getN_no());
		return deleteNoticeCnt;
	}

	
	
	
}
