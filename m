Return-Path: <linux-kernel+bounces-253545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E5E9322BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D21282708
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6211990AD;
	Tue, 16 Jul 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sH4IwQLV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99ED196450;
	Tue, 16 Jul 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121889; cv=none; b=DB+X1rw0lbt+V7U3tBGTqPZlftBjnUp/a+SKlw6poh7mLvlkBONdD5ocF8XBeONuFNvvT6TFXqTNA/zO09crjOVOucOUy4DuA1HQkMy4v57WzrvTNdik9Iv0t8cEWcbA6Vr5UzLMn7r7WqZnB0Be15HnNBYxl8oAzGSDP3B4iHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121889; c=relaxed/simple;
	bh=lU7qlL1uamfPHcDf1WFGzX289bQX/TvkrTQF2JrqPsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVXUayx/S0dO6/QsUrLTeTlFFaYP8cVfI34AQN1RLFgkYk9aQKDZL+v5bnLoVqfgDy4Weqwls2jMS4GLRhfVFA0OnWjp/pLTf4rEtGxVBk6+LalTxZ2mFpPj8b2SOyK6VQz04ZmSJPmTy4SAK58u0Zb4517gRkvkzekcwNoj1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sH4IwQLV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721121885;
	bh=lU7qlL1uamfPHcDf1WFGzX289bQX/TvkrTQF2JrqPsI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sH4IwQLVeBbX1amWG+qExoVEP7aknwjCFa/EcaMT8nRzmosJQvV/qf2GQnqK2zeMb
	 usxrsErHV6CzphYQJNPnkvyma8+NFgjkoLIVJwzFEs903ebzYcm0uySVNrPLx4MBUs
	 cWGb53yMrW6pZp+THuXGzxhFyMD4QdKGlmSYyXcPaG7JD5vMbModCXlN39YvRgHBb6
	 6RfHjYbBhlo/NUYuNSfJ2CNgdvceXq5+iHm2ARNWlkMm0x5QPeq8JfV4VtdfvlPfbU
	 XnTVqhX95hF/DPq10m6bVzs39bpyDKIdXq4zKt9g5Pgd9uPq73vHrnXWecl+KCXz66
	 lBvvElPtUvRdg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3C6A83780C13;
	Tue, 16 Jul 2024 09:24:45 +0000 (UTC)
Message-ID: <3dd2dcc9-5fbb-4384-985f-a61e26cc8a5f@collabora.com>
Date: Tue, 16 Jul 2024 11:24:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: dts: mediatek: mt8195-cherry: Remove
 keyboard-backlight node
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Tzung-Bi Shih <tzungbi@kernel.org>,
 kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240715-cros-backlight-dt-probe-v1-1-0b5afe64c94b@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240715-cros-backlight-dt-probe-v1-1-0b5afe64c94b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 15/07/24 18:09, Nícolas F. R. A. Prado ha scritto:
> Commit 970c3a6b7aa3 ("mfd: cros_ec: Register keyboard backlight
> subdevice") introduced support for detecting keyboard backlight
> fuctionality through communication with the ChromeOS EC. This means that
> the DT node is no longer used. Remove the unneeded node.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Different CrosEC FW versions could potentially not support discovering
> the keyboard backlight functionality, but I've tested both a recent
> 
>    tomato_v2.0.23149-099cd3e539 tomato_15699.72.0 2024-01-03
> 
> and an old
> 
>    tomato_v2.0.10686-234e646fd8 tomato_14268.0.0 2021-10-07
> 
> version on mt8195-cherry-tomato and on both relying only on the
> discoverability works. I've tested on both tomato-r2 and tomato-r3. I
> have not tested on dojo, however, as I don't have access to it.
> 

Dojo will work anyway because those machines do share the same base FW... but
anyway, I'm not sure that this is the right thing to do.

The commit that you mentioned says that it is meant to make that "work on machines
without specific ACPI or OF support for the keyboard backlight", but not that the
intention is to stop using either ACPI nor DT nodes for that.

The DT kselftest is relatively young, and I suspect that anyway this is not the
only affected device, so the justification is only barely valid.

Don't misunderstand me, I'm not saying that I'm not okay with this, but I'd like to
have more opinions about this.

If we choose to go this way, ideally we should remove this from all of the upstream
Chromebook devicetrees (not only MediaTek, clearly!) so that would require a bit
more effort to test here and there.

Any opinion from anyone?

Cheers,
Angelo

> My motivation to remove the node is because the DT kselftest expects DT
> nodes that can match to a driver to be probed, and with the "breaking"
> commit, the DT node goes unprobed which results in a failure:
> 
>    not ok 225 /soc/spi@1100a000/ec@0/keyboard-backlight
> 
> I can also solve this in a different way, by adding this driver to the
> ignore list of the test. But this solution seemed better as the DT
> isn't meant to describe devices that can be discovered at run time
> anyway.
> ---
>   arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index fe5400e17b0f..20dfa18c9dda 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -1228,10 +1228,6 @@ cros_ec: ec@0 {
>   		spi-max-frequency = <3000000>;
>   		wakeup-source;
>   
> -		keyboard-backlight {
> -			compatible = "google,cros-kbd-led-backlight";
> -		};
> -
>   		i2c_tunnel: i2c-tunnel {
>   			compatible = "google,cros-ec-i2c-tunnel";
>   			google,remote-bus = <0>;
> 
> ---
> base-commit: 91e3b24eb7d297d9d99030800ed96944b8652eaf
> change-id: 20240715-cros-backlight-dt-probe-7754a832ad60
> 
> Best regards,

