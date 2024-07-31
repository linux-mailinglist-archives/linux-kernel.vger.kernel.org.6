Return-Path: <linux-kernel+bounces-268622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A5C942711
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B469B282637
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFD116D9B3;
	Wed, 31 Jul 2024 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="jqhe/tyJ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0049624;
	Wed, 31 Jul 2024 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407886; cv=none; b=mlu1hhuUZOXDVGwOMPoRRM/q7sAZdiY4KtiwQp/39vbibeCWW7nobZREJJaRQV6JClpz9q7bSJMDtuEllf9d8NL0NivS9H0vsrZhKAMkmXTXbB9//t4Um0W6WAcW3n2gLIDEz6Kk1bZ0UzHPmAH6juXBDVRF2kNDRHBHj2cxHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407886; c=relaxed/simple;
	bh=L1QXg3uqxYl4CTovcnxt95DP+CEt5OQZZcl1u0OySnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLlav6yHpAxqQ4ommHpqkzn+k9Ph/4kA9edPvIsk5fBek+Mj1LLyzPmza0dnu6vq30T+OKT3MsXkKT6gAqlM/Wj0dLHw3bPMQL5YpSmoVaabYs1cz170y/EENzg0AcG/HEJ7wEdQulkZG+K1zn7Sba6rTNk/GohI6mMYtJW9mjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=jqhe/tyJ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=P1V0z9JyXNMjXUrrv9MyjJnAXiVD3xEEot8JcZbXg2w=;
	t=1722407884; x=1722839884; b=jqhe/tyJToFnr96kQpiEys0KNdmNcFU4Z90ED1uEQd9JMWL
	/FXC8FdXHRzr/8rJDp36xSt5xMovzhvlWbw1wezHKvMHSarG+mK7d5WNqGhBiVniC9CzcmdCJM0p/
	6Z40Vq4u8Jzw5lEU15fyX4zF8J4JpPaGqzf35yGZpiRAGjG7hI314ZP5zSBRGJ1nvuLgezu2x9sJI
	4EsnEpDX+bjjEIQnjglYqxsDKcagg4h0ImGX0O+RQQy3xP1gnWfe6xOzciuzUu7tzjfumXOTbzgBs
	cIyFkty60oXIbA410jW/TDzJ0TfgT6gc9r6CeTlXTl8ZMtCn7gBzDEvI8lJqZABQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sZ2yH-00070r-AD; Wed, 31 Jul 2024 08:38:01 +0200
Message-ID: <245f2c54-6d06-4b71-a9f8-a6fc0dbcceb3@leemhuis.info>
Date: Wed, 31 Jul 2024 08:38:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Brightness at max level after waking up from sleep
 on AMD Laptop
To: hamza.mahfooz@amd.com
Cc: regressions@lists.linux.dev, alexander.deucher@amd.com,
 serg.partizan@gmail.com,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 mario.limonciello@amd.com, ML dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <77KAHS.13UUH2XVHQQF1@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <77KAHS.13UUH2XVHQQF1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1722407884;56903427;
X-HE-SMSGID: 1sZ2yH-00070r-AD

[+amd-glx, +lkml, +dri-devel]

On 27.07.24 18:52, serg.partizan@gmail.com wrote:
> 
> After updating from 6.8.9 to 6.9.1 I noticed a bug on my HP Envy x360
> with AMD Ryzen 5 4500U.
>
> [...]
> After waking up from sleep brightness is set to max level, ignoring
> previous value.
> 
> With the help of Arch Linux team, we was able to track bad commit to
> this:
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/63d0b87213a0ba241b3fcfba3fe7b0aed0cd1cc5

Hamza Mahfooz, in case you missed it, that is a patch of yours:
63d0b87213a0ba ("drm/amd/display: add panel_power_savings sysfs entry to
eDP connectors") [v6.9-rc1].

> I have tested this on latest mainline kernel:
> 
> Results after waking up:
> 
>> cat /sys/class/backlight/amdgpu_bl1/{brightness,actual_brightness}
> 12
> 252
> 
> Then, on exact this commit (63d0b87213a0ba241b3fcfba3fe7b0aed0cd1cc5),
> result is the same.
> 
> Then, on commit just before this one (aeaf3e6cf842):
> 
>> cat /sys/class/backlight/amdgpu_bl1/{brightness,actual_brightness}
> 12
> 12
> 
> I hope I included all relevant information, more info can be found here:
> 
> https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/52

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.:

#regzbot introduced: 63d0b87213a0ba241

