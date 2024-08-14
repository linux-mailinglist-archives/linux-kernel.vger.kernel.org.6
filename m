Return-Path: <linux-kernel+bounces-286539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F36E2951C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA55B267BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC4F1B29BD;
	Wed, 14 Aug 2024 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvFCD54l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD4F1B0121;
	Wed, 14 Aug 2024 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643470; cv=none; b=D80u3t1ARrgjWZxMbGrAtF2WtLcrpBdO3tyw6mlLg8dEuIaG93qziAULIYQnDj+LbGq6p58vSaz26t5fICzunExHUDi1/qPUMMn6vFg2KuZKvT62cUWcZsgRklzWbnQVDFQNNaULTxI56eEv0NJ8EhxZgaerWUVw99DN3XLzQYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643470; c=relaxed/simple;
	bh=D0wbeYwEYlIc0tC9lVOfZ5aSYHYqpRDolJ+IlKgpWoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUmjwAKigip411Y3B6XOycmZGKIoDxsO1BVD0IKtNGHf/xe4EDQlXNa0utOuC/QVAmqm1GyT6vnojOIHzBvmAMKZRi+C7luqaSvYX1lifeFPUAHe51L5RTKMsZbZ4QflIqjYFKi2NcWK88MpcHQl1Ye8/Q7L1/aFXXK2/IwWNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvFCD54l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074BFC4AF0D;
	Wed, 14 Aug 2024 13:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723643469;
	bh=D0wbeYwEYlIc0tC9lVOfZ5aSYHYqpRDolJ+IlKgpWoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lvFCD54l8ywbh8HVnkAVrRRzdhlifEub+erkgslMAFqylt0X9p1rRn6Vwfivc2RKr
	 bGZJAa3iPyJCq356ufbpcpWf0A35zu09Fk5XqpYBlVCVKAKOJ4/wN0Dqr6cyeMOnoX
	 bLmaZiaY+kY3kvyRhYKPW5/BDviCKA3iIgBdXfg6NbSPG4OenKRcTUOq/5QkrIzWTW
	 yIlLEktu9qNS9l4SxifexNS9vh9jKPfcGDpd/6K+vNWEjaTp2Fl0N4rWZbUufbc6Gd
	 3E33m5BjrHRu3QQhgPp/aVB/CcEqTsT1lYEgAIjX/NVS7cqyzRj7ujwfFoa/vhKoO4
	 FlJdb4FL6CwAg==
Date: Wed, 14 Aug 2024 14:51:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, abdellatif.elkhlifi@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: Update Corstone-1000 maintainers
Message-ID: <20240814-detergent-given-f062d350f370@spud>
References: <20240814133525.4090877-1-hugues.kambampiana@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Rn4szDAqStxIZrlv"
Content-Disposition: inline
In-Reply-To: <20240814133525.4090877-1-hugues.kambampiana@arm.com>


--Rn4szDAqStxIZrlv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 02:35:25PM +0100, Hugues KAMBA MPIANA wrote:
> - Add new maintainers: Abdellatif El Khlifi, Hugues Kamba Mpiana
> - Remove maintainers: Vishnu Banavath, Rui Miguel Silva
> - Update contact information for existing maintainers

I can see what you have done, but why are you doing it?

>=20
> Signed-off-by: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,corstone1000.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/arm,corstone1000.yaml =
b/Documentation/devicetree/bindings/arm/arm,corstone1000.yaml
> index 693f3fe7be60..cff1cdaadb13 100644
> --- a/Documentation/devicetree/bindings/arm/arm,corstone1000.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,corstone1000.yaml
> @@ -7,8 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ARM Corstone1000
> =20
>  maintainers:
> -  - Vishnu Banavath <vishnu.banavath@arm.com>
> -  - Rui Miguel Silva <rui.silva@linaro.org>
> +  - Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> +  - Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
> =20
>  description: |+
>    ARM's Corstone1000 includes pre-verified Corstone SSE-710 subsystem th=
at

--Rn4szDAqStxIZrlv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZry2SQAKCRB4tDGHoIJi
0uoXAQCcCFQwf5DLEw1Q2ZRgnZ1OIbsY3mhEmAbSzJMn7VJgXQD/cJO3vUBYLTuE
V7ZQLWMFL1UoXdhp9J87nykBPGSHjwk=
=McgL
-----END PGP SIGNATURE-----

--Rn4szDAqStxIZrlv--

