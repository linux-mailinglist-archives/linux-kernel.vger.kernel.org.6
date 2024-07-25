Return-Path: <linux-kernel+bounces-262316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E144793C402
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65148B21330
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2609E19D880;
	Thu, 25 Jul 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REUUdLqI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617CC19D091;
	Thu, 25 Jul 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917349; cv=none; b=TPGkoPxutiBbvtaeebpd4tbnosaVcNrkZvLxDrjM0+EWXKdUQqu1Yg6VLdjbg0tRz31lHpQhzgfH7cWkWVzSerQOFylUWRKab7/jNabEcYnZczoj/y+5bEG5RgxJZCFbbS3ZsPnJpxTihThtRqReA7woB38sU6uqUuXR88JlXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917349; c=relaxed/simple;
	bh=Xr7gwIkEtfygg5zDHKVTVXXd8+oxncye9yOKYkaCVy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pye1o7E1pWwbU3z8HJvfbTHgYkQll/yFvOl/gdBo3glz/tSOmPgoEg7hRMIRDT/+qH5yf++fMGI3pqX7VrkDT0kWMKonNf7JCDP0/ZXkx2eso8MGv6rUm96Kd4ud7F2zoNAYVYDz+fvORiT3bQdy/5C3qTIihhlVNioJPvrQvdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REUUdLqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5341C32782;
	Thu, 25 Jul 2024 14:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721917348;
	bh=Xr7gwIkEtfygg5zDHKVTVXXd8+oxncye9yOKYkaCVy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REUUdLqIyoeSYhmWzkbITk+xAAkWffbxWAah6GwSlP/RmvesVWI0DCdssNefjCA44
	 rsAsvhhyTlip8ypB18FsjBBeNJrRe55Qh7H/qsZ6tNf1EWJyRPT1YMgE+6aEhMOy7D
	 /XVMrDWxQ54LdkqWjDmIHlrx/m+R6+uX1vS5UYpwIvT5iu98TnUwOqAU1GbO+MZqNE
	 UPNIsXO6H930srHPnFRFRYElOhuc6rGIp9+3vrub+a14j+lRzcZkYNlzYKP9SRaKtW
	 0Fe84o8hTFqhuNUjX5isLyxE59yTS+dD2ZN5IFO9gDxcDDKxpFXyJKnauAhlL1Cl6Q
	 VB5D6nQoU5WNg==
Date: Thu, 25 Jul 2024 15:22:24 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] dt-bindings: clock: mpfs-clkcfg: Add PIC64GX
 compatibility
Message-ID: <20240725-upstream-smokeless-6d0eb847a594@spud>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
 <20240725121609.13101-9-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oUQL6fU2J0AJLRVY"
Content-Disposition: inline
In-Reply-To: <20240725121609.13101-9-pierre-henry.moussay@microchip.com>


--oUQL6fU2J0AJLRVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 01:16:00PM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX has a clock controller compatible whith mpfs-clkcfg
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> ---
>  .../devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml    | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcf=
g.yaml b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
> index e4e1c31267d2..ca889f5df87a 100644
> --- a/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
> +++ b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
> @@ -19,7 +19,11 @@ description: |
> =20
>  properties:
>    compatible:
> -    const: microchip,mpfs-clkcfg
> +    oneOf:
> +      - items:
> +          - const: microchip,pic64gx-clkcfg
> +          - const: microchip,mpfs-clkcfg
> +      - const: microchip,mpfs-clkcfg

Ditto here, the mpfs binding is wrong and I don't want the pic64gx to
ape that. Instead, we should take the opportunity to fix the binding.
You're gonna need to do that so that the pinctrl driver can access the
IOMUX registers correctly. As with the mailbox, either simplemfd or
syscon are needed here. I mocked something up a few weeks ago while
talking to someone about a hwmon driver, I'll dig it up when I am back
to work.

Cheers,
Conor.

> =20
>    reg:
>      items:
> --=20
> 2.30.2
>=20
>=20

--oUQL6fU2J0AJLRVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqJfoAAKCRB4tDGHoIJi
0suUAQC/tzIWQ+Mg2NnvUYdGhSkTvOGO4cDGQ05zxeqfGSiiWgEA7Rwx2eJ2o5Ny
E6x8AuEC/cU5wHg6AoUfsPnTv8QKGw4=
=tflQ
-----END PGP SIGNATURE-----

--oUQL6fU2J0AJLRVY--

