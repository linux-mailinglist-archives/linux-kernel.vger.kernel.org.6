Return-Path: <linux-kernel+bounces-429638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6A59E1EE8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D47281604
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824E41F6669;
	Tue,  3 Dec 2024 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CxSOzUHl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53971F472F;
	Tue,  3 Dec 2024 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235621; cv=none; b=ZtFSnAfVqA4AeUokrB3Dw0n/1r1v0IUlILGJTb47cBQUDzMAuUqPVIt4dDHltbHIX13G3GnKJc9+CMevBfnK7yPw1HCz+P419X/GdFB7kt2wzCCIIydUBlpSC+3PQezW4b8mXBNkNRrUmUi3tOqR9vbNsC7wVfZ8k2QIR3lVqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235621; c=relaxed/simple;
	bh=pWkF2Bb5Gq9pQgLzlneBZEmWId9TYqkXXlfj6J23HWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgDJli8zXBCWCi/xT0dKMxfqw+D/z0E41SPgG2Mu8QzL4017Cf7W612i6Ajq/eVLWFueCVVShnLXwLBKuig7VNp9AxGZQHlhBV9V7zB7S1AwHldCsKGcADGKKy+Nz55Malu8X4rSoZFM7WA4N+iCKZXmyXip4NOUws7Q0POc9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CxSOzUHl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733235617;
	bh=pWkF2Bb5Gq9pQgLzlneBZEmWId9TYqkXXlfj6J23HWo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CxSOzUHleEfy78K+Esg2j1PTKTlTEWEB4mU0JQmVw33Axdb+Xgdvi6V/bIvqIvrqh
	 /pPuET51Lm3hokG4sqBmFkhDz4rwXMvrpOrOda+UR/1JPlU0K5ObahFjYu+pQwt17q
	 hTAzkrbIIU346k5IVGXQnTn+bAOeN68AWEkAdeLV3qhDQ4tvn5vLNgyJtDyQDwRvg4
	 pfun9CO0xFCe6OL28XNLVWeZ3TFR+Y8c9DrmpyGIup7/QTgAJi3y4TIN4Ulz3YkUBi
	 iKbETl2bfBCYWn6eqwWqd8qXreVMcn1pn0Gd6A7SQhlwHIwDjYVfVkESz8mrWyNH2T
	 SIL4W7WVSYlEg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3CD3217E0DE6;
	Tue,  3 Dec 2024 15:20:16 +0100 (CET)
Message-ID: <4da0ab36-34c2-413a-90b3-bcdbdd4a6ac0@collabora.com>
Date: Tue, 3 Dec 2024 15:20:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/18] arm64: dts: mediatek: mt7988: add fixed
 regulators for 1v8 and 3v3
To: frank-w@public-files.de, Frank Wunderlich <linux@fw-web.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-4-linux@fw-web.de>
 <016b77dc-2d33-4639-b241-2574ad877971@collabora.com>
 <371B3F0C-D468-45C8-B1F6-F4619B7C72DD@public-files.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <371B3F0C-D468-45C8-B1F6-F4619B7C72DD@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/12/24 11:51, Frank Wunderlich ha scritto:
> Am 3. Dezember 2024 10:40:54 MEZ schrieb AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>:
>> Il 02/12/24 13:25, Frank Wunderlich ha scritto:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Add regulator nodes used for mmc to Bananapi R4 board.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>
>> If you're adding the eMMC regulators, I assume that there's an eMMC, or that even
>> if there's no device in some version of the board, these two regulators are always
>> assigned to the eMMC device - right?
> 
> Like BPi-R3 there is one mmc controller mapped to either sd or emmc. I can move the regulators to the dtbo,but then they are defined twice (at least 3v3).
> 
>> You should, at this point, do exactly that: you can leave the mmc0 disabled and
>> only enable it in a DTBO.
> 
> I enable it only in dtbo...
> 
>> &mmc0 {
>> 	/* eMMC gets enabled by DTBO if present */
>> 	vmmc-supply = <&reg_3p3v>;
>> 	vqmmc-supply = <&reg_1p8v>;
>> };
> 
> Problem is here that sdcard uses only the 3v3 twice
> 
> https://github.com/frank-w/BPI-Router-Linux/blob/6.12-main/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-sd.dtso
> 
> And emmc needs both
> 
> https://github.com/frank-w/BPI-Router-Linux/blob/6.12-main/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-emmc.dtso
> 
> Only defining the vmmc-supply in dts and set only the other in dtso is possible but but imho not nice.
> 

If you added that in the commit description in the first place, I wouldn't
have sent you that suggestion ;-)

So, please add the reason that you just explained to me in the description
of this commit and just leave the code as-is.

Cheers!

>> Cheers,
>> Angelo
>>
>>> ---
>>> v2:
>>> - move mmc regulators to board dts of bpi-r4
>>> ---
>>>    .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts   | 18 ++++++++++++++++++
>>>    1 file changed, 18 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
>>> index d914eae2b524..df53512c6890 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
>>> +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
>>> @@ -8,6 +8,24 @@ / {
>>>    	compatible = "bananapi,bpi-r4", "mediatek,mt7988a";
>>>    	model = "Banana Pi BPI-R4";
>>>    	chassis-type = "embedded";
>>> +
>>> +	reg_1p8v: regulator-1p8v {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "fixed-1.8V";
>>> +		regulator-min-microvolt = <1800000>;
>>> +		regulator-max-microvolt = <1800000>;
>>> +		regulator-boot-on;
>>> +		regulator-always-on;
>>> +	};
>>> +
>>> +	reg_3p3v: regulator-3p3v {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "fixed-3.3V";
>>> +		regulator-min-microvolt = <3300000>;
>>> +		regulator-max-microvolt = <3300000>;
>>> +		regulator-boot-on;
>>> +		regulator-always-on;
>>> +	};
>>>    };
>>>      &pio {
>>
>>
> 
> 
> regards Frank



