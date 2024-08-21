Return-Path: <linux-kernel+bounces-295717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816BE95A080
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B7D1F22B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1151B2526;
	Wed, 21 Aug 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAmP7+2T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F7F1D12EB;
	Wed, 21 Aug 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252163; cv=none; b=o7PTw1sLj4iiI/uLfBomICwznRfBzEJ9JL8wnYBByRP7Shsv4aIeq8o9PpbeUQA7UQhgrN8KoXMr213dtnURieYfVuOU4QSHTwvQFefsfOu8u3xHidq2h6fy0xHrLr29AyN8uEP6pTEhgcGMjN4LS7g4U+DX0Tx3ZpScRLplVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252163; c=relaxed/simple;
	bh=Y052opyD6L5wdxXdHKcCFMjjqWMg/ewI0fExlR8qZWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjvlzEMeqQMkvSzJhZbKuO0+2uRRLk/p3Gy4KYOyXG08W4hB9S1RYUrxE5g3v3V4OBO6B5Olood0r0f8MOAcpd6+T4qZEnnmXsZsWAhVv3hwJS+I5WKID5VvCduwr2cvZheecy8LppI6yT0RzpwOQOYnjNXrhr0NuJGu0OCFBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAmP7+2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A26C32786;
	Wed, 21 Aug 2024 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252163;
	bh=Y052opyD6L5wdxXdHKcCFMjjqWMg/ewI0fExlR8qZWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAmP7+2TrnIkeytkb3/lP+k5d8T8YkDXZAy/8fPCdrNOG+JPT8EGH3yZ4TH+oaJ1Y
	 tiO1dR/pTGXoGTTQ1Rhl90HuA70Emdsx5lf7rnvsJqfs4ScQ7sNOIdLvNCuFDZesPz
	 Cj9McGxNhtRD3n4NhBJAj/M+g/rOM4sxu4ALQ9gu0ib0TQNIxU0j9bqRxu366ARZCR
	 2UKXlBRUU5qWK9y2aOxdOmFzt3e/woj9K3KJm82RH/j/o0mK3wT+CFGPSmzYcGpSt+
	 UZD2HxvuAIwvyO7OfddAtYf+coF5QVcFYYoMdMQRLfdJSGRqZbij/xqVFhp0/pHPbH
	 QsNZ6dpSapCOQ==
Date: Wed, 21 Aug 2024 15:55:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexander Dahl <ada@thorsis.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:MICROCHIP OTPC DRIVER" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 03/12] dt-bindings: nvmem: microchip-otpc: Add
 compatible for SAM9X60
Message-ID: <20240821-undertake-recovery-bc05779e60e2@spud>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-4-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zztae3tCmolu/aRS"
Content-Disposition: inline
In-Reply-To: <20240821105943.230281-4-ada@thorsis.com>


--Zztae3tCmolu/aRS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 12:59:34PM +0200, Alexander Dahl wrote:
> The SAM9X60 SoC family has a similar OTPC to the SAMA7G5 family.
>=20
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  .../devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml        | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-ot=
pc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.ya=
ml
> index cc25f2927682..d98b6711bdfd 100644
> --- a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
> @@ -21,6 +21,7 @@ allOf:
>  properties:
>    compatible:
>      items:
> +      - const: microchip,sam9x60-otpc
>        - const: microchip,sama7g5-otpc
>        - const: syscon

As Rob's bot pointed out, this breaks the existing devicetrees. If you
want a fallback to the sama7g5, then you will need to add a new items
list here, alongside the existing one.

Cheers,
Conor.

> =20
> --=20
> 2.39.2
>=20

--Zztae3tCmolu/aRS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsX//wAKCRB4tDGHoIJi
0sB+AP9xRa6mUx3ab/CdDEKKF3lgCLmeq0kaIYV/ciVX2Fr0mwEAiWhYuDt0IltF
WI54qwF+iWElCDgJhiwDk6xc5mDAzwg=
=tRm/
-----END PGP SIGNATURE-----

--Zztae3tCmolu/aRS--

