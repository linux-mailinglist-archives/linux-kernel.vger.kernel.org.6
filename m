Return-Path: <linux-kernel+bounces-189023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 579978CE9FF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCB41F230E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ED23FE5D;
	Fri, 24 May 2024 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBMOwUP7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DD63A268;
	Fri, 24 May 2024 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716576060; cv=none; b=tMQju/d62efw9/Gxhl6UOO2YT17cv4/LPC/2pT0GuTAAq61d4oa54cf+UCA5WPVyKnsFfKikmoo1TJaEovic0/DTryjogWK5s2LRAhoiaOsPPtMVk0wm2avHACosT79kwOqowgI6WCoVJLOCxf7TWrBjX3ltMieON60t3W4UU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716576060; c=relaxed/simple;
	bh=40gtA562p+lzTr+9s5RdmfFpwV562RCDBYLHPKo0nKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2haJPqmN9DBVOUcThMtIh/hGVyjqaTdQv1Qrivie5o5uoXKesN2yu0ALMZuVJE20gazeSAvfbRU9RguI03swVh0Y5TziPfNykOV/lR6adEBcQiU1lghVdA0wS/ZlzKwTpfExxftay1l/ywiU1mgoKbQhnMZ+22bLYg4WYCdDew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBMOwUP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8F1C2BBFC;
	Fri, 24 May 2024 18:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716576059;
	bh=40gtA562p+lzTr+9s5RdmfFpwV562RCDBYLHPKo0nKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBMOwUP7AP/4PR0PLfby9X4PcyO0ur/nKESPtUBj36LbsywxT1CwIj7RwKXXKvHJe
	 T4tEznwZi/jrasixDIEhX+yxPRuLzmXqj0Rj7VjJa4I+30ujLIbRreH1i5G5zG9Gwl
	 3qPybTC0hq5PMPkL3afqj3yZV697FG7ItUR7aBM8yobAV6J/nyqRV0JU3cmnLA8cWo
	 JKLYfmWLXN7MZKNp6i9C0snt/vYDx3eLKtJGNns3FajyvtQF8LeOiywgDqhrLLT3HI
	 0rlphCLLguX/4ZUmn7hdVyG3x/QPuWPITU/TIV9NYIRO53i18Mo/jzmS3feyrQVCV3
	 2gpKV6fZ1eXrw==
Date: Fri, 24 May 2024 19:40:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: rename gw7905 to gw75xx
Message-ID: <20240524-cavalier-outthink-51805f49c8fb@spud>
References: <20240522215043.3747651-1-tharvey@gateworks.com>
 <07250029-7cea-4a82-9e70-22e0e6f7fb37@linaro.org>
 <20240523-vividly-sequester-d85ac7bccbbd@spud>
 <CAJ+vNU3fQt=6t3a_QFU_3jb5mTVLGJiptPnGEmWvvXZYGEPOFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pCaot/fJN4+FoIrV"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3fQt=6t3a_QFU_3jb5mTVLGJiptPnGEmWvvXZYGEPOFQ@mail.gmail.com>


--pCaot/fJN4+FoIrV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 04:04:50PM -0700, Tim Harvey wrote:
> On Thu, May 23, 2024 at 7:47=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Thu, May 23, 2024 at 09:02:46AM +0200, Krzysztof Kozlowski wrote:
> > > On 22/05/2024 23:50, Tim Harvey wrote:
> > > > The GW7905 was renamed to GW7500 before production release.
> > > >
> > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Docum=
entation/devicetree/bindings/arm/fsl.yaml
> > > > index 0027201e19f8..d8bc295079e3 100644
> > > > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > > > @@ -920,8 +920,8 @@ properties:
> > > >                - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
> > > >                - fsl,imx8mm-evk            # i.MX8MM EVK Board
> > > >                - fsl,imx8mm-evkb           # i.MX8MM EVKB Board
> > > > +              - gateworks,imx8mm-gw75xx-0x # i.MX8MM Gateworks Boa=
rd
> > >
> > > That's not even equivalent. You 7500 !=3D 75xx.
> > >
> >
> > > >                - gateworks,imx8mm-gw7904
> > > > -              - gateworks,imx8mm-gw7905-0x # i.MX8MM Gateworks Boa=
rd
> > >
> > > Compatibles do not change. It's just a string. Fixed string.
> >
> > I think there's justification here for removing it, per the commit
> > message, the rename happened before the device was available to
> > customers.
> > Additionally, I think we can give people that upstream things before th=
ey're
> > publicly available a bit of slack, otherwise we're just discouraging
> > people from upstreaming early.
>=20
> Hi Conor,
>=20
> Thanks for understanding - that's exactly what happened. I'm in the
> habit of submitting patches early and often and it's no fun when
> something like a silly product name gets changed and breaks all the
> hard work.
>=20
> The board model number is stored in an EEPROM at manufacturing time
> and that EEPROM model is used to build a dt name. So instead of GW7905
> which would be a one-off custom design it was decided to change the
> product to a GW75xx. The difference between GW7500 and GW75xx is
> because we subload components on boards between GW7500/GW7501/GW7502
> etc but the dt is the same.
>=20
> If there is resistance to a patch that renames it then I guess I'll
> have to submit a patch that removes the obsolete board, then adds back
> the same board under a different name. Shall I do that?

I think this patch is fine - other than the inconsistency that Krzysztof
pointed out between the "renamed to gw7500" and the "gw75xx" in the new
compatible.

--pCaot/fJN4+FoIrV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlDfNgAKCRB4tDGHoIJi
0uWsAP9dzrZ3+eiCFu2YQvK3J+Zew8rK3KOAEeLUpnNiZQre7QEAzAhNADZZS5/6
Y98YUIYEF8yRhwinZqc/RiVXus5T0gY=
=BFLi
-----END PGP SIGNATURE-----

--pCaot/fJN4+FoIrV--

