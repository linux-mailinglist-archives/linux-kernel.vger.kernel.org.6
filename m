Return-Path: <linux-kernel+bounces-249448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94A992EBD9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74206283E51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0AF16C68D;
	Thu, 11 Jul 2024 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tedqk7W4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE56171BA;
	Thu, 11 Jul 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712464; cv=none; b=dGNajr5dayZjNeLvEOMpVU0imwzULuss4RfYSezO3xPEWXVFwvZvMq3pn5D9NTptM6HWPFMMC6SQRRrNVS7a3UCY0hX7zqE8Pz5Ke23CEHYnqRu1BHMT1vwnYe6smSNRn+Ev1qgEKlaXAg9tpmxJTKeLl4LAKV0+4cRoCkcu688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712464; c=relaxed/simple;
	bh=MvnTZvYlvAJG+4eJfd/4pU9PjPA3LpeEu0NyvpIktlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=relxDaiMEVSqWBp2v9MzkRqya3BGIc1MO2PlVv/rc4dasCfvM73XdnlJt4JNMwGtiiJXMMyaBWHa26jTsca5E3YNIO0ZktpHBr5Jw004w+0TCA2x0nT6xWRgrMSIMsqpfxGoEqw7flaQbMKOSBmF3sD+a0NEi9eyRNe7oXMPVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tedqk7W4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65ACC116B1;
	Thu, 11 Jul 2024 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720712463;
	bh=MvnTZvYlvAJG+4eJfd/4pU9PjPA3LpeEu0NyvpIktlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tedqk7W41opP+LCc6/iGXIb8iBb6poMiWyRHQfNmGHiDC5JE6sE4R+hFX0Inzlav9
	 FPmAbdCJ3zDU9xDuZtvObcQj55D/8ZXkNi92bc7wpDuNvMf8ak/hVsc1aOBky+vKrD
	 dErKdJnFzdWoKJQzO829pV5WH/FxBIOR3HugSSHjlXW6+T0RXiJwV+sWXNwPR25ON/
	 Q+yiIxe23SD/zVZB6vuLiGSvQwyTJJRKwWafsfoFAfyR1T1g1DKmYsVhHsxIQAYIW2
	 IzeS/01teXFWubsoK203q2Uhv5qwSECzrIkVcFgEJcshVlwMe7Fa2lR2aspPTBsmr9
	 kT9MlQc36cwWQ==
Date: Thu, 11 Jul 2024 16:40:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Varshini.Rajendran@microchip.com, tglx@linutronix.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	Dharma.B@microchip.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	maz@kernel.org
Subject: Re: [PATCH v5 15/27] dt-bindings: interrupt-controller: Document the
 property microchip,nr-irqs
Message-ID: <20240711-molasses-shut-1fc7d9fe6a0e@spud>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102814.196063-1-varshini.rajendran@microchip.com>
 <20240703-dentist-wired-bdb063522ef7@spud>
 <a41274c3-fd32-4eba-8240-bf95e41f63d9@microchip.com>
 <82ca4f3d-fa78-4617-823e-69f16a2c3319@microchip.com>
 <a5b78d97-c646-4915-8d6c-65f134ae08eb@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nDBBa4rtrpxCXD0u"
Content-Disposition: inline
In-Reply-To: <a5b78d97-c646-4915-8d6c-65f134ae08eb@microchip.com>


--nDBBa4rtrpxCXD0u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 02:42:01PM +0200, Nicolas Ferre wrote:
> Answering to myself (again) and to Conor...
>=20
> On 09/07/2024 at 16:06, Nicolas.Ferre@microchip.com wrote:
> > On 09/07/2024 at 08:13, Varshini Rajendran - I67070 wrote:
> > > On 03/07/24 9:11 pm, Conor Dooley wrote:
> > > > On Wed, Jul 03, 2024 at 03:58:14PM +0530, Varshini Rajendran wrote:
> > > > > Add the description and conditions to the device tree documentati=
on
> > > > > for the property microchip,nr-irqs.
> > > > >=20
> > > > > Signed-off-by: Varshini Rajendran<varshini.rajendran@microchip.co=
m>
> > > > This needs to be part of patch 14.
> > > >=20
> > > > > ---
> > > > >     .../bindings/interrupt-controller/atmel,aic.yaml     | 12 +++=
+++++++++
> > > > >     1 file changed, 12 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/interrupt-controll=
er/atmel,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
atmel,aic.yaml
> > > > > index 9c5af9dbcb6e..06e5f92e7d53 100644
> > > > > --- a/Documentation/devicetree/bindings/interrupt-controller/atme=
l,aic.yaml
> > > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/atme=
l,aic.yaml
> > > > > @@ -54,6 +54,10 @@ properties:
> > > > >         $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > >         description: u32 array of external irqs.
> > > > > +  microchip,nr-irqs:
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > > +    description: u32 array of nr_irqs.
> > > > This makes no sense, did you just copy from above? Why would the nu=
mber
> > > > of irqs be an array? Why can't you determine this from the compatbl=
e?
> > > >=20
> > > Sorry for the bad description. I will correct it in the next version.
> > >=20
> > > For the second part of the question, this change was done as a step to
> > > resolve having a new compatible while having practically the same IP
> > > pointed out in the v3 of the series [1]. It is kind of looping back to
> > > the initial idea now. Even if this is added as a driver data, it
> > > overrides the expectation from the comment in [1]. Please suggest. I
> >=20
> > In your v3 patch, indeed you were extracting the number of IRQs from the
> > compatibility string (aka, from device tree...). It's my preferred
> > solution as well.
> >=20
> > So, come back to v3 [1] and address what Conor said in v4 "...having
> > specific $soc_aic5_of_init() functions for each SoC seems silly when
> > usually only the number of interrupts changes. The number of IRQs could
> > be in the match data and you could use aic5_of_init in your
> > IRQCHIP_DECLARE directly"
>=20
> Well, after a brief talk with Varshini and a review of the code, I'm not =
so
> sure it's worth re-writing this part anymore Conor...
> It'll need changing 3-4 files (2 drivers and the "common" .h/.c files,
> because of the type change of ".data"); handling the special case of sama=
5d2
> (smr_cache thing) and touching lot more code than what is done in v3 of t=
his
> patch series.
>=20
> Original design was probably not optimal, but well, it's simple,
> understandable and except if there is a big benefit in moving, I would
> prefer to keep it like this.
> If you agree, we can ask Varshini to re-post a separated IRQ-focused seri=
es
> for handling sam9x75 changes.

I dunno, it's up to the folks that care about the driver whether they
want to do restructuring, not me. The nr-irqs property stays NAKed though,
since the information is determinable from the compatible.

Thanks,
Conor.

--nDBBa4rtrpxCXD0u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZo/9CgAKCRB4tDGHoIJi
0mx3AQCsqLkCivWDia6wN8hZKPu1StC5UsY51d1Rozwcn71YtgEArFLPqvA4ftRs
hwFCmStS0rheTKUI+76oEvQMyLkXJw4=
=Z7jH
-----END PGP SIGNATURE-----

--nDBBa4rtrpxCXD0u--

