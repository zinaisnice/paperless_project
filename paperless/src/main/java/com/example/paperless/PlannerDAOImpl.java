package com.example.paperless;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PlannerDAOImpl implements PlannerDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/* plannerList.do */
	// 일정 목록 반환
	public List<Map<String,String>> getPlanList(PlannerDTO plannerDTO){
		/* plannerList.do */
		// 일정 목록 반환
		List<Map<String,String>> planList = this.sqlSession.selectList("com.example.paperless.PlannerDAO.getPlanList", plannerDTO);
		return planList;
	}
	
	/* planRegProc.do */
	// 일정 추가
	public int insertPlan(PlannerDTO plannerDTO) {
		int insertPlanCnt = this.sqlSession.insert("com.example.paperless.PlannerDAO.insertPlan", plannerDTO);
		return insertPlanCnt;
	}
	
	/* updatePlanProc.do */
	// 일정 수정
	public int updatePlan(PlannerDTO plannerDTO) {
		int updatePlanCnt = this.sqlSession.update("com.example.paperless.PlannerDAO.updatePlan", plannerDTO);
		return updatePlanCnt;
	}
	
	/* delPlanProc.do */
	// 일정 삭제
	public int deletePlan(PlannerDTO plannerDTO) {
		int deletePlanCnt = this.sqlSession.delete("com.example.paperless.PlannerDAO.deletePlan", plannerDTO);
		return deletePlanCnt;
	}
}
