Return-Path: <linux-kernel+bounces-423692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544079DAB83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F64B21E82
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3E1200BA2;
	Wed, 27 Nov 2024 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yzy7GJrB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91A0200B8B;
	Wed, 27 Nov 2024 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724075; cv=none; b=PXPSu2Lick5gb1+XgoAn5OMamE7Mqkkj+GXRQAh/zM60s+5FwViqCSjSZowFWpOGHrsB7jLd6+JGWgQhrhMmBie6KraKL1t4RzZsSxLc/r6glmepWfw3Py8NtTkeQfEMZJe9PfACRZRhGTIU5J4N7+OEYqhWp+hR/BfcfQzyOkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724075; c=relaxed/simple;
	bh=t/t+qxjEE72ckgaetIew3I8k7tV0KGgHqs4PPn6lneU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XItcoaryFH4hZ42pwElRWWl1p46Mj0JwrPSNMujSrbpeOw0OvFBYPsF/vwP641nW5RHC9HvqGQNWVYlsOt1zS0lSwK1Jk0N05vGmVbfxm8Qb30trMLxch0cZXJev3g1bTGwsa59kV8rWcIOK7cPksPt2o2aYnKgABI1wQQ32tKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yzy7GJrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1F2C4CECC;
	Wed, 27 Nov 2024 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724075;
	bh=t/t+qxjEE72ckgaetIew3I8k7tV0KGgHqs4PPn6lneU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yzy7GJrBd/e3ed1KEIowTju/iUvh/T9yE4tGSE0foVfkz5XPzXIOav9a3ecTJoRt5
	 moLU8F3FSksk54D/GR/HMeNLeuUuKh3NiYt2bnkveJbvFmKh0fRGHABUGUbsZ9FriC
	 ZTUUjasE8OBdmpR7GkUMGtwjrFU+3VOiB+UijToRHYzP/qVaWiQoI22LUiD2adoIUe
	 6ANGhB0IE2OfxqeDIOQbHvGef7jPGS8zPibk4MFBmqNmk215695V7uGLXiUPItOMIv
	 EfDTid/dN/dhSFUnjvKfQh9oCGv4ZQsc6tA/55cUwZw/kBHf8zQju+TwCHdhHSgtVg
	 GCogrBmNZzflQ==
Date: Wed, 27 Nov 2024 16:14:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Jason Hsu <jasonhell19@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, patrick@stwcx.xyz,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yang.chen@quantatw.com, jerry.lin@quantatw.com
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Message-ID: <20241127-resupply-tanned-1410c026f127@spud>
References: <20241127073409.147714-1-jason-hsu@quantatw.com>
 <20241127073409.147714-2-jason-hsu@quantatw.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jmHGxiniHzsUH9Y8"
Content-Disposition: inline
In-Reply-To: <20241127073409.147714-2-jason-hsu@quantatw.com>


--jmHGxiniHzsUH9Y8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 03:34:08PM +0800, Jason Hsu wrote:
> From: Jason-Hsu <jasonhell19@gmail.com>
>=20
> Document the new compatibles used on Meta Ventura.
> Add subject prefix for the patch.
>=20
> Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>

I acked this on v1:
https://lore.kernel.org/all/20241022-purgatory-modify-fdcc5f1cff23@spud/

Where did that ack go?

> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 2f92b8ab08fa..98ea2b3e0eb1 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -86,6 +86,7 @@ properties:
>                - facebook,greatlakes-bmc
>                - facebook,harma-bmc
>                - facebook,minerva-cmc
> +              - facebook,ventura-rmc
>                - facebook,yosemite4-bmc
>                - ibm,blueridge-bmc
>                - ibm,everest-bmc
> --=20
> 2.34.1
>=20

--jmHGxiniHzsUH9Y8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0dFZgAKCRB4tDGHoIJi
0mIfAQCayJEyg/gpu7kW1AsnuurZqhAYXJ0x4zKzE2K1FAFASQD7BAOqyd6ui9uH
b6YBGxhPSq91ve2zVGXLlpN06U7rIAY=
=Gnpn
-----END PGP SIGNATURE-----

--jmHGxiniHzsUH9Y8--

