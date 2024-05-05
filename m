Return-Path: <linux-kernel+bounces-168998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5008BC0BB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 16:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA8D1F214CC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E54F22611;
	Sun,  5 May 2024 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="hceOVzgY"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4BD1D556;
	Sun,  5 May 2024 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714918766; cv=none; b=mLd15musCrNd9cdEjHyxrLbg7Xc8Fyv2idVc7N3alyDqQ+mba9dK17wOILtks5uP9BTKzCYf4skiMUOOAJcyR136PT+135wdaD+EhXCItumQNdwcdTee6rSAfRCO2jjSzy85azYhH8sW0mL2ZOkRiJeKEtl40oaoL7RmP4Hk05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714918766; c=relaxed/simple;
	bh=SAEvmIotPqAqP4XLvKSosMOSjs06S7YIf9CueJAwTVg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Knwo3+hP3WYL/XsyUQ1jYPk9lnBT8XTcrPbgvg0fyHP5D47g3eQf4QuO+ZJJ//qgAlIag6clskDm6+2HgPMFrN2/ATfMUt2aDQW/KxJO4+6R7v4t9ZjdQ9FJyccGLUb3KETDS8Ij+ZR3hmVOpA9GfnyzqymoFxTFT3ZW39NA1iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=hceOVzgY; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+/NerHMiR0+A8pDjbV6sBaybhDSjwYhNFbikAGqXas0=; t=1714918764; x=1715350764;
	 b=hceOVzgYchIzYS3Qpfq0lXOAXF6pkk4eDfB1hniK2TIrNiOjm0F01ChItscycqFd7e5jXHFTrK
	nwD/RoBH+5eEc4PGDB5QfxLslrLbbYXoXcLP2b30KiFcm4EpiFcspKhrYYg2Bj3Znu+BjYUYqcuC2
	LdYBVYcTNoEDt2INB0Ef4/6gU9TzSrTOM8uK5lumvtIm89IwCUtqPKNI0CDYPX+C+ynS9QCzWZrQQ
	2JPk6l/KmF4HDcZVrCBaE/ObfhSpFjYTdOUOBnew3PxMjLvIeBZsfWVkAjCb1IPVAoVwHJr1Z7B7f
	mhlUekNR+3xORFlpnDDEmpRuMAO5RXYmGqO0w==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1s3ci2-0002mt-2S; Sun, 05 May 2024 16:19:22 +0200
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-05-05]
Date: Sun,  5 May 2024 14:19:19 +0000
Message-ID: <171491873337.1284823.18146984489788770141@leemhuis.info>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714918764;e4034975;
X-HE-SMSGID: 1s3ci2-0002mt-2S

Hi Linus, here is the weekly report for regressions introduced during
this cycle. Most issues are either brand new, being worked on or likely
to be fixed during the next week. The latter might be the case for one
issue I want to highlight nevertheless:

* Ben Greear more than a month ago reported a reproducible hang during
startup and bisected it to the main merge window LED merge[1]. Ben
recently even submitted a iwlwifi patch to work around the underlying
problem[2]. But real debugging and patch review are making slow progress
afaics, so I'm not really sure if the issue will be resolved somehow
before 6.9 is out, which is why I wanted to quickly mention it.

Side note: I wonder if this issue is related to some other interactions
problems between the LED and net code that were fixed this cycle[3], but
Johannes thinks that is unlikely.

[1] https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/
and https://lore.kernel.org/lkml/89a9eec3-337f-3c9f-6bbe-00a26a15287c@candelatech.com/
[2] https://lore.kernel.org/all/20240424174748.957641-1-greearb@candelatech.com/
and https://lore.kernel.org/all/20240430234212.2132958-1-greearb@candelatech.com/
[3] 19fa4f2a85d777 ("r8169: fix LED-related deadlock on module removal") [v6.9-rc4]
and c04d1b9ecce565 ("igc: Fix LED-related deadlock on driver unbind") [v6.9-rc6]


* FWIW, my plan was to bring up the -next regression fix
6677196fb1932e ("clk: qcom: gdsc: treat optional supplies as optional")
[next-20240404 (pending-fixes)] here too, which after more than a month
in -next is still not mainlined. But Stephen sent a PR on Friday[1], so
that might be resolved already when you see this mail.
[1] https://lore.kernel.org/all/20240504030607.999295-1-sboyd@kernel.org/

Ciao, Thorsten


---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 9 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.8.. aka v6.9-rc), culprit identified
======================================================


leds: hangs on boot
-------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/
https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/

By Ben Greear; 32 days ago; 21 activities, latest 0 days ago.
Introduced in f5c31bcf604d (v6.9-rc1)

Fix incoming:
* wifi: iwlwifi: Use request_module_nowait
  https://lore.kernel.org/regressions/645d2dd8-3c85-4da6-a391-7394af417c6c@leemhuis.info/


[ *NEW* ] kbuild: deb-pkg and bindeb-pkg: build failure (and slowness, too)
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZjcRPelwZP34N42s@gmail.com/
https://lore.kernel.org/lkml/ZjcRPelwZP34N42s@gmail.com/

By Ingo Molnar; 0 days ago; 5 activities, latest 0 days ago.
Introduced in 1d7bae8f8c85 (v6.9-rc1)

Recent activities from: Ingo Molnar (4), Masahiro Yamada (1)


[ *NEW* ] drm/qxl: deadlock after a revert to fix a regression
--------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240502081641.457aa25f@gandalf.local.home/
https://lore.kernel.org/lkml/20240502081641.457aa25f@gandalf.local.home/

By Steven Rostedt; 3 days ago; 3 activities, latest 1 days ago.
Introduced in 07ed11afb68d (v6.9-rc4)

Recent activities from: Steven Rostedt (3)


btrfs: snapper fails
--------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/generic/https://github.com/openSUSE/snapper/issues/894/
https://github.com/openSUSE/snapper/issues/894

By Linux regression tracking (Thorsten Leemhuis); 14 days ago; 7 activities, latest 2 days ago.
Introduced in 86211eea8ae1 (v6.9-rc1)

Fix incoming:
* btrfs: qgroup: do not check qgroup inherit if qgroup is disabled
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=e7ee6564f44c45d8e0a1eac1452b988ada5bf08d


x86/topology: system stopped booting
------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com/
https://lore.kernel.org/lkml/3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com/

By Lyude Paul; 17 days ago; 13 activities, latest 3 days ago.
Introduced in f0551af02130 (v6.9-rc1)

Fix incoming:
* x86/topology: Deal with more broken ACPI tables
  https://lore.kernel.org/regressions/c2786db1-a8c9-4323-832e-cffd8373bf68@leemhuis.info/


net: Bluetooth: firmware loading problems with older firmware
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240401144424.1714-1-mike@fireburn.co.uk/
https://lore.kernel.org/lkml/20240401144424.1714-1-mike@fireburn.co.uk/

By Mike Lothian; 33 days ago; 9 activities, latest 3 days ago.
Introduced in 1cb63d80fff6 (v6.9-rc1)

Fix incoming:
* Bluetooth: btusb: Fix the patch for MT7920 the affected to MT7921
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=29e16b778480453fa4a31b53e3574100e9b46aa0


clk: qcom: gdsc: lockdep splat
------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/
https://lore.kernel.org/lkml/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/

By Johan Hovold; 43 days ago; 15 activities, latest 12 days ago.
Introduced in 9187ebb954ab (v6.9-rc1)

Fix incoming:
* clk: qcom: gdsc: treat optional supplies as optional
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=6677196fb1932e60b88ad0794a7ae532df178654


===================================================
current cycle (v6.8.. aka v6.9-rc), unknown culprit
===================================================


Ryzen 7840HS CPU single core never boosts to max frequency
----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218759/
https://bugzilla.kernel.org/show_bug.cgi?id=218759

By Gaha; 13 days ago; 19 activities, latest 2 days ago.
Introduced in v6.8..v6.9-rc5

Recent activities from: The Linux kernel's regression tracker (Thorsten
  Leemhuis) (2), Mario Limonciello (AMD) (1)


net: Beaglebone Ethernet Probe Failure In 6.8+
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zh/tyozk1n0cFv+l@euler/
https://lore.kernel.org/netdev/Zh%2Ftyozk1n0cFv%2Bl@euler/

By Colin Foster; 17 days ago; 8 activities, latest 6 days ago.
Introduced in v6.8..v6.9-rc5

Recent activities from: Andrew Lunn (1), Colin Foster (1)

One patch associated with this regression:
* Re: Beaglebone Ethernet Probe Failure In 6.8+
  https://lore.kernel.org/netdev/Zicyc0pj3g7%2FMemK@euler/
  12 days ago, by Colin Foster


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/171429421714.587108.18297293641257286341@leemhuis.info

Thanks for your attention, have a nice day!

  Regzbot, your hard working Linux kernel regression tracking robot


P.S.: Wanna know more about regzbot or how to use it to track regressions
for your subsystem? Then check out the getting started guide or the
reference documentation:

https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The short version: if you see a regression report you want to see
tracked, just send a reply to the report where you Cc
regressions@lists.linux.dev with a line like this:

#regzbot introduced: v5.13..v5.14-rc1

If you want to fix a tracked regression, just do what is expected
anyway: add a 'Link:' tag with the url to the report, e.g.:

Link: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/

