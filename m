Return-Path: <linux-kernel+bounces-511766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C12FA32F62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DED518875C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28812627FE;
	Wed, 12 Feb 2025 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc3EGtFJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC82505B3;
	Wed, 12 Feb 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387676; cv=none; b=QBc16hEfAYXtNFf84OxFAemnX/r0kqU9rjtL/hrUtci38oOEZ1/CCgK+WflQD7jf6s367MVq6fUipw51oy/9CU4Jl3jnog6J2X9YsMFu0F5gBi/h0ptli28d5mopZ4CspU+1GL/jHnVH9LZVUVW+BPgYKnXBtsRVLkgVUB8wq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387676; c=relaxed/simple;
	bh=mmXa4CSLqs9OFL2IL4tC3NZkiKo2CpyEZ1OGJE22XGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uShZ+ivzXKLUyTp28rI9OIrNJ7W7eDYVh8z+amu0mxwGjh6FnIE4haPMN9Wf1lkcs7BkaKHCZuZTbQI/w2jvTCK2sNZdlaXvUZQ8BNQoyHu2P/WrwGdsb8o0WzsKqDBGVZ07ZOQgJ6AlGu673NjdDZRN7n9RXHGY+083KC1zUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc3EGtFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7077FC4CEDF;
	Wed, 12 Feb 2025 19:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739387674;
	bh=mmXa4CSLqs9OFL2IL4tC3NZkiKo2CpyEZ1OGJE22XGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nc3EGtFJkIVzlt6VS0rDMB7lrWbePGEGz6bNMMQjVVDdEOltHQNeLRM6T1xxYCl6g
	 KWC6MtbBFtLzxL506xs0kTCYOpnZlBjV9pwwXIGtqI7YHBWjUoZa8J8nVWc0dQPlVj
	 y1wi3zx3p7kaX6ryv1QbfSBkkWlTDaky2V1vuhJcYA7vw+jrfnJzRd5AT3zQcd+hua
	 6eTuR4O6GwGnByKuQgzIiSmW5mIaA2mjBhLllphMq1REc1moGo0bmDqSACFKoNl1q9
	 Td1/Yygdsc5toBSImNqV0HTl5izJAa+LxOZzLfLZUL4DVGlA7Whjg+fA9yivSKJAZJ
	 5Yci1aN5p0YEw==
Date: Wed, 12 Feb 2025 19:14:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, festevam@gmail.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH next v2 1/3] dt-bindings: usb: microchip,usb2514: add
 support for vdda
Message-ID: <20250212-dullness-wreath-8d934b09576f@spud>
References: <20250212135649.3431570-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iw1sCEGjCNgsc9hl"
Content-Disposition: inline
In-Reply-To: <20250212135649.3431570-1-catalin.popescu@leica-geosystems.com>


--iw1sCEGjCNgsc9hl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 02:56:47PM +0100, Catalin Popescu wrote:
> Microchip hub USB2514 has one 3V3 digital power supply and one 3V3
> analog power supply. Add support for analog power supply vdda.
>=20
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
> v2:
> - merge "if" with "allOf" and move the whole after patternProperties
>   section
> ---
>  .../bindings/usb/microchip,usb2514.yaml       | 21 ++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml=
 b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> index b14e6f37b298..aeffdf0362c2 100644
> --- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> @@ -9,9 +9,6 @@ title: Microchip USB2514 Hub Controller
>  maintainers:
>    - Fabio Estevam <festevam@gmail.com>
> =20
> -allOf:
> -  - $ref: usb-device.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -28,6 +25,9 @@ properties:
>    vdd-supply:
>      description: 3.3V power supply.
> =20
> +  vdda-supply:
> +    description: 3.3V analog power supply.
> +
>    clocks:
>      description: External 24MHz clock connected to the CLKIN pin.
>      maxItems: 1
> @@ -43,6 +43,20 @@ patternProperties:
>      $ref: /schemas/usb/usb-device.yaml
>      additionalProperties: true
> =20
> +allOf:
> +  - $ref: usb-device.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: usb424,2514
> +    then:
> +      properties:
> +        vdda-supply: true
> +    else:
> +      properties:
> +        vdda-supply: false

Hmm, the then: here isn't needed, you can just invert the original if
with a "not:". Sorry for not noticing that last time.

--iw1sCEGjCNgsc9hl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6zzFgAKCRB4tDGHoIJi
0tx3AQCYwlidnU+dpYKm2CS9UgBGpqPUz+cfsEHZNbYm62SWmgEArgcsb+i0xZ9l
14Bhc9qVma3uZu7iEZUxiH1+xAczpwU=
=utub
-----END PGP SIGNATURE-----

--iw1sCEGjCNgsc9hl--

