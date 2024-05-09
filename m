Return-Path: <linux-kernel+bounces-174660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5AE8C125D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3407A1F220DE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50AA16F82E;
	Thu,  9 May 2024 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1QS4I9/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8815F3E6;
	Thu,  9 May 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715270407; cv=none; b=RKcBOaWI9dqfOQ30Fo//I1fN25qPRES+jLl1UrcK6RrHSFTYyFNSEavg+gGmCDEdhY64VPS8eKQ6erqJAZyz7tb+KPEtfP+0+20XmCf73YdEnccySLnpwJBkKo7zyfHHT1sURtUE+YJfqfG3Y2bBqaxx9JurAPj/TTDmA6e/1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715270407; c=relaxed/simple;
	bh=UfrhcwJ0ah2cdvUjRZoxoFEbzLrvnyUF0PTj5hIHqUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYykqV8MXBvSFQffLGXgKLO5qZNzFboDFqLWHhOi2183SU+bDOzB1hDhO+fw9mqqdrcwFmXZfwPUXzMKsp18eYLyJyFfNzpfUEEnC76X+VqoVyGvwCMEZe/p/XB49rpBfBpIxKuv/H7+4cMIL0P+E2ZAEMRGOqPCTZiOzFwSzWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1QS4I9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000CCC116B1;
	Thu,  9 May 2024 16:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715270406;
	bh=UfrhcwJ0ah2cdvUjRZoxoFEbzLrvnyUF0PTj5hIHqUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1QS4I9/90RXeixwL6xknwvJ1+xBV2aul465fqkma4WCyBi+J2/zrkXPUQHWANtEA
	 kwWRtPI5J4zzjFU88sx3O2FZwlgbEUU7kpgl/RM/Q44RTwqKQ8W6ywwBLYgbqvN6/L
	 S1gvdRXogBoJAgm56y9GlSYyavLXlow4HkVZ+dpCmfF8ser4dpdFOCaDNvjYbWN0aI
	 RqBuZTB2b2dCgSq8MgtiHMQEkI5sONms+sj3IYtrGU6nEa4JRmbebq44vBCJkfZTIq
	 LPRdY90qoxORA7dUbEABSw5GJRhs6dYU6db9fTeC6EwaaepS6AIoVPSyx8cqq5DypT
	 9pvRdUv4g5UAA==
Date: Thu, 9 May 2024 17:00:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 2/4] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Message-ID: <20240509-recycler-flask-0b3b7e2802f9@spud>
References: <20240509-cn9130-som-v5-0-95493eb5c79d@solid-run.com>
 <20240509-cn9130-som-v5-2-95493eb5c79d@solid-run.com>
 <5da207e2-1579-4056-9e3f-c25f5b14e225@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vtGJc9zRmffZ/WKF"
Content-Disposition: inline
In-Reply-To: <5da207e2-1579-4056-9e3f-c25f5b14e225@solid-run.com>


--vtGJc9zRmffZ/WKF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 10:49:13AM +0000, Josua Mayer wrote:
> Am 09.05.24 um 12:46 schrieb Josua Mayer:
> > Add bindings for the SolidRun CN9132 COM-Express Type 7 evaluation boar=
d.
> > The CEX is based on CN9130 SoC and includes two southbridges.
> >
> > Because CN9132 and 9131 are just names for different designs around the
> > same SoC, no soc compatibles beside marvell,cn9130 are needed.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml | 8 ++=
++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k=
=2Eyaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> > index 74d935ea279c..538d91be8857 100644
> > --- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> > +++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> > @@ -92,4 +92,12 @@ properties:
> >            - const: solidrun,cn9130-sr-som
> >            - const: marvell,cn9130
> > =20
> > +      - description:
> > +          SolidRun CN9132 COM-Express Type 7 based single-board comput=
ers
> > +        items:
> > +          - enum:
> > +              - solidrun,cn9132-clearfog
> > +          - const: solidrun,cn9132-sr-cex7
> > +          - const: marvell,cn9130
> > +
> >  additionalProperties: true
> >
> It appears I will not be able to submit actual device-tree for this
> board. Therefore when applying this patch-set, it may be skipped.
>=20
> I am not sure about the policy in this case,
> if it is better to pick or skip.

What do you mean my "not be able to"? Does the device exist? If it does
then, I at least, have no objection to documenting a compatible for it.

Cheers,
Conor.

--vtGJc9zRmffZ/WKF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjzzAQAKCRB4tDGHoIJi
0stTAP0Swn4g/aqRsQl4DdOnCMj2fHNKJe8wWaM1UzJWDe0ErAEAoUzKZ5J5wzKF
3vxTmwRcjr2FGSFSByz6l+/v4Q/Cqgk=
=4PBQ
-----END PGP SIGNATURE-----

--vtGJc9zRmffZ/WKF--

