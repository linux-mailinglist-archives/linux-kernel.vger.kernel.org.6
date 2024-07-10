Return-Path: <linux-kernel+bounces-247807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9294592D4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF5A1F2393C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916E194131;
	Wed, 10 Jul 2024 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="figjelsX"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1679F18635;
	Wed, 10 Jul 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624555; cv=none; b=TnpuWLwjSqac17cSgW/hZE2jJ0w5xwNvJVYbGZ74IvHAUH/zwqNGdaAsUIpjIrkzFd2HT+yOomQ7Jr3cF5c5jTYj5fJEqUYHEhSdkyg8RPFROLrkVN4XwdumhdjZ+F1C2oW4JbnbKbUP7IWkb3Xt+XJgOYRZH2cfFFCTDsUbpBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624555; c=relaxed/simple;
	bh=wYrR1El+TS0rB0KwLL4f7USQe4e6pmH8PrDQ/6V2wPc=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=fbhvuIyywImwJaGcaVThkC+OdBwojThwetkxestDW5ersLC+dAnxuOH3JkoGyOy+PKvMEHYL3F15jNmtpvn60RA0G0NA+SuOHcjUHa/neuvilO51O9y1+cbXKy3ogXiTLLWooNaq1SONJWZzUtASzNDLv7J+XJEx0pPzf6R/StM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=figjelsX; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wYrR1El+TS0rB0KwLL4f7USQe4e6pmH8PrDQ/6V2wPc=; t=1720624553; x=1721056553;
	 b=figjelsXZWv/q9RXbUbeWW2h9rcMwAk6W+k57+Z/pvbOxg7urwJcA+n3PAHXouiNeEa4VXn8Z2
	ofLYeIcZZwz8Eon8lC/UkEB3x4uBloCYT81CDfAPH+ixpgTqna3elPHQRMdusZSLnYD+Md0AWIfXg
	g1bTmx2+yIH0NFsKKnbQMiJO25jTbjG0XJvUCRiyTrDWkoi/WOO4hVDpivwU2SUEJ+IhmI58k2/DF
	ptmmUCMl5Sxjb1oblUfdAhHmjx0jBAN88+bXCoj/tAo4tZLDw53WrxBp+/qAfSjSweY5hRsaDNgVU
	BD4qiDm73XJeB4K4r7CYrtJl5Qx6ebG9wS9GQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sRZ2n-00022J-Dw; Wed, 10 Jul 2024 17:15:45 +0200
Message-ID: <64d01ac5-9a84-44db-be72-ef22e6e5fc07@leemhuis.info>
Date: Wed, 10 Jul 2024 17:15:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Quick extra regression report listing regression which available
 fixes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1720624553;1e34e3ea;
X-HE-SMSGID: 1sRZ2n-00022J-Dw

Hi Linus, as you might release the final on Sunday, here is a quick
"extra" report in case you want to know about a few unfixed regressions
introduced during the 6.10 cycle. By chance this list only contains
issues for which a fix is already available; I track a few more
regression, but they are IMHO not worth mentioning for one reason or
another.

There are two issues that worry me somewhat:

* A btrfs regression that leads to increased execution time of the
kswapd0 process and symptoms as if there is not enough memory; at least
two people are affected by this -- but there are indicators that this is
only the tip of the iceberg. Luckily Filipe Manana a few days ago
submitted a patch-set to fix this. It might or might not be picked up by
David and sent to you this week:
https://lore.kernel.org/lkml/CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs%2BA@mail.gmail.com/
https://lore.kernel.org/linux-btrfs/cover.1720448663.git.fdmanana@suse.com/

* bpf: build error with CONFIG_WERROR and CONFIG_BPF. Known for 8 weeks
now since a patch to fix this was posted; my recent prodding was
ignored; luckily two -mm developers yesterday convinced Alexei that it
might be worth fixing for 6.10 with a updated patch from Vlastimil Babka:
https://lore.kernel.org/bpf/20240516072411.42016-1-sheharyaar48@gmail.com/
https://lore.kernel.org/all/20240710100521.15061-2-vbabka@suse.cz/


There are a few regressions with available fixes, which seem to be
unlikely to be submitted for mainline inclusion during this week afaics:

* net: dsa: mt7530-mdio: mt7531 switch on Bananapi-R64 not detected
(known for 8 weeks already):
https://lore.kernel.org/lkml/20240516204847.171029-1-linux@fw-web.de/
https://lore.kernel.org/lkml/f485d1d4f7b34cc2ebf3d60030d1c67b4016af3c.1720107535.git.daniel@makrotopia.org/

* drm/qxl: VM graphics often malfunction after boot and sometimes
shutdowns occur (known for 5 weeks already):
https://lore.kernel.org/regressions/DS7PR12MB57665F9F4BDF0598D7CC53DD94FF2@DS7PR12MB5766.namprd12.prod.outlook.com/
https://lore.kernel.org/dri-devel/20240708142208.194361-1-tzimmermann@suse.de/


There are a few regressions for which fixes are available, but those
might or might not will be submitted for mainline inclusion during this
week:

* ASoC: SOF: Intel: Lenovo Thinkpad X1 Carbon Gen 10 first S2idle fails,
S0ix not even tried to enter from there on:
https://github.com/thesofproject/linux/issues/5072
https://bugzilla.kernel.org/show_bug.cgi?id=218961#c10

* of/irq: identification of ATA drives with P.A. Semi Nemo boards broke:
https://lore.kernel.org/lkml/3ab66fab-c3f2-4bed-a04d-a10c57dcdd9b@xenosoft.de/
https://lore.kernel.org/lkml/c8010a06-9d8d-466a-9a83-ee25950f1885@xenosoft.de/

* e1000e: s2idle and S3 broken. That's the issue I highlighted a few
days ago in a separate mail, but I never got a reply. Anyway, looks like
a patch finally is submitted for inclusion into net (five weeks after
the issue was reported, which is related to another issue that is in 6.9
and 6.6.y kernels):
https://bugzilla.kernel.org/show_bug.cgi?id=218936
https://bugzilla.kernel.org/show_bug.cgi?id=218940
https://lore.kernel.org/all/0b96edcc-6b5f-447f-8023-440427a9fff2@leemhuis.info/
https://lore.kernel.org/all/20240709203123.2103296-1-anthony.l.nguyen@intel.com/

* pinctrl: rockchip: boot broke on RK3328 / Rock64
https://lore.kernel.org/all/705544af-d615-4ff0-a54c-72a69140ce6d@eh5.me/
https://lore.kernel.org/lkml/20240709105428.1176375-1-i@eh5.me/


There furthermore are a few regressions with available fixes in next
through -fixes branches, which thus will likely be submitted for
mainline inclusion during this week:

* drm/bridge: adv7511: Intermittent EDID failures; the fix after six
weeks finally made it to a branch that likely will be submitted for
mainline inclusion later this week.
https://lore.kernel.org/lkml/20240521011614.496421-1-aford173@gmail.com/
https://lore.kernel.org/lkml/20240630221931.1650565-1-aford173@gmail.com/

* spi: omap2-mcpsi: boot hangs with ocelot_mfd driver and spi:
omap2-mcspi: omap2-mcspi broke, Oops after a timeout.
https://lore.kernel.org/lkml/Zl%2FV0dU6SjAMkpLG@colin-ia-desktop/
https://lore.kernel.org/lkml/20240612170030.3qatttsgrwjg2m5s@joaog-nb/
https://lore.kernel.org/lkml/20240704-spi-revert-omap2-multi-v1-1-69357ef13fdc@kernel.org/

Ciao, Thorsten

