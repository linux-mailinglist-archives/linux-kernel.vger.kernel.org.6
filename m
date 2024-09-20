Return-Path: <linux-kernel+bounces-334244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7416097D479
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC8AB2227F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0948A13E02C;
	Fri, 20 Sep 2024 10:52:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493A213B58C;
	Fri, 20 Sep 2024 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726829536; cv=none; b=CxTMlyEVmI/retaKB44k0fjfFc+nULWaQ1XlMBuuUUDeyqg7JeDg4Fjaq+ESJT6HlFv4J7XlQv2Ciqok6QrJ8+0yYkWhCnAldgjrzF+pnjw0SCnkGzexlbDONGpVc+32RpyLw8LQAmN3WudPiWeINXOTWDGSSVCvPnOiO5ghRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726829536; c=relaxed/simple;
	bh=+AVJHOZFocQEpR4sM/heuTB54p64ztcQeipzPwMW2T4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwDHjSCIReT6YWT7Ji/qsaCk34i6qw+uJksSAVAeJWG/aaug3lO3mbpvcwlWhCUNREaU2jLNCuXUqsaMMQ5gclkh63UAntlJxasJGR9vtFhC1cno/0vT0XGn2PAl+I+26knAMPWmy5vasS95Cjjh9Rtv9QrC/Qu0Fz0gjiGVSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0D871007;
	Fri, 20 Sep 2024 03:52:41 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E9403F64C;
	Fri, 20 Sep 2024 03:52:10 -0700 (PDT)
Date: Fri, 20 Sep 2024 11:52:06 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: allwinner: Add disable-wp for boards
 with micro SD card
Message-ID: <20240920115206.1ea2666b@donnerap.manchester.arm.com>
In-Reply-To: <fed7f9f5-0189-4ac4-bcc5-4b59e8b1ccc1@gmail.com>
References: <20240919-b4-nanopineoplus2-fix-mmc0-wp-v2-1-c708a9abc9eb@gmail.com>
	<20240919212151.50957a14@minigeek.lan>
	<fed7f9f5-0189-4ac4-bcc5-4b59e8b1ccc1@gmail.com>
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

On Fri, 20 Sep 2024 07:38:53 +0200
Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com> wrote:

Hi,

> Dne 19. 09. 24 v 22:21 Andre Przywara napsal(a):
> > On Thu, 19 Sep 2024 20:35:39 +0200
> > Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com> wrote:
> >  =20
> >> Adding disable-wp property for micro SD nodes of Allwinner arm64 devic=
es.
> >> Boards were verified from online pictures/tables
> >> that they have micro SD slots. =20
> >=20
> > The changes itself look good to me, and I checked that the boards in
> > question have a microSD card slot, so do not feature a write-protect
> > switch.
> > You seem to be missing the mmc0 node in
> > sun50i-h616-bigtreetech-cb1.dtsi though, can you please add this file,
> > to fix the two boards using this file as well?
> >  =20
>=20
> I wondered about that one, as it's just a compute module without the
> actual slot, I thought it was not right to put it there, as
> someone could wire it to full SD or eMMC in their own board.
> Maybe put it to sun-50i-h616-bigtreetech-cb1-manta.dts and
> sun-50i-h616-bigtreetech-pi.dts instead? The dtsi has broken-cd
> property already, but as it seems it is wired to the connector.
> I was not sure about this, what are your thoughts?

Oh, you are right, so this is actually a "bug" in the existing DT.
Could you please send a separate patch, moving this out of the .dtsi and
into the two board .dts files, adding the disable-wp on the way?
Please CC: Martin (who sent the original DTs).

> > With that added:
> >  =20
> >> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com> =
=20
> >=20
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> >=20
> > There are some boards which have their base .dtsi in the arch/arm
> > directory, but we can tackle those separately. =20
>=20
> I missed them, if I add the property to sunxi-libretech-all-h3-cc.dtsi
> and sunxi-bananapi-m2-plus.dtsi, could tag you as a reviewer?

You can always CC: me, though I would spot it through the linux-sunxi list
anyway (I have a special eye on this one).

Anyway, if you feel like it, you can do the same exercise for the arch/arm
directory, though it's a bit more tricky there, since there are far more
and also older boards, some indeed with a full scale SD card slot.
Definitely make this a separate patch, maybe even split this up by SoC or
SoC groups. For instance I'd believe that any H3 boards would have microSD
only, courtesy of being "newer". Since those are the ones that share .dtsi
files with arch/arm64, that's probably a good target for one patch.

It looks like there is not a single wp-gpios property for any of those
boards. I wonder if disable-wp; is then correct regardless. If there are
boards with full scale SD slots *and* the WP pin connected, this could be
fixed later, on a case-by-case base. Compared to the current situation we
don't seem to lose anything.
And I just checked the BananaPi(-M1), with a full scale slot, and this one
doesn't connect the WP pin, so "disable-wp;" is definitely correct there
as well.

> There is also a module called Emlid Neutis, the compute module itself
> has not a slot, but the board that uses it does, unfortunately they are
> not separate files, so I do not see a clear solution here, as above.

Right, so similar to the Bigtreetech boards above, the split
between the SoM .dtsi and the board .dts files doesn't seem to be right,
but it affects more than just the SD card - namely UARTs, USB, audio
routing, etc.
So this would be a separate patch as well. I have a board with the N5
module at home, so happy to verify that.

Cheers,
Andre

> >  =20
> >> ---
> >> Sorry that my last messages were not in mailing list,
> >> one was wrongly sent and second was rejected, as the bot claimed it
> >> contained html. ---
> >> Changes in v2:
> >> - NEW: Added the property to all Sunxi arm64 boards, as discussed in
> >> mailing list
> >> - Link to v1:
> >> https://lore.kernel.org/r/20240914-b4-nanopineoplus2-fix-mmc0-wp-v1-1-=
12f54f0d6620@gmail.com
> >> --- arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts    |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts         |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts       |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts        |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts      |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts  |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts         |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts          |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi           |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts            |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi              |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi    |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts          |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts       |
> >> 1 + arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts |
> >> 1 + 16 files changed, 16 insertions(+)
> >>
> >> diff --git
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts index
> >> 526443bb736c..18fa541795a6 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts @@
> >> -136,6 +136,7 @@ &mmc0 { vmmc-supply =3D <&reg_vcc3v3>; bus-width =3D =
<4>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> >> +	disable-wp;
> >>   	status =3D "okay";
> >>   };
> >>  =20
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts index
> >> 05486cccee1c..128295f5a5d6 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts @@ -88,6
> >> +88,7 @@ ext_rgmii_phy: ethernet-phy@7 {
> >>   &mmc0 {
> >>   	vmmc-supply =3D <&reg_vcc3v3>;
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> >>   	status =3D "okay";
> >> diff --git
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts index
> >> 3a7ee44708a2..44fdc8b3f79d 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dts @@ -157,6
> >> +157,7 @@ eth_mac1: mac-address@fa { &mmc0 {
> >>   	vmmc-supply =3D <&reg_vcc3v3>;
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> >>   	status =3D "okay";
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts index
> >> ce3ae19e72db..0f29da7d51e6 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts @@ -153,6
> >> +153,7 @@ &ir {
> >>   &mmc0 {
> >>   	vmmc-supply =3D <&reg_vcc3v3>;
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> >>   	status =3D "okay";
> >> diff --git
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts index
> >> b699bb900e13..d4fc4e60e4e7 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts @@
> >> -153,6 +153,7 @@ &ir { &mmc0 {
> >>   	vmmc-supply =3D <&reg_vcc3v3>;
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> >>   	status =3D "okay";
> >> diff --git
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
> >> index ae85131aac9c..3322cc4d9aa4 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts @@
> >> -82,6 +82,7 @@ ext_rgmii_phy: ethernet-phy@1 { &mmc0 {
> >>   	vmmc-supply =3D <&reg_vcc3v3>;
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> >>   	status =3D "okay";
> >> diff --git
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
> >> index 734481e998b8..3eb986c354a9 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts @@
> >> -79,6 +79,7 @@ hdmi_out_con: endpoint { &mmc0 {
> >>   	vmmc-supply =3D <&reg_vcc3v3>;
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> >>   	status =3D "okay";
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts index
> >> 3be1e8c2fdb9..13a0e63afeaf 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts @@ -129,6
> >> +129,7 @@ ext_rgmii_phy: ethernet-phy@1 { &mmc0 {
> >>   	vmmc-supply =3D <&reg_cldo1>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	status =3D "okay";
> >>   };
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts index
> >> 6c3bfe3d09d9..ab87c3447cd7 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts @@ -131,6
> >> +131,7 @@ hdmi_out_con: endpoint { &mmc0 {
> >>   	vmmc-supply =3D <&reg_cldo1>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	status =3D "okay";
> >>   };
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi index
> >> 13b07141c334..d05dc5d6e6b9 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi @@ -94,6
> >> +94,7 @@ hdmi_out_con: endpoint { &mmc0 {
> >>   	vmmc-supply =3D <&reg_cldo1>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	status =3D "okay";
> >>   };
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts index
> >> c8b275552872..fa7a765ee828 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts @@ -133,6
> >> +133,7 @@ ext_rgmii_phy: ethernet-phy@1 { &mmc0 {
> >>   	vmmc-supply =3D <&reg_cldo1>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	status =3D "okay";
> >>   };
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi index
> >> 855b7d43bc50..bb7de37c0d58 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi @@ -124,6 +124,7
> >> @@ &mmc0 { pinctrl-0 =3D <&mmc0_pins>;
> >>   	vmmc-supply =3D <&reg_vcc3v3>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	status =3D "okay";
> >>   };
> >> diff --git
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi index
> >> fc7315b94406..a3fe39f8e2ca 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi @@
> >> -81,6 +81,7 @@ ext_rgmii_phy: ethernet-phy@1 { &mmc0 {
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	status =3D "okay";
> >>   };
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts index
> >> 26d25b5b59e0..dd3bd9cca710 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts @@ -52,6
> >> +52,7 @@ &ir { &mmc0 {
> >>   	vmmc-supply =3D <&reg_dcdce>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	status =3D "okay";
> >>   };
> >> diff --git
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts index
> >> 18b29c6b867f..16c68177ff69 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts @@ -111,6
> >> +111,7 @@ ext_rgmii_phy: ethernet-phy@1 { };
> >>   &mmc0 {
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_HIGH>;	/* PF6 */
> >>   	vmmc-supply =3D <&reg_vcc3v3>;
> >> diff --git
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts
> >> index d6631bfe629f..024377b333c1 100644 ---
> >> a/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts +++
> >> b/arch/arm64/boot/dts/allwinner/sun50i-h618-transpeed-8k618-t.dts @@
> >> -71,6 +71,7 @@ &ir { &mmc0 { vmmc-supply =3D <&reg_dldo1>;
> >>   	cd-gpios =3D <&pio 8 16 GPIO_ACTIVE_LOW>;	/* PI16 */
> >> +	disable-wp;
> >>   	bus-width =3D <4>;
> >>   	status =3D "okay";
> >>   };
> >>
> >> ---
> >> base-commit: 57f962b956f1d116cd64d5c406776c4975de549d
> >> change-id: 20240914-b4-nanopineoplus2-fix-mmc0-wp-9d77fb9e6513
> >>
> >> Best regards, =20
> >  =20
>=20


