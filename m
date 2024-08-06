Return-Path: <linux-kernel+bounces-276524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4699494EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5851C20985
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB55E3FBB3;
	Tue,  6 Aug 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjtuVZBs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607C3BB50;
	Tue,  6 Aug 2024 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959744; cv=none; b=qJjdZyoPAOzzrHytmfbo2b22SAiFZOPk27i9wI6NyqDhvZiwsGkOGQOllvYTW78YnpZZulJHJ8rbUSQpHa0Ko+4FK0cBom9KP8QEkxuNDSoZqtrf5XYlV+Tf086t+gefXjWSx16FRdGvsem5NVT0s+tE4fEsh36EFHKA60jSkic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959744; c=relaxed/simple;
	bh=VLWMu+XGaZ9ljsmZ/RYlnVDMaBW8pidNKeBxbJItLqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS9D739K5iaRFHlL//q7TFK8LfXr+369gG3MrmTa8J6+pIYussjpeu457ukeu3nqDXOaiRQoZ/APU1/d+5kQm0xWTRTIwqYbwN6wdCe+mlcRqk4vH3We0o7Jk7YvjNJZ8NjRAzwqXlpSwN05D3bnue25cHCl3q9K+B6tpL8Uh2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjtuVZBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F1EC32786;
	Tue,  6 Aug 2024 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722959743;
	bh=VLWMu+XGaZ9ljsmZ/RYlnVDMaBW8pidNKeBxbJItLqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjtuVZBssb+fJ+eraMrjCPLdD7DVaSzuVlHjqca8Z8M7WYBn+4ZzOek2T/qAWRxCn
	 E48kCirswlVS9RkBZYHqFx9CGMm8XRsA77I8NeXNl3h3Nkx/+ZePj6Kas9TW1ZzP6Q
	 JloVL2snbcNTftQrYA5vy5ics6aQIPmyUEAFjMi/UZ+FBve2Hi/kJJ2CKitUffYihK
	 vtVZBMcM4/UMpq/coSS0VcaB9jIEaXKu2dGbGUinMe9grytxQx1yQJJuFVHbf+WPKW
	 wQfoHpPA6X+LNuZyu5vV8d5XOrK56C+dQ9Qp59kCrg/EGKuE8CWvsy8leHbnaqcrBO
	 ztiC1xLZrC1tg==
Date: Tue, 6 Aug 2024 16:55:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: Re: [PATCH 2/4] dt-bindings: display: panel-lvds: Add compatible for
 Jenson BL-JT60050-01A
Message-ID: <20240806-slit-drizzle-f66826c4a75d@spud>
References: <20240806133352.440922-1-frieder@fris.de>
 <20240806133352.440922-3-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qMNukOARXmC3ZgtK"
Content-Disposition: inline
In-Reply-To: <20240806133352.440922-3-frieder@fris.de>


--qMNukOARXmC3ZgtK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 03:33:00PM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> The Jenson BL-JT60050-01A is a 7" 1024x600 LVDS display.
>=20
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.y=
aml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> index 155d8ffa8f6ef..5af2d69300751 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> @@ -50,6 +50,8 @@ properties:
>            - hannstar,hsd101pww2
>            # Hydis Technologies 7" WXGA (800x1280) TFT LCD LVDS panel
>            - hydis,hv070wx2-1e0
> +          # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT =
LCD LVDS panel
> +          - jenson,bl-jt60050-01a
>            - tbs,a711-panel
> =20
>        - const: panel-lvds
> --=20
> 2.45.2
>=20

--qMNukOARXmC3ZgtK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrJHeQAKCRB4tDGHoIJi
0uT/AQDZ3oYCjgSl8iA0ZosJw94mLPP8le3GIwiacXplGM09LwEAvrzQHMtQcy3n
o8MCHhrPfEZ67Ng4ZC71UnfjQfSTHgA=
=DsOi
-----END PGP SIGNATURE-----

--qMNukOARXmC3ZgtK--

