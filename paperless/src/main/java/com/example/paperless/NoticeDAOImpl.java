package com.example.paperless;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAOImpl implements NoticeDAO{
	
	// SqlSessionTemplate 객체의 기능
	// DB 연동 시 사용한다. 메소드를 통해 xml 파일에 있는 SQL 구문을 읽어서 결과값을 받아오는 객체이다.
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// [검색한 공지사항 목록]을 리턴하는 메소드 선언
	public List<Map<String,String>> getNoticeList(NoticeSearchDTO noticeSearchDTO) {
		
		List<Map<String,String>> noticeList = this.sqlSession.selectList(
			"com.example.paperless.NoticeDAO.getNoticeList"
			, noticeSearchDTO
		);
		return noticeList;
	}

	// [공지사항 목록]의 총 개수를 리턴하는 메소드 선언
	public int getNoticeListAllTotCnt(NoticeSearchDTO noticeSearchDTO) {
		int noticeListAllTotCnt = this.sqlSession.selectOne(
			"com.example.paperless.NoticeDAO.getNoticeListAllTotCnt"
			, noticeSearchDTO
		);
		return noticeListAllTotCnt;
	}
	
	// [검색한 공지사항 목록]의 총 개수를 리턴하는 메소드 선언
	public int getNoticeListTotCnt(NoticeSearchDTO noticeSearchDTO) {
		int noticeListTotCnt = this.sqlSession.selectOne(
			"com.example.paperless.NoticeDAO.getNoticeListTotCnt"
			, noticeSearchDTO
		);
		return noticeListTotCnt;
	}
	
	
	
	
	
	/* noticeRegProc.do */
	// [공지사항 입력 후 입력 적용 행의 개수]를 리턴하는 메소드 선언
	public int insertNotice(NoticeDTO noticeDTO) {
		int noticeRegCnt = sqlSession.insert(
			"com.example.paperless.NoticeDAO.insertNotice"
			, noticeDTO
		);
		
		return noticeRegCnt;
	}
	
	
	
	
	
	

	

	/* noticeDetail.do */
	// 공지사항 조회수를 1 증가하고 업데이트한 행의 개수를 얻는 메소드 선언
	public int updateReadcount(int n_no) {
		int updateCount = this.sqlSession.update(
			"com.example.paperless.NoticeDAO.updateReadcount"
			, n_no
		);
		return updateCount;
	}
	
	// [1개의 공지사항 정보]를 리턴하는 메소드 선언
	public NoticeDTO getNotice(int n_no) {
		NoticeDTO notice = this.sqlSession.selectOne(
			"com.example.paperless.NoticeDAO.getNotice"
			, n_no
		);
		return notice;
	}
	
	// 해당 공지사항의 이전 공지사항
	public NoticeDTO getBeforeNotice(int n_no) {
		NoticeDTO beforeNotice = this.sqlSession.selectOne(
			"com.example.paperless.NoticeDAO.getBeforeNotice"
			, n_no
		);
		return beforeNotice;
	}
	
	// 해당 공지사항의 다음 공지사항
	public NoticeDTO getAfterNotice(int n_no) {
		NoticeDTO afterNotice = this.sqlSession.selectOne(
			"com.example.paperless.NoticeDAO.getAfterNotice"
			, n_no
		);
		return afterNotice;
	}
	
	/* noticeUpProc.do */
	// [수정/삭제할 공지사항의 존재 개수]를 리턴하는 메소드 선언
	public int getNoticeCnt(int n_no) {
		
		int noticeCnt = this.sqlSession.selectOne(
			"com.example.paperless.NoticeDAO.getNoticeCnt"
			, n_no
		);
		return noticeCnt;
	}
	
	// [수정 적용행의 개수]를 리턴하는 메소드 선언
	public int updateNotice(NoticeDTO noticeDTO) {
		int updateNoticeCnt = this.sqlSession.update(
			"com.example.paperless.NoticeDAO.updateNotice"
			, noticeDTO
		);
		return updateNoticeCnt;
	}
	
	
	
	/* noticeDelProc */
	// [삭제 적용행의 개수]를 리턴하는 메소드 선언
	public int deleteNotice(int n_no) {
		int deleteNoticeCnt = this.sqlSession.delete(
			"com.example.paperless.NoticeDAO.deleteNotice"
			, n_no
		);
		return deleteNoticeCnt;
	}
	
	
	
	

	
	
	// ============================
	// [공지사항 글] 내용을 비우는 업데이트를 하는 메소드 선언
	// ============================	
//		 public int updateNoticeEmpty (NoticeDTO noticeDTO) {
//			//-------------------------------------------------------
//				// [SqlSessionTemplate 객체]의 update(~,~) 를 호출하여 [조회수 증가]하기
//				//-------------------------------------------------------
//				int updateCount = this.sqlSession.update(
//						"com.naver.erp.BoardDAO.updateBoardEmpty"
//						,noticeDTO				
//				);
//				return updateCount;
//		 }
	
}
