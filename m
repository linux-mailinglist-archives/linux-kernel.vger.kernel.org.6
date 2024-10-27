Return-Path: <linux-kernel+bounces-383831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDE99B20A8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F04B20F8A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5DA184520;
	Sun, 27 Oct 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utA08je0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520F170A1B;
	Sun, 27 Oct 2024 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730062970; cv=none; b=UzNPsXRx44HDwvTHNpAAOIthbYx4FQWSOH+iS8YQ4/Sj9Guq/W29P/ijoVDjgFY5O1uCZCPea837/FjmtRbJu0zO6F3g98YwydWU7ShtdaG9vdHZR1ruiS4/Co9T4WGxbIZbnDDR/z6441u1WPH+HmQpESSXHl4J5rUQ2+dI/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730062970; c=relaxed/simple;
	bh=1CN3cHomt0l97thHBnpxa1oYEp4SPAVR2NHJL6u+QI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3AeQ1iSrjY2T/EXcL7VBvaeFddb+PieBQnDUrz2rmSMNfSkwiM85oSSIv/s6x9oj4WK+thamWJqrXlB8tM41KjuqzJh5bepClKYA39nUsF1Jg6QU0VY2DqplC+WMBwJFGVvEAfA+DaQkEnxZsGwKkkdYIibwWlk07kKWiTrWkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utA08je0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E20C4CEC7;
	Sun, 27 Oct 2024 21:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730062970;
	bh=1CN3cHomt0l97thHBnpxa1oYEp4SPAVR2NHJL6u+QI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=utA08je0e4Eju4ck+Wh7xtn2qIbSYoPo3l6BQHj1u6xjzElw425xCeBE+oed70UpQ
	 5GBEduv7K6ntNlsWDJaj7Wa34c9dOfysbGlhFRr3Yh8GXZUIBC4nDVzC0YUuEyU+0x
	 IPn9VoSzZcyBEiJmDVVdYwmIiRmSQefeVdrJ/Smbm0bVoXZ95gqonGRPtSDbC3ureT
	 2kfmtXnZnX42FLcRUATqEdmXnYEhNRNlGPQqf0kM0S9L0WxATKVgOGyrDVLNdvJYPI
	 tmN6fSXVQa6zpQguZSOEvDp5u6ZbCN9pmJiyxPgnnG6CuIbq4n/aj1xrhuqFOg4OWY
	 D5VaW7vk3+AiQ==
Date: Sun, 27 Oct 2024 22:02:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: Introduce MT8188 Geralt
 platform based Ciri
Message-ID: <iupuwxxslb3t76mzy3ufsruwwpd47fuop7y6tfcbwkosdagkxf@fnklbp6t6au2>
References: <20241025110111.1321704-1-fshao@chromium.org>
 <20241025110111.1321704-3-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025110111.1321704-3-fshao@chromium.org>

On Fri, Oct 25, 2024 at 06:59:36PM +0800, Fei Shao wrote:
> Introduce MT8188-based Chromebook Ciri, also known commercially as
> Lenovo Chromebook Duet (11", 9).
> 
> Ciri is a detachable device based on the Geralt design, where Geralt is
> the codename for the MT8188 platform. Ciri offers 8 SKUs to accommodate
> different combinations of second-source components, including:
> - audio codecs (RT5682S and ES8326)
> - speaker amps (TAS2563 and MAX98390)
> - MIPI-DSI panels (BOE NV110WUM-L60 and IVO t109nw41)
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>  arch/arm64/boot/dts/mediatek/Makefile         |    8 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku0.dts  |   11 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku1.dts  |   63 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku2.dts  |   54 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku3.dts  |   20 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku4.dts  |   43 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku5.dts  |   76 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku6.dts  |   67 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku7.dts  |   52 +
>  .../boot/dts/mediatek/mt8188-geralt-ciri.dtsi |  413 +++++
>  .../boot/dts/mediatek/mt8188-geralt.dtsi      | 1497 +++++++++++++++++
>  11 files changed, 2304 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 8fd7b2bb7a15..c6c34d99316b 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -69,6 +69,14 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-voltorb-sku589824.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-voltorb-sku589825.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku0.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku1.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku2.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku3.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku4.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku5.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku6.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku7.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r5-sku2.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
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
> index 000000000000..53fdd5acaa3f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
> @@ -0,0 +1,63 @@
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
> +&touchscreen {
> +	himax,pid = <0x1003>;

Why do you add more of undocumented properties?

> +	firmware-name = "himax_i2chid_1003.bin";
> +};
> +
> +&i2c0 {
> +	/delete-node/ audio-codec@1a;
> +
> +	es8326: audio-codec@19 {
> +		compatible = "everest,es8326";
> +		reg = <0x19>;
> +		interrupts-extended = <&pio 108 IRQ_TYPE_LEVEL_LOW>;
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
> +	hs-capture-dai-link {

Nope, that's not how DAI links are called.

> +		codec {
> +			sound-dai = <&es8326>;
> +		};
> +	};

...

> +&i2c2 {
> +	status = "disabled";
> +};
> +
> +&i2c_tunnel {
> +	/delete-node/ sbs-battery@b;
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
> +	maxim,dsm_param_name = "dsm_param.bin";

NAK. Not a DT property. You cannot send us ACPI stuff.

Go through internal review first, which should tell you that ACPI is not
accepted into DT. There are just few exceptions and codecs do not
qualify.

Best regards,
Krzysztof


