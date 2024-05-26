Return-Path: <linux-kernel+bounces-189805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041488CF51F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 19:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD481C20862
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 17:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8D012B148;
	Sun, 26 May 2024 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="jwRCMKeX"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45E12B145;
	Sun, 26 May 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716746059; cv=none; b=PeAvUMT3zlWZIby/7sySDDMFGchNkraOa8bETlptIOOW76FAA3AA3GNfFCWiQXEjFQ+LwjmrKOQDdDYWu1NNnfiQtogUTqwBhUloJduGyMxiykbL+uJXxFhSShV7Tb+sRLyVKUJsmL1SK0psZkLmxIanxi/G9FO5Q4UtXFVHkrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716746059; c=relaxed/simple;
	bh=v0xCDyUgNW9DiicSdecADq1dgTMrfgk+NfuCNyvdSA8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=omRNn3bqZ/E0BVSyiztRRxFdQk7PyPjIgpD6oe3nPD+Od84lD23bGEEAltSES9S0gc+BJo70q59BF90wTRYKyH77rydh3JpkQWWaMP2zga898EMZbQJKcn9LFKXqepi35Jx7TvjLSvsfpKEvDOCYTiOsS4SozJSMNTNt6Rvl1+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=jwRCMKeX; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=B0AnmB5PsAURnMCUveQIXlGUhOSEUMJwfY9dzUBhOFg=; t=1716746056; x=1717178056;
	 b=jwRCMKeXp+7HuHC0kN3Ks5zoZHHJNCywENYfh6rjF+eEJ26VCcJxgHZS5wFVysW3LnFfDTY1O2
	/vs8sIqA8sieB69nd7Cgw1kZx7hy0dPID/AFaCarXwr1lW4v0PSaud3CnYeGF7mzOnSbitDsUBG+W
	YMALi/6I+kOD/shmZZEEUoxjuvGth3yGaXsJ6dssmDqSInF9NHo3TyjjW8gpztl5Sz7LY/0uQGJTq
	u3mZipEYFeqoOSZQ9zHg0hQ+PF2ew3pBWpbcuOkuy3zjYuu9c+nFT+NwCMXwITxdwY+Len1sRj2c3
	ayi4SpFcOOIuxWH8JTlDbr48gRDRuUHIckzzg==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1sBI4U-000581-El; Sun, 26 May 2024 19:54:14 +0200
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-05-26]
Date: Sun, 26 May 2024 17:54:13 +0000
Message-ID: <171674601223.3216887.11973021776359474447@leemhuis.info>
X-Mailer: git-send-email 2.45.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716746056;b72d15c1;
X-HE-SMSGID: 1sBI4U-000581-El

Hi Linus, here is the weekly report for regressions introduced during
this cycle. There is nothing in here that at this point really worries
me. Just two things that look a bit odd, but maybe I'm just overly careful:

* Frank Wunderlich reported that the mt7531 switch on a Bananapi-R64 is
not detected anymore; Frank provided a fix (that causes a new warning),
but Arınç ÜNAL mentioned that a better fix was forthcoming (witch afaics
did not happened). That was nearly 10 days ago, but since then nothing
really happened:
https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/

* Guenter reported problems with sifive_u in qemu and even suggested a
few solutions, but the discussion with the author of the culprit went a
bit sideways; most of that was also more than a week ago and no fix or
any progress is in sight for now.
https://lore.kernel.org/lkml/7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net/

Ciao, Thorsten


---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 9 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


========================================================
current cycle (v6.9.. aka v6.9-post), culprit identified
========================================================


[ *NEW* ] :drm/amd: green flashing bar on top of screen
-------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com/

By Mikhail Gavrilov; 0 days ago; 1 activities, latest 0 days ago.
Introduced in bc87d666c05a

Recent activities from: Mikhail Gavrilov (1)


[ *NEW* ] mm: cause warning at mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsMB9A8-X%2BNp_Q%2BfWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com/

By Mikhail Gavrilov; 4 days ago; 18 activities, latest 2 days ago.
Introduced in 8430557fc584

Fix incoming:
* mm/debug_vm_pgtable: Drop RANDOM_ORVALUE trick
  https://lore.kernel.org/regressions/e3b3b766-fab6-483d-8493-adc206d4c8c9@leemhuis.info/


[ *NEW* ] net: dsa: mt7530-mdio: mt7531 switch on Bananapi-R64 not detected
---------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240516204847.171029-1-linux@fw-web.de/
https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/

By Frank Wunderlich; 9 days ago; 5 activities, latest 3 days ago.
Introduced in 868ff5f4944a

Recent activities from: Frank Wunderlich (2), Linux regression tracking
  (Thorsten Leemhuis) (1), Rob Herring (Arm) (1), Arınç ÜNAL (1)

One patch associated with this regression:
* [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
  https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/
  9 days ago, by Frank Wunderlich


[ *NEW* ] __request_module warning: sync module loading from async tpm driver probe
-----------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/119dc5ed-f159-41be-9dda-1a056f29888d@notapiano/
https://lore.kernel.org/regressions/119dc5ed-f159-41be-9dda-1a056f29888d@notapiano/

By Nícolas F. R. A. Prado; 9 days ago; 32 activities, latest 3 days ago.
Introduced in 1b6d7f9eb150

Recent activities from: Jarkko Sakkinen (9), Herbert Xu (9), Nícolas F.
  R. A. Prado (5), James Bottomley (4), Ard Biesheuvel (2), Torsten
  Duwe (1), Linus Torvalds (1), Eric Biggers (1)

6 patch postings are associated with this regression, the latest is this:
* [v3 PATCH] hwrng: core - Remove add_early_randomness
  https://lore.kernel.org/lkml/Zk2Eso--FVsZ5AF3@gondor.apana.org.au/
  4 days ago, by Herbert Xu


[ *NEW* ] sifive_u boot failure
-------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net/
https://lore.kernel.org/lkml/7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net/

By Guenter Roeck; 8 days ago; 9 activities, latest 3 days ago.
Introduced in 8d532528ff6a

Recent activities from: Russell King (Oracle) (5), Guenter Roeck (4)

One patch associated with this regression:
* Re: [PATCH] clkdev: report over-sized strings when creating clkdev entries
  https://lore.kernel.org/lkml/646bd149-f29a-4c91-ab00-4f6d2fce23fd@roeck-us.net/
  8 days ago, by Guenter Roeck


[ *NEW* ] 6.10/regression/bisected commit c4cb23111103 causes sleeping function called from invalid context at kernel/locking/mutex.c:585
-----------------------------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CABXGCsN1z2gj99zSdhQWynpTXBymrqHejDfF8axxxoiZ_0g_-g@mail.gmail.com/
https://lore.kernel.org/lkml/CABXGCsN1z2gj99zSdhQWynpTXBymrqHejDfF8axxxoiZ_0g_-g@mail.gmail.com/

By Mikhail Gavrilov; 5 days ago; 3 activities, latest 3 days ago.
Introduced in c4cb23111103

Recent activities from: Chris Bainbridge (1), Vasant Hegde (1), Mikhail
  Gavrilov (1)


[ *NEW* ] boot regression on linux-next on sc7180 platforms - null pointer dereference on iommu_dma_sync_sg_for_device
----------------------------------------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/6d0da90d-f405-4b5d-b7f9-238cc9405ebe@notapiano/
https://lore.kernel.org/lkml/6d0da90d-f405-4b5d-b7f9-238cc9405ebe@notapiano/

By Nícolas F. R. A. Prado; 12 days ago; 18 activities, latest 4 days ago.
Introduced in 8cc3bad9d9d6

Recent activities from: Andy Shevchenko (7), Nícolas F. R. A. Prado (7),
  Neil Armstrong (4)

5 patch postings are associated with this regression, the latest is this:
* Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
  https://lore.kernel.org/lkml/76763ae4-557a-401e-9497-9295e7da3fd7@notapiano/
  4 days ago, by Nícolas F. R. A. Prado

Noteworthy links:
* Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
  https://lore.kernel.org/lkml/d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano/
  9 days ago, by Nícolas F. R. A. Prado; thread monitored.


[ *NEW* ] scsi: WARNING: [...] block/blk-settings.c:202 blk_validate_limits+0x28c/0x304
---------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ce2bf6af-4382-4fe1-b392-cc6829f5ceb2@roeck-us.net/
https://lore.kernel.org/linux-block/ce2bf6af-4382-4fe1-b392-cc6829f5ceb2@roeck-us.net/
https://bugzilla.kernel.org/show_bug.cgi?id=218858

By Guenter Roeck and doru iorgulescu; 10 days ago; 6 activities, latest 6 days ago.
Introduced in afd53a3d8528

Recent activities from: Guenter Roeck (3), John Garry (2), Christoph
  Hellwig (1)

2 patch postings are associated with this regression, the latest is this:
* Re: [PATCH 04/23] scsi: initialize scsi midlayer limits before allocating the queue
  https://lore.kernel.org/linux-block/7df05966-36ea-4d37-99bc-1cf01b4ed921@roeck-us.net/
  10 days ago, by Guenter Roeck


[ *NEW* ] drm/nouveau/nvif: build error on parisc:allmodconfig with gcc 12.x or later
-------------------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/6584ea16-06f7-4a95-bd83-870f30fc4b5d@roeck-us.net/
https://lore.kernel.org/dri-devel/6584ea16-06f7-4a95-bd83-870f30fc4b5d@roeck-us.net/

By Guenter Roeck; 8 days ago; 3 activities, latest 7 days ago.
Introduced in a61ddb4393ad

Fix incoming:
* drm/nouveau/nvif: Avoid build error due to potential integer overflows
  https://lore.kernel.org/regressions/e3b3b766-fab6-483d-8493-adc206d4c8c9@leemhuis.info/


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/171552254677.1971316.17732013113090096417@leemhuis.info

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

