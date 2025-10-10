import "./top-bar/top-bar.rhai" as top_bar;

enter([
    listen("wsp_info", #{ initial: "{}", cmd: "scripts/workspace" }),
    poll("time", #{ initial: "", cmd: "date +%H:%M", interval: "10s" }),
    poll("date", #{ initial: "", cmd: "date +%d/%m/%Y", interval: "24h" }),
    poll("uptime", #{ initial: "0", cmd: "cat /proc/uptime", interval: "1m" }),
    listen("volume", #{ initial: "", cmd: "scripts/getvol" }),

    // top bar and contents
    defwindow("top-bar", #{
        geometry: #{ width: "100%", height: "20px" },
        windowtype: "dock",
        exclusive: true,
        monitor: 0,
    }, top_bar::render(wsp_info, time)),

    defwindow("power-menu", #{
        geometry: #{
            y: "10px",
            x: "10px",
            anchor: "top right",
            width: "80px",
            height: "60px"
        },
        windowtype: "dialog",
        monitor: 0,
    }, top_bar::render_power()),

    defwindow("extra-sidebar", #{
        geometry: #{
            y: "10px",
            x: "10px",
            anchor: "top left",
            width: "80px",
            height: "60px"
        },
        windowtype: "dialog",
        monitor: 0,
    }, top_bar::render_sidebar(volume, uptime, date)),

    // Bottom dock
    defwindow("bottom-dock", #{
        geometry: #{ width: "40%", height: "30px", anchor: "bottom center" },
        windowtype: "dock",
        exclusive: true,
        monitor: 0,
    }, label(#{ text: "Hello there! this is work in progress..." }))
]);

