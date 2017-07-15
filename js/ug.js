/*
 * jQuery loading, fires after the dom is loaded
 */
$().ready(function() {
	// Set up ajax calls
	$.ajaxSetup({
		cache: false, // Set cache to false so IE does not cache calls
		error: function(x,e) {
			if(x.status==0){
					alert('You are offline!!\nPlease Check Your Network.');
			}else if(x.status==400){
					alert('There was an error loading this content.');
			}else if(x.status==404){
					alert('Requested URL not found.');
			}else if(x.status==500){
					alert('Internel Server Error. Please retry the request.');
			}else if(e=='parsererror'){
					alert('Parsing JSON Request failed.');
			}else if(e=='timeout'){
					alert('Request time out. Please retry the request.');
		   }else{
					alert('Unknown error\nPlease retry the request.');
			}
		}
	});
});
	
var currId = '#home';
var curl;

$(document).ready(function() {
	// Handler for .ready() called.
	ContentChange('#home')
});

function random_character() {
    var chars = "0123456789abcdefghijklmnopqurstuvwxyzABCDEFGHIJKLMNOPQURSTUVWXYZ{;}/.-+ ";
    return chars.substr( Math.floor(Math.random() * 73), 1);
}

function generateerror() {
	var message = 'System Failure - Entering Debug mode';
	var w = Math.floor(Math.random() * 180) + 70;
	for (var o=0;o<w;o++) {
		message = message + ' ';
		var r = Math.floor(Math.random() * 20);
		if (r == 1) {
			message = message + random_notice();
		}
		var l = Math.floor(Math.random() * 10) + 1;
		for (var i=0;i<l;i++) {
			message = message + random_character();
		}
	}
	return message;
}

function random_notice() {
	var things = ['Disconnect', 'port-forward', 'drive I/o error','robots','abnormal end' ,'Abort, Retry, Fail?' ,'Bad command or file name' ,'Bounds checking' ,'Bounds-checking elimination' ,'Burst error-correcting code' ,'Can\'t extend' ,'Guru Meditation' ,'Halt and Catch Fire' ,'Hang (computing)' ,'Hyper Text Coffee Pot Control Protocol' ,'Inaccessible boot device' ,'KDL' ,'Kernel panic' ,'Kmode exception not handled' ,'Known error' ,'Lame delegation' ,'Linux kernel oops' ,'Logfile' ,'Logic error' ,'Lp0 on fire' ,'Machine-check exception' ,'Mojibake' ,'NO CARRIER' ,'Netsplit' ,'Not a typewriter' ,'Out of memory' ,'PC LOAD LETTER' ,'Page fault' ,'Reboot (computing)' ,'Red Screen of Death' ,'Runtime error 200' ,'Screen of death' ,'Segmentation fault' ,'Semantic error' ,'Software brittleness' ,'Stack buffer overflow' ,'Stack overflow' ,'Standby of death' ,'Syntax error' ,'Systematic fault' ,'Triple fault' ,'Unexpected kernel mode trap' ,'Yellow light of death' ,'ERROR 100' ,'ERROR 110' ,'ERROR 120' ,'ERROR 125' ,'ERROR 150' ,'ERROR 200' ,'ERROR 202' ,'ERROR 211' ,'ERROR 212' ,'ERROR 213' ,'ERROR 214' ,'ERROR 215' ,'ERROR 220' ,'ERROR 221' ,'ERROR 225' ,'ERROR 226' ,'ERROR 227', 'ERROR 551' ,'ERROR 552' ,'ERROR 553' ,'ERROR 600' ,'ERROR 631' ,'ERROR 632' ,'ERROR 633','Arden', 'Camden', 'Celadine',  'Collins', 'Daralis', 'Grant', 'Grayson', 'Huntley', 'Jadrek', 'Jane',  'Kara', 'Orikanos', 'Parker', 'Phedra', 'Professor', 'Quinn', 'Reese', 'Slate', 'Smith', 'Zekia', 'Children', 'Princess', 'Space Ship', 'United States', 'France', 'Mars', 'Immortal Prison', 'Mexico City', 'Africa', 'Fate Well Critical', 'UN', 'Crowns', 'Broken', 'CIA', 'Project H6K1'];
	return things[Math.floor(Math.random()*things.length)];
}

function ContentChange(WhichDiv) {
	$(currId).hide();
	currId = WhichDiv; 	

	switch(WhichDiv) {
		case '#n-news':
			var spinner = $('#n-news').html('<h1>Loading..<blink>.</blink></h1><br><br>');
			$('#n-news').show();
			curl = "http://underground.qii.net/news.pl?ntype=1";
			spinner.load(curl, function(){  });
			return;
		break;
		case '#o-news':
			var spinner = $('#o-news').html('<h1>Loading..<blink>.</blink></h1><br><br>');
			$('#o-news').show();
			curl = "http://underground.qii.net/news.pl?ntype=2";
			spinner.load(curl, function(){  });
			return;
		case '#comms':
			var onewserror = generateerror();
			$('#comms').html('<h1>Loading..<blink>.</blink></h1><br><br>'+onewserror);
			$('#comms').show();
			return;
		default:
			$(WhichDiv).show();
			return;
		break;	
	}	
	
}

function showtype(WhichDiv) {
	$(WhichDiv).toggle();
}

function togglenews(WhichNews) {
	$(WhichNews).fadeToggle("slow", "linear");
}


function UpdateContent(ct) {
	var curl
	
	var spinner = $('#content').html('');
	curl = "/news.pl";
	spinner.load(curl, function(){
	$('#n-news').show();
	});

}	
	