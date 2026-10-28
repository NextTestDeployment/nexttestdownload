// NextTest Sample External JavaScript File
// Modifies page style and returns viewport metrics
const banner = document.createElement('div');
banner.id = 'nexttest-custom-banner';
banner.innerText = '⚡ Executed from external .js file via executeScriptFile';
banner.style.cssText = 'position:fixed;top:0;left:0;right:0;background:#a9cf34;color:#233034;text-align:center;font-weight:bold;padding:6px;z-index:99999;font-size:14px;';
document.body.appendChild(banner);
return { width: window.innerWidth, height: window.innerHeight, title: document.title };
