Return-Path: <linux-kernel+bounces-190467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552F78CFEAD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B7C1F22387
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAF813B7A7;
	Mon, 27 May 2024 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="euVLF9yJ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080C13A259;
	Mon, 27 May 2024 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808580; cv=none; b=HGtCGwR8Ix7YH8sl/fAYZlLbuumrp2mYHND2a3YhI4BXAgM8tfEO2yojKYr/LvJkWJA/9dFyNOVyEQTKUrNzMdHfJ2fy3rYCRJvumHQ/PvoJ+ua91vMfLra8kX+tKv9pXEcx4yIxP9S8qaVfEZcEv3CO2w08cU26NEdaPGL0MLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808580; c=relaxed/simple;
	bh=mwCYwCCjvL4nTs5rhRxkGA0LBcbSZqOtDLfeWOP6FlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rjqua2odXWZuydMoLZGQe9KbqILhvsz5WDr+DjRtpabSFP0D6FfbfKH8hT+8o9e0uTZzUWVnDVU0owCS19DAeZvmPyYEfEJXtmqaz7gjwnI9IIL26cfC+p2S8k/sVZgmdCH7dYUmbZG6lWL/b4ictcDLqgnWFiloYVlB5F4tPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=euVLF9yJ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=1SX+hjPO8iXzPnEmnZdrhvcBPehECadE4WnLUAtHG/s=; t=1716808578;
	x=1717240578; b=euVLF9yJ6YWu2KNmkUZ1lyXFynOoZ3xTLXUw3AYhUJHWIIfglOx0bWpEZsmpx
	YxRx4o4VMlsAglN6pix1mFmwEzDlLLwQEMp7/EmN8llM+AqO7tcbJU23m6sIdw4yLrD4mfNzJiMPp
	unlWajG300Gea9yksytXZEmEJ5FXtrJUTMdnF6PUAHcD2mZNOXfKDAeMMTcS2J4licgvZYLewzjrX
	f5xsVGDLFHJhYEayHJ4PL2vkA2mQ6LUX0lwPjUYXs3ULB4QjPxGnqslhpkgPO+nIxAC+OsTkaXrgF
	kQkOCMLm7q1+s+B23ikP5N16YbMYstDcaSMke9rLIoIM4PIerw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sBYKk-0003Yd-SU; Mon, 27 May 2024 13:16:06 +0200
Message-ID: <d7f0c16a-0d83-4060-8d95-95b293d95dfd@leemhuis.info>
Date: Mon, 27 May 2024 13:16:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
To: Ron Economos <re@w6rz.net>, Guenter Roeck <linux@roeck-us.net>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 regressions@lists.linux.dev, linux-clk@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>
References: <28114882-f8d7-21bf-4536-a186e8d7a22a@w6rz.net>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <28114882-f8d7-21bf-4536-a186e8d7a22a@w6rz.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716808578;bfb9d9e0;
X-HE-SMSGID: 1sBYKk-0003Yd-SU

On 27.05.24 12:45, Ron Economos wrote:
> On Fri, May 17, 2024 at 03:09:14PM -0700, Guenter Roeck wrote:
>>
>> On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
>> > Report an error when an attempt to register a clkdev entry results in a
>> > truncated string so the problem can be easily spotted.
>> >
>> > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
>> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>>
>> With this patch in the mainline kernel, I get
>> [...]
>> when trying to boot sifive_u in qemu.
>>
>> Apparently, "10000000.clock-controller" is too long. Any suggestion on
>> how to solve the problem ? I guess using dev_name(dev) as dev_id
> parameter
>> for clk_hw_register_clkdev() is not or no longer a good idea.
>> What else should be used instead ?
> 
> This issue causes a complete boot failure on real hardware (SiFive
> Unmatched).

Hmmm. That and because nobody afaics has time/motivation to fix this
anytime soon (or am I mistaken there?) makes me wonder if we should
revert this change for now (and remerge it later once the problem this
change exposed was fixed). Or is another solution in sight somewhere?

Ciao, Thorsten

> The boot only gets as far as "Starting kernel ..." with no
> other indication of what's going on.
> 
> Guenter's suggested patch solves the issue.
> 
> diff --git a/drivers/clk/sifive/sifive-prci.c
> b/drivers/clk/sifive/sifive-prci.c
> index 25b8e1a80ddc..20cc8f42d9eb 100644
> --- a/drivers/clk/sifive/sifive-prci.c
> +++ b/drivers/clk/sifive/sifive-prci.c
> @@ -537,7 +537,7 @@ static int __prci_register_clocks(struct device
> *dev, struct __prci_data *pd,
>                          return r;
>                  }
> 
> -               r = clk_hw_register_clkdev(&pic->hw, pic->name,
> dev_name(dev));
> +               r = clk_hw_register_clkdev(&pic->hw, pic->name, "prci");
>                  if (r) {
>                          dev_warn(dev, "Failed to register clkdev for
> %s: %d\n",
>                                   init.name, r);
> 
> 
> 

#regzbot dup:
https://lore.kernel.org/lkml/7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net/

