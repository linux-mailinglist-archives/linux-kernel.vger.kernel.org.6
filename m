Return-Path: <linux-kernel+bounces-416798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C65C9D4A65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95ECDB2173A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CA51CBA1B;
	Thu, 21 Nov 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUDO8WC5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD05695;
	Thu, 21 Nov 2024 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732183416; cv=none; b=fuhhpNWyCT0TekYKGbzp2xR31W40rTr89jrrmkoO/eL4RkhY1jbVay2YOLX+xbDn8y84opq7C8ARisGukwSitSjtgAIDA+hWNRSQXTAf+ooHjGE7Ip9pxSjBLW0BD3LSTp6SsI/jwOR7EhBBuV0xVwW1R2SckOC9I6h2PhLsz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732183416; c=relaxed/simple;
	bh=yUFMSqVABQFpF2Uh/kLBLBUGGQq/2hSOL8FF4zayNDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtK7SxaQDSCMr7SKlZNfnEIJ+FtfQlDp7IK2aJWnnmr21wq3MsPzub/mlEHDXTatmcKY8i0rrJ8DfU9oL7xxzkcmY3JiLDxT6XON7DE0hKcrVhFOXXcXpoji+8FzMQSihSSlEjJLW3Upr2rlMH2mNstJYzcA+J2h7cwglwVE2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUDO8WC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875C2C4CECE;
	Thu, 21 Nov 2024 10:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732183415;
	bh=yUFMSqVABQFpF2Uh/kLBLBUGGQq/2hSOL8FF4zayNDc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dUDO8WC522K3Y0MkqgP25TSysFI3CBbIAe/+a49XMBHTMHw6E2raTrRjiH9gvkqU/
	 i7xDcYO7BNJdCZYgiaLGos+EDiZZ8TpmIg3EKtc0DJmeGDexEqq0MZdBZCEE9P6i/i
	 IaP3To1FV8xHixBhLiwCnTrjT+uach7Yf8hmvcGgNJ7swhuY3L72ZEpugvRhSYgl4H
	 g6WwB/uuqTCtYmPmXRgTvwU9PrMtmt36ApJ66J73KLpgOQZ5EedEPmy9zAMxO4K2Ml
	 lYnJaxR+zPOkrxI/XWcs3nvcIfCRgABMe53HAQ9j84TvItTD/cp34xrLdxCPDMi+nr
	 3wT2saJpf6IlA==
Message-ID: <ccf63c6c-c9a0-4a15-9edf-8d2bfdc78538@kernel.org>
Date: Thu, 21 Nov 2024 11:03:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] drm: bridge: inno-hdmi: add inno bridge driver.
To: Keith Zhao <keith.zhao@starfivetech.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "rfoss@kernel.org" <rfoss@kernel.org>,
 "Laurent.pinchart@ideasonboard.com" <Laurent.pinchart@ideasonboard.com>,
 "jonas@kwiboo.se" <jonas@kwiboo.se>,
 "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "hjc@rock-chips.com" <hjc@rock-chips.com>, "heiko@sntech.de"
 <heiko@sntech.de>, "andy.yan@rock-chips.com" <andy.yan@rock-chips.com>,
 William Qiu <william.qiu@starfivetech.com>,
 Xingyu Wu <xingyu.wu@starfivetech.com>, "kernel@esmil.dk" <kernel@esmil.dk>,
 "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 Changhuang Liang <changhuang.liang@starfivetech.com>,
 Jack Zhu <jack.zhu@starfivetech.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241120061848.196754-1-keith.zhao@starfivetech.com>
 <20241120061848.196754-4-keith.zhao@starfivetech.com>
 <410ebbd0-2304-4d9e-8d4a-5e63ab29ada8@kernel.org>
 <NTZPR01MB1050A2F29632FFC065AEEDCBEE22A@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <NTZPR01MB1050A2F29632FFC065AEEDCBEE22A@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/11/2024 03:15, Keith Zhao wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: 2024年11月20日 15:38
>> To: Keith Zhao <keith.zhao@starfivetech.com>; devicetree@vger.kernel.org;
>> dri-devel@lists.freedesktop.org
>> Cc: andrzej.hajda@intel.com; neil.armstrong@linaro.org; rfoss@kernel.org;
>> Laurent.pinchart@ideasonboard.com; jonas@kwiboo.se;
>> jernej.skrabec@gmail.com; maarten.lankhorst@linux.intel.com;
>> mripard@kernel.org; tzimmermann@suse.de; airlied@gmail.com;
>> simona@ffwll.ch; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
>> hjc@rock-chips.com; heiko@sntech.de; andy.yan@rock-chips.com; William Qiu
>> <william.qiu@starfivetech.com>; Xingyu Wu <xingyu.wu@starfivetech.com>;
>> kernel@esmil.dk; paul.walmsley@sifive.com; palmer@dabbelt.com;
>> aou@eecs.berkeley.edu; p.zabel@pengutronix.de; Changhuang Liang
>> <changhuang.liang@starfivetech.com>; Jack Zhu <jack.zhu@starfivetech.com>;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v5 3/9] drm: bridge: inno-hdmi: add inno bridge driver.
>>
>> On 20/11/2024 07:18, keith zhao wrote:
>>> +	/* Unmute hotplug interrupt */
>>> +	hdmi_modb(hdmi, HDMI_STATUS, m_MASK_INT_HOTPLUG,
>>> +v_MASK_INT_HOTPLUG(1));
>>> +
>>> +	ret = devm_request_threaded_irq(hdmi->dev, irq, inno_hdmi_hardirq,
>>> +					inno_hdmi_irq, IRQF_SHARED,
>>> +					dev_name(hdmi->dev), hdmi);
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(inno_hdmi_bind);
>>> +
>>> +MODULE_AUTHOR("Keith Zhao <keithzhao@starfivetech.com>");
>>> +MODULE_DESCRIPTION("INNO HDMI transmitter driver");
>>> +MODULE_LICENSE("GPL"); MODULE_ALIAS("platform:inno-hdmi");
>>
>> You should not need MODULE_ALIAS() in normal cases. If you need it, usually it
>> means your device ID table is wrong (e.g. misses either entries or
>> MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute for incomplete
>> ID table.
>>
> Thank you for your suggestion! 
> I will review the device ID table to ensure its completeness 
> and avoid using MODULE_ALIAS().

In this context neither MODULE_ALIAS nor ID table are suitable/needed.
If you need them, means your driver does not build in all setups :/
Best regards,
Krzysztof

