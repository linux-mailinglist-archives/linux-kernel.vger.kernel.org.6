Return-Path: <linux-kernel+bounces-333810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106A697CE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 22:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA722854C2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3A913C3CD;
	Thu, 19 Sep 2024 20:22:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014FF29429;
	Thu, 19 Sep 2024 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726777338; cv=none; b=cmaMVFb/mvfcnnE5YPI0S7WLr0FGbao0HK9eYEjaaV3jzTh+QVZK6KykLQjpWki03CQD+00MKU92cdDjuf/X026/o2qG9neHaBxYCqbPdsyndmskJrNpEds9dy8QEzc07EnR9iC1bMaKF8OkzkvahqdzzSTiVN721s0SeYFCf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726777338; c=relaxed/simple;
	bh=cBD5rgF3hHsN9vnuoAsIcKWXWxmExELzV7aksgYxIW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cE8plI+e6jkjTaRnwFjo3RF11JOfh7Peql1yLQj1QoogAzf1OF5Bsfajnob2AIpXLXmWXNopWgLusHr3oq08gSXKqM+nAuArMoEfEuFf/+fCJ5DuUNUm/zZlY2/TnWc8Ujk6Pzndw1zpLCAvOyY762+p/2EvRYS+NTCViz7GYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5EB11007;
	Thu, 19 Sep 2024 13:22:43 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B98593F71A;
	Thu, 19 Sep 2024 13:22:12 -0700 (PDT)
Date: Thu, 19 Sep 2024 21:21:51 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: allwinner: Add disable-wp for boards
 with micro SD card
Message-ID: <20240919212151.50957a14@minigeek.lan>
In-Reply-To: <20240919-b4-nanopineoplus2-fix-mmc0-wp-v2-1-c708a9abc9eb@gmail.com>
References: <20240919-b4-nanopineoplus2-fix-mmc0-wp-v2-1-c708a9abc9eb@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Sep 2024 20:35:39 +0200
Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com> wrote:

> Adding disable-wp property for micro SD nodes of Allwinner arm64 devices.
> Boards were verified from online pictures/tables
> that they have micro SD slots.

The changes itself look good to me, and I checked that the boards in
question have a microSD card slot, so do not feature a write-protect
switch.
You seem to be missing the mmc0 node in
sun50i-h616-bigtreetech-cb1.dtsi though, can you please add this file,
to fix the two boards using this file as well?

With that added:

> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

There are some boards which have their base .dtsi in the arch/arm
directory, but we can tackle those separately.

Cheers,
Andre

> ---
> Sorry that my last messages were not in mailing list,
> one was wrongly sent and second was rejected, as the bot claimed it
> contained html. ---
> Changes in v2:
> - NEW: Added the property to all Sunxi arm64 boards, as discussed in
> mailing list
> - Link to v1:
> https://lore.kernel.org/r/20240914-b4-nanopineoplus2-fix-mmc0-wp-v1-1-12f=
54f0d6620@gmail.com
> --- arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts    |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts         |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts       |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts        |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts      |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts  |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts         |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts          |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi           |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts            |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi              |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi    |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts          |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts       |
> 1 + arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts |
> 1 + 16 files changed, 16 insertions(+)
>=20
> diff --git
> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts index
> 526443bb736c..18fa541795a6 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts @@
> -136,6 +136,7 @@ &mmc0 { vmmc-supply =3D <&reg_vcc3v3>; bus-width =3D <4>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> +	disable-wp;
>  	status =3D "okay";
>  };
> =20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts index
> 05486cccee1c..128295f5a5d6 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts @@ -88,6
> +88,7 @@ ext_rgmii_phy: ethernet-phy@7 {=20
>  &mmc0 {
>  	vmmc-supply =3D <&reg_vcc3v3>;
> +	disable-wp;
>  	bus-width =3D <4>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
>  	status =3D "okay";
> diff --git
> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts index
> 3a7ee44708a2..44fdc8b3f79d 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts @@ -157,6
> +157,7 @@ eth_mac1: mac-address@fa { &mmc0 {
>  	vmmc-supply =3D <&reg_vcc3v3>;
> +	disable-wp;
>  	bus-width =3D <4>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
>  	status =3D "okay";
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts index
> ce3ae19e72db..0f29da7d51e6 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts @@ -153,6
> +153,7 @@ &ir {=20
>  &mmc0 {
>  	vmmc-supply =3D <&reg_vcc3v3>;
> +	disable-wp;
>  	bus-width =3D <4>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
>  	status =3D "okay";
> diff --git
> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts index
> b699bb900e13..d4fc4e60e4e7 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts @@
> -153,6 +153,7 @@ &ir { &mmc0 {
>  	vmmc-supply =3D <&reg_vcc3v3>;
> +	disable-wp;
>  	bus-width =3D <4>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
>  	status =3D "okay";
> diff --git
> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
> index ae85131aac9c..3322cc4d9aa4 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts @@
> -82,6 +82,7 @@ ext_rgmii_phy: ethernet-phy@1 { &mmc0 {
>  	vmmc-supply =3D <&reg_vcc3v3>;
> +	disable-wp;
>  	bus-width =3D <4>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
>  	status =3D "okay";
> diff --git
> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> index 734481e998b8..3eb986c354a9 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts @@
> -79,6 +79,7 @@ hdmi_out_con: endpoint { &mmc0 {
>  	vmmc-supply =3D <&reg_vcc3v3>;
> +	disable-wp;
>  	bus-width =3D <4>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
>  	status =3D "okay";
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts index
> 3be1e8c2fdb9..13a0e63afeaf 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts @@ -129,6
> +129,7 @@ ext_rgmii_phy: ethernet-phy@1 { &mmc0 {
>  	vmmc-supply =3D <&reg_cldo1>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> +	disable-wp;
>  	bus-width =3D <4>;
>  	status =3D "okay";
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts index
> 6c3bfe3d09d9..ab87c3447cd7 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts @@ -131,6
> +131,7 @@ hdmi_out_con: endpoint { &mmc0 {
>  	vmmc-supply =3D <&reg_cldo1>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> +	disable-wp;
>  	bus-width =3D <4>;
>  	status =3D "okay";
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi index
> 13b07141c334..d05dc5d6e6b9 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi @@ -94,6
> +94,7 @@ hdmi_out_con: endpoint { &mmc0 {
>  	vmmc-supply =3D <&reg_cldo1>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> +	disable-wp;
>  	bus-width =3D <4>;
>  	status =3D "okay";
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts index
> c8b275552872..fa7a765ee828 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts @@ -133,6
> +133,7 @@ ext_rgmii_phy: ethernet-phy@1 { &mmc0 {
>  	vmmc-supply =3D <&reg_cldo1>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> +	disable-wp;
>  	bus-width =3D <4>;
>  	status =3D "okay";
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi index
> 855b7d43bc50..bb7de37c0d58 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi @@ -124,6 +124,7
> @@ &mmc0 { pinctrl-0 =3D <&mmc0_pins>;
>  	vmmc-supply =3D <&reg_vcc3v3>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> +	disable-wp;
>  	bus-width =3D <4>;
>  	status =3D "okay";
>  };
> diff --git
> a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi index
> fc7315b94406..a3fe39f8e2ca 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi @@
> -81,6 +81,7 @@ ext_rgmii_phy: ethernet-phy@1 { &mmc0 {
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	disable-wp;
>  	bus-width =3D <4>;
>  	status =3D "okay";
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts index
> 26d25b5b59e0..dd3bd9cca710 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts @@ -52,6
> +52,7 @@ &ir { &mmc0 {
>  	vmmc-supply =3D <&reg_dcdce>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	disable-wp;
>  	bus-width =3D <4>;
>  	status =3D "okay";
>  };
> diff --git
> a/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts index
> 18b29c6b867f..16c68177ff69 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts @@ -111,6
> +111,7 @@ ext_rgmii_phy: ethernet-phy@1 { };=20
>  &mmc0 {
> +	disable-wp;
>  	bus-width =3D <4>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_HIGH>;	/* PF6 */
>  	vmmc-supply =3D <&reg_vcc3v3>;
> diff --git
> a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
> index d6631bfe629f..024377b333c1 100644 ---
> a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts +++
> b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts @@
> -71,6 +71,7 @@ &ir { &mmc0 { vmmc-supply =3D <&reg_dldo1>;
>  	cd-gpios =3D <&pio 8 16 GPIO_ACTIVE_LOW>;	/* PI16 */
> +	disable-wp;
>  	bus-width =3D <4>;
>  	status =3D "okay";
>  };
>=20
> ---
> base-commit: 57f962b956f1d116cd64d5c406776c4975de549d
> change-id: 20240914-b4-nanopineoplus2-fix-mmc0-wp-9d77fb9e6513
>=20
> Best regards,


