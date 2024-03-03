/**
 *  공통 스크립트
 */

function movePage(url, params){
	if(console){
		console.log(url);
		console.log(params);
	}
	
	if(params == undefined) params = {};
	
	$.ajax({
		url : ctx + url,
		data : params,
		success : function(data, status, XMLHttpRequest){
			console.log(data);
			$('div#contentDiv').html(data);
		},
		error : function(XMLHttpRequest, status, errorThrows){
			console.log(XMLHttpRequest.responseText);
			$('div#contentDiv').html(XMLHttpRequest.responseText);
		}
	});
}