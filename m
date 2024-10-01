Return-Path: <linux-kernel+bounces-345802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B4598BB52
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F100D1C22E2B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022AA1C0DC5;
	Tue,  1 Oct 2024 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e/86Gb1A"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE81BFE10;
	Tue,  1 Oct 2024 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782586; cv=none; b=Z3aEClHkvoiD+AJ0NZlHS3zun9sHBGRpzOyPSO3C+4f1Tcs5QjLRqM/2kalsClIxDVJc+tJmB3nnR2dF6qO/kB/5u+oDhyJ6NkIb26dvMYKEaJ8zWqjEjeTc+YTtHT3qd+Dcx1eN7nwqSLELvAyAfm8jP64Yq2icjYvv5Z87lIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782586; c=relaxed/simple;
	bh=9LVfX5DE4WDwQ8o0TCm+Ht76lDuHkNfNyC8x+bsil+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8n3/jcaR/LvC4CeT7e5ZfvVLHFt8iUXiyi0tPcvzIGBnHt+bJ6Du15ImUpGmH4VwI7zNlIRb1c/t3YiSrNv2mEOsTSCpFgllWU2Leaq2tIQKE9cpJxmp/erwPSmjw2/KYbl+nfoOcSnPM0cGaMVil3Vw2L0kiLudzlCOT2AS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e/86Gb1A; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727782582;
	bh=9LVfX5DE4WDwQ8o0TCm+Ht76lDuHkNfNyC8x+bsil+4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e/86Gb1AM4O0IEKiOyQ4yd6lMyq+7+f7d7WHPpjqKiUuawvdYjDQdFqQQRDNIJOI7
	 WvCNWvzh6fOdo8MDAhOVuigra8U2jud1+AVMauKohpruTg8W3dAYvJeSnnyW0YGyT5
	 W46JHAjyJI5bpUBpw9iMJQxvAUL45xy8Jj8VWvZ25jDQtOt6i/8aFUm/hv4tQcFWr3
	 KPSsjgzVgt0OMO7u8Lk9PxCifkkRUuGwBo/3l3jyghZVHg+YviKsBOclkmmixg73pY
	 pBPFPm9XqNwRT6/NHi8rlFrhpHoPWf/YX9xbZ9E8a/bM2S/RWY7cZpQGjGL4h2/meN
	 H9MmARibsgmLA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 64C2F17E0F7D;
	Tue,  1 Oct 2024 13:36:22 +0200 (CEST)
Message-ID: <b7032557-0b7c-4329-9762-14bda341e79c@collabora.com>
Date: Tue, 1 Oct 2024 13:36:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediate: Introduce MT8186
 Chinchou/Chinchou360 Chromebooks
To: =?UTF-8?Q?Albert_Jakie=C5=82a?= <jakiela@google.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, wenst@chromium.org, rafal@milecki.pl,
 hsinyi@chromium.org, nfraprado@collabora.com, sean.wang@mediatek.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240927122940.4190949-1-jakiela@google.com>
 <20240927122940.4190949-2-jakiela@google.com>
 <2c5614f7-0ada-453a-bd81-2f0054a919a0@collabora.com>
 <CAODvyLQ0pUUvBtfk7Pj05vwTkjEnCkfBY4-EG0okQB972tLC-g@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAODvyLQ0pUUvBtfk7Pj05vwTkjEnCkfBY4-EG0okQB972tLC-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/10/24 13:13, Albert Jakieła ha scritto:
> Deleting `compatible` property will not allow the sound card to probe, so I
> override it with proper compat.
> 

The inherited `compatible = "mediatek,mt8186-mt6366-rt1019-rt5682s-sound"` from
mt8186-corsola.dtsi should allow that to probe correctly.

Can you please share the log of the error(s) that you're seeing?

Thanks,
Angelo

> On Mon, Sep 30, 2024 at 11:23 AM AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com> wrote:
> 
>> Il 27/09/24 14:29, Albert Jakieła ha scritto:
>>> The MT8186 Chinchou/Chinchou360, also known as the Asus Chromebook
>>> CZ12/CZ11 Flip, is a clamshell or convertible device with touchscreen,
>>> stylus and extra buttons.
>>>
>>
>> You have a typo in your commit title `mediate` -> `mediatek`
>>
>>> Signed-off-by: Albert Jakieła <jakiela@google.com>
>>> ---
>>> Changes in v2:
>>> - PATCH 2/2: Remove sku2147483647, remove duplicate nodes, add model
>>>        and remove uneccecery nodes from sound card.
>>> - Link to v1:
>> https://lore.kernel.org/all/20240925080353.2362879-2-jakiela@google.com/
>>>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/Makefile         |   3 +
>>>    .../mediatek/mt8186-corsola-chinchou-sku0.dts |  18 +
>>>    .../mediatek/mt8186-corsola-chinchou-sku1.dts |  34 ++
>>>    .../mt8186-corsola-chinchou-sku16.dts         |  28 ++
>>>    .../dts/mediatek/mt8186-corsola-chinchou.dtsi | 432 ++++++++++++++++++
>>>    5 files changed, 515 insertions(+)
>>>    create mode 100644
>> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku0.dts
>>>    create mode 100644
>> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku1.dts
>>>    create mode 100644
>> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou-sku16.dts
>>>    create mode 100644
>> arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
>>>
>>
>> ..snip..
>>
>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
>> b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
>>> new file mode 100644
>>> index 000000000000..96cc3c267c20
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-chinchou.dtsi
>>> @@ -0,0 +1,432 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright 2023 Google LLC
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include "mt8186-corsola.dtsi"
>>> +
>>> +/ {
>>
>> ..snip..
>>
>>> +
>>> +&sound {
>>> +     status = "okay";
>>> +
>>> +     compatible = "mediatek,mt8186-mt6366-rt5650-sound";
>>
>> Why did you keep the compatible string override?
>>
>>> +     model = "mt8186_rt5650";
>>> +
>>
>> Regards,
>> Angelo
>>
>>
>>
>>
>>
> 



