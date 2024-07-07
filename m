Return-Path: <linux-kernel+bounces-243536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A077392975C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 12:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D72F1C20A46
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 10:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FA717C64;
	Sun,  7 Jul 2024 10:06:30 +0000 (UTC)
Received: from 2.mo561.mail-out.ovh.net (2.mo561.mail-out.ovh.net [46.105.75.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7411725
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.75.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720346790; cv=none; b=ZVy+M7CE+Dt+OrKVC60+I8TBpOzQxwuSGt7kl4eABNeWrNnP1/jTgE7F9TNoAVxVj7CIUZydmen3wfanlmxsM60UK6gb7VxmsZmgDPoQpwNMlnIeQiW0PEoDQpM9WucdKdLQv7O7HP08i7JHZ0LyPYfKReOFnT+utJnAjjvqQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720346790; c=relaxed/simple;
	bh=q+ZVjfg32dhaNaFZrGSXCDJnaZ2EaLf0W2r5pUl6IEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHRv8MGA757s7JKfXVpSpeq0rgOXXAi7dNuHA/2UObZoCdFLQ3Nkm6OsqLum7bVR5UWsV+RCqQ5JPhDMGnXQ86DopgTlL9mBpRX9ML3zKVPUd+ebeuUxdB9gbWjT7PTEzuLJ4of8c5dJycI24fuqxPsaxMMVsjUmSlomP75H0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl; spf=pass smtp.mailfrom=milecki.pl; arc=none smtp.client-ip=46.105.75.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=milecki.pl
Received: from director11.ghost.mail-out.ovh.net (unknown [10.108.9.137])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4WGzcd5ywcz1N4Y
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 07:37:53 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-7hjjw (unknown [10.110.113.129])
	by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 592ED1FE1E;
	Sun,  7 Jul 2024 07:37:51 +0000 (UTC)
Received: from milecki.pl ([37.59.142.108])
	by ghost-submission-6684bf9d7b-7hjjw with ESMTPSA
	id 1GHDEc9Fimb2UQoARsdD+Q
	(envelope-from <rafal@milecki.pl>); Sun, 07 Jul 2024 07:37:51 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-108S00297993a4f-17e4-4353-9d0d-40a5a04800ad,
                    9FB31564A4F31A61F7AB0932BCD271886B876CF9) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp:31.11.218.106
Message-ID: <0c095098-4b3e-481b-b866-29cacb9f165d@milecki.pl>
Date: Sun, 7 Jul 2024 09:37:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM linux-next]
To: Mirsad Todorovac <mtodorovac69@gmail.com>, linux-mtd@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <47e0483d-6e3d-43a8-9273-25278a4a74b9@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
In-Reply-To: <47e0483d-6e3d-43a8-9273-25278a4a74b9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5030802259375991588
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeggdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeetteefjeejgefhieekveelveekhedtgefhgfdutdehhffggfevudehteevjeeuteenucfkphepuddvjedrtddrtddruddpfedurdduuddrvddukedruddtiedpfeejrdehledrudegvddruddtkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedupdhmohguvgepshhmthhpohhuth

Some more descriptive subject would be nice :)


On 7.07.2024 02:10, Mirsad Todorovac wrote:
> In file included from ./include/asm-generic/bug.h:22,
>                   from ./arch/x86/include/asm/bug.h:87,
>                   from ./include/linux/bug.h:5,
>                   from ./include/linux/fortify-string.h:6,
>                   from ./include/linux/string.h:374,
>                   from ./arch/x86/include/asm/page_32.h:18,
>                   from ./arch/x86/include/asm/page.h:14,
>                   from ./arch/x86/include/asm/processor.h:20,
>                   from ./arch/x86/include/asm/timex.h:5,
>                   from ./include/linux/timex.h:67,
>                   from ./include/linux/time32.h:13,
>                   from ./include/linux/time.h:60,
>                   from ./include/linux/stat.h:19,
>                   from ./include/linux/module.h:13,
>                   from drivers/mtd/mtdpart.c:10:
> drivers/mtd/mtdpart.c: In function ‘parse_mtd_partitions’:
> drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
>    693 |                         pr_debug("%s: got parser %s\n", master->name,
>        |                                  ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/printk.h:376:21: note: in definition of macro ‘pr_fmt’
>    376 | #define pr_fmt(fmt) fmt
>        |                     ^~~
> ./include/linux/dynamic_debug.h:248:9: note: in expansion of macro ‘__dynamic_func_call_cls’
>    248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
>        |         ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:250:9: note: in expansion of macro ‘_dynamic_func_call_cls’
>    250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
>        |         ^~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/dynamic_debug.h:269:9: note: in expansion of macro ‘_dynamic_func_call’
>    269 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>        |         ^~~~~~~~~~~~~~~~~~
> ./include/linux/printk.h:610:9: note: in expansion of macro ‘dynamic_pr_debug’
>    610 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>        |         ^~~~~~~~~~~~~~~~
> drivers/mtd/mtdpart.c:693:25: note: in expansion of macro ‘pr_debug’
>    693 |                         pr_debug("%s: got parser %s\n", master->name,
>        |                         ^~~~~~~~
> drivers/mtd/mtdpart.c:693:50: note: format string is defined here
>    693 |                         pr_debug("%s: got parser %s\n", master->name,
>        |                                                  ^~
> 
> Offending commit is 5b644aa012f67.

Actually it goes back to 2015 to the commit 8e2c992b59fc ("mtd: mtdpart: add debug prints to partition parser.").


> Proposed non-intrusive fix resolves the warning/error, but I could not test the code.
> (I don't have the physical device.)
> 
> -----------------><------------------------------------------
> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> index 6811a714349d..81665d67ed2d 100644
> --- a/drivers/mtd/mtdpart.c
> +++ b/drivers/mtd/mtdpart.c
> @@ -691,7 +691,7 @@ int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
>                          if (!parser && !request_module("%s", *types))
>                                  parser = mtd_part_parser_get(*types);
>                          pr_debug("%s: got parser %s\n", master->name,
> -                               parser ? parser->name : NULL);
> +                               parser ? parser->name : "(null"));
>                          if (!parser)
>                                  continue;
>                          ret = mtd_part_do_parse(parser, master, &pparts, data);
> 
> 
> Hope this helps.

I'd say it's simple enough to send patch without actual hw testing.

