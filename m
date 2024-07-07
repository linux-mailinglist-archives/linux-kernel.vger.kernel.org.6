Return-Path: <linux-kernel+bounces-243471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FEB9296B0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 07:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BC1282725
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 05:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130C3C8E1;
	Sun,  7 Jul 2024 05:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="q1R3tD2R"
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122793C0B;
	Sun,  7 Jul 2024 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720330202; cv=none; b=lZqjrmd3y8jtuu/tPe7ahdqu5WmBKsGYKY3KclqKm4cHLVknAanbOO/eL7ASWi6qtJ8mstz6mJSRd9t+YbFV1ebuT6ySZYmksdT0nfBcv7geY+ZeYMHTAqK+XM/y8HxJyGbPVlWo0DsWmx8SHndb0nyJGk1zXYa1U95ZUeJB4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720330202; c=relaxed/simple;
	bh=RrJZGTxd7xygHhaOVoishTvrFUj3gGMe/6VLlgISMgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sgkmi7/GSfRoAI3JyKG3FHdRaxTj22cDC/2G+MhI7ygz/BOIdxtfjVIbznWo3YFofFXTyiXuoyBQGABQIiPosAfyefdU/qJGeVmLHbtxWHaXrjgq7p0TKi2vY1iIewUs531BCJ6qN3HsrlYXPrW2YXb47BwfQ8vaeWqUKsVj2rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=q1R3tD2R; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id QKT8ssABbbqgGQKT8soUOV; Sun, 07 Jul 2024 07:29:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720330191;
	bh=zC54ys3M8a39QLCtSzCZVowyG7EsoN9tlLmkgNqnfvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=q1R3tD2RXdeLFyBEQTmY0fXh19otMgvcnaVayp8aA524Au5Og59rc7IdyRPmdZauT
	 +JM3S5N5bt5lbojBzDK991fq+LRxD3RckSk5ZggPl2RaefwxZl4P9UTijWJBZseetv
	 ImAORn69hTuHhzoVO4DMb/wdmEnXGF2xS96UxgSfTp1oCQFq7i/NknY8pmihF6OqV8
	 54lSTnrL0SnbsyaS202XTF5u3M9fFM8KgcS8BirE3GeiznpeDg3g+T/HaHdtCfUwBg
	 Km25DkU07YuNSG1aW87wwxnCPrLN0JD/ifJJNB9VbnX7Tqr3ozt7hTZ9Dk6L0LGTSF
	 Dqswi9a5z0kGg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 07 Jul 2024 07:29:51 +0200
X-ME-IP: 86.243.222.230
Message-ID: <7635709f-9974-4c60-9cb0-78ae7f007cc2@wanadoo.fr>
Date: Sun, 7 Jul 2024 07:29:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Removed extra asterisks from comment beginnings, and
 removed unnecessary comment end
To: Gold Side <goldside000@outlook.com>, "krzk@kernel.org" <krzk@kernel.org>,
 "perex@perex.cz" <perex@perex.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
References: <DM4P223MB0541357D7B105C83EF9FCFD5F7D92@DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <DM4P223MB0541357D7B105C83EF9FCFD5F7D92@DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/07/2024 à 06:14, Gold Side a écrit :
>  From 3574f0514207f9610a69d82d3dd0d018d6dce5dd Mon Sep 17 00:00:00 2001
> From: Steven Davis <goldside000@outlook.com>
> Date: Tue, 2 Jul 2024 22:57:24 -0400
> Subject: [PATCH 1/3] Removed extra asterisk from comment beginning
> 
> It saves a byte. I'd imagine bytes are valuable in a project like this.
> PS: Please forgive my previous patch email, I didn't know the guidelines well.

Hi,

no-problem, newcomers are always welcomed and they have to learn. So, 
IMHO, making small mistakes is part of the learning curve.


People/mailing-list should be defined according to the MAINTAINERS file. 
A script helps you for that: ./scripts/get_maintainer.pl

It can be run either on a patch or on a file/directory.

Here:
	./scripts/get_maintainer.pl -f kernel/module/main.c
or
	./scripts/get_maintainer.pl your_patch.patch
give:
	Luis Chamberlain <mcgrof@kernel.org> (maintainer:MODULE SUPPORT)
	linux-modules@vger.kernel.org (open list:MODULE SUPPORT)
	linux-kernel@vger.kernel.org (open list:MODULE SUPPORT)

It is perfectly fine to add other people/mailing list that are relevant, 
as kernel-janitor.

If you are using git mail, it is possible to automate the creation of 
the To: and cc: fields. (see 
https://www.marcusfolkesson.se/blog/get_maintainers-and-git-send-email/). 
If using this --identify, you still can add some other --to, --cc., 
which is really convenient.



On your commit log, here are a few comments:
   - there should be a new-line before the Signed-off-by: line
   - you can add whatever you want after the --- ending the commit 
description. These extra comments are informational only, and won't be 
part of the git history. Here, your PS should have been here.
    - imperative wording is preferred when writing commit logs

You can also give a look at 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html, 
if not already done.


Welcome and happy patching :)

CJ

> Signed-off-by: Steven Davis <goldside000@outlook.com
> ---
>   kernel/module/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d18a94b973e102..25e456f4381c71 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -450,7 +450,7 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
>        return false;
>   }
>   
> -/**
> +/*
>    * is_module_percpu_address() - test whether address is from module static percpu
>    * @addr: address to test
>    *


