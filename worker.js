function off(shard){
	cmsrpc_request(".",
	"EvaluationService", 0,
	"disable_worker",
	{"shard":shard},
	function() {
	cmsrpc_request(".",
	"EvaluationService", 0,
	"workers_status",
	{},
	update_workers_status);
	});
}
function on(shard){
	cmsrpc_request(".",
	"EvaluationService", 0,
	"enable_worker",
	{"shard":shard},
	function() {
	cmsrpc_request(".",
	"EvaluationService", 0,
	"workers_status",
	{},
	update_workers_status);
	});
}
function restart(shard){
	off(shard);
	on(shard);
}
var workers_count=workers_status_table.children[1].children.length;
for (var i = 2; i < workers_count; i++) {
	if (workers_status_table.children[1].children[i].children[2].innerText==="Worker disabled") {
		on(i);
		console.log("on "+i);
	}
}
for (var i = 2; i < workers_count; i++) {
	m=workers_status_table.children[1].children[i].children[3].innerText.match(/(\d+) minute\(s\)/);
	if (m!==null) {
		if (m[1]>=2) {
			restart(i);
			console.log("restart "+i);
		}
	}
}