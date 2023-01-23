package com.example.paperless;

import java.util.List;
import java.util.Map;

public interface PlannerDAO {
	
	/* plannerList.do */
	// 일정 목록 반환
	List<Map<String,String>> getPlanList(PlannerDTO plannerDTO);
	
	/* planRegProc.do */
	// 일정 추가
	int insertPlan(PlannerDTO plannerDTO);
	
	/* updatePlanProc.do */
	// 일정 수정
	int updatePlan(PlannerDTO plannerDTO);
	
	/* delPlanProc.do */
	// 일정 삭제
	int deletePlan(PlannerDTO plannerDTO);
}
