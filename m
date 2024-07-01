Return-Path: <linux-kernel+bounces-236507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AC091E32C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0571F226C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C516C853;
	Mon,  1 Jul 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKP31U3P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B116B739;
	Mon,  1 Jul 2024 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846188; cv=none; b=ATgLHi3L5HfkKDAz3FMKl3PkX1MJQHrOE7Vp5K1dMeWlpNWcEDy6XE75ie/ly8Q4dWJiXFC4Vq1eJpQFw33k5Semt+KYNLg5bf7E8NxkSm8szd/Oj5q4vXwqwCAmR8syRxaYH2mkiCRknevC8hrAJazHixsYd4gv118fptkua7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846188; c=relaxed/simple;
	bh=9zEnVq1vKf8ZCB+ZTWMUuZ5XV/zSomvjrV9gFojPVhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/kV0JCdqmBZkyzJ489qmlrzIIyyBDFq1UVaNs3R53EeE9DoLkq/N+74FCA3p3nNhPTeoG5/gj+BsVHAFvArRqX7Y0jzYfHm0e5aW4KT148qTt57P+3Sz8OitISeB+jyEB5bZL/xi4ZBlz+KZcbFq7lbcuQqUzs2/dr8+gWcjYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKP31U3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA9EC116B1;
	Mon,  1 Jul 2024 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719846188;
	bh=9zEnVq1vKf8ZCB+ZTWMUuZ5XV/zSomvjrV9gFojPVhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WKP31U3PYNlxmJ5Jw6ioMcWDQnElftOp2CStBuFMpol50DHkEDljLXpYZneKe1hK/
	 V+Gzkx/DA10SFxNMABh5BXp6LpumMgOF3zJi8+RqTegYGwwVu1Cv1G2NgtPk5jsj7V
	 wu8qzmuCoAaBYDgWCjmT2uFTh4nRowX0GrqnZ3skuKsek7sqOgeKF0KVraQ7oEaXQA
	 bmTn0A63keAa789BFAcl8D7VXLegb4ugUTcuRLKhrHAb8kj4llVkKd7vd6PWcfkrql
	 ISTEAL+faHJHnOmfNpwilUfMY/cDu+mEF33TVK6Asti4NavBdUskw83zY6gy8u2bYl
	 SctQE3VkLt17w==
Date: Mon, 1 Jul 2024 16:03:03 +0100
From: Conor Dooley <conor@kernel.org>
To: George Liu <liuxiwei1013@gmail.com>
Cc: linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au
Subject: Re: [PATCH v1 2/3] dt-bindings: arm: aspeed: add IEIT x86 platform
 BMC boards
Message-ID: <20240701-penniless-purplish-99aa73b47a42@spud>
References: <20240701105259.972135-1-liuxiwei@ieisystem.com>
 <20240701105259.972135-2-liuxiwei@ieisystem.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IXUbULBPs5b4abff"
Content-Disposition: inline
In-Reply-To: <20240701105259.972135-2-liuxiwei@ieisystem.com>


--IXUbULBPs5b4abff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 06:52:58PM +0800, George Liu wrote:
> Document the new compatibles used on the ieisystems
>=20
> Signed-off-by: George Liu <liuxiwei@ieisystem.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index e386d0ebfb14..818fbe9c45fc 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -92,6 +92,7 @@ properties:
>                - ibm,rainier-bmc
>                - ibm,system1-bmc
>                - ibm,tacoma-bmc
> +              - ieit,nf5280m7-bmc

This is a singular item, but your commit message's $body and $subject
both sound plural. Is that intentional?

>                - inventec,starscream-bmc
>                - inventec,transformer-bmc
>                - jabil,rbp-bmc
> --=20
> 2.34.1
>=20

--IXUbULBPs5b4abff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoLFJwAKCRB4tDGHoIJi
0pXnAP4labcVzdg4N5elo5nMFW9/bbZHoNZWdzlofSvdJaEHJwD/cMxGLP+opluH
MicGC5BtbXqGAUic3usuJcSJOjWoYwM=
=O6so
-----END PGP SIGNATURE-----

--IXUbULBPs5b4abff--

