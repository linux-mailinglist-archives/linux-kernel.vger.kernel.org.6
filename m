Return-Path: <linux-kernel+bounces-262314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD7D93C3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891BE1F2183B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A50C19D074;
	Thu, 25 Jul 2024 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOIwYLb4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2743FB3B;
	Thu, 25 Jul 2024 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917188; cv=none; b=MAGnlrS5ThwlZFETY85gaKN99yVbzO2bfWO55y8A7SWZ2dpg3HXNdVXCZMLrcURmJfXcCXGRN3kuX/qThy8cE/cHTparDNYjw0ReFlIu20YpNn/AhJYHwe07rGy4QgLt6GrA8nq0a0OHSAq2bx+TavLugSN7+PhdquHZCpAO1hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917188; c=relaxed/simple;
	bh=xSXbpBKVBhuZ4AyMY+6MQuhpMHVCd4YhhxciNhrGcMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOVbEgO2cunEJ+TmQEIL+dL0X3zNre8rMjRdHMTTcR/6CR8umrtr6RFGee0/v1PIqPdZv7WFGGSUlLPqOHeUrT1hxsNUiFFB0EbnyTGFbmTSRVAyGYcfEKLaMbAhTAfVeb5CTpZu2X9gouL6f3TZmeNZ629P/H+ZHEGE2RsyqdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOIwYLb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA61C116B1;
	Thu, 25 Jul 2024 14:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721917188;
	bh=xSXbpBKVBhuZ4AyMY+6MQuhpMHVCd4YhhxciNhrGcMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vOIwYLb4PE900cdK78Zk1zR+oad48KV56rFvEz0yj57Nt7qkbpnCBJW8vukMvV/gb
	 gBs1EhqtoLtDT1rkEIdxxD7x5ssQow1s1ahbS6nSbU3cysVyVUK+6kt+EdrI0KvdG+
	 xCf2dSxfBC6EfQNtHMM/tPmCmukVPN8dFK/DXcWRelYSZNqCH2Nc5Stl8U2wc1UgRf
	 LhnmnM8w6Aeplpc4X6YXiB6nuZxTTtnDQg2Ulur9SwKsht4OWOZVCV97jkJEiBz9F2
	 D77BtymVLs0lg5LiOg6SRFaSiAFL9TbU0feh4ngdaYFODeleZmRXIQDH0vjYy/HcLO
	 Sdrxd0YJmkufg==
Date: Thu, 25 Jul 2024 15:19:43 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/17] dt-bindings: clock: mpfs-ccc: Add PIC64GX
 compatibility
Message-ID: <20240725-trance-creme-d71484a00581@spud>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
 <20240725121609.13101-8-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="duUHs0Bth47OpGBI"
Content-Disposition: inline
In-Reply-To: <20240725121609.13101-8-pierre-henry.moussay@microchip.com>


--duUHs0Bth47OpGBI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 01:15:59PM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX SoC has clock compatibles with the MPFS IP

These commit messages don't really make sense. It should read something
like "The pic64gx SoC has has Clock Conditioning Circuitry compatible
with that on PolarFire SoC" or something along those lines.

>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> ---
>  .../devicetree/bindings/clock/microchip,mpfs-ccc.yaml       | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/microchip,mpfs-ccc.y=
aml b/Documentation/devicetree/bindings/clock/microchip,mpfs-ccc.yaml
> index f1770360798f..9a6b50527c42 100644
> --- a/Documentation/devicetree/bindings/clock/microchip,mpfs-ccc.yaml
> +++ b/Documentation/devicetree/bindings/clock/microchip,mpfs-ccc.yaml
> @@ -17,7 +17,11 @@ description: |
> =20
>  properties:
>    compatible:
> -    const: microchip,mpfs-ccc
> +    oneOf:
> +      - items:
> +          - const: microchip,pic64gx-ccc
> +          - const: microchip,mpfs-ccc
> +      - const: microchip,mpfs-ccc
> =20
>    reg:
>      items:
> --=20
> 2.30.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--duUHs0Bth47OpGBI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqJe/wAKCRB4tDGHoIJi
0slGAP4wp/zEDCscW2AIhOJSwQdtzjmmLTjj+1JuMn38oqByKgEA6ThBH9tWmOYa
PvNEFcO75zEzmND+DCX0MJSXwX4tZwE=
=GAWT
-----END PGP SIGNATURE-----

--duUHs0Bth47OpGBI--

