Return-Path: <linux-kernel+bounces-533445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41136A45A84
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B872C18940AF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5059F20FA9A;
	Wed, 26 Feb 2025 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k5n6OxUv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E971258CE1;
	Wed, 26 Feb 2025 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563168; cv=none; b=FyZ6zmpG9ng9yZC4Jgy3p+3csQLF9IrNh42WI+6Z+UQQALdDYVZwvcLJq4ax9p+02pg2XOPp2n7zB1OTEWgWOcZFyzhfp4JbbRpN++/K5BbDCF0wMsQtRkQnqL7cRt3cdnCqjwuKCVR5CziYgUrqHVYMJiYm9+lylpD+7NhMFWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563168; c=relaxed/simple;
	bh=4JZL08t7KG0UOC6HcBU5zxjetitwgkZ1Di1DC2VPPN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=i09L9M93Dq5I+G4VeKB2YdPqtNe3QeDstBrU8I63G0FAa4kgxOfaVP8sQntec1dzaoAFwAHTjcyFJKhC8UsOjPFagnbmRPWEjNcUqtOPBDa95THDUyRwqaldiNz9hklnjElVGUkrncrO5YA8IhhTPxlyGD1/uKPLxYK8YWa6jOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k5n6OxUv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740563163;
	bh=4JZL08t7KG0UOC6HcBU5zxjetitwgkZ1Di1DC2VPPN8=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=k5n6OxUv508uzhg0BzGhZ+WDRVvHmEiNyP6gg4N460Q909yqbnMxMDKv3F76dybTx
	 91fj04sQwP4hcEIEibt5qS2aAPyEAM9kHjsRocnfL2uKAtzMN2SN/7jQgFK2CQpzXO
	 zu6B7X7CLTJ4f/6vIJPpwAypYz+ARL15ci/Kzk0bb7Wpf8X/XToW+CAWqEdEVwWDJQ
	 2Z9pvusDBUfiUx7KwJasmBwOTJ0pW59Hl+2hqFt4KJjBC7DNlsmqRz7CxJPeUl8Q8Z
	 wwzPx2ni5VhdrsiBYY55gCK2kaqVHkqtPfvtv8A5UrKeFn2W/ql1YJfmSLlhkEab/y
	 iMIhdoGRy44Tg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0C6A217E0663;
	Wed, 26 Feb 2025 10:46:03 +0100 (CET)
Message-ID: <618b3cdb-0fef-4194-aeb0-4111c011904d@collabora.com>
Date: Wed, 26 Feb 2025 10:46:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH] arm64: dts: mediatek: mt7986: fix pwn fan
 settings for sinovoip bpi-r3 board
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
References: <20250226050132.547353-1-mikhail.kshevetskiy@iopsys.eu>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org
In-Reply-To: <20250226050132.547353-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/02/25 06:01, Mikhail Kshevetskiy ha scritto:

Please reformat the title...

arm64: dts: mediatek: mt7986-bpi-r3: Change fan PWM value for mid speed

> Popular bpi-r3 pwm fans like this one
> 
>    https://www.amazon.com/youyeetoo-Barebone-Fan-BPI-R3-Integrated/dp/B0CCCTY8PS

Such links to products do expire over time, so this commit will eventually have
missing info in the future.

"Popular cheap PWM fans for this machine, like the ones coming in heatsink+fan
combos will not work properly at the currently defined medium speed"

> 
> will not work properly. Trying different pwm setting using a command
> 
>    echo $value > /sys/devices/platform/pwm-fan/hwmon/hwmon1/pwm1
> 
> I found:
> 
>    pwm1 value     fan rotation speed   cpu temperature     notes
>    -----------------------------------------------------------------
>      0            maximal              31.5 Celsius        too noisy
>     40            optimal              35.2 Celsius        no noise hearable
>     95            minimal
>     above 95      does not rotate      55.5 Celsius
>    -----------------------------------------------------------------
> 
> At the moment we have following cooling levels defined:
> 
>    cooling-levels = <255 96 0>;

Yes, we can see that in the actual DT, not necessary to repeat in the description.

"The current cooling levels define a PWM value of 96 for the cpu-active-medium
step..."

> 
> for cpu-active-low, cpu-active-medium and cpu-active-high modes
> correspondingly. Thus only cpu-active-high and cpu-active-low are usable.
> I think this is wrong.
> 
> This patch fixes cpu-active-medium settings for bpi-r3 board.
> 
> PS: I know, the patch is not ideal as it can break pwm fan for some users.
>      There are some peoples that use handmade cooling solutions, but:
>        * discussed cooler is the only 'official' pwm cooler for bpi-r3
>          available on the market.
>        * most peoples will use passive cooling available on the market or
>          the discussed cooler.
>        * the pwm-fan dts section was added before the official cooler
>          appears on the market.
>      Thus it should not be a lot of harm from this fix.

I get that the cheapest fans you can get are not working correctly with the current
mid pwm setting, but you can't break things.

This devicetree should, at this point, hold default values that would generally
make the vast majority of fans to actually spin, because it's impossible to have
something perfectly (or vaguely, sometimes) optimized for each fan on the market.

Of course this means that you need to properly configure your fans in userspace
if you want to reach the sweet spot.

I added Frank and Daniel to this thread, as they are the ones who originally did
upstream this device.

Frank, Daniel, any suggestion regarding the PWM values here?

P.S.: Remember that the fan will still spin to HIGH when temperature gets high,
so the SoC is still thermally protected until users start tuning their fan speed
in userspace.

> 
> This patch may not be enough. Users may wants to tweak their thermal_zone0
> trip points, thus tuning fan rotation speed depending on cpu temperature.
> That can be done on the base of the folloving example:

P.P.S.: Fix typos please.

Thanks,
Angelo


> 
>    === example =========
>    # cpu temterature below 25 Celsius degrees, no rotation
>    echo 25000 > /sys/class/thermal/thermal_zone0/trip_point_4_temp
>    # cpu temperature in [25..32] Celsius degrees, normal rotation speed
>    echo 32000 > /sys/class/thermal/thermal_zone0/trip_point_3_temp
>    # cpu temperature above 50 Celsius degrees, max rotation speed
>    echo 50000 > /sys/class/thermal/thermal_zone0/trip_point_2_temp
>    =====================
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> index ed79ad1ae871..b0cc0cbdff0f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> @@ -42,7 +42,7 @@ fan: pwm-fan {
>   		compatible = "pwm-fan";
>   		#cooling-cells = <2>;
>   		/* cooling level (0, 1, 2) - pwm inverted */
> -		cooling-levels = <255 96 0>;
> +		cooling-levels = <255 40 0>;
>   		pwms = <&pwm 0 10000>;
>   		status = "okay";
>   	};



