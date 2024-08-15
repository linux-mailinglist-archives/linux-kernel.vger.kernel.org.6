Return-Path: <linux-kernel+bounces-288184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8EB953703
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5A41F226E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A331AED47;
	Thu, 15 Aug 2024 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzoAgqHu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A056F1AD9FB;
	Thu, 15 Aug 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735282; cv=none; b=XTkBR25VVyeDhlPCgfbevnHhivQETjicRpH77X3N/wJ7YXH+nGu5av8WKzvwehPh1tktcqwUaGuhCnwCjDw8QgGyF0vn1Ws0VHydGS0gGrGyZDGm8/tdU7A+HuKmfLlppD2Y1cGBY9YSePBIM4Pt/3XTYYxIQVlK8VVd75v/4/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735282; c=relaxed/simple;
	bh=1s/yIl/TAOT3jm91oaphVLmwdi6HlvNxgrJlCYWjeaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYabzCX7uOOq+Qa9LUIHgVdwNXqOlSXzZVLQD5hggnHimoqgzDysICfJkJDUVA1TqVJgdO9uh7jpD+rrLeAdRPL81avqMWSYU0sSOdLb2yWMZ8jvrs5ElTs2Ii+py22CqB+lazto3wozmjrJVoBrsLXWl5IiGorOO9Y8BOMggZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzoAgqHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A05C32786;
	Thu, 15 Aug 2024 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735282;
	bh=1s/yIl/TAOT3jm91oaphVLmwdi6HlvNxgrJlCYWjeaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzoAgqHuvSvSa93qQUZ78p54yvgjzVoP9m7nQyClYDzUZDypvdquwFlJujOCn3J28
	 m86YXNUZCeItMTOu6Y7cwQvpvFfm+P4y3FrHwihagpN3V/BuFuQNWW2G1He7eY9W2p
	 cKpEFiIhnb7LBc6q3YYFlnFLRK4ptyKKmrA/I6whXsIUPTEvAYJIoZQB5GsR9LUzNy
	 uVONtY5UB4r7gE3pm/fW8FH86XdTquBrIAiWmVTIa767vpi4yDiHPUBnA/BI9+zGuQ
	 m0WnOd1RPhEbRSnhY22HUtkX3f0HPLtoYbhfnn0cN/oXJBFKOEAf2gnMB3VQZwSHFN
	 QfbGE34RtwOcQ==
Date: Thu, 15 Aug 2024 16:21:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: nxp,lpc3220-mic:
 Convert to dtschema
Message-ID: <20240815-starring-genetics-812e8f6bcd89@spud>
References: <20240814174651.188748-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hnaFiFhfNM9FUQW/"
Content-Disposition: inline
In-Reply-To: <20240814174651.188748-1-animeshagarwal28@gmail.com>


--hnaFiFhfNM9FUQW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 11:16:47PM +0530, Animesh Agarwal wrote:
> Convert the nxp,lpc3220-mic bindings to yaml format.
>=20
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>  .../interrupt-controller/nxp,lpc3220-mic.txt  | 58 -------------
>  .../interrupt-controller/nxp,lpc3220-mic.yaml | 85 +++++++++++++++++++
>  2 files changed, 85 insertions(+), 58 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controlle=
r/nxp,lpc3220-mic.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controlle=
r/nxp,lpc3220-mic.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/nxp,l=
pc3220-mic.txt b/Documentation/devicetree/bindings/interrupt-controller/nxp=
,lpc3220-mic.txt
> deleted file mode 100644
> index 0bfb3ba55f4c..000000000000
> --- a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-=
mic.txt
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -* NXP LPC32xx MIC, SIC1 and SIC2 Interrupt Controllers
> -
> -Required properties:
> -- compatible: "nxp,lpc3220-mic" or "nxp,lpc3220-sic".
> -- reg: should contain IC registers location and length.
> -- interrupt-controller: identifies the node as an interrupt controller.
> -- #interrupt-cells: the number of cells to define an interrupt, should b=
e 2.
> -  The first cell is the IRQ number, the second cell is used to specify
> -  one of the supported IRQ types:
> -      IRQ_TYPE_EDGE_RISING =3D low-to-high edge triggered,
> -      IRQ_TYPE_EDGE_FALLING =3D high-to-low edge triggered,
> -      IRQ_TYPE_LEVEL_HIGH =3D active high level-sensitive,
> -      IRQ_TYPE_LEVEL_LOW =3D active low level-sensitive.
> -  Reset value is IRQ_TYPE_LEVEL_LOW.
> -
> -Optional properties:
> -- interrupts: empty for MIC interrupt controller, cascaded MIC
> -  hardware interrupts for SIC1 and SIC2
> -
> -Examples:
> -
> -	/* LPC32xx MIC, SIC1 and SIC2 interrupt controllers */
> -	mic: interrupt-controller@40008000 {
> -		compatible =3D "nxp,lpc3220-mic";
> -		reg =3D <0x40008000 0x4000>;
> -		interrupt-controller;
> -		#interrupt-cells =3D <2>;
> -	};
> -
> -	sic1: interrupt-controller@4000c000 {
> -		compatible =3D "nxp,lpc3220-sic";
> -		reg =3D <0x4000c000 0x4000>;
> -		interrupt-controller;
> -		#interrupt-cells =3D <2>;
> -
> -		interrupt-parent =3D <&mic>;
> -		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>,
> -			     <30 IRQ_TYPE_LEVEL_LOW>;
> -	};
> -
> -	sic2: interrupt-controller@40010000 {
> -		compatible =3D "nxp,lpc3220-sic";
> -		reg =3D <0x40010000 0x4000>;
> -		interrupt-controller;
> -		#interrupt-cells =3D <2>;
> -
> -		interrupt-parent =3D <&mic>;
> -		interrupts =3D <1 IRQ_TYPE_LEVEL_LOW>,
> -			     <31 IRQ_TYPE_LEVEL_LOW>;
> -	};
> -
> -	/* ADC */
> -	adc@40048000 {
> -		compatible =3D "nxp,lpc3220-adc";
> -		reg =3D <0x40048000 0x1000>;
> -		interrupt-parent =3D <&sic1>;
> -		interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH>;
> -	};
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/nxp,l=
pc3220-mic.yaml b/Documentation/devicetree/bindings/interrupt-controller/nx=
p,lpc3220-mic.yaml
> new file mode 100644
> index 000000000000..66f2227ed364
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-=
mic.yaml
> @@ -0,0 +1,85 @@
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
> +  - Animesh Agarwal <animeshagarwal28@gmail.com>
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
> +    description: |
> +      The first cell is the IRQ number, the second cell is used to speci=
fy one
> +      of the supported IRQ types:

> +          IRQ_TYPE_EDGE_RISING =3D low-to-high edge triggered,
> +          IRQ_TYPE_EDGE_FALLING =3D high-to-low edge triggered,
> +          IRQ_TYPE_LEVEL_HIGH =3D active high level-sensitive,
> +          IRQ_TYPE_LEVEL_LOW =3D active low level-sensitive.

These are teh standard definitions, so there's no need to have them
here?

> +      Reset value is IRQ_TYPE_LEVEL_LOW.
> +
> +  interrupts:
> +    items:
> +      - description: Interrupt for SIC1
> +      - description: Interrupt for SIC2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +if:
> +  properties:
> +    compatible:
> +      const: nxp,lpc3220-sic
> +
> +then:
> +  required:
> +    - interrupts

The text binding didn't require this, what has changed?

Cheers,
Conor.

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
> +      };
> +
> +    sic1: interrupt-controller@4000c000 {
> +        compatible =3D "nxp,lpc3220-sic";
> +        reg =3D <0x4000c000 0x4000>;
> +        interrupt-controller;
> +        #interrupt-cells =3D <2>;
> +
> +        interrupt-parent =3D <&mic>;
> +        interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>, <30 IRQ_TYPE_LEVEL_LOW>;
> +    };
> +
> +    sic2: interrupt-controller@40010000 {
> +        compatible =3D "nxp,lpc3220-sic";
> +        reg =3D <0x40010000 0x4000>;
> +        interrupt-controller;
> +        #interrupt-cells =3D <2>;
> +
> +        interrupt-parent =3D <&mic>;
> +        interrupts =3D <1 IRQ_TYPE_LEVEL_LOW>, <31 IRQ_TYPE_LEVEL_LOW>;
> +    };
> --=20
> 2.46.0
>=20

--hnaFiFhfNM9FUQW/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr4c7gAKCRB4tDGHoIJi
0qlgAP4t9eofW+3ydBLc2Opdi71Z1WKgclGJjJW6+7arYi72WgD/U1XIWgBtp3F1
FBdsgiRFWlAt3sbKp6k/lJybKm33Dg0=
=74vs
-----END PGP SIGNATURE-----

--hnaFiFhfNM9FUQW/--

