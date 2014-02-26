$(function () {
	$(".pagination").hide();
	$(document).on("click", "#more-lp", function() {
		url = $('#lp-pagination .next_page').attr('href');
		if (url) {
			$("#more-lp").html('');
			$("#more-lp").spin('small');
			$.getScript(url);
		}
		return false;
	});
	lp_url = $('#lp-pagination .next_page').attr('href');
	if (!lp_url) {
		$("#more-lp").html('');
	}

	$(document).on("click", "#more-sp", function() {
		url = $('#sp-pagination .next_page').attr('href');
		if (url) {
			$("#more-sp").html('');
			$("#more-sp").spin('small');
			$.getScript(url);
		}
		return false;
	});
	sp_url = $('#sp-pagination .next_page').attr('href');
	if (!sp_url) {
		$("#more-sp").html('');
	}

	$(document).on("click", "#more-blp", function() {
		url = $('#blp-pagination .next_page').attr('href');
		if (url) {
			$("#more-blp").html('');
			$("#more-blp").spin('small');
			$.getScript(url);
		}
		return false;
	});
	blp_url = $('#blp-pagination .next_page').attr('href');
	if (!blp_url) {
		$("#more-blp").html('');
	}

	$(document).on("click", "#more-question", function() {
		url = $('#question-pagination .next_page').attr('href');
		if (url) {
			$("#more-question").html('');
			$("#more-question").spin('small');
			$.getScript(url);
		}
		return false;
	});
	qtn_url = $('#question-pagination .next_page').attr('href');
	if (!qtn_url) {
		$("#more-question").html('');
	}


	$(document).on("click", "#more-cat", function() {
		url = $('#cat-pagination .next_page').attr('href');
		if (url) {
			$("#more-cat").html('');
			$("#more-cat").spin('small');
			$.getScript(url);
		}
		return false;
	});
	cat_url = $('#cat-pagination .next_page').attr('href');
	if (!cat_url) {
		$("#more-cat").html('');
	}

	$(document).on("click", "#more-comp", function() {
		url = $('#comp-pagination .next_page').attr('href');
		if (url) {
			$("#more-comp").html('');
			$("#more-comp").spin('small');
			$.getScript(url);
		}
		return false;
	});
	comp_url = $('#comp-pagination .next_page').attr('href');
	if (comp_url) {
		$("#more-comp").html('More...');
	}

	$(document).on("click", "#more-risk", function() {
		url = $('#risk-pagination .next_page').attr('href');
		if (url) {
			$("#more-risk").html('');
			$("#more-risk").spin('small');
			$.getScript(url);
		}
		return false;
	});
	comp_url = $('#risk-pagination .next_page').attr('href');
	if (comp_url) {
		$("#more-risk").html('More...');
	}
});
