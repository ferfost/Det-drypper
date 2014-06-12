// inject the main script from the latest github source
var s = document.createElement('script');
s.src = 'https://apottere.github.io/DripBot/dripBot.js';
(document.head||document.documentElement).appendChild(s);
s.onload = function() {
    s.parentNode.removeChild(s);
};

// add a variable so the script knows it is running from the extension (and can reload the window and still work)
var actualCode = '(' + function() {
   window.dripBotPro = true;
} + ')();';
var script = document.createElement('script');
script.textContent = actualCode;
(document.head||document.documentElement).appendChild(script);
script.parentNode.removeChild(script);
