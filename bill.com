
<!DOCTYPE html>
<html lang="en" data-theme="auto">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Pakistan electricity bill checker — MEPCO, LESCO, GEPCO, FESCO, IESCO, PESCO, HESCO, SEPCO, QESCO, TESCO, HAZECO">
<title>Pakistan Electricity Bill Checker</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
<style>
/* ════════════════════════════════════════
   THEME
════════════════════════════════════════ */
:root { --dur: .28s; }

html {
  --bg: #0d130d; --bg2: #131d13; --sf: #172117; --sf2: #1d2d1d;
  --br: #263826; --br2: #2e4a2e;
  --tx: #e8f5e8; --t2: #9dc09d; --t3: #5e825e;
  --gr: #22c55e; --grd: rgba(34,197,94,.13); --grm: rgba(34,197,94,.38); --grg: rgba(34,197,94,.2);
  --re: #fc8181; --red: rgba(252,129,129,.12); --rem: rgba(252,129,129,.38);
  --ye: #f6c90e; --bl: #63b3ed;
  --wp: #25D366; --wpd: rgba(37,211,102,.13);
  --shc: 0 2px 16px rgba(0,0,0,.45);
  --shh: 0 4px 28px rgba(0,0,0,.55);
}
html[data-theme="light"] {
  --bg: #f0f7f0; --bg2: #e4f0e4; --sf: #ffffff; --sf2: #f4faf4;
  --br: #c5dbc5; --br2: #aaccaa;
  --tx: #141f14; --t2: #365936; --t3: #6a8c6a;
  --gr: #15803d; --grd: rgba(21,128,61,.11); --grm: rgba(21,128,61,.42); --grg: rgba(21,128,61,.18);
  --re: #e53e3e; --red: rgba(229,62,62,.10); --rem: rgba(229,62,62,.38);
  --ye: #b7791f; --bl: #2b6cb0;
  --wp: #075E54; --wpd: rgba(7,94,84,.10);
  --shc: 0 2px 16px rgba(0,0,0,.08);
  --shh: 0 4px 28px rgba(0,0,0,.12);
}
@media (prefers-color-scheme: light) {
  html[data-theme="auto"] {
    --bg: #f0f7f0; --bg2: #e4f0e4; --sf: #ffffff; --sf2: #f4faf4;
    --br: #c5dbc5; --br2: #aaccaa;
    --tx: #141f14; --t2: #365936; --t3: #6a8c6a;
    --gr: #15803d; --grd: rgba(21,128,61,.11); --grm: rgba(21,128,61,.42); --grg: rgba(21,128,61,.18);
    --re: #e53e3e; --red: rgba(229,62,62,.10); --rem: rgba(229,62,62,.38);
    --ye: #b7791f; --bl: #2b6cb0;
    --wp: #075E54; --wpd: rgba(7,94,84,.10);
    --shc: 0 2px 16px rgba(0,0,0,.08);
    --shh: 0 4px 28px rgba(0,0,0,.12);
  }
}

/* ════════════════════════════════════════
   RESET & BASE
════════════════════════════════════════ */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }
body {
  background: var(--bg); color: var(--tx);
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 15px; line-height: 1.7;
  min-height: 100vh;
  transition: background var(--dur), color var(--dur);
}
body::before {
  content: ''; position: fixed; inset: 0; pointer-events: none; z-index: 0;
  background-image:
    linear-gradient(var(--br) 1px, transparent 1px),
    linear-gradient(90deg, var(--br) 1px, transparent 1px);
  background-size: 48px 48px; opacity: .14;
}
a { color: inherit; text-decoration: none; }
button { cursor: pointer; font-family: inherit; }

/* ════════════════════════════════════════
   LAYOUT
════════════════════════════════════════ */
.wrap {
  position: relative; z-index: 1;
  max-width: 1000px; margin: 0 auto; padding: 0 16px 60px;
}

/* ════════════════════════════════════════
   HEADER  (normal flow, NOT sticky)
════════════════════════════════════════ */
.site-header {
  background: var(--sf);
  border: 1px solid var(--br);
  border-radius: 18px;
  padding: 22px 24px 20px;
  margin: 18px 0 18px;
  box-shadow: var(--shh);
}

/* Brand row */
.hdr-brand-row {
  display: flex; align-items: center; justify-content: space-between;
  gap: 12px; flex-wrap: wrap; margin-bottom: 16px;
}
.hdr-brand { display: flex; align-items: center; gap: 12px; }
.hdr-icon {
  width: 46px; height: 46px; background: var(--gr); border-radius: 13px;
  display: flex; align-items: center; justify-content: center;
  font-size: 22px; box-shadow: 0 0 18px var(--grg); flex-shrink: 0;
}
.hdr-title {
  font-size: clamp(16px, 3.5vw, 22px);
  font-weight: 800; letter-spacing: -.4px; line-height: 1.15;
}
.hdr-title span { color: var(--gr); }
.hdr-sub {
  font-size: 11px; color: var(--t3);
  font-family: 'JetBrains Mono', monospace; margin-top: 2px;
}

/* Theme toggle */
.theme-grp {
  display: flex; align-items: center;
  background: var(--bg2); border: 1px solid var(--br);
  border-radius: 32px; padding: 3px; gap: 2px; flex-shrink: 0;
}
.tbtn {
  border: none; background: transparent; padding: 5px 12px; border-radius: 26px;
  font-size: 12px; font-weight: 600; color: var(--t3); transition: all .2s;
}
.tbtn.on { background: var(--gr); color: #fff; box-shadow: 0 0 10px var(--grm); }
.tbtn:hover:not(.on) { background: var(--br); color: var(--tx); }

/* DISCO grid */
.disco-label {
  font-size: 10px; font-family: 'JetBrains Mono', monospace;
  color: var(--t3); text-transform: uppercase; letter-spacing: 2px;
  margin-bottom: 8px; display: flex; align-items: center; gap: 8px;
}
.disco-label::after { content: ''; flex: 1; height: 1px; background: var(--br); }

.disco-grid {
  display: grid;
  grid-template-columns: repeat(11, 1fr);
  gap: 6px; margin-bottom: 16px;
}
@media (max-width: 680px) { .disco-grid { grid-template-columns: repeat(6, 1fr); } }
@media (max-width: 380px) { .disco-grid { grid-template-columns: repeat(4, 1fr); } }

.dbtn {
  background: var(--bg2); border: 1.5px solid var(--br); border-radius: 9px;
  padding: 8px 4px; text-align: center; transition: all .16s;
}
.dbtn:hover { border-color: var(--grm); background: var(--grd); transform: translateY(-1px); }
.dbtn.on {
  border-color: var(--gr); background: var(--grd);
  box-shadow: 0 0 12px var(--grd); transform: translateY(-1px);
}
.dk {
  font-family: 'JetBrains Mono', monospace; font-size: 11px;
  font-weight: 700; color: var(--t2); display: block;
}
.dbtn:hover .dk, .dbtn.on .dk { color: var(--gr); }
.dn { font-size: 9px; color: var(--t3); display: block; margin-top: 2px; line-height: 1.2; }
@media (max-width: 600px) { .dn { display: none; } }

/* Search row */
.search-row { display: flex; gap: 8px; flex-wrap: wrap; margin-bottom: 8px; }
.ref-inp {
  flex: 1; min-width: 200px;
  background: var(--bg2); border: 2px solid var(--br); border-radius: 11px;
  padding: 13px 16px; font-family: 'JetBrains Mono', monospace;
  font-size: 16px; font-weight: 500; color: var(--tx); outline: none;
  transition: border-color .2s, box-shadow .2s;
  letter-spacing: 2px;
}
.ref-inp::placeholder { color: var(--t3); font-size: 12px; letter-spacing: .5px; }
.ref-inp:focus { border-color: var(--gr); box-shadow: 0 0 0 4px var(--grd); }

.btn-primary {
  background: var(--gr); color: #fff; border: none; border-radius: 11px;
  padding: 13px 26px; font-weight: 700; font-size: 15px; white-space: nowrap;
  transition: opacity .2s, transform .15s; display: inline-flex; align-items: center; gap: 7px;
}
.btn-primary:hover { opacity: .88; transform: translateY(-1px); }
.btn-primary:active { transform: scale(.97); }
.btn-primary:disabled { opacity: .4; cursor: not-allowed; transform: none; }

.btn-outline {
  background: transparent; color: var(--gr); border: 2px solid var(--grm);
  border-radius: 11px; padding: 13px 18px; font-weight: 700; font-size: 13px;
  white-space: nowrap; transition: all .2s; display: inline-flex; align-items: center; gap: 6px;
}
.btn-outline:hover { background: var(--grd); border-color: var(--gr); }
.btn-outline:disabled { opacity: .35; pointer-events: none; }

/* Detection badge */
.det-badge {
  display: none; padding: 8px 13px; border-radius: 8px;
  background: var(--grd); border: 1px solid var(--grm);
  font-size: 12px; color: var(--gr); font-family: 'JetBrains Mono', monospace;
}
.det-badge.show { display: block; animation: slideIn .3s ease; }

/* Rate limit warning */
.rl-warn {
  display: none; padding: 10px 14px; border-radius: 8px; margin-top: 8px;
  background: rgba(246,201,14,.1); border: 1px solid rgba(246,201,14,.4);
  font-size: 12px; color: var(--ye); font-family: 'JetBrains Mono', monospace;
  align-items: center; gap: 8px;
}
.rl-warn.show { display: flex; }

/* ════════════════════════════════════════
   BANNERS
════════════════════════════════════════ */
.banner {
  border-radius: 14px; padding: 14px 18px; margin-bottom: 14px;
  display: flex; align-items: center; justify-content: space-between;
  gap: 12px; flex-wrap: wrap; transition: box-shadow .2s, border-color .2s;
}
.proj-ban {
  background: linear-gradient(135deg, var(--sf), var(--sf2));
  border: 1px solid var(--br); box-shadow: var(--shc);
}
.proj-ban:hover { border-color: var(--grm); box-shadow: 0 4px 20px var(--grd); }
.wa-ban {
  background: linear-gradient(135deg, var(--wpd), var(--sf));
  border: 1.5px solid var(--wp); box-shadow: 0 2px 14px var(--wpd);
}
.wa-ban:hover { box-shadow: 0 4px 22px var(--wpd); }
.wa-post { display: none; }
.wa-post.show { display: flex; animation: bounceIn .5s ease; }

.ban-info { display: flex; align-items: center; gap: 11px; }
.bico {
  width: 40px; height: 40px; border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  font-size: 18px; flex-shrink: 0;
}
.bico-sq { border-radius: 11px !important; }
.bico-g { background: var(--grd); border: 1px solid var(--grm); }
.bico-wp { background: var(--wp); }
.btx strong { font-size: 14px; font-weight: 700; display: block; color: var(--tx); }
.btx span { font-size: 12px; color: var(--t3); }

.btn-g { background: var(--gr); color: #fff; border: none; }
.btn-g:hover { opacity: .88; transform: translateY(-1px); }
.btn-wp { background: var(--wp); color: #fff; border: none; }
.btn-wp:hover { opacity: .88; transform: translateY(-1px); }
.btn-sm {
  border-radius: 9px; padding: 9px 17px; font-weight: 700;
  font-size: 13px; display: inline-flex; align-items: center;
  gap: 6px; transition: all .2s; white-space: nowrap; text-decoration: none; cursor: pointer;
}

/* ════════════════════════════════════════
   SECTION LABEL
════════════════════════════════════════ */
.slbl {
  font-size: 11px; font-family: 'JetBrains Mono', monospace; color: var(--t3);
  text-transform: uppercase; letter-spacing: 2.5px; margin: 20px 0 10px;
  display: flex; align-items: center; gap: 9px;
}
.slbl::after { content: ''; flex: 1; height: 1px; background: var(--br); }

/* ════════════════════════════════════════
   LOADING / ERROR
════════════════════════════════════════ */
.loading { display: none; text-align: center; padding: 50px 20px; }
.loading.on { display: block; }
.spinner {
  width: 44px; height: 44px; border: 3px solid var(--br);
  border-top-color: var(--gr); border-radius: 50%;
  animation: spin .7s linear infinite; margin: 0 auto 14px;
}
.loading-txt { font-family: 'JetBrains Mono', monospace; font-size: 13px; color: var(--t3); }

.errbox {
  display: none; background: var(--red); border: 1.5px solid var(--rem);
  border-radius: 12px; padding: 14px 18px; color: var(--re);
  font-size: 14px; margin-bottom: 14px; gap: 10px; line-height: 1.5;
}
.errbox.on { display: flex; animation: slideIn .3s ease; }
.errbox a { color: var(--re); text-decoration: underline; }

/* ════════════════════════════════════════
   RESULTS
════════════════════════════════════════ */
#res { display: none; }
#res.on { display: block; animation: fadeUp .45s ease; }

/* Bill head */
.bhead {
  background: var(--sf); border: 1px solid var(--br); border-radius: 16px;
  padding: 22px; margin-bottom: 12px; box-shadow: var(--shc);
  display: grid; grid-template-columns: 1fr auto; gap: 18px; align-items: start;
}
@media (max-width: 500px) { .bhead { grid-template-columns: 1fr; } }

.cname { font-size: 22px; font-weight: 800; letter-spacing: -.4px; margin-bottom: 3px; }
.cfn { font-size: 13px; color: var(--t3); margin-bottom: 4px; }
.cadr { font-size: 13px; color: var(--t2); margin-bottom: 10px; line-height: 1.4; }
.tags { display: flex; flex-wrap: wrap; gap: 6px; }
.tag {
  background: var(--sf2); border: 1px solid var(--br); border-radius: 6px;
  padding: 3px 9px; font-family: 'JetBrains Mono', monospace; font-size: 10px; color: var(--t3);
}
.tag.g { border-color: var(--grm); color: var(--gr); background: var(--grd); }
.tag.b { border-color: rgba(99,179,237,.4); color: var(--bl); background: rgba(99,179,237,.10); }
html[data-theme="light"] .tag.b { border-color: rgba(43,108,176,.3); color: #2b6cb0; background: rgba(43,108,176,.08); }

.ablock { text-align: right; flex-shrink: 0; min-width: 145px; }
@media (max-width: 500px) { .ablock { text-align: left; min-width: auto; } }
.albl {
  font-size: 10px; font-family: 'JetBrains Mono', monospace; color: var(--t3);
  text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 4px;
}
.aval { font-size: 38px; font-weight: 800; color: var(--gr); line-height: 1; letter-spacing: -1.5px; }
.aunit { font-size: 15px; font-weight: 400; color: var(--t3); }
.duelbl { font-family: 'JetBrains Mono', monospace; font-size: 12px; color: var(--re); margin-top: 5px; }
.afterd { font-size: 13px; color: var(--t3); margin-top: 3px; }
.afterd strong { color: var(--ye); font-weight: 700; }
.bpaid { display: inline-flex; align-items: center; gap: 4px; background: var(--grd); color: var(--gr); border: 1px solid var(--grm); border-radius: 6px; padding: 3px 10px; font-size: 11px; font-weight: 700; font-family: 'JetBrains Mono', monospace; margin-top: 7px; }
.bover { display: inline-flex; align-items: center; gap: 4px; background: var(--red); color: var(--re); border: 1px solid var(--rem); border-radius: 6px; padding: 3px 10px; font-size: 11px; font-weight: 700; font-family: 'JetBrains Mono', monospace; margin-top: 7px; }

/* Dup card */
.dupcard {
  background: var(--sf); border: 1.5px solid var(--grm); border-radius: 14px;
  padding: 14px 20px; margin-bottom: 12px;
  display: flex; align-items: center; justify-content: space-between;
  gap: 12px; flex-wrap: wrap; box-shadow: 0 2px 14px var(--grd);
}
.dupinfo strong { font-size: 14px; font-weight: 700; display: block; }
.dupinfo span { font-size: 12px; color: var(--t3); }

/* Grid 2 */
.g2 { display: grid; grid-template-columns: 1fr 1fr; gap: 11px; margin-bottom: 11px; }
@media (max-width: 500px) { .g2 { grid-template-columns: 1fr; } }

.card {
  background: var(--sf); border: 1px solid var(--br); border-radius: 14px;
  padding: 17px; box-shadow: var(--shc);
}
.cttl {
  font-size: 11px; font-family: 'JetBrains Mono', monospace; color: var(--t3);
  text-transform: uppercase; letter-spacing: 2px; margin-bottom: 12px;
  padding-bottom: 9px; border-bottom: 1px solid var(--br);
}
.ir {
  display: flex; justify-content: space-between; align-items: baseline;
  padding: 7px 0; border-bottom: 1px solid var(--br); gap: 10px;
}
.ir:last-child { border-bottom: none; }
.ik { font-size: 13px; color: var(--t2); flex-shrink: 0; }
.iv { font-size: 13px; font-weight: 600; font-family: 'JetBrains Mono', monospace; text-align: right; }
.iv.g { color: var(--gr); } .iv.r { color: var(--re); } .iv.y { color: var(--ye); }

/* Charges */
.ccard {
  background: var(--sf); border: 1px solid var(--br); border-radius: 14px;
  padding: 17px; margin-bottom: 11px; box-shadow: var(--shc);
}
.cgrid { display: grid; grid-template-columns: 1fr 1fr; }
@media (max-width: 500px) { .cgrid { grid-template-columns: 1fr; } }
.ccol:first-child { padding-right: 17px; border-right: 1px solid var(--br); margin-right: 17px; }
@media (max-width: 500px) {
  .ccol:first-child { padding-right: 0; border-right: none; margin-right: 0; border-bottom: 1px solid var(--br); padding-bottom: 13px; margin-bottom: 13px; }
}
.cct { font-size: 11px; color: var(--t3); font-family: 'JetBrains Mono', monospace; margin-bottom: 8px; padding-bottom: 6px; border-bottom: 1px solid var(--br); }

/* Meter */
.mcard { background: var(--sf); border: 1px solid var(--br); border-radius: 14px; padding: 17px; margin-bottom: 11px; box-shadow: var(--shc); }
.mstats { display: grid; grid-template-columns: repeat(auto-fit, minmax(95px, 1fr)); gap: 9px; margin-top: 10px; }
.mst { background: var(--sf2); border: 1px solid var(--br); border-radius: 10px; padding: 13px; text-align: center; }
.mslbl { font-size: 10px; font-family: 'JetBrains Mono', monospace; color: var(--t3); text-transform: uppercase; letter-spacing: .8px; margin-bottom: 5px; }
.msval { font-size: 19px; font-weight: 800; color: var(--gr); font-family: 'JetBrains Mono', monospace; }

/* History */
.hcard { background: var(--sf); border: 1px solid var(--br); border-radius: 14px; padding: 17px; overflow-x: auto; box-shadow: var(--shc); }
.htbl { width: 100%; border-collapse: collapse; min-width: 400px; }
.htbl th {
  font-family: 'JetBrains Mono', monospace; font-size: 10px; text-transform: uppercase;
  letter-spacing: 1.5px; color: var(--t3); padding: 8px 10px; text-align: left;
  border-bottom: 2px solid var(--br);
}
.htbl td { padding: 9px 10px; border-bottom: 1px solid var(--br); font-size: 13px; }
.htbl tr:last-child td { border-bottom: none; }
.htbl tbody tr:hover td { background: var(--sf2); }
.htbl td:first-child { font-family: 'JetBrains Mono', monospace; color: var(--t2); font-weight: 600; }
.htbl td:nth-child(2) { font-family: 'JetBrains Mono', monospace; font-weight: 600; }
.htbl td:nth-child(4) { font-family: 'JetBrains Mono', monospace; font-weight: 600; color: var(--tx); }
.bw { background: var(--sf2); border-radius: 4px; height: 7px; width: 90px; overflow: hidden; }
.bf { height: 100%; border-radius: 4px; background: var(--gr); }
.pb { display: inline-block; background: var(--grd); color: var(--gr); border: 1px solid var(--grm); border-radius: 5px; padding: 3px 8px; font-size: 11px; font-weight: 700; font-family: 'JetBrains Mono', monospace; }
.ub { display: inline-block; background: var(--red); color: var(--re); border: 1px solid var(--rem); border-radius: 5px; padding: 3px 8px; font-size: 11px; font-weight: 700; font-family: 'JetBrains Mono', monospace; }

/* ════════════════════════════════════════
   STATS MODAL (Rate Limit Info)
════════════════════════════════════════ */
.stats-bar {
  background: var(--sf2); border: 1px solid var(--br); border-radius: 10px;
  padding: 10px 16px; margin-top: 10px;
  display: flex; align-items: center; flex-wrap: wrap; gap: 14px;
}
.stat-item { display: flex; align-items: center; gap: 6px; font-size: 12px; color: var(--t3); }
.stat-item strong { color: var(--tx); font-family: 'JetBrains Mono', monospace; }
.stat-dot { width: 7px; height: 7px; border-radius: 50%; flex-shrink: 0; }
.dot-g { background: var(--gr); }
.dot-y { background: var(--ye); }
.dot-r { background: var(--re); }

/* ════════════════════════════════════════
   FOOTER
════════════════════════════════════════ */
footer {
  text-align: center; padding: 22px 0 14px; color: var(--t3);
  font-size: 12px; font-family: 'JetBrains Mono', monospace;
  border-top: 1px solid var(--br); margin-top: 32px;
}
footer a { color: var(--gr); }
footer a:hover { text-decoration: underline; }

/* ════════════════════════════════════════
   KEYFRAMES
════════════════════════════════════════ */
@keyframes slideIn { from { opacity: 0; transform: translateY(-7px); } to { opacity: 1; transform: translateY(0); } }
@keyframes bounceIn { 0% { transform: scale(.9); opacity: 0; } 65% { transform: scale(1.02); } 100% { transform: scale(1); opacity: 1; } }
@keyframes fadeUp { from { opacity: 0; transform: translateY(12px); } to { opacity: 1; transform: translateY(0); } }
@keyframes spin { to { transform: rotate(360deg); } }

/* ════════════════════════════════════════
   RESPONSIVE
════════════════════════════════════════ */
@media (max-width: 500px) {
  .search-row { flex-direction: column; }
  .btn-primary, .btn-outline { width: 100%; justify-content: center; }
  .hdr-brand-row { flex-direction: column; align-items: flex-start; }
}
</style>
</head>
<body>
<div class="wrap">

<!-- ═══════════════════════════════
     MAIN HEADER (normal scroll)
═══════════════════════════════ -->
<div class="site-header">

  <!-- Brand + Theme -->
  <div class="hdr-brand-row">
    <div class="hdr-brand">
      <div class="hdr-icon">⚡</div>
      <div>
        <div class="hdr-title">Pakistan <span>Electricity</span> Bill Checker</div>
        <div class="hdr-sub">All 11 DISCOs · PITC Real-time Portal · Free Tool</div>
      </div>
    </div>
    <div class="theme-grp" role="group" aria-label="Theme selector">
      <button class="tbtn" id="tAuto"  onclick="setTheme('auto')">🌓 Auto</button>
      <button class="tbtn" id="tLight" onclick="setTheme('light')">☀️ Light</button>
      <button class="tbtn" id="tDark"  onclick="setTheme('dark')">🌙 Dark</button>
    </div>
  </div>

  <!-- DISCO Selector -->
  <div class="disco-label">Select Your DISCO</div>
  <div class="disco-grid" id="dg"></div>

  <!-- Search -->
  <div class="search-row">
    <input type="text" class="ref-inp" id="refInp"
      placeholder="Enter 14-digit Reference Number…"
      maxlength="20" inputmode="numeric" autocomplete="off" />
    <button class="btn-primary" id="btnGo" onclick="go()">⚡ Check Bill</button>
    <button class="btn-outline" id="btnDup" onclick="openDup()" disabled>🖨 Duplicate</button>
  </div>

  <!-- Auto-detect badge -->
  <div class="det-badge" id="detBadge"></div>

  <!-- Rate limit warning -->
  <div class="rl-warn" id="rlWarn">
    <span>⏳</span>
    <span id="rlMsg">Rate limit reached. Please wait before searching again.</span>
  </div>

  <!-- Usage stats bar -->
  <div class="stats-bar" id="statsBar">
    <div class="stat-item">
      <div class="stat-dot dot-g"></div>
      <span>Searches today: <strong id="statCount">0</strong> / 10</span>
    </div>
    <div class="stat-item">
      <div class="stat-dot dot-y"></div>
      <span>Last search: <strong id="statLast">—</strong></span>
    </div>
    <div class="stat-item">
      <div class="stat-dot dot-g"></div>
      <span>Device ID: <strong id="statDev">—</strong></span>
    </div>
    <div class="stat-item" id="statCoolItem" style="display:none">
      <div class="stat-dot dot-r"></div>
      <span>Cooldown: <strong id="statCool">—</strong></span>
    </div>
  </div>

</div>
<!-- /site-header -->

<!-- ═══════════════════════════════
     PAGE CONTENT
═══════════════════════════════ -->

<!-- PROFESSOR Banner -->
<div class="banner proj-ban">
  <div class="ban-info">
    <div class="bico bico-sq bico-g">🌐</div>
    <div class="btx">
      <strong>PROFESSOR — Tech Projects &amp; Tools</strong>
      <span>Developer tools and projects at professor-toolkit.work.gd</span>
    </div>
  </div>
  <a href="professor-toolkit.work.gd" target="_blank" rel="noopener" class="btn-sm btn-g">🚀 Visit PROFESSOR</a>
</div>

<!-- WhatsApp Persistent -->
<div class="banner wa-ban">
  <div class="ban-info">
    <div class="bico bico-wp">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="#fff"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/></svg>
    </div>
    <div class="btx">
      <strong>Join Our WhatsApp Channel</strong>
      <span>Bill alerts, due-date reminders &amp; electricity tips — Free</span>
    </div>
  </div>
  <a href="https://whatsapp.com/channel/0029Vb6icbzLo4hisnuo9G3X" target="_blank" rel="noopener" class="btn-sm btn-wp">
    <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/></svg>
    Join Channel
  </a>
</div>

<!-- Error -->
<div class="errbox" id="errbox"><span>⚠️</span><span id="errmsg"></span></div>

<!-- Loading -->
<div class="loading" id="loading">
  <div class="spinner"></div>
  <div class="loading-txt">Fetching bill data from PITC…</div>
</div>

<!-- WA Post nudge -->
<div class="banner wa-ban wa-post" id="waPost">
  <div class="ban-info">
    <div class="bico bico-wp">🔔</div>
    <div class="btx">
      <strong>Bill found! Never miss a due date.</strong>
      <span>Join our WhatsApp channel for automatic reminders</span>
    </div>
  </div>
  <a href="https://whatsapp.com/channel/0029Vb6icbzLo4hisnuo9G3X" target="_blank" rel="noopener" class="btn-sm btn-wp">
    <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/></svg>
    Join Now 🔔
  </a>
</div>

<!-- Results -->
<div id="res"></div>

<footer>
  Pakistan Electricity Bill Checker &nbsp;·&nbsp; All 11 DISCOs &nbsp;·&nbsp;
  Powered by <a href="https://bill.pitc.com.pk" target="_blank" rel="noopener">PITC</a> &nbsp;·&nbsp;
  <a href="professor-toolkit.work.gd" target="_blank" rel="noopener">PROFESSOR</a> &nbsp;·&nbsp;
  <a href="https://whatsapp.com/channel/0029Vb6icbzLo4hisnuo9G3X" target="_blank" rel="noopener">WhatsApp Channel</a>
</footer>
</div><!-- /wrap -->

<script>
/* ══════════════════════════════════════════════════════
   THEME
══════════════════════════════════════════════════════ */
function setTheme(t) {
  document.documentElement.setAttribute('data-theme', t);
  localStorage.setItem('pbill-theme', t);
  ['Auto','Light','Dark'].forEach(x => document.getElementById('t'+x).classList.remove('on'));
  document.getElementById('t' + t[0].toUpperCase() + t.slice(1)).classList.add('on');
}
setTheme(localStorage.getItem('pbill-theme') || 'auto');

/* ══════════════════════════════════════════════════════
   RATE LIMITER — device fingerprint + localStorage
   Rules:
     • Max 10 searches per day per device
     • Min 8 seconds between searches (cooldown)
     • Duplicate ref: 30 second block (cache reuse)
     • Shows countdown timer during cooldown
══════════════════════════════════════════════════════ */
const RL = {
  MAX_PER_DAY: 10,
  COOLDOWN_MS: 8000,        // 8s between any searches
  DUP_BLOCK_MS: 30000,      // 30s block on same ref repeated
  STORAGE_KEY: 'pbill_rl',

  // Generate or load stable device fingerprint
  getDeviceId() {
    let id = localStorage.getItem('pbill_devid');
    if (!id) {
      const rnd = Math.random().toString(36).slice(2, 10);
      const ts  = Date.now().toString(36).slice(-4);
      const nav = (navigator.userAgent.length + screen.width + screen.height).toString(36);
      id = (rnd + ts + nav).slice(0, 12).toUpperCase();
      localStorage.setItem('pbill_devid', id);
    }
    return id;
  },

  load() {
    try {
      const raw = localStorage.getItem(this.STORAGE_KEY);
      const data = raw ? JSON.parse(raw) : {};
      // Reset count if it's a new calendar day
      const today = new Date().toDateString();
      if (data.date !== today) {
        data.date = today;
        data.count = 0;
        data.searches = [];
      }
      return data;
    } catch { return { date: new Date().toDateString(), count: 0, searches: [] }; }
  },

  save(data) {
    try { localStorage.setItem(this.STORAGE_KEY, JSON.stringify(data)); } catch {}
  },

  // Returns null if ok, or error message string
  check(refNo) {
    const data = this.load();
    const now = Date.now();

    // Daily limit
    if (data.count >= this.MAX_PER_DAY) {
      return `Daily limit reached (${this.MAX_PER_DAY} searches/day). Resets at midnight.`;
    }

    // Cooldown between searches
    if (data.lastSearch && (now - data.lastSearch) < this.COOLDOWN_MS) {
      const wait = Math.ceil((this.COOLDOWN_MS - (now - data.lastSearch)) / 1000);
      return `Please wait ${wait}s before searching again.`;
    }

    // Same reference number block
    if (data.lastRef === refNo && data.lastSearch && (now - data.lastSearch) < this.DUP_BLOCK_MS) {
      const wait = Math.ceil((this.DUP_BLOCK_MS - (now - data.lastSearch)) / 1000);
      return `Same reference searched recently. Wait ${wait}s or scroll down to see cached result.`;
    }

    return null; // OK
  },

  record(refNo) {
    const data = this.load();
    data.count = (data.count || 0) + 1;
    data.lastSearch = Date.now();
    data.lastRef = refNo;
    data.searches = [...(data.searches || []), { ref: refNo, time: new Date().toISOString() }].slice(-50);
    this.save(data);
  },

  getStats() {
    const data = this.load();
    return {
      count: data.count || 0,
      lastSearch: data.lastSearch ? new Date(data.lastSearch).toLocaleTimeString('en-PK', {hour:'2-digit',minute:'2-digit'}) : '—',
      deviceId: this.getDeviceId(),
      remaining: Math.max(0, this.MAX_PER_DAY - (data.count || 0)),
    };
  }
};

// Cooldown countdown ticker
let cooldownTimer = null;
function startCooldownTick(ms) {
  clearInterval(cooldownTimer);
  const end = Date.now() + ms;
  const item = document.getElementById('statCoolItem');
  const txt  = document.getElementById('statCool');
  item.style.display = 'flex';
  cooldownTimer = setInterval(() => {
    const left = Math.max(0, Math.ceil((end - Date.now()) / 1000));
    txt.textContent = left + 's';
    if (left <= 0) {
      clearInterval(cooldownTimer);
      item.style.display = 'none';
      document.getElementById('rlWarn').classList.remove('show');
      updateStats();
    }
  }, 500);
}

function updateStats() {
  const s = RL.getStats();
  document.getElementById('statCount').textContent = s.count + ' / ' + RL.MAX_PER_DAY;
  document.getElementById('statLast').textContent = s.lastSearch;
  document.getElementById('statDev').textContent = s.deviceId;
  // Color count based on usage
  const el = document.getElementById('statCount');
  if (s.count >= RL.MAX_PER_DAY) { el.style.color = 'var(--re)'; }
  else if (s.count >= 7) { el.style.color = 'var(--ye)'; }
  else { el.style.color = 'var(--gr)'; }
}

/* ══════════════════════════════════════════════════════
   DISCOS
══════════════════════════════════════════════════════ */
const DISCOS = [
  { k:'MEPCO',  n:'Multan',     px:['131','132','133','134','135','136','137','138'], dp:'mepcobill' },
  { k:'LESCO',  n:'Lahore',     px:['010','011','012','013','014','015','016','017','018','019'], dp:'lescobill' },
  { k:'GEPCO',  n:'Gujranwala', px:['040','041','042','043','044','045','046','047'], dp:'gepcobill' },
  { k:'FESCO',  n:'Faisalabad', px:['070','071','072','073','074','075','076','077'], dp:'fescobill' },
  { k:'IESCO',  n:'Islamabad',  px:['050','051','052','053','054','055'], dp:'iescobill' },
  { k:'PESCO',  n:'Peshawar',   px:['100','101','102','103','104','105'], dp:'pescobill' },
  { k:'HAZECO', n:'Hazara',     px:['110','111','112','113'], dp:'hazecoebill' },
  { k:'HESCO',  n:'Hyderabad',  px:['160','161','162','163','164','165'], dp:'hescobill' },
  { k:'SEPCO',  n:'Sukkur',     px:['170','171','172','173'], dp:'sepcobill' },
  { k:'QESCO',  n:'Quetta',     px:['190','191','192','193','194'], dp:'qescobill' },
  { k:'TESCO',  n:'Tribal',     px:['120','121','122'], dp:'tescobill' },
];
const PM = {};
DISCOS.forEach(d => d.px.forEach(p => PM[p] = d));
let sel = null, curRef = '';

(function() {
  const g = document.getElementById('dg');
  DISCOS.forEach(d => {
    const b = document.createElement('div');
    b.className = 'dbtn'; b.id = 'disco-' + d.k;
    b.innerHTML = `<span class="dk">${d.k}</span><span class="dn">${d.n}</span>`;
    b.onclick = () => pick(d.k);
    g.appendChild(b);
  });
  updateStats();
})();

function pick(k) {
  sel = DISCOS.find(d => d.k === k) || null;
  document.querySelectorAll('.dbtn').forEach(b => b.classList.remove('on'));
  if (sel) document.getElementById('disco-' + k)?.classList.add('on');
}

document.getElementById('refInp').addEventListener('input', function() {
  const v = this.value.trim().replace(/\s/g, '');
  const badge = document.getElementById('detBadge');
  if (v.length >= 3) {
    const d = PM[v.substring(0, 3)];
    if (d) {
      badge.textContent = `⚡ Auto-detected: ${d.k} — ${d.n}`;
      badge.classList.add('show');
      pick(d.k);
    } else {
      badge.classList.remove('show');
    }
  } else {
    badge.classList.remove('show');
  }
});

document.getElementById('refInp').addEventListener('keydown', e => {
  if (e.key === 'Enter') go();
});

function openDup() {
  if (!curRef || !sel) return;
  window.open(`https://bill.pitc.com.pk/${sel.dp}/general?refno=${curRef}`, '_blank');
}

/* ══════════════════════════════════════════════════════
   FETCH + RATE LIMIT ENFORCEMENT
══════════════════════════════════════════════════════ */
function showErr(m) {
  document.getElementById('errmsg').innerHTML = m;
  document.getElementById('errbox').classList.add('on');
}
function hideErr() { document.getElementById('errbox').classList.remove('on'); }

function setLoad(v) {
  document.getElementById('loading').classList.toggle('on', v);
  document.getElementById('btnGo').disabled = v;
  document.getElementById('btnGo').textContent = v ? '⏳ Fetching…' : '⚡ Check Bill';
}

async function go() {
  const refNo = document.getElementById('refInp').value.trim().replace(/\s/g, '');

  if (!refNo || refNo.length < 10) {
    showErr('Please enter a valid reference number (at least 10 digits).');
    return;
  }

  // ── Rate limit check ──
  const rlErr = RL.check(refNo);
  if (rlErr) {
    document.getElementById('rlMsg').textContent = rlErr;
    document.getElementById('rlWarn').classList.add('show');
    // Start countdown if it's a cooldown message
    const waitMatch = rlErr.match(/Wait (\d+)s/);
    if (waitMatch) startCooldownTick(parseInt(waitMatch[1]) * 1000);
    return;
  }
  document.getElementById('rlWarn').classList.remove('show');

  // ── DISCO detection ──
  if (!sel) {
    const d = PM[refNo.substring(0, 3)];
    if (d) pick(d.k);
    else {
      showErr('Could not detect DISCO. Please tap your DISCO button above.');
      return;
    }
  }

  hideErr();
  document.getElementById('res').classList.remove('on');
  document.getElementById('res').innerHTML = '';
  document.getElementById('btnDup').disabled = true;
  document.getElementById('waPost').classList.remove('show');
  setLoad(true);

  try {
    const resp = await fetch('https://bill.pitc.com.pk/bill/info', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': 'Dalvik/2.1.0 (Linux; U; Android 11; Pixel 4 Build/RD2A.211001.002)'
      },
      body: JSON.stringify({
        refNo,
        secret_token: 'token_4rpak_security',
        app_name: 'RoshanPakistan'
      })
    });

    if (!resp.ok) throw new Error(`Server error ${resp.status}. Try again shortly.`);
    const data = await resp.json();
    if (!data?.status || !data?.basicInfo)
      throw new Error(data?.error || 'No bill data found for this reference number.');

    // Record successful search
    RL.record(refNo);
    updateStats();
    startCooldownTick(RL.COOLDOWN_MS);

    curRef = refNo;
    document.getElementById('btnDup').disabled = false;
    document.getElementById('waPost').classList.add('show');
    render(data);

  } catch (err) {
    const m = err.message || '';
    if (m.includes('Failed to fetch') || m.includes('NetworkError') || m.toLowerCase().includes('cors')) {
      showErr(`Browser blocked the request (CORS restriction).<br>
        <strong>Solution:</strong> Open this page on your phone's Chrome browser, or use the
        <a href="https://play.google.com/store/apps/details?id=pitc.com.smartptw.onewindowapp" target="_blank">Roshan Pakistan app</a>.`);
    } else {
      showErr(m || 'Network error. Check your connection and try again.');
    }
  } finally {
    setLoad(false);
  }
}

/* ══════════════════════════════════════════════════════
   HELPERS
══════════════════════════════════════════════════════ */
const DASH = '<span style="color:var(--t3)">—</span>';

function esc(v) {
  return String(v ?? '').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
}
function fv(v) {
  const s = String(v ?? '').trim();
  return s ? esc(s) : DASH;
}
function fRs(v) {
  if (v === null || v === undefined || v === '' || v === 0 || v === '0') return DASH;
  const n = parseFloat(v);
  if (isNaN(n) || n === 0) return DASH;
  if (n < 0) return `<span class="iv r">−Rs.${Math.abs(n).toLocaleString()}</span>`;
  return `Rs.${n.toLocaleString()}`;
}
function fDate(d) {
  if (!d) return '—';
  const dt = new Date(d);
  return isNaN(dt.getTime()) ? esc(String(d)) : dt.toLocaleDateString('en-PK', { day:'2-digit', month:'short', year:'numeric' });
}

/* ══════════════════════════════════════════════════════
   RENDER
══════════════════════════════════════════════════════ */
function render(data) {
  const b  = data.basicInfo;
  const h  = data.histInfo || {};
  const ms = data.metersInfo || [];

  const dueDate   = b.billDueDate ? new Date(b.billDueDate) : null;
  const isOverdue = dueDate && new Date() > dueDate;
  const netBill   = parseInt(b.netBill || 0) || 0;
  const lps       = parseInt(b.LatePaymentSurcharge || 0) || 0;

  // History newest first
  let maxU = 1;
  for (let i = 1; i <= 13; i++) {
    const u = parseFloat(h[`gbHistUnits${i}`] || 0);
    if (u > maxU) maxU = u;
  }
  const rows = [];
  for (let i = 13; i >= 1; i--) {
    const mm = h[`gbHistMM${i}`]; if (!mm) continue;
    const un = parseInt(h[`gbHistUnits${i}`] || 0);
    const bl = parseInt(h[`gbHistAssment${i}`] || 0);
    const pd = parseInt(h[`payment${i}`] || 0);
    rows.push({ mm, un, bl, pd, isPaid: pd > 0, pct: maxU > 0 ? (un / maxU * 100).toFixed(1) : 0 });
  }

  const dupUrl = `https://bill.pitc.com.pk/${sel.dp}/general?refno=${curRef}`;

  document.getElementById('res').innerHTML = `

  <div class="bhead">
    <div>
      <div class="cname">${esc((b.consumerName||'').trim())}</div>
      <div class="cfn">${esc((b.consumerFName||'').trim())}</div>
      <div class="cadr">${esc((b.consumerAddress1||'').trim())}${b.consumerAddress2 ? ', ' + esc((b.consumerAddress2||'').trim()) : ''}</div>
      <div class="tags">
        <span class="tag b">⚡ ${sel.k}</span>
        <span class="tag g">✔ ${esc(b.cons_cat || 'DOMESTIC')}</span>
        <span class="tag">${esc(b.tariffDescription || '')}</span>
        <span class="tag" style="font-size:9px">${esc((b.refNo||'').trim())}</span>
        ${b.divName  ? `<span class="tag">${esc(b.divName)}</span>` : ''}
        ${b.sactionLoad ? `<span class="tag">Load: ${esc(b.sactionLoad)} KW</span>` : ''}
        ${b.phase ? `<span class="tag">Phase: ${esc(b.phase)}</span>` : ''}
      </div>
    </div>
    <div class="ablock">
      <div class="albl">Amount Payable</div>
      <div class="aval">${netBill.toLocaleString()} <span class="aunit">Rs.</span></div>
      ${dueDate ? `<div class="duelbl">Due: ${fDate(b.billDueDate)}</div>` : ''}
      ${lps > 0 ? `<div class="afterd">After due date: <strong>Rs.${(netBill+lps).toLocaleString()}</strong></div>` : ''}
      <div><span class="${isOverdue ? 'bover' : 'bpaid'}">${isOverdue ? '⚠ OVERDUE' : '✔ CURRENT'}</span></div>
    </div>
  </div>

  <div class="dupcard">
    <div class="dupinfo">
      <strong>🖨 Download Duplicate Bill</strong>
      <span>${sel.k} &nbsp;·&nbsp; Ref: ${curRef}</span>
    </div>
    <a class="btn-sm btn-g" href="${dupUrl}" target="_blank" rel="noopener">Open PDF Bill</a>
  </div>

  <div class="slbl">Bill Details</div>
  <div class="g2">
    <div class="card">
      <div class="cttl">📋 Connection Info</div>
      <div class="ir"><span class="ik">Bill Month</span><span class="iv g">${fDate(b.billMonth)}</span></div>
      <div class="ir"><span class="ik">Read Date</span><span class="iv">${fv(b.meterReadDate)}</span></div>
      <div class="ir"><span class="ik">Application No</span><span class="iv">${fv(b.appNo)}</span></div>
      <div class="ir"><span class="ik">Feeder</span><span class="iv">${fv(b.feederName)}</span></div>
      <div class="ir"><span class="ik">Division</span><span class="iv">${fv(b.divName)}</span></div>
      <div class="ir"><span class="ik">Sub-Division</span><span class="iv">${fv(b.subDivName)}</span></div>
      <div class="ir"><span class="ik">Units Consumed</span><span class="iv g">${fv(b.totCurCons)} kWh</span></div>
      <div class="ir"><span class="ik">Tariff</span><span class="iv">${fv(b.tariffDescription)}</span></div>
      ${b.sactionLoad ? `<div class="ir"><span class="ik">Sanctioned Load</span><span class="iv">${fv(b.sactionLoad)} KW</span></div>` : ''}
    </div>
    <div class="card">
      <div class="cttl">💳 Payment Status</div>
      <div class="ir"><span class="ik">Net Bill</span><span class="iv g">Rs.${netBill.toLocaleString()}</span></div>
      <div class="ir"><span class="ik">Late Surcharge</span><span class="iv r">${fRs(b.LatePaymentSurcharge)}</span></div>
      <div class="ir"><span class="ik">After Due Date</span><span class="iv y">Rs.${(netBill+lps).toLocaleString()}</span></div>
      <div class="ir"><span class="ik">Due Date</span><span class="iv ${isOverdue ? 'r' : ''}">${fDate(b.billDueDate)}</span></div>
      <div class="ir"><span class="ik">Relief Due Date</span><span class="iv">${fv(b.reliefDueDate)}</span></div>
      <div class="ir"><span class="ik">Arrears</span><span class="iv">${b.arrear ? fRs(b.arrear) : DASH}</span></div>
      <div class="ir"><span class="ik">Total FPA</span><span class="iv">${fRs(b.totalFpa)}</span></div>
      <div class="ir"><span class="ik">Issue Date</span><span class="iv">${fDate(b.issue_date)}</span></div>
    </div>
  </div>

  <div class="ccard">
    <div class="cttl">🔢 Charges Breakdown</div>
    <div class="cgrid">
      <div class="ccol">
        <div class="cct">Company Charges</div>
        <div class="ir"><span class="ik">Energy Charges</span><span class="iv">${fRs(b.companyCharges?.energyCharges)}</span></div>
        <div class="ir"><span class="ik">Fixed Charges</span><span class="iv">${fRs(b.companyCharges?.fixedCharges)}</span></div>
        <div class="ir"><span class="ik">Meter Rent</span><span class="iv">${fRs(b.companyCharges?.meterRent)}</span></div>
        <div class="ir"><span class="ik">Variable FPA</span><span class="iv">${fRs(b.companyCharges?.varFPA)}</span></div>
        <div class="ir"><span class="ik">Qtr Tariff Adj.</span><span class="iv">${fRs(b.companyCharges?.qtrTariffAdjustments)}</span></div>
        <div class="ir"><span class="ik">Service Rent</span><span class="iv">${fRs(b.companyCharges?.serviceRent)}</span></div>
        ${b.billCalc ? `<div class="ir"><span class="ik">Calculation</span><span class="iv" style="font-size:11px">${esc(b.billCalc.trim())}</span></div>` : ''}
      </div>
      <div class="ccol">
        <div class="cct">Government Taxes</div>
        <div class="ir"><span class="ik">GST (18%)</span><span class="iv">${fRs(b.govtCharges?.gst)}</span></div>
        <div class="ir"><span class="ik">Electricity Duty</span><span class="iv">${fRs(b.govtCharges?.electricityDuty)}</span></div>
        <div class="ir"><span class="ik">FC Surcharge</span><span class="iv">${fRs(b.govtCharges?.fcSurcharge)}</span></div>
        <div class="ir"><span class="ik">Income Tax</span><span class="iv">${fRs(b.govtCharges?.incomeTax)}</span></div>
        <div class="ir"><span class="ik">PTV Fee</span><span class="iv">${fRs(b.govtCharges?.ptvFee)}</span></div>
        <div class="ir"><span class="ik">Further Tax</span><span class="iv">${fRs(b.govtCharges?.furtherTax)}</span></div>
        <div class="ir"><span class="ik">GST on FPA</span><span class="iv">${fRs(b.govtCharges?.gstFpa)}</span></div>
        <div class="ir"><span class="ik">TR Surcharge</span><span class="iv">${fRs(b.govtCharges?.trSurcharge)}</span></div>
        <div class="ir"><span class="ik">NJ Surcharge</span><span class="iv">${fRs(b.govtCharges?.neelamJehlamSurcharge)}</span></div>
      </div>
    </div>
  </div>

  ${ms.length ? `
  <div class="mcard">
    <div class="cttl">🔌 Meter Reading — ${esc(ms[0].mtrNo || '')}</div>
    <div class="mstats">
      <div class="mst"><div class="mslbl">Previous Read</div><div class="msval">${(ms[0].mtrKwhPrvRead || 0).toLocaleString()}</div></div>
      <div class="mst"><div class="mslbl">Present Read</div><div class="msval">${(ms[0].mtrKwhPrsRead || 0).toLocaleString()}</div></div>
      <div class="mst"><div class="mslbl">Consumed</div><div class="msval" style="color:var(--ye)">${(ms[0].mtrKwhConsump || 0).toLocaleString()}</div></div>
      <div class="mst"><div class="mslbl">Multiplier</div><div class="msval">${ms[0].mtrKwhMF || 1}</div></div>
    </div>
  </div>` : ''}

  <div class="slbl">13-Month Payment History</div>
  <div class="hcard">
    <table class="htbl">
      <thead>
        <tr>
          <th>Month</th>
          <th>Units (kWh)</th>
          <th>Usage</th>
          <th>Billed (Rs)</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        ${rows.map(r => `<tr>
          <td>${esc(r.mm)}</td>
          <td>${r.un.toLocaleString()}</td>
          <td><div class="bw"><div class="bf" style="width:${r.pct}%"></div></div></td>
          <td>${r.bl.toLocaleString()}</td>
          <td><span class="${r.isPaid ? 'pb' : 'ub'}">${r.isPaid ? '✔ PAID' : '✗ UNPAID'}</span></td>
        </tr>`).join('')}
      </tbody>
    </table>
  </div>
  `;

  const el = document.getElementById('res');
  el.classList.add('on');
  setTimeout(() => el.scrollIntoView({ behavior: 'smooth', block: 'start' }), 60);
}
</script>
</body>
</html>
