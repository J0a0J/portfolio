<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<script>

function getBoardData(pageNumber) {
	// RestController url - 데이터를 받아올 곳 
    var url = '/haha/board/' + pageNumber + '.do'; // 동적으로 URL 생성
    // url을 변경해도 현재의 페이지가 뜨게 해주는 기능 
    // Controller url - jsp를 사용해야 하기에 이 url 사용 
    history.pushState({}, '', '/haha/board/list.do?page=' + pageNumber);
   	
    $.ajax({
        url: url,
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            // 성공적으로 데이터를 받아온 경우 처리 로직
            var boardList = data.boardInfo;
            var html = ''; 

            // 받아온 데이터로 HTML을 생성
            for (var i = 0; i < boardList.length; i++) {
                var board = boardList[i];
                
                // 생성한 HTML을 변수에 추가
                html += '<tr>' +
                            '<td align="center">' + board.boardSeq + '</td>' +
                            '<td>' +
                                '<span class="bold">' +
                                    '<a href="javascript:movePage(\'/board/read.do?boardSeq=' + board.boardSeq + '&page=' + 1 + '\')">' + 
                                        board.title +
                                    '</a>' +
                                '</span>' +
                            '</td>' +
                            '<td>' + board.memberNick + '</td>' +
                            '<td>' + board.hits + '</td>' +
                            '<td>' + (board.hasFile ? board.hasFile : '') + '</td>' +
                            '<td>' + (board.createDtm ? board.createDtm : '') + '</td>' +
                        '</tr>';
                        
            	generatePagination(data.pageTotalNums, data.pageGroup, ${page});
            }

            // 생성한 HTML을 tbody에 삽입 
            $('#boardTableBody').html(html);
            
        },
        error: function(xhr, status, error) {
            console.error(error); // 오류 처리
        }
    });
}

function generatePagination(pageTotalNums, pageGroup, currentPage) {
    var pageUnit = 10;
    var beginPage = 1 + (pageGroup * pageUnit);
    var endPage = (pageTotalNums - currentPage) < 10 ? pageTotalNums : pageUnit + (pageGroup * 10);

    var html = '';

    // 이전 페이지로 이동하는 링크
    html += '<li class="page-item"><a class="page-link" href="#" data-page="' + (beginPage - pageUnit) + '">&laquo;</a></li>';

    // 페이지 번호 생성
    for (var i = beginPage; i <= endPage; i++) {
        if (currentPage == i) {
        	// Controller로 현재 페이지 값을 보내고  
            html += '<li class="page-item active"><a class="page-link" href="/board/list.do?page=' + i 
            		+ '" data-page="' + i + '">' + i + '</a></li>';
        } else {
            html += '<li class="page-item"><a class="page-link" href="javascript:movePage(\'/board/list.do?page=' + i 
            		+ '\')" data-page="' + i + '">' + i + '</a></li>';
        }
    }

    // 다음 페이지로 이동하는 링크
    html += '<li class="page-item"><a class="page-link" href="javascript:movePage(\'/board/list.do?page=' 
    		+ (pageUnit + 1 + (pageGroup * 10)) + '\')" data-page="' + (pageUnit + 1 + (pageGroup * 10)) + '">&raquo;</a></li>';

    // 페이지 번호를 출력할 요소에 HTML 삽입
    $('#pagination').html(html);
}

// 페이지 로드 시 데이터 요청
$(document).ready(function() {
	// 동적으로 url 변경을 위해 Controller에서 값을 받아옴.
	var currentPage = parseInt('${page}');
    getBoardData(currentPage); // 초기 페이지 번호를 전달하여 데이터 요청
});

function search() {
	// 선택된 검색 조건과 검색어 가져오기
    var searchSelectValue = document.getElementById('searchSelect').value;
    var searchInputValue = document.getElementById('searchInput').value;
    
    // URL 생성
    var url = '/board/list.do?searchSelect=' + searchSelectValue + '&searchKeyword=' + searchInputValue;
    
    // 생성된 URL로 이동
	movePage(url);
}
</script>
<body>
<style>
.search-container {
    text-align: center;
}
.search-input,
.search-select {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-right: 10px;
    box-sizing: border-box;
}
</style>
	<section>
	<div class="container">
		<h4>자유게시판</h4>
		<div class="table-responsive">
			<table class="table table-sm">
				<colgroup>
					<col width="10%" />
					<col width="35%" />
					<col width="10%" />
					<col width="8%" />
					<col width="8%" />
					<col width="15%" />
				</colgroup>

				<thead>
					<tr>
						<th class="fw-30" align="center">&emsp;&emsp;&emsp;#</th>
						<th align="center">제목</th>
						<th align="center">글쓴이</th>
						<th align="center">조회수</th>
						<th align="center">첨부파일</th>
						<th align="center">작성일</th>
					</tr>
				</thead>
				
				<!-- 글 정보 들어가는 곳 -->
				<tbody id="boardTableBody">	
				</tbody>
				
			</table>
		</div>
		<div class="row text-center">
			<div class="col-md-12">
			
			<!-- 하단 번호  -->
				<ul class="pagination pagination-simple pagination-sm" id="pagination">
				</ul>
		
			</div>
		</div> 
		<div class="row">
			<div class="col-md-12 text-right">
				<a href="javascript:movePage('/board/goToWrite.do')">
					<button type="button" class="btn btn-primary">
						<i class="fa fa-pencil"></i> 글쓰기
					</button>
				</a>
			</div>
		</div>
		<div class="search-container">
	        <!-- 검색 조건 선택 드롭다운 -->
	        <select id="searchSelect" class="search-select"  name="searchSelect">
	            <option value="title" name="title">제목</option>
	            <option value="memberNick" name="member_nick">글쓴이</option>
        	</select>	
	        <!-- 검색 입력란 -->
	        <input type="text" id="searchInput" class="search-input" placeholder="검색어를 입력하세요" name="searchInput">
	        <!-- 검색 버튼 -->
	        <button id="searchButton" class="btn btn-primary" type="submit" onclick="search()">검색</button>
    	</div>
	</div>
	</section>
	<!-- / -->
</body>
</html>