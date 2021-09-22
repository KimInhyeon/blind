/**
 * OSのパス区切りを返却する。
 */
function getPathSep() {
	var separater = null;
	var appVer = navigator.appVersion;
	if (appVer.indexOf("Win")!=-1) {
		separater = '\\';
	} else if (appVer.indexOf("Mac")!=-1) {
		separater = '/';
	} else if (appVer.indexOf("X11")!=-1) {
		separater = '/';
	} else if (appVer.indexOf("Linux")!=-1) {
		separater = '/';
	} else {
		separater = '/';
	}
    return separater;
}

/**
 * 入力値がnullまたはブランクの場合、trueを返却する。
 */
function isNull(p_id) {
	var input = document.getElementById(p_id);

	if (input === null || input.value == ""
			|| input.value.replace(/ /gi, "") == ""
			|| input.value == "undefined") {
		return true;
	} else {
		return false;
	}
}

/**
 * 入力値がnullまたはブランクかチェックする。
 */
function checkIsNull(p_id, label) {
	var msgStr = [ label ];

	if (isNull(p_id)) {
		sendMessage("KS_FMSYS_ERRMSG_001_JS", msgStr);
		setFocus(p_id);
		return false;
	} else {
		return true;
	}
}

/**
 * 入力値に特定文字があるのかチェックする。
 */
function containsChars(input, chars) {
	for (var i = 0; i < input.value.length; i++) {
		if (chars.indexOf(input.value.charAt(i)) != -1) {
			return true;
		}
	}
	return false;
}

/**
 * 入力値（ヴァリュー）に特定文字があるのかチェックする。
 */
function containsChars_value(p_value, chars) {
	for (var i = 0; i < p_value.length; i++) {
		if (chars.indexOf(p_value.charAt(i)) != -1) {
			return true;
		}
	}
	return false;
}

/**
 * 入力値に特定文字だけ許容したい時使う。
 */
function containsCharsOnly(input, chars) {
	for (var i = 0; i < input.value.length; i++) {
		if (chars.indexOf(input.value.charAt(i)) == -1) {
			return false;
		}
	}
	return true;
}

function containsCharsAndSpace(input, chars) {
	for (var i = 0; i < input.value.length; i++) {
		console.log(input.value.charAt(i));
		if (chars.indexOf(input.value.charAt(i)) == -1) {
			if (input.value.charAt(i) != " ") {
			    return false;	
			}
		} 
	}
	return true;
}


/**
 * 入力値がアルファベットかチェックする。
 */
function isAlphabet(p_id) {
	var input = document.getElementById(p_id);
	var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

	return containsCharsOnly(input, chars);
}

/**
 * 入力値がアルファベットかチェックする。
 */
function isAlphabetForEmployeeRegist(p_id) {
	var input = document.getElementById(p_id);
	var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

	return containsCharsAndSpace(input, chars);
}

/**
 * 入力値がアルファベット大文字かチェックする。
 */
function isUpperCase(input) {
	var input = document.getElementById(p_id);
	var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	return containsCharsOnly(input, chars);
}

/**
 * 入力値がアルファベット小文字かチェックする。
 */

function isLowerCase(p_id) {
	var input = document.getElementById(p_id);
	var chars = "abcdefghijklmnopqrstuvwxyz";

	return containsCharsOnly(input, chars);
}

/**
 * 入力値が数字の場合trueを返却する。
 */
function isNumber(p_id) {
	var input = document.getElementById(p_id);
	var chars = "0123456789";

	return containsCharsOnly(input, chars);
}

/**
 * 入力値が数字かチェックする。
 */
function checkIsNumber(p_id, label) {
	var msgStr = [ label ];

	if (!isNumber(p_id)) {
		sendMessage("KS_FMSYS_ERRMSG_004_JS", msgStr);
		setFocus(p_id);
		return false;
	} else {
		return true;
	}
}

/**
 * 入力値が数字・アルファベットではない場合trueを返却する。
 */
function isAlphaNum(p_id) {
	var input = document.getElementById(p_id);
	var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

	return containsCharsOnly(input, chars);
}

/**
 * 入力値がアルファベットまたは数字かチェックする。
 */
function checkIsAlphaNum(p_id) {
	if (!isAlphaNum(p_id)) {
		alert(KS_FMSYS_ERRMSG_006_JS);
		setFocus(p_id);
		return false;
	} else {
		return true;
	}
}

/**
 * 入力値が数字・アルファベットかチェックする。
 */
function isAlphaNum(p_id) {
	var input = document.getElementById(p_id);
	var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

	return containsCharsOnly(input, chars);
}

/**
 * 入力値が数字・ハイフンかチェックする。
 */
function isNumHyphen(p_id) {
	var input = document.getElementById(p_id);
	var chars = "-0123456789";

	return containsCharsOnly(input, chars);
}

/**
 * 入力値が数字・コンマかチェックする。
 */
function isNumComma(p_id) {
	var input = document.getElementById(p_id);
	var chars = ",0123456789";

	return containsCharsOnly(input, chars);
}

/**
 * 入力値がメール形式かチェックする。
 */
function isValidEmail(p_id) {
	var input = document.getElementById(p_id);
	var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;

	return isValidFormat(input, format);
}

/**
 * 入力値が電話番号形式かチェックする。
 */
function isValidPhone(p_id) {
	var input = document.getElementById(p_id);
	var format = /^(\d+)-(\d+)-(\d+)$/;

	return isValidFormat(input, format);
}

/**
 * 文字列長さチェック。
 */
function checkCharLength(p_id, p_min, p_max, label) {
	var msgStr = [ label, p_min, p_max ];
	var inputStr = document.getElementById(p_id).value;

	if (inputStr.length > p_max || inputStr.length < p_min) {
		if (inputStr.length != 0) {
			sendMessage("KS_FMSYS_ERRMSG_003_JS", msgStr);
			setFocus(p_id);
			return false;
		}
	} else {
		return true;
	}
}

/**
 * 入力値がメール形式かチェックする。
 */
function isValidEmail(p_id) {
	var input = document.getElementById(p_id);
	var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;

	return isValidFormat(input, format);
}

/**
 * 入力値がメール形式かチェックする。(＠前だけをチェック)
 */
function checkIsReissueEmail(p_id, label) {
	var msgStr = [ label, p_id ];

	if (!isValidReissueEmail(p_id)) {
		sendMessage("KS_FMSYS_ERRMSG_005_JS", msgStr);
		setFocus(p_id);
		return false;
	} else {
		return true;
	}
}

/**
 * 入力値がメール形式かチェックする。(＠前だけをチェック)
 */
function isValidReissueEmail(p_id) {
	var input = document.getElementById(p_id);
	var chars = "_.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

	return containsCharsOnly(input, chars);
}

/**
 * 入力値のバイト長さをリターンする。
 */
function getByteLength(p_id) {
	var input = document.getElementById(p_id);
	var byteLength = 0;
	for (var inx = 0; inx < input.value.length; inx++) {
		var oneChar = escape(input.value.charAt(inx));
		if (oneChar.length == 1) {
			byteLength++;
		} else if (oneChar.indexOf("%u") != -1) {
			byteLength += 2;
		} else if (oneChar.indexOf("%") != -1) {
			byteLength += oneChar.length / 3;
		}
	}
	return byteLength;
}

/**
 * 入力値のバイト長さが最大のバイト長さを増えるかをチェックする。
 */
function checkMaxByteLength(p_id, maxByteLength) {

	if (getByteLength(p_id) <= maxByteLength) {
		return true;
	} else {
		return false;
	}
}

/**
 * 入力値に特定文字があるのかチェックする。
 */
function checkSpecChars(p_id, specChars) {
	var input = document.getElementById(p_id);
	return containsChars(input, specChars);
}

/**
 * 入力値からコンマを削除する。
 */
function removeComma(p_id) {
	var input = document.getElementById(p_id);
	return input.value.replace(/,/gi, "");
}

/**
 * フォーカスを取得する。
 */
function setFocus(p_id) {
	setTimeout(function() {
		document.getElementById(p_id).focus(), 10
	});
}

/**
 * 入力値の先頭文字が "."（ドット）かをチェックする。
 */
function startWithDot(p_id) {
	var input = document.getElementById(p_id);
	var firstChar = input.value.charAt(0);
	if (firstChar == '.') {
		return true;
	} else {
		return false;
	}
}

/**
 * 入力値がシステム予約語かチェックする。
 */
function checkReservedWords(p_id) {
	var input = document.getElementById(p_id);
	const reservedWords = [ 'AUX', 'CON', 'NUL', 'PRN', 'COM0', 'COM1', 'COM2',
			'COM3', 'COM4', 'COM5', 'COM6', 'COM7', 'COM8', 'COM9', 'LPT0',
			'LPT1', 'LPT2', 'LPT3', 'LPT4', 'LPT5', 'LPT6', 'LPT7', 'LPT8',
			'LPT9' ];
	for (var reservedWord of reservedWords){
		if (input.value == reservedWord){
			return true;
		}
	}
	return false;
}

/**
 * 入力値(ヴァリュー)がシステム予約語かチェックする。
 */
function checkReservedWords_value(p_value) {
	const reservedWords = [ 'AUX', 'CON', 'NUL', 'PRN', 'COM0', 'COM1', 'COM2',
			'COM3', 'COM4', 'COM5', 'COM6', 'COM7', 'COM8', 'COM9', 'LPT0',
			'LPT1', 'LPT2', 'LPT3', 'LPT4', 'LPT5', 'LPT6', 'LPT7', 'LPT8',
			'LPT9' ];
	for (var reservedWord of reservedWords){
		if (p_value == reservedWord){
			return true;
		}
	}
	return false;
}

function checkIsZenkaku(p_id) { 
	var input = document.getElementById(p_id).value;
	
	for (var i = 0; i < input.length; ++i) { 
		var c = input.charCodeAt(i); 
		// 半角カタカナは不許可 
		if (c < 256 || (c >= 0xff61 && c <= 0xff9f)) { 
			alert(KS_FMSYS_ERRMSG_031_JS);
			setFocus(p_id);
			return false; 
		}
	}
	return true; 
}

function checkIsAlphabet(p_id) {
	var flag = true
	
	flag = isAlphabetForEmployeeRegist(p_id);
	
	if (!flag) {
		alert(KS_FMSYS_ERRMSG_030_JS);
		setFocus(p_id);
		return false;
	}
	return true;
}

function checkDropboxSelected(p_id, label) { 
	var input = document.getElementById(p_id).value;
	var msgStr = [ label, p_id ];
	
	if (input == "-1") { 
		sendMessage("KS_FMSYS_ERRMSG_002_JS", msgStr);
		setFocus(p_id);
		return false; 
	}
	return true; 
}

function checkIsDate(p_id) {
	var input = document.getElementById(p_id).value;
    var rxDatePattern = /^(\d{4})(\d{1,2})(\d{1,2})$/; //Declare Regex                  
    var dtArray = input.match(rxDatePattern); // is format OK?
    
    var flag = true
 
    if (dtArray == null)
    	flag = false;
 
    //Checks for yyyymmdd format.
    dtYear = dtArray[1];
    dtMonth = dtArray[2];
    dtDay = dtArray[3];
 
    if (dtMonth < 1 || dtMonth > 12)
    	flag = false;
    else if (dtDay < 1 || dtDay > 31)
    	flag = false;
    else if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31)
    	flag = false;
    else if (dtMonth == 2) {
        var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
        if (dtDay > 29 || (dtDay == 29 && !isleap))
        	flag = false;
    }
    
	if (!flag) {
		alert(KS_FMSYS_ERRMSG_032_JS);
		setFocus(p_id);
		return false;
	}
    return true;
}

function messageCreate(msg, msgStr) {
	var targetStr = "";
	var modMsg = msg;

	for (var inx = 0; inx < msgStr.length; inx++) {
		targetStr = '{' + inx + '}';
		modMsg = modMsg.replace(targetStr, msgStr[inx]);
	}

	return modMsg;
}

function sendMessage(msgId, msgStr) {
	var result = "";

	switch (msgId) {
	case "KS_FMSYS_ERRMSG_001_JS":
		result = messageCreate(KS_FMSYS_ERRMSG_001_JS, msgStr);
		alert(result);
		break;
		
	case "KS_FMSYS_ERRMSG_002_JS":
		result = messageCreate(KS_FMSYS_ERRMSG_002_JS, msgStr);
		alert(result);
		break;		

	case "KS_FMSYS_ERRMSG_003_JS":
		result = messageCreate(KS_FMSYS_ERRMSG_003_JS, msgStr);
		alert(result);
		break;

	case "KS_FMSYS_ERRMSG_004_JS":
		result = messageCreate(KS_FMSYS_ERRMSG_004_JS, msgStr);
		alert(result);
		break;

	case "KS_FMSYS_ERRMSG_005_JS":
		result = messageCreate(KS_FMSYS_ERRMSG_005_JS, msgStr);
		alert(result);
		break;
	}
}