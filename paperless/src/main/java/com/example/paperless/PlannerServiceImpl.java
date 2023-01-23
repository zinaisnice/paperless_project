package com.example.paperless;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class PlannerServiceImpl implements PlannerService{
	
	@Autowired
	private PlannerDAO plannerDAO;
}
