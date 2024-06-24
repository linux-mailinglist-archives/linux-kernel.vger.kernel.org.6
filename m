Return-Path: <linux-kernel+bounces-227585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9991539E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92BE1C203AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AD119E7C2;
	Mon, 24 Jun 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiCDFoQQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE919D8BE;
	Mon, 24 Jun 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246294; cv=none; b=bSFWkP0CaCPKCZjdnn4ispNUVJTT9yLasdf+LvWee1gxEHlhjgre+Kvs+Wk9zT9wnaRy5YQFdzTSJUeQhRnhsA7sFvsbR6NCnTsArAVepPgd/6Vjbu19kxLZGeDwdAGDeo8E0kqgbZSE07QdlEZUni2tCtnlESZGKQbDuFLlC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246294; c=relaxed/simple;
	bh=wM1PLXDti0AmfzBXeR8CNL+SeLrBWDa8hBsTl6a356M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbC9geIYUkeddDi9omvqLE8SeRQv2Anr2l327/Al++L86G0ETVDKMlyoTB2hRkhL3cr4JhDJPHCQcasT0LrD7kDDGEkVLFz0Eu0fDxuanCtKb6n1zs7hXOvzIQMXj9NKGBIHxB7RD6IVrIktfxOf+i3kwMnEhaGT+z4ueNXssbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiCDFoQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39421C32782;
	Mon, 24 Jun 2024 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246293;
	bh=wM1PLXDti0AmfzBXeR8CNL+SeLrBWDa8hBsTl6a356M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZiCDFoQQ3fDx4zKxFDo4HlJJEa9HR8T8jT9qeuT0LBCDOp7aUzWKPTdybfc5p1/F8
	 pPqTFpm4uL/vLYebKQTBpPeQt9/XdJGezBQTcZQLu1RqDlkowqavkZh+7OEkz+yFP0
	 P5VueDIG/P71oGrXN2YG4cjAcYfVkzbdpyeSNnruYDDGOJ/HDohChF0IJdChvSSB3I
	 VcVzAg2KeWNlEWVXCgNzJMX1dsJcz750fX5bMW3KaSnVSiButdrwLESmVKgxT8rIwr
	 +/Mei1FVDzXQwQWho10G3i0aLIq5MGS1eJHmyn54m69biDGYKMZW1aSupTvmkCqysM
	 RPUYTx2nZCfcQ==
Date: Mon, 24 Jun 2024 17:24:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH 3/4] dt-bindings: soc: ti: am645-system-controller: add
 child nodes used by main domain
Message-ID: <20240624-hula-fever-74499b22784d@spud>
References: <cover.1719210050.git.jan.kiszka@siemens.com>
 <52848094062ea55b0063e6fc37f27e6ed5035aa8.1719210050.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ahEv3udmetJmBawl"
Content-Disposition: inline
In-Reply-To: <52848094062ea55b0063e6fc37f27e6ed5035aa8.1719210050.git.jan.kiszka@siemens.com>


--ahEv3udmetJmBawl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 08:20:49AM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Expand bindings to cover both the MCU and the main usage of the AM654
> system controller.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../soc/ti/ti,am654-system-controller.yaml    | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-con=
troller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-con=
troller.yaml
> index e79803e586ca..0eec807f38df 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller=
=2Eyaml
> @@ -34,6 +34,35 @@ patternProperties:
>      type: object
>      $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
> =20
> +  "^mux-controller$":
> +    type: object
> +    description:
> +      This is the SERDES lane control mux.

Where is this object described?

> +
> +  "^clock@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/mfd/syscon.yaml#
> +    properties:
> +      compatible:
> +        items:
> +          - const: ti,am654-serdes-ctrl
> +          - const: syscon
> +
> +  "^dss-oldi-io-ctrl@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/mfd/syscon.yaml#
> +    properties:
> +      compatible:
> +        items:
> +          - const: ti,am654-dss-oldi-io-ctrl
> +          - const: syscon
> +
> +  "^clock-controller@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
> +    description:
> +      Clock provider for TI EHRPWM nodes.
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.43.0
>=20

--ahEv3udmetJmBawl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnmd0QAKCRB4tDGHoIJi
0j3YAQDs+1riKZsxwG5tXCyvlJ9JB7R1pYOYsnx6qqkugXpkjQEAxkbTJwMuMV4t
+CaTrRobr4M7OcTAMYQMgBdJct9/Uw4=
=07Mo
-----END PGP SIGNATURE-----

--ahEv3udmetJmBawl--

