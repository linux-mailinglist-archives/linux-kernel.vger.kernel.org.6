Return-Path: <linux-kernel+bounces-329051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D46EA978C80
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 03:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73FEFB2253A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1939BE5D;
	Sat, 14 Sep 2024 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="JJNmq9jL"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4488C1A;
	Sat, 14 Sep 2024 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726278987; cv=pass; b=cJEsN0l54y95wMAj5yM3OxuIp3wPu698Q0qoXNLdKgAZhCn/3GUHXIYDqO/3dGByb0VlcwiZrHA/dYx13bX4mmRwyTKO0HlvY4Ik8GXTyML2TKRW6EsZ86cK20iIZcXrTZYEi1rqmtYrjRYEgc65SwPR/xGoynQOZZ0huEwK+Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726278987; c=relaxed/simple;
	bh=ayBCYZquB2nxVKX6mp0OElWmvLIk/UXOyDEVCYprcsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O55ffQne+VGIuVCfvn2Yc2IvYi20I2jrOtM0rE1mm9ITT0KIJYnukdvd/meVQ1XE4MVVsrrrSkNBr72wn7ncKh0LR6TcuQ4EJqmrV05c3aJBXnoB3eIDZN8idLa4+mCPZR3yGkYH9UXA0NQ5zv4CzJP8dfHUH4Nh1DO1Q6Twrm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=JJNmq9jL; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1726278962; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RzJyEf15GliLrSVJ/uyX7penK2QMkryN+d4RXb6QJ+6ncXwSJGTy/7GOWV1ckmLDatEPFQzhxrIyognx/6uMMvLQFhIwNZf4YwweT2y940uaqn3k6jEUFiZ5MuZJ5WnbPHKR0BEWlOfzx7kwNigV3wCFNuUj1p+HDtSL5hWZzWk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726278962; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NXQ26KT6Pv90YwCJ3APT9lq+9hwmObUaP8zl7IDRZwQ=; 
	b=YUuDxBcrCMqE7sf81QwLdoaT0JqQi+gxSRajQgUF5A7iIGvIJhjxVXj+fjoXfC24qjPSNJTCNjv13yZdQiPT+duK25CsK5hye+wuhUZHlDyiwHfC/FNYKVeYcIcqO128AUeov4IRRdz59c+ht5oFWRiJn2NL7G/pVchcVHPpaTQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726278962;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=NXQ26KT6Pv90YwCJ3APT9lq+9hwmObUaP8zl7IDRZwQ=;
	b=JJNmq9jLLHCaqwfhUXkVQTdtdGm8q9fe+oLihCQoK9+cANoPVN4caaGg+8aEw0gm
	oCvW1te5P8I5iiwm722yBp/HW0m3VVe7hORwALOo+jD5hHi8jY2191pO/o0OPUPurss
	mPRawi+IxSq/0UlgezWaITrvHz6YFwbjZCfrfiMsOGNg3AgPF2tWZ9Ui1eQW6b0k0fb
	RVZ9ZYmJ72w6BQyBxJm+KLuduHvhw3yrif11BKHLOBHtJBdfsMoKl3cXKIPpIGhRjqo
	LCyoVofFN7JlrR9uYYcAAus6RZObpHkaLp7xC79RQq4te1RwXC0hHLdRtMKYaWbJwjm
	fGtv6NXA3g==
Received: by mx.zohomail.com with SMTPS id 1726278961359640.2990860982334;
	Fri, 13 Sep 2024 18:56:01 -0700 (PDT)
Message-ID: <ad869e684c940435ba3fcf4dbccbfc770b38c16b.camel@icenowy.me>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: document RerVision
 A33-Vstar board
From: Icenowy Zheng <uwu@icenowy.me>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Date: Sat, 14 Sep 2024 09:55:55 +0800
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

I think I need help to properly reference usb-device.yaml to allow
cells properties. Currently it's in a allOf: section of
genesys,gl850g.yaml along with Genesys-specific per-compatible rules
(USB2/USB3 hubs), but it looks that this fails to work.

I copied the patternProperties rule from usb-hcd.yaml to allow
downstream devices,  this works well.

BTW should a usb-hub.yaml be present to allow different hub bindings to
share the code for downstream devices?

>=20
>=20
>=20
>=20
>=20


