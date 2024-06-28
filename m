Return-Path: <linux-kernel+bounces-234208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD0091C3B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD94283FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911D1C9EC5;
	Fri, 28 Jun 2024 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSYP1xDF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9A1C2336;
	Fri, 28 Jun 2024 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592040; cv=none; b=LFltV2f/pb+AO2VxrIV33hdMcld6Ek2C4xy558UmMG8YJnvMYBcvUSDP8pk2Sba+j9n63vaokTut3xAKYbuNpEOzD4UwnjkQpfqLzpgVYECLBrzTNv7+lIBAtz3wkaTA/3UDXkvjxvozvFcjMav5xAlP+xbx3WFgQoxSWokhQ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592040; c=relaxed/simple;
	bh=b8temVV0TllxhDo4Ny297auVo63BjKTKc7Hu9KyJGQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUl6llZ83gJltS606p2Me0AAioD3MBppu8TeH2iyAUp2OUQiFQ6BH9m8g5YtLqBps89Y/uCUeHuME35EB8nv/3Oh7lnPWW5haUu9t7/6y5PsEUAr6NsLGcq62yQCRE/0+1gtEhzF7EWWuFfsVD43q+olm4lsqjY6awCY93ycOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSYP1xDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C049C116B1;
	Fri, 28 Jun 2024 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719592040;
	bh=b8temVV0TllxhDo4Ny297auVo63BjKTKc7Hu9KyJGQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aSYP1xDF0sDOfd3XlqFaopvPmmfe6zBNsUmghSX65fM3WHuZWrwuoNTg9boJof6fQ
	 rNZTb4+r4a01b5rTh18QuqAZ8JoTCc2fLmrD2my2MHyAt8dro7xw9WQFqV40oUwctj
	 rGrAY3qwmbhBF2qjNU4eEmzHlelCU+8zvfzoQNvQaNbVLdyco/3SOhsvwtIxi6e8Rw
	 gWwBPUx84gPYcZ1yoeaStvz00qdYswMrz07XZ3FGlbKiN/ai0vlWNGwoipoUhuigvL
	 OP7PrpsiAAUX41gYCnpM8hkPINPm4j8cLDwfAgjx9RI8zzFiiLHOCxRxHgr1CYmITW
	 FOL8i334zE/cQ==
Date: Fri, 28 Jun 2024 17:27:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: st7701: Add Anbernic RG28XX
 panel
Message-ID: <20240628-splashy-slug-1d74e3fd9fe6@spud>
References: <20240628051019.975172-1-kikuchan98@gmail.com>
 <20240628051019.975172-2-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pgsu2z4eVwfR5zRj"
Content-Disposition: inline
In-Reply-To: <20240628051019.975172-2-kikuchan98@gmail.com>


--pgsu2z4eVwfR5zRj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 02:10:15PM +0900, Hironori KIKUCHI wrote:
> The RG28XX panel is a display panel of the Anbernic RG28XX, a handheld
> gaming device from Anbernic. It is 2.8 inches in size (diagonally) with
> a resolution of 480x640.
>=20
> This panel is driven by a variant of the ST7701 driver IC internally,
> confirmed by dumping and analyzing its BSP initialization sequence
> by using a logic analyzer. It is very similar to the existing
> densitron,dmt028vghmcmi-1a panel, but differs in some unknown
> register values, so add a new entry for the panel to distinguish them.
>=20
> Additionally, the panel is connected via SPI instead of MIPI DSI.
> So add and modify for SPI as well.
>=20
> Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> ---
>  .../display/panel/sitronix,st7701.yaml        | 69 +++++++++++++++++--
>  1 file changed, 64 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7=
701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.=
yaml
> index b348f5bf0a9..835ea436531 100644
> --- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
> @@ -20,21 +20,19 @@ description: |
>    Densitron DMT028VGHMCMI-1A is 480x640, 2-lane MIPI DSI LCD panel
>    which has built-in ST7701 chip.
> =20
> -allOf:
> -  - $ref: panel-common.yaml#
> -
>  properties:
>    compatible:
>      items:
>        - enum:
>            - anbernic,rg-arc-panel
> +          - anbernic,rg28xx-panel

Please no wildcards in compatibles - what is the actual model of this
panel? I don't really want to see the model of the handheld here if
possible.

>            - densitron,dmt028vghmcmi-1a
>            - elida,kd50t048a
>            - techstar,ts8550b
>        - const: sitronix,st7701
> =20
>    reg:
> -    description: DSI virtual channel used by that screen
> +    description: DSI / SPI channel used by that screen
>      maxItems: 1
> =20
>    VCC-supply:
> @@ -43,6 +41,13 @@ properties:
>    IOVCC-supply:
>      description: I/O system regulator
> =20
> +  dc-gpios:
> +    maxItems: 1
> +    description:
> +      Controller data/command selection (D/CX) in 4-line SPI mode.
> +      If not set, the controller is in 3-line SPI mode.
> +      Disallowed for DSI.
> +
>    port: true
>    reset-gpios: true
>    rotation: true
> @@ -57,7 +62,38 @@ required:
>    - port
>    - reset-gpios
> =20
> -additionalProperties: false
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            # SPI connected panels
> +            enum:
> +              - anbernic,rg28xx-panel
> +    then:
> +      $ref: /schemas/spi/spi-peripheral-props.yaml

I'm not really keen on this. I'd rather see a different binding for the
SPI version compared to the MIPI ones. Is doing things like this common
for panels? If it is, I'll turn a blind eye..

> +
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              # DSI or SPI without D/CX pin
> +              enum:
> +                - anbernic,rg-arc-panel
> +                - anbernic,rg28xx-panel
> +                - densitron,dmt028vghmcmi-1a
> +                - elida,kd50t048a
> +                - techstar,ts8550b

This is all the compatibles in the file, so nothing is allowed to use
dc-gpios? Why bother adding it?

Confused,
Conor.

> +    then:
> +      required:
> +        - dc-gpios
> +    else:
> +      properties:
> +        dc-gpios: false
> +
> +unevaluatedProperties: false
> =20
>  examples:
>    - |
> @@ -82,3 +118,26 @@ examples:
>              };
>          };
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        panel@0 {
> +            compatible =3D "anbernic,rg28xx-panel", "sitronix,st7701";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <3125000>;
> +            VCC-supply =3D <&reg_lcd>;
> +            IOVCC-supply =3D <&reg_lcd>;
> +            reset-gpios =3D <&pio 8 14 GPIO_ACTIVE_HIGH>; /* LCD-RST: PI=
14 */
> +            backlight =3D <&backlight>;
> +
> +            port {
> +                panel_in_rgb: endpoint {
> +                    remote-endpoint =3D <&tcon_lcd0_out_lcd>;
> +                };
> +            };
> +        };
> +    };
> --=20
> 2.45.2
>=20

--pgsu2z4eVwfR5zRj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn7kYgAKCRB4tDGHoIJi
0pznAQCKC1Je5s1v+LFS2US28Hr1eEQJ2Gs+Thz3sMqhwKdSSQEA0hr0INeGetBN
6uay1QTnj82kx/CUcLALbjyKpRnrPAU=
=OKdQ
-----END PGP SIGNATURE-----

--pgsu2z4eVwfR5zRj--

