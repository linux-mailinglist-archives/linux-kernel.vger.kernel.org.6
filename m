Return-Path: <linux-kernel+bounces-266739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E6C94061C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033A51C21906
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B326156887;
	Tue, 30 Jul 2024 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="GOKo00CW"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1401474BC;
	Tue, 30 Jul 2024 03:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722311799; cv=none; b=Ogduim7GhhVdgFKljSJbhcPCxzi1D92pZJxJvyYCf77LZoiMgDe8bqlKb7sDplHUsZPHRMd1JR6H5o1LW7aXNP7wS4OIsosm6UkXtuMUdvjdzF3YWNxClVqSMUC/QhoZ/u7UPvsllHepcdYWa2ZSKp+tISp7NCrUDKTs170Ht0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722311799; c=relaxed/simple;
	bh=2uGIxog9NdeojwZ6uUCFl0uUwO8rbODnB4sHB/OAJro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cKsymn11JldqpArqSIkeFF2GRPtk2paG1Q8DwTBhX+NIeNPwq+XWgnGrRWUoEZmQ0vIqWJf4VkYQ+OqXnkoLq59ruA5Rw4ltasiyGmNgsek8tOAUPGt7A9sBp/W4WkSsCZkynlhDOBjt8VOMNywPcqcTO937kTx5VrOou9glnz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=GOKo00CW; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722311787;
	bh=MS3klEd7ZevntHEIeQtcKtN+G0dUXIcDk100cqPHI1Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GOKo00CWVXVHiPBmdkyKdzHKroWlZdp73d+ebOWjKyINjoBN2Vhmw4TMLP0oGzuz6
	 tAPZKohwTr5JtCqIKJDxWM0PGLFjpltsVozRKnO9EWu2FdbAKWaU6NUuxvQo02RfAP
	 vYA1O6nP8gtv9E0wtYt8gpo9g3g1MUiciDKLKVfSXxqiKYVsa5tBllZTYTDMSDHJBD
	 j2dgbZri8BtnQkonvSqbTmCSiZnpgXU8Nh7Lf2YieLV6MmiTCA0y6moVdXiD/ESQPh
	 ZS+a/AtKywnn5s6LZxEArI0RZpXlQ6OL3BVJQEFdGBBcAd2mfvR1Amwj5HS5sJlkUf
	 +bJVoTTtgEcLw==
Received: from [192.168.68.112] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6F32266B02;
	Tue, 30 Jul 2024 11:56:24 +0800 (AWST)
Message-ID: <cf5f5efb49ef6230ba5084e53316a8fb8ddedef1.camel@codeconstruct.com.au>
Subject: Re: [PATCH v11 25/27] ARM: dts: aspeed: yosemite4: add RTQ6056
 support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Patrick Williams <patrick@stwcx.xyz>, Delphine CC Chiu
	 <Delphine_CC_Chiu@wiwynn.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Tue, 30 Jul 2024 13:26:21 +0930
In-Reply-To: <ZqgRq4h0HWClxSEW@heinlein.vulture-banana.ts.net>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240723092310.3565410-26-Delphine_CC_Chiu@wiwynn.com>
	 <ZqgRq4h0HWClxSEW@heinlein.vulture-banana.ts.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-29 at 17:03 -0500, Patrick Williams wrote:
> On Tue, Jul 23, 2024 at 05:23:06PM +0800, Delphine CC Chiu wrote:
> > Add RTQ6056 (spider board 3rd source) support in yosemite4 DTS.
> >=20
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > ---
> >  .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts=
 b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > index f73719b3c2f1..03a1e41312e3 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> > @@ -1240,35 +1240,35 @@ adc@37 {
> >  	};
> > =20
> >  	power-sensor@40 {
> > -		compatible =3D "ti,ina233";
> > +		compatible =3D "ti,ina233", "richtek,rtq6056";
>=20
> Is this legal to have two chips both listed as compatible?  I thought
> this approach has been rejected before.

It depends on the circumstances. Does one have a superset of the
functionality of the other?

https://github.com/devicetree-org/devicetree-specification/blob/main/source=
/chapter2-devicetree-basics.rst#compatible

Andrew

