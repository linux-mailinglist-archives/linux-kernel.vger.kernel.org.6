Return-Path: <linux-kernel+bounces-539216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB368A4A21C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D103A9990
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D80227700D;
	Fri, 28 Feb 2025 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tE0CTrkE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DEF277002;
	Fri, 28 Feb 2025 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768523; cv=none; b=fzdnKr5rqkUmPxPvjdG0C1PjNV4y73f66wX6XFDhp+fKu1mANwOcP4+ce15bDrGYyYlBzGYcK2Yy1UW1xdkrQN1y8nan1fol1DBrR/QPRJaKRuv/sKCWJR3k2eoSeiUfmY5vBYQNBjnE72RdhJuN3CTl9yWe5Acc9dLZk8cfHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768523; c=relaxed/simple;
	bh=APUCKC71dBuc4EDL+Bo9BJ7sSImd07t8ITjnaY/kkOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM/dk9NC8MXhcGbDRn6c93SjCNb2pbrotIxa5Zj6hh71izS2ACZpnHgN+KYrAxU+VEXH3R/avmBsEsmPHA5W+1IZa3aM2OXWtK0/ZBFIOHtjog0LrqtO0gtm+cz8X+wO6VuGqqNF2JlMUrHuIgIgnpKINPJw7RFcklZIsD79R98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tE0CTrkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DBEC4CED6;
	Fri, 28 Feb 2025 18:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740768523;
	bh=APUCKC71dBuc4EDL+Bo9BJ7sSImd07t8ITjnaY/kkOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tE0CTrkERAGLoYB4WFOzNCx5PXDQCV/BT0UuoTB0OKZBX0/naUWLbkGFOdg2gErJW
	 /6joExoZEzUb/CvagMdI4RLmjav7PcogdMbQj8azgm3hKEUWLqi7ucf+x8GgOChAw3
	 EVlxHPoOw0s/tMCkH/xf/3eaQ+Suo85a86HifJsmgmfdWpwnWmFUWrNLDw8KdQH10o
	 zTxqy7c2l7ATQfrvoTBEMNCv5LLmxmZJdRgQQmIqauLLSPieVLoK5PSRgDF46YEyp8
	 ij1/CB30mbAU2hGIEpjOS57U0o0uCgp4nzsbEvHD9VopfbPFIgeGbOC0J9S4flKM5C
	 F09dDAth7Rs7Q==
Date: Fri, 28 Feb 2025 18:48:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
Cc: tglx@linutronix.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vz@mleia.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] dt-bindings: interrupt-controller: Convert
 nxp,lpc3220-mic.txt to yaml format
Message-ID: <20250228-unglue-circle-9a749b22df6a@spud>
References: <20250228034021.607135-1-leo.fthirata@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9cO6X+FAmGc7FisE"
Content-Disposition: inline
In-Reply-To: <20250228034021.607135-1-leo.fthirata@gmail.com>


--9cO6X+FAmGc7FisE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 12:39:15AM -0300, Leonardo Felipe Takao Hirata wrot=
e:
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/nxp,l=
pc3220-mic.yaml b/Documentation/devicetree/bindings/interrupt-controller/nx=
p,lpc3220-mic.yaml
> new file mode 100644
> index 000000000000..59e8814a15b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-=
mic.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/nxp,lpc3220-mic.=
yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP LPC32xx MIC, SIC1 and SIC2 Interrupt Controllers
> +
> +maintainers:
> +  - Vladimir Zapolskiy <vz@mleia.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,lpc3220-mic
> +      - nxp,lpc3220-sic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  interrupts:
> +    items:
> +      - description: Regular interrupt request
> +      - description: Fast interrupt request

> +    description: IRQ and FIQ outputs of SIC1/SIC2 to the MIC.

If you respin, drop this line and...

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,lpc3220-sic
> +    then:
> +      required:
> +        - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    mic: interrupt-controller@40008000 {
> +        compatible =3D "nxp,lpc3220-mic";
> +        reg =3D <0x40008000 0x4000>;
> +        interrupt-controller;
> +        #interrupt-cells =3D <2>;
> +    };
> +
> +    sic1: interrupt-controller@4000c000 {

=2E..the unused label "sic1".
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> +        compatible =3D "nxp,lpc3220-sic";
> +        reg =3D <0x4000c000 0x4000>;
> +        interrupt-controller;
> +        #interrupt-cells =3D <2>;
> +        interrupt-parent =3D <&mic>;
> +        interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>,
> +                    <30 IRQ_TYPE_LEVEL_LOW>;
> +    };
> --=20
> 2.43.0
>=20

--9cO6X+FAmGc7FisE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8IFBgAKCRB4tDGHoIJi
0gRsAQCMHHYcmdil1ulRxMe8G+ZFyihKS8OFXG6C2v7HxDGtLgEA483qefZEZj1O
xibX14Nm7bHmDi6LQB7+SgQ0rGwi3wA=
=cqiV
-----END PGP SIGNATURE-----

--9cO6X+FAmGc7FisE--

