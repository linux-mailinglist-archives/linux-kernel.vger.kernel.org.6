Return-Path: <linux-kernel+bounces-325795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB92F975E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD5228284C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F7611712;
	Thu, 12 Sep 2024 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="UgDTvYii"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE3015C3;
	Thu, 12 Sep 2024 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102849; cv=none; b=iy4SsZVjSu9BffJG6o6RSY0K6fiwaRMdaoW8Q02Z9XGoVVGtglY/l14ABwZDO+2L5cCMgCK6HC5N1N9HC43mG9vq0ZfyqKT/56mjnHkscvf9XiqPtsdq9mJZlsvkP9kMmvqOsc5p0xzKD5l/oQqQitLVC8soG0mKXKw6QWkTRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102849; c=relaxed/simple;
	bh=LTVCW/TUO91aqFZtxT8rnStLjRXD7FVxAuDObdr0C0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e9Jjg/hDSXHaj5L2Fwgo5J3kpRD9YVtet4xE8o9AM4UdytQRErZmGVTYwmN4YgMzHWVC/G8CChfbjOAlXUyG4doHnOCCekiFOKlj2BTTbgGP9ekNpDjyP0vwXK6dtD1NPCKcwSSnScIL6aGemxII/RnZOa1jJzu5iZJDEkYNYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=UgDTvYii; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726102845;
	bh=GNjZ85orHNFiT2iD9bmLshHf/vQPcwQdQ803KguC+x0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UgDTvYiiiAUto4p3EkRZMy61b83Dvibk+E2PmV3N2CigzezLx1Fz3sYCBXtmqXSNn
	 1zHiK68BlJ9nB6QJAgtyzHS/COKy3i6A2vpNpfjnuJRBPHdJSOxGrti6Thjaocf82m
	 ubI9epK0MvBLymOdQDmTaxpU7KtzoHp7o/kef74CARNhpwcSjovFaElV09GH75C+Xv
	 B+DyKxxIVYwq7uI21sIkfd5aqlnp4E0ZNPbqAMStHCd0nTe+7224+liizl8SsgNiS1
	 2fUttIp7ffwHVEgRJ/Y+qgdTLm0i1+QUvo+TOnly4e3dutdvvNYxRFUiba1vFLac3l
	 VGyvojW7DfwuA==
Received: from [192.168.68.112] (ppp118-210-89-8.adl-adc-lon-bras32.tpg.internode.on.net [118.210.89.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9BE28650AD;
	Thu, 12 Sep 2024 09:00:44 +0800 (AWST)
Message-ID: <4ad15ead271edd36d4638068cdf63b124a78b437.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Add power module and
 ADC on Medusa Board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, Ricky CX Wu
	 <ricky.cx.wu.wiwynn@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, linux-aspeed@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, patrick@stwcx.xyz, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Joel Stanley
 <joel@jms.id.au>
Date: Thu, 12 Sep 2024 10:30:44 +0930
In-Reply-To: <172597760852.3917242.15739474117640537130.robh@kernel.org>
References: <20240910075357.3531211-1-Delphine_CC_Chiu@wiwynn.com>
	 <172597760852.3917242.15739474117640537130.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ricky,

On Tue, 2024-09-10 at 09:15 -0500, Rob Herring (Arm) wrote:
> On Tue, 10 Sep 2024 15:53:56 +0800, Delphine CC Chiu wrote:
> > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> >=20
> > Add RTQ6056 as 2nd source ADC sensor on Medusa Board.
> > Add power sensors on Medusa board:
> > - Add XDP710 as 2nd source HSC to monitor P48V PSU power.
> > - Add MP5023 as P12V efuse (Driver exists but un-documented).
> > - Add PMBUS sensors as P12V Delta Module.
> >=20
> > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > ---
> >  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 45 ++++++++++++++++++-
> >  1 file changed, 43 insertions(+), 2 deletions(-)
> >=20
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
>   pip3 install dtschema --upgrade
>=20
>=20
> New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-yose=
mite4.dtb' for 20240910075357.3531211-1-Delphine_CC_Chiu@wiwynn.com:
>=20
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@=
1e78a000/i2c@600/power-sensor@40: failed to match any schema with compatibl=
e: ['mps,mp5023']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@=
1e78a000/i2c@600/power-sensor@62: failed to match any schema with compatibl=
e: ['pmbus']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@=
1e78a000/i2c@600/power-sensor@64: failed to match any schema with compatibl=
e: ['pmbus']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@=
1e78a000/i2c@600/power-sensor@65: failed to match any schema with compatibl=
e: ['pmbus']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: /ahb/apb/bus@=
1e78a000/i2c@600/power-sensor@68: failed to match any schema with compatibl=
e: ['pmbus']

Can you please either:

1. Drop these nodes so we're not adding more warnings, or
2. Write the appropriate bindings and send them in a v2?

Andrew

