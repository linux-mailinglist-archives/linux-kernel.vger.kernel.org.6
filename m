Return-Path: <linux-kernel+bounces-344171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D5598A5C6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706EC1F2407C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD95818EFEB;
	Mon, 30 Sep 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2TqyLHw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2728E19047C;
	Mon, 30 Sep 2024 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704028; cv=none; b=uuSr5kA0SU7X6TgPngtK5NxiuNQdCGiZh6VICzOMxzop4ReP6bgXWRBADiUtTeHkCf80ORA7hhTjWPpfgoDNn6JbTq0yqnup7nk/Dt3kjFsb3K54zd9rngfFiRKY6OofnKKr2ME0ZBBDsfF5TQ3M/CxF7XsXoC+IeTR1y4vFciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704028; c=relaxed/simple;
	bh=ziv26nKdeGHyeDvoebEHZtakmkZCrhTwBfu3X0oREtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT8n/4Qh/PC/sNkswI4kC8Dfxnk42U2/x9WQhsV53+w7GSsSl5asAeuwt9tWGlXYigmMv8WgPc1SyoXzbtEvpkAKN5ZnxpJE3kYxA8/qRGuAB6nMQdxEpawLvI1CIURdADJJihRb8Jmq0xcieoIMAMNUq3B2mFozaI7QZCKYQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2TqyLHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3786C4CEC7;
	Mon, 30 Sep 2024 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704027;
	bh=ziv26nKdeGHyeDvoebEHZtakmkZCrhTwBfu3X0oREtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2TqyLHwPaml91v43oa1uhJ6COrdhQdrNvWFZrF/KDnz1jqFeG7dzsmRkOvJiigzM
	 0OI9S7FCm1jUuahKVUhEkA3ex+zYv2/mChNJeh0tw0MPHPJqCW2QX7coYn/UAerff5
	 1fRZPwjzbXhsw7RA/S1+iqN6XXEaBv9ktMTNRem/Pro+U+zMMjUXnFakEl5stwu8Xy
	 On4kM65Lt12N5IcEadaXGRUKkEONBEIudKiyf7w/94tyMFoRAtzjlPndVfzWtsghVM
	 eLtNoW+bvlXpibSPW69aqB7hfDzd3YSplcFxzTV6s/6WXl7bR7IwfTx70xfpJFrnKQ
	 gl752ELo9iW/Q==
Date: Mon, 30 Sep 2024 14:47:03 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 06/20] dt-bindings: cache: sifive,ccache0: add
 a PIC64GX compatible
Message-ID: <20240930-ploy-outpost-9d16f9573c20@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-7-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cuCIrOF2wBq4Nn+p"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-7-pierre-henry.moussay@microchip.com>


--cuCIrOF2wBq4Nn+p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:35AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> The PIC64GX use the same IP than MPFS, therefore add compatibility with
> MPFS as fallback
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> ---
>  Documentation/devicetree/bindings/cache/sifive,ccache0.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml =
b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> index 7e8cebe21584..9d064feb2ab1 100644
> --- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> +++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> @@ -47,6 +47,11 @@ properties:
>            - const: microchip,mpfs-ccache
>            - const: sifive,fu540-c000-ccache
>            - const: cache
> +      - items:
> +          - const: microchip,pic64gx-ccache
> +          - const: microchip,mpfs-ccache
> +          - const: sifive,fu540-c000-ccache
> +          - const: cache
> =20
>    cache-block-size:
>      const: 64
> @@ -93,6 +98,7 @@ allOf:
>                - starfive,jh7100-ccache
>                - starfive,jh7110-ccache
>                - microchip,mpfs-ccache
> +              - microchip,pic64gx-ccache

Is this required? Shouldn't the fallback activate it?

> =20
>      then:
>        properties:
> --=20
> 2.30.2
>=20

--cuCIrOF2wBq4Nn+p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqr1wAKCRB4tDGHoIJi
0ieYAP4l09p3b+zq6wwEW+eJRsKgHwmoFiyLk7Qy4SxEFLq3IAD/TdV7wnajZ/7Y
s49CAKjLjWev5IgQkHS698tDluAONAU=
=oUfe
-----END PGP SIGNATURE-----

--cuCIrOF2wBq4Nn+p--

