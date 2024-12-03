Return-Path: <linux-kernel+bounces-429167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB6C9E1814
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E941666BD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7A41E285D;
	Tue,  3 Dec 2024 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KdaG89f/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C281E32D0;
	Tue,  3 Dec 2024 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218858; cv=none; b=OxOim3eWUXOVrEwLfz7hXHmSvS/nxwlvya4aq84plzyrMy+UpQq16Db5utwHwCzA9U7Pz5sVdfWSogb98xHGTLK3HWTKEq5rDH4O/6nJIWzv7F9q4TyF6mghVx3lnqDJ+UltXE5FqeUUkD5JpravgjiK4ZEvmG6MkyvhmEBgE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218858; c=relaxed/simple;
	bh=5ZyzNz0Sm72FrIcgVg1yVZzQ3dql7Zb+xQ3cpLxHlmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6bkWutoS10m/XotXhfAHHXglYvS4+5zcax+9EpaPQBZqU3jr/gPib8O9ayv1WdAwaw927xa7QBmLOBZfM6DHbbafhSxGIdabmI8a3iF/FXSJWokOyB0x8W4ynKBrw7z6n+zm2M11zJQlC7E4PJqK5zWJYqNoL/3mASSljMpFeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KdaG89f/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218855;
	bh=5ZyzNz0Sm72FrIcgVg1yVZzQ3dql7Zb+xQ3cpLxHlmw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KdaG89f/LuAnqDL4HVE+B6vJoIfLwKvzcCgitdsS3+WHMcm2brwUit+Zffjesr+5y
	 OjpU0Sv4rChCUA8mWUFwy+fAC1Px9wQLXki3hkKo/ZczvorUu87L6NPkGwhbCYzoxk
	 SIjfrxQX/ZLKd8VZLSCgYO5/vtnjl96la66EF0BEx87yLXzyXaUkC7Ww9A9nFlTd9n
	 VqO8Aj6FZ/JL/1y63TJO5M9ZKAvULWpu2Y1z1a9pbXE640o5lp2Pok469RpOLvfhND
	 3almUWDDxSb8mtnv6QPqcot1WMH9mRQ61lRO496fceZHh7IfC8QxAwMIFlbs/OTax9
	 XiPI7CaSxIJvQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BF94E17E35E0;
	Tue,  3 Dec 2024 10:40:54 +0100 (CET)
Message-ID: <016b77dc-2d33-4639-b241-2574ad877971@collabora.com>
Date: Tue, 3 Dec 2024 10:40:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/18] arm64: dts: mediatek: mt7988: add fixed
 regulators for 1v8 and 3v3
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-4-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add regulator nodes used for mmc to Bananapi R4 board.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

If you're adding the eMMC regulators, I assume that there's an eMMC, or that even
if there's no device in some version of the board, these two regulators are always
assigned to the eMMC device - right?

You should, at this point, do exactly that: you can leave the mmc0 disabled and
only enable it in a DTBO.

&mmc0 {
	/* eMMC gets enabled by DTBO if present */
	vmmc-supply = <&reg_3p3v>;
	vqmmc-supply = <&reg_1p8v>;
};

Cheers,
Angelo

> ---
> v2:
> - move mmc regulators to board dts of bpi-r4
> ---
>   .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts   | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> index d914eae2b524..df53512c6890 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
> @@ -8,6 +8,24 @@ / {
>   	compatible = "bananapi,bpi-r4", "mediatek,mt7988a";
>   	model = "Banana Pi BPI-R4";
>   	chassis-type = "embedded";
> +
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-1.8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-3.3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
>   };
>   
>   &pio {



