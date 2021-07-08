config.load_autoconfig()

# Theme
config.source('nord.py')

# Adblock lists
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2020.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/legacy.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt",
    "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=1&mimetype=plaintext&_=223428",
    "https://raw.githubusercontent.com/brave/adblock-lists/master/brave-lists/brave-social.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt",
    "https://raw.githubusercontent.com/brave/adblock-lists/master/brave-unbreak.txt",
    "https://curben.gitlab.io/malware-filter/urlhaus-filter-online.txt",
    "https://gitcdn.xyz/repo/NanoAdblocker/NanoFilters/master/NanoMirror/NanoDefender.txt",
    "https://gitcdn.xyz/repo/NanoAdblocker/NanoFilters/master/NanoFilters/NanoBase.txt"]

# General Settings

c.content.pdfjs = True
c.tabs.last_close = "close"
c.scrolling.smooth = True
c.aliases = {'q': 'quit', 'w': 'session-save', 'wq': 'quit --save'}
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://docs.google.com/*')
config.set('content.headers.user_agent',
           'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://drive.google.com/*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
config.set('content.notifications.enabled', True, 'https://www.reddit.com')
config.set('content.notifications.enabled', True, 'https://www.youtube.com')
c.downloads.location.directory = '~/Downloads'
c.tabs.show = 'always'
c.url.default_page = 'https://start.duckduckgo.com'
c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}', 'am': 'https://www.amazon.com/s?k={}', 'aw': 'https://wiki.archlinux.org/?search={}', 'goog': 'https://www.google.com/search?q={}', 'hoog': 'https://hoogle.haskell.org/?hoogle={}',
                       're': 'https://www.reddit.com/r/{}', 'ub': 'https://www.urbandictionary.com/define.php?term={}', 'wiki': 'https://en.wikipedia.org/wiki/{}', 'yt': 'https://www.youtube.com/results?search_query={}'}

# Keybinds

# General

config.bind('K', ":tab-next")
config.bind('J', ":tab-prev")

# Bindings for normal mode
config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind(
    'xx', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')
config.bind('<Space>b', ':spawn -u qute-bitwarden')

# Open URLs in new tab
config.bind('<Space>q', ':close')
config.bind('<Space>R', ':config-source')
config.bind('<Space>yt', ':open youtube.com')
config.bind('<Space>re', ':open reddit.com')
config.bind('<Space>gh', ':open github.com/grvxs')
config.bind('<Space>yt', ':open youtube.com')
config.bind('<Space>du', ':open duckduckgo.com')
config.bind('<Space>dr', ':open docs.rs')
config.bind('<Space>go', ':open google.com')
config.bind('<Space>te', ':open web.telegram.org')
config.bind('<Space>wh', ':open web.whatsapp.com')
config.bind('<Space>pv', ':open primevideo.com')
config.bind('<Space>os', ':open https://wiki.osdev.org/Main_Page')
config.bind('<Space>t', ':open -t')
config.bind('<Space>T', ':open --private')
config.bind('<Space>l', ':hint links spawn --detach mpv --fs {hint-url}')
