Return-Path: <linux-kernel+bounces-577363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D06CA71C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DD77A3B82
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4150D1F7561;
	Wed, 26 Mar 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq1qAuYH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961011185;
	Wed, 26 Mar 2025 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007429; cv=none; b=oTRZrvuHXR2AwKW4JfaJ0iIIfVJMcsQO2XDMFoSqTyjPN/RxxzuVDmKxh8QsT/G3wAHLiyfwEAMEp9SgxH7MBiyCIXtky+HXwYexrbq1RVcpK4RgOQVZisKGqTUasUlF7f9s678SjHXgAax44dCkj6mp2zMUT6d3EoC3HLjTFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007429; c=relaxed/simple;
	bh=oomNfdMh6E2nDnQNhRCunwuBUsly+x4CicD2ka69jEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGvzL4m9pNZWyd49PCgvSWKYpZvqC+00NUD2Zv021cD390h/Br3egh5QrTRyx/K5XpJxTbsJ+CA5RQml01JI9hZYeyeHOVvRzdBp/mKV7AtiOqzpV5GPd+wrqpvWrEp9Vt3Lxh2qc3HYl7RIybw4Z2TLDE1gjB8fgGrNdwT3Cug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq1qAuYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3174DC4CEE2;
	Wed, 26 Mar 2025 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743007429;
	bh=oomNfdMh6E2nDnQNhRCunwuBUsly+x4CicD2ka69jEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tq1qAuYHIoYqh7GKYTOGbF1nPIOtr/x5x6ow9TyKUwo8DvopuEAsSq4mGhN6UaBgS
	 Dur8UHx/bLiADLD9WRT8IQ1FOrRuAWU+WD+lWYXcDSbj0UPE8OBjNFecO0RQAatFBC
	 IQNe06ZX8D940ybNAaclYEZxCFHi7XnQ6gs4mQrA2q7W916IHNbA+oSBQF/fctf8AE
	 ISEUZbvK448yUbWmxAJqtN6SaaML+iKLKE7saQ3edgFIm0K+c2kds3LqDYNIJ8ddDB
	 GT4i82tJfA9pdA2xKXyBfg2LuO+R2Zuv+Dsuvp9CQPq5RB2wW56ZcLpH1cG9C6Zj23
	 FhQsrZQ7E0gEw==
Date: Wed, 26 Mar 2025 16:43:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Noah Wang <noahwang.wang@outlook.com>,
	Michal Simek <michal.simek@amd.com>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] dt-bindings: trivial-devices: Document SPI
 measurement on LWE boards
Message-ID: <20250326-unluckily-consuming-948176031b08@spud>
References: <20250326140930.2587775-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xPU2MvtdTf8JZkvq"
Content-Disposition: inline
In-Reply-To: <20250326140930.2587775-1-lukma@denx.de>


--xPU2MvtdTf8JZkvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 03:09:30PM +0100, Lukasz Majewski wrote:
> The measurement device on Liebherr's (LWE) boards is used to monitor
> the overall state of the device. It does have SPI interface to
> communicate with Linux host via spidev driver. Document the SPI DT
> binding as trivial SPI device.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---

You should not do a resend with no explanation as to why. Additionally,
I would like to know why my review on the original patch was ignored:
https://lore.kernel.org/all/20250225-despair-rural-dc10216005f4@spud/#t

Cheers,
Conor.

>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index fadbd3c041c8..5d736a9792c2 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -161,6 +161,8 @@ properties:
>            - jedec,spd5118
>              # Linear Technology LTC2488
>            - lineartechnology,ltc2488
> +            # Liebherr on-board measurement SPI device
> +          - lwe,btt
>              # 5 Bit Programmable, Pulse-Width Modulator
>            - maxim,ds1050
>              # 10 kOhm digital potentiometer with I2C interface
> --=20
> 2.39.5
>=20

--xPU2MvtdTf8JZkvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+QuvAAKCRB4tDGHoIJi
0la8AP9wwuHP+ibdTfgyZRbLb0lAWCHK7mvcV2Kclx6o7EIQ+QD7B8V2mFu1CLzL
etaG5we5NpJXY4fyAugjIJXq9JpbdgU=
=joJo
-----END PGP SIGNATURE-----

--xPU2MvtdTf8JZkvq--

