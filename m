Return-Path: <linux-kernel+bounces-571604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB46A6BF9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB383189FD08
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB67922CBC0;
	Fri, 21 Mar 2025 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itDBty/K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126C1D86F2;
	Fri, 21 Mar 2025 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573828; cv=none; b=FQl/w7YTv0Ibae+F7e3VNHtFg/R7lW1RojOqA3VCSgwRzow5Zkg39xnX8JHLqbJAuNf1PDokDZ3LRlQO0q1gLuprozwClJb1GXvr+F8caE9waKQXUwytZtwvYQLHNY0aoVrDNsw9b90mdU7keUonXO4sWboOxwF+Jfh4fX32U1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573828; c=relaxed/simple;
	bh=umYqcnZz+agf38qEhHYrPYvQsxuxpuc1Mi3ge1ApdAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du6+gb9OJ8sanX67c4gedoaJNbDWtXroiDfEA9a0yhxoALomNGsolBtF27nizgR8F/XMHcI23TubmTZ9O+xJ5e36k4HnQnTN3ku9od+nlIPuhDarla4csx6eqKOZ3ze0yfWh5GXuvx9VSy2tpqlwXGplSFIL9vpK58QgZiPMVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itDBty/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5272AC4CEE3;
	Fri, 21 Mar 2025 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742573827;
	bh=umYqcnZz+agf38qEhHYrPYvQsxuxpuc1Mi3ge1ApdAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=itDBty/KNEjPSwYMNa8z9uFKfsH0bVgmDLPIEi8PauRGi2IsNeIKCWCHA+7pug8TT
	 HQGf94iD4NvsRp/7HPBYE0eBFgeIVSrDYjvkCaHWzwfWaauADPnUSFUHGyerp/SbAZ
	 +LV1En1EFRXbtrXjhZXDbkGW/WllYWVrD+e7Fh+5rVh/qNWtfy1+8ZXyyMGvPkHL2c
	 77sS5sVOpcqkOyU5IxGJNnBXBprsQ0Nn+f9+zIDJtt38hg4h0iZiEvDPGkRbyJHv+O
	 OoLu72AYlRCo291i+Nvavko7MTXmPvzRrhF5k1RqmO/nxl4ApxB8OmBk5yPIV9Upmr
	 pZr243kG80S9Q==
Date: Fri, 21 Mar 2025 16:17:03 +0000
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
Subject: Re: [PATCH v3] dt-bindings: timer: Add SiFive CLINT2
Message-ID: <20250321-crazily-attention-1aeb67606cf3@spud>
References: <20250321083507.25298-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dT2myeOCt2U0MUNc"
Content-Disposition: inline
In-Reply-To: <20250321083507.25298-1-nick.hu@sifive.com>


--dT2myeOCt2U0MUNc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 04:35:06PM +0800, Nick Hu wrote:
> Add compatible string and property for the SiFive CLINT v2. The SiFive
> CLINT v2 is incompatible with the SiFive CLINT v0 due to differences
> in their control methods.
>=20
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
> - v3 changes:
>   - Add the reason for the incompatibility between sifive,clint2 and
>     sifive,clint0.
> - v2 changes:
>   - Don't allow sifive,clint2 by itself. Add '-{}' to the first entry
>   - Mark the sifive,fine-ctr-bits as the required property when
>     the compatible includes the sifive,clint2
>=20
>  .../bindings/timer/sifive,clint.yaml          | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/=
Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index 76d83aea4e2b..34684cda8b15 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -36,6 +36,12 @@ properties:
>                - starfive,jh7110-clint   # StarFive JH7110
>                - starfive,jh8100-clint   # StarFive JH8100
>            - const: sifive,clint0        # SiFive CLINT v0 IP block
> +      - items:
> +          - {}
> +          - const: sifive,clint2        # SiFive CLINT v2 IP block
> +        description:
> +          SiFive CLINT v2 is the HRT that supports the Zicntr. The contr=
ol of sifive,clint2
> +          differs from that of sifive,clint0, making them incompatible.
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-clint
> @@ -62,6 +68,22 @@ properties:
>      minItems: 1
>      maxItems: 4095
> =20
> +  sifive,fine-ctr-bits:
> +    maximum: 15
> +    description: The width in bits of the fine counter.
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: sifive,clint2
> +then:
> +  required:
> +    - sifive,fine-ctr-bits
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

--dT2myeOCt2U0MUNc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ92Q/wAKCRB4tDGHoIJi
0rQ6AQCiSS55Yt7GDJR+NVBVe/vA621bKXpmgoK5F4s/BCg0YQD/cAZ/JN+9lRZi
SzUkk9S/gW9bBvtexlGOY8rgWEaEmQ8=
=pGkd
-----END PGP SIGNATURE-----

--dT2myeOCt2U0MUNc--

