Return-Path: <linux-kernel+bounces-341046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B4987ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD78D280D32
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25672188734;
	Thu, 26 Sep 2024 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="H844pCf7"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD79188719
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727386611; cv=none; b=hsm5DSi/LkXn3WAtybw2WSxQT3I4R9vvJyDWvsMm8Yn3JP4eQ7LDhG+4d9D9IgUeRne+NvCPUl7WIbRo4YYVN0xfPvt2o8aGrKuC5opidpPEdSis+1ByyShp3NvFuFsoTUcDMyy1+a6Zw62xlb0xYc1RpqD4KZZMuYaJXY6ntVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727386611; c=relaxed/simple;
	bh=7/i64ZwALR/u1yY/pGZnzgaQHj98Hoe6B7sFzP7ir1I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D8nKjc3uafsKV/4Z8WEIji6J5h5PI55dgjaBDHjh/qQGxFdDKwezGxrtpQk11FvjouQEaX6+48CaaKyyXp8QfCWrdIm0RVNdLjjXVoeH7hl6MpKBbwn52zs4tqtxsojs+iqo0fq5m3KmGXJfjV5zJ2llhFaQhFePtjF1F9H0OZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=H844pCf7; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7BB7C88F01;
	Thu, 26 Sep 2024 23:36:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727386608;
	bh=pQm6hWBbP8aED+PgrpCMWQNkhSYBem+FgR6UjXOzVzg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=H844pCf7f52aq/kSX1NuRGWsbtE4Hch8dSPfsQcjiU3zQtJQUZ8Rn3p9h2JxiFrA1
	 Sh22i5vNz1XxWbt0x4SCft8Y7MAIq17UjVOghXki0Cov2iRS8451QpFpoHjebeQiG2
	 FEmk4vVqrQ/0LUTOcl//pClKZsiffzZ2lI6pJ7kUbfYyUTYbw4j6MZpiU1wvQxPlM3
	 pmQ+bPSQZIHYnbsDbMbKldPX4Ngc7mKJSIvOjw1jbnscDHYmd2mgcVwW2OiNB7g5qM
	 lzD7BHAzC9smFZgbGmkpiHlAWn7fm7U7gWVd5r9bS8quU9i3ADAS1GYWrBEdSRAdwv
	 c39VcTDmC2qbg==
Message-ID: <3aaa4265-dfd5-47e3-9cfc-ca3fa649f425@denx.de>
Date: Thu, 26 Sep 2024 23:35:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2] soc: imx8m: Probe the SoC driver as platform driver
To: Saravana Kannan <saravanak@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@dh-electronics.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240925220552.149551-1-marex@denx.de>
 <CAGETcx9Gnbtt8m+tKZrw6fU_jM1idJ2wJZuz_EyOPq5wpm3Z1w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGETcx9Gnbtt8m+tKZrw6fU_jM1idJ2wJZuz_EyOPq5wpm3Z1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/26/24 1:03 AM, Saravana Kannan wrote:
> On Wed, Sep 25, 2024 at 3:06 PM Marek Vasut <marex@denx.de> wrote:
>>
>> With driver_async_probe=* on kernel command line, the following trace is
>> produced because on i.MX8M Plus hardware because the soc-imx8m.c driver
>> calls of_clk_get_by_name() which returns -EPROBE_DEFER because the clock
>> driver is not yet probed. This was not detected during regular testing
>> without driver_async_probe.
>>
>> Convert the SoC code to platform driver and instantiate a platform device
>> in its current device_initcall() to probe the platform driver. Rework
>> .soc_revision callback to always return valid error code and return SoC
>> revision via parameter. This way, if anything in the .soc_revision callback
>> return -EPROBE_DEFER, it gets propagated to .probe and the .probe will get
>> retried later.
> 
> I'm assuming you tested this patch and it works?

I tested it both with and without driver_async_probe=*

> Did you see any other
> issues with driver_async_probe=* ?

Nope, just this one.

> Does this improve your probe/boot time? Some stats on that would be nice.

It does improve the boot time from 4.5 to 2.9 seconds (measured by 
looking at the kernel log, so imprecise, but noticeable). With 'quiet' 
on kernel command line, boot time drops from 2.99s to 2.34s .

>> "
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 1 at drivers/soc/imx/soc-imx8m.c:115 imx8mm_soc_revision+0xdc/0x180
>> CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-next-20240924-00002-g2062bb554dea #603
>> Hardware name: DH electronics i.MX8M Plus DHCOM Premium Developer Kit (3) (DT)
>> pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : imx8mm_soc_revision+0xdc/0x180
>> lr : imx8mm_soc_revision+0xd0/0x180
>> sp : ffff8000821fbcc0
>> x29: ffff8000821fbce0 x28: 0000000000000000 x27: ffff800081810120
>> x26: ffff8000818a9970 x25: 0000000000000006 x24: 0000000000824311
>> x23: ffff8000817f42c8 x22: ffff0000df8be210 x21: fffffffffffffdfb
>> x20: ffff800082780000 x19: 0000000000000001 x18: ffffffffffffffff
>> x17: ffff800081fff418 x16: ffff8000823e1000 x15: ffff0000c03b65e8
>> x14: ffff0000c00051b0 x13: ffff800082790000 x12: 0000000000000801
>> x11: ffff80008278ffff x10: ffff80008209d3a6 x9 : ffff80008062e95c
>> x8 : ffff8000821fb9a0 x7 : 0000000000000000 x6 : 00000000000080e3
>> x5 : ffff0000df8c03d8 x4 : 0000000000000000 x3 : 0000000000000000
>> x2 : 0000000000000000 x1 : fffffffffffffdfb x0 : fffffffffffffdfb
>> Call trace:
>>   imx8mm_soc_revision+0xdc/0x180
>>   imx8_soc_init+0xb0/0x1e0
>>   do_one_initcall+0x94/0x1a8
>>   kernel_init_freeable+0x240/0x2a8
>>   kernel_init+0x28/0x140
>>   ret_from_fork+0x10/0x20
>> ---[ end trace 0000000000000000 ]---
>> SoC: i.MX8MP revision 1.1
>> "

[...]

>> +static struct platform_driver imx8m_soc_driver = {
>> +       .probe = imx8m_soc_probe,
>> +       .driver = {
>> +               .name = "imx8m-soc",
>> +       },
>> +};
>> +module_platform_driver(imx8m_soc_driver);
> 
> This just translates to a module_init() when compiled as a module.
> 
>>
>> +
>> +static int __init imx8_soc_init(void)
>> +{
>> +       struct platform_device *pdev;
>> +
>> +       pdev = platform_device_register_simple("imx8m-soc", -1, NULL, 0);
>> +
>> +       return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
>> +}
>>   device_initcall(imx8_soc_init);
> 
> This also translates to a module_init() when compiled as a module.
> 
> I've never seen a module with two module_init()s and I'm pretty sure
> that doesn't work. I'm guessing this driver doesn't support tristate
> in its current state. But with this patch, it should work as a module
> too. Why not add support for that too?

I am not entirely sure whether there are no dependencies on this soc 
driver, so let's start with builtin .

> Why not just do both of these things in one initcall?
> platform_create_bundle() doesn't work with deferred probing though. So
> just do one initcall that adds the device and registers the platform
> driver.

Fixed in V3.

[...]

