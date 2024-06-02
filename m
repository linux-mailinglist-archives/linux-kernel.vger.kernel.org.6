Return-Path: <linux-kernel+bounces-198374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 560FD8D7747
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 19:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0BAB217BB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 17:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E6C56458;
	Sun,  2 Jun 2024 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="MVnBqoQX"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1267D57C8A;
	Sun,  2 Jun 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717348448; cv=none; b=O33MbMBXiHFAvsuVrz4/wkxaa9sRmIrzPudsequK01N3/eXL7PqZ8pZHm9N4G3+u/n3ymb6ezCFy6gMJoV9fZsMCXsVvMpk3VVjIRieqd7NgjLqglBlhuk//GgNDcC9MjQmquq3iPzASZW+ssWKo30vhugsHD9EfiElHSbXSe5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717348448; c=relaxed/simple;
	bh=zpbdsuEbsWtrVJubq9mjubZKUmGOCJhz+VMVxpCjAS8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K2ARVyhjUMujw4tqre42Ox/SNU06F9PIMFwf40UHbDDT+uleVK2mGpLkcRlp1Trffwh9pa6yAuTOjaTsolJJd6e5S5dvg0fu1BHARraXGXhSXRcEWvlhvUw2yHqZ6KcRcQ4jAv99uRUdifR74i14C1tFW0F4dG0hy/1/EH6zX7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=MVnBqoQX; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=vtS1ALxA8bVJljw3ZcU9XA2sj+N1cCRdGjn7VQX5j/U=; t=1717348446; x=1717780446;
	 b=MVnBqoQXPxmHf4cjuQYNRu8+xp2/Sn563ziDpHB9Fj/tgyKLsk18NCGRIFNI1WkDOKUvYUXjnK
	ZR7Ush+j+FJNznE2nLGMTvrRO8gpxUJSGbjAWnmrK44CYoLxPP0YTgFJytxqgT8u1AlBQ6mCAfP3c
	HGTdM5ltPIgEG0ZVVmzDAbbC4qqJORjrVEC0uQrVs9Adtjj/gHBpDW6KYwvDTl0j1os3FvXg0Ln3g
	tpQ8hLVVyXzoFEEfGuymqd6vuP3qXwng3w/qailVvqGKHGsWh91Mt0zZpAGrI6eNUb2VLETj/nUVy
	FppiV8wm80Ch3+6kolpzu3XZ0Be20WpJMXpkg==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1sDoHA-0001Uh-B7; Sun, 02 Jun 2024 18:41:44 +0200
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-06-02]
Date: Sun,  2 Jun 2024 16:41:43 +0000
Message-ID: <171734646847.3801768.17100765308817567892@leemhuis.info>
X-Mailer: git-send-email 2.45.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717348446;9e87345c;
X-HE-SMSGID: 1sDoHA-0001Uh-B7

Hi Linus, here is a quick weekly report for regressions introduced
during this cycle. I lacked time to update each tracked regression 
yesterday/today, but from a quick look there is nothing to worry.
There is just one report where the reporter did not get an answer after
a full week, but I'll prod it tomorrow.

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 14 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


=======================================================
current cycle (v6.9.. aka v6.10-rc), culprit identified
=======================================================


[ *NEW* ] iio: IIO channel read outs and thereby thermal mitigation on the Lenovo ThinkPad X13s broken
------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240530074416.13697-1-johan+linaro@kernel.org/
https://lore.kernel.org/lkml/20240530074416.13697-1-johan%2Blinaro@kernel.org/

By Johan Hovold; 3 days ago; 2 activities, latest 1 days ago.
Introduced in 3092bde731ca (v6.10-rc1)

Fix incoming:
* iio: inkern: fix channel read regression
  https://lore.kernel.org/regressions/9631daef-8cb9-4632-ba8d-3ff9a6669e2b@leemhuis.info/


[ *NEW* ] PCI: KASAN: use-after-free in lockdep_register_key+0x755/0x8f0
------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/87v82y6wvi.fsf@kernel.org/
https://lore.kernel.org/lkml/87v82y6wvi.fsf@kernel.org/

By Kalle Valo; 5 days ago; 12 activities, latest 1 days ago.
Introduced in 7e89efc6e9e4 (v6.10-rc1)

Fix incoming:
* PCI: Revert the cfg_access_lock lockdep mechanism
  https://lore.kernel.org/regressions/144eb23f-ae27-46ff-83e7-9a764e58587e@leemhuis.info/


[ *NEW* ] probe with driver acpi-fan failed with error -22
----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240530153727.843378-1-laura.nao@collabora.com/
https://lore.kernel.org/lkml/20240530153727.843378-1-laura.nao@collabora.com/

By Laura Nao; 3 days ago; 2 activities, latest 2 days ago.
Introduced in 31a0fa0019 (v6.10-rc1)

Recent activities from: Laura Nao (2)


scsi: WARNING: [...] block/blk-settings.c:202 blk_validate_limits+0x28c/0x304
-----------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ce2bf6af-4382-4fe1-b392-cc6829f5ceb2@roeck-us.net/
https://lore.kernel.org/linux-block/ce2bf6af-4382-4fe1-b392-cc6829f5ceb2@roeck-us.net/
https://bugzilla.kernel.org/show_bug.cgi?id=218858
https://bugzilla.kernel.org/show_bug.cgi?id=218905

By Guenter Roeck, doru iorgulescu, and doru iorgulescu; 17 days ago; 12 activities, latest 2 days ago.
Introduced in afd53a3d8528 (v6.10-rc1)

Recent activities from: Michael Ellerman (3), Christoph Hellwig (1),
  Thorsten Leemhuis (1), Linux regression tracking (Thorsten
  Leemhuis) (1)

2 patch postings are associated with this regression, the latest is this:
* Re: [PATCH 04/23] scsi: initialize scsi midlayer limits before allocating the queue
  https://lore.kernel.org/linux-block/7df05966-36ea-4d37-99bc-1cf01b4ed921@roeck-us.net/
  17 days ago, by Guenter Roeck


net: dsa: mt7530-mdio: mt7531 switch on Bananapi-R64 not detected
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240516204847.171029-1-linux@fw-web.de/
https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/

By Frank Wunderlich; 16 days ago; 9 activities, latest 2 days ago.
Introduced in 868ff5f4944a (v6.10-rc1)

Recent activities from: Arınç ÜNAL (3), Frank Wunderlich (1)

One patch associated with this regression:
* [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
  https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/
  16 days ago, by Frank Wunderlich


[ *NEW* ] iommu/vt-d: blktests block/008 lead kerne panic
---------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAHj4cs9KZJc6Wsp9t0fDc4fDBJB1TmwGT7-8peCGLiqW3J_Fqw@mail.gmail.com/
https://lore.kernel.org/linux-block/CAHj4cs9KZJc6Wsp9t0fDc4fDBJB1TmwGT7-8peCGLiqW3J_Fqw@mail.gmail.com/
https://lore.kernel.org/lkml/20240530120110.22141-1-00107082@163.com/

By Yi Zhang and David Wang; 5 days ago; 11 activities, latest 2 days ago.
Introduced in d74169ceb0d2 (v6.10-rc1)

Fix incoming:
* iommu/amd: Fix panic accessing amd_iommu_enable_faulting
  https://lore.kernel.org/regressions/9631daef-8cb9-4632-ba8d-3ff9a6669e2b@leemhuis.info/


mm: cause warning at mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
--------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsMB9A8-X%2BNp_Q%2BfWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com/

By Mikhail Gavrilov; 11 days ago; 23 activities, latest 2 days ago.
Introduced in 8430557fc584 (v6.10-rc1)

Fix incoming:
* mm/debug_vm_pgtable: drop RANDOM_ORVALUE trick
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=ec3c2e591cbf7820c1fca9b5d572feed3063e752


sifive_u boot failure
---------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net/
https://lore.kernel.org/lkml/7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net/
https://lore.kernel.org/lkml/d7f0c16a-0d83-4060-8d95-95b293d95dfd@leemhuis.info/

By Guenter Roeck and Linux regression tracking (Thorsten Leemhuis); 15 days ago; 14 activities, latest 2 days ago.
Introduced in 8d532528ff6a (v6.10-rc1)

Fix incoming:
* clk: sifive: Do not register clkdevs for PRCI clocks
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=2607133196c35f31892ee199ce7ffa717bea4ad1


6.10/regression/bisected commit c4cb23111103 causes sleeping function called from invalid context at kernel/locking/mutex.c:585
-------------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsN1z2gj99zSdhQWynpTXBymrqHejDfF8axxxoiZ_0g_-g@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsN1z2gj99zSdhQWynpTXBymrqHejDfF8axxxoiZ_0g_-g@mail.gmail.com/
https://bugzilla.kernel.org/show_bug.cgi?id=218900
https://lore.kernel.org/lkml/20240527192159.GEZlTdV7OoOuJrHmI0@fat_crate.local/

By Mikhail Gavrilov, Jean-Christophe Guillain, and Borislav Petkov; 12 days ago; 6 activities, latest 3 days ago.
Introduced in c4cb23111103 (v6.10-rc1)

Fix incoming:
* iommu/amd: Check EFR[EPHSup] bit before enabling PPR
  https://lore.kernel.org/regressions/66e2de37-99d7-411d-aa2b-8792a749895a@leemhuis.info/


[ *NEW* ] usb: chipidea: USB broken on DragonBoard410c, msm8974-based devices, and sony yuga
--------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/21ea292a-b1d1-43e2-92ab-9f1f63aaf729@samsung.com/
https://lore.kernel.org/lkml/21ea292a-b1d1-43e2-92ab-9f1f63aaf729@samsung.com/
https://lore.kernel.org/lkml/ecb8d3e8-d525-4a2d-a868-803202c16296@franken-peeters.be/

By Marek Szyprowski and Wouter Franken; 37 days ago; 2 activities, latest 3 days ago.
Introduced in 22ffd399e6e7 (v6.10-rc1)

Recent activities from: Alexandre Messier (1)


[ *NEW* ] net: igc: kernel crash
--------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsOkiGxAfA9tPKjYX7wqjBZQxqK2PzTcW-RgLfgo8G74EQ@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsOkiGxAfA9tPKjYX7wqjBZQxqK2PzTcW-RgLfgo8G74EQ@mail.gmail.com/
https://lore.kernel.org/intel-gfx/87o78rmkhu.fsf@intel.com/

By Mikhail Gavrilov and Jani Nikula; 17 days ago; 4 activities, latest 4 days ago.
Introduced in 86167183a17e (v6.10-rc1)

Fix incoming:
* Revert "igc: fix a log entry using uninitialized netdev"
  https://lore.kernel.org/regressions/66e2de37-99d7-411d-aa2b-8792a749895a@leemhuis.info/


:drm/amd: green flashing bar on top of screen
---------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com/

By Mikhail Gavrilov; 7 days ago; 1 activities, latest 7 days ago.
Introduced in bc87d666c05a (v6.10-rc1)


====================================================
current cycle (v6.9.. aka v6.10-rc), unknown culprit
====================================================


[ *NEW* ] drm/amdgpu: crash on playing videos
---------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ebb3b35e631169041e70eb0a7efd6cecef609833.camel@sjtu.edu.cn/
https://lore.kernel.org/amd-gfx/ebb3b35e631169041e70eb0a7efd6cecef609833.camel@sjtu.edu.cn/

By Wang Yunchen; 4 days ago; 3 activities, latest 3 days ago.
Introduced in v6.9..v6.10-rc1

Recent activities from: Wang Yunchen (2), Alex Deucher (1)


mm: WARNING: CPU: 13 PID: 7032 at lib/xarray.c:1024 xas_split_alloc+0xbd/0x110
------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218861/
https://bugzilla.kernel.org/show_bug.cgi?id=218861

By sander44; 14 days ago; 3 activities, latest 12 days ago.
Introduced in v6.9..0450d2083be6 (v6.9..v6.10-rc1)


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/171674601223.3216887.11973021776359474447@leemhuis.info

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

