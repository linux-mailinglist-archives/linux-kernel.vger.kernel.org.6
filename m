Return-Path: <linux-kernel+bounces-542222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493D4A4C745
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8753ABB20
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45264216E1D;
	Mon,  3 Mar 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsBcs+Yv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B02215789;
	Mon,  3 Mar 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019398; cv=none; b=qHyMat+lx0MlNru8Zf0BYgTJrvy7V6Oa1PUmShnpW8W69wLetk8q9YM0wb3pr++UlX/bkwKck9iOba6XCNrqRRbAaEKrqERZNfSQm0icqvYYwqz4nBFtTPkOf7jpIYhqc4eDEdFAmxjI4jwbFJBT4k8Y4pMwBl2f4KMcgS5U5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019398; c=relaxed/simple;
	bh=hfkj99KGappDMmEncM9OKBX88k+6ubsMEvtGHpVAh24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJfnfJZK001sOr04KSfu73xHpcK0YK2pmz9FPx/zfO4kSeYevUKfQi5hCc8E4t0FNzsX5KXHFEqhKpeLVHfVcMzHBeGL5uPiC8WLBTMbtH4LQV1DPSAIet3KX5b6Lb4Xv4yC/dFBllpn4lzs4NLqFSOjnC8VWMcTIP/q1/ntNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsBcs+Yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AAEC4CEE6;
	Mon,  3 Mar 2025 16:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019398;
	bh=hfkj99KGappDMmEncM9OKBX88k+6ubsMEvtGHpVAh24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AsBcs+Yv8Y4r2VZqv8lwPXuIXX05s/8lkVJXoxuPK8suCAdv5KMF+VdQ/I7KmsWm3
	 72Gf63UKosyabd2JR0srkyUv0gw14z7wdBmSERT3VGUb/3PvdGmfSNrjBZIr3bLypg
	 d2G96kCukO4DfrttUHG97qDFjAZmrkGbk5lmQOsGpJmaiU56SYjE7fJYlqfuBmGUWY
	 Tr3mojmhrX0wgyW1eoJ1wVKiar7GzjDZG0R3U3Z5ULnavJRR8GnKh0NV2vbq0I5ufm
	 fwgpX9B3N3wVeAcRiywoYBKDeAcw0N/eRCDsw/SDaqqV70vl2hSrupQ8aIfXIQynD6
	 H5NaKIIxdqVJw==
Date: Mon, 3 Mar 2025 16:29:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: Add Sophgo SG2044
 MSI controller
Message-ID: <20250303-woozy-pluck-c04b13342401@spud>
References: <20250303111648.1337543-1-inochiama@gmail.com>
 <20250303111648.1337543-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dO6efuNDhgDYYCLt"
Content-Disposition: inline
In-Reply-To: <20250303111648.1337543-2-inochiama@gmail.com>


--dO6efuNDhgDYYCLt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2025 at 07:16:46PM +0800, Inochi Amaoto wrote:
> Like SG2042, SG2044 uses a similar msi controller to provide MSI
> interrupt for PCIe controllers.

In the future, could you mention the way in which they differ?
"similar" could mean 99% the same but incompatible, or 90% the same but
capable of using a fallback?
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Add support for the SG2044 msi controller
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../bindings/interrupt-controller/sophgo,sg2042-msi.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophg=
o,sg2042-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sophgo,sg2042-msi.yaml
> index e1ffd55fa7bf..f6b8b1d92f79 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg204=
2-msi.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg204=
2-msi.yaml
> @@ -18,7 +18,9 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: sophgo,sg2042-msi
> +    enum:
> +      - sophgo,sg2042-msi
> +      - sophgo,sg2044-msi
> =20
>    reg:
>      items:
> --=20
> 2.48.1
>=20

--dO6efuNDhgDYYCLt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8XZAQAKCRB4tDGHoIJi
0u8AAPwIgZNbZPvjU5OIngWO0eEFHEluL1AAnaKVQ0LYpdwwfAEA+5Ax4/LF2luS
+Z0b0hXAU2eo0WQlC2NjayPbAt3ndQs=
=U5Rv
-----END PGP SIGNATURE-----

--dO6efuNDhgDYYCLt--

