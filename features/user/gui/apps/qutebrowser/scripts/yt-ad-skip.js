// ==UserScript==
// @name         Youtube Ad Skip
// @version      0.0.7
// @description  Make Youtube more tolerable by automatically skipping ads
// @author       Adcott
// @match        *://*.youtube.com/*
// ==/UserScript==

GM_addStyle(`
#player-ads,
.adDisplay,
.ad-container,
.ytd-display-ad-renderer,
.video-ads,
ytd-rich-item-renderer:has(ytd-ad-slot-renderer),
ytd-ad-slot-renderer,
#masthead-ad,
*[class^="ytd-ad-"],
#panels.ytd-watch-flexy {
    display: none !important;
}`);

document.addEventListener('load', () => {
    let ad = document.querySelector('.ad-showing:has(.ytp-ad-persistent-progress-bar-container) video');
    let skipButton = document.querySelector('.ytp-ad-skip-button');

    if (ad) ad.currentTime = 99999;
    if (skipButton) skipButton.click();
}, true);
