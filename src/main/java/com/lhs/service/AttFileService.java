package com.lhs.service;

import java.util.HashMap;
import java.util.List;

public interface AttFileService {
	
	/** type, board_seq 통한 해당 게시글의 모든 첨부파일 불러오기. 
	 * @param params
	 * @return
	 */
	public List<HashMap<String, Object>> readAttFiles(HashMap<String, Object> params);
	
	/**
	 *	pk를 통해 해당 첨부파일 불러오기.
	 * @param fileIdx
	 * @return
	 */
	public HashMap<String, Object> readAttFileByPk(int fileIdx);
	
	
	//첨부파일 테이블에 있는 정복와 물리적 파일간 연결끊긴 데이터 찾아서 특정클럼(linked)에 표시(update)하라.

		 /* 파일 없으면 컬럼 linked 값 수정 1건. 
		 */
		public int updateLinkedInfo();
		



	

}
