Return-Path: <linux-kernel+bounces-397002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8F59BD572
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A2E1C21847
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1E31E885E;
	Tue,  5 Nov 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci6r5DV2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2B1D516F;
	Tue,  5 Nov 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832799; cv=none; b=M8QaCU6oDOqjp4q3h4MmxtJSDFiFQqvTpFnLtfz264j2ehj2H4kWu9PaCLJ51TC5u5lHgI/VbJZmwmq/a5pR8t4N5ouRIVKRH2fmdbZ9hr1xnbzoIwo86ZdN12W/E/yFZpGwkyOsC4rT6ZLnFM4ZV43beos+eW+K/fogaIKWz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832799; c=relaxed/simple;
	bh=ehmuV0mGF+56Q7DGeN7/B0OGtD8FDHl8tJhMc+L5J7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVW4gSC926cGwjsfGCahDkGSXIGggYuIAXpARHZ1JrdbjfL/TpHe1JDH9Qm/rjxF7eS6TYaAfrdBqryzN3ddeQTowmFmIU9Keqb93JLGQvo0vTiGXJht54Y0bIybPwFC9TMVLeSAMIbKXfa8sqM3ezg61NNVVHf8z4isMEauhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci6r5DV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4656C4CECF;
	Tue,  5 Nov 2024 18:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730832798;
	bh=ehmuV0mGF+56Q7DGeN7/B0OGtD8FDHl8tJhMc+L5J7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ci6r5DV2VqvCag1s6EuF1aRwGbPKGH/tDqYybfvWC09acB+ugQ+GjwdbjAN+mH/zy
	 9wUzO9DRDwMJO7FtUVQzTMYgujVqO3KDgHY6kXbZXUUv/ACutVQBpo4uUAU1A/dmrA
	 0KPfpjx8ruV3QgyNqLAhbXp661aM0b5hHIqO6Q2jXxAeyAXVw/K/s/nkR+0nALKWUP
	 k02jNQE3NdHiPOnuxzyXcaNHbBKmTI5cdXXbf4xnd5JEjzX8tA8vLQma1VRzkDEE3c
	 J1e2RY1kEInd06J27owPH5EGn3nsxBG2etos92r1tCCT23IH726/PaZyDU2W8/1lel
	 4nKNe9OV3BcCQ==
Date: Tue, 5 Nov 2024 18:53:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Naresh Solanki <naresh.solanki@9elements.com>, jdelvare@suse.com,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, krzk+dt@kernel.org, sylv@sylv.io,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	linux@roeck-us.net, Joel Stanley <joel@jms.id.au>,
	conor+dt@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Message-ID: <20241105-regroup-busily-adbb9b342abc@spud>
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
 <173072771091.3690717.11563964377469449295.robh@kernel.org>
 <20241104-saturate-device-d020a0d7321f@spud>
 <f468a5c0a0112cee35815fb6c7b7f9933934adc2.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R4RpYoaHCnWgW7y6"
Content-Disposition: inline
In-Reply-To: <f468a5c0a0112cee35815fb6c7b7f9933934adc2.camel@codeconstruct.com.au>


--R4RpYoaHCnWgW7y6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 10:39:34AM +1030, Andrew Jeffery wrote:
> Hi Conor,
>=20
> On Mon, 2024-11-04 at 18:49 +0000, Conor Dooley wrote:
> > On Mon, Nov 04, 2024 at 08:39:21AM -0600, Rob Herring (Arm) wrote:
> > >=20
> > > On Mon, 04 Nov 2024 14:52:14 +0530, Naresh Solanki wrote:
> > > > Document the new compatibles used on IBM SBP1.
> > > >=20
> > > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > > Changes in V4:
> > > > - Retain Acked-by from v2.
> > > > - Fix alphabetic order
> > > > ---
> > > > =A0Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> > > > =A01 file changed, 1 insertion(+)
> > > >=20
> > >=20
> > >=20
> > > My bot found new DTB warnings on the .dts files added or changed in
> > > this
> > > series.
> > >=20
> > > Some warnings may be from an existing SoC .dtsi. Or perhaps the
> > > warnings
> > > are fixed by another series. Ultimately, it is up to the platform
> > > maintainer whether these warnings are acceptable or not. No need to
> > > reply
> > > unless the platform maintainer has comments.
> > >=20
> > > If you already ran DT checks and didn't see these error(s), then
> > > make sure dt-schema is up to date:
> > >=20
> > > =A0 pip3 install dtschema --upgrade
> > >=20
> > >=20
> > > New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ibm-
> > > sbp1.dtb' for
> > > 20241104092220.2268805-1-naresh.solanki@9elements.com:
> >=20
> > Really? This many warnings on a v6?
> >=20
>=20
> I understand that it's surprising and disappointing, however these
> warnings are from the Aspeed DTSIs and not directly from the proposed
> DTS. Many are an artefact of history, and I'm (slowly) working to clean
> them up. Recently I haven't had any time to dedicate to that effort,
> and as I'm somewhat responsible for the state of things, I'm not
> prepared to block other people's patches and push my own
> responsibilities onto them.

Ah, you see that's where I would say "no new warnings" and get the
submitter to fix them ;) And were I the submitter, I'd want to resolve
the warnings rather than run into issues down the road when things get
"fixed"/documented. But I guess that's why I have the schmucks task of
reviewing bindings innit..

> I've been replying to those proposing new Aspeed-based devicetrees to
> separate the warnings they're introducing from the warnings that
> already exist, and requiring them to fix the issues they're responsible
> for. I hope that I'll have time to continue to improve the situation,
> as this is obviously a tedious task for me too.=20

Well, it is your platform and if you're confident that these nodes are
correct despite the warnings, who am I to stop you!

--R4RpYoaHCnWgW7y6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyppmQAKCRB4tDGHoIJi
0gl3AQDYMKKpv+VRW+O5chJQqZbIqtD3TSwbPLzL+iwv7LwutgD/SjKnZdTS+eIj
kcZPtile9/G6QpMnUwj4wo/u+c6FAwU=
=6O1S
-----END PGP SIGNATURE-----

--R4RpYoaHCnWgW7y6--

