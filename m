Return-Path: <linux-kernel+bounces-513851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09060A34F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8328B169C99
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC35A266B4A;
	Thu, 13 Feb 2025 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWItHsxi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056F24A07B;
	Thu, 13 Feb 2025 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478853; cv=none; b=lA6r5xSxmumnOVRMUJUu4/0ePI832ozJT0GTu7qQWxvZq7aoMzV9oo8KpnPdCQrtfSIlX4dq1z6lNHLg+gXZ7+28UVhD/IBUT6SFsVGCzQSX6KceZZAOYpmKFfxe9RZYcBBGOM1OXc+IX5wDxY3CEsJYWEX9g7C2V3sX2ZDTOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478853; c=relaxed/simple;
	bh=wACtKrlGkDFD2CehLloQxCXfN3BfTmIwySgtfSfnCcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPSAzaD2EKTyFui7g6QnkQYy0eiR3cwLRcxbBdDnjY6go+rdY6oUEHwQtUOSiMAwLFroXVEf/+7KRgs+Pr1aGQnA3bGgyQWuqxTQy5xJBKoaZfpJXIEBxt9m2cO2WPe9Qq2ro2Tjco7AW/Ll5GnQCPtBDQQedftAeFI1vMuFWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWItHsxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72629C4CED1;
	Thu, 13 Feb 2025 20:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739478852;
	bh=wACtKrlGkDFD2CehLloQxCXfN3BfTmIwySgtfSfnCcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWItHsxi2rqu7ohlJKkIQKfqw+yGev52gT6jsP2BLwJqFvXvxkoFifcYjfKZxQtpD
	 BL45PkBFLAlTB/WlhW0U3oTEgmsrYey3t32btr2V3EYPbSH7OvGsalOKR7ymiYznd7
	 K4lH/kLmKkdvZvK3yGesowGXIHMDlGhD9l4xuYvNYHJWS9agDBhM8uwjO/+Fp3hhKs
	 u4yu9wtTvfLvZx5+kdG+N6Y3Kq8aAy/S/TUOdVooKtrWsEugA7fJ5r7e54/5M/XZnt
	 i/dchSkEHhBbjWSaS03Y0goBDGUf5Aaxpr2XEpWeecZfD9znUtkxqJLi4AYkzaUHKK
	 VUuD2Fr1uFYqA==
Date: Thu, 13 Feb 2025 20:34:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: display: bridge: Document Solomon
 SSD2825
Message-ID: <20250213-pumice-overcrowd-6c22b0d5d66c@spud>
References: <20250213135605.157650-1-clamor95@gmail.com>
 <20250213135605.157650-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RYX6hg1Zf+RyCNrz"
Content-Disposition: inline
In-Reply-To: <20250213135605.157650-2-clamor95@gmail.com>


--RYX6hg1Zf+RyCNrz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 03:56:04PM +0200, Svyatoslav Ryhel wrote:
> Add bindings for Solomon SSD2825 MIPI master bridge chip that connects an
> application processor with traditional parallel LCD interface and an LCD
> driver with MIPI slave interface. The SSD2825 supports both parallel RGB
> interface and serial SPI interface.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../display/bridge/solomon,ssd2825.yaml       | 140 ++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/solo=
mon,ssd2825.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/solomon,ssd=
2825.yaml b/Documentation/devicetree/bindings/display/bridge/solomon,ssd282=
5.yaml
> new file mode 100644
> index 000000000000..cd7ff971495c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.ya=
ml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/solomon,ssd2825.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Solomon SSD2825 RGB to MIPI-DSI bridge
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: solomon,ssd2825
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios: true
> +
> +  dvdd-supply:
> +    description: Regulator for 1.2V digital power supply.
> +
> +  avdd-supply:
> +    description: Regulator for 1.2V analog power supply.
> +
> +  vddio-supply:
> +    description: Regulator for 1.8V IO power supply.
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  spi-cpha: true
> +  spi-cpol: true

Should these be required? Supplies should really be required too, since
the device probably cannot function without them?

> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: tx_clk

Drop the _clk, since this cannot be anything else! clock-names isn't
really useful when you have just one, so I'd be inclined to say remove
it entirely...

> +  solomon,hs-zero-delay-ns:
> +    description:
> +      HS zero delay period
> +    default: 133
> +
> +  solomon,hs-prep-delay-ns:
> +    description:
> +      HS prep delay period
> +    default: 40

Do these two have limits? Use maximum/minimum to set them if so.
Cheers,
Conor.

> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Video port for RGB input
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +            unevaluatedProperties: false
> +
> +            properties:
> +              bus-width:
> +                enum: [ 16, 18, 24 ]
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Video port for DSI output (panel or connector)
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        dsi@2 {
> +            compatible =3D "solomon,ssd2825";
> +            reg =3D <2>;
> +
> +            spi-max-frequency =3D <1000000>;
> +
> +            spi-cpha;
> +            spi-cpol;
> +
> +            reset-gpios =3D <&gpio 114 GPIO_ACTIVE_LOW>;
> +
> +            dvdd-supply =3D <&vdd_1v2>;
> +            avdd-supply =3D <&vdd_1v2>;
> +            vddio-supply =3D <&vdd_1v8_io>;
> +
> +            solomon,hs-zero-delay-ns =3D <300>;
> +            solomon,hs-prep-delay-ns =3D <65>;
> +
> +            clocks =3D <&ssd2825_tx_clk>;
> +            clock-names =3D "tx_clk";
> +
> +            ports {
> +                #address-cells =3D <1>;
> +                #size-cells =3D <0>;
> +
> +                port@0 {
> +                    reg =3D <0>;
> +
> +                    bridge_input: endpoint {
> +                        remote-endpoint =3D <&dpi_output>;
> +                        bus-width =3D <24>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg =3D <1>;
> +
> +                    bridge_output: endpoint {
> +                        remote-endpoint =3D <&panel_input>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> --=20
> 2.43.0
>=20

--RYX6hg1Zf+RyCNrz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ65XPwAKCRB4tDGHoIJi
0hzAAQDseKFgxGQUbrlzreleTOKNbwf6GnuQRkI2MsAuMMiLiwD+LafI+AN+rbRA
1Z3fYDtF78dkCTgVHJYUBJPwzQ7DQwI=
=jDhJ
-----END PGP SIGNATURE-----

--RYX6hg1Zf+RyCNrz--

