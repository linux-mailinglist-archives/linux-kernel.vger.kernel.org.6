Return-Path: <linux-kernel+bounces-344203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D15D898A657
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6134284EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA671922DF;
	Mon, 30 Sep 2024 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WysnG83C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8C18FDD8;
	Mon, 30 Sep 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704440; cv=none; b=mhuQGygHk445sVcrCLXwvh93kBDx5ZP3pjf/bxmJA5f9VbdMkW+RcpWkNl3iO1XZxaFH9EXk7pJbYNFTUOeWhxHGTP8QUaMI4NdrD5hQ0hTOC+dbb61i1mMUqQ2l7XsrqXCLitnadHBEqoApqJAQ8vkYrYR+toy0SKmOc6qiuhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704440; c=relaxed/simple;
	bh=pCgtNUlDws28YKTzJDQZoNSiw0mc+bFIyJBWjYcPoK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7d3y5yvri8DG+VHjZwjU2aRESVtez21hwJkfiwkBDDbf5MPaa7ztJxIKbZGqTazWpyfbrJNdixJl20rE2nNNeU+pHlLvOz8Uqz168sKIjD/zXDaY8XpGZUVLnaJqGN5R/pIMCJYcmPSy2YpG9h2RNngDDp/sKn1xI/z3Jur9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WysnG83C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20DFC4CEC7;
	Mon, 30 Sep 2024 13:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704439;
	bh=pCgtNUlDws28YKTzJDQZoNSiw0mc+bFIyJBWjYcPoK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WysnG83CKIrIeBANzf2lJRzkrWWTNiiMDY7duwnOsKgmgmCSbRxlRRx2xiKF6PuNO
	 Nv/pq7bpYHa/MKtowGJTbtjI3MEOVqCqNGnRkg04RrBkGNLZiJqFChPzdauKe6UrmC
	 dPnCq+OX2vZiCWuXOXsfurSiF8qhcErbQrwt6+IuqhW5yQonZWRZLU7KZ07r26m4+j
	 c6/3YsNSscp+mnLbZVGiDooEGd07YyubftQXk1NuslGKgC2q+7sKO26XDWW26x3WJI
	 xuK/oUoJ+Td0I8GWnjArW5kd1T5jc+Lk91UO3/9pybt1iUbYd4jzoKROwNA2IcbVBu
	 /hJyaQkf7kqQg==
Date: Mon, 30 Sep 2024 14:53:55 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 14/20] dt-bindings: soc: microchip:
 mpfs-sys-controller: Add PIC64GX compatibility
Message-ID: <20240930-patio-portly-cd5d3c95152d@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-15-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Hf2aEzpa7rylryo"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-15-pierre-henry.moussay@microchip.com>


--/Hf2aEzpa7rylryo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:43AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX is compatible with mpfs-sys-controller, without additional
> feature
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> ---
>  .../soc/microchip/microchip,mpfs-sys-controller.yaml        | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mp=
fs-sys-controller.yaml b/Documentation/devicetree/bindings/soc/microchip/mi=
crochip,mpfs-sys-controller.yaml
> index a3fa04f3a1bd..af89d5959747 100644
> --- a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-=
controller.yaml
> +++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-=
controller.yaml
> @@ -24,7 +24,11 @@ properties:
>      maxItems: 1
> =20
>    compatible:
> -    const: microchip,mpfs-sys-controller
> +    oneOf:
> +      - items:
> +          - const: microchip,pic64gx-sys-controller
> +          - const: microchip,mpfs-sys-controller
> +      - const: microchip,mpfs-sys-controller

NAK, v1 commentary has not been implemented here.

> =20
>    microchip,bitstream-flash:
>      $ref: /schemas/types.yaml#/definitions/phandle
> --=20
> 2.30.2
>=20
>=20

--/Hf2aEzpa7rylryo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqtcwAKCRB4tDGHoIJi
0of3AQClj5XAcu2rD37lVMgv2I7vxtKm1S4Djn4z1U4mVytKFwEAwwLrP0ODJjQb
IbOg/VwrTyRSuKT94PEUetB5QCDLMQU=
=UBFn
-----END PGP SIGNATURE-----

--/Hf2aEzpa7rylryo--

