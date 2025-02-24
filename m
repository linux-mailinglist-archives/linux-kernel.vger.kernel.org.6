Return-Path: <linux-kernel+bounces-528459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D61EA417DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57663B2B39
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9804A241C8F;
	Mon, 24 Feb 2025 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IOM2g64P"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89918A6D5;
	Mon, 24 Feb 2025 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387252; cv=none; b=jLc28DxQTO5Hp88sOqCUDsRmTzsqFTv8zuXMBYiydoMHapic1NrkL0r5LAlAaRgtx9enMPDuBDskwfqUnecXbeiy3CEARtrM0wAkbpGntspmNf9fIyeNVxOgNvRAAPmcbpowF1bbRd/ERuJE1McMjXUPfGx7mBpCzTlj/Ozi8GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387252; c=relaxed/simple;
	bh=6bOy9KlYLQyrPSIjTKd8+I20FV1jUat1LPHJT2fj0CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFCBrKF7NvAatDjff/KFB3/2iF+3GBrDwUg5ZGwHMvZ0BvNupl0yjBo7nvXl5tvH1S04bRX8RGB9YSqvragvGzrJby7oOuGhgauZr0K+TMVjwi6+G34CH3BuzWvtdOvGNpaNaBFgKlG6dobaVGUka86vcZeYE/aib9C8FeosJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IOM2g64P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740387248;
	bh=6bOy9KlYLQyrPSIjTKd8+I20FV1jUat1LPHJT2fj0CA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IOM2g64PkCwY3bMfCSfg7CSfBu84lFzLss4S42gqmJlCwkEhycqrjpG30bm248nDv
	 N2eBYf/mT745k7zVqwGMRyDXwGEw5CCSPpFa7Wt1+0gV85jkKdhZD/KWJR8FZwkYCi
	 nRwbtChVaYQXkMCggjYwZDLUYgdTGozDnrxe1cjfFzW4UzpRh7BzcF2fK9XIC5m0Mz
	 ZlMM7E11sm5//N0lJl4+Jpmfv0vqLQXKZd7S3JX/Jk3pIuD/hDI9S284Sz+fdtBQJG
	 hTWr6ZUQwsj61oViQd+y2+7kyCwwWBpUTWRunsaonBSuiXM+BKmDH1QwJNQopQ5mUP
	 GVuMcIR0KIA6A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6949E17E001F;
	Mon, 24 Feb 2025 09:54:07 +0100 (CET)
Message-ID: <5d10f630-57a4-427d-a14e-e4058d4fdffe@collabora.com>
Date: Mon, 24 Feb 2025 09:54:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: dts: mediatek: mt8395-genio-1200-evk: add
 support for TCPC port
To: ChiYuan Huang <cy_huang@richtek.com>,
 =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 "fparent@baylibre.com" <fparent@baylibre.com>,
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "macpaul@gmail.com" <macpaul@gmail.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 "simon.sun@yunjingtech.com" <simon.sun@yunjingtech.com>,
 =?UTF-8?B?WW93LXNoaW4gTGlvdSAo5YqJ56WQ54KYKQ==?=
 <yow-shin.liou@mediatek.com>,
 =?UTF-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
References: <20250220143354.2532448-1-macpaul.lin@mediatek.com>
 <cb392432-e452-4460-ace6-54b3649aed52@collabora.com>
 <f09f880b7f9b642140109f17ed3f89aa44195b99.camel@mediatek.com>
 <Z7vRUmETQaYRbEyZ@git-send.richtek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <Z7vRUmETQaYRbEyZ@git-send.richtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 24/02/25 02:54, ChiYuan Huang ha scritto:
> On Fri, Feb 21, 2025 at 11:39:09AM +0000, Macpaul Lin (林智斌) wrote:
>> On Thu, 2025-02-20 at 16:58 +0100, AngeloGioacchino Del Regno wrote:
>>>
>>>
>>
>> [snip]
>>
>>>> +             tcpc {
>>>> +                     compatible = "mediatek,mt6360-tcpc";
>>>> +                     interrupts-extended = <&pio 17
>>>> IRQ_TYPE_LEVEL_LOW>;
>>>> +                     interrupt-names = "PD_IRQB";
>>>> +
>>>> +                     connector {
>>>> +                             compatible = "usb-c-connector";
>>>> +                             label = "USB-C";
>>>> +                             data-role = "dual";
>>>> +                             op-sink-microwatt = <10000000>;
>>>> +                             power-role = "dual";
>>>> +                             try-power-role = "sink";
>>>
>>> Would be appreciated if you could also complete the node by adding
>>> the pd-revision
>>> property, enabling full USBC Power Delivery for the MT6360 PMIC.
>>>
>>
>> Well, I have no idea about the pd-revision of MT6360.
>> I could found MT6360 supports PD 3.0 according to the datasheet,
>> however, I have no idea about the other fields like major and minor
>> values. Dear ChiYuan, could you help to provide the value of pd-
>> revision? The property has been defined in
>> Documentation/devicetree/bindings/connector/usb-connector.yaml.
>>
> Hi, Macpaul:
> 
> You can specify the version information to 3.1 version 1.6.
> Just add the below property into the 'connector' node.
> 
> pd-revision = /bits/ 8 <0x03 0x01 0x01 0x06>;
> 
> Regards,
> ChiYuan

Thanks ChiYuan, that's great to know.

With this - all boards relying on MT6360 can charge use the full set of supported
USB Power Delivery capabilities (that, since the PD revision is specific to the
MT6360 TCPC, and not board specific!).

Macpaul, please add the pd-revision as suggested, and for v6, please add my:

Reviewed-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers!
Angelo




