Return-Path: <linux-kernel+bounces-543885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE0DA4DB15
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1037A6703
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E133A205AB9;
	Tue,  4 Mar 2025 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBIlVP17"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99E20110B;
	Tue,  4 Mar 2025 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084705; cv=none; b=shqf8mWWm7gQwdA+uGA3CI6Zeojl+b6fKq3+KU2huaoe7nL081kkKEsc6C3LXlgRqw+O09qd2ZH5j2GrifYSvliO8vHoAASEAl7afFzI76L+MMMN2IP8kvpub7Ap6Ov0zsC3aXbSd311jmy/XoBLG3/tycc+fPowqBRO0xhLPwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084705; c=relaxed/simple;
	bh=RFSOtfsshoPLz8uQk8L8GWRmANjFxX7fOK7KFtr+Na4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXYOn/BIFSoHvETzObeX4APhoy3pC6lCOH3/bWkaGZwSIgcAcmN1eMklXaOH7utRWpLTaIO+2n+DzV6MHJ08GlGW5Iq+HkenXs07H2b+L2GxhsvgjCmFH53bX9OKxg9JpAmqFT6d5+L7WKOdgZrAxeCgqd8FgH8Vf4VcyNGxIss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBIlVP17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27447C4CEEA;
	Tue,  4 Mar 2025 10:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741084704;
	bh=RFSOtfsshoPLz8uQk8L8GWRmANjFxX7fOK7KFtr+Na4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBIlVP17++sBd0/E022gkm9RtiMBm//2Qi+0bH3AALgIoFm5IRA7DI3lGvZ2bVNG5
	 tybcB/lslUba8ku09PAh8tAfX36OyFSfLl+kT7so6MODRM+UrdHlBGDJ62l1r9EAvL
	 zLxo1Rz7w78sKNpxaShc46+h07Ab49zACTlqK9e+LRi4zHzFP3BiNiSdx5xP6QDwiq
	 GelHpvK19WOpxRpV9SZfiq0aSWalF6/ufA5c2NW3XGu7MS4He52SKsCEmvlZAOJT92
	 vD+xCB/1oxmqzbPCFqJqqydnneHfgzxc8mE9+ZJNZuI8xDEQa5y4HPmoIFaD/s8gG1
	 GOnjwP/di/Bhg==
Date: Tue, 4 Mar 2025 11:38:21 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH 3/5] dt-bindings: display: simple-bridge: Document DPI
 color encoder
Message-ID: <20250304-wandering-tangible-doberman-5b6dd0@houat>
References: <20250304101530.969920-1-victor.liu@nxp.com>
 <20250304101530.969920-4-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="bzxgqvsj66324ffl"
Content-Disposition: inline
In-Reply-To: <20250304101530.969920-4-victor.liu@nxp.com>


--bzxgqvsj66324ffl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/5] dt-bindings: display: simple-bridge: Document DPI
 color encoder
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 06:15:28PM +0800, Liu Ying wrote:
> A DPI color encoder, as a simple display bridge, converts input DPI color
> coding to output DPI color coding, like Adafruit Kippah DPI hat[1] which
> converts input 18-bit pixel data to 24-bit pixel data(with 2 low padding
> bits in every color component though). Document the DPI color encoder.
>=20
> [1] https://learn.adafruit.com/adafruit-dpi-display-kippah-ttl-tft/downlo=
ads
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

So it's just a bunch of signals that aren't wired / set to the ground? I
assume to free a few GPIOs?

I guess that makes sense.

> ---
>  .../display/bridge/simple-bridge.yaml         | 89 ++++++++++++++++++-
>  1 file changed, 87 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/simple-brid=
ge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.ya=
ml
> index 43cf4df9811a..c1747c033040 100644
> --- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
> @@ -27,6 +27,7 @@ properties:
>            - const: adi,adv7123
>        - enum:
>            - adi,adv7123
> +          - dpi-color-encoder

I don't think we can claim that there's a generic DPI color encoder.
Maybe we can add the prefix dumb or transparent?

>            - dumb-vga-dac
>            - ti,opa362
>            - ti,ths8134
> @@ -37,13 +38,31 @@ properties:
> =20
>      properties:
>        port@0:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
>          description: The bridge input
> =20
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              dpi-color-coding: true
> +
>        port@1:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
>          description: The bridge output
> =20
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              dpi-color-coding: true
> +
>      required:
>        - port@0
>        - port@1
> @@ -61,6 +80,44 @@ required:
> =20
>  additionalProperties: false
> =20
> +allOf:
> +  - $ref: /schemas/display/dpi-color-coding.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: dpi-color-encoder
> +    then:
> +      properties:
> +        ports:
> +          properties:
> +            port@0:
> +              properties:
> +                endpoint:
> +                  required:
> +                    - dpi-color-coding
> +
> +            port@1:
> +              properties:
> +                endpoint:
> +                  required:
> +                    - dpi-color-coding
> +    else:
> +      properties:
> +        ports:
> +          properties:
> +            port@0:
> +              properties:
> +                endpoint:
> +                  properties:
> +                    dpi-color-coding: false
> +
> +            port@1:
> +              properties:
> +                endpoint:
> +                  properties:
> +                    dpi-color-coding: false
> +

Also it complicates the binding enough to warrant for another binding for
that specific "component".

>  examples:
>    - |
>      bridge {
> @@ -88,4 +145,32 @@ examples:
>          };
>      };
> =20
> +  - |
> +    bridge {
> +        compatible =3D "dpi-color-enoder";

You have a typo in the compatible.

Maxime

--bzxgqvsj66324ffl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8bYHQAKCRAnX84Zoj2+
dnKYAYDXEYGM/SkhM244aBGXiRWPgBNNkdS0JzKslX0DQbXTpZSOhu+j9DoBxZpD
xhnqmakBf31E1HXeWp+8D4ryD5j0hPOlhYKCK/WNtwdj1uDThiRlPOEeTDAUrD0G
2tW3JVs+LQ==
=9IBe
-----END PGP SIGNATURE-----

--bzxgqvsj66324ffl--

