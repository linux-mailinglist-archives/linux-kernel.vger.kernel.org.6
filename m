Return-Path: <linux-kernel+bounces-219777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0B490D7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50772B3285F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDA713C67E;
	Tue, 18 Jun 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4LRG5bb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6B4E1A2;
	Tue, 18 Jun 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725458; cv=none; b=tS9Uk8TPv4gI1XPmgYu8QgjNNorVWWuFY77vJs7X7p3c195jyCv6JTKqvIZgUcmey/2afMOoSvfq9mhapwrZOKXBfBXGzKLtA08Cp0sb8CrV866Eik4vQb2j3XAjEdWOjJC8A9Qd9TnjXGoIIzoKdvyvxIfSy4YdIEhdN1sy+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725458; c=relaxed/simple;
	bh=Nz74RKopuS+B4T23S582RCPI8vsJnBsk3FTpx1fP5ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbomI77r/u2OcK9ijsedbkw8O/M3RFynZwlPBaYtlGt6UIJtja9RqcoKMoXdY2jpbwr3WuQk78m2njZn5o8997e3zYsmTqa9mOnSHDNh5qbtlWaVXiyuGeBK82rmP0BcHZq7Y5127nenZx2LFooH2dNJzUGjyuO8feZTy3aV4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4LRG5bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B16C4AF1D;
	Tue, 18 Jun 2024 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718725458;
	bh=Nz74RKopuS+B4T23S582RCPI8vsJnBsk3FTpx1fP5ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4LRG5bbjkpvMDqJzi5M706m3FpBdIAYHszpbVxRMpYPlhxMQ/4w+uFTHwq5gdMHH
	 gZyNShx1ciZm22/pWrg5s7Dg75UtNJNLyrXRtcYNktarm8wTSjwiBIeb9UXfUuS6oN
	 +9e/b4M0XpRPZo3gAQlWOZKbljOJ6w2a31lz4ramRvJDgOV8gCM/7sw5H+tgKSDBWR
	 sZfD+JSpofVr7n0cm3czDSILbcBwc59ZZ/oXrcBNsElVvtDOXrsBL9R3HMFmEOat1M
	 7MFo3OZl8XTtkv1sv89gl/Mw1YZaY5/JDU3AGeXJfhPvg91fOtE22g9EptjePdK+5I
	 VCVbrhRMMihcg==
Date: Tue, 18 Jun 2024 16:44:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/9] dt-bindings: interrupt-controller: Add SpacemiT
 K1 PLIC
Message-ID: <20240618-dumping-channel-9d44a0a099f0@spud>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_417C31822BDAD48EF8B84B312521318DBA08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FSkqdc+KknUFXXWK"
Content-Disposition: inline
In-Reply-To: <tencent_417C31822BDAD48EF8B84B312521318DBA08@qq.com>


--FSkqdc+KknUFXXWK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 01:20:50AM +0800, Yangyu Chen wrote:
> Add compatible string for SpacemiT K1 PLIC.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml     | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index 709b2211276b..3d0426b56904 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -59,6 +59,7 @@ properties:
>            - enum:
>                - canaan,k210-plic
>                - sifive,fu540-c000-plic
> +              - spacemit,k1-plic
>                - starfive,jh7100-plic
>                - starfive,jh7110-plic
>            - const: sifive,plic-1.0.0
> @@ -71,7 +72,9 @@ properties:
>                - thead,th1520-plic
>            - const: thead,c900-plic
>        - items:
> -          - const: sifive,plic-1.0.0
> +          - enum:
> +              - sifive,plic-1.0.0
> +              - spacemit,k1-plic

Why in two places? This isn't sifive IP, so I think we should go with
this one here.

>            - const: riscv,plic0
>          deprecated: true
>          description: For the QEMU virt machine only
> --=20
> 2.45.1
>=20

--FSkqdc+KknUFXXWK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnGrTQAKCRB4tDGHoIJi
0jq0AP4lxPgHkGay5JhNSJiMctW7CtSJbceARlA+wrgDdJXQPwEAkxZyXmL0TNEH
HEYlHWkxs4e4X0We91j0Af49H7k/Kgk=
=Wk3x
-----END PGP SIGNATURE-----

--FSkqdc+KknUFXXWK--

