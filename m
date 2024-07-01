Return-Path: <linux-kernel+bounces-235980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A664491DBFF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73431C229D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924C446436;
	Mon,  1 Jul 2024 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwpS5InK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25FA84D13;
	Mon,  1 Jul 2024 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828188; cv=none; b=Nm5J5SVSifs07X77a4zhAWaXqYE/dF5js778Xeag57z8THH7OPqpgYKX6MUZ5vTkiWZ9PiekhOcwXq9VhuVNZaKuLg+4xXFg6g8Z2WxgszS02rSPNQVGzLgcxCXqy3BTM+2vUmO+bnu0l9c1VyR3m96wXmXaXgf264z++dQpRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828188; c=relaxed/simple;
	bh=rj2CuGZSuorKkqrmqjXwI7PvtbVRpe9ajyOq8suI5Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUpvNP8dpSKo2SM0yoI2Rde3p6gp97vj0p0EmrEbVhCjhNwSndjBUs9aq7E1bpnCtP+ttsH9SGHeHX/c1/6r0PZpQHdMtVMki2rHWhBbkd6LuyrCYuJxoevNOhgfJhUZA5TkYAHDb/fgBgXd3qoEQpJE2MzI+bR1irVwAzO2224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwpS5InK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FB5C116B1;
	Mon,  1 Jul 2024 10:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719828188;
	bh=rj2CuGZSuorKkqrmqjXwI7PvtbVRpe9ajyOq8suI5Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FwpS5InKB0WHeJvDl00B4mDyVpgtWRPch13ta7HsTvTyk2qU9CAm4ahmD+wsEctHc
	 MYCrGVTnrBjo6jvt5GBxaYTB8FxHv2menHZexYacTgYMG0C30VswIdbnWpOZXlztTt
	 OjJMVYyPKMojWhQ9TYdzm6UgIXkrrfyfGqTtDugOOatUeh4SBaU8qxzDDxX4L42Pnt
	 98wTdukcSrqmbqnb6HUV5DX3aayTslixUC5ntsCv8Zos0pLeELIO1eytxsJakjk/Zs
	 E4C/MMklfw5skb2y++k8fvOSz/31hK7nhwNQK6IAM8iTnJREQpK3R8arWmCXukuPdC
	 4l53aEE/qNQBg==
Date: Mon, 1 Jul 2024 11:03:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: megi@xff.cz, javierm@redhat.com, neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com, sam@ravnborg.org, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: display: himax-hx8394: Add Microchip
 AC40T08A MIPI Display panel
Message-ID: <20240701-preset-shredding-409ef0d80ca4@spud>
References: <20240701085837.50855-1-manikandan.m@microchip.com>
 <20240701085837.50855-2-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zEW7h/lfGlnSjTL0"
Content-Disposition: inline
In-Reply-To: <20240701085837.50855-2-manikandan.m@microchip.com>


--zEW7h/lfGlnSjTL0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 02:28:35PM +0530, Manikandan Muralidharan wrote:
> Add compatible string for the Microchip's AC40T08A MIPI Display
> panel.This panel uses a Himax HX8394 display controller.
> The reset line is not populated and leads to driver probe issues,
> thus add conditional block to narrow reset-gpio property per variant.

I really should have asked on v1, but I wasn't sure whether or not the
optional nature of the reset-gpios was specific to your new panel so I
held off: Is it ever the case that a reset-gpio can be provided for this
microchip panel, or just not in the configuration you tested? If it is
never possible, then I'd probably do...

>=20
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
> changes in v2:
> - re-order compatible string alphabetically.
> - Add conditional block to narrow reset-gpio property from required
> list based on compatible string check
> ---
>  .../bindings/display/panel/himax,hx8394.yaml    | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394=
=2Eyaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> index 644387e4fb6f..75ccabff308b 100644
> --- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> @@ -15,14 +15,12 @@ description:
>    such as the HannStar HSD060BHW4 720x1440 TFT LCD panel connected with
>    a MIPI-DSI video interface.
> =20
> -allOf:
> -  - $ref: panel-common.yaml#
> -
>  properties:
>    compatible:
>      items:
>        - enum:
>            - hannstar,hsd060bhw4
> +          - microchip,ac40t08a-mipi-panel
>            - powkiddy,x55-panel
>        - const: himax,hx8394
> =20
> @@ -46,7 +44,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - reset-gpios
>    - backlight
>    - port
>    - vcc-supply
> @@ -54,6 +51,18 @@ required:
> =20
>  additionalProperties: false
> =20
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            enum:
> +              - microchip,ac40t08a-mipi-panel
> +    then:
> +      required:
> +        - reset-gpios

  - if:
      properties:
        compatible:
          const: microchip,ac40t08a-mipi-panel
    then:
      properties:
        reset-gpios: false
    else:
      required:
        - reset-gpios

Otherwise, what you have is fine.

Cheers,
Conor.

>  examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
> --=20
> 2.25.1
>=20

--zEW7h/lfGlnSjTL0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoJ+1gAKCRB4tDGHoIJi
0tMwAP0RreznrdGTlsp+/TMrTBH1CLFSfccb6TiXVFKsF//otwD+L5S9KraEH2JJ
IwJ5jYCHglQ2NnWI9qvTDAwHlg3zYgw=
=TrUD
-----END PGP SIGNATURE-----

--zEW7h/lfGlnSjTL0--

