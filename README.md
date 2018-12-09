---


---

<h1 id="SUBXsetup">SUBX Masternode Setup Script</h1>
<p>Easy daemon setup for SUBX masternode for fresh VPS installation<br>
this tool is very simple that can handle library for SUBX coin daemon, compile the daemon and prepare data directory each SUBXMN<br>
and create file <a href="http://runmn.sh">runmn.sh</a></p>
<h2 id="todo">TODO</h2>
<ul>
<li>open file <a href="http://subx_setup.sh">subx_setup.sh</a>, change max=NUMBER_YOUR_MN</li>
<li>UPLOAD <a href="http://subx_setup.sh">subx_setup.sh</a> and <a href="http://setswapfile.sh">setswapfile.sh</a> to your VPS using winscp on your $HOME directory</li>
<li>run setswapfile: <code>sh ./setswapfile.sh</code></li>
<li>Begin SUBX daemon installation: <code>sh ./subx_setup.sh</code></li>
<li>open subx.conf on your vps (default ~/.subxmn1; ~/.subxmn2; ~/.subxmnxmax) paste your generated genkey to masternodeprivkey=YOUR_GENKEY</li>
<li>call <a href="http://runmn.sh">runmn.sh</a>: <code>sh ./runmn.sh</code></li>
<li>Enjoy</li>
</ul>
<p><strong>tested on ubuntu server 16.04 on virtual box</strong><br>
<strong>please make sure each daemon have different masternodeprivkey copied from your local masternode.conf</strong><br>
<strong>always open your local wallet, this is a must to run cold wallet masternode.</strong><br>
HAPPY MASTERNODING!!</p>

