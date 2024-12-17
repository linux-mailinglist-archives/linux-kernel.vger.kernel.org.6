Return-Path: <linux-kernel+bounces-449779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00BF9F55FF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B587168856
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C7D1F8691;
	Tue, 17 Dec 2024 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFbMk+aj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC614B965;
	Tue, 17 Dec 2024 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459717; cv=none; b=Hh+GRaF7I1YQADQyX9uLiyrA+1/Wnz/fwdQTwwc12Pde7Mb3zZGka7hgZ7JN4n//6zWwGuI28Y/4vEzyB7TXP0nyIPA9WcTHuAEfPKc3d/2lvgjRkYq7s5Ldm6TVb9UPtkt4nzYJbKLoavJf6AO1TEJnQnz306K0AAGg/ohOgR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459717; c=relaxed/simple;
	bh=Qx6v/m0eT0KVSkXg4Yl87aJQFBilKDmCaBMeZU4RyC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlfOfnUeygP2SDCBPKP4ieVOMeYEwsBCkxynYXhtCZBNbdbP/FsBkroHCKoACS7cZxgxIvbBKl911J2SjTH7dNYVHq5kRU7nmXEGREy67XJpentXe0N5XUVlu2CnpUr+azf9Zq8b2FXoC5jLnZ1MxgpB1op4gZEUxCZat2h3WIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFbMk+aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFA4C4CED3;
	Tue, 17 Dec 2024 18:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734459716;
	bh=Qx6v/m0eT0KVSkXg4Yl87aJQFBilKDmCaBMeZU4RyC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AFbMk+ajQKp5dDA43QrwJ+xzQxWM3/BDfTQYgHZvN8frM+tkIwZz8hKVYhI58RkA4
	 TCWxTPglaS1d4ipiIy0OqjQKF5TgzkiahZwJrIyS82lZrogsxCsNRIrbdGYJbrWbNh
	 sXiR6R7oF+ljaDPyv7/cdukLqIz1mdyYQWqiFtlI6sjsL92Ir59ml4/vnQO+yuBQ6r
	 pJurWJumZ3ABc5LPmvSMyklqE2jqZRlayXVBKpGztFR9VvqjZe+G9izSmkqkCT2RUA
	 sZRe5qUSzmZEZZRd+UOWudJQWlau/fGYfEAsT5snSG4OU6Zk0KiRwnUwtoBTxU/Pzg
	 rUlo4w3dk/ITw==
Date: Tue, 17 Dec 2024 18:21:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: mfd: sprd,sc2731: reference
 sprd,sc2731-efuse bindings
Message-ID: <20241217-envoy-plant-c088f5f80bd1@spud>
References: <Z1_9ROiI2ZHKsbAD@standask-GA-A55M-S2HP>
 <20241216-bobbed-lend-abf4b2b5323c@spud>
 <Z2ErogZuX_bLtM2c@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r9y0Ru4J3JjlPJb/"
Content-Disposition: inline
In-Reply-To: <Z2ErogZuX_bLtM2c@standask-GA-A55M-S2HP>


--r9y0Ru4J3JjlPJb/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 08:43:30AM +0100, Stanislav Jakubek wrote:
> On Mon, Dec 16, 2024 at 06:39:09PM +0000, Conor Dooley wrote:
> > On Mon, Dec 16, 2024 at 11:13:24AM +0100, Stanislav Jakubek wrote:
> > > Directly reference the sc2731-efuse bindings to simplify the schema.
> > > Remove the duplicate example from the efuse bindings.
> > > While at it, add the "pmic_adc" label that was missed during the
> > > initial YAML conversion.
> > >=20
> > > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > > ---
> > > Changes in V4:
> > > - rebase on next-20241216
> > > - drop patch 1 (already applied)
> > > - add the pmic_adc label that was initially missed
> > >=20
> > > Changes in V3:
> > > - new patch due to a missing dependency in the MFD tree=20
> > >=20
> > > Link to V3: https://lore.kernel.org/lkml/cd8cc95b59c31418b174bba521dd=
2599a7929fda.1730709384.git.stano.jakubek@gmail.com/
> > > Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA=
-A55M-S2HP/
> > > Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA=
-A55M-S2HP/
> > >=20
> > >  .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 12 ++------
> > >  .../bindings/nvmem/sprd,sc2731-efuse.yaml     | 29 -----------------=
--
> > >  2 files changed, 2 insertions(+), 39 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml b=
/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> > > index 8beec7e8e4c6..b023e1ef8d3c 100644
> > > --- a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> > > @@ -67,15 +67,7 @@ patternProperties:
> > > =20
> > >    "^efuse@[0-9a-f]+$":
> > >      type: object
> > > -    additionalProperties: true
> > > -    properties:
> > > -      compatible:
> > > -        enum:
> > > -          - sprd,sc2720-efuse
> > > -          - sprd,sc2721-efuse
> > > -          - sprd,sc2723-efuse
> > > -          - sprd,sc2730-efuse
> > > -          - sprd,sc2731-efuse
> > > +    $ref: /schemas/nvmem/sprd,sc2731-efuse.yaml#
> > > =20
> > >    "^fuel-gauge@[0-9a-f]+$":
> > >      type: object
> > > @@ -199,7 +191,7 @@ examples:
> > >            };
> > >          };
> > > =20
> > > -        adc@480 {
> > > +        pmic_adc: adc@480 {
> >=20
> > I don't understand the point of this hunk, nothing ever references it.
> > Examples aren't supposed to contain unused labels.
>=20
> Hi Conor,
>=20
> this label is used by the fuel-gauge io-channels in the example:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/mfd/sprd,sc2731.yaml?h=3Dv6.13-rc3#n219

Ah shit, my bad. I didn't realise all that was one example.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--r9y0Ru4J3JjlPJb/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2HBQAAKCRB4tDGHoIJi
0jvUAQDG5kNOA0nT9wNL2zOUvJlunou1KWj07v4pclFPUFUQvgD/dQYGIe0icVnP
eamHwUDdp0bNswgb95leLFma8qeHUwU=
=OA2B
-----END PGP SIGNATURE-----

--r9y0Ru4J3JjlPJb/--

