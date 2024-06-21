Return-Path: <linux-kernel+bounces-225388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1C191300E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6B01F259BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E217C229;
	Fri, 21 Jun 2024 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qBegDUoD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B4616D310;
	Fri, 21 Jun 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007565; cv=none; b=Zx6Wqxk5RTjnv792L+ztqdbXoOk81L33608EsLU7iK96wua79w+uzXj/kxtIKfphciqVvfaFuubM9/AtZC2+tzri/GTtIyyTu7dBs3/uJAzoaOOa/t2bHZl8/iaFrUFBW+mbD5B0PAExEexZ5K1ZXZenDRL01r7VITh/4v9czsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007565; c=relaxed/simple;
	bh=MJaLeVkFyERVtHBT2g/r5XD6cXEUKTBZEHce/z3g82s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRqnSZVQDD8afmgL8wDEklGT/ebk7Bp8DWlE/eq4KFDpfQBkPkQddEHxFrqthXScl56ITYM/cZm0JtiytlY6cPZi3WGbndjYffJ3CG2t4h5VZ2XaNqr3NEMXXmqLvvSDAJwdlA1exWVkgBDyGZqo12h1fDcUIudenfKMR9QbqS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qBegDUoD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719007562;
	bh=MJaLeVkFyERVtHBT2g/r5XD6cXEUKTBZEHce/z3g82s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qBegDUoDurKTVdNcHFcw5VkH9LSZLcyHToC7OzpzJ3koi3sUHicl1vfsdHP0SVf0E
	 syh3VRXPfN4A0/eJ8oMDyE3ohYJdgaT8GPAiVyBKOZgGk9kfixHejNbATa2QuGTASs
	 YEMmusdDwUvYk1dw8guHwHllLMQL8hcOZSTXU5FslI2R886nYAvmCsyK1ATsnWqvMm
	 1QDf8w6ZWadHGgH1E1xT6qzI7x/u8ndVEMfCAu38T6e3k8JcPwk3GF6+me057Sl1SZ
	 y4Y4g/CUjFLHtxGqmcvplVDkxwi4u3u9Cy3sbAxsGHCe3JCz6e1/mlfLZBr81zwQFF
	 wUrPWW1gEJStQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 04920378203F;
	Fri, 21 Jun 2024 22:06:00 +0000 (UTC)
Message-ID: <55dbc2a8-4e4a-405a-a9ae-e62b18aaeb1d@collabora.com>
Date: Sat, 22 Jun 2024 01:06:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: Fix mic-in-differential usage
 on rk3568-rock-3a
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Furkan Kardame <f.kardame@manjaro.org>,
 Michael Riesch <michael.riesch@wolfvision.net>, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
 <20240619-rk809-fixes-v1-3-fa93bc5313f4@collabora.com>
 <c35b3e80-7889-473d-8365-88436c3cb9a9@kwiboo.se>
 <4015ded1-5ec4-4374-982e-9c7f23b43884@collabora.com>
 <1fce65a2-b752-4bab-84e5-314b60d682f0@collabora.com>
 <dbf9d54e-1197-4731-80f2-91ff7c9954e4@kwiboo.se>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <dbf9d54e-1197-4731-80f2-91ff7c9954e4@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/24 9:58 AM, Jonas Karlman wrote:
> Hi Cristian,
> 
> On 2024-06-21 03:23, Cristian Ciocaltea wrote:
>> On 6/19/24 3:56 PM, Cristian Ciocaltea wrote:
>>> Hi Jonas,
>>>
>>> On 6/19/24 3:22 PM, Jonas Karlman wrote:
>>>> Hi Cristian,
>>>>
>>>> On 2024-06-19 13:23, Cristian Ciocaltea wrote:
>>>>> The 'mic-in-differential' DT property supported by the RK809/RK817 audio
>>>>> codec driver is actually valid if prefixed with 'rockchip,':
>>>>>
>>>>>   DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb
>>>>>   rk3568-rock-3a.dtb: pmic@20: codec: 'mic-in-differential' does not match any of the regexes: 'pinctrl-[0-9]+'
>>>>> 	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
>>>>>
>>>>> Make use of the correct property name.
>>>>>
>>>>> Fixes: a84ffd2ef1ff ("arm64: dts: rockchip: Fix mic-in-differential usage on rock-3a")
>>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>>>>> index ebdedea15ad1..0b54dfe92d6e 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>>>>> @@ -533,7 +533,7 @@ regulator-state-mem {
>>>>>  		};
>>>>>  
>>>>>  		codec {
>>>>> -			mic-in-differential;
>>>>> +			rockchip,mic-in-differential;
>>>>
>>>> If I understand the schematics correctly, only one wire is connected so
>>>> this board cannot really use differential signaling, and this should
>>>> probably instead be dropped.
>>>
>>> Thanks for pointing this out, I will drop it in v2.
>>
>> I've also checked the schematics which indicate the PMIC RK809 CODEC
>> receives both MIC1_INN and MIC1_INP signals; the former comes from the
>> Jack input, while the latter is generated by the SLM42Q3AT MEMS Microphone.
>>
>> However, I'm not sure the Mic presence on the board is dependent on the
>> HW revision - on REV V1.3 the "NC_" prefix under U24 component label
>> suggests it is not connected.  So maybe we should keep the property?!
> 
> There is no such mic on the board, at least on the rev 1.3 that I have.
> 
> This prop should be used to indicate that the attached microphone uses
> differential signaling, e.g. should have its two output signals
> connected to both INP(+) and INN(-).
> 
> The SLM42Q3AT or the single wire from headphone jack indicate that a
> single-ended microphone is/can be used/wired on this board.
> 
> The current use of non-working mic-in-differential was wrong, adding
> the rockchip,mic-in-differential would change behavior and wrongly
> describe hw of this board.

Thanks a lot for the clarifications! I dropped this in v2.

Regards,
Cristian

