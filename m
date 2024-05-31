Return-Path: <linux-kernel+bounces-196839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C878D6268
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAD21F21527
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64B9158A18;
	Fri, 31 May 2024 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Bx1EeHyQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lxByJNjO"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD715886A;
	Fri, 31 May 2024 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160956; cv=none; b=Uw2GRyVomw+GFHZGrst6s9J0TmVMTABA7JtA07VN/v+KJMs/VvuZ59SdI0WUPYXXzJfHPVAxuFPKwJQtLzpKWyENZ4fzzZXSPMBBCaGlP0YBDBlb27zpeEoyzbAlkZXx6xrs9kmp2zRkSV5VM3JrHzB1MavUIPLVhvc9hK4H5os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160956; c=relaxed/simple;
	bh=mgmSvDEDUnSXOohlZU0FzjtDlp32E9UwOhItrFUXEAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpgVhGVHHg0Z3VSM5AXVxQFX8qRc21FatsQWak6vPckd8XfNKw9ikl6tu1tRfUveMyUZTwKnYMeFTvsXI96umjOIoN4DeARgNuWSKtCnnhExi63HAAf6xDPzRFQOQ54o9j9/Z0M1Zn0NzkBBkTpOp0foE5sxIOvZfICwtxZQ+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Bx1EeHyQ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=lxByJNjO reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1717160953; x=1748696953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cqnIZ10/tMnH14SGwTodwVLTAqEG93IVacBI//NGqKA=;
  b=Bx1EeHyQDVnXrzZAkETD6DcjZby4ucrtGh8iDQwtqDiYjyPS2jbkQH5M
   gYY17GJvSOH1HQ/XEJot24LG9+0kMWiU0n79UMo7Zsp+zcpDhU5xEFvEr
   eeoOfWuwdFNMA0BBnrFy3bhmansusEG7FoVxJIX2QmKEuyFo78z3vU5qA
   aGCuNQ/VuX2kiFiCiC12DDNNPPdoXMBbVuvEQvXtOWNGjTBKsxnu3nlKP
   b95mmGmUdWl9K16OoXdaHpXM3GGQIwJR1umO7ZEATKMf4XZ2CeYRSPg0M
   Z4SPB22jQolsiywGoEBZQuvi1/7wjID+5c02ybgNka3J7fp1j22eePePr
   w==;
X-CSE-ConnectionGUID: piIEhqDwS3G7ocBCBuNPGg==
X-CSE-MsgGUID: /gIAaVxNR4+q09c5pb8i+g==
X-IronPort-AV: E=Sophos;i="6.08,204,1712613600"; 
   d="scan'208";a="37161436"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 31 May 2024 15:09:10 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 635101616BC;
	Fri, 31 May 2024 15:09:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1717160946;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cqnIZ10/tMnH14SGwTodwVLTAqEG93IVacBI//NGqKA=;
	b=lxByJNjO/QtCEsNdHyiqxj0fDzf7LmTiSAOwv0ZR6WLmbtT5aqEWwnWtaf1kIVISrUh2tS
	amIhQRmuC41kftsSyNKkfIu6tRQrcoYjFUndRuE805+LJI+u8iEndjTIE9b/zw3s7+Fv8M
	BwtsZi2lKx3R5yjT3fmS42hLLeJxoD4WDypWrTACgaG4oARBwMsj9Bk1gsDeqYvvbXbI08
	PcWwpaEpnV3j+/Z3OUNR4pXkh6JWGckE4C+f83KW0LEf2uy7n/vQR0/ppiuNSb25sCn+f1
	Y/PDTIJh4R7WrbQ3sqdU+OLSyz3bGZgoFSmz7CHFatmwU92ygWu4DlXrOLUrhg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ls1021a: add QUICC Engine node
Date: Fri, 31 May 2024 15:09:05 +0200
Message-ID: <5987259.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <87frtynpfx.fsf@geanix.com>
References: <20240530-arm-ls1021a-qe-dts-v1-1-2eda23bdf8c5@geanix.com> <3380831.44csPzL39Z@steina-w> <87frtynpfx.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Esben,

Am Freitag, 31. Mai 2024, 14:20:02 CEST schrieb Esben Haabendal:
> Alexander Stein <alexander.stein@ew.tq-group.com> writes:
>=20
> > Would you consider current converting into YAML format?
>=20
> You mean converting Documentation/devicetree/bindings/soc/fsl/qe.txt and
> Documentation/devicetree/bindings/soc/fsl/qe/*.txt into YAML?
>=20
> I can consider that. I haven't done something like that before, but I
> assume it might include some additional work other than trivially format
> conversion. So I would prefer to do that after this patch, if that is
> ok.

Getting the constraints right is probably not that easy. But having
verifiable bindinds helps getting the .dtsi right.

> > Am Donnerstag, 30. Mai 2024, 16:22:54 CEST schrieb Esben Haabendal:
> >> The LS1021A contains a QUICC Engine Block, so add a node to device
> >> tree describing that.
> >>=20
> >> Signed-off-by: Esben Haabendal <esben@geanix.com>
> >> ---
> >>  arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 51 ++++++++++++++++++++++++++=
+++++++++
> >>  1 file changed, 51 insertions(+)
> >>=20
> >> diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts=
/nxp/ls/ls1021a.dtsi
> >> index e86998ca77d6..ff7be69acdd5 100644
> >> --- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
> >> +++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
> >> @@ -460,6 +460,57 @@ gpio3: gpio@2330000 {
> >>  			#interrupt-cells =3D <2>;
> >>  		};
> >> =20
> >> +		uqe: uqe@2400000 {
> >> +			#address-cells =3D <1>;
> >> +			#size-cells =3D <1>;
> >> +			device_type =3D "qe";
> >> +			compatible =3D "fsl,qe", "simple-bus";
> >> +			ranges =3D <0x0 0x0 0x2400000 0x40000>;
> >> +			reg =3D <0x0 0x2400000 0x0 0x480>;
> >
> > Properties please in this order:
> > * compatible
> > * reg
> > * #address-cells
> > * #size-cells
> > * ranges
> > * device_type
>=20
> Fixing.
>=20
> >> +			brg-frequency =3D <150000000>;
> >> +			bus-frequency =3D <300000000>;
> >
> > Mh, aren't these values depending on your actual RCW configuration?
>=20
> Yes, you are right. The QE bus-frequency comes from platform_clk which
> is controlled by various bits in RCW and sys_ref_clk.
>=20
> So I guess it should be possible to derive bus-frequency from sysclk
> clock-frequency attribute and RCW. But fsl,qe bus-frequency is a
> required property...
>=20
> Max bus-frequency for LS1021A is 300 MHz. But it should be possible to
> set it lower, although I suspect that many/most/everyone is running it
> at 300 MHz.

Thanks for confirmation. I'll let DT maintainer decide how to deal with thi=
s.

> >> +			fsl,qe-num-riscs =3D <1>;
> >> +			fsl,qe-num-snums =3D <28>;
> >
> > Current bindings defines:
> >> fsl,qe-snums: This property has to be specified as '/bits/ 8' value,
> >>   defining the array of serial number (SNUM) values for the virtual
> >>   threads.
> >
> > So '/bits/ 8' is missing.
>=20
> Ok, so you want me to add an array for fs,qe-snums attribute?
> None of the existing fsl,qe devices has a fsl,qe-snums.
> And qe_snums_init() has a fallback, so I don't think it is correct to
> specify fsl,qe-snums to be a required property in the bindings. It
> should be listed as optional.

fsl,qe-num-snums is a deprecated property, so IMHO the replacement
fsl,qe-snums should be used instead for new device tree entries.
qe_snums_init() supporting 'fsl,qe-num-snums' is just to support
"legacy bindings" as stated in the comment.

>=20
> >> +			qeic: qeic@80 {
> >> +				compatible =3D "fsl,qe-ic";
> >> +				reg =3D <0x80 0x80>;
> >> +				#address-cells =3D <0>;
> >> +				interrupt-controller;
> >> +				#interrupt-cells =3D <1>;
> >> +				interrupts =3D <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
> >> +					      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> >> +			};
> >> +
> >> +			ucc@2000 {
> >> +				cell-index =3D <1>;
> >> +				reg =3D <0x2000 0x200>;
> >> +				interrupts =3D <32>;
> >> +				interrupt-parent =3D <&qeic>;
> >
> > Move cell-index to last position.
>=20
> Done.
>=20
> >> +			};
> >> +
> >> +			ucc@2200 {
> >> +				cell-index =3D <3>;
> >> +				reg =3D <0x2200 0x200>;
> >> +				interrupts =3D <34>;
> >> +				interrupt-parent =3D <&qeic>;
> >
> > Same here.
>=20
> Done.
>=20
> >> +			};
> >> +
> >> +			muram@10000 {
> >> +				#address-cells =3D <1>;
> >> +				#size-cells =3D <1>;
> >> +				compatible =3D "fsl,qe-muram", "fsl,cpm-muram";
> >> +				ranges =3D <0x0 0x10000 0x6000>;
> >
> > Node address but no 'reg' property? I have no idea if this is okay.
> > Also compatible (and possibly reg) first.
>=20
> It is done in the same way for all existing fsl,qe-muram devices. So if
> it is not okay, a tree-wide fixup would be in place.

I can't finally say if this is okay, but at least the compatible shall be
listed first.

Thanks and best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



