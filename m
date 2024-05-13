Return-Path: <linux-kernel+bounces-177822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E062A8C4501
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0641C235AC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E542915534F;
	Mon, 13 May 2024 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSuogmHR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA314D2BF;
	Mon, 13 May 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617379; cv=none; b=azwCh2nESL2gmfy4BvgEsiqCEafnWGJhMxGTq+6mmmwmSjzKq5ehom1etCDLfyfsZHPqMozDWuHwBFLGW+v7EC800S/7QdxUfXARox02VMnrUKxN+T93fTCp64rHAAVUEYbGg0h0do+6erEuwW0lSssq2D0DGX4jjjpqn75yp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617379; c=relaxed/simple;
	bh=N2ATGd7KlEQx4kG5H+XRfUmL8uzdKU8CWZcVR4j/D6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bmuc3k4xzBg2yFl98zP3+P3X+G3Nye9y4yu0yS8HcxqSquoncPsU9bh0sdZy6/Lk40s8gBjolfqFKgbnwZrzxe3RrA4obxAXSJF8LwZvgKMQVWDH3TANAge3ndXur19YD+GQr2IK+j3ZJeuFlV0kP0L7DSkms67BMV2h0jG0z64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSuogmHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5479C113CC;
	Mon, 13 May 2024 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715617378;
	bh=N2ATGd7KlEQx4kG5H+XRfUmL8uzdKU8CWZcVR4j/D6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSuogmHR4dnns/0HOj3omiIm8ZdqXO1qtQ/dZSU9ruI15Mx/CYiFcHWlChYkhBzfc
	 hwd65xyvkBsO23iRMRAaiI+UP38hExb3xmvACAbl/9eREniNiq47jN7SJRHXko4Uoo
	 rP5fAiHJeJsZqI2cjc7+fhsQKJuv80JBy0jeb5hzKXD88Djc+NwvTUOI84AjuWktCI
	 pwRq1uKCqbHAuLh5cT3H8fA7eF/r5nHm+Wf7INM5pdQf77xapIFQqFywP2j+9/0cqu
	 xtgL0tp9ywA2jEC7SQ2qBfT2Ne26/7D1wVRff+glJE/eMyaudWaR2+0rc/nD/xKjtA
	 9rFcC2XOgUlCw==
Date: Mon, 13 May 2024 17:22:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	johnny_lai@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v3 6/6] regulator: dt-bindings: rtq2208: Add property to
 get ldo of RTQ2208 is adjustable or not
Message-ID: <20240513-tissue-repave-13d2e3bf88fd@spud>
References: <cover.1715340537.git.alina_yu@richtek.com>
 <6a3a90d9aa2022dfb92e124e417f3e72c2f28b0b.1715340537.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0Rzf6EampsUN2LBy"
Content-Disposition: inline
In-Reply-To: <6a3a90d9aa2022dfb92e124e417f3e72c2f28b0b.1715340537.git.alina_yu@richtek.com>


--0Rzf6EampsUN2LBy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 08:06:25PM +0800, Alina Yu wrote:
> Since there is no way to check is ldo is adjustable or not.
> As discussing in v2 series, 'richtek,fixed-microvolt' is added for that.
> user is supposed to know whether vout of ldo is adjustable.
>=20
> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> ---
>  Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml | 8 +++=
+++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.=
yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
> index 609c066..6212f44 100644
> --- a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
> @@ -75,6 +75,13 @@ properties:
>          description:
>            regulator description for ldo[1-2].
> =20
> +        properties:
> +          richtek,fixed-microvolt:
> +            description: |
> +              If it exists, the voltage is unadjustable.
> +              There is no risk-free method for software to determine whe=
ther the ldo vout is fixed or not.
> +              Therefore, it can only be done in this way.
> +
>  required:
>    - compatible
>    - reg
> @@ -177,6 +184,7 @@ examples:
>              };
>            };
>            ldo1 {

> +            richtek,fixed-microvolt =3D <1200000>;
>              regulator-min-microvolt =3D <1200000>;
>              regulator-max-microvolt =3D <1200000>;

I'm dumb and this example seemed odd to me. Can you explain to me why
it is not sufficient to set min-microvolt =3D=3D max-microvolt to achieve
the same thing?

Cheers,
Conor.

--0Rzf6EampsUN2LBy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkI+XgAKCRB4tDGHoIJi
0teoAP0deskjwTQhQkwFkOEF3YwHdE/UPQPpoXblTyQcsq2YKAD+JWsBhF6E1eTE
vJixXEaTaIbjTD3RYNjy9OvMwTWmWwY=
=GwZ0
-----END PGP SIGNATURE-----

--0Rzf6EampsUN2LBy--

