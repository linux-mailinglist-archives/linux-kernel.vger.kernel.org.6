Return-Path: <linux-kernel+bounces-559225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A44A5F10F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C61D3BA61C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BFD265CB7;
	Thu, 13 Mar 2025 10:40:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6905D1FBC87;
	Thu, 13 Mar 2025 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862452; cv=none; b=J7K/B41EugYbVb5U8WeG12uGzYQdMSGXEyKIMc9MqcyfaaenLiN1rUyM82TBt6lGIQvKTpUD3+aSKpXYo5g9hzopTzRhhkNSZ+TdziY3cRdwxenwQaKswAMZSR4KqpAPW7KYxeoYOF8QMvjzoRATCh6h5++yvwyumBXkRXOIyac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862452; c=relaxed/simple;
	bh=4o3UedLCe/DgFbR3RKmsogTND36AT5FRXO4VwEfXLRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewCmdmxZCUGcqAtYM8DZXvK1ejTF7UZ072vB66Gwa/8us9GtY1wqDeYmgZyMOLqTyW/h1OA/bcH1yugt81e/waHpKkdcYkU2hMKYiCkqAs0u3lD5NQZKWKX2ziH8cREt1eut7YI2q+Tzy+JI406rpOO6sSrs4FaaXggLT8txoJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0763C12FC;
	Thu, 13 Mar 2025 03:40:59 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D83F23F694;
	Thu, 13 Mar 2025 03:40:46 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:40:42 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Michael Klein <michael@fossekall.de>
Cc: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Samuel Holland
 <samuel@sholland.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: bananapi: add support for PHY LEDs
Message-ID: <20250313104042.694c1856@donnerap.manchester.arm.com>
In-Reply-To: <Z9KYqlfUYxRaWnGQ@a98shuttle.de>
References: <20250312193629.85417-1-michael@fossekall.de>
	<20250312193629.85417-2-michael@fossekall.de>
	<4637912.LvFx2qVVIh@jernej-laptop>
	<Z9KYqlfUYxRaWnGQ@a98shuttle.de>
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

On Thu, 13 Mar 2025 09:34:50 +0100
Michael Klein <michael@fossekall.de> wrote:

Hi,

> On Thu, Mar 13, 2025 at 07:07:24AM +0100, Jernej =C5=A0krabec wrote:
> >Dne sreda, 12. marec 2025 ob 20:36:28 Srednjeevropski standardni =C4=8Da=
s je Michael Klein napisal(a): =20
> >> The Bananapi M1 has three LEDs connected to the RTL8211E ethernet PHY.
> >> Add the corresponding nodes to the device tree.
> >>
> >> Signed-off-by: Michael Klein <michael@fossekall.de> =20
> >
> >This is patch 2/2. Which one is patch 1/2? I got only one. =20
>=20
> https://patchwork.kernel.org/project/netdevbpf/patch/20250312193629.85417=
-1-michael@fossekall.de/
>=20
> Sorry for any inconvenience in case I messed up the patch submission.
>=20
> I made two commits for this change and submitted them via `git send-email=
=20
> HEAD^^`. The first patch went to netdev@vger.kernel.org, the second=20
> to linux-arm-kernel@lists.infradead.org, which seems logical. Have I=20
> done something wrong?

Well, for those really small "series" it's probably better to send all
patches to everyone, especially if the first patch gives some context,
without which the second leaves people (like me) scratching their head.
Also in this case a cover letter would help
(git format-patch --cover-letter), to give some idea of what you are after.

Cheers,
Andre


>=20
> >Best regards,
> >Jernej =20
>=20
> Michael
>=20
> > =20
> >> ---
> >>  .../boot/dts/allwinner/sun7i-a20-bananapi.dts | 27 +++++++++++++++++++
> >>  1 file changed, 27 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts b/arch=
/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts
> >> index 46ecf9db2324..4976453ed192 100644
> >> --- a/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts
> >> +++ b/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts
> >> @@ -48,6 +48,7 @@
> >>
> >>  #include <dt-bindings/gpio/gpio.h>
> >>  #include <dt-bindings/interrupt-controller/irq.h>
> >> +#include <dt-bindings/leds/common.h>
> >>
> >>  / {
> >>  	model =3D "LeMaker Banana Pi";
> >> @@ -169,6 +170,32 @@ &ir0 {
> >>  &gmac_mdio {
> >>  	phy1: ethernet-phy@1 {
> >>  		reg =3D <1>;
> >> +
> >> +		leds {
> >> +			#address-cells =3D <1>;
> >> +			#size-cells =3D <0>;
> >> +
> >> +			led@0 {
> >> +				reg =3D <0>;
> >> +				color =3D <LED_COLOR_ID_GREEN>;
> >> +				default-state =3D "keep";
> >> +				linux,default-trigger =3D "netdev";
> >> +			};
> >> +
> >> +			led@1 {
> >> +				reg =3D <1>;
> >> +				color =3D <LED_COLOR_ID_AMBER>;
> >> +				default-state =3D "keep";
> >> +				linux,default-trigger =3D "netdev";
> >> +			};
> >> +
> >> +			led@2 {
> >> +				reg =3D <2>;
> >> +				color =3D <LED_COLOR_ID_BLUE>;
> >> +				default-state =3D "keep";
> >> +				linux,default-trigger =3D "netdev";
> >> +			};
> >> +		};
> >>  	};
> >>  };
> >>
> >> =20
> >
> >
> >
> >
> > =20
>=20


