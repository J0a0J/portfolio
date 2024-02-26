/**
 *  공통 스크립트
 */

function movePage(target, url, params){
	if(console){
		console.log(target);
		console.log(url);
		console.log(params);
	}
	
	if(params == undefined) params = {};
	if(target != null){
		
	}
	
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