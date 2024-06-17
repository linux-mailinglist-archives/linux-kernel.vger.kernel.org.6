Return-Path: <linux-kernel+bounces-216612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B56390A219
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BF5280F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4844017DE17;
	Mon, 17 Jun 2024 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ZIR0v1lI"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EB4176ACB;
	Mon, 17 Jun 2024 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718589110; cv=none; b=k2vBesbdf+yTv8NecS7sEMcPz8ZtxON/1+jp5LEK/UaDMlr2TmyXt/6V0352DrZBd95fw9sQVuOUGBn/4GJlUnUEdFOWSPqupXPQ++A3Kxdc3hvjjwhbZtDizTViJF1HsNAV4BuRzBCWV4X8bE95bC8jlO1ZHWM/qc7TAugDYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718589110; c=relaxed/simple;
	bh=ngDwTY3j1nXwAIQv0mUkX7nrrF23O7NJyWWHubE4Roc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrOqUQRtsGd/tkh4PA8cl57PGmbaC0ZjhiEYtAuCt6iSw9KH2ZttwEVEG5krC/AhE0Eh4Sko8Y7dyGlF4X1i0Yyj4HD1uqRDbttAyamGgTtEVh3gmULnvLtdtFjl53TU4dds/G2WKYDXZtwZsJsgH4u6ITKTphLO6ejlB8Veksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ZIR0v1lI; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=yjhnsYCfAeoBAabQvKZBv+okYUIYqBnLVfnV+eVmD54=;
	b=ZIR0v1lICYJG3iQZmi9ehNMCButpVAOYVX2BJCxyciLhVEcCLlGUH032xYs8+u
	gQSL8KEfAEvhaTjKqWLppanByLvwe9JnttAJdWBFqXeFnhBNBUsYAODFwJEftq4s
	LKf/QXGKg0utTFt4oF2QB/4CQjrF92w+WjdhvtBPZtwTs=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrAD3XfqYlm9mFcsLCA--.41569S3;
	Mon, 17 Jun 2024 09:51:21 +0800 (CST)
Date: Mon, 17 Jun 2024 09:51:20 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Michael Walle <mwalle@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Li Yang <leoyang.li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Priit Laes <plaes@plaes.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 13/13] ARM: dts: imx6qdl-kontron-samx6i: add actual
 device trees
Message-ID: <Zm+WmDvhXJsprfar@dragon>
References: <20240606090206.2021237-1-mwalle@kernel.org>
 <20240606090206.2021237-14-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606090206.2021237-14-mwalle@kernel.org>
X-CM-TRANSID:ClUQrAD3XfqYlm9mFcsLCA--.41569S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF15ZFy8Zw4Utr1fAF18Krg_yoWxGFy7pa
	s7GFsxWF4xCw1xK34DXryUKF4UAw4DCasI9rn8Ja40yFZ7u3ZrGr9akw15C3W5Jrs5Cw43
	KF92vr1xtwsrXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jf6pPUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDhkBZVszYrt7JgAAsf

On Thu, Jun 06, 2024 at 11:02:06AM +0200, Michael Walle wrote:
> For now, there wasn't any in-tree users of the dtsi files for the
> Kontron SMARC-sAMX6i board. Let's add device trees, for this board on a
> Kontron SMARC Eval 2.0 Carrier.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
>  .../nxp/imx/imx6dl-kontron-samx6i-ads2.dts    |  12 ++
>  .../dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts |  12 ++
>  .../nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi  | 148 ++++++++++++++++++
>  4 files changed, 174 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
> index 231c0d73a53e..92e291603ea1 100644
> --- a/arch/arm/boot/dts/nxp/imx/Makefile
> +++ b/arch/arm/boot/dts/nxp/imx/Makefile
> @@ -99,6 +99,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-icore.dtb \
>  	imx6dl-icore-mipi.dtb \
>  	imx6dl-icore-rqs.dtb \
> +	imx6dl-kontron-samx6i-ads2.dtb \
>  	imx6dl-lanmcu.dtb \
>  	imx6dl-mamoj.dtb \
>  	imx6dl-mba6a.dtb \
> @@ -207,6 +208,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-icore-ofcap10.dtb \
>  	imx6q-icore-ofcap12.dtb \
>  	imx6q-icore-rqs.dtb \
> +	imx6q-kontron-samx6i-ads2.dtb \
>  	imx6q-kp-tpc.dtb \
>  	imx6q-logicpd.dtb \
>  	imx6q-marsboard.dtb \
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts
> new file mode 100644
> index 000000000000..6a0c53f23a15
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6dl-kontron-samx6i-ads2.dts
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0 OR X11
> +
> +/dts-v1/;
> +
> +#include "imx6dl.dtsi"
> +#include "imx6qdl-kontron-samx6i.dtsi"
> +#include "imx6qdl-kontron-samx6i-ads2.dtsi"
> +
> +/ {
> +	model = "Kontron SMARC-sAMX6i Dual-Lite/Solo on SMARC Eval 2.0 carrier";
> +	compatible = "kontron,imx6dl-samx6i-ads2", "kontron,imx6dl-samx6i", "fsl,imx6dl";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts b/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts
> new file mode 100644
> index 000000000000..94c395cc020e
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6q-kontron-samx6i-ads2.dts
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0 OR X11
> +
> +/dts-v1/;
> +
> +#include "imx6q.dtsi"
> +#include "imx6qdl-kontron-samx6i.dtsi"
> +#include "imx6qdl-kontron-samx6i-ads2.dtsi"
> +
> +/ {
> +	model = "Kontron SMARC-sAMX6i Quad/Dual on SMARC Eval 2.0 carrier";
> +	compatible = "kontron,imx6q-samx6i-ads2", "kontron,imx6q-samx6i", "fsl,imx6q";
> +};
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi
> new file mode 100644
> index 000000000000..15a87ee4159d
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-kontron-samx6i-ads2.dtsi
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree include for the Kontron SMARC-sAMX6i board on a SMARC Eval
> + * 2.0 carrier (ADS2).
> + *
> + */
> +
> +/ {
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	sound {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&dailink_master>;
> +		simple-audio-card,frame-master = <&dailink_master>;
> +		simple-audio-card,widgets =
> +			"Headphone", "Headphone Jack",
> +			"Line", "Line Out Jack",
> +			"Microphone", "Microphone Jack",
> +			"Line", "Line In Jack";
> +		simple-audio-card,routing =
> +			"Line Out Jack", "LINEOUTR",
> +			"Line Out Jack", "LINEOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"Headphone Jack", "HPOUTL",
> +			"IN1L", "Line In Jack",
> +			"IN1R", "Line In Jack",
> +			"Microphone Jack", "MICBIAS",
> +			"IN2L", "Microphone Jack",
> +			"IN2R", "Microphone Jack";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&ssi1>;
> +		};
> +
> +		dailink_master: simple-audio-card,codec {
> +			sound-dai = <&wm8904>;
> +		};
> +	};
> +
> +	reg_codec_mic: regulator-codec-mic {
> +		compatible = "regulator-fixed";
> +		regulator-name = "V_3V3_MIC";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reg_codec_1p8v: regulator-codec-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "V_1V8_S0_CODEC";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&audmux {
> +	status = "okay";
> +};
> +
> +&can1 {
> +	status = "okay";
> +};
> +
> +&can2 {
> +	status = "okay";
> +};
> +
> +&ecspi4 {
> +	flash@1 {
> +		compatible = "jedec,spi-nor";
> +		m25p,fast-read;
> +		spi-max-frequency = <100000000>;
> +		reg = <1>;

compatible
reg
spi-max-frequency (generic properties)
m25p,fast-read (device or vendor specific ones)

> +	};
> +};
> +
> +&fec {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +
> +	wm8904: audio-codec@1a {
> +		#sound-dai-cells = <0>;
> +		compatible = "wlf,wm8904";
> +		reg = <0x1a>;

Move #sound-dai-cells here?

Shawn

> +		clocks = <&clks IMX6QDL_CLK_CKO2>;
> +		clock-names = "mclk";
> +		AVDD-supply = <&reg_codec_1p8v>;
> +		CPVDD-supply = <&reg_codec_1p8v>;
> +		DBVDD-supply = <&reg_codec_1p8v>;
> +		DCVDD-supply = <&reg_codec_1p8v>;
> +		MICVDD-supply = <&reg_codec_mic>;
> +	};
> +};
> +
> +&i2c3 {
> +	eeprom@57 {
> +		compatible = "atmel,24c64";
> +		reg = <0x57>;
> +		pagesize = <32>;
> +	};
> +};
> +
> +&pcie {
> +	status = "okay";
> +};
> +
> +&ssi1 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	status = "okay";
> +};
> -- 
> 2.39.2
> 


