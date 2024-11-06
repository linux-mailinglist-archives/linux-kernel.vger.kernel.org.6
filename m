Return-Path: <linux-kernel+bounces-398279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD57B9BEEA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D010C1C23F93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7298C1CC89D;
	Wed,  6 Nov 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IetfN3Wc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4541DF995;
	Wed,  6 Nov 2024 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899159; cv=none; b=Qm7t1MNL0ORdQefLbjhAN9cOxLuSWU/VyGOJqALhVo+IDbv0E85jllEUQdG1pSHUuJYCfoc39t145Cfp7dRUimk9bR93F/+sREmiYWFp5OpH3kCaTPWz55HLWSAYhbI92UbpeeJaDkByaiLSKbi9cG25t6LA7D5KJ6Ud4DRt4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899159; c=relaxed/simple;
	bh=TAI+2CrEdmrSSIj6MqPr/UZzBM8r9QxzuoTVg0oNfqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tE1OtIbWFsD6AG8HXzr4CfK9h6TZmcePOrbOlGltjSFf9/ZIz52T9OxZZsdYqxc/ytM5zAhuPD5xYNLj7EtayO5o/CRMnR6ZPdhpLxANad6t3paF6KSUPNti1JHJqa/lNjH6PGDGwN8cuJjmiIavcT6tT+QX0C5GqCNIZ7m/iFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IetfN3Wc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730899154;
	bh=TAI+2CrEdmrSSIj6MqPr/UZzBM8r9QxzuoTVg0oNfqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IetfN3Wc7H0SQ9+4KBQg46c0VJWWeNB011oOWRoCs2SAJzM/9SSRXf7QJtm3KzmDU
	 xKvfIKoxd/bTCXdDY0EAoFrKida8py4Fwk/NQlhVJku64gZI9POZ9nSX3NL1/ktyhv
	 z1zqSEOo8IckMSZtDWQS096sgWn/NL4MpukJ9LpbD/jA5o5eckyAAOnxwq0TaC+D3w
	 /LI7N9S+PvoW29SSCgNw2ad2Y/wF/2uy+Vhjp43lYJ5AmXCzB6+h3kPHgZqEcODZeW
	 iRNwPPnXG0dez1eMIIAV3rAO7UTxB3dy6OeFU9xHvYmUYhmoIHUlvZ2LeffXne+VOK
	 Yj0bpUfdTBFuA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D132C17E3636;
	Wed,  6 Nov 2024 14:19:13 +0100 (CET)
Message-ID: <b66dbf9e-b35b-482c-9eb7-112ef1f398d6@collabora.com>
Date: Wed, 6 Nov 2024 14:19:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: Introduce MT8188 Geralt
 platform based Ciri
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20241105093222.4055774-1-fshao@chromium.org>
 <20241105093222.4055774-3-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241105093222.4055774-3-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/11/24 10:30, Fei Shao ha scritto:
> Introduce MT8188-based Chromebook Ciri, also known commercially as
> Lenovo Chromebook Duet (11", 9).
> 
> Ciri is a detachable device based on the Geralt design, where Geralt is
> the codename for the MT8188 platform. Ciri offers 8 SKUs to accommodate
> different combinations of second-source components, including:
> - audio codecs (RT5682S and ES8326)
> - speaker amps (TAS2563 and MAX98390)
> - MIPI-DSI panels (BOE nv110wum-l60 and IVO t109nw41)
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
> Changes in v2:
> - remove invalid or undocumented properties
>      e.g. mediatek,dai-link, maxim,dsm_param_name etc.
> - remove touchscreen as the driver is not yet accepted in upstream
> - update sound DAI link node name to match the binding
> - add missing pinctrls in audio codec nodes
> 
>   arch/arm64/boot/dts/mediatek/Makefile         |    8 +
>   .../dts/mediatek/mt8188-geralt-ciri-sku0.dts  |   11 +
>   .../dts/mediatek/mt8188-geralt-ciri-sku1.dts  |   60 +
>   .../dts/mediatek/mt8188-geralt-ciri-sku2.dts  |   56 +
>   .../dts/mediatek/mt8188-geralt-ciri-sku3.dts  |   15 +
>   .../dts/mediatek/mt8188-geralt-ciri-sku4.dts  |   43 +
>   .../dts/mediatek/mt8188-geralt-ciri-sku5.dts  |   73 +
>   .../dts/mediatek/mt8188-geralt-ciri-sku6.dts  |   69 +
>   .../dts/mediatek/mt8188-geralt-ciri-sku7.dts  |   47 +
>   .../boot/dts/mediatek/mt8188-geralt-ciri.dtsi |  397 +++++
>   .../boot/dts/mediatek/mt8188-geralt.dtsi      | 1492 +++++++++++++++++
>   11 files changed, 2271 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 8fd7b2bb7a15..c6c34d99316b 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -69,6 +69,14 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-voltorb-sku589824.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-voltorb-sku589825.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku0.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku1.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku2.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku3.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku4.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku5.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku6.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku7.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r5-sku2.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts
> new file mode 100644
> index 000000000000..7a2edbaa74f1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +/dts-v1/;
> +#include "mt8188-geralt-ciri.dtsi"
> +
> +/ {
> +	model = "Google Ciri sku0 board";
> +	compatible = "google,ciri-sku0", "google,ciri", "mediatek,mt8188";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
> new file mode 100644
> index 000000000000..c40d41e1dd36
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +/dts-v1/;
> +#include "mt8188-geralt-ciri.dtsi"
> +
> +/ {
> +	model = "Google Ciri sku1 board";
> +	compatible = "google,ciri-sku1", "google,ciri", "mediatek,mt8188";
> +};
> +
> +&dsi_panel {
> +	compatible = "ivo,t109nw41", "himax,hx83102";
> +};
> +
> +&i2c0 {
> +	/delete-node/ audio-codec@1a;
> +
> +	es8326: audio-codec@19 {
> +		compatible = "everest,es8326";
> +		reg = <0x19>;
> +		interrupts-extended = <&pio 108 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&audio_codec_pins>;
> +		#sound-dai-cells = <0>;
> +		everest,jack-pol = [0e];
> +		everest,interrupt-clk = [00];
> +	};
> +};
> +
> +&sound {
> +	compatible = "mediatek,mt8188-es8326";
> +	model = "mt8188_m98390_8326";
> +
> +	audio-routing =
> +		"ETDM1_OUT", "ETDM_SPK_PIN",
> +		"ETDM2_OUT", "ETDM_HP_PIN",
> +		"ETDM1_IN", "ETDM_SPK_PIN",
> +		"ETDM2_IN", "ETDM_HP_PIN",
> +		"ADDA Capture", "MTKAIF_PIN",
> +		"Headphone Jack", "HPOL",
> +		"Headphone Jack", "HPOR",
> +		"MIC1", "Headset Mic",
> +		"Left Spk", "Front Left BE_OUT",
> +		"Right Spk", "Front Right BE_OUT";
> +	status = "okay";
> +
> +	dai-link-2 {
> +		codec {
> +			sound-dai = <&es8326>;
> +		};
> +	};
> +
> +	dai-link-3 {
> +		codec {
> +			sound-dai = <&es8326>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts
> new file mode 100644
> index 000000000000..846fd685d4b2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2024 Google LLC
> + */
> +/dts-v1/;
> +#include "mt8188-geralt-ciri.dtsi"
> +
> +/ {
> +	model = "Google Ciri sku2 board";
> +	compatible = "google,ciri-sku2", "google,ciri", "mediatek,mt8188";
> +};
> +
> +&i2c0 {
> +	/delete-node/ audio-codec@1a;
> +
> +	es8326: audio-codec@19 {
> +		compatible = "everest,es8326";
> +		reg = <0x19>;
> +		interrupts-extended = <&pio 108 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&audio_codec_pins>;
> +		#sound-dai-cells = <0>;
> +		everest,jack-pol = [0e];
> +		everest,interrupt-clk = [00];
> +	};
> +};
> +
> +&sound {
> +	compatible = "mediatek,mt8188-es8326";
> +	model = "mt8188_m98390_8326";
> +
> +	audio-routing =
> +		"ETDM1_OUT", "ETDM_SPK_PIN",
> +		"ETDM2_OUT", "ETDM_HP_PIN",
> +		"ETDM1_IN", "ETDM_SPK_PIN",
> +		"ETDM2_IN", "ETDM_HP_PIN",
> +		"ADDA Capture", "MTKAIF_PIN",
> +		"Headphone Jack", "HPOL",
> +		"Headphone Jack", "HPOR",
> +		"MIC1", "Headset Mic",
> +		"Left Spk", "Front Left BE_OUT",
> +		"Right Spk", "Front Right BE_OUT";
> +	status = "okay";
> +
> +	dai-link-2 {
> +		codec {
> +			sound-dai = <&es8326>;
> +		};
> +	};
> +
> +	dai-link-3 {
> +		codec {
> +			sound-dai = <&es8326>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
> new file mode 100644
> index 000000000000..d037c2528fe2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2024 Google LLC
> + */
> +/dts-v1/;
> +#include "mt8188-geralt-ciri.dtsi"
> +
> +/ {
> +	model = "Google Ciri sku3 board";
> +	compatible = "google,ciri-sku3", "google,ciri", "mediatek,mt8188";
> +};
> +
> +&dsi_panel {
> +	compatible = "ivo,t109nw41", "himax,hx83102";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts
> new file mode 100644
> index 000000000000..591ffcd5b95f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2024 Google LLC
> + */
> +/dts-v1/;
> +#include "mt8188-geralt-ciri.dtsi"
> +
> +/ {
> +	model = "Google Ciri sku4 board (rev4)";
> +	compatible = "google,ciri-sku4", "google,ciri", "mediatek,mt8188";
> +};
> +
> +&i2c0 {
> +	/delete-node/ amplifier@38;
> +	/delete-node/ amplifier@39;
> +
> +	tas2563: amplifier@4f {
> +		compatible = "ti,tas2563", "ti,tas2781";
> +		reg = <0x4f>, <0x4c>; /* left / right channel */
> +		reset-gpios = <&pio 118 GPIO_ACTIVE_HIGH>;
> +		#sound-dai-cells = <0>;
> +	};
> +};
> +
> +&sound {
> +	model = "mt8188_tas2563_5682";
> +	audio-routing =
> +		"ETDM1_OUT", "ETDM_SPK_PIN",
> +		"ETDM2_OUT", "ETDM_HP_PIN",
> +		"ETDM1_IN", "ETDM_SPK_PIN",
> +		"ETDM2_IN", "ETDM_HP_PIN",
> +		"ADDA Capture", "MTKAIF_PIN",
> +		"Headphone Jack", "HPOL",
> +		"Headphone Jack", "HPOR",
> +		"IN1P", "Headset Mic";
> +	status = "okay";
> +
> +	dai-link-1 {
> +		codec {
> +			sound-dai = <&tas2563>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
> new file mode 100644
> index 000000000000..e352c3bf659b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2024 Google LLC
> + */
> +/dts-v1/;
> +#include "mt8188-geralt-ciri.dtsi"
> +
> +/ {
> +	model = "Google Ciri sku5 board (rev4)";
> +	compatible = "google,ciri-sku5", "google,ciri", "mediatek,mt8188";
> +};
> +
> +&dsi_panel {
> +	compatible = "ivo,t109nw41", "himax,hx83102";
> +};
> +
> +&i2c0 {
> +	/delete-node/ audio-codec@1a;
> +	/delete-node/ amplifier@38;
> +	/delete-node/ amplifier@39;
> +
> +	es8326: audio-codec@19 {
> +		compatible = "everest,es8326";
> +		reg = <0x19>;
> +		interrupts-extended = <&pio 108 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&audio_codec_pins>;
> +		#sound-dai-cells = <0>;
> +		everest,jack-pol = [0e];
> +		everest,interrupt-clk = [00];
> +	};
> +
> +	tas2563: amplifier@4f {
> +		compatible = "ti,tas2563", "ti,tas2781";
> +		reg = <0x4f>, <0x4c>; /* left / right channel */
> +		reset-gpios = <&pio 118 GPIO_ACTIVE_HIGH>;
> +		#sound-dai-cells = <0>;
> +	};
> +};
> +
> +&sound {
> +	compatible = "mediatek,mt8188-es8326";
> +	model = "mt8188_tas2563_8326";
> +
> +	audio-routing =
> +		"ETDM1_OUT", "ETDM_SPK_PIN",
> +		"ETDM2_OUT", "ETDM_HP_PIN",
> +		"ETDM1_IN", "ETDM_SPK_PIN",
> +		"ETDM2_IN", "ETDM_HP_PIN",
> +		"ADDA Capture", "MTKAIF_PIN",
> +		"Headphone Jack", "HPOL",
> +		"Headphone Jack", "HPOR",
> +		"MIC1", "Headset Mic";
> +	status = "okay";
> +
> +	dai-link-1 {
> +		codec {
> +			sound-dai = <&tas2563>;
> +		};
> +	};
> +
> +	dai-link-2 {
> +		codec {
> +			sound-dai = <&es8326>;
> +		};
> +	};
> +
> +	dai-link-3 {
> +		codec {
> +			sound-dai = <&es8326>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts
> new file mode 100644
> index 000000000000..7e14cda8b66a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2024 Google LLC
> + */
> +/dts-v1/;
> +#include "mt8188-geralt-ciri.dtsi"
> +
> +/ {
> +	model = "Google Ciri sku6 board (rev4)";
> +	compatible = "google,ciri-sku6", "google,ciri", "mediatek,mt8188";
> +};
> +
> +&i2c0 {
> +	/delete-node/ audio-codec@1a;
> +	/delete-node/ amplifier@38;
> +	/delete-node/ amplifier@39;
> +
> +	es8326: audio-codec@19 {
> +		compatible = "everest,es8326";
> +		reg = <0x19>;
> +		interrupts-extended = <&pio 108 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&audio_codec_pins>;
> +		#sound-dai-cells = <0>;
> +		everest,jack-pol = [0e];
> +		everest,interrupt-clk = [00];
> +	};
> +
> +	tas2563: amplifier@4f {
> +		compatible = "ti,tas2563", "ti,tas2781";
> +		reg = <0x4f>, <0x4c>; /* left / right channel */
> +		reset-gpios = <&pio 118 GPIO_ACTIVE_HIGH>;
> +		#sound-dai-cells = <0>;
> +	};
> +};
> +
> +&sound {
> +	compatible = "mediatek,mt8188-es8326";
> +	model = "mt8188_tas2563_8326";
> +
> +	audio-routing =
> +		"ETDM1_OUT", "ETDM_SPK_PIN",
> +		"ETDM2_OUT", "ETDM_HP_PIN",
> +		"ETDM1_IN", "ETDM_SPK_PIN",
> +		"ETDM2_IN", "ETDM_HP_PIN",
> +		"ADDA Capture", "MTKAIF_PIN",
> +		"Headphone Jack", "HPOL",
> +		"Headphone Jack", "HPOR",
> +		"MIC1", "Headset Mic";
> +	status = "okay";
> +
> +	dai-link-1 {
> +		codec {
> +			sound-dai = <&tas2563>;
> +		};
> +	};
> +
> +	dai-link-2 {
> +		codec {
> +			sound-dai = <&es8326>;
> +		};
> +	};
> +
> +	dai-link-3 {
> +		codec {
> +			sound-dai = <&es8326>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
> new file mode 100644
> index 000000000000..7eda79f4484a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2024 Google LLC
> + */
> +/dts-v1/;
> +#include "mt8188-geralt-ciri.dtsi"
> +
> +/ {
> +	model = "Google Ciri sku7 board (rev4)";
> +	compatible = "google,ciri-sku7", "google,ciri", "mediatek,mt8188";
> +};
> +
> +&dsi_panel {
> +	compatible = "ivo,t109nw41", "himax,hx83102";
> +};
> +
> +&i2c0 {
> +	/delete-node/ amplifier@38;
> +	/delete-node/ amplifier@39;
> +
> +	tas2563: amplifier@4f {
> +		compatible = "ti,tas2563", "ti,tas2781";
> +		reg = <0x4f>, <0x4c>; /* left / right channel */
> +		reset-gpios = <&pio 118 GPIO_ACTIVE_HIGH>;
> +		#sound-dai-cells = <0>;
> +	};
> +};
> +
> +&sound {
> +	model = "mt8188_tas2563_5682";
> +	audio-routing =
> +		"ETDM1_OUT", "ETDM_SPK_PIN",
> +		"ETDM2_OUT", "ETDM_HP_PIN",
> +		"ETDM1_IN", "ETDM_SPK_PIN",
> +		"ETDM2_IN", "ETDM_HP_PIN",
> +		"ADDA Capture", "MTKAIF_PIN",
> +		"Headphone Jack", "HPOL",
> +		"Headphone Jack", "HPOR",
> +		"IN1P", "Headset Mic";
> +	status = "okay";
> +
> +	dai-link-1 {
> +		codec {
> +			sound-dai = <&tas2563>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
> new file mode 100644
> index 000000000000..62c8a37a4c3d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
> @@ -0,0 +1,397 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +/dts-v1/;
> +#include "mt8188-geralt.dtsi"
> +
> +/delete-node/ &pp3300_edp_disp;
> +
> +&aud_etdm_hp_on {
> +	pins-mclk {
> +		pinmux = <PINMUX_GPIO114__FUNC_O_I2SO2_MCK>;
> +	};
> +};
> +
> +&aud_etdm_hp_off {
> +	pins-mclk {
> +		pinmux = <PINMUX_GPIO114__FUNC_B_GPIO114>;
> +		bias-pull-down;
> +		input-enable;
> +	};
> +};
> +
> +&aud_etdm_spk_on {
> +	pins-bus {
> +		drive-strength = <8>;
> +	};
> +};
> +
> +/* Ciri's TDP design target is 90 degrees */

...and there's only Ciri in this submission, so move that to -geralt.dtsi

> +&cpu_little0_alert0 {
> +	temperature = <90000>;
> +	hysteresis = <2000>;
> +	type = "passive";
> +};
> +
> +&cpu_little1_alert0 {
> +	temperature = <90000>;
> +	hysteresis = <2000>;
> +	type = "passive";
> +};
> +
> +&cpu_little2_alert0 {
> +	temperature = <90000>;
> +	hysteresis = <2000>;
> +	type = "passive";
> +};
> +
> +&cpu_little3_alert0 {
> +	temperature = <90000>;
> +	hysteresis = <2000>;
> +	type = "passive";
> +};
> +
> +&cpu_big0_alert0 {
> +	temperature = <90000>;
> +	hysteresis = <2000>;
> +	type = "passive";
> +};
> +
> +&cpu_big1_alert0 {
> +	temperature = <90000>;
> +	hysteresis = <2000>;
> +	type = "passive";
> +};
> +
> +&dp_intf0 {
> +	/delete-node/ port;

Just don't add dp_intf0 if there's none, instead of removing the port here.

> +};
> +
> +&dsi_panel {
> +	compatible = "boe,nv110wum-l60", "himax,hx83102";

Move this to each SKU dts file.

> +};
> +
> +&edp_tx {
> +	/delete-node/ ports;
> +	/delete-node/ aux-bus;
> +};
> +
> +&i2c0 {
> +	/delete-node/ audio-codec@1a;
> +	/delete-node/ amplifier@3a;
> +	/delete-node/ amplifier@3b;

No board ever uses those three nodes, because it's all Ciri and nothing else.
Just never declare these in -geralt.dtsi and never delete them here.

> +
> +	rt5682s: audio-codec@1a {
> +		compatible = "realtek,rt5682s";
> +		reg = <0x1a>;
> +		interrupts-extended = <&pio 108 IRQ_TYPE_EDGE_BOTH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&audio_codec_pins>;
> +		#sound-dai-cells = <1>;
> +
> +		AVDD-supply = <&mt6359_vio18_ldo_reg>;
> +		DBVDD-supply = <&mt6359_vio18_ldo_reg>;
> +		LDO1-IN-supply = <&mt6359_vio18_ldo_reg>;
> +		MICVDD-supply = <&pp3300_s3>;
> +		realtek,jd-src = <1>;
> +	};
> +};
> +
> +&i2c2 {
> +	status = "disabled";

...and if there's no i2c2, just don't add it to -geralt.dtsi in the first place...
but I believe that you just wanted to avoid probing the device that you declared
in -geralt.dtsi on this bus, so you can either remove the nodes for all of the
unused i2c busses in your board designs, or you can keep them but remove all of
the devices that aren't actually there.

It's your choice in the end, but disabling this here doesn't make much sense imo.

> +};
> +
> +&i2c_tunnel {
> +	/delete-node/ sbs-battery@b;

Since nothing ever uses sbs-battery@b, just remove sbs-battery@b entirely
from -geralt.dtsi instead of deleting it here.

Non-Ciri boards, if any, will define the @b one if necessary in their own
dts/dtsi file(s).

> +
> +	battery: sbs-battery@f {
> +		compatible = "sbs,sbs-battery";
> +		reg = <0xf>;
> +		sbs,i2c-retry-count = <2>;
> +		sbs,poll-retry-count = <1>;
> +	};
> +};
> +
> +&max98390_38 {
> +	sound-name-prefix = "Front Right";

Move to -geralt.dtsi

> +};
> +
> +&max98390_39 {
> +	sound-name-prefix = "Front Left";

ditto

> +};
> +
> +&mipi_tx_config0 {
> +	drive-strength-microamp = <5200>;
> +};
> +
> +&mmc1 {
> +	status = "disabled";

Why are you configuring mmc1 in -geralt.dtsi if no board uses it at all?

> +};
> +
> +&mt6359_vm18_ldo_reg {
> +	regulator-min-microvolt = <1800000>;
> +	regulator-max-microvolt = <1900000>;
> +	regulator-microvolt-offset = <100000>;
> +};
> +
> +&sound {
> +	compatible = "mediatek,mt8188-rt5682s";
> +	model = "mt8188_m98390_5682";
> +
> +	audio-routing =
> +		"ETDM1_OUT", "ETDM_SPK_PIN",
> +		"ETDM2_OUT", "ETDM_HP_PIN",
> +		"ETDM1_IN", "ETDM_SPK_PIN",
> +		"ETDM2_IN", "ETDM_HP_PIN",
> +		"ADDA Capture", "MTKAIF_PIN",
> +		"Headphone Jack", "HPOL",
> +		"Headphone Jack", "HPOR",
> +		"IN1P", "Headset Mic",
> +		"Left Spk", "Front Left BE_OUT",
> +		"Right Spk", "Front Right BE_OUT";

Please move compatible, model and audio-routing to SKU0 (and also copy that to
SKU3): as you're continuously overriding it in all other SKUs, having it here
can only confuse people...

> +	status = "okay";
> +
> +	dai-link-0 {
> +		dai-format = "i2s";

...and move dai-format to -geralt.dtsi.

> +	};
> +
> +	dai-link-1 {
> +		dai-format = "i2s";
> +		codec {
> +			sound-dai = <&max98390_38>,
> +				    <&max98390_39>;
> +		};
> +	};
> +
> +	dai-link-2 {
> +		codec {
> +			sound-dai = <&rt5682s 0>;
> +		};
> +	};
> +
> +	dai-link-3 {
> +		codec {
> +			sound-dai = <&rt5682s 0>;
> +		};
> +	};
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&spi1_pins_default>;
> +	pinctrl-1 = <&spi1_pins_sleep>;

Also move this to -geralt.dtsi, it's even the same pins...!
P.S.: Of course, move the spi1_pins_sleep to -geralt.dtsi as well.

> +	num-cs = <1>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;

...address and size cells, but no children nodes?

> +};
> +
> +&pio {

..snip..

> +
> +	touchscreen_rst: touchscreen-rst-pins {
> +		pins-tchscr-rst {
> +			pinmux = <PINMUX_GPIO5__FUNC_B_GPIO5>;
> +			output-high;
> +		};
> +	};

touchscreen_rst is unused - either use it or remove it.

> +
> +	spi1_pins_default: spi1-default-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO75__FUNC_O_SPIM1_CSB>,
> +				 <PINMUX_GPIO76__FUNC_O_SPIM1_CLK>,
> +				 <PINMUX_GPIO77__FUNC_B0_SPIM1_MOSI>,
> +				 <PINMUX_GPIO78__FUNC_B0_SPIM1_MISO>;
> +			bias-disable;
> +			drive-strength = <10>;
> +		};
> +	};
> +
> +	spi1_pins_sleep: spi1-sleep-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO75__FUNC_B_GPIO75>,
> +				 <PINMUX_GPIO76__FUNC_B_GPIO76>,
> +				 <PINMUX_GPIO77__FUNC_B_GPIO77>,
> +				 <PINMUX_GPIO78__FUNC_B_GPIO78>;
> +			bias-pull-down;
> +			input-enable;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> new file mode 100644
> index 000000000000..0d33ae82f0eb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> @@ -0,0 +1,1492 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + */
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include "mt8188.dtsi"
> +#include "mt6359.dtsi"
> +
> +/ {
> +	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		mmc0 = &mmc0;
> +		mmc1 = &mmc1;
> +		serial0 = &uart0;
> +	};
> +
> +	backlight_lcd0: backlight-lcd0 {
> +		compatible = "pwm-backlight";
> +		brightness-levels = <0 1023>;
> +		default-brightness-level = <576>;
> +		enable-gpios = <&pio 1 GPIO_ACTIVE_HIGH>;
> +		num-interpolated-steps = <1023>;
> +		power-supply = <&ppvar_sys>;
> +		pwms = <&disp_pwm0 0 500000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	dmic-codec {
> +		compatible = "dmic-codec";
> +		num-channels = <2>;
> +		wakeup-delay-ms = <100>;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";

		/* The size will be filled in by the bootloader */
		reg = <0 0x40000000 0 0>;


> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +

..snip..

> +
> +&disp_dsi0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	dsi_panel: panel@0 {
> +		compatible = "boe,tv110c9m-ll3";

Remove the compatible string, then add a comment (93 cols, it's ok in one line):

/* Compatible string for different panels can be found in each device dts */

> +		reg = <0>;
> +		enable-gpios = <&pio 25 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mipi_dsi_pins>;
> +
> +		backlight = <&backlight_lcd0>;
> +		avdd-supply = <&ppvar_mipi_disp_avdd>;
> +		avee-supply = <&ppvar_mipi_disp_avee>;
> +		pp1800-supply = <&mt6359_vm18_ldo_reg>;
> +		rotation = <270>;
> +
> +		status = "okay";
> +
> +		port {
> +			dsi_panel_in: endpoint {
> +				remote-endpoint = <&dsi_out>;
> +			};
> +		};
> +	};
> +
> +	port {
> +		dsi_out: endpoint {
> +			remote-endpoint = <&dsi_panel_in>;
> +		};
> +	};
> +};
> +
> +&disp_pwm0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&disp_pwm0_pins>;
> +	status = "okay";
> +};
> +
> +&disp_pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&disp_pwm1_pins>;
> +};
> +
> +&dp_intf0 {
> +	port {
> +		dp_intf0_out: endpoint {
> +			remote-endpoint = <&edp_in>;
> +		};
> +	};
> +};
> +
> +&dp_intf1 {
> +	status = "okay";
> +
> +	port {
> +		dp_intf1_out: endpoint {
> +			remote-endpoint = <&dptx_in>;
> +		};
> +	};
> +};
> +
> +&dp_tx {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dp_tx_hpd>;
> +	#sound-dai-cells = <0>;
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +			dptx_in: endpoint {
> +				remote-endpoint = <&dp_intf1_out>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			dptx_out: endpoint {
> +				data-lanes = <0 1 2 3>;
> +			};
> +		};
> +	};
> +};
> +
> +&edp_tx {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&edp_tx_hpd>;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +			edp_in: endpoint {
> +				remote-endpoint = <&dp_intf0_out>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			edp_out: endpoint {
> +				data-lanes = <0 1 2 3>;
> +				remote-endpoint = <&edp_panel_in>;
> +			};
> +		};
> +	};
> +
> +	/*
> +	 * Geralt also supports eDP OLED panels, which control panel
> +	 * brightness via the AUX channel and don't require PWM pin
> +	 * control.
> +	 * This is an auxiliary panel path for hardware layout
> +	 * validation and demonstration, so it's disabled by default.
> +	 * Boards adopting MIPI-DSI panels may not have this path.
> +	 **/

There's no board using this: please remove edp_tx entirely, as this is
only adding lines to this device tree for no useful reason.

If a board with that appears, you can reintroduce this here, or if it is
a single board, you can add that in the board dts.

> +	aux-bus {
> +		edp_panel: panel {
> +			compatible = "lg,lp120up1";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&edp_bl_en>;
> +			power-supply = <&pp3300_edp_disp>;
> +			status = "disabled";
> +
> +			port {
> +				edp_panel_in: endpoint {
> +					remote-endpoint = <&edp_out>;
> +				};
> +			};
> +		};
> +	};
> +};
> +

..snip..
> +	edp_bl_en: edp-bl-en-pins {
> +		pins-ap-disp-bklten {
> +			pinmux = <PINMUX_GPIO1__FUNC_B_GPIO1>;
> +			output-low;
> +		};
> +	};
> +
> +	edp_disp_en: edp-disp-en-pins {
> +		pins-en-pp3300-edp-disp {
> +			pinmux = <PINMUX_GPIO27__FUNC_B_GPIO27>;
> +			output-low;
> +		};
> +	};
> +
> +	edp_tx_hpd: edp-tx-hpd-pins {
> +		pins-dp-tx-hpd {
> +			pinmux = <PINMUX_GPIO17__FUNC_I0_EDP_TX_HPD>;
> +		};
> +	};

After removing the always disabled edp nodes, you can also remove these pins
as they are then unused.

> +
> +	gsc_int: gsc-int-pins {
> +		pins-gsc-ap-int-odl {
> +			pinmux = <PINMUX_GPIO0__FUNC_B_GPIO0>;
> +			input-enable;
> +		};
> +	};
> +

..snip..

> +&pmic {
> +	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&scp {

Is this SCP-dual or SCP?
I see SCP, but I also see a SCP-Dual memory region... what's going on here?

Of course, the SCP-Dual won't work if you don't override the compatible string...

> +	firmware-name = "mediatek/mt8188/scp.img";
> +	memory-region = <&scp_mem>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&scp_pins>;
> +	status = "okay";
> +
> +	cros-ec-rpmsg {
> +		compatible = "google,cros-ec-rpmsg";
> +		mediatek,rpmsg-name = "cros-ec-rpmsg";
> +	};
> +};
> +
> +&sound {
> +	compatible = "mediatek,mt8188-nau8825";
> +	model = "mt8188_m98390_8825";
> +	pinctrl-names = "aud_etdm_hp_on",
> +			"aud_etdm_hp_off",
> +			"aud_etdm_spk_on",
> +			"aud_etdm_spk_off",
> +			"aud_mtkaif_on",
> +			"aud_mtkaif_off";

	pinctrl-names = "aud_etdm_hp_on", "aud_etdm_hp_off",
			"aud_etdm_spk_on", "aud_etdm_spk_off",
			"aud_mtkaif_on", "aud_mtkaif_off";

> +	pinctrl-0 = <&aud_etdm_hp_on>;
> +	pinctrl-1 = <&aud_etdm_hp_off>;
> +	pinctrl-2 = <&aud_etdm_spk_on>;
> +	pinctrl-3 = <&aud_etdm_spk_off>;
> +	pinctrl-4 = <&aud_mtkaif_on>;
> +	pinctrl-5 = <&aud_mtkaif_off>;

Add a comment:

	/* The audio-routing is defined in each board dts */

> +	audio-routing = "ETDM1_OUT", "ETDM_SPK_PIN",
> +			"ETDM2_OUT", "ETDM_HP_PIN",
> +			"ETDM1_IN", "ETDM_SPK_PIN",
> +			"ETDM2_IN", "ETDM_HP_PIN",
> +			"ADDA Capture", "MTKAIF_PIN",
> +			"Headphone Jack", "HPOL",
> +			"Headphone Jack", "HPOR",
> +			"MIC", "Headset Mic",
> +			"Left Spk", "Front Left BE_OUT",
> +			"Right Spk", "Front Right BE_OUT",
> +			"Rear Left Spk", "Rear Left BE_OUT",
> +			"Rear Right Spk", "Rear Right BE_OUT";
> +

...and remove the audio-routing from this dtsi; it's anyway being
overridden by the -ciri.dtsi devicetree...

> +	mediatek,adsp = <&adsp>;
> +
> +	status = "okay";
> +
> +	dai-link-0 {
> +		link-name = "ETDM1_IN_BE";
> +		dai-format = "dsp_b";
> +		mediatek,clk-provider = "cpu";
> +	};
> +
> +	dai-link-1 {
> +		link-name = "ETDM1_OUT_BE";
> +		dai-format = "dsp_b";
> +		mediatek,clk-provider = "cpu";
> +
> +		codec {
> +			sound-dai = <&max98390_38>,
> +				    <&max98390_39>,
> +				    <&max98390_3a>,
> +				    <&max98390_3b>;
> +		};
> +	};
> +
> +	dai-link-2 {
> +		link-name = "ETDM2_IN_BE";
> +		mediatek,clk-provider = "cpu";
> +
> +		codec {
> +			sound-dai = <&nau8825>;
> +		};
> +	};
> +
> +	dai-link-3 {
> +		link-name = "ETDM2_OUT_BE";
> +		mediatek,clk-provider = "cpu";
> +
> +		codec {
> +			sound-dai = <&nau8825>;
> +		};
> +	};
> +
> +	dai-link-4 {
> +		link-name = "DPTX_BE";
> +
> +		codec {
> +			sound-dai = <&dp_tx>;
> +		};
> +	};
> +};
> +

Cheers,
Angelo


