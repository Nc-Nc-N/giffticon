package com.ncncn.service;

import java.util.List;

import com.ncncn.domain.CsPsnlQustVO;
import com.ncncn.domain.pagination.CsCriteria;

public interface PsnlQustService {

	//1:1문의 등록
	void register(CsPsnlQustVO qna);

	//ajax CsPsnlQustVO 가져오기
	CsPsnlQustVO get(int id);

	//관리자 답변 및 수정
	boolean modify(CsPsnlQustVO qna);

	//사용자 문의 수정
	boolean modifyFromUser(CsPsnlQustVO qna);

	//1:1문의 삭제
	boolean remove(int id);

	//관리자 1:1문의 가져오기
	List<CsPsnlQustVO> getList(CsCriteria cri);

	//사용자 1:1문의 가져오기
	List<CsPsnlQustVO> getListPsnlQust(CsCriteria cri, int userId);

	//관리자 total
	int getTotal(CsCriteria cri);

	//사용자 total
	int getTotalPsnlQust(CsCriteria cri, int userId);

	//답변대기 통계를 위한 count
	int countHaveNoAns();
}
