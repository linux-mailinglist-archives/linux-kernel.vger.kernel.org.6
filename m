Return-Path: <linux-kernel+bounces-210402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971F0904335
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C071C21C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5525F870;
	Tue, 11 Jun 2024 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8tNwlcK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926843AD5;
	Tue, 11 Jun 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129445; cv=none; b=p1/r/3qfN04LX0SVgW0dccsKEsaQrumjnOWDUHL9B77jxvIfUZGlXCZe/Ct4YUuwwPetgdm/1dd07oyYPJQ9DiXEz0nASuOs+CQSWLWbBtrLKkkGtRjBaw+67a1nUNvwBfnLfdRlCE6OQG1JUpbnBZ54esmcB1mUlAb5Mks8Fec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129445; c=relaxed/simple;
	bh=TjzdMfhIprBIYXA1Ded7MQ848LN5/jfRqWbIpulmQvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXRbHJJYig7oi2045dySM1I+6R2qgS/4YkyjcrlLF5lWfjkexLy766WZd+JJa9O9k0Z/A5F7QH8VN8XPbNykxT2ONUp3J9VzTk8AdWsWnlwumC3C3PetVHCVwevlXG0Ff4Y9oTNBShVFb1z+JwwCV1QbQwmSj0/uex7OfXRcxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8tNwlcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4745C2BD10;
	Tue, 11 Jun 2024 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718129445;
	bh=TjzdMfhIprBIYXA1Ded7MQ848LN5/jfRqWbIpulmQvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8tNwlcKIt1/wAXVS5HNNI/G+aDoD+Cy+B+GzOC7ogR+dsbMBzRZbp/0A1sAsXeRP
	 WYTHIkKi3hMbzKEJqCOqJyC+sosflnqJmszos6oMHQSg2vtqnr2FY8sse1g2e5W0+H
	 AeR8PR1iXxAQwBm9sQdjCkyEjqGepvnEvaS3vawHoioswWRdx/GXHO4RFf3q3m4hTI
	 zlvxZhb0yDfDRLb+XHdgQy8w+8OQ3mmlxkSAovU6m+NCT9dI/Ox9kCOgkicNXK85as
	 Klr5HC5t3x1ML/lwytCzyTf248TqKivtJ82ZpzlxdhkqTDjDnfGwWKC/Mqw8vhGeKQ
	 lANhMUqeLhBzQ==
Date: Tue, 11 Jun 2024 19:10:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Aniket <aniketmaurya@google.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: i3c: dw: Add clock binding
Message-ID: <20240611-alphabet-dubbed-d6c3a56e7208@spud>
References: <20240611171600.1105124-1-aniketmaurya@google.com>
 <20240611171600.1105124-2-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AJEiS4jL6BfZv+VG"
Content-Disposition: inline
In-Reply-To: <20240611171600.1105124-2-aniketmaurya@google.com>


--AJEiS4jL6BfZv+VG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 05:15:59PM +0000, Aniket wrote:
> Add dt binding for optional apb clock.
> Core clock is mandatory. Also add
> an example.

Please fix your line wrapping here.

> Signed-off-by: Aniket <aniketmaurya@google.com>

Full name please.

> ---
>  .../bindings/i3c/snps,dw-i3c-master.yaml      | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yam=
l b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> index c0e805e531be..7e3d4f308477 100644
> --- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
> @@ -20,7 +20,16 @@ properties:
>      maxItems: 1
> =20
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    items:
> +      - description: Core interface clock

s/interface //.

> +      - description: APB interface clock
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: core_clk
> +      - const: pclk

Why not name them "core" and "apb"? Putting "clk" in both names is
redundant infomration, we already know they're clocks.

> =20
>    interrupts:
>      maxItems: 1
> @@ -49,4 +58,12 @@ examples:
>              pagesize =3D <0x8>;
>          };
>      };
> +  - |
> +    i3c@10400 {

No need for an extra example for this.

Thanks,
Conor.

> +      compatible =3D "snps,dw-i3c-master-1.00a";
> +      reg =3D <0x10400 0x1000>;
> +      interrupts =3D <8>;
> +      clocks =3D <&i3c0_cclk>,<&i3c0_pclk>;
                              ^^
			missing a space here.

> +      clock-names =3D "core_clk", "pclk";
> +    };
>  ...
> --=20
> 2.45.2.505.gda0bf45e8d-goog
>=20
>=20

--AJEiS4jL6BfZv+VG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmiTIAAKCRB4tDGHoIJi
0vecAQC9e41GbhP5Enju1g8aTW6hHW9ASQpnsTQWipyRbCAcGAEAry2a4LactviZ
jCwkwT8BlTp06IV6M5Mh7kQR13zwJgE=
=/2we
-----END PGP SIGNATURE-----

--AJEiS4jL6BfZv+VG--

