Return-Path: <linux-kernel+bounces-556935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 605A1A5D0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4DC7A9E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106D725FA26;
	Tue, 11 Mar 2025 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJaKlmpj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E151EB9F7;
	Tue, 11 Mar 2025 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725903; cv=none; b=daQn4QaOFE2lFnwNC7++4CasB2BpvVsILpMR3R4hkzOykHnOpVwMWBdf7ec93irBxgJSnV590dkXq4zP/epX37qKsqYxtHFgLnawFYueKAS6VMTlzYXsri93Ms+cNFWmfQDhfGcEtHqJCEvCkEnAVlFwSbMgBRF8YNd8d6EspU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725903; c=relaxed/simple;
	bh=p5wxlv0baXv+9OyKpF3W9P7Pe9J7X5EYUfFeIweRo8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssUE3KmywjsDx4knt5P8G+41vQvmyGXBD0AgisdRkGupeQyIcgBovxQDtTyRUbjIUPONRVkHZvEaIq9po6DErbi1FgXNtlYrVi8UxV9wVX0UiDQq+38gswLXlJP3DaDxCI5gazv82NjeIVYG3OLuVc9EWu4KPqn2IqBQ7gMcLz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJaKlmpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5491BC4CEEA;
	Tue, 11 Mar 2025 20:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741725902;
	bh=p5wxlv0baXv+9OyKpF3W9P7Pe9J7X5EYUfFeIweRo8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJaKlmpjXm4f6lZA5REj923wJohERzFXbEWZl3bV7OP9XKjUqE+6bNVEye9YFZZ54
	 jQdwCB/6iUYv9YzUXR+CFAVwGPLx6G7VV9M6LwZKRHBk1hYA0b5ASAe/Hs7PwLXxSi
	 LQPSU7my445RPrq/D6PJYBJ1h8UkXMafV26W+tV1pRHj5LKmM5hlcmrfadQQP618my
	 AyhfNDIpjSU4t5zwCZbOysERoGyuNpR6Z7L4Bq2FL67TjrL4IO0/lLnhv9RH9yyMne
	 SpU9S64myDPSwZWhruU6mnqQDI19qOPlc9qN9p1E2i3eSjQHctk2M7k06SdQ7b93KH
	 Qg2q2sjLnlqSA==
Date: Tue, 11 Mar 2025 20:44:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Nick Hu <nick.hu@sifive.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: timer: Add SiFive CLINT2
Message-ID: <20250311-unwoven-headrest-5b1716bcfeb3@spud>
References: <20250311051903.3825-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zeIRKp/XrKjrRaB4"
Content-Disposition: inline
In-Reply-To: <20250311051903.3825-1-nick.hu@sifive.com>


--zeIRKp/XrKjrRaB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 01:19:03PM +0800, Nick Hu wrote:
> Add compatible string and property for the SiFive CLINT v2.
>=20
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>  .../bindings/timer/sifive,clint.yaml          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/=
Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index 76d83aea4e2b..93d74c504b5f 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -36,6 +36,9 @@ properties:
>                - starfive,jh7110-clint   # StarFive JH7110
>                - starfive,jh8100-clint   # StarFive JH8100
>            - const: sifive,clint0        # SiFive CLINT v0 IP block
> +      - items:
> +          - const: sifive,clint2        # SiFive CLINT v2 IP block
> +        description: SiFive CLINT v2 is the HRT that supports the Zicntr

I'm curious why sifive,clint0 isn't a fallback.

>        - items:
>            - enum:
>                - allwinner,sun20i-d1-clint
> @@ -62,6 +65,22 @@ properties:
>      minItems: 1
>      maxItems: 4095
> =20
> +  sifive,fine-ctr-bits:
> +    description: The width in bits of the fine counter.
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: sifive,clint2
> +then:
> +  properties:
> +    sifive,fine-ctr-bits:
> +      maximum: 15
> +else:
> +  properties:
> +    sifive,fine-ctr-bits: false
> +
>  additionalProperties: false
> =20
>  required:
> --=20
> 2.17.1
>=20

--zeIRKp/XrKjrRaB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ9CgyQAKCRB4tDGHoIJi
0nOuAP9PpKdkQZr7bEJYcCGO2Jxd3xT8eb18iBJdGL9sMehhggD9FXyfpKM7pUMq
4n4C8jt8e/ZF8OUasNqcpXS84fhqPwY=
=Szks
-----END PGP SIGNATURE-----

--zeIRKp/XrKjrRaB4--

