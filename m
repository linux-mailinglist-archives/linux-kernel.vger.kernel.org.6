Return-Path: <linux-kernel+bounces-283415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44FD94F22A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C521C21161
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75501862B2;
	Mon, 12 Aug 2024 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3mgSpRi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006B4D112;
	Mon, 12 Aug 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478143; cv=none; b=ttcQGTtlmJwOEPySGW7Oz2Idlt3TCVLgeuoOdKW1ErHKUe5tlZPGKDN6Q8X2FcneBtsVz1hTtqGhGH7ovv8+tA64JLDjR6tFdzHSAUjUtUJXtJldN2mOIpkv8wrXmBMTjga/7QYUeDINYABg7fGZDmru6NCTvSZ6MCzWKxAmaSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478143; c=relaxed/simple;
	bh=fIxgfU9U7UdKHCzgTt5JxPxYSDRiI+jpNpkMi6cCmNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhrt7jdDYSXF27kr1Cd4qhVMjgBr861VHTNIkjI6sdYOQTAOyqx2h0G9iFOcThJPRsmgFRwH499/QFjhr/NT7aKrRxEJIwue4+7PtanKVNXBItq56OVG3/XtStHL9q6wBa/x1GL+fOAIF/uzYsfs5rAP0qVgaCo4hg+t7lxNrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3mgSpRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6098DC32782;
	Mon, 12 Aug 2024 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723478142;
	bh=fIxgfU9U7UdKHCzgTt5JxPxYSDRiI+jpNpkMi6cCmNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3mgSpRiCH/hfVz2HIjVM3C3Yq1lKI/jniZJcW7Ur61Ag1fqi65ipjx2ct84DMI7M
	 ysFCCNySYeQc9/SjndDB+u/vUZB6yel/3PTpuALkdKCzgb4fEN+R4JpiF47QioSeDx
	 q6hQE6XJuufABIB5Cyn/PVzhgYEyCxcpi8w73daUvRcKkqS+mhH0QCfPlsLZ70vXxU
	 1maqNbGWxk3KsNl93e3FEmNsxc/oM6locRh/VSratxEfDtPff5xHOOblWkXV1nLL82
	 JFWjibQXr6QkjDKkLp5iLrFxtvilJGf/NEtL1Zakmnt3L2hh5WyJ0Sx07x7rOmUZfs
	 QkQN7t4vp1Idw==
Date: Mon, 12 Aug 2024 16:55:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Minda Chen <minda.chen@starfivetech.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: jh7110-usb-phy: Add sys-syscon
 property
Message-ID: <20240812-overstuff-skirt-7a8aabbcdc6f@spud>
References: <cover.1723472153.git.jan.kiszka@siemens.com>
 <30f3ca9f6bd788e16767b36aa22c0e9dc4d1c6a4.1723472153.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LtVVHt/+tPGAV+JK"
Content-Disposition: inline
In-Reply-To: <30f3ca9f6bd788e16767b36aa22c0e9dc4d1c6a4.1723472153.git.jan.kiszka@siemens.com>


--LtVVHt/+tPGAV+JK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 04:15:51PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Analogously to the PCI PHY, access to sys_syscon is needed to connect
> the USB PHY to its controller.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> ---
>  .../bindings/phy/starfive,jh7110-usb-phy.yaml         | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-ph=
y.yaml b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
> index 269e9f9f12b6..eaf0050c6f17 100644
> --- a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
> @@ -19,6 +19,16 @@ properties:
>    "#phy-cells":
>      const: 0
> =20
> +  starfive,sys-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to System Register Controller sys_sysco=
n node.
> +          - description: PHY connect offset of SYS_SYSCONSAIF__SYSCFG re=
gister for USB PHY.

Why is having a new property for this required? The devicetree only has
a single usb phy, so isn't it sufficient to look up the syscon by
compatible, rather than via phandle + offset?

> +    description:
> +      The phandle to System Register Controller syscon node and the PHY =
connect offset
> +      of SYS_SYSCONSAIF__SYSCFG register. Connect PHY to USB controller.
> +
>    clocks:
>      items:
>        - description: PHY 125m
> @@ -47,4 +57,5 @@ examples:
>                   <&stgcrg 6>;
>          clock-names =3D "125m", "app_125m";
>          #phy-cells =3D <0>;
> +        starfive,sys-syscon =3D <&sys_syscon 0x18>;
>      };
> --=20
> 2.43.0
>=20

--LtVVHt/+tPGAV+JK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrowegAKCRB4tDGHoIJi
0gXFAP9irfiKqj3CaOoVEdmxFBQbHAu8wbJBdmXuGodai0OMaQEAp0i//vC20L1l
o+8FpvJ1Mt/ZC28yMFhDKZtipTS5rgc=
=rBq+
-----END PGP SIGNATURE-----

--LtVVHt/+tPGAV+JK--

