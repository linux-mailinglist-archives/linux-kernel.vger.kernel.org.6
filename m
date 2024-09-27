Return-Path: <linux-kernel+bounces-342225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F3C988C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A001C2122D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48FF18BB97;
	Fri, 27 Sep 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="euJNz2wm"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9918A93C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474166; cv=none; b=KODzzIHCVq9zfaN8hYLathcjHcya9jbIDrPq1vV4XEX5e6RJRYWK3WUZTMkyF+vkgTKLxRMBrsaS0AEYgJ0gYj0b8gT+De7QUGvPxAVm6SKoBSFUgnPnuxEpr9PUHuw0JxvmKnvErgrXn3qrOGlkQRUE1GSQLWq+hEexPBTo35Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474166; c=relaxed/simple;
	bh=vFobzuLapNJqa1JFkKMs2L8PJFRop/kO4uJVZ+Q8/LY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbbiFhfOq7P7hxNWEaLhPmzkcvGQjIudVRizNJTvUN7j8Ii9Z4jyM5kHjxuNHberoNr+jbXhxa43Ici0DOqseKqiBcrEYDmCS4cogzgffczdhfwhadr9ZwA78ePatGDZ4xon4OJw30+Mr1PgZuz//Ism9uRukzaYHF7mrjLfNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=euJNz2wm; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A89708913A;
	Fri, 27 Sep 2024 23:55:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727474154;
	bh=1wCrVSekfrRZtVecO31dRGlCjgzqIKbOjbSNaN+r9UE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=euJNz2wmpidlnQLnFqwxsbsJRvPUh2AsHlq4G+NOEduRoQp1LGOluygbnuq/F9JRm
	 YkwVDV9drVXvvQLUTQYfcjMdKFw6FDd1juk3lBru9X9fi8fTR/JamtcCilsB9g3wft
	 DRf3akd7jeeGxwvnYfGI9cj+RADfYSC966vAfrhH6SlqpCxTPZXuN5m4Ygm370wnof
	 /cVAlYQhfbQuGp5sDK56u444+haxnBd3RI8kzziff7wzn280yFHq7mao6pk+Xbp+oF
	 JLjJumgsSNPFl/ZbgG0mVfQpngFpvsmMcNXbSbIBTMJJ7FPbQE+cB0V4qQ0ovoXD4d
	 vjjGkZ8p/Zjhg==
Message-ID: <e32ed329-b012-44f2-854b-80a8b0efc4e6@denx.de>
Date: Fri, 27 Sep 2024 23:42:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] soc: imx8m: Probe the SoC driver as platform
 driver
To: Saravana Kannan <saravanak@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kernel@dh-electronics.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240926213729.2882045-1-marex@denx.de>
 <CAGETcx-q7+DGhPYd3QrsPh7O_0HU7T=NhaJYp0Fu7YW2zwbo7Q@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAGETcx-q7+DGhPYd3QrsPh7O_0HU7T=NhaJYp0Fu7YW2zwbo7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/27/24 1:39 AM, Saravana Kannan wrote:

[...]

>> +static int imx8mq_soc_revision(u32 *socrev)
>>   {
>>          struct device_node *np;
>>          void __iomem *ocotp_base;
>>          u32 magic;
>>          u32 rev;
>>          struct clk *clk;
>> +       int ret;
>>
>>          np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
>>          if (!np)
>> -               return 0;
>> +               return -EINVAL;
>>
>>          ocotp_base = of_iomap(np, 0);
> 
> Using devm_of_iomap() and scoped "whatever it's called" might help
> simplify the error handling.
> 
> So something like this for np:
> struct device_node *np __free(device_node) = np =
> of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
> 
> And this for ocotp_base:
> ocotp_base = devm_of_iomap(dev, np, 0);

This would fail if OCOTP driver probes first and claims the memory area 
with request_mem_region() (or devm_request_mem_region(), used in 
__devm_ioremap_resource() which is called from devm_of_iomap()). I ran 
into this with ANATOP, which is the other iomap()d device here. The 
of_iomap() does not use request_mem_region(), so it can map the area.

> Would mean you can delete all the error handling parts

All right, let's do this in separate 3/3 patch , because the amount of 
changes in this one patch are growing to be too much and difficult to 
review.

[...]

>> @@ -212,8 +240,11 @@ static int __init imx8_soc_init(void)
>>          data = id->data;
>>          if (data) {
>>                  soc_dev_attr->soc_id = data->name;
>> -               if (data->soc_revision)
>> -                       soc_rev = data->soc_revision();
>> +               if (data->soc_revision) {
>> +                       ret = data->soc_revision(&soc_rev);
>> +                       if (ret)
>> +                               goto free_soc;
>> +               }
>>          }
> 
> I'm glad it's working for you, but I think there might still be a race
> that you are just lucky enough to not hit. I think you still need to
> fix up drivers/base/soc.c to return -EPROBE_DEFER when
> soc_device_match() is called but soc_bus_type has no devices
> registered. That way any drivers that try to use that API will defer
> probe until this device gets to probe.

soc_device_match() returns a pointer to soc_device_attribute or NULL, do 
you have some other function in mind ?

> And then you'll have to look at all the callers of that API for the
> boards this driver is meant for and make sure they don't ignore the
> error return value. Just add a WARN() on the API to figure out all the
> callers in your board.
> 
> Also, you might want to check that your list of probed devices doesn't
> change without any async probing or this patch vs with async probing
> and this patch. Quick way to get list of successfully probed devices
> is:
> # find /sys/devices -name driver

It seems OK.

[...]

