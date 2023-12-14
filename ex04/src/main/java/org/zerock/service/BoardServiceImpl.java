package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
@ToString
public class BoardServiceImpl implements BoardService {
	
	private BoardMapper mapper;

	@Override
	public void register(BoardVO board) {
		
		log.info("register....." + board);
		
		mapper.insertSelectKey(board);
	}

	@Override
	public List<BoardVO> getList() {
		log.info("getList................");
		return mapper.getList();
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get.............." + bno);
			return mapper.read(bno);
	}

	@Override
	public int modify(BoardVO board) {
		log.info("modify............" + board);
		return mapper.update(board);
	}

	@Override
	public int remove(Long bno) {
		log.info("remove........." + bno);
		return mapper.delete(bno);
	}
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		
		log.info("get List with criteria: " + cri);
		
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

}
