$(function () {
    var browser = '';
    var isIE = navigator.userAgent.search("MSIE") > -1;
    var isIE7 = navigator.userAgent.search("MSIE 7") > -1;
    var isFirefox = navigator.userAgent.search("Firefox") > -1;
    var isOpera = navigator.userAgent.search("Opera") > -1;
    var isSafari = navigator.userAgent.search("Safari") > -1;//Google瀏覽器是用這核心

    if (!!navigator.userAgent.match(/Trident\/7\./)) {
        alert('您正在使用IE瀏覽器，請更換Chrome!');
    }

    if (isIE7) {
        browser = 'IE7';
        alert('您正在使用IE瀏覽器，請更換Chrome!');
    }
    if (isIE) {
        browser = 'IE';
        alert('您正在使用IE瀏覽器，請更換Chrome!');
    }

    if (isFirefox) {
        browser = 'Firefox';
    }
    if (isOpera) {
        browser = 'Opera';
    }
    if (isSafari) {
        browser = 'Safari/Chrome';
    }
    //return browser;
});

// ===== 根據瀏覽器動態改變元素大小 ====== //
//var browser = detectBrowser();
//alert(browser);