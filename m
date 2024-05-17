Return-Path: <linux-kernel+bounces-182601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 178CA8C8D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754F0B24B47
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 20:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D23140399;
	Fri, 17 May 2024 20:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uO0fxI8F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCD1A2C20;
	Fri, 17 May 2024 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715976024; cv=none; b=OlNZNW0VeZtaf75p85r/z76SFWeASki5z/zkwsK0sXYcwtHwTBbO7cUb7PlBuO4+xNN+mTQ0u+mm171dPOA+L0u44hbXfWFGOdK8IA85pNue4O2HhUVSELzqHAWTJu+iY50Wb/9pudLSLIbgwDOSBAm7SI++Uk1fq/QBAIDQd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715976024; c=relaxed/simple;
	bh=mO7CseUBhealxcctlNPit4cFTmehA1i4nglslSvX8Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqUwzMPc2mO0LmDSrV/ZzPaeqKBcz08uFTS5pAaNPCC+KLmus542ImYDHrLJPLvNgBTqBi5K6E6tQAmXMFGVgV0igPXHNy+dQ0i+PYVuNgfnA9gs2fMyU7+m/Fbg6slBMOFYziDMdSat0zTX4XbXYWYIT7cXGuSC755UzxnLjxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uO0fxI8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D682CC2BD10;
	Fri, 17 May 2024 20:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715976023;
	bh=mO7CseUBhealxcctlNPit4cFTmehA1i4nglslSvX8Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uO0fxI8FFLkYVRhck0Wkwx/iUrrEBPSCiE1OLZUMOTKhIS+nXvu1wE+JoKWtqMEtA
	 LXJ5vd6gSyk8beFp1jqgCWWEHoYSMKILQksgqSed+SLOCXZ8siJx9RvnbFxYL9oPcE
	 YZ/PS0lL2aLLwNdh5F5w7oqBH4DqJ3UuOUUqqJ4hmNpfO6PFnHwdB3AHvfCIT08gKP
	 9gr/2lLLvdSP1GDtTLKySmBavbprNQNj1rnAcJw4nPbaxI7Rd0S++A6+oGrL+bZJE3
	 wRjdxVd3SheJRPYXMsUIYfTRjQ8ZW+5hjhOZG72KO8sw73dk0W4LhsxVZ1S58FbsBp
	 8zNIkWQplmvZw==
Date: Fri, 17 May 2024 21:00:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: riscv,cpu-intc:
 convert to dtschema
Message-ID: <20240517-browsing-trespass-a46ef27fc115@spud>
References: <20240517150741.181303-1-kanakshilledar111@protonmail.com>
 <20240517-disfigure-disperser-1fa6b36729ec@spud>
 <CAGLn_=s4ghNODpVhPdk61Jt4XLteXp4W7oFS9WOb9O2-9BiXWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D4u/o0+VChCwFfPF"
Content-Disposition: inline
In-Reply-To: <CAGLn_=s4ghNODpVhPdk61Jt4XLteXp4W7oFS9WOb9O2-9BiXWQ@mail.gmail.com>


--D4u/o0+VChCwFfPF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 11:21:54PM +0530, Kanak Shilledar wrote:
> On Fri, May 17, 2024 at 9:34=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > On Fri, May 17, 2024 at 08:37:40PM +0530, Kanak Shilledar wrote:
> > > +properties:
> > > +  compatible:
> > > +    const: "riscv,cpu-intc"
> >
> > A new warning with dtbs_check from your patch:
> > /stuff/linux/build/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: =
interrupt-controller: compatible:0: 'riscv,cpu-intc' was expected
> >         from schema $id: http://devicetree.org/schemas/interrupt-contro=
ller/riscv,cpu-intc.yaml#
> > /stuff/linux/build/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: =
interrupt-controller: compatible: ['andestech,cpu-intc', 'riscv,cpu-intc'] =
is too long
> >         from schema $id: http://devicetree.org/schemas/interrupt-contro=
ller/riscv,cpu-intc.yaml#
> >
> > There's a duplicate description in riscv/cpus.yaml:
> >   interrupt-controller:
> >     type: object
> >     additionalProperties: false
> >     description: Describes the CPU's local interrupt controller
> >
> >     properties:
> >       '#interrupt-cells':
> >         const: 1
> >
> >       compatible:
> >         oneOf:
> >           - items:
> >               - const: andestech,cpu-intc
> >               - const: riscv,cpu-intc
> >           - const: riscv,cpu-intc
> >
> >       interrupt-controller: true
> >
> > I think the one in cpus.yaml should be converted to a ref and the
> > andestech compatible added here.
>=20
> I am working on the v2 patch, in which I didn't provide any ref to the
> cpus.yaml and just replaced my compatible section with the one above
> to resolve the issue with `/renesas/r9a07g043f01-smarc.dtb`. I tested
> with others and didn't get any warnings.

Please don't do that, we shouldn't have two different places that each
are defining compatibles etc for the hardware.

Thanks,
Conor.


--D4u/o0+VChCwFfPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZke3UQAKCRB4tDGHoIJi
0q6PAPwKVqnbhecYJjHe4HwYA3O0NAWGknlpQcOFDft4MhEAGgEAhNhFfkElcT02
xQCzM1ohYrPWjt9F8QeIP9AviRyqswU=
=03KH
-----END PGP SIGNATURE-----

--D4u/o0+VChCwFfPF--

