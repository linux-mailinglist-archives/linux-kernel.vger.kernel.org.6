Return-Path: <linux-kernel+bounces-344172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74D598A5C9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890DC28251D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95818FDCE;
	Mon, 30 Sep 2024 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqvwUj9v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C718E02A;
	Mon, 30 Sep 2024 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704053; cv=none; b=MSPoJppyPRK529m3zCWfZyhHSn0c0d8yuULk7Avgqh2lxy+i35VkNYcAYqXFAAXA50gS6NSlchxKJrVc0vqc1phJ35tKFsaNMZInkCPSOcQzvATWwcIpyak/Rn/cGX5Mp4AJJ67or8Mgu4GnHu0a6g5UkGGqxRUpAk1d7bxh5iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704053; c=relaxed/simple;
	bh=b71U8gGO5CeeJLzH8fxt8y1xLe5F5T9LsFaZJ/y1igY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRfLnSD90Z49YylLjHExf7pQ2n2s1dJ97f3YKLFmqoqkfppt7yU+hGRjtJEuu0U6thYT6Z1JnMpT1mNj3UqTxBkr+KbeSv6yFmx11dkzimnkYBpO9qoIvOYTF1pQuKQCg3LHNSOmP0rXqh7ctVD3MVu5anFjTl6MX8pRGxLV6I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqvwUj9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A02AC4CEC7;
	Mon, 30 Sep 2024 13:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704051;
	bh=b71U8gGO5CeeJLzH8fxt8y1xLe5F5T9LsFaZJ/y1igY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IqvwUj9v7tMZrw9J7Q4xfkWoz6YU/RBjCoEEpimdVteecYcF0FhkmWrIjN/muaO5L
	 g6LpsVSL9lpDvWZ3HTaJnxsvHSbForNW3xQ3Nx0DbbZ2oNAVMryF71UXB2e7p6Yn1j
	 W2OE55trNd1EWTJ4x456+kx5/wN+nuiGZ2PR08IfSKrFsu9YgeqKGDxIiFUQY1BU0j
	 bzcZavxQ9qb/NEE7NO8AUrpd9YKqY+XhkWXrRvMF6g8idSM637X7LmWto19hw36MBR
	 diu1DoweoLjiO9XLoxWMtI+e2Xrss5g9i7o2F3JXG2HDI1nim3/Hxb+RCyDNBZGpUQ
	 WkJkfVYzbw/Kg==
Date: Mon, 30 Sep 2024 14:47:27 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 07/20] dt-bindings: clock: mpfs-ccc: Add
 PIC64GX compatibility
Message-ID: <20240930-siesta-dandy-cb83076f68f2@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-8-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WZasyoaWaR6SUx82"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-8-pierre-henry.moussay@microchip.com>


--WZasyoaWaR6SUx82
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:36AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX SoC Clock Conditioning Circuitry is compatibles
> with the Polarfire SoC
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> =20
>    reg:
>      items:
> --=20
> 2.30.2
>=20
>=20

--WZasyoaWaR6SUx82
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqr7wAKCRB4tDGHoIJi
0g+YAQC2pAyyoANnVvonXgOAp+seHCS5qLMcnRgDuwtA+N6p1wEAlsGBNaSU8FMY
snCwQ2cdghqeMYQDlLX3qxhh9yCuIwM=
=ukWt
-----END PGP SIGNATURE-----

--WZasyoaWaR6SUx82--

