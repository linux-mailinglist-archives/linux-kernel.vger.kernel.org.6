Return-Path: <linux-kernel+bounces-223770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584AE9117FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5551F21DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B526548F7;
	Fri, 21 Jun 2024 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L2dz/yDS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2C4EB45;
	Fri, 21 Jun 2024 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718933026; cv=none; b=PS+gSPrG64FSaoHvAvPj6GCpfcEv4lRXwsB9u1YBPM3/g4taqE8WbHEt4u81poWF1KRA7oU4C2iayJ1VpazLckA2rFYRYpU2uevHyEqiInz/XP2VkFUNf3gIZaqNpNf6aa+ishEuNdY00abrRt/OLrF5M+fUNuyqYxB40DG2Tac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718933026; c=relaxed/simple;
	bh=S/Y+XD9EEnIR15Y7mRl6RrqRYyY+K+WmygZUm5wATzo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dECeFFE//GVk85mi2H8z2EvVQW/E+I7ASr2enplhHiTl+hT95huPaiwRmsFalBJQ2fcmrlLsYedKYXt2uXHxua7JpwsYvew/TBGR9zUGAgkMiN6wYlFgc7YXeH4cCS79MqgeuDNFJaU4jv7xv2tyoTLXV6vbiGJBdcLWhDP0lZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L2dz/yDS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718933022;
	bh=S/Y+XD9EEnIR15Y7mRl6RrqRYyY+K+WmygZUm5wATzo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=L2dz/yDSW0PG56ChLFne9pA3VPa3SAhhoxfa6nEqxFvc+g92GCayvWkpfw3N9lckd
	 PUdCvjFlmNg2Q+A4yNwfa627epfMxTufbR5lm8s9Ypck4O3wuANihNFOEOSfAMHwu+
	 2eCysVofl9oyYQzfjbNOmFp2A6R5n601anu6SyQzNCCXqRgls5EwFtcs0KbRQ6JBC2
	 pC0xPHkWOmbIlw8H5wvU91IXsQnBytxR/OCNlEIYF0pger3soEk89cb9rL6KF8fEt4
	 G37KYh7o3d/s9JsCaNxhTVXxbg/cKSjmMFhMM14BCurmPsoUYQ1EBuYUgq2+/k5O6O
	 4fjoFBQn0OLfA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B1D5A3780FF1;
	Fri, 21 Jun 2024 01:23:41 +0000 (UTC)
Message-ID: <1fce65a2-b752-4bab-84e5-314b60d682f0@collabora.com>
Date: Fri, 21 Jun 2024 04:23:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: Fix mic-in-differential usage
 on rk3568-rock-3a
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Furkan Kardame <f.kardame@manjaro.org>,
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com>
 <20240619-rk809-fixes-v1-3-fa93bc5313f4@collabora.com>
 <c35b3e80-7889-473d-8365-88436c3cb9a9@kwiboo.se>
 <4015ded1-5ec4-4374-982e-9c7f23b43884@collabora.com>
Content-Language: en-US
In-Reply-To: <4015ded1-5ec4-4374-982e-9c7f23b43884@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/24 3:56 PM, Cristian Ciocaltea wrote:
> Hi Jonas,
> 
> On 6/19/24 3:22 PM, Jonas Karlman wrote:
>> Hi Cristian,
>>
>> On 2024-06-19 13:23, Cristian Ciocaltea wrote:
>>> The 'mic-in-differential' DT property supported by the RK809/RK817 audio
>>> codec driver is actually valid if prefixed with 'rockchip,':
>>>
>>>   DTC_CHK arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb
>>>   rk3568-rock-3a.dtb: pmic@20: codec: 'mic-in-differential' does not match any of the regexes: 'pinctrl-[0-9]+'
>>> 	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#
>>>
>>> Make use of the correct property name.
>>>
>>> Fixes: a84ffd2ef1ff ("arm64: dts: rockchip: Fix mic-in-differential usage on rock-3a")
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>>> index ebdedea15ad1..0b54dfe92d6e 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
>>> @@ -533,7 +533,7 @@ regulator-state-mem {
>>>  		};
>>>  
>>>  		codec {
>>> -			mic-in-differential;
>>> +			rockchip,mic-in-differential;
>>
>> If I understand the schematics correctly, only one wire is connected so
>> this board cannot really use differential signaling, and this should
>> probably instead be dropped.
> 
> Thanks for pointing this out, I will drop it in v2.

I've also checked the schematics which indicate the PMIC RK809 CODEC
receives both MIC1_INN and MIC1_INP signals; the former comes from the
Jack input, while the latter is generated by the SLM42Q3AT MEMS Microphone.

However, I'm not sure the Mic presence on the board is dependent on the
HW revision - on REV V1.3 the "NC_" prefix under U24 component label
suggests it is not connected.  So maybe we should keep the property?!

Cristian

