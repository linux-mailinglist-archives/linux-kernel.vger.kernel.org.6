Return-Path: <linux-kernel+bounces-374204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EED9A66C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00FA728262F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03FF1E7C05;
	Mon, 21 Oct 2024 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5vzXI40"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178521D221A;
	Mon, 21 Oct 2024 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510775; cv=none; b=d7MSpvUARfspp5bSKJxyTr5RMr7VVIymvkqqYcE1iAQL7Z6XXFuUE6CdnlGWTqigGYidoVAzyVvVQKF7cjI0ffvUeDr6iOTNE2Rn6ydZtgBL1HI/D/zjghjWpLVbujBL+XIERtWKJFOTwPQOeOYTpPFo7DsSKCJtlqvUpFOuksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510775; c=relaxed/simple;
	bh=1Jme4gIIz82rExq3mwSUQkm+RToEqsxpUietgBS2oSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Anim+0wO9X+/BAZQOXODGSkVUK6xxEQbwv6cN+x0E1Ep9Yy+kgB/JWC4JZJQE1tkybvBbKPKDxTx6w6Nu/buKQoP4JUrDKuRMOkvquVnBlf6F5OytWPAzpFLpEmcYZ7RMuCvt9SHuSRjCMpm2B5uhPduGYVWx7cQe/3QeWSP7zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5vzXI40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560E2C4CEC7;
	Mon, 21 Oct 2024 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729510774;
	bh=1Jme4gIIz82rExq3mwSUQkm+RToEqsxpUietgBS2oSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5vzXI40PqiO/ZlFy4X+1+z1D1NpWRCf1cif1g1uQm2wDrhFuMsfqSSF/ZFbgzIiw
	 R5fD+hUD9cSB7EExwMayiYPSr+eIhwNRwT+eNZAPjRLiWgaTRpYfMlzP1To24tsYJs
	 BNqelR2yVFX3CVc9CHWzAvjOv2bLtC2pee4l0VOUzcesZZ4TO6TuYSU9Se3mfXIqMP
	 E+2ledUt4tXX4B1S1ZRSjjJGsbtUIAEVR/5jifJvH4KxZL3k2viKdXXLt8/jDRzKt9
	 GXbQCiG0VY6cN9f2xjNcS2xbHFrww97RMYBFDc7uYiMefUQUIFjqQMydoC2Kzz8fmF
	 37Vq06CEigB6w==
Date: Mon, 21 Oct 2024 12:39:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] dt-bindings: soc: bcm: Convert to Dt schema
Message-ID: <20241021-exposable-seventh-baed2b1442b6@spud>
References: <20241019-raspberrypi-bcm2835-power-v1-1-75e924dc3745@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jsNLbNMoOQF7+2+I"
Content-Disposition: inline
In-Reply-To: <20241019-raspberrypi-bcm2835-power-v1-1-75e924dc3745@gmail.com>


--jsNLbNMoOQF7+2+I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 19, 2024 at 07:51:18PM +0000, Karan Sanghavi wrote:

$subject: dt-bindings: soc: bcm: Convert to Dt schema

That's not specific enough about what binding you're converting here.

> +maintainers:
> +  - Karan Sanghavi <karansanghvi98@gmail.com>

Why not the maintainer of the original binding?

> +
> +description: |

The | here serves no purpose, as you have no formatting to preserve.

> +  The Raspberry Pi power domain driver manages power for various subsystems
> +  in the Raspberry Pi BCM2835 SoC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - raspberrypi,bcm2835-power
> +
> +  firmware:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - firmware
> +  - "#power-domain-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/power/raspberrypi-power.h>

What do you use from this header?

> +    power: power {

The label here should be removed, it is never referenced.

Cheers,
Conor.

--jsNLbNMoOQF7+2+I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxY9cAAKCRB4tDGHoIJi
0uWBAQDqyXsS9xBwhJafkY9nPgRKoBLTT3Or7JFqALzIN6u6lQD9Fo2HSsTrqOx3
T3mii/cTYz5+jrAlsyvSCkV4PdqMoAA=
=Kua4
-----END PGP SIGNATURE-----

--jsNLbNMoOQF7+2+I--

