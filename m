Return-Path: <linux-kernel+bounces-341045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88118987ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9952814BA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ACB188720;
	Thu, 26 Sep 2024 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="TfMtX7TP"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5F18870F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727386610; cv=none; b=pyWAT0f5YBjda1dsLM/2xuFm4efdvglpvROgcP5RuCJL0FvySQm9huljagrTR3vECNucLpBg84q0Bb3KmrMNazJTM7bfSbF0cmMbhICZQvsnC5dhPb2kyj6OQH/WwF1JxhGdEASUeUtyQ8cqf/lmTkwhSclWknTKw82qc5IvC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727386610; c=relaxed/simple;
	bh=uLj1TQIz29YvWyZC9daB78m4qX8efmzwOi2AwGOGz14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3R+pFQ5mrqQeIEyv7TWx4mps+69OCMKjs9o+vwJRndEQ6VpTy5AtoWfLf+5NKQYnmXVvyt6PzCH+gW9Jc5hzhvU5uyCklFLUj8enhUUOpyk39mq45enWOLxsOZfPtSsfLbQb6xf+7Eije0vZpEtf8wvXMGmge3sccLoAlVQ6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=TfMtX7TP; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3C02D88EEF;
	Thu, 26 Sep 2024 23:36:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727386607;
	bh=cZohkt9lhUoK00lVteVbt+pjYX2ufVHgWjn8qzAq7xg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TfMtX7TPJyHEETWYre0O89dF+DDkFzQH9zD/y3zqRn/0SqRy2YZToXwl4A7bz8AL4
	 6whfbOzvEsJtDqIWPmc8/V+/8S3lBThejYUPZkzq74YqQEwUtVs1TCMF/A4wuuWlek
	 G08BtnjD3kxZGP80pDOwD+/XryOPXaptdduchQMd9skQtx1mF4C57dx83hVWMImQSY
	 fq5srM4ztQg15w8sShIq4SGBFaQn8Qn2nc+bsoyGZHaXTfzkTCY55h2LEaRwqtKcMh
	 Bz20SvCnYxmxXEI7NHAL4FUpDf6GyqC2pnizzNp9VFBNN/5RLXFccdyH4b+hC0K480
	 rZdQelrT5oNog==
Message-ID: <ac403563-34ee-4ba1-b658-06f8df0f5f90@denx.de>
Date: Thu, 26 Sep 2024 23:26:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: imx8m: Probe the SoC driver as platform driver
To: Saravana Kannan <saravanak@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel@dh-electronics.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Fabio Estevam <festevam@gmail.com>, Jeff Johnson
 <quic_jjohnson@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240925220552.149551-1-marex@denx.de>
 <a9967a8c-8e03-44c2-8f79-14c6dd5d74af@app.fastmail.com>
 <CAGETcx8opbQ=+dBkSWwfCoqGsvUBftJm7VaGULZhC5DNyuktJQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAGETcx8opbQ=+dBkSWwfCoqGsvUBftJm7VaGULZhC5DNyuktJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/26/24 7:36 PM, Saravana Kannan wrote:
> On Wed, Sep 25, 2024 at 11:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Wed, Sep 25, 2024, at 22:04, Marek Vasut wrote:
>>> With driver_async_probe=* on kernel command line, the following trace is
>>> produced because on i.MX8M Plus hardware because the soc-imx8m.c driver
>>> calls of_clk_get_by_name() which returns -EPROBE_DEFER because the clock
>>> driver is not yet probed. This was not detected during regular testing
>>> without driver_async_probe.
>>>
>>> Convert the SoC code to platform driver and instantiate a platform device
>>> in its current device_initcall() to probe the platform driver. Rework
>>> .soc_revision callback to always return valid error code and return SoC
>>> revision via parameter. This way, if anything in the .soc_revision callback
>>> return -EPROBE_DEFER, it gets propagated to .probe and the .probe will get
>>> retried later.
>>
>> Thanks for the new version, that was quick!
>>
>>> +static struct platform_driver imx8m_soc_driver = {
>>> +     .probe = imx8m_soc_probe,
>>> +     .driver = {
>>> +             .name = "imx8m-soc",
>>> +     },
>>> +};
>>> +module_platform_driver(imx8m_soc_driver);
>>> +
>>> +static int __init imx8_soc_init(void)
>>> +{
>>> +     struct platform_device *pdev;
>>> +
>>> +     pdev = platform_device_register_simple("imx8m-soc", -1, NULL, 0);
>>> +
>>> +     return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
>>> +}
>>>   device_initcall(imx8_soc_init);
>>
>> Did you run into problems with the method I suggested first?
>>
>> I don't like the way that this version still registers both the
>> device and driver regardless of the hardware it runs on, I'd
>> prefer to leave the platform check in the initcall and
>> only register them if we are actually on an imx8 machine.
>>
>> Having two initcalls also makes it impossible to build this
>> as a loadable module, which is why I suggested
>> platform_create_bundle().
> 
> That particular helper doesn't seem to like probe deferral because it
> allows for some of the code to be in init sections. So, it gets
> dropped after module load is complete. So, Marek will still have to
> register the device and driver separately. But I agree that it might
> be better to NOT register the device and driver if the basic
> conditions aren't met.
Fixed in V3.

