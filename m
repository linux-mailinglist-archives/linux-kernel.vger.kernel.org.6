Return-Path: <linux-kernel+bounces-222944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C1E910A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A4C1C2300D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B951B142F;
	Thu, 20 Jun 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPFujK9I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8771B140F;
	Thu, 20 Jun 2024 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898266; cv=none; b=Yv8skiqCPm2YdynAKAIiynEv2j07NBk++wOwcBFHBwy569t51+RW6ibsJiQvUbW7h9EWBUVv+pSy6WMj8VZ/j+WuxZeRcNI04DItzv5I5IIdZ3vlXNlX1j9GC6bwwDHf03sYb/928AG4JbEGBe4fwSqly3qwV17TTx9/Y+xZl60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898266; c=relaxed/simple;
	bh=q6p3XaUo/fxgIa/+WdJqQs77HQjNFVXrGZIYtw1+2SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFA+hlXGOo7PJUMq0//hqnwTagdYD52J5tmryhb7Ke6teiUgmWblPcilLT7URXwvIh+FbS69gln/ZGPl2SqbHeqIH+pJRR3385kphOkCpY5M0Da2iAYdK0F1pWlXGm5VoZwP2M1vnJy+w6td3B+RT3X1LR4jJlG/oddl6XTBiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPFujK9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C0FC32786;
	Thu, 20 Jun 2024 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718898266;
	bh=q6p3XaUo/fxgIa/+WdJqQs77HQjNFVXrGZIYtw1+2SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPFujK9IVfyVtQL4PsoQzZIrmXvDSgYB8PKJ5+Gv9Kj5lT7tUOsMzCZ/upqvLcsFM
	 RXeqQHUon9YzA8v9nBGsWHQIME9BGL/4kGW/u/0XyiwbfNhN7xOh7zq47byjMrdoZk
	 iaKarbich29RRlncEK5d8s+3641aiBB2kjZXWjlGSGdGF9lck4EcRTkItDvAnTnTDA
	 4uc4vbEeTZTv5G3OYn7dMHg3HYNIdqMcXg4Ft9CLPdpdi7aI9do1tbxtI44ClgJelx
	 8K46N5Y5ZjVPue3XcV2jlcT4Iy6d9ssWKeHINVV1te16lEIE+XfoP1SsOsvzCmT1tY
	 c9xfL8WUQdBlw==
Date: Thu, 20 Jun 2024 16:44:21 +0100
From: Conor Dooley <conor@kernel.org>
To: iansdannapel@gmail.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko.stuebner@cherry.de, neil.armstrong@linaro.org,
	macromorgan@hotmail.com, sre@kernel.org, hvilleneuve@dimonoff.com,
	andre.przywara@arm.com, michael.riesch@wolfvision.net,
	linus.walleij@linaro.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: vendor-prefix: Add prefix for Efinix,
 Inc.
Message-ID: <20240620-barber-trickle-0a98341c9e01@spud>
References: <20240620144708.125497-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZRkpeeRhcuMxIsh0"
Content-Disposition: inline
In-Reply-To: <20240620144708.125497-1-iansdannapel@gmail.com>


--ZRkpeeRhcuMxIsh0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 04:47:08PM +0200, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
>=20
> Add entry for Efinix, Inc. (https://www.efinixinc.com/)
>=20
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>

This is a 3/3 patch is but is unthreaded with no user visible on lore:
https://lore.kernel.org/all/20240620144708.125497-1-iansdannapel@gmail.com/

What's gone wrong here?

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index fbf47f0bacf1..8e9dc26b2a79 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -422,6 +422,8 @@ patternProperties:
>      description: Emtop Embedded Solutions
>    "^eeti,.*":
>      description: eGalax_eMPIA Technology Inc
> +  "^efnx,.*":
> +    description: Efinix, Inc.
>    "^einfochips,.*":
>      description: Einfochips
>    "^eink,.*":
> --=20
> 2.34.1
>=20

--ZRkpeeRhcuMxIsh0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnROVQAKCRB4tDGHoIJi
0vmZAQC394zwUxjJcF36HC21Cb5DRWqXVT41rEEPmdNSO0UrMQEAkaSkNanC9xID
dEzrarJqdtr7DXOLFLqih+jC1z6fagI=
=W6nU
-----END PGP SIGNATURE-----

--ZRkpeeRhcuMxIsh0--

