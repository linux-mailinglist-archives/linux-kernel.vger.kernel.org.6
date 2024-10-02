Return-Path: <linux-kernel+bounces-347258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5885498D033
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C278287144
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167551E00BD;
	Wed,  2 Oct 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Qkp3bkda"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E361946A2;
	Wed,  2 Oct 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861580; cv=none; b=BL+HWG74DkU/W6hWhUa9VcuUuCz0F1+wOUqtDWmRhSRd5Y19SoMUHVA4X7XW1VpFES/VceLaz4ZaD62Th9iXwoQeXVyUefdvEjfLzFS6g2ZwV0VJI9ejC6pgu4PDnxH5DzjbL/PP88iM4ph7iAqJjg6SeQm2Px/JwQoqyfEpfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861580; c=relaxed/simple;
	bh=Jd3Oj9mtQ/mi5K+VxCFLk3mKstNWEsxSwYmRpLtFFRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLa9J2DfQB81aw8q6uuxnYrI9ZiyEPXO11W4GvurjA0fcHjzvYrbwiqBYWyOwXvRfSKVvdyXiv/pwNbWPU/eQos1QJlLfWc8UERCFDiIkJy7ZuD+ESTQPamyb+dsCJNLEMUgh1q9AfF6qQsM0GBj06zeU3XyK9fCnkmAr1GviKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Qkp3bkda; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727861576;
	bh=Jd3Oj9mtQ/mi5K+VxCFLk3mKstNWEsxSwYmRpLtFFRk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qkp3bkdaIqoMdynbqckRLJtYKLJ7SmDh//gWge52G+Z0HttpT+y33UKHF5/53rrxg
	 GVv+BN2FsoZzOOcJ9yifTV1G1yla/hLi5gfbnw4xE404djzegUSw3IBYYVsDtcB7dc
	 Es3efUWRgSUMEf9s8aHl7aPld5AoXQgi38VRiQ0fivxvANIq+DmuTnmCa1OKk59RE1
	 DCGTHRi1pViWbuVLVPevfMQQ4zQiF4gr8GQEuU6gi5PHV5uBhzGxvg5fVbDNWeDJX7
	 x4Nn+51tbFOMkV20xU8xvSVZZFELut/v4e7tdLHSN05n7k11UGaYo5iT1PlW0M+lj+
	 ivUjKX0bYtK7w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C98617E1147;
	Wed,  2 Oct 2024 11:32:56 +0200 (CEST)
Message-ID: <8d36c55e-1dee-4bda-a1f5-d2033e116a56@collabora.com>
Date: Wed, 2 Oct 2024 11:32:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] arm64: dts: mediatek: Add MT8186 Ponyta
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 hsinyi@google.com, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, knoxchiou@google.com, devicetree@vger.kernel.org,
 krzk+dt@kernel.org, "Rob Herring (Arm)" <robh@kernel.org>
References: <20240914063122.1622196-1-cengjianeng@huaqin.corp-partner.google.com>
 <172650686036.806282.435049873625711480.robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <172650686036.806282.435049873625711480.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/09/24 19:19, Rob Herring (Arm) ha scritto:
> 
> On Sat, 14 Sep 2024 14:31:20 +0800, Jianeng Ceng wrote:
>> This is v8 of the MT8186 Chromebook device tree series.
>> ---
>> Changes in v8:
>> - PATCH 1/2: Remove custom label.
>> - PATCH 2/2: Change the commit about ponyta.
>> - Link to v7:https://lore.kernel.org/all/20240913031505.372868-1-cengjianeng@huaqin.corp-partner.google.com/
>>
>> Changes in v7:
>> - PATCH 2/2: Remove prototype sku.
>> - PATCH 2/2: Disable the other trackpad to enable one of them.
>> - Link to v5:https://lore.kernel.org/all/20240913015503.4192806-1-cengjianeng@huaqin.corp-partner.google.com/
>>
>> Changes in v6:
>> - No change.
>>
>> Changes in v5:
>> - PATCH 1/2: Remove sku2147483647.
>> - PATCH 2/2: Remove sku2147483647.
>> - Link to v4:https://lore.kernel.org/all/20240906085739.1322676-1-cengjianeng@huaqin.corp-partner.google.com/
>>
>> Changes in v4:
>> - PATCH 1/2: Add more info for Ponyta custom label in commit.
>> - Link to v3:https://lore.kernel.org/all/20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com/
>>
>> Changes in v3:
>> - PATCH 0/2: Add the modify records.
>> - PATCH 1/2: Modify lable to label.
>> - Link to v2:https://lore.kernel.org/all/20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com/
>>
>> Changes in v2:
>> - PATCH 2/2: Modify the dtb name without rev2.
>> - Link to v1:https://lore.kernel.org/all/20240902125502.1844374-1-cengjianeng@huaqin.corp-partner.google.com/
>>
>> Jianeng Ceng (2):
>>    dt-bindings: arm: mediatek: Add MT8186 Ponyta Chromebook
>>    arm64: dts: mediatek: Add MT8186 Ponyta Chromebooks
>>
>>   .../devicetree/bindings/arm/mediatek.yaml     | 10 +++++
>>   arch/arm64/boot/dts/mediatek/Makefile         |  2 +
>>   .../mediatek/mt8186-corsola-ponyta-sku0.dts   | 18 ++++++++
>>   .../mediatek/mt8186-corsola-ponyta-sku1.dts   | 22 ++++++++++
>>   .../dts/mediatek/mt8186-corsola-ponyta.dtsi   | 44 +++++++++++++++++++
>>   5 files changed, 96 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
>>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
>>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi
>>
>> --
>> 2.34.1
>>
>>
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>    pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y mediatek/mt8186-corsola-ponyta-sku0.dtb mediatek/mt8186-corsola-ponyta-sku1.dtb' for 20240914063122.1622196-1-cengjianeng@huaqin.corp-partner.google.com:
> 
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: /soc/pwrap@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt6366', 'mediatek,mt6358']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: /soc/pwrap@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt6366', 'mediatek,mt6358']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: /soc/pwrap@1000d000/pmic/codec: failed to match any schema with compatible: ['mediatek,mt6366-sound', 'mediatek,mt6358-sound']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: /soc/pwrap@1000d000/pmic/codec: failed to match any schema with compatible: ['mediatek,mt6366-sound', 'mediatek,mt6358-sound']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: /soc/pwrap@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt6366', 'mediatek,mt6358']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: /soc/pwrap@1000d000/pmic: failed to match any schema with compatible: ['mediatek,mt6366', 'mediatek,mt6358']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: /soc/pwrap@1000d000/pmic/codec: failed to match any schema with compatible: ['mediatek,mt6366-sound', 'mediatek,mt6358-sound']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: /soc/pwrap@1000d000/pmic/codec: failed to match any schema with compatible: ['mediatek,mt6366-sound', 'mediatek,mt6358-sound']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: /soc/pwrap@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek,mt6366-rtc', 'mediatek,mt6358-rtc']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: /soc/pwrap@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek,mt6366-rtc', 'mediatek,mt6358-rtc']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: /soc/pwrap@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek,mt6366-rtc', 'mediatek,mt6358-rtc']
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: /soc/pwrap@1000d000/pmic/rtc: failed to match any schema with compatible: ['mediatek,mt6366-rtc', 'mediatek,mt6358-rtc']

Hello Jianeng,
I can't apply this series unless you fix the following warnings from the DTB check:

> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: dp-bridge@5c: 'extcon' is a required property
> 	from schema $id: http://devicetree.org/schemas/display/bridge/ite,it6505.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: dp-bridge@5c: 'extcon' is a required property
> 	from schema $id: http://devicetree.org/schemas/display/bridge/ite,it6505.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dtb: sound: 'model' is a required property
> 	from schema $id: http://devicetree.org/schemas/sound/mt8186-mt6366-rt1019-rt5682s.yaml#
> arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dtb: sound: 'model' is a required property
> 	from schema $id: http://devicetree.org/schemas/sound/mt8186-mt6366-rt1019-rt5682s.yaml#
> 

Regards,
Angelo


