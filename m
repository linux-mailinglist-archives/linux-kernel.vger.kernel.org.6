Return-Path: <linux-kernel+bounces-333415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D34D97C847
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DE11F24F53
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFD019CC34;
	Thu, 19 Sep 2024 10:59:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA0619B3C0;
	Thu, 19 Sep 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726743573; cv=none; b=uR4jbyJgnvmyrCFtkKvh+FzY8lkmp+xRv9B0AhkhwhOyIwd5utpH0itsfS4u6xfG9N2FEO4l4zc5nxf3uSdL7cYT95qH9+mdY58fG069rB9qAtR/zncy8LghrhGs7Du2Ct2FUbNct9LHUQOIhx3l9DuXkd7uxgpYRCxyQi8K5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726743573; c=relaxed/simple;
	bh=mxFAOVyrY0vyBJ7RF0Fc/M95egmsj3e4Xp70EK3JIoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nC1/OMZsEhkn/AkKsUH++Dc/t2bPINiqL67HF6d54i+rVeqEBFkagUgd4sej8KGoV4Gjf2L5K/r/5pc8/Tk/a2i+eaL3oj/inkehvzCRmrJxZIWWxRzCmQy1NuHyLXC7nDfDCEQGnOniutSK6JLJMUJ2kiY0Pw8XoQ7TlGfNotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D65A1007;
	Thu, 19 Sep 2024 03:59:59 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E4143F71A;
	Thu, 19 Sep 2024 03:59:27 -0700 (PDT)
Date: Thu, 19 Sep 2024 11:59:23 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Kamil Kasperski <ressetkk@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v4 3/3] arm64: dts: allwinner: h616: add support for T95
 tv boxes
Message-ID: <20240919115923.6869adfb@donnerap.manchester.arm.com>
In-Reply-To: <ff3b061a-27b7-42b3-b741-1d25c06487ae@gmail.com>
References: <20240319-add-t95-axp313-support-v4-0-6204b6d23229@gmail.com>
	<20240319-add-t95-axp313-support-v4-3-6204b6d23229@gmail.com>
	<20240319232236.07007592@minigeek.lan>
	<ff3b061a-27b7-42b3-b741-1d25c06487ae@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Mar 2024 00:33:50 +0100
Kamil Kasperski <ressetkk@gmail.com> wrote:

Hi Kamil,

> W dniu 20.03.2024 o=C2=A000:22, Andre Przywara pisze:
> > On Tue, 19 Mar 2024 18:50:24 +0100
> > Kamil Kasperski <ressetkk@gmail.com> wrote:
> >
> > Hi Kamil,
> > =20
> >> Add dtsi file for T95 tv boxes and add initial support for T95 5G AXP3=
13A
> >> variant with a board name H616-T95MAX-AXP313A-v3.0 Internal storage is=
 not
> >> accessible due to lack of support for H616 NAND controller.
> >>
> >> Signed-off-by: Kamil Kasperski <ressetkk@gmail.com> =20
> > thanks for the changes, looks good now, although a bit minimal ;-)
> >
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> >
> > Please can you wait till the -rc1 release on Sunday, and send a rebased
> > version next week? There is a small merge conflict in the dts Makefile
> > as of now.
> >
> > Cheers,
> > Andre =20
>=20
> Sure, no problem. Thank you very much for a review.

It's been a while, but can you maybe send a rebased version of this
patch set again? The merge window has just opened, so exactly now is
probably not a good time, but if you rebase on v6.12-rc1, due to be
released on the 29th September, we can get this queued.

Some minor things I just spotted below:

> Once it gets merged I'll get back to u-boot patch.
>=20
> Cheers,
> Kamil
>=20
> > =20
> >> ---
> >>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
> >>  arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi | 109 ++++++++++++=
+++++++++
> >>  .../dts/allwinner/sun50i-h616-t95max-axp313.dts    |  84 ++++++++++++=
++++
> >>  3 files changed, 194 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/=
dts/allwinner/Makefile
> >> index 21149b346a60..294921f12b73 100644
> >> --- a/arch/arm64/boot/dts/allwinner/Makefile
> >> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> >> @@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6-mi=
ni.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-cb1-manta.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-bigtreetech-pi.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> >> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-t95max-axp313.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-x96-mate.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h618-longanpi-3h.dtb
> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h618-orangepi-zero2w.dtb
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi b/arch=
/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi
> >> new file mode 100644
> >> index 000000000000..4c02408733bc
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi
> >> @@ -0,0 +1,109 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +/*
> >> + * Copyright (C) 2024 Kamil Kasperski <ressetkk@gmail.com>
> >> + *
> >> + * Common DT nodes for H616-based T95 TV boxes
> >> + * There are two versions reported with different PMIC variants.
> >> + */
> >> +
> >> +#include "sun50i-h616.dtsi"
> >> +
> >> +#include <dt-bindings/gpio/gpio.h>
> >> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +
> >> +/ {
> >> +	aliases {
> >> +		ethernet1 =3D &sdio_wifi;
> >> +		serial0 =3D &uart0;
> >> +	};
> >> +
> >> +	chosen {
> >> +		stdout-path =3D "serial0:115200n8";
> >> +	};
> >> +
> >> +	reg_vcc5v: vcc5v {
> >> +		/* board wide 5V supply directly from the DC input */
> >> +		compatible =3D "regulator-fixed";
> >> +		regulator-name =3D "vcc-5v";
> >> +		regulator-min-microvolt =3D <5000000>;
> >> +		regulator-max-microvolt =3D <5000000>;
> >> +		regulator-always-on;
> >> +	};
> >> +
> >> +	reg_vcc3v3: vcc3v3 {
> >> +		/* discrete 3.3V regulator */
> >> +		compatible =3D "regulator-fixed";
> >> +		regulator-name =3D "vcc-3v3";
> >> +		regulator-min-microvolt =3D <3300000>;
> >> +		regulator-max-microvolt =3D <3300000>;
> >> +		regulator-always-on;

Can you please add a line:
		vin-supply =3D <&reg_vcc5v>;
here, to not leave this regulator dangling? That should also suppress a
warning about a dummy regulator.

> >> +	};
> >> +
> >> +	wifi_pwrseq: pwrseq {
> >> +		compatible =3D "mmc-pwrseq-simple";
> >> +		clocks =3D <&rtc CLK_OSC32K_FANOUT>;
> >> +		clock-names =3D "ext_clock";
> >> +		pinctrl-0 =3D <&x32clk_fanout_pin>;
> >> +		pinctrl-names =3D "default";
> >> +		reset-gpios =3D <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
> >> +	};
> >> +};
> >> +
> >> +&ehci0 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&ehci2 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&ir {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&mmc0 {
> >> +	cd-gpios =3D <&pio 8 16 GPIO_ACTIVE_LOW>;	/* PI16 */
> >> +	bus-width =3D <4>;
> >> +	status =3D "okay";

Please add a:
	disable-wp;
here, as microSD slots don't have a write-protect switch. We are in the
process of fixing all sunxi arm64 boards in this respect, but this DT would
probably miss that effort.

> >> +};
> >> +
> >> +&mmc1 {
> >> +	mmc-pwrseq =3D <&wifi_pwrseq>;
> >> +	bus-width =3D <4>;
> >> +	non-removable;
> >> +	status =3D "okay";
> >> +
> >> +	sdio_wifi: wifi@1 {
> >> +		reg =3D <1>;
> >> +	};
> >> +};
> >> +
> >> +&ohci0 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&ohci2 {
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&uart0 {
> >> +	pinctrl-names =3D "default";
> >> +	pinctrl-0 =3D <&uart0_ph_pins>;
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&uart1 {
> >> +	pinctrl-names =3D "default";
> >> +	pinctrl-0 =3D <&uart1_pins>, <&uart1_rts_cts_pins>;
> >> +	uart-has-rtscts;
> >> +	status =3D "okay";

As Jernej mentioned: this is probably for connecting to the Bluetooth part
of the WiFi chip, so please add a least a comment here. And I wonder if we
know what Bluetooth IP this is, and if there is a compatible string for
that? Does the vendor firmware give any clue here?

Cheers,
Andre

> >> +};
> >> +
> >> +&usbotg {
> >> +	dr_mode =3D "host";	/* USB A type receptable */
> >> +	status =3D "okay";
> >> +};
> >> +
> >> +&usbphy {
> >> +	status =3D "okay";
> >> +};
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.d=
ts b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
> >> new file mode 100644
> >> index 000000000000..08a6b4fcc235
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-t95max-axp313.dts
> >> @@ -0,0 +1,84 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +/*
> >> + * Copyright (C) 2024 Kamil Kasperski <ressetkk@gmail.com>
> >> + *
> >> + * Configuration for T95 TV box with board label H616-T95MAX-AXP313A-=
v3.0
> >> + */
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include "sun50i-h616-t95.dtsi"
> >> +
> >> +/ {
> >> +	model =3D "T95 5G (AXP313)";
> >> +	compatible =3D "t95,t95max-axp313", "allwinner,sun50i-h616";
> >> +};
> >> +
> >> +&mmc0 {
> >> +	vmmc-supply =3D <&reg_dldo1>;
> >> +};
> >> +
> >> +&mmc1 {
> >> +	vmmc-supply =3D <&reg_dldo1>;
> >> +	vqmmc-supply =3D <&reg_aldo1>;
> >> +};
> >> +
> >> +&r_i2c {
> >> +	status =3D "okay";
> >> +
> >> +	axp313: pmic@36 {
> >> +		compatible =3D "x-powers,axp313a";
> >> +		reg =3D <0x36>;
> >> +		#interrupt-cells =3D <1>;
> >> +		interrupt-controller;
> >> +
> >> +		vin1-supply =3D <&reg_vcc5v>;
> >> +		vin2-supply =3D <&reg_vcc5v>;
> >> +		vin3-supply =3D <&reg_vcc5v>;
> >> +
> >> +		regulators {
> >> +			reg_aldo1: aldo1 {
> >> +				regulator-always-on;
> >> +				regulator-min-microvolt =3D <1800000>;
> >> +				regulator-max-microvolt =3D <1800000>;
> >> +				regulator-name =3D "vcc1v8";
> >> +			};
> >> +
> >> +			reg_dldo1: dldo1 {
> >> +				regulator-always-on;
> >> +				regulator-min-microvolt =3D <3300000>;
> >> +				regulator-max-microvolt =3D <3300000>;
> >> +				regulator-name =3D "vcc3v3";
> >> +			};
> >> +
> >> +			reg_dcdc1: dcdc1 {
> >> +				regulator-always-on;
> >> +				regulator-min-microvolt =3D <810000>;
> >> +				regulator-max-microvolt =3D <990000>;
> >> +				regulator-name =3D "vdd-gpu-sys";
> >> +			};
> >> +
> >> +			reg_dcdc2: dcdc2 {
> >> +				regulator-always-on;
> >> +				regulator-min-microvolt =3D <810000>;
> >> +				regulator-max-microvolt =3D <1100000>;
> >> +				regulator-name =3D "vdd-cpu";
> >> +			};
> >> +
> >> +			reg_dcdc3: dcdc3 {
> >> +				regulator-always-on;
> >> +				regulator-min-microvolt =3D <1500000>;
> >> +				regulator-max-microvolt =3D <1500000>;
> >> +				regulator-name =3D "vdd-dram";
> >> +			};
> >> +		};
> >> +	};
> >> +};
> >> +
> >> +&pio {
> >> +	vcc-pc-supply =3D <&reg_aldo1>;
> >> +	vcc-pf-supply =3D <&reg_dldo1>;
> >> +	vcc-pg-supply =3D <&reg_aldo1>;
> >> +	vcc-ph-supply =3D <&reg_dldo1>;
> >> +	vcc-pi-supply =3D <&reg_dldo1>;
> >> +};
> >> =20
>=20


