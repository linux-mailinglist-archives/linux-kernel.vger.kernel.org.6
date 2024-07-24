Return-Path: <linux-kernel+bounces-261197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A074D93B409
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25212B23678
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288FE15B986;
	Wed, 24 Jul 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="h3xTsq3U"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4889C15B554;
	Wed, 24 Jul 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835789; cv=none; b=oAURuAzTgcbuLTKitNkcidIfwSUrgaPhqa8pRWD5HPfptFzZ8tYwWQrcynt4mGBeGw9w0Vy57QbACrCm59zRYCAEd3EQusgJqEakmpSxO+pMtzMuhM0xbP0YJCsJOiOTMsncVUn064jdfUIRdF/INWj1DOWrjOgBKvGCWcrheX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835789; c=relaxed/simple;
	bh=AukMGJiOqCCtt17aswDkfUN2mPrEt30Ji1pkpma+scc=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=dRPFTqCpPJP1L1xl3Ii3GgbIxuMxpK33lSj+KR2/oHsGpXZutUWZkTFp5uqBnAfYGDVYr6has2Yc9hV5W68gQk8O5ilsrNswmoEDvMXKALZ+tdU5VOo2Ph58/6TpoxB6rimP28wxjTZXhu8smfSX8Nl5aDvQGdhBqX8RHv/3mrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=h3xTsq3U; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:Subject:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To
	:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=crvD7PrqGMqV/Y/g69Di0jX+60ZadkqnzEmO6bIr5Ak=; t=1721835787;
	x=1722267787; b=h3xTsq3UaeAXfhF832IKP/qfRwoWgzlGhvSWhILvsU4c24Dkz87zkaphZhtrK
	s5S8QNbgvIwTLfW4d5T2HGphv6fTssjFhB+zziSj3C6BNNsDAlxn0m38x2CaqPhuR2QeRJbJOTj06
	SvxSKperIUUP6F9VXXfdTrSYPAOD8wxPqlR/5L5obrGQ9oF7UpAFcxZ6/WV4t5EUDklA2NoGEen0J
	9mTDZBtz2BXkCRk9aXWFv8jwyYzfToRwWIe5ta4blQmhqNAqFZT4Paf73OpreNtCb28rpw5RXlyNf
	mNVX/pbjnhWOjp6i43gv65bTLQo3RUT7PEnyDpFsW87TUJAJlg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sWe8m-0001Zq-LO; Wed, 24 Jul 2024 17:42:56 +0200
Message-ID: <1ff5b407-ff81-40ef-8aa3-9f155491f497@leemhuis.info>
Date: Wed, 24 Jul 2024 17:42:56 +0200
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
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>,
 Colin Ian King <colin.i.king@gmail.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [regression] opening and closing /dev/dri/card0 in a QEMU KVM
 instance will shutdown system
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1721835787;8d1a1c47;
X-HE-SMSGID: 1sWe8m-0001Zq-LO

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a report about a regression in bugzilla.kernel.org that
appears to be related to the simpledrm driver. As many (most?) kernel
developers don't keep an eye on the bug tracker, I decided to write this
mail. To quote from https://bugzilla.kernel.org/show_bug.cgi?id=219007 :

>  Colin Ian King 2024-07-05 16:05:27 UTC
> 
> The following code when run as root on a Debian sid amd64 server
> running in virt-manager (KVM QEMU) will shut the system down with
> 6.10.0-rc6.  The fork() is required to cause racing on the open/close on
> /dev/dri/card0
> 
> #include <fcntl.h>
> #include <unistd.h>
> 
> int main(void)
> {
> 	 pid_t pid = fork();
> 
> 	 while (1) {
> 	 	int fd;
> 
> 	 	fd = openat(AT_FDCWD, "/dev/dri/card0", O_WRONLY|O_NONBLOCK|O_SYNC);
> 	 	close(fd);
> 	 }
> }
> 
> This was originally found using: while true; do sudo ./stress-ng
> --dev 4 --dev-file /dev/dri/card0 -t 5; done and narrowed down to the
> above reproducer. (cf:
> https://github.com/ColinIanKing/stress-ng/issues/407 )
> 
> This does not occur on pre 6.10 kernels, so it looks like a 6.10 regression.

See the ticket for more details, which also contains a dmesg from a boot
in the VM: https://bugzilla.kernel.org/attachment.cgi?id=306610

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.9..v6.10
#regzbot title: drm: opening and closing /dev/dri/card0 in a QEMU KVM
instance will shutdown system
#regzbot from: Colin Ian King <colin.i.king@gmail.com>
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219007
#regzbot ignore-activity

