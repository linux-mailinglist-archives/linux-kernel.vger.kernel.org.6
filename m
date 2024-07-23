Return-Path: <linux-kernel+bounces-260041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D3D93A1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A151C22355
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD497152179;
	Tue, 23 Jul 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yqs/oV3d"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736108F70;
	Tue, 23 Jul 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742534; cv=none; b=k9odkcmjC80snRY4w7Wx07I9BPr/fO44pHE3HqLME0kZTvTokVWQakjtnJiME7CPNZbngBXilbQTHRbMEw7pqjUyZaaPM8iWK7S3/65aqdaqTjuqinfYhWHp1ReSQqDm+dzZGiIxv83ogveUlK7g6XGu02DpNVX3i9ZxbVYLqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742534; c=relaxed/simple;
	bh=0101h3AR4t4tFHVUYl3vvkl6dP4t7mFrAs0dfnHYuhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tt/WFdr/cLukVgyRT9sRTexnq0OTVITOsWUxnrO0Unfh4YI50pecTYytyFE6oFezW2BqFA5oGCT45jqNs5B4K8kjDi5kqd4chjM5pmoN2eW+58awaWezzIBm2o5JnWQ6C1wNVuSf6WeegUnzlQV1c0KFeb2U7HlxQQA9gAi02jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Yqs/oV3d; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721742530;
	bh=0101h3AR4t4tFHVUYl3vvkl6dP4t7mFrAs0dfnHYuhY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yqs/oV3d3A1c9LPaI+1J5zcGWIdbIDEd8yNoKJImvMjSIp6l/09WU08rOuXUhLqyl
	 m9XQt16rECAQLjSLEJojCGwauE0Wc+HHvk8wlDyNEYGNzSNcXefQXGrg5tPrLXuYjn
	 mJXYXOp0n+koAORglzN6PNWoSFc8HRcvX16VQQ9d7Jqk5UonTABPcqWD1TYcHjWcnz
	 c8VvjbruG2l5h1T9ZQ0nWvBmIF/pgXn/PXswv7YI9SgZlXzDQF/VXmWV/ZuRWcG4h3
	 5xVnvwVt7Kc3XtFMPwtqsLKlBCQxC2KtXe7XhFW24XqoHMDz24MbtFRp0k9xhzhCqP
	 Az+w45WA3ZZKA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 07829378143B;
	Tue, 23 Jul 2024 13:48:49 +0000 (UTC)
Message-ID: <229cecc5-33b9-4ab7-bd3b-3243415cfa4e@collabora.com>
Date: Tue, 23 Jul 2024 15:48:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt8183: Add kukui-jacuzzi-cerise series
 boards
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240723-jacuzzi_dt-v1-1-3e994a2b5e24@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240723-jacuzzi_dt-v1-1-3e994a2b5e24@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/07/24 11:56, Hsin-Te Yuan ha scritto:
> Cerise is known as ASUS Chromebook CZ1.
> Stern is known as ASUS Chromebook Flip CZ1.
> 
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>   .../dts/mediatek/mt8183-kukui-jacuzzi-cerise.dts   | 25 ++++++++++++++++
>   .../dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi  | 21 +++++++++++++
>   .../dts/mediatek/mt8183-kukui-jacuzzi-stern.dts    | 35 ++++++++++++++++++++++
>   3 files changed, 81 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dts
> new file mode 100644
> index 000000000000..b4f4ed701253
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2021 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8183-kukui-jacuzzi-cerise.dtsi"
> +#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
> +
> +/ {
> +	model = "Google cerise board";
> +	compatible = "google,cerise-sku0", "google,cerise", "mediatek,mt8183";
> +};
> +
> +&mt6358codec {
> +	mediatek,dmic-mode = <1>; /* one-wire */
> +};
> +
> +&touchscreen {
> +	status = "disabled";
> +};
> +
> +&qca_wifi {
> +	qcom,ath10k-calibration-variant = "GO_CERISE";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi
> new file mode 100644
> index 000000000000..087a0ef33e13
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cerise.dtsi
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2021 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8183-kukui-jacuzzi.dtsi"
> +
> +&cpu_thermal {
> +	sustainable-power = <4500>; /* milliwatts */
> +};
> +
> +&mmc1_pins_uhs {
> +	pins-clk {
> +		drive-strength = <MTK_DRIVE_6mA>;
> +	};
> +};
> +
> +&i2c2 {
> +	i2c-scl-internal-delay-ns = <13200>;
> +};

It's really just a few lines, unless more than two devicetrees use those, I'm
more for just putting those in cerise.dts and stern.dts instead of having yet
another dtsi to walk through...


> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-stern.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-stern.dts
> new file mode 100644
> index 000000000000..15e00feae3a9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-stern.dts
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2021 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8183-kukui-jacuzzi-cerise.dtsi"
> +#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
> +
> +/ {
> +	model = "Google stern board";
> +	compatible = "google,cerise-sku1", "google,cerise", "mediatek,mt8183";
> +};
> +
> +&mt6358codec {
> +	mediatek,dmic-mode = <0>; /* two-wire */
> +};
> +
> +&touchscreen {

You are referencing to the touchscreen@10 node from mt8183-kukui-jacuzzi.dtsi...

> +	status = "okay";

...which is not disabled by default, so this property is useless, and

> +
> +	compatible = "hid-over-i2c";

It's originally elan,ekth3500, you override it with hid-over-i2c, that's ok, but

> +	reg = <0x10>;

the node already has this property....

> +	interrupt-parent = <&pio>; > +	interrupts = <155 IRQ_TYPE_LEVEL_LOW>;

...and this one, actually even better, it's using interrupts-extended instead...

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&touchscreen_pins>;

....and it's the same for this

> +
> +	post-power-on-delay-ms = <10>;
> +	hid-descr-addr = <0x0001>;

...but those two aren't present.

So you only need three properties in here :-)

> +};
> +

Apart from that, there's no google,cerise (nor the skus, of course) in the bindings
so please add those to arm/mediatek.yaml between Burnet and Cozmo; only then I will
be able to accept new board dts.

Thanks!
Angelo


