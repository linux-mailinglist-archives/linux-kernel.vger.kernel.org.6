Return-Path: <linux-kernel+bounces-411179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5B19CF42A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22020287CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2AC1E131B;
	Fri, 15 Nov 2024 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0MvTbo2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876F818871E;
	Fri, 15 Nov 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696125; cv=none; b=hbnkEzImocqKfSAd3L7tLGnBLZlJwdw+vfu+6HeOivjI3aSLX56F+DqZWEmqHSdxwoRjEG334LPnx3UhWLTQhViQny32LuToMSx5+hxBRzlOv3nR3mlrYryc+ESYqKm+MxMvD5TwhZwu18pYfsxGISQw59K586+q4jayvlu34ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696125; c=relaxed/simple;
	bh=++IZNTbl4zJf0IyHA20ua0rUxj1vHDqoB8EyTTHY6Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXjTR1syWtQo+VkksK+2d/UjHn0M88hceZsyvEigi9pm6KvElU7kP0U44/d1Mc9znlSW7mmilq9AnFUzioZQy0mCMJaXKC5xre8jCa8fK9EzgEZQm1+l/yGGsD1HAhg8+WDIYz9v77OmkcqHXn8fB1Uvhvqia1MVIfFPitu9b78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0MvTbo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145AFC4CECF;
	Fri, 15 Nov 2024 18:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731696125;
	bh=++IZNTbl4zJf0IyHA20ua0rUxj1vHDqoB8EyTTHY6Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0MvTbo2ThWXIgKEM3fv0n8jlzKDtXZVT/g36UWKTTgqT7qAdj/ByqX/GZJdKnXA0
	 5I0KKobt6742/EBpOyD/6351zeyuNN582vXpZujMRVUP1jPWhh0XW1fZSWiBvhQD2L
	 ZGSxejrZIoVW5xrBukSvfx3jOqNS3XoZbjJqdNcQeB8m4qHD1YW3waUtFXfrSl6aR2
	 dcibMee1WV7lNCR86SN6ut7ffIDcb8WKrvS7IhIZNIJIP1gSj8HEqUsm1gEpDId2eK
	 VQ3KoSoec0EWUqOdk2r8SKFD7Y6I6riIYF2chEV+TB/W3yWAMwsELF4+rg1X6+uuoQ
	 EVVf7TsSFXtog==
Date: Fri, 15 Nov 2024 18:42:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Karol Przybylski <karprzy7@gmail.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, andreas@kemnade.info,
	rogerq@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] dt-bindings: mfd: omap-usb-tll: convert to YAML
Message-ID: <20241115-document-skirt-1b12ae3af541@spud>
References: <20241114185830.10025-1-karprzy7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4NKNFzJwDjBr1PW/"
Content-Disposition: inline
In-Reply-To: <20241114185830.10025-1-karprzy7@gmail.com>


--4NKNFzJwDjBr1PW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 07:58:30PM +0100, Karol Przybylski wrote:
> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml b/Do=
cumentation/devicetree/bindings/mfd/omap-usb-tll.yaml
> new file mode 100644
> index 000000000000..f49417d1faf7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/omap-usb-tll.yaml#

ti,usbhs-tll.yaml as the filename please.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OMAP HS USB Host TLL (Transceiver-Less Interface)
> +
> +maintainers:
> +  - <maintainer@kernel.org>

Put whoever the original author of the binding was here, failing that
probably the platform maintainers for omap.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,usbhs-tll
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,hwmod:

Pretty sure you need a type here:
    $ref: /schemas/types.yaml#/definitions/string

> +    const: usb_tll_hs
> +
> +  clocks:
> +    minItems: 2

Please add an items list here for each clock with a description.

Where did the minItems: 2 come from? The text binding suggests that 1
would be valid.


Cheers,
Conor.

> +
> +  clock-names:
> +    items:
> +      - const: usb_tll_hs_usb_ch0_clk
> +      - const: usb_tll_hs_usb_ch1_clk
> +      - const: usb_tll_hs_usb_ch2_clk
> +    minItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ti,hwmod
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usbhstll@4a062000 {
> +      compatible =3D "ti,usbhs-tll";
> +      reg =3D <0x4a062000 0x1000>;
> +      interrupts =3D <78>;
> +      ti,hwmod =3D "usb_tll_hs";
> +    };
> --=20
> 2.34.1
>=20

--4NKNFzJwDjBr1PW/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzeV+AAKCRB4tDGHoIJi
0svQAQDXLOBNlVg9oP82qZqMc2ModrcXsVv4yWOYyRhGUw4LpwEAxWbfhhG1Tb66
gPq2W0d+4Qvw6JEt+sfSmTABGbiN7QU=
=LiRY
-----END PGP SIGNATURE-----

--4NKNFzJwDjBr1PW/--

