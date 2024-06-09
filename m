Return-Path: <linux-kernel+bounces-207432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97190170A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 18:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DD21F2123B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7A47F59;
	Sun,  9 Jun 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="hJsK173M"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6263C7;
	Sun,  9 Jun 2024 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717951947; cv=none; b=ZnK9cvF2npWX2broZls2U1u8nduNGSQbN+Ocn+nHOwpW7PaYzmAEv+PzxG/xIIpIGA5K8bJ34tCCkND7qINF/mu2/Q5kpv6bG+hK3Cct+8m2Ib9zkEpHfFZCps1RZzQ4jlq3En7m9AlZyc/tM6sYoL8PVHY12kMJ2Zl2+fx5WIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717951947; c=relaxed/simple;
	bh=h4wXwK68ugLZMighrK3ruJWe3jC4aASr0M0vfE+LP6I=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O7G9wMRYlsOBBS5/13GafT5/sex14667ffddW/regCOMJ8WFENjiL0x2BMTPdQFWmXGGGBLx+GoRPZXrObusigCk44HnXAiHRYWbn6+aylbxCCAi41yA2867vM1VwoLR+0SsJs6jsT8RigVzBSVN6MW6/4fh/9XMlhDt5kdzQvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=hJsK173M; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qnoq3daycpuOMtcTBaC+b8k0apfO30gXr1ZBVil0tmk=; t=1717951944; x=1718383944;
	 b=hJsK173Mtp925/Etw1K+ar3GNVg/OYgicLfFmHbwiBtbH7xkN15/ETcBbHNWHUzIeF2C29toSc
	SpC2nCv+BhGTJ8o39oi+TOhoY0RXR5UjH4MIyVPuJLFizatr4DAWxoCdEzWIQGEbId8sHoqNNIty3
	JwNRQbLdKeLvSClCp6fZUVqmlqx+Dg+yYF8v9FSsAPKYiODOPQiSl3FPd/w2I4hCKEZgYqzLj27KR
	OU+wZmuE8FmZm7ILs8+cv4rX9aa6e2Hva64EOVRjJKfLvMu0bA2pJ73ZpDxy9GsDJAjLfcSka95em
	S6KAN8Bc0JMQTPibMm4D9FDtKO8K/nh8C+x6g==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1sGLmI-0002EQ-Eh; Sun, 09 Jun 2024 18:52:22 +0200
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-06-09]
Date: Sun,  9 Jun 2024 16:52:21 +0000
Message-ID: <171795191306.47744.1188389943277445679@leemhuis.info>
X-Mailer: git-send-email 2.45.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717951945;7fbd0a60;
X-HE-SMSGID: 1sGLmI-0002EQ-Eh

Hi Linus, here is a quick weekly report for regressions introduced
during this cycle. I'm still a bit behind as there are quite a few open
regression currently as well as some other stuff that keeps me busy, but
it seems there is nothing much to worry about -- apart from the usual
"there IMHO are too many regression fixes that were submitted one or two
weeks ago already which in a ideal world would be in mainline by now".

One of those that also worries me a little is a regression caused by
868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of switch from
device tree"), which broke the detection of the mt7531 switch on
Bananapi-R64. There are two arm64 dts patches around to fix this (one
part of a patch-set), which is why everyone would prefer to fix this --
but the arm64 dts people for weeks now did not really react to the
report. But I'm nevertheless somewhat optimistic that this will be
solved over the next week. For details, see this thread:
https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/

There is also a net/led AB-BA deadlock that was introduced in the 6.9
cycle that annoys a few people. Hans now took this up and provided a
revert that hopefully will make it to you soon:
https://lore.kernel.org/all/20240607101847.23037-1-hdegoede@redhat.com/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 15 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


=======================================================
current cycle (v6.9.. aka v6.10-rc), culprit identified
=======================================================


[ *NEW* ] Bluetooth Kernel Bug: After connecting either HFP/HSP or A2DP is not available (Regression in 6.9.3, 6.8.12)
----------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com/
https://lore.kernel.org/stable/CAGew7BttU%2Bg40uRnSCN5XmbXs1KX1ZBbz%2BxyXC_nw5p4dR2dGA@mail.gmail.com/

By Timo Schröder; 2 days ago; 15 activities, latest 0 days ago.
Introduced in 84a4bb6548a2 (v6.10-rc1)

Recent activities from: Timo Schröder (5), Pauli Virtanen (3),
  bluez.test.bot (2), Luiz Augusto von Dentz (2), kernel test robot (1),
  Linux regression tracking (Thorsten Leemhuis) (1), Paul Menzel (1)

3 patch postings are associated with this regression, the latest is this:
* [PATCH v2] Bluetooth: fix connection setup in l2cap_connect
  https://lore.kernel.org/linux-bluetooth/ad69720e0ba720209cb04240fbc3c5ff059accbc.1717945321.git.pav@iki.fi/
  0 days ago, by Pauli Virtanen


iommu/vt-d: blktests block/008 lead kerne panic
-----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAHj4cs9KZJc6Wsp9t0fDc4fDBJB1TmwGT7-8peCGLiqW3J_Fqw@mail.gmail.com/
https://lore.kernel.org/linux-block/CAHj4cs9KZJc6Wsp9t0fDc4fDBJB1TmwGT7-8peCGLiqW3J_Fqw@mail.gmail.com/
https://lore.kernel.org/lkml/20240530120110.22141-1-00107082@163.com/

By Yi Zhang and David Wang; 12 days ago; 12 activities, latest 1 days ago.
Introduced in d74169ceb0d2 (v6.10-rc1)

Fix incoming:
* iommu/amd: Fix panic accessing amd_iommu_enable_faulting
  https://lore.kernel.org/regressions/9631daef-8cb9-4632-ba8d-3ff9a6669e2b@leemhuis.info/


[ *NEW* ] spi: omap2-mcpsi: boot hangs with ocelot_mfd driver
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zl/V0dU6SjAMkpLG@colin-ia-desktop/
https://lore.kernel.org/lkml/Zl%2FV0dU6SjAMkpLG@colin-ia-desktop/

By Colin Foster; 4 days ago; 4 activities, latest 2 days ago.
Introduced in e64d3b6fc9a3 (v6.10-rc1)

Recent activities from: Colin Foster (2), Mark Brown (1), Louis
  Chauvet (1)

One patch associated with this regression:
* omap2-mcspi multi mode
  https://lore.kernel.org/lkml/Zl%2FV0dU6SjAMkpLG@colin-ia-desktop/
  4 days ago, by Colin Foster


net: dsa: mt7530-mdio: mt7531 switch on Bananapi-R64 not detected
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240516204847.171029-1-linux@fw-web.de/
https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/

By Frank Wunderlich; 23 days ago; 14 activities, latest 2 days ago.
Introduced in 868ff5f4944a (v6.10-rc1)

Recent activities from: Thorsten Leemhuis (3), Paolo Abeni (1), Arınç
  ÜNAL (1)

One patch associated with this regression:
* [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
  https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/
  23 days ago, by Frank Wunderlich


:drm/amd: green flashing bar on top of screen
---------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com/

By Mikhail Gavrilov; 14 days ago; 3 activities, latest 2 days ago.
Introduced in bc87d666c05a (v6.10-rc1)

Recent activities from: Alex Deucher (1), Mikhail Gavrilov (1)

One patch associated with this regression:
* Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac cause appearing green flashing bar on top of screen on Radeon 6900XT and 120Hz
  https://lore.kernel.org/lkml/CADnq5_PDxJ8O1JUQ9RBYRFB9G1WZJos05ZAM4jUKuPBwPxjNkA@mail.gmail.com/
  2 days ago, by Alex Deucher


probe with driver acpi-fan failed with error -22
------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240530153727.843378-1-laura.nao@collabora.com/
https://lore.kernel.org/lkml/20240530153727.843378-1-laura.nao@collabora.com/

By Laura Nao; 10 days ago; 21 activities, latest 2 days ago.
Introduced in 31a0fa0019 (v6.10-rc1)

Recent activities from: Rafael J. Wysocki (11), Daniel Lezcano (5),
  Laura Nao (2), srinivas pandruvada (1)

3 patch postings are associated with this regression, the latest is this:
* [PATCH v3] thermal: core: Do not fail cdev registration because of invalid initial state [implicit due to Link/Closes tag]
  https://lore.kernel.org/lkml/12456961.O9o76ZdvQC@kreacher/
  2 days ago, by Rafael J. Wysocki; thread monitored.

Noteworthy links:
* [PATCH v1] thermal: core: Do not fail cdev registration because of invalid initial state [implicit due to Link/Closes tag]
  https://lore.kernel.org/lkml/4569763.LvFx2qVVIh@kreacher/
  3 days ago, by Rafael J. Wysocki; thread monitored.
* [PATCH v2] thermal: core: Do not fail cdev registration because of invalid initial state [implicit due to Link/Closes tag]
  https://lore.kernel.org/lkml/6056838.lOV4Wx5bFT@kreacher/
  3 days ago, by Rafael J. Wysocki; thread monitored.


mm: cause warning at mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
--------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsMB9A8-X%2BNp_Q%2BfWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com/

By Mikhail Gavrilov; 18 days ago; 29 activities, latest 2 days ago.
Introduced in 8430557fc584 (v6.10-rc1)

Fix incoming:
* mm/debug_vm_pgtable: drop RANDOM_ORVALUE trick
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=4676aed660dcbdd5a92aab22102a647c87ef29a1


usb: chipidea: USB broken on DragonBoard410c, msm8974-based devices, and sony yuga
----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/21ea292a-b1d1-43e2-92ab-9f1f63aaf729@samsung.com/
https://lore.kernel.org/lkml/21ea292a-b1d1-43e2-92ab-9f1f63aaf729@samsung.com/
https://lore.kernel.org/lkml/ecb8d3e8-d525-4a2d-a868-803202c16296@franken-peeters.be/

By Marek Szyprowski and Wouter Franken; 44 days ago; 3 activities, latest 3 days ago.
Introduced in 22ffd399e6e7 (v6.10-rc1)

Fix incoming:
* Revert "usb: chipidea: move ci_ulpi_init after the phy initialization"
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=718d4a63c0a62d16af1d0425d515d7e76f35681e


[ *NEW* ] e1000e: s2idle and S3 broken
--------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218936/
https://bugzilla.kernel.org/show_bug.cgi?id=218936
https://bugzilla.kernel.org/show_bug.cgi?id=218940

By Dieter Mummenschanz and Todd Brandt; 4 days ago; 5 activities, latest 3 days ago.
Introduced in bfd546a552e1 (v6.10-rc2)

Recent activities from: Dieter Mummenschanz (3), Todd Brandt (2)


iio: IIO channel read outs and thereby thermal mitigation on the Lenovo ThinkPad X13s broken
--------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240530074416.13697-1-johan+linaro@kernel.org/
https://lore.kernel.org/lkml/20240530074416.13697-1-johan%2Blinaro@kernel.org/

By Johan Hovold; 10 days ago; 6 activities, latest 3 days ago.
Introduced in 3092bde731ca (v6.10-rc1)

Fix incoming:
* iio: inkern: fix channel read regression
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=78f0dfa64cbd05f381849377a32e0a2f1afe9215


net: igc: kernel crash
----------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsOkiGxAfA9tPKjYX7wqjBZQxqK2PzTcW-RgLfgo8G74EQ@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsOkiGxAfA9tPKjYX7wqjBZQxqK2PzTcW-RgLfgo8G74EQ@mail.gmail.com/
https://lore.kernel.org/intel-gfx/87o78rmkhu.fsf@intel.com/

By Mikhail Gavrilov and Jani Nikula; 24 days ago; 7 activities, latest 3 days ago.
Introduced in 86167183a17e (v6.10-rc1)

Fix incoming:
* Revert "igc: fix a log entry using uninitialized netdev"
  https://lore.kernel.org/regressions/66e2de37-99d7-411d-aa2b-8792a749895a@leemhuis.info/


[ *NEW* ] drm/qxl: VM graphics often malfunction after boot and sometimes shutdowns occur
-----------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/DS7PR12MB57665F9F4BDF0598D7CC53DD94FF2@DS7PR12MB5766.namprd12.prod.outlook.com/
https://lore.kernel.org/regressions/DS7PR12MB57665F9F4BDF0598D7CC53DD94FF2@DS7PR12MB5766.namprd12.prod.outlook.com/

By Kaplan, David; 6 days ago; 1 activities, latest 6 days ago.
Introduced in b33651a5c98d (v6.10-rc1)

Recent activities from: Kaplan, David (1)


====================================================
current cycle (v6.9.. aka v6.10-rc), unknown culprit
====================================================


[ *NEW* ] cpufreq/thermal regression in 6.10
--------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZmVfcEOxmjUHZTSX@hovoldconsulting.com/
https://lore.kernel.org/lkml/ZmVfcEOxmjUHZTSX@hovoldconsulting.com/

By Johan Hovold; 0 days ago; 1 activities, latest 0 days ago.
Introduced in v6.9..v6.10-rc2

Recent activities from: Johan Hovold (1)


drm/amdgpu: crash on playing videos
-----------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ebb3b35e631169041e70eb0a7efd6cecef609833.camel@sjtu.edu.cn/
https://lore.kernel.org/amd-gfx/ebb3b35e631169041e70eb0a7efd6cecef609833.camel@sjtu.edu.cn/
https://lore.kernel.org/amd-gfx/CAMOvFfkQscju1spNKHmEC_Rut%2B2=qfhKGZSvGhCk_nd5VhuDkg@mail.gmail.com/

By Wang Yunchen and Winston Ma; 11 days ago; 3 activities, latest 10 days ago.
Introduced in v6.9..v6.10-rc1


mm: WARNING: CPU: 13 PID: 7032 at lib/xarray.c:1024 xas_split_alloc+0xbd/0x110
------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218861/
https://bugzilla.kernel.org/show_bug.cgi?id=218861

By sander44; 21 days ago; 3 activities, latest 19 days ago.
Introduced in v6.9..0450d2083be6 (v6.9..v6.10-rc1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/171734646847.3801768.17100765308817567892@leemhuis.info

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

