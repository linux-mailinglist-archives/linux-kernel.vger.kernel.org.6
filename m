Return-Path: <linux-kernel+bounces-249564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF7192ED52
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19D81C21349
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2694316D9B8;
	Thu, 11 Jul 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ib0PEyRO"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3870716D4F4;
	Thu, 11 Jul 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717136; cv=none; b=RFL99AEdxKETTnu56N/2sQuxB2Hd+geVXuGjZgVUzvQeVf5aqmtHPyMHeP9jfDaukFwByOvyTuwHm+n83z5w5yuzBkEjaHw+EDL7AKLTLrJntKIOl0LHfnZyRFPd4VrGK+EWxFeJ3M20PFvwuXQwhnugXvR3cQbXWPdUKWJkQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717136; c=relaxed/simple;
	bh=64KH7PTBGPdIivIu0imh6UyExWNoqFfbdzOXdF2F5os=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZedODwsvoHpFrzdnV3sMRYE5AAJZ9ZXgXgElpe2uhJ5VdzIaLnTapLcnevkX3OCSZYe1IjVIZRtxR75ChqlTPaRGj6gElD/Pdbro25aUspEJnPvwoo+zXRJ2UMPquTHtKB1wA8//8IST3QdLdqU/oGfOErHjsi75uWJ8ZXSlbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ib0PEyRO; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=64KH7PTBGPdIivIu0imh6UyExWNoqFfbdzOXdF2F5os=; t=1720717134;
	x=1721149134; b=ib0PEyROMPzkQseuvZs1eMYseLOW9e4ABjtNgRLtY6xe0a6XUdgu7/oeiCol4
	LW5W/x1g6zdneQg86Gzrt0obmKw011ovnEVudTtuMdCqExYu8H8TleBmO+5OuZBcyxRO1+iBAJX53
	Rz5mBLPU1hS945KcbFifchjRGsBRi+jfcWPxF/JL8ibd+Knjufqs3LiewlEFwvQ6le/ec3P8kBuNh
	1HIzqzdwC2i8IS/FqbkjJvNNZ8ox8UiswqKofNsu+xW7ra6nrWsb2xLr1ex6pdZKP9ZeJPX4t9UGp
	aenKL41V96uq5CS/yD/vREW/b1zHtpODlF99vpnZvvBUC3uR4g==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sRx88-0000rP-9X; Thu, 11 Jul 2024 18:58:52 +0200
Message-ID: <cc8317fd-4b3f-4b0b-b141-104393d66574@leemhuis.info>
Date: Thu, 11 Jul 2024 18:58:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Quick extra regression report listing regression which available
 fixes
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
References: <64d01ac5-9a84-44db-be72-ef22e6e5fc07@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <64d01ac5-9a84-44db-be72-ef22e6e5fc07@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1720717134;c2017f8d;
X-HE-SMSGID: 1sRx88-0000rP-9X

On 10.07.24 17:15, Thorsten Leemhuis wrote:
> Hi Linus, as you might release the final on Sunday, here is a quick
> "extra" report in case you want to know about a few unfixed regressions
> introduced during the 6.10 cycle. By chance this list only contains
> issues for which a fix is already available; I track a few more
> regression, but they are IMHO not worth mentioning for one reason or
> another.
> [...]


FWIW a quick add-on in case you are interested.

There are two regressions from recent cycles that have available fixes
that afaics will miss 6.10:

* copy_from_kernel_nofault_allowed() breaks MMUless devices:
https://bugzilla.kernel.org/show_bug.cgi?id=218953
Known for 4 weeks. Caused by 169f9102f9198b ("ARM: 9350/1: fault:
Implement copy_from_kernel_nofault_allowed()") [v6.9-rc1]. Fix is in
-next as 3ccea4784fddd9 ("ARM: Remove address checking for MMUless
devices") since earlier this week:
https://lore.kernel.org/all/20240611100947.32241-1-yangyj.ee@gmail.com/

* fs/ntfs3: memory corruption when page_size changes (like from Windows
-> RasPi5)
https://lore.kernel.org/ntfs3/20240529064053.2741996-1-chenhuacai@loongson.cn/
https://lore.kernel.org/all/20240614155437.2063380-1-popcornmix@gmail.com/
Known since the end of May. Caused by 865e7a7700d930 ("fs/ntfs3: Reduce
stack usage") [v6.8-rc4, v6.6.19]. Fix is in -next as 68ef5b8c612b0c
("fs/ntfs3: Update log->page_{mask,bits} if log->page_size changed"
(likely for 3+ weeks already, not sure, did not verify):
https://lore.kernel.org/ntfs3/20240529064053.2741996-2-chenhuacai@loongson.cn/

* perf jevents: DDR controller metrics are completely unavailable on
i.MX8M* systems
https://lore.kernel.org/linux-perf-users/20240531194414.1849270-1-l.stach@pengutronix.de/
Known since the end of May through a proposed fix which fell through the
cracks once already -- and maybe that happened again, as since a week
nothing happened.


And while at it and in case you care, there are also a few regressions
from recent cycles where the culprit is identified for more than three
weeks now, but there still is no fix in sight or in -next:

* 9p: autopkgtest qemu jobs broken
https://bugzilla.kernel.org/show_bug.cgi?id=218916
https://lore.kernel.org/lkml/Zj0ErxVBE3DYT2Ea@gpd/
https://bugs.launchpad.net/ubuntu/+source/autopkgtest/+bug/2056461
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1072004
Known upstream for 2 months now. To quote a complaint about it I got
today: "[this is] causing the testing infrastructure of two distros to
grind to a halt, requiring pinning old kernels (Ubuntu) or simply
disabling all tests that require qemu (Debian). The reporters have
analyzed it, root caused it, found the commit causing it, provided
reproducers, reported to mailing list and bugzilla, provided tentative
patches. On the kernel side? Crickets."

* x86/bugs: dosemu crashes on some x86-32 machines
https://bugzilla.kernel.org/show_bug.cgi?id=218707
https://lore.kernel.org/lkml/IdYcxU6x6xuUqUg8cliJUnucfwfTO29TrKIlLGCCYbbIr1EQnP0ZAtTxdAM2hp5e5Gny_acIN3OFDS6v0sazocnZZ1UBaINEJ0HoDnbasSI=@protonmail.com/
Known for 13 weeks. Fixes are under review for some time, but review is
slow. Latest proposed fix is:
https://lore.kernel.org/lkml/20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com/

* can: m_can: kernel hang
https://lore.kernel.org/lkml/e72771c75988a2460fa8b557b0e2d32e6894f75d.camel@ew.tq-group.com/
Known for three weeks now and no fix in sight because people are
apparently busy with other stuff. But likely not something many people
care about.

Ciao, Thorsten

