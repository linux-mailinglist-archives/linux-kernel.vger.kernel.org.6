Return-Path: <linux-kernel+bounces-328389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 790EA9782C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217A71F21FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F921C695;
	Fri, 13 Sep 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="iyWXDOK5"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863F1CD25;
	Fri, 13 Sep 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238306; cv=pass; b=r+l/J/80R4rcLDEmJpIqN8k/WbeM9egu85xSiYNAi0FM14aUyHZutm2H+7DmP/P5Xe0xb69nJ4ptvDH/bv4Dptr0xDpD+EpsJfy908tESt3BPBhLUX1/iNF33jJZOiE8NcsOxaE8EVzswreOYbBDXzzD30p3MYQdQ/jRMmuKZJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238306; c=relaxed/simple;
	bh=TQ+lbt0dZZtqQ5zTM2574sDLvRMXMnydP2f0zeU1DQE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HSGAumKUU/dDaIRd9mmGXFzudkh6pg+8ZR+/jcSfJ2BWziN2XFFa0KR1A2fxdDvUkflZfTGp21cHt24qv3Na9flHp7eEajqP89aBv7QWC0I6uJvy/HYrajyBLru40516szfesXNuMcfLN+JyXv1HFeDcd+8ogdb7HAURGNtJHww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=iyWXDOK5; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1726238289; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gXu3gAfwiRGposmVsMnz2XW5UaQh+RLJNo9h5cVmHzG5ORAS2iq0RvxgiVKazS/6zD2e0LfTb3L1OaozMM1kdDcL0DagbsCr9st7ZDVMcJDkdRm8F/9fhdFMfm1XjH9m1qlDhhZowVMJ8QKbhgMOKlV59Zz2otqnEjoLmXX6dsk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726238289; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TQ+lbt0dZZtqQ5zTM2574sDLvRMXMnydP2f0zeU1DQE=; 
	b=lCOEijue5iatK7sVloaZCJa/stf3zi24RgDYEE3V7JelQYY+iiwQqzwPI1YtNtTI/19GYoRHKLNGeNu8lVj9/xSZnF9whdmxzD0s23dkPcZ0OC2+KDh15YmeOUwe0UJpLb+w0XrQao5KmdSx9xpCSkffD1azWPM+F731IH17gMo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726238289;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=TQ+lbt0dZZtqQ5zTM2574sDLvRMXMnydP2f0zeU1DQE=;
	b=iyWXDOK5grUAwZYse5UDcVQJfUJF7vp3lFuhTq3v9Mqx0drnTUpW071MlAmlygyI
	KZBHcPLqzbr71NiURyVvzNBFzB9BFpKnyct4QKSFqyXhuVJF1T9uppOVJksj9VbVYW2
	TKHp/6ng6f7h5NO0Kl/AauhkNs8jnkEJHs0whcN78JvRnbkTsY3vxM0PH0wS65+sosI
	MgbJh+soeWzBMGaPng60AduRpT5qdDYtLo7s9KqcsvmTs5psFcUWiR8LMwQmGBbf+/i
	eojkxiKmgoqeV94a2iz3imk6RBVabWP7Sl1DcfmRIHPYZg44bkNbwWitrmpu2JXJYce
	W4OHNoWroQ==
Received: by mx.zohomail.com with SMTPS id 1726238287800904.5970497017767;
	Fri, 13 Sep 2024 07:38:07 -0700 (PDT)
Message-ID: <055eebbba3b1caae1b907ab553d4bc24ebef7eaf.camel@icenowy.me>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: document RerVision
 A33-Vstar board
From: Icenowy Zheng <uwu@icenowy.me>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Date: Fri, 13 Sep 2024 22:37:57 +0800
In-Reply-To: <172623730520.4076253.7175037716930825765.robh@kernel.org>
References: <20240913104845.4112986-1-uwu@icenowy.me>
	 <172623730520.4076253.7175037716930825765.robh@kernel.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2024-09-13=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 09:24 -0500=EF=BC=
=8CRob Herring (Arm)=E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, 13 Sep 2024 18:48:44 +0800, Icenowy Zheng wrote:
> > RerVision A33-Vstar is an evaluation board of their A33-Core1 SoM.
> >=20
> > Add its compatible (with the SoM compatible) to the sunxi board DT
> > binding file.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > =C2=A0Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in
> this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the
> warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to
> reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
> =C2=A0 pip3 install dtschema --upgrade
>=20
>=20
> New warnings running 'make CHECK_DTBS=3Dy allwinner/sun8i-a33-
> vstar.dtb' for 20240913104845.4112986-1-uwu@icenowy.me:
>=20
> arch/arm/boot/dts/allwinner/sun8i-a33-vstar.dtb: hub@1: '#address-
> cells', '#size-cells', 'ethernet@4' do not match any of the regexes:
> 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> http://devicetree.org/schemas/usb/genesys,gl850g.yaml#

Oops the GL850G DT binding should be updated to allow downstream
devices.

>=20
>=20
>=20
>=20
>=20
>=20


