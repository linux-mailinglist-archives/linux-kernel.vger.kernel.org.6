Return-Path: <linux-kernel+bounces-262299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCDA93C3CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA59281FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD08419CD0F;
	Thu, 25 Jul 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV9i8yAE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0441819B3E3;
	Thu, 25 Jul 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916683; cv=none; b=YRQTyWqOCaNQZN3KkXK0Z6FcI3rl8+zn3MCgqZA/8vnjZwIU9fdiMquA1BJzw5yydTokSApg2P8shkgjqeMfd0ZnaHJ6aFH1G8hIKbfnjFyYQFsnNcX3dZ25/qquh3rztrxiiiJt4ZlzsbJ+r/S/qwC7/6dFA3a214vq665f2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916683; c=relaxed/simple;
	bh=K2jntEM2NdwIXR7woB2lurOGQ31Ad2/rOHMmjfH1G4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYPlM7vgTzMxo918hlpW5ecsP3nQb7FtDMylvGyIyqukMfPZYIlq6cX0du1mjWboH0v4uEHnKZdNJ0ZVtdMJ6qrsHzIY/sCO4FpzQW2U2hXqf1U6zHXK9BPU3jBJIxrk7JJSd/mvUfSQ4k225PWyyMBYUdY85WlRHp6JG600qqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV9i8yAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6E3C116B1;
	Thu, 25 Jul 2024 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721916682;
	bh=K2jntEM2NdwIXR7woB2lurOGQ31Ad2/rOHMmjfH1G4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QV9i8yAE4X67/HuPTmdg3c21biU527XqS5W8o4IAPOOEJkqK07d4/knl/sc78SHfh
	 C853fWnul+h7vVsYkFMNpFHcf2qpaFgx7Ts7HAMhAq62E7RPZPR121WqFRFFLbxsD+
	 hZgAxfTVQgEdKSeEKRkHN7lDKF1raqLCHrroTKc7rqy0kPqHUvQLN5ht2IjWOig6Rd
	 QXgi9lT/lmH/ixNnGI6cZQAmUN1WCkMSJ0TZcOAYLT4swfjADYeGErxYh/5skPTAtC
	 9t7G1PsVE+JmN6EZYdfC1YDi1LuyOK+3eWpzDZ57GfOZk4PFb5svjhklZt/fXG91bM
	 B8Fdq4JnqYBvw==
Date: Thu, 25 Jul 2024 15:11:18 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] dt-bindings: riscv: sifive-l2: add a PIC64GX
 compatible
Message-ID: <20240725-widget-ebook-1f34438355de@spud>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
 <20240725121609.13101-7-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YV+Pv3m+MnxQFIob"
Content-Disposition: inline
In-Reply-To: <20240725121609.13101-7-pierre-henry.moussay@microchip.com>


--YV+Pv3m+MnxQFIob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 01:15:58PM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> The PIC64GX use an IP similar to MPFS one, therefore add compatibility wi=
th
> MPFS as fallback

It's the same, not similar ;)

$subject should start with "dt-bindings: cache:"

>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> ---
>  Documentation/devicetree/bindings/cache/sifive,ccache0.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml =
b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> index 7e8cebe21584..9d064feb2ab1 100644
> --- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> +++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> @@ -47,6 +47,11 @@ properties:
>            - const: microchip,mpfs-ccache
>            - const: sifive,fu540-c000-ccache
>            - const: cache
> +      - items:
> +          - const: microchip,pic64gx-ccache
> +          - const: microchip,mpfs-ccache
> +          - const: sifive,fu540-c000-ccache
> +          - const: cache
> =20
>    cache-block-size:
>      const: 64
> @@ -93,6 +98,7 @@ allOf:
>                - starfive,jh7100-ccache
>                - starfive,jh7110-ccache
>                - microchip,mpfs-ccache
> +              - microchip,pic64gx-ccache
> =20
>      then:
>        properties:
> --=20
> 2.30.2
>=20

--YV+Pv3m+MnxQFIob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqJdBgAKCRB4tDGHoIJi
0qoPAQDiWmbC30Jswzi04zwSiokBIT65V56No17WIdstMpQawwD/XR7qsT5GSXbW
xP2sbx7bJboOZtoU9RKv4M8P0KcwJgY=
=H2JB
-----END PGP SIGNATURE-----

--YV+Pv3m+MnxQFIob--

