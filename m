Return-Path: <linux-kernel+bounces-185079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37358CB03B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46031C219C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7727B127B40;
	Tue, 21 May 2024 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eZc1qmfA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68395127E2F;
	Tue, 21 May 2024 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301167; cv=none; b=Lo36q2foZXE4g/lXjPSBMsyWew+wyKFwrFZnZOi9/Uidb1pEvDkgdQVLOtYyG3PGvBoceIQB6wvfJpEy+LWBjJ5Ny5gNVkT9e5ooaj6HeZF66VHxd5w4r+Rn9YcJ0HBt1f1swHMZ48Emu2qsZLvUNvOu1juU9MBMrO0zkxTo1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301167; c=relaxed/simple;
	bh=azKC0Vfzh32+CSfRP2wDq5OaQ3ELUVlycMEY4NkDgU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tO+viTeAlk5NhIqO0qooacHk9kS+g7y3IidcOgkjt+Vvg4xCXeFdSrw+/mWeWlIOpW50br1NjhT1158hvXgyaD2tb+G6lI1PlYCzFBaWbZperTZvo3Dq4z9/vg4pgF5QBndf/V6ABEmXg3BCMi4AUbm4iJkAfDScMzjG5cMDbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eZc1qmfA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716301161;
	bh=azKC0Vfzh32+CSfRP2wDq5OaQ3ELUVlycMEY4NkDgU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eZc1qmfAiQAaUmlDqAvO0MSkWkwr2IA9QonlE5eg8HeZqqeA3GfTJq7mUjPkKNtsS
	 +QpkrquKWAYUXmDvsGAqBjOtYqz/Flpuzf8XhIZM5fCcxUcZqrJZcdvfFNkNyPShQ8
	 VEymr8zDhfZE4lI7ufMIzoOqphgAJYU/p9JjP6PBxzHDNPpEpPsTNaHy7YhZE3ZXjr
	 EgUbppA0xwqCxflZhyjhiAAJssRDVbI1mEyJJSx9PY3OByttbJUL8OiyNhNOb3TKLe
	 2SZlpmoSEMq6VU4LYo/UvJzOEilVMMRQi9fjwq68seTj7c1uG7DTKfAEWWZo2/4ZHs
	 69PvrMfxnbYdw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8B65F3782137;
	Tue, 21 May 2024 14:19:20 +0000 (UTC)
Message-ID: <ff12e104-da8b-4800-bfbe-a006ffe1b840@collabora.com>
Date: Tue, 21 May 2024 16:19:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] arm64: dts: mediatek: mt8188: add default thermal
 zones
To: Julien Panis <jpanis@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240521-mtk-thermal-mt818x-dtsi-v4-0-b91ee678411c@baylibre.com>
 <20240521-mtk-thermal-mt818x-dtsi-v4-4-b91ee678411c@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240521-mtk-thermal-mt818x-dtsi-v4-4-b91ee678411c@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/05/24 16:05, Julien Panis ha scritto:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Inspired by the vendor kernel but adapted to the upstream thermal
> driver version.
> 
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 432 +++++++++++++++++++++++++++++++
>   1 file changed, 432 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index a9f1b9db54a6..2b0f3e03acc1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -12,6 +12,8 @@
>   #include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
>   #include <dt-bindings/power/mediatek,mt8188-power.h>
>   #include <dt-bindings/reset/mt8188-resets.h>
> +#include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
>   
>   / {
>   	compatible = "mediatek,mt8188";

.snip..

> +
> +		gpu1-thermal {

You forgot to implement my feedback to Nicolas - this must be gpu-thermal

> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts_ap MT8188_AP_GPU1>;
> +
> +			trips {
> +				gpu1_alert0: trip-alert0 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu1_alert1: trip-alert1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
> +				gpu1_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu2-thermal {

..and for consistency with the other SoCs, this must be gpu1-thermal.

> +			polling-delay = <1000>;
> +			polling-delay-passive = <250>;
> +			thermal-sensors = <&lvts_ap MT8188_AP_GPU2>;
> +
> +			trips {
> +				gpu2_alert0: trip-alert0 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu2_alert1: trip-alert1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +
> +				gpu2_crit: trip-crit {
> +					temperature = <100000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		soc1-thermal {

Any idea of what can "soc1" ever be? What measurement point is that?

VPU? IMG? INFRA?

soc1, soc2, soc3 make little sense.

Regards,
Angelo



