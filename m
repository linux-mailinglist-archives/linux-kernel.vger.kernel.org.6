Return-Path: <linux-kernel+bounces-285095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32112950943
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6CC1B247E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6877F1A071B;
	Tue, 13 Aug 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXoPKn6U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91B191F71;
	Tue, 13 Aug 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563625; cv=none; b=jvBPYU2cXgPVTlYuSy0AGTzFdEeUFLfSVN4Mq194XRnbndCXjGPaWLhsQTpLOgM7jb/zDyiBcua3TgxgtLBwRcvPEwqB+xEpC4xMw7I/A3ley/fYzvuY4IuLlKSS/FtYWxSibkzOK1eRI1/xcJ3KhWGVF/siftuX9FuSQ+kFD7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563625; c=relaxed/simple;
	bh=x4tT144aOZx9FuZqA2GLX4HlAeWiSYgx499ceqnuVP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwjtOm/MWg4/QRrqlUHbFrUZq2jpYWeQvVs+mEMruwMe0vb0moLsv8RYSCsXshrC4bVPfA4Sc3cZr4mrZSdNuz4abJHsKT8WnZ2i8PMsfDC5gwDC02R272NkZniXsibVzMobZEi/cDbcfRZrN8WYFYcYfO5ObCaCbPP0yDIW2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXoPKn6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA579C4AF09;
	Tue, 13 Aug 2024 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723563625;
	bh=x4tT144aOZx9FuZqA2GLX4HlAeWiSYgx499ceqnuVP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXoPKn6UFDhcCtzNKfPHaTOfMJcPrNRis4hlZuHfmtE4EBgOAYY6HKhalsivSZSy4
	 3+6X7voWjVNTFZXaxodfLXvHGfaMrlImNXzzmyI16Kc2o72Q1sRrHKg9X6x6BEbPQt
	 1ZldCndWDp3+oLySJA7CM4pVpStDUEFWnC7HlLxJ1sVy1WHUptzxOxSqi7g/Fz+c+I
	 QJOcFPW2c+uXNjqYgi9NqJBJYC0MLrVDD+SdVMOvNCxbMHOKrhb5ttLOc89AUAhu/I
	 D/+p1gJB4622PHr+StOuOptN2p/KX9Wa1vqHgzJ9BI/boOSFGU4Uu5D/fpLcBb47QO
	 JSFIDJWrN5xEA==
Date: Tue, 13 Aug 2024 16:40:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: soc: ti: am645-system-controller:
 add child nodes used by main domain
Message-ID: <20240813-outrank-mumble-8dddbfc68586@spud>
References: <cover.1723529100.git.jan.kiszka@siemens.com>
 <ac1622c04e5ae2bb80075e70dbde23abc2f3a4b5.1723529100.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dQ4bp7j23augji+P"
Content-Disposition: inline
In-Reply-To: <ac1622c04e5ae2bb80075e70dbde23abc2f3a4b5.1723529100.git.jan.kiszka@siemens.com>


--dQ4bp7j23augji+P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 08:04:59AM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Expand bindings to cover both the MCU and the main usage of the AM654
> system controller.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../soc/ti/ti,am654-system-controller.yaml    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-con=
troller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-con=
troller.yaml
> index e79803e586ca..5a689ec3c5c9 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller=
=2Eyaml
> @@ -29,11 +29,36 @@ properties:
> =20
>    ranges: true
> =20
> +  mux-controller:
> +    type: object
> +    ref: /schemas/mux/reg-mux.yaml#
> +    description:
> +      This is the SERDES lane control mux.
> +
>  patternProperties:
>    "^phy@[0-9a-f]+$":
>      type: object
>      $ref: /schemas/phy/ti,phy-gmii-sel.yaml#
> =20
> +  "^clock@[0-9a-f]+$":

Could you explain to me why these are all patternProperties? Why are the
addresses of these things not fixed for an am654?

> +    type: object
> +    $ref: /schemas/soc/ti/ti,am654-serdes-ctrl.yaml#
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

--dQ4bp7j23augji+P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrt+ZAAKCRB4tDGHoIJi
0nlRAP9ltCP7sOlvu1IrXMI7uVLNba8ZsvjztHWFwmYX7ydL+QEA5omNP1QYX+HY
/yHP0psylV0wt/oUBfoZelKenkN+Jgk=
=38tq
-----END PGP SIGNATURE-----

--dQ4bp7j23augji+P--

