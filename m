Return-Path: <linux-kernel+bounces-252075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE391930DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8051C20C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 06:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A9C183097;
	Mon, 15 Jul 2024 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="d3O+blyL"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A23F8E4;
	Mon, 15 Jul 2024 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721024658; cv=none; b=jOUFloSPB5aY43zJwQeTTXBlCT5UHZRAEJ+5elIaCSyy9UdJTr8zwCIVcmOuz02dM9qKIRGth1Mg4RNtvfX5Wl8LIgKTcIEoaDnxlcmWyjwsscaSk1DvsWR/kLfJ+w9C66AzEw9UpskQ8qrkDcro5JRiA681xarEV+UJDU0RqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721024658; c=relaxed/simple;
	bh=UL5FQfANxI+qYkk3a9jwzdH+IG6RWRcwYTkX30elwUM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=IuDaCW873tW88daU1Pa+hj164lOK93/yLsUVq1m1XOBnns8svaVtLnwl6vPSZvzcLzZpyhvf2SwwQgEIZsBjL/x+RsdVvJno5JhVHzgdy8uw1UGv0Mdf8yFirG7etapsxbcFjfOcrecWboqvqW3YNyiqtW8swAzlsEI8fBB/C8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=d3O+blyL; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CVKNT0DWuTIcJYbk3ROolMw+sbtGpk7moqSCzc6nXeA=; t=1721024656; x=1721456656;
	 b=d3O+blyLMG9SX5qIyVyRX5KL50lM7imj1mHe6rCweKp98tcZAdKi7/HT2poapJwYIglZeKeT5P
	kOE1XeKJCp22wxPQb34ezdeAaApIv3rh7PXb4ZY2wUpJu6lsJ08QEglT47xb/RuwEVcDBJ3/oxnZZ
	RuEUw61xguMDXhqCKEi4Pq8ItVRlXxRlxLxRRV9PEVs8n8dqHCGWMIwlImsJF113yyovdhrM3d37a
	1DA9mqFWAIM8cay/lo3PYIoSFNFwRGsHXH/a1ZezXzQMKHbuGeud/v6SzStGefw8IMGHTtgUEIrcC
	8+pK3xZfgZ6V4Yi4PGnLGN3azSEJaMhBMXw2Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sTF81-0004lI-KQ; Mon, 15 Jul 2024 08:24:05 +0200
Message-ID: <1a61d10f-7974-4fb5-ada6-f2c40c55f2f7@leemhuis.info>
Date: Mon, 15 Jul 2024 08:24:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Subject: Boot error since 6.9: Initramfs unpacking failed: invalid magic at
 start of compressed archive
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Jack D <wm2vdghq@duck.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1721024656;03d24d17;
X-HE-SMSGID: 1sTF81-0004lI-KQ

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a report about a regression in bugzilla.kernel.org that a user
bisected to the main ARM64 merge commit from the 6.9 cycle. So the real
issue might be somewhere else, but some help would be appreciated. To
quote from https://bugzilla.kernel.org/show_bug.cgi?id=219014 :

> Hi.
> 
> I'm marking as arm64 since git bisect identifies the first problematic commit as:
>   6d75c6f40a03c97e1ecd683ae54e249abb9d922b
> 
> git bisect log is attached.
> 
> Any kernel tagged v6.9x and later fails to boot with the following error:
> 
> [    0.420154] Initramfs unpacking failed: invalid magic at start of compressed archive
> [    0.433178] Freeing initrd memory: 8820K
> ... snip ...
> [    0.701958] List of all partitions:
> [    0.705604] No filesystem could mount root, tried: 
> [    0.705608] 
> [    0.712166] Kernel panic - not syncing: VFS: Unable to mount root fs on "UUID=a889afec-1ced-4493-ab8b-cf1569819c49" or unknown-block(0,0)                                                
> [    0.724903] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.8-sheeva64 #sheeva64
> [    0.732356] Hardware name: gti sheeva64 development board (DT)
> [    0.738369] Call trace:
> 
> full start-up log attached.
> 
> kernel 6.8.12 and earlier builds boot no problem. 
> 
> Info:
> 
> - hardware: sheeva64 plug (Marvell Armada 3720 dual core ARMv8 Cortex-A53)
> - uboot version: U-Boot 2017.03-armada-18.09.1-gc338309136
>   - uboot init script with kernel cmdline is attached (I haven't changed this in at least a few years)
> - ext4 rootfs is on external usb drive
> - kernel 6.8.12 and earlier boot without issue (see attached: .config.6.8.12)
> - problem first seen in commit: 6d75c6f40a03c97e1ecd683ae54e249abb9d922b (see attached: git_bisect.log)
> - any kernel tagged 6.9x and later that I've tried fails with above error (see attached: .config.6.9.8.broken)
> - I'm building the kernel by cross-compiling on debian "testing" (`crossbuild-essential-arm64`)
> - the `initrd.img-6.9x` file itself appears valid:
>   - `lsinitramfs` works no problem
>   - `file initrd.img-6.9x` output is the same as the working initrds (`Zstandard compressed data (v0.8+), Dictionary ID: None`)
> 
> The bisected commit 6d75c6f40a03c97e1ecd683ae54e249abb9d922b is a merge of some 130+ arm64-related commits, so I'm having a hard time narrowing this down further. I'm glad to help test/troubleshoot but I'd need someone to give me some pointers.
> 
> thanks.
> 
> Jack Donohue

See the ticket for more details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 6d75c6f40a03c97e1ecd683ae54e249abb9d922b
#regzbot title: arm64: Initramfs unpacking failed: invalid magic at
start of compressed archive
#regzbot from: Jack D <wm2vdghq@duck.com>
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219014
#regzbot ignore-activity

