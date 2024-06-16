Return-Path: <linux-kernel+bounces-216358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9185909E6E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828BA281718
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 16:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9DA1B27D;
	Sun, 16 Jun 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="J2BUGppU"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7728199A2;
	Sun, 16 Jun 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554200; cv=none; b=S9oMIBl4CIjrDAZhpJsdNanDAeYeUuxU/dnnm5V3ySO982K2CC7SzKVhtFzZvY394vHXNTRczL8am0jbGrGy3Bun5hnUTdxojKdLoPb0wKuIqWfs6GIZcLxOl0XhMYO9Nj83VYMJAOgmE9ynL2+Dt8QJSpQgyhTvks46QRKbEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554200; c=relaxed/simple;
	bh=RhJ533r6kgi+8DTVEq0FIqkrDIs38xzZJ3kVgRCG9Ow=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cUnsmltKfQlz2oW7ktKi+9citiCbJCxPikgAkVSsyI6QWOTN1lrPXrC5g43FosAb8YZ3AlbxD7/fNvhey1KHGlkyfxELZJGdos76DGlBIqGFmDru4W1bWQshhsrVl0vt7zsObBdoJ25taKKDKHQP8Y2cKljc3Ja2WYvAmzEFpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=J2BUGppU; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TDDyDhE1w7vzxPPqh7gNhOtr9tJB0Ni/nLxytuTtMZ8=; t=1718554197; x=1718986197;
	 b=J2BUGppUMW/qHrwhAOWba2dnXHX432CmoVg+l63eVhKnbnUCr0TMHzxYm2MGWVsGE6aRSn8ZNs
	43f+2EF6O8+decMIpk7cEDBxhwyTe3VZzDoHttCPxP7cFk/oFVa3lfCvIkKkNVbKI0NhRI9twzsuG
	Cyu0bJejSDxMuYC+D8cvjn2pWfBM4WdySRxO1NgzTcAs2s10NWiHaaDvimvLe0mBvCjq3h0ciwYFh
	W41uoNxg9JB5U7SCty/E1IcmcMAFvJ1INLJaZC4s3xuj+DuD/SMl85UMftd5j3/MeTjXOqng1Vf45
	hqmDXBIy8y2OlGNNxuVet99eyvwkqbTbLkmqQ==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1sIsRx-0004vz-Ol; Sun, 16 Jun 2024 18:09:49 +0200
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-06-16]
Date: Sun, 16 Jun 2024 16:09:48 +0000
Message-ID: <171855416884.750783.12465497601688065358@leemhuis.info>
X-Mailer: git-send-email 2.45.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718554197;0875d270;
X-HE-SMSGID: 1sIsRx-0004vz-Ol

Hi Linus, find below the weekly report for regressions introduced
during this cycle. Let me quickly mention two things (one from the last
cycle):

* The issue I wrote to you about earlier today already: the net/led AB-BA deadlock
that was introduced in the 6.9 cycle that annoys a few people. Hans
provided a revert (that was ACKed) and would like you to pick it up
directly:
https://lore.kernel.org/all/20240607101847.23037-1-hdegoede@redhat.com/

* Still not much progress has been made regarding the regression I
mentioned last week that is caused by 6.10 commit 868ff5f4944a ("net:
dsa: mt7530-mdio: read PHY address of switch from device tree") and now
known for a month. It broke the detection of the mt7531 switch on
Bananapi-R64. There are two arm64 dts patches around to fix this (one
part of a patch-set), which is why at least the net maintainers would
prefer to fix this instead of reverting the culprit -- but we only made
small progress over the last week. Hopefully soon some solution will
emerge:
https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 12 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


=======================================================
current cycle (v6.9.. aka v6.10-rc), culprit identified
=======================================================


drm/qxl: VM graphics often malfunction after boot and sometimes shutdowns occur
-------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/DS7PR12MB57665F9F4BDF0598D7CC53DD94FF2@DS7PR12MB5766.namprd12.prod.outlook.com/
https://lore.kernel.org/regressions/DS7PR12MB57665F9F4BDF0598D7CC53DD94FF2@DS7PR12MB5766.namprd12.prod.outlook.com/

By Kaplan, David; 13 days ago; 3 activities, latest 2 days ago.
Introduced in b33651a5c98d (v6.10-rc1)

Recent activities from: Kaplan, David (1), Thomas Zimmermann (1)


mm: cause warning at mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
--------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsMB9A8-X%2BNp_Q%2BfWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com/

By Mikhail Gavrilov; 25 days ago; 33 activities, latest 3 days ago.
Introduced in 8430557fc584 (v6.10-rc1)

Fix incoming:
* mm/debug_vm_pgtable: drop RANDOM_ORVALUE trick
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=539c45c4b4f62143ef7b8d46a98a67bb57558131


net: dsa: mt7530-mdio: mt7531 switch on Bananapi-R64 not detected
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240516204847.171029-1-linux@fw-web.de/
https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/

By Frank Wunderlich; 30 days ago; 20 activities, latest 4 days ago.
Introduced in 868ff5f4944a (v6.10-rc1)

Recent activities from: Arınç ÜNAL (3), AngeloGioacchino Del Regno (2),
  Thorsten Leemhuis (1)

One patch associated with this regression:
* [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
  https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/
  30 days ago, by Frank Wunderlich


spi: omap2-mcpsi: boot hangs with ocelot_mfd driver
---------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zl/V0dU6SjAMkpLG@colin-ia-desktop/
https://lore.kernel.org/lkml/Zl%2FV0dU6SjAMkpLG@colin-ia-desktop/

By Colin Foster; 11 days ago; 5 activities, latest 5 days ago.
Introduced in e64d3b6fc9a3 (v6.10-rc1)

Recent activities from: Colin Foster (1)

One patch associated with this regression:
* omap2-mcspi multi mode
  https://lore.kernel.org/lkml/Zl%2FV0dU6SjAMkpLG@colin-ia-desktop/
  11 days ago, by Colin Foster


e1000e: s2idle and S3 broken
----------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218936/
https://bugzilla.kernel.org/show_bug.cgi?id=218936
https://bugzilla.kernel.org/show_bug.cgi?id=218940

By Dieter Mummenschanz and Todd Brandt; 11 days ago; 7 activities, latest 5 days ago.
Introduced in bfd546a552e1 (v6.10-rc2)

Recent activities from: Hui Wang (2)

2 patch postings are associated with this regression, the latest is this:
* [iwl-net][PATCH v2] Revert "e1000e: move force SMBUS near the end of enable_ulp function" [implicit due to Link/Closes tag]
  https://lore.kernel.org/netdev/20240611062416.16440-1-hui.wang@canonical.com/
  5 days ago, by Hui Wang; thread monitored.

Noteworthy links:
* [iwl-net][PATCH] Revert "e1000e: move force SMBUS near the end of enable_ulp function" [implicit due to Link/Closes tag]
  https://lore.kernel.org/netdev/20240610013222.12082-1-hui.wang@canonical.com/
  6 days ago, by Hui Wang; thread monitored.


:drm/amd: green flashing bar on top of screen
---------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com/

By Mikhail Gavrilov; 21 days ago; 5 activities, latest 5 days ago.
Introduced in bc87d666c05a (v6.10-rc1)

Recent activities from: Mikhail Gavrilov (2)

One patch associated with this regression:
* Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac cause appearing green flashing bar on top of screen on Radeon 6900XT and 120Hz
  https://lore.kernel.org/lkml/CADnq5_PDxJ8O1JUQ9RBYRFB9G1WZJos05ZAM4jUKuPBwPxjNkA@mail.gmail.com/
  9 days ago, by Alex Deucher


[ *NEW* ] drm/bridge: adv7511: Intermittent EDID failures
---------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240601132459.81123-1-aford173@gmail.com/
https://lore.kernel.org/lkml/20240601132459.81123-1-aford173@gmail.com/

By Adam Ford; 15 days ago; 2 activities, latest 6 days ago.
Introduced in f3d9683346d6 (v6.10-rc1)

Fix incoming:
* drm/bridge: adv7511: Fix Intermittent EDID failures
  https://lore.kernel.org/regressions/1b79fc84-588e-4ff1-8034-8fc99686f831@leemhuis.info/


usb: chipidea: USB broken on DragonBoard410c, msm8974-based devices, and sony yuga
----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/21ea292a-b1d1-43e2-92ab-9f1f63aaf729@samsung.com/
https://lore.kernel.org/lkml/21ea292a-b1d1-43e2-92ab-9f1f63aaf729@samsung.com/
https://lore.kernel.org/lkml/ecb8d3e8-d525-4a2d-a868-803202c16296@franken-peeters.be/

By Marek Szyprowski and Wouter Franken; 51 days ago; 3 activities, latest 10 days ago.
Introduced in 22ffd399e6e7 (v6.10-rc1)

Fix incoming:
* Revert "usb: chipidea: move ci_ulpi_init after the phy initialization"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=718d4a63c0a62d16af1d0425d515d7e76f35681e


iio: IIO channel read outs and thereby thermal mitigation on the Lenovo ThinkPad X13s broken
--------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240530074416.13697-1-johan+linaro@kernel.org/
https://lore.kernel.org/lkml/20240530074416.13697-1-johan%2Blinaro@kernel.org/

By Johan Hovold; 17 days ago; 6 activities, latest 10 days ago.
Introduced in 3092bde731ca (v6.10-rc1)

Fix incoming:
* iio: inkern: fix channel read regression
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=78f0dfa64cbd05f381849377a32e0a2f1afe9215


====================================================
current cycle (v6.9.. aka v6.10-rc), unknown culprit
====================================================


[ *NEW* ] performance problems on Thinkpad X220 (GPU working harder and causing throttling?)
--------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZmrTZozoi0t/tuva@duo.ucw.cz/
https://lore.kernel.org/lkml/ZmrTZozoi0t%2Ftuva@duo.ucw.cz/

By Pavel Machek; 3 days ago; 7 activities, latest 1 days ago.
Introduced in v6.9..v6.10-rc3

Recent activities from: Pavel Machek (4), Linus Torvalds (3)


mm: WARNING: CPU: 13 PID: 7032 at lib/xarray.c:1024 xas_split_alloc+0xbd/0x110
------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218861/
https://bugzilla.kernel.org/show_bug.cgi?id=218861

By sander44; 28 days ago; 5 activities, latest 1 days ago.
Introduced in v6.9..0450d2083be6 (v6.9..v6.10-rc1)

Recent activities from: Mike Lothian (1), The Linux kernel's regression
  tracker (Thorsten Leemhuis) (1)


drm/amdgpu: crash on playing videos
-----------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ebb3b35e631169041e70eb0a7efd6cecef609833.camel@sjtu.edu.cn/
https://lore.kernel.org/amd-gfx/ebb3b35e631169041e70eb0a7efd6cecef609833.camel@sjtu.edu.cn/
https://lore.kernel.org/amd-gfx/CAMOvFfkQscju1spNKHmEC_Rut%2B2=qfhKGZSvGhCk_nd5VhuDkg@mail.gmail.com/

By Wang Yunchen and Winston Ma; 18 days ago; 3 activities, latest 17 days ago.
Introduced in v6.9..v6.10-rc1


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/171795191306.47744.1188389943277445679@leemhuis.info

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

