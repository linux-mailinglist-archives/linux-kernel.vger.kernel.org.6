Return-Path: <linux-kernel+bounces-243470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080999296AC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B893F282921
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 04:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD85D8473;
	Sun,  7 Jul 2024 04:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lAZ8IrrD"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B925D6FBE;
	Sun,  7 Jul 2024 04:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720327896; cv=none; b=MBWPYuws3Oc3f9N0etLId18CRbjAodQeBWqW3k97IgPVThdsRP1FVZrOKlKCUVU5SfdXwStf/oT1c39HmkA4HfG1g3886ILSQDhGVpykwM4x2sgnbYmOMPTlyJkYlOq/gT2WDTV+SPuu6C1lsxxgh8NdOBKk8dTJ/ylpIqsIH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720327896; c=relaxed/simple;
	bh=CfARi/u/Fjxlqoftj9lntYklY68vu0badl6dd5s2AW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iaU/UJGkb6VIAWoqM+faVrM4b1NnIsF42M5ocVO2fEFPICtEHTALpUoxiUsY3oCz87Svud0PgSWo1g6XmwYnN9HtGFGEu2w1ry3/VlgrrHKP978AC1dnB/jnSrMo0o3wf/BNFUvzZnWEgGKfnTb0XTq88EfDMzd81PjWxPzRQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lAZ8IrrD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=+8eTiFjpxhErd3IxWY+zIjQpbI2d1Wq18AjNJiaZkS8=; b=lAZ8IrrDatXCTq6nh6An+D0z/R
	VvFaw2xYre3Q2+L8t8xAFyRvRBvvYgtJdJCwt5GkDRgJEeTXAjL1OVQUkbx+1rg/fKxcUKQaEExzm
	19cTFBqo7QLV07xtlVH4PBMd1rtoQOxqVU6gUTME7hz+R4lqlHCQnBXr47jZX3VuGL9Ze1pTMCWq8
	x4oLWu1pDD0WETLI+HaGPFoBDEV8vzET0vqbnfidHBijY9ZKLX8E7Sjc/7OyRkwuOI7aJgvzF3PlQ
	VDiyYlU1HB2xsQbHajkXXbedToEnahODVI+WJva5Pdlj8dqzVb0QG9dqyOH8TSJK2r4TFtPF2MOUK
	uzZphovg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQJs6-00000001LcR-0joK;
	Sun, 07 Jul 2024 04:51:34 +0000
Message-ID: <6fa86cb0-a795-4e5f-b8c7-50c69ff86792@infradead.org>
Date: Sat, 6 Jul 2024 21:51:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Removed extra asterisks from comment beginnings, and
 removed unnecessary comment end
To: Gold Side <goldside000@outlook.com>, "perex@perex.cz" <perex@perex.cz>,
 "krzk@kernel.org" <krzk@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
References: <DM4P223MB054192AAFD5EA92A22AC8323F7D92@DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <DM4P223MB054192AAFD5EA92A22AC8323F7D92@DM4P223MB0541.NAMP223.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/6/24 9:14 PM, Gold Side wrote:
> From 072a5624cf67614a7f64d6ba15773f85ee5a2e1d Mon Sep 17 00:00:00 2001
> From: Steven Davis <goldside000@outlook.com>
> Date: Wed, 3 Jul 2024 16:00:15 -0400
> Subject: [PATCH 3/3] Removed, like, 30,000 more useless asterisks
> 
> Is there a reason for those extra asterisks to be in there? Seems unnecessary.

Yes, they are for kernel-doc comments, which aid in generating documentation.
They are not unnecessary.

> Signed-off-by: Steven Davis <goldside000@outlook.com>
> ---
>  sound/sound_core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/sound_core.c b/sound/sound_core.c
> index d81fed1c122699..6d446c5bb94a0f 100644
> --- a/sound/sound_core.c
> +++ b/sound/sound_core.c
> @@ -331,7 +331,7 @@ static void sound_remove_unit(struct sound_unit **list, int unit)
>  
>  static struct sound_unit *chains[SOUND_STEP];
>  
> -/**
> +/*
>   *   register_sound_special_device - register a special sound node
>   *   @fops: File operations for the driver
>   *   @unit: Unit number to allocate
> @@ -418,7 +418,7 @@ int register_sound_special(const struct file_operations *fops, int unit)
>  
>  EXPORT_SYMBOL(register_sound_special);
>  
> -/**
> +/*
>   *   register_sound_mixer - register a mixer device
>   *   @fops: File operations for the driver
>   *   @dev: Unit number to allocate
> @@ -443,7 +443,7 @@ EXPORT_SYMBOL(register_sound_mixer);
>   *   in open - see below.
>   */
>   
> -/**
> +/*
>   *   register_sound_dsp - register a DSP device
>   *   @fops: File operations for the driver
>   *   @dev: Unit number to allocate
> @@ -466,7 +466,7 @@ int register_sound_dsp(const struct file_operations *fops, int dev)
>  
>  EXPORT_SYMBOL(register_sound_dsp);
>  
> -/**
> +/*
>   *   unregister_sound_special - unregister a special sound device
>   *   @unit: unit number to allocate
>   *
> @@ -483,7 +483,7 @@ void unregister_sound_special(int unit)
>   
>  EXPORT_SYMBOL(unregister_sound_special);
>  
> -/**
> +/*
>   *   unregister_sound_mixer - unregister a mixer
>   *   @unit: unit number to allocate
>   *
> @@ -498,7 +498,7 @@ void unregister_sound_mixer(int unit)
>  
>  EXPORT_SYMBOL(unregister_sound_mixer);
>  
> -/**
> +/*
>   *   unregister_sound_dsp - unregister a DSP device
>   *   @unit: unit number to allocate
>   *

-- 
~Randy

