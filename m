Return-Path: <linux-kernel+bounces-411147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B45F9CF47B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A9CB35B27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC091E0DBE;
	Fri, 15 Nov 2024 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAN3QWgG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5C18FC89;
	Fri, 15 Nov 2024 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731694596; cv=none; b=CJ4Jr15Md/xEjIsp5tJydeismxcRPFVdRUH+h30hjWDStt3WRu83EN0a0GmvQdzv1WBOt3FMy5m8fxvQ2UDvLUe1OA66V2LCqXUt5B3dUFfVSTEoeiR5dwvJvvz0XuxjlvhSCMSr0Zo2xTsvse5Vi8QHJ/SUmVcZQX6fDGQjgAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731694596; c=relaxed/simple;
	bh=Ajqij5l+VbD/fyP9HOKgcHhq++qaq7/wfGzYBMJNYHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNjl3H4tu+eLBaF0/UL24vycvkFwZqXD8L4t78bkeKY+n6sm9znVuGpLs6Vvpqlax9Ic63Vo0xiCUVJpcqeli+3yChckd49ZuYdSSo09hOfNBVR0RVKCgin1tQErzVl8mLNa2CarlFWNAc9mxkoY8qHMl8L8Uk8uUQAjTdsdeUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAN3QWgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D745C4CED0;
	Fri, 15 Nov 2024 18:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731694596;
	bh=Ajqij5l+VbD/fyP9HOKgcHhq++qaq7/wfGzYBMJNYHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAN3QWgGntJ72//vRQ70Ktir9oDLwAQCDCHiRGIcWPVTAotk/7qfNBTvQTle9BMlD
	 gAJH6xwco2SdcdkYHNUb6SIO0fFRz0N/GoPtjHdD4I5IIr7b/TGLlms13h2BpGunN/
	 CgoCKSNErOVdxNf+CO61yb97h8oyX2Qfl4Pd6/hwPTl5TCJZCr7NNDHUOWdEXZfgGC
	 hq14RlDZ6AOdLE5UcvgwGYqDR9W/NsSRkzcNTrdG0yGXzdPuZJH8+Vr1trjSO7Il2h
	 CgUrPE0i2fnwSiwPPDfEu1GG5X87iltLyyD4cBHfn8H2Jdj1XndTr9XdAM0YkfRMEF
	 LDiIeZe2/L6IQ==
Date: Fri, 15 Nov 2024 18:16:32 +0000
From: Conor Dooley <conor@kernel.org>
To: cleverline1mc@gmail.com
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: w1: ds2482: Add vcc-supply property
Message-ID: <20241115-happy-garter-2cf65f4b1290@spud>
References: <20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com>
 <20241115-ds2482-add-reg-v1-3-cc84b9aba126@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HOgI7ROxgraE+AA0"
Content-Disposition: inline
In-Reply-To: <20241115-ds2482-add-reg-v1-3-cc84b9aba126@gmail.com>


--HOgI7ROxgraE+AA0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 03:58:06PM +0100, Kry=C5=A1tof =C4=8Cern=C3=BD via =
B4 Relay wrote:
> From: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
>=20
> Adds the newly added vcc-supply property to bindings.

This commit message is a circular argument. You're adding it to the
binding, which of course means it is newly added.

>=20
> Signed-off-by: Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com>
> ---
>  Documentation/devicetree/bindings/w1/maxim,ds2482.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml b/Doc=
umentation/devicetree/bindings/w1/maxim,ds2482.yaml
> index 422becc6e1fa8d58665c5586ebdc611cd0b2c760..a6b9e0658ec858cb24b21cf64=
443a061bb43e4ef 100644
> --- a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
> +++ b/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
> @@ -25,6 +25,9 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  vcc-supply:
> +    description: phandle of the regulator that provides the supply volta=
ge.

"vcc-supply: true" should suffice.

> +
>  required:
>    - compatible
>    - reg
>=20
> --=20
> 2.39.5
>=20
>=20

--HOgI7ROxgraE+AA0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzeP/wAKCRB4tDGHoIJi
0iMkAP0RrX4g9TNjdFDQvcGMUp/IlZKR5auop+LsaiO0fvKhkQD/YGCGrp6WlBSs
FBa4+wR3o9Fk1QWXn06MfaLOKRGTEww=
=nlTY
-----END PGP SIGNATURE-----

--HOgI7ROxgraE+AA0--

