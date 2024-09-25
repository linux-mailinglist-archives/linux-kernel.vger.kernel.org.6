Return-Path: <linux-kernel+bounces-339074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8154986008
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD7F1F26372
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F431192D77;
	Wed, 25 Sep 2024 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="pqmcV9+9"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A9518452A;
	Wed, 25 Sep 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727267024; cv=none; b=DQ1h7pK4ZqU4hXBVooe/LvkiIVd1NAN8CZe3KCQPIbAbNcK7whxGlUR/L4JSsbW+mCDvKapkT4cM+b1npOrZH9mEgFpLYxBzCv9xfoydSTqgvDJk+O9CDYLsUTLzVLOjL9c2aBErAjcgWVBWf/JtGw3jV6Gjd2NB6do5B3if9tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727267024; c=relaxed/simple;
	bh=xJpNptsOxLsojUl6nDKNKIYUHPxpjNwDAUH41RcxOO0=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=a+Bhw/HSf/dTXwUBahmPmOG4bJFbYU2OPg8g+oW9PEUfCZ9SKuy8a3BbJVw2EOERR1Cg3YPFGbLjDUY1nrTg508nsyQHn5iMgCeuU3DDXnMoMDBAuAn6WLdf/WIS3TdqkjQhLExLa/j/e/QDQH1PrNpMGJq7ahh5FjqE7uNdWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=pqmcV9+9; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Reply-To:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=xJpNptsOxLsojUl6nDKNKIYUHPxpjNwDAUH41RcxOO0=; t=1727267022;
	x=1727699022; b=pqmcV9+9+Sabmpf0hJ/4SDBACwRb1byi7z0vEM0n8WoCBy1qh24HNuOyKMcBK
	GYmp3l2Fuxn1BgSndzI13OTlN2ZRpO2CJHbobOt+AW7sBKsEk/hx8ZiUEmaMSflt7vYGoL7rzXCek
	OwuDBEBMtlYa54jr9RKe92N/Gl4T0muTD4qSkFUqVDMcfEdqdfaWb4MHrNj04LDymYqlEyK3zh7Gq
	dNTufnt7D5gX8c4oLyyFOAT2bkKTup4wvGEZ3qcVXyTWDOPlSpHc0R+aWJd8V5A4/0xWbFI+304DL
	8GLONH0Z0Nn0NHDTLq7g/ouAqRdSC0MF9tdukKy3lJasCrKzLw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1stR3Q-0005hP-6o; Wed, 25 Sep 2024 14:23:36 +0200
Message-ID: <bf8288c9-13a1-47f0-9842-3b8eff37ef65@leemhuis.info>
Date: Wed, 25 Sep 2024 14:23:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Linus Walleij <linus.walleij@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, Andrew <quark@disroot.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] segfault in Qt apps running on Linux kernel 6.10.8 ARM
 with LPAE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1727267022;d28f6a51;
X-HE-SMSGID: 1stR3Q-0005hP-6o

Hi, Thorsten here, the Linux kernel's regression tracker.

Catalin, Linus, I noticed a report about a regression in
bugzilla.kernel.org that appears to be caused by a change of yours:

7af5b901e84743 ("ARM: 9358/2: Implement PAN for LPAE by TTBR0 page table
walks disablement") [v6.10-rc1]

As many (most?) kernel developers don't keep an eye on the bug tracker,
I decided to write this mail. To quote from https://bugzilla.kernel.org/
show_bug.cgi?id=219247 :

> Trying to run LxQt on a Chromebook XE303C12 with Devuan 4 and Linux
> kernel 6.10.8 results in a segmentation fault (for LxQt). There are
> no such problems with Linux kernel 6.9.12 or earlier. With Linux
> kernel 6.10.8 it is possible to run Xfce4, but trying to run for
> example Kate ends in a segmentation fault. Mesa 20.3.5, patched for
> partial hardware acceleration, preserves this acceleration in Xfce4.
> The mpv works using acceleration regardless of the Linux kernel
> version. dmesg does not give anything significantly new compared to
> previous kernel version.

See the ticket for more details and the bisection log. The reporter is CCed.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 7af5b901e84743c608aae90cb0e429702812c324
#regzbot title: ARM: segfault in Qt apps running on Linux kernel 6.10.8
ARM with LPAE
#regzbot from: Andrew
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219247
#regzbot ignore-activity

