Return-Path: <linux-kernel+bounces-186025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C548CBEEF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4014B1F22F36
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229A481AB7;
	Wed, 22 May 2024 10:05:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF7F7E572;
	Wed, 22 May 2024 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372319; cv=none; b=KvlyNail3DE+gZBPoilDXDNcTRRwysM4elzGP5fnghwgB9Kaj2xSnGU0jTbDTFhflhjuCbMyj28qYOqjHIEDbZmgLHBGGPkeARRqkp/seOQgv1HQyOuHBEI3aJg0D+8VIXfeI1dDa4TL5L8s/QLVBcNHLbCUy9ZgAsgbwYYEH68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372319; c=relaxed/simple;
	bh=uWk0LMa9b/L4O6C8T1qp//VpKe389OGPlpvKZgpDSIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KT3mpA7/UHhYxIBcdS4MbzvNS64Tpefa6R8T8QD/9gJvJl/ViHUgoN+ylx/JuFR13bgLD1z9d++X6k6m1rl/tnhTbGiofOMtk58vFE9a16yCztYn7KDA/MufjenHvIuPlLJmtkkZOnUYxwvYnoMYtkLfhJx0WTV2qzy/1T+R/Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27D8A339;
	Wed, 22 May 2024 03:05:37 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B1E13F641;
	Wed, 22 May 2024 03:05:11 -0700 (PDT)
Date: Wed, 22 May 2024 11:05:07 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Icenowy Zheng <uwu@icenowy.me>, linux-sunxi@lists.linux.dev,
 wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, didi.debian@cknow.org, Marek Kraus
 <gamiee@pine64.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Correct the descriptions
 for Pine64 boards
Message-ID: <20240522110507.51b12966@donnerap.manchester.arm.com>
In-Reply-To: <5635a6e79427e43ef20b690c766267d0@manjaro.org>
References: <d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org>
	<057b4a5504656bb7455ead39768d9e7167fb724b.camel@icenowy.me>
	<5635a6e79427e43ef20b690c766267d0@manjaro.org>
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

On Wed, 22 May 2024 08:10:21 +0200
Dragan Simic <dsimic@manjaro.org> wrote:

Hi,

> Hello Icenowy,
>=20
> On 2024-05-22 02:48, Icenowy Zheng wrote:
> > =E5=9C=A8 2024-04-23=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 03:00 +0200=EF=
=BC=8CDragan Simic=E5=86=99=E9=81=93=EF=BC=9A =20
> >> Correct the descriptions of a few Pine64 boards and devices,
> >> according
> >> to their official names used on the Pine64 wiki.=C2=A0 This ensures
> >> consistency
> >> between the officially used names and the names in the source code.
> >>=20
> >> Cc: Marek Kraus <gamiee@pine64.org>
> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >> ---
> >>=20
> >> Notes:
> >> =C2=A0=C2=A0=C2=A0 This completes the correction of the descriptions o=
f the Pine64
> >> boards
> >> =C2=A0=C2=A0=C2=A0 and devices, which was started with the Pine64 boar=
ds and devices
> >> based
> >> =C2=A0=C2=A0=C2=A0 on Rockchip SoCs. [1]
> >> =C2=A0=C2=A0=C2=A0
> >> =C2=A0=C2=A0=C2=A0 [1]
> >> https://lore.kernel.org/linux-rockchip/ec124dab2b1a8776aa39177ecce34ba=
bca3a50e2.1713832790.git.dsimic@manjaro.org/
> >>=20
> >> =C2=A0Documentation/devicetree/bindings/arm/sunxi.yaml | 12 ++++++----=
--
> >> =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml
> >> b/Documentation/devicetree/bindings/arm/sunxi.yaml
> >> index 09d835db6db5..b66873ae2d71 100644
> >> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> >> @@ -709,17 +709,17 @@ properties:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
sochip,s3
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
allwinner,sun8i-v3
> >> =C2=A0
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pine64 PineH64 model A
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pine64 H64 Model A
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
pine64,pine-h64
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
allwinner,sun50i-h6
> >> =C2=A0
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pine64 PineH64 model B
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pine64 H64 Model B =20
> >=20
> > Sorry for replying so late, but I don't think there is a Pine64 H64
> > board. The Pine64 wiki calls it Pine H64. [1]
> >=20
> > [1] https://wiki.pine64.org/wiki/PINE_H64 =20
>=20
> Good point, thanks.  Though, this board is really an exception to
> the naming scheme employed for the Pine64 boards, so perhaps it would
> actually be better to rename the board in the Pine64 wiki, by adding
> "64" to "Pine", to ensure consistency.

I am sorry, but I don't think this is how it works. The board is really
called "Pine H64", that's printed on the board [1] and everywhere else [2].
That's a choice the manufacturer made, and renaming some Wiki page won't
change that. I understand the engineer's desire to make everything nice and
consistent ;-) , but I am afraid that's not our call. After all this file
is to document the device naming, not to be an example of consistent
naming schemes.

Cheers,
Andre

[1] https://linux-sunxi.org/images/5/53/Pineh64_top.jpg
[2] https://pine64.org/devices/pine_h64_model_a/
>=20
> Alas, the Pine64 wiki is currently in read-only mode, due to some
> recent issues with the underlying hardware that runs it.  Migration to
> another form of documentation for Pine64 boards is also a possibility,
> which makes the updates even more complicated.
>=20
> With all this in mind, I think it would be the best to rename the board
> on the Pine64 side, to ensure consistency, and keep this patch as-is.
> I'll make a mental note to do that on the Pine64 side once the current
> situation with the Pine64 wiki is resolved.
>=20
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
pine64,pine-h64-model-b
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
allwinner,sun50i-h6
> >> =C2=A0
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pine64 LTS
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pine64 A64 LTS
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
pine64,pine64-lts
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
allwinner,sun50i-r18
> >> @@ -748,17 +748,17 @@ properties:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
pine64,pinephone
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
allwinner,sun50i-a64
> >> =C2=A0
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pine64 PineTab, Develop=
ment Sample
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pine64 PineTab Develope=
r Sample
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
pine64,pinetab
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
allwinner,sun50i-a64
> >> =C2=A0
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pine64 PineTab, Early A=
dopter's batch (and
> >> maybe later ones)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pine64 PineTab Early Ad=
opter
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
pine64,pinetab-early-adopter
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
allwinner,sun50i-a64
> >> =C2=A0
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pine64 SoPine Baseboard
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Pine64 SOPine
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
pine64,sopine-baseboard
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
pine64,sopine
> >>  =20
>=20


