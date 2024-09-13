Return-Path: <linux-kernel+bounces-328184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0454697802F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851AF1F21234
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B191DA2FB;
	Fri, 13 Sep 2024 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="bGfXFbMI"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96321DA117;
	Fri, 13 Sep 2024 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230986; cv=none; b=mEq7ZQoB6mFKaBnQbZtPfqMu0zGQjptxcGvA3yXdY6x+H7LcdeatFHDefOpTId5hrBD/vmttCFv91rrbr06IqRMwp0JspALvcFFTG0VU6wm6X54ZSbXTIBfYrfJCv8KODZ40Mxmj/8cufCsJDoTYJPQv7JuOIJTXbMOPUuTc6kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230986; c=relaxed/simple;
	bh=Ifn0TKO0V+PgQPdTNsWQiKqLin4teSEr1KycJN33zL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eD90vSgFhmgCx6+ygo9pxFHiPI0oblp6eGtMHcaBy4yLtlWjf3wSYkyIfPvoK9bhSQrufAX1qTOYEVaQT4Qw20qvPnBPl2nlODRH04OUtftCzQaL0ssa7OIxaz7uJvkrDdID/d+0BEiQDa/YLnp+Yh4tTj0A7UiM96mzplo88UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=bGfXFbMI; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726230964; x=1726835764; i=wahrenst@gmx.net;
	bh=w9pQp4vcOCGEB2IVxFlezSTyTVaHXt1RWt+5/SWFMvU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bGfXFbMIjf96b5I5b+EA1MEz9vKCI/XmovQWnsAmQjlzxDOlXFk8Pslww+bUSCWu
	 Cn/63c8esUsBfqb8WdKbY1knO/IUMva+5Bchly7Qd2DvpcnAKB0Ntk2X0f3DdOBbM
	 W0JqZia0HDNXyTfPIxxL7+hOox+5HA5I5RUQ3CW+VULdCGg+9vKSMJR4Bq+/f8UK4
	 w9/ICb2/S+oVdsf+rFfOXNwimX8jFNZByjGhVTXe8cobyoOgMOGv8NyuYHWyRP4ZC
	 KCOh+qzLaq9uTtihWMSpbTdaTNd4Qc1GSYxSoGZBrlxFvOB+z31Se+Vr3VaLA6nGV
	 oaIYtt7Rbn7XFpxlRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.100] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiPl-1sQ6x70br3-00Hpte; Fri, 13
 Sep 2024 14:36:04 +0200
Message-ID: <e1a2c92a-1d60-4251-9133-5fc238866336@gmx.net>
Date: Fri, 13 Sep 2024 14:36:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] dts: nxp: mxs: Add descriptions for imx287 based
 btt3-[012] devices
To: Lukasz Majewski <lukma@denx.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240912124825.2528984-1-lukma@denx.de>
 <20240912124825.2528984-2-lukma@denx.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240912124825.2528984-2-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yq2Xp1xqt7dzn632TVX0+ZW1pwfLlRq/3qjbhLeEDjeCJQxT7Fq
 6vTdYpZV5Fq9/t1et4lOpXqTtAw6AS4nTkDp8GJkQBGMQo1pSSJsTqml9spxEPXfm8LGRbV
 YNjKbd37DVlVyp4RA0FavJnLda8tLit0vRsyVIUkWjCq3ZqJ2aVS9rBQvz8QRq9yMI3/UPJ
 u0UoR/Om6EW27sSC6qIlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:89DhqAHWlCE=;u+0nyf4LDnqt+vhvCDQZLVG5QPW
 by5hBsK7eW8srAMKtZ6GvI2575vMi0Am8KtnDO3zFqu9WSaJIT3Cb0V9zUBCi/R7ODijCoO69
 ZOB0PaHq9AjUnh7C2y4I62rDFk7fknulDCMagFvLv3koufWmwjcO94yMnQAkHJyMABS+vegf8
 2CPABs6ts6qmkvQYyRgF+fYNyxibKRUDn601MKObfOk38VLwAbk+K3lNTQl32EaZD/Z0TLbWc
 5lQ1D1AVTOjFN3+hne1lLZP5gI8+WMY1y2CC2nF7PVa2jV7vxjtCf8ibwUHEQxZN0zv/8qKGh
 zQFvFdNzyksUnFZfcAQWuwfeUFseftqidV4KoSQGxVrUIgLr7lAJ2tnw2JE32pYwMlopF3fHQ
 ex0EkQcWnhXcg4RjEDBJ4P22q+9nxkdO24N3ei2WtJj4yevivlbGZCH4hI743s+qNkXUIVK9A
 FVg46Zfpouzbw2rzvoNkmSqgqiF9+t5A7iaZH1oTNRC0hC36FsCF3zC9TkyBc30BviA/xlctW
 RgySkIm5vcbWlXPjHUbGeH8BEmfPWBvv1YRvTh7sYD+dcnjXIT01YSOf4FN1p34cxdJf8BP52
 bwA/aoCwGpmP+e6iJCX+FcCJMrR0H5WphaQIUhfLFMUBDdve/Onup1td7UDDapJvnLa41ozqD
 nDTfNnSgSFrtG0pjJoIkMJJ85iU+Ncd2c9ebJSpLi98zrpe1dSqHjV/s65IKC/9klY6DnueM2
 8mlUP4ZONMSXCZcOf++D1WZ/tAf6tMGTh3NTCdrcWEY8aXh4E281wXfpMMdxSRg7LqSUJgbbk
 sUK6RTY15SvBFNOafypijrvg==

Hi Lukasz,

please adjust the subject of your patch accordingly to the subsystem.

Suggestion

ARM: dts: mxs: Add descriptions for imx287 based btt3-[012] devices

Am 12.09.24 um 14:48 schrieb Lukasz Majewski:
> The btt3 device' HW revisions from 0 to 2 use imx287 SoC and are to
> some extend similar to already upstreamed XEA devices, hence are
> using common imx28-lwe.dtsi file.
>
> New, imx28-btt3.dtsi has been added to embrace common DTS
> properties for different HW revisions for this device.
>
> As a result - changes introduced in imx28-btt3-[012].dts are
> minimal.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>
> ---
> Changes for v2:
> - Rename dts file from btt3-[012] to imx28-btt3-[012] to match current
>    linux kernel naming convention
> - Remove 'wlf,wm8974' from compatible for codec@1a
>
> Changes for v3:
> - Keep alphabethical order for Makefile entries
>
> Changes for v4:
> - Change compatible for btt3 board (to 'lwn,imx28-btt3')
>
> Changes for v5:
> - Combine patch, which adds btt3-[012] with one adding board entry to
>    fsl.yaml
>
> Changes for v6:
> - Make the patch series for adding entry in fsl.yaml and btt3
> ---
>   arch/arm/boot/dts/nxp/mxs/Makefile         |   3 +
>   arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts |  12 +
>   arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts |   8 +
>   arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts |  12 +
>   arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi  | 320 +++++++++++++++++++++
>   5 files changed, 355 insertions(+)
>   create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts
>   create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts
>   create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts
>   create mode 100644 arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi
>
> diff --git a/arch/arm/boot/dts/nxp/mxs/Makefile b/arch/arm/boot/dts/nxp/=
mxs/Makefile
> index a430d04f9c69..96dd31ea19ba 100644
> --- a/arch/arm/boot/dts/nxp/mxs/Makefile
> +++ b/arch/arm/boot/dts/nxp/mxs/Makefile
> @@ -8,6 +8,9 @@ dtb-$(CONFIG_ARCH_MXS) +=3D \
>   	imx28-apf28.dtb \
>   	imx28-apf28dev.dtb \
>   	imx28-apx4devkit.dtb \
> +	imx28-btt3-0.dtb \
> +	imx28-btt3-1.dtb \
> +	imx28-btt3-2.dtb \
>   	imx28-cfa10036.dtb \
>   	imx28-cfa10037.dtb \
>   	imx28-cfa10049.dtb \
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts b/arch/arm/boot/=
dts/nxp/mxs/imx28-btt3-0.dts
> new file mode 100644
> index 000000000000..6ac46e4b21bb
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-0.dts
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2024
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + */
> +
> +/dts-v1/;
> +#include "imx28-btt3.dtsi"
> +
> +&hog_pins_rev {
> +	fsl,pull-up =3D <MXS_PULL_ENABLE>;
> +};
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts b/arch/arm/boot/=
dts/nxp/mxs/imx28-btt3-1.dts
> new file mode 100644
> index 000000000000..213fe931c58b
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-1.dts
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2024
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + */
> +
> +/dts-v1/;
> +#include "imx28-btt3.dtsi"
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts b/arch/arm/boot/=
dts/nxp/mxs/imx28-btt3-2.dts
> new file mode 100644
> index 000000000000..c787c2d03463
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-btt3-2.dts
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2024
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + */
> +
> +/dts-v1/;
> +#include "imx28-btt3.dtsi"
> +
> +&lcdif {
> +	display =3D <&display_te_b>;
The reason why you don't move the second display into this file is
because you expect a new hardware revision in the future?
> +};
> diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi b/arch/arm/boot/d=
ts/nxp/mxs/imx28-btt3.dtsi
> new file mode 100644
> index 000000000000..94a21ea8d5d2
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/mxs/imx28-btt3.dtsi
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2024
> + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> + */
> +/dts-v1/;
> +#include "imx28-lwe.dtsi"
> +
> +/ {
> +	model =3D "BTT3";
> +
> +	compatible =3D "lwn,imx28-btt3", "fsl,imx28";
> +
> +	chosen {
> +	       bootargs =3D "root=3D/dev/mmcblk0p2 rootfstype=3Dext4 ro rootwa=
it console=3DttyAMA0,115200 panic=3D1 quiet";
> +	};
It's a little bit unusual to place so many Linux specific stuff into the
device tree bootargs.
> +
> +	memory@40000000 {
> +		reg =3D <0x40000000 0x10000000>;
> +		device_type =3D "memory";
> +	};
> +
> +	poweroff {
> +		compatible =3D "gpio-poweroff";
> +		gpios =3D <&gpio0 24 0>;
Please use the GPIO polarity defines.
> +	};
> +
> +	sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,name =3D "BTTC Audio";
> +		simple-audio-card,widgets =3D "Speaker", "BTTC Speaker";
> +		simple-audio-card,routing =3D "BTTC Speaker", "SPKOUTN", "BTTC Speake=
r", "SPKOUTP";
> +		simple-audio-card,dai-link@0 {
> +			format =3D "left_j";
> +			bitclock-master =3D <&dai0_master>;
> +			frame-master =3D <&dai0_master>;
> +			mclk-fs =3D <256>;
> +			dai0_master: cpu {
> +				sound-dai =3D <&saif0>;
> +			};
> +			codec {
> +				sound-dai =3D <&wm89xx>;
> +				clocks =3D <&saif0>;
> +			};
> +		};
> +	};
> +
> +	wifi_pwrseq: sdio-pwrseq {
> +		compatible =3D "mmc-pwrseq-simple";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&wifi_en_pin_bttc>;
> +		reset-gpios =3D <&gpio0 27 GPIO_ACTIVE_LOW>;
> +		/* W1-163 needs 60us for WL_EN to be low and */
> +		/* 150ms after high before downloading FW is possible */
> +		post-power-on-delay-ms =3D <200>;
> +		power-off-delay-us =3D <100>;
> +	};
> +};
> +
> +&auart0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&auart0_2pins_a>;
> +	status =3D "okay";
> +};
> +
> +&auart3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&auart3_pins_a>;
> +	uart-has-rtscts;
> +	status =3D "okay";
> +};
> +
> +&i2c0 {
> +	wm89xx: codec@1a {
> +		compatible =3D "wlf,wm8940";
> +		reg =3D <0x1a>;
> +		#sound-dai-cells =3D <0>;
> +	};
> +};
> +
> +&lcdif {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&lcdif_24bit_pins_a>, <&lcdif_sync_pins_bttc>,
> +		    <&lcdif_reset_pins_bttc>;
> +	lcd-supply =3D <&reg_3v3>;
> +	display =3D <&display0>;
> +	status =3D "okay";
> +	display0: display0 {
> +		bits-per-pixel =3D <32>;
> +		bus-width =3D <24>;
> +		display-timings {
> +			native-mode =3D <&timing0>;
> +			timing0: timing0 {
> +				clock-frequency =3D <6500000>;
> +				hactive =3D <320>;
> +				vactive =3D <240>;
> +				hfront-porch =3D <20>;
> +				hback-porch =3D <38>;
> +				hsync-len =3D <30>;
> +				vfront-porch =3D <4>;
> +				vback-porch =3D <14>;
> +				vsync-len =3D <4>;
> +				hsync-active =3D <0>;
> +				vsync-active =3D <0>;
> +				de-active =3D <0>;
> +				pixelclk-active =3D <1>;
> +			};
> +		};
> +	};
> +	display_te_b: display1 {
> +		bits-per-pixel =3D <32>;
> +		bus-width =3D <24>;
> +		display-timings {
> +			native-mode =3D <&timing0>;
> +			timing_te_b: timing0 {
> +				clock-frequency =3D <6500000>;
> +				hactive =3D <320>;
> +				vactive =3D <240>;
> +				hfront-porch =3D <20>;
> +				hback-porch =3D <68>;
> +				hsync-len =3D <30>;
> +				vfront-porch =3D <4>;
> +				vback-porch =3D <14>;
> +				vsync-len =3D <4>;
> +				hsync-active =3D <0>;
> +				vsync-active =3D <0>;
> +				de-active =3D <1>;
> +				pixelclk-active =3D <1>;
> +			};
> +		};
> +	};
> +
> +};
> +
> +&mac0 {
> +	clocks =3D <&clks 57>, <&clks 57>, <&clks 64>;
> +	clock-names =3D "ipg", "ahb", "enet_out";
> +	phy-handle =3D <&mac0_phy>;
> +	phy-mode =3D "rmii";
> +	phy-supply =3D <&reg_3v3>;
> +	local-mac-address =3D [ 00 11 B8 00 BF 8A ];
Is this replaced dynamically by the bootloader? Otherwise this suggests
all boards use the same MAC address.
> +	status =3D "okay";
> +
> +	mdio {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		mac0_phy: ethernet-phy@0 {
> +			/* LAN8720Ai - PHY ID */
> +			compatible =3D "ethernet-phy-id0007.c0f0","ethernet-phy-ieee802.3-c2=
2";
> +			reg =3D <0>;
> +			smsc,disable-energy-detect;
> +			max-speed =3D <100>;
> +
> +			reset-gpios =3D <&gpio4 12 GPIO_ACTIVE_LOW>; /* GPIO4_12 */
I think the comment only repeat what is already defined here.
> +			reset-assert-us =3D <1000>;
> +			reset-deassert-us =3D <1000>;
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&hog_pins_a>, <&hog_pins_rev>;
> +
> +	hog_pins_a: hog@0 {
> +		reg =3D <0>;
> +		fsl,pinmux-ids =3D <
> +			MX28_PAD_GPMI_RDY2__GPIO_0_22
> +			MX28_PAD_GPMI_RDY3__GPIO_0_23
> +			MX28_PAD_GPMI_RDN__GPIO_0_24
> +			MX28_PAD_LCD_VSYNC__GPIO_1_28
> +			MX28_PAD_SSP2_SS1__GPIO_2_20
> +			MX28_PAD_SSP2_SS2__GPIO_2_21
> +			MX28_PAD_AUART2_CTS__GPIO_3_10
> +			MX28_PAD_AUART2_RTS__GPIO_3_11
> +			MX28_PAD_GPMI_WRN__GPIO_0_25
> +			MX28_PAD_ENET0_RXD2__GPIO_4_9
> +			MX28_PAD_ENET0_TXD2__GPIO_4_11
> +		>;
> +		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
> +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> +	};
> +
> +	hog_pins_rev: hog@1 {
> +		reg =3D <1>;
> +		fsl,pinmux-ids =3D <
> +			MX28_PAD_ENET0_RXD3__GPIO_4_10
> +			MX28_PAD_ENET0_TX_CLK__GPIO_4_5
> +			MX28_PAD_ENET0_COL__GPIO_4_14
> +			MX28_PAD_ENET0_CRS__GPIO_4_15
> +		>;
> +		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
> +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> +	};
> +
> +	keypad_pins_bttc: keypad-bttc@0 {
> +		reg =3D <0>;
> +		fsl,pinmux-ids =3D <
> +			MX28_PAD_GPMI_D00__GPIO_0_0
> +			MX28_PAD_AUART0_CTS__GPIO_3_2
> +			MX28_PAD_AUART0_RTS__GPIO_3_3
> +			MX28_PAD_GPMI_D03__GPIO_0_3
> +			MX28_PAD_GPMI_D04__GPIO_0_4
> +			MX28_PAD_GPMI_D05__GPIO_0_5
> +			MX28_PAD_GPMI_D06__GPIO_0_6
> +			MX28_PAD_GPMI_D07__GPIO_0_7
> +			MX28_PAD_GPMI_CE1N__GPIO_0_17
> +			MX28_PAD_GPMI_CE2N__GPIO_0_18
> +			MX28_PAD_GPMI_CE3N__GPIO_0_19
> +			MX28_PAD_GPMI_RDY0__GPIO_0_20
> +		>;
> +		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
> +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> +	};
> +
> +	lcdif_sync_pins_bttc: lcdif-bttc@0 {
> +		reg =3D <0>;
> +		fsl,pinmux-ids =3D <
> +			MX28_PAD_LCD_DOTCLK__LCD_DOTCLK
> +			MX28_PAD_LCD_ENABLE__LCD_ENABLE
> +			MX28_PAD_LCD_HSYNC__LCD_HSYNC
> +			MX28_PAD_LCD_RD_E__LCD_VSYNC
> +		>;
> +		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
> +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> +	};
> +
> +	lcdif_reset_pins_bttc: lcdif-bttc@1 {
> +		reg =3D <1>;
> +		fsl,pinmux-ids =3D <
> +			MX28_PAD_LCD_RESET__GPIO_3_30
> +		>;
> +		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
> +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up =3D <MXS_PULL_ENABLE>;
> +	};
> +
> +	ssp1_sdio_pins_a: ssp1-sdio@0 {
> +		reg =3D <0>;
> +		fsl,pinmux-ids =3D <
> +			MX28_PAD_SSP1_DATA0__SSP1_D0
> +			MX28_PAD_GPMI_D01__SSP1_D1
> +			MX28_PAD_GPMI_D02__SSP1_D2
> +			MX28_PAD_SSP1_DATA3__SSP1_D3
> +			MX28_PAD_SSP1_CMD__SSP1_CMD
> +			MX28_PAD_SSP1_SCK__SSP1_SCK
> +		>;
> +		fsl,drive-strength =3D <MXS_DRIVE_8mA>;
> +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up =3D <MXS_PULL_ENABLE>;
> +	};
> +
> +	wifi_en_pin_bttc: wifi_en_pin@0 {
This should trigger a schema warning. The node name should use dashes
instead of underscore.
> +		reg =3D <0>;
> +		fsl,pinmux-ids =3D <
> +			MX28_PAD_GPMI_CLE__GPIO_0_27
> +		>;
> +		fsl,drive-strength =3D <MXS_DRIVE_8mA>;
> +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up =3D <MXS_PULL_ENABLE>;
> +	};
> +};
> +
> +&pwm {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pwm3_pins_a>;
> +	status =3D "okay";
> +};
> +
> +&reg_usb_5v {
> +	gpio =3D <&gpio1 28 0>;
Please use polarity define.
> +};
> +
> +&saif0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&saif0_pins_a>;
> +	#sound-dai-cells =3D <0>;
> +	assigned-clocks =3D <&clks 53>;
> +	assigned-clock-rates =3D <12000000>;
> +	status =3D "okay";
> +};
> +
> +&saif1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&saif1_pins_a>;
> +	fsl,saif-master =3D <&saif0>;
> +	#sound-dai-cells =3D <0>;
> +	status =3D "okay";
> +};
> +
> +&ssp1 {
> +	compatible =3D "fsl,imx28-mmc";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&ssp1_sdio_pins_a>;
> +	bus-width =3D <4>;
> +	no-1-8-v;       /* force 3.3V VIO */
> +	pm-ignore-notify;
This seems to be undocumented.
> +	non-removable;
> +	vmmc-supply =3D <&reg_3v3>;
> +	mmc-pwrseq =3D <&wifi_pwrseq>;
> +	keep-power-in-suspend;
> +	status =3D "okay";
> +
> +	wlan@1 {
> +		reg =3D <1>;
> +		compatible =3D "brcm,bcm4329-fmac";
> +	};
> +};
> +
> +&ssp2 {
> +	compatible =3D "fsl,imx28-spi";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&spi2_pins_a>;
> +	status =3D "okay";
> +};


