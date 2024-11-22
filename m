Return-Path: <linux-kernel+bounces-418073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669F19D5CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9796BB24E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B83F1DE3B4;
	Fri, 22 Nov 2024 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLaU/E4e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694C1DE3A2;
	Fri, 22 Nov 2024 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269575; cv=none; b=e45hZagyMvm22vEDjV9fvvQ8PyRg6HtikMryqBaD2r3BdPaseL6lRmNwXsv0xFwY7mM9MczKwOpfjOLO6Qgk9Y9gUBVf0PaicOkKQoVWJVjBUoJ2p+WK5e5xcF78FDUOJuj9lJmPFzOW6mJ0kt9EOpr1BIxZMUHh2renTjJ9xvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269575; c=relaxed/simple;
	bh=0ftWDSX41M/H1Xuk75QeX8CBR8oUnrbEjm0UfJzEf30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPg0kP8xQvT2heEWZNfEsnhdXjzSVo2x7F8O8bdNMSpJhoeVgKpfqo7v1JtENYNwNf7Cf0t2UyfYb6rf8sA+cIgAD8h1//HrNDvMq+exQvaBUWrV/3yykjGHp44sGNSQB9uC2AClzI9mG7yGgld/kSalOx5CCQgBZc0RVDzJh/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLaU/E4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B23C4CED7;
	Fri, 22 Nov 2024 09:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732269573;
	bh=0ftWDSX41M/H1Xuk75QeX8CBR8oUnrbEjm0UfJzEf30=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lLaU/E4eB91C5DQq/cwO3HkPlxay7OZkwOSTa4d+Mzc0NC6prGZaSYqckUGJjWvQC
	 kRbyEKtNdCNNio3/5r5gfrRb9vOlDlPj9uoewaO7KFVBsV1EecD1O02gMGSY4E4kWO
	 CXKO4x2IY0U1XGHA1fKCW5840MPSMVcTSqdKzU1Or846i20CoBAY9+DGbroYkenMkM
	 nALzxJi+4E2tg5Lv6LnqKWO+ApZ76wyx6W7VpI+VDACfAgaEw3tCNjXn2kFJEbWWv+
	 7+rJ+LMn0DPKZpUD9pFHqFZPqgvZZ39clgtj35x+PMg7OGuDOBW89YtIQGJKx1G10a
	 pr7XgGGBDj9Ng==
Message-ID: <34f5e893-bb52-4e48-a854-0967b39cae28@kernel.org>
Date: Fri, 22 Nov 2024 10:59:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] memory: mtk-smi: mt8188: Add SMI clamp function
To: =?UTF-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20241120063701.8194-1-friday.yang@mediatek.com>
 <20241120063701.8194-3-friday.yang@mediatek.com>
 <5bf3bdab-8614-4024-a9da-f7f58414c0af@kernel.org>
 <e18bf1ba05c86b26fb4f18c444a19b391df29c55.camel@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <e18bf1ba05c86b26fb4f18c444a19b391df29c55.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/11/2024 10:41, Friday Yang (杨阳) wrote:
> On Wed, 2024-11-20 at 08:49 +0100, Krzysztof Kozlowski wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> On 20/11/2024 07:36, Friday Yang wrote:
>>> In order to avoid handling glitch signal when MTCMOS on/off, SMI
>>> need
>>> clamp and reset operation. Parse power reset settings for LARBs
>>> which
>>> need to reset. Register genpd callback for SMI LARBs and apply
>>> reset
>>> operations in the callback.
>>>
>>> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
>>> ---
>>>  drivers/memory/mtk-smi.c | 175
>>> ++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 171 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
>>> index 2bc034dff691..c7119f655350 100644
>>> --- a/drivers/memory/mtk-smi.c
>>> +++ b/drivers/memory/mtk-smi.c
>>> @@ -10,15 +10,21 @@
>>>  #include <linux/err.h>
>>>  #include <linux/io.h>
>>>  #include <linux/iopoll.h>
>>> +#include <linux/mfd/syscon.h>
>>
>> Where do you use it?
> 
> device_node_to_regmap need this header file.

Ah, indeed, but then I wonder why you parse phandle instead of using
standard syscon API: syscon_regmap_lookup_by_phandle().


> 
>>
>>>  #include <linux/module.h>
>>>  #include <linux/of.h>
>>>  #include <linux/of_platform.h>
>>>  #include <linux/platform_device.h>
>>> +#include <linux/pm_domain.h>
>>
>> Where do you use it?
> 
> dev_pm_genpd_add_notifier need this header file.

ack

> 
>>
>>>  #include <linux/pm_runtime.h>
>>> +#include <linux/regmap.h>
>>
>> Where do you use it?
> 
> regmap_write need this header file.

ack

> 
>>
>>> +#include <linux/reset.h>
>>> +#include <linux/reset-controller.h>
>>>  #include <linux/soc/mediatek/mtk_sip_svc.h>
>>>  #include <soc/mediatek/smi.h>
>>>  #include <dt-bindings/memory/mt2701-larb-port.h>
>>>  #include <dt-bindings/memory/mtk-memory-port.h>
>>> +#include <dt-bindings/reset/mt8188-resets.h>
>>>
>>
>> ...
> 
> reset_control_reset/devm_reset_control_get need reset.h
> But reset-controller.h could be removed.
> MT8188_SMI_RST_LARB10 and other index need mt8188-resets.h 
> 
>>
>>>
>>> +static int mtk_smi_larb_parse_clamp_info(struct mtk_smi_larb
>>> *larb)
>>> +{
>>> +     struct device *dev = larb->dev;
>>> +     const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
>>> +     struct device_node *smi_node;
>>> +     struct of_phandle_args args;
>>> +     int ret, index;
>>> +
>>> +     /* Only SMI LARBs located in camera and image subsys need to
>>
>> Use Linux coding style.
> 
> Sorry for the mistake, I will fix it.
> 
>>
>>> +      * apply clamp and reset operation, others can be skipped.
>>> +      */
>>> +     ret = of_parse_phandle_with_fixed_args(dev->of_node,
>>> +                                            "resets", 1, 0,
>>> &args);
>>
>> NAK
>>
>>> +     if (ret)
>>> +             return 0;
>>> +
>>> +     smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
>>> +     if (!smi_node)
>>> +             return -EINVAL;
>>> +
>>> +     index = args.args[0];
>>
>> That's reset, not clamp port. NAK.
> 
> I could change from 'clamp_port' to 'reset_port'.
> This index is used for getting the port id from the array
> 'mtk_smi_larb_clamp_port_mt8188 ' in SMI driver.

Index is for reset, not for port ID.

> It could also be used for getting the reset signal in
> SMI reset controller driver.
> 

Look at my comments from previous version - they were not under reset
property. The argument for reset is for reset provider, not this reset
consumer.

BTW, when you link to previous versions of patchset, link to lore, not
patchwork. Or just use b4.

Best regards,
Krzysztof

