Return-Path: <linux-kernel+bounces-252799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276B093183A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FB2282C77
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521F51C6A3;
	Mon, 15 Jul 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AExAI/Pt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8FD17C67;
	Mon, 15 Jul 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059852; cv=none; b=RuEe+JkVDQkmR78bUO2mBdFwRaV9VbXZ2WH886Xc+nLqJiwfJJ7oHCv4Dzyjrh6B6Rgd0MeC3E8vrb1xPmbCbPcEXmOlFQTzUrHGdWvv4Ljjz4IPon/Xtxj7iLZ7d+XWJBzBbojza8EPNfKcmwnpRPm6Xj/Mv3m/6hRvHSkTpXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059852; c=relaxed/simple;
	bh=PAt/9RGpGz5K/aBEqlPzaGzWnvBVjbcdM/9lPF7RxC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRlzXwcipFnVkGclDj3zXZNw1qzoaBkRIRNIDgpb5XgDV056+HEPNsk29isyiBxV6qQlmkZcsggKyh2Qzdwl0cU7XDyBChSRBzVtPnqe6O4c9ts3800mjM5BI9j/8Ch6AW6OpFTBYgA8UxF4FtWIxSeQGtni7njfarNg0SapSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AExAI/Pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7987C32782;
	Mon, 15 Jul 2024 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721059852;
	bh=PAt/9RGpGz5K/aBEqlPzaGzWnvBVjbcdM/9lPF7RxC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AExAI/PtfzbH4lbUzmoVjy0AU2GYM2r1404RPLKoEC5mPRh9jid8V7JQUUI2hoxkM
	 Ia6ddKvr0D/1cV10wLLRzctyqxaiiUIdoaNQP83NcphzbPklIBE90UmyrNNWltgzlN
	 nfB8+hdryeYovM8egb0Mcb+Hye0DK1KbFGd4uy4FugVEaAQ6RxEAmJP55nYgKTf+W9
	 9otnzy8AbpaScv6WUCnSEKANE4AbqeadWUVbjgpkFUnDeC1TunFmP1oZOnd7oCS+fS
	 ac/+LbBL3DWgVQ5x6tXBzyMG/ERm0CUjjdaHnnTOLulneGFvNzCWaMj8qErEIQoe0Z
	 jK75/9WsvmwGg==
Date: Mon, 15 Jul 2024 17:10:47 +0100
From: Conor Dooley <conor@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: arm: amlogic: meson-gx-ao-secure:
 support more SoCs.
Message-ID: <20240715-override-blustery-e6763fddf3c4@spud>
References: <20240715-soc_info-v2-0-3836c8cc27a5@amlogic.com>
 <20240715-soc_info-v2-1-3836c8cc27a5@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2RXs66YUzlqAnmaH"
Content-Disposition: inline
In-Reply-To: <20240715-soc_info-v2-1-3836c8cc27a5@amlogic.com>


--2RXs66YUzlqAnmaH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 04:59:19PM +0800, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>=20
> Add dt-binding document for ao-secure of Amlogic SoCs(S4,C3,T7,A4).

That's not really accurate - no document is added here.
Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

cheers,
Conor.

>=20
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml | 16 ++++++++++=
++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-=
gx-ao-secure.yaml b/Documentation/devicetree/bindings/arm/amlogic/amlogic,m=
eson-gx-ao-secure.yaml
> index 7dff32f373cb..b4f6695a6015 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-s=
ecure.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-s=
ecure.yaml
> @@ -25,10 +25,18 @@ select:
> =20
>  properties:
>    compatible:
> -    items:
> -      - const: amlogic,meson-gx-ao-secure
> -      - const: syscon
> -
> +    oneOf:
> +      - items:
> +          - const: amlogic,meson-gx-ao-secure
> +          - const: syscon
> +      - items:
> +          - enum:
> +              - amlogic,a4-ao-secure
> +              - amlogic,c3-ao-secure
> +              - amlogic,s4-ao-secure
> +              - amlogic,t7-ao-secure
> +          - const: amlogic,meson-gx-ao-secure
> +          - const: syscon
>    reg:
>      maxItems: 1
> =20
>=20
> --=20
> 2.37.1
>=20
>=20

--2RXs66YUzlqAnmaH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpVKBwAKCRB4tDGHoIJi
0uO/AP962MqOigrXH0P1+IKy+IgUZlDyAU/Muhh+aiiFTfnLUAEApruA3hfW1ktM
vBVcabNKjmHd1AIJnBXisYtn45QqJQU=
=KCrM
-----END PGP SIGNATURE-----

--2RXs66YUzlqAnmaH--

