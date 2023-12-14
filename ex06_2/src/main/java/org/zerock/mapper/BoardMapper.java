package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	
	List<BoardVO> getList();
	
	List<BoardVO> getListWithPaging(Criteria cri);
	
	void insert(BoardVO board);
	
	void insertSelectKey(BoardVO board);
	
	BoardVO read(Long bno);
	
	int delete(Long bno);
	
	int update(BoardVO board);
	
	int getTotalCount(Criteria cri);
	
	void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);

}
