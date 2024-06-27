Return-Path: <linux-kernel+bounces-232105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B754591A383
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21E61C21115
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA77713C807;
	Thu, 27 Jun 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CScKeZZ9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97767381C8;
	Thu, 27 Jun 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483022; cv=none; b=rko4nCsl266Rr8Qd61O+6JKIBfusv56OTU72cV0E83MATYF1XGTLMxS3RSMxyu69zxeiknotgRN0U5PwSnjEXRCzokioYaapmNtBovA56Kpq5fZZS11PBCXGE7C4ysra0TIBpxgtORjQuXdZTq6FNBd3eYPYhqekiF5nZ9NNJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483022; c=relaxed/simple;
	bh=YKvSjQO0kBriuXHtpM5S2HDjrcI9aj+U9VFh4zoTZMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZOADgPZJLXg8ooaOOnzmp4Bk7zt7E19ExGl9WLMfwIgndkaRT3ZYXhzz9j3s1gJcblGbV5UQNONGTusqz5QiKmS0ormHyLpwafGe7dA9TVzyq88xtL/NrqT7lvLbHGxV8S7hnwbqgYfjzXGTAIgbiLdIulq5M6SHQLNkf+01JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CScKeZZ9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719483018;
	bh=YKvSjQO0kBriuXHtpM5S2HDjrcI9aj+U9VFh4zoTZMg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CScKeZZ9hJayTeQlGW/3Ok8Jm4GshJujZzcM6rXvkfujk1wULJ31eu/DM6dXCEV+c
	 9Y8tFxvckIKBqnI3OBLFAsYpkUvnDXVZNYInGxb6E0MLL23CfrHvUzjiygG5HsOr7N
	 Oj6cKI5BerncV4nnf38QoDXaU663019BIcIrXrOQbiUIEHLhnGrd3x8kX6Iegb0Zpm
	 HDE/Ndh/ZzCPTogp+Gss7PAJxvmIKHinrwj6Y/iSZ1Dhs6wkXhwCjwJrKVb26IFZFo
	 ytE9nyNJ2Uo7bLy77wrQD/AF1yjKiWsmfJuSwepAqnqcGml/wQMhh75SUmQayfts5L
	 GcXTqREx2+Yww==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 123B537810CD;
	Thu, 27 Jun 2024 10:10:18 +0000 (UTC)
Message-ID: <726f2ed3-675f-45e8-94f0-d392181e7f92@collabora.com>
Date: Thu, 27 Jun 2024 12:10:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: [PATCH v3 1/2] arm64: dts: mt7986: add dtbs with applied
 overlays for bpi-r3
To: Frank Wunderlich <frank-w@public-files.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Wunderlich <linux@fw-web.de>
References: <20240608080530.9436-1-linux@fw-web.de>
 <20240608080530.9436-2-linux@fw-web.de>
 <trinity-82c94d49-2a78-4470-83cd-3c6747e01849-1719434738199@3c-app-gmx-bs52>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <trinity-82c94d49-2a78-4470-83cd-3c6747e01849-1719434738199@3c-app-gmx-bs52>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/06/24 22:45, Frank Wunderlich ha scritto:
> any suggestions? hoping it does no laying around so long as v2
> 

So you're trying to just test that the overlay is valid and can actually be
overlaid to the base dts?

I'm not sure that this is the right/best way... and I honestly have no time
to check that *exactly right now*, even though that should be.

I have to be convinced of what I'm doing before applying patches, and I know
that this was sent a bit of time ago, but I really didn't have any time to
dig into that... let's see if for some miracle I can do that for this cycle
otherwise it's going to be the next one.

I mean no disrespect to Rob who suggested this change, but I still want to
check that on my own before picking it.

Sorry about the delays

Cheers,
Angelo


> regards Frank
> 
> 
>> Gesendet: Samstag, 08. Juni 2024 um 10:05 Uhr
>> Von: "Frank Wunderlich" <linux@fw-web.de>
>> An: "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
>> Cc: "Frank Wunderlich" <frank-w@public-files.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, "Daniel Golle" <daniel@makrotopia.org>, "Rob Herring" <robh+dt@kernel.org>
>> Betreff: [PATCH v3 1/2] arm64: dts: mt7986: add dtbs with applied overlays for bpi-r3
>>
>> From: Frank Wunderlich <frank-w@public-files.de>
>>
>> Build devicetree binaries for testing overlays and providing users
>> full dtb without using overlays.
>>
>> Suggested-by: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>> ---
>> https://lore.kernel.org/all/CAL_JsqK_3xxD0DFwipXO85P=q=EYjUdjE1_8g1MKtvw3vVzx5A@mail.gmail.com/
>> https://lore.kernel.org/all/CAL_JsqJSi=kJSix=f3787ULZnaCy_Y26Phdhy5y9fat_vkDuUw@mail.gmail.com/
>>
>> v2:
>> make full dtbs multiline for better readability
>> ---
>>   arch/arm64/boot/dts/mediatek/Makefile | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>> index 37b4ca3a87c9..0ec5b904d35d 100644
>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>> @@ -15,6 +15,27 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo
>> +mt7986a-bananapi-bpi-r3-emmc-nand-dtbs := \
>> +	mt7986a-bananapi-bpi-r3.dtb \
>> +	mt7986a-bananapi-bpi-r3-emmc.dtbo \
>> +	mt7986a-bananapi-bpi-r3-nand.dtbo
>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nand.dtb
>> +mt7986a-bananapi-bpi-r3-emmc-nor-dtbs := \
>> +	mt7986a-bananapi-bpi-r3.dtb \
>> +	mt7986a-bananapi-bpi-r3-emmc.dtbo \
>> +	mt7986a-bananapi-bpi-r3-nor.dtbo
>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nor.dtb
>> +mt7986a-bananapi-bpi-r3-sd-nand-dtbs := \
>> +	mt7986a-bananapi-bpi-r3.dtb \
>> +	mt7986a-bananapi-bpi-r3-sd.dtbo \
>> +	mt7986a-bananapi-bpi-r3-nand.dtbo
>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nand.dtb
>> +mt7986a-bananapi-bpi-r3-sd-nor-dtbs := \
>> +	mt7986a-bananapi-bpi-r3.dtb \
>> +	mt7986a-bananapi-bpi-r3-sd.dtbo \
>> +	mt7986a-bananapi-bpi-r3-nor.dtbo
>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nor.dtb
>> +
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986b-rfb.dtb
>>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7988a-bananapi-bpi-r4.dtb
>> --
>> 2.34.1
>>
>>


