Return-Path: <linux-kernel+bounces-543894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E52A4DB43
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EAAA3A502E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B87C1FF1C1;
	Tue,  4 Mar 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yxqyov7g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541251FCFE7;
	Tue,  4 Mar 2025 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084907; cv=none; b=X39Qs+Rd2e8Ftj1lVtlV0dRheaA5Cie9arzy8LjZi6nDR/Vr6QfoLrvKZWvg3QZ2A04uCnqSZ8tXqRTUmFRHliV13IumQ9dc7OTdZSz7K1TaQibPNWFXj4Yp5djXrlhuoZfyJmb83bMmNvPoiiBWZqPokHCj7u8t33hJr2ThwQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084907; c=relaxed/simple;
	bh=fH0fOlyigILpZQf9CtDXVvcvx+MFI1+wMcAyGLpTuZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QANVmS6Zyzqd6xqfNTWLcfMshj3PW0czHkQ1NVn9CJOZQEJPnALsX6O/+HHzfCfr19bNNmCWv8uA3us/cXHjA0EyV5WsmDHobWYKRcHm7os2/Nw+9a9EGVzOlw78nU+Cg5BtM9sUSA491BQM25jkTHocg2iONExHx3pySNF1ljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yxqyov7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D39C4CEE5;
	Tue,  4 Mar 2025 10:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741084907;
	bh=fH0fOlyigILpZQf9CtDXVvcvx+MFI1+wMcAyGLpTuZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yxqyov7gSZLMx3iMM3JIGSb/2W+3tDwsao7G6fNjoxAThtUWkmQ1qIqlGCXURUAR6
	 1n1+kEJhcC4Ml0DqVVJ0WsiMWQlQVWZDAwqJ0uHOSbUPtBF6q5r1OmSwbWKlM7s97R
	 Gj3FJzZds7GGvuuzma4ELAp9uWk+5ByUwP1A+wq4wqkYWdqXB5XHnXVVSunm79NDXk
	 poKPLOSWhDFaNgwyf0MxAzX9YNo0mn/wiN67lC6v4X0dz0xy1VIvwlUaa4p1yiNsT3
	 bXl/fQr97KnIG1XeMUUH+ad5d8BIbFyK4sDdYE+QWd+/o42rXSAunndJ8B8iskSUiK
	 PGHEpYl2tMb/w==
Date: Tue, 4 Mar 2025 11:41:44 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH 5/5] drm/bridge: simple-bridge: Add next panel support
Message-ID: <20250304-interesting-solemn-potoo-fd4c6e@houat>
References: <20250304101530.969920-1-victor.liu@nxp.com>
 <20250304101530.969920-6-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ykwvdkugqkulwx5n"
Content-Disposition: inline
In-Reply-To: <20250304101530.969920-6-victor.liu@nxp.com>


--ykwvdkugqkulwx5n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/5] drm/bridge: simple-bridge: Add next panel support
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 06:15:30PM +0800, Liu Ying wrote:
> The next bridge connected to a simple bridge could be a panel, e.g.,
> a DPI panel connected to a DPI color encoder. Add the next panel support,
> instead of supporting non-panel next bridge only.
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig         |  1 +
>  drivers/gpu/drm/bridge/simple-bridge.c | 32 ++++++++++++++++----------
>  2 files changed, 21 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index d20f1646dac2..92187dbdd32b 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -310,6 +310,7 @@ config DRM_SIMPLE_BRIDGE
>  	tristate "Simple DRM bridge support"
>  	depends on OF
>  	select DRM_KMS_HELPER
> +	select DRM_PANEL_BRIDGE
>  	help
>  	  Support for non-programmable DRM bridges, such as ADI ADV7123, TI
>  	  THS8134 and THS8135 or passive resistor ladder DACs.
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bri=
dge/simple-bridge.c
> index c0445bd20e07..4c585e5583ca 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -19,6 +19,7 @@
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
> =20
> @@ -35,6 +36,7 @@ struct simple_bridge {
>  	const struct simple_bridge_info *info;
> =20
>  	struct drm_bridge	*next_bridge;
> +	struct drm_panel	*next_panel;
>  	struct regulator	*vdd;
>  	struct gpio_desc	*enable;
> =20
> @@ -114,6 +116,10 @@ static int simple_bridge_attach(struct drm_bridge *b=
ridge,
>  	struct simple_bridge *sbridge =3D drm_bridge_to_simple_bridge(bridge);
>  	int ret;
> =20
> +	if (sbridge->next_panel)
> +		return drm_bridge_attach(bridge->encoder, sbridge->next_bridge,
> +					 bridge, flags);
> +
>  	ret =3D drm_bridge_attach(bridge->encoder, sbridge->next_bridge, bridge,
>  				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>  	if (ret < 0)
> @@ -247,7 +253,6 @@ static int simple_bridge_get_dpi_color_coding(struct =
simple_bridge *sbridge,
>  static int simple_bridge_probe(struct platform_device *pdev)
>  {
>  	struct simple_bridge *sbridge;
> -	struct device_node *remote;
>  	int ret;
> =20
>  	sbridge =3D devm_kzalloc(&pdev->dev, sizeof(*sbridge), GFP_KERNEL);
> @@ -257,17 +262,20 @@ static int simple_bridge_probe(struct platform_devi=
ce *pdev)
>  	sbridge->info =3D of_device_get_match_data(&pdev->dev);
> =20
>  	/* Get the next bridge in the pipeline. */
> -	remote =3D of_graph_get_remote_node(pdev->dev.of_node, 1, -1);
> -	if (!remote)
> -		return -EINVAL;
> -
> -	sbridge->next_bridge =3D of_drm_find_bridge(remote);
> -	of_node_put(remote);
> -
> -	if (!sbridge->next_bridge) {
> -		dev_dbg(&pdev->dev, "Next bridge not found, deferring probe\n");
> -		return -EPROBE_DEFER;
> -	}
> +	ret =3D drm_of_find_panel_or_bridge(pdev->dev.of_node, 1, -1,
> +					  &sbridge->next_panel,
> +					  &sbridge->next_bridge);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Next panel or bridge not found\n");
> +
> +	if (sbridge->next_panel)
> +		sbridge->next_bridge =3D devm_drm_panel_bridge_add(&pdev->dev,
> +								 sbridge->next_panel);
> +
> +	if (IS_ERR(sbridge->next_bridge))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sbridge->next_bridge),
> +				     "Next bridge not found\n");

This makes sense in general, but I think a better approach would be to
use devm/drmm_of_get_bridge here.

Maxime

--ykwvdkugqkulwx5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8bY6AAKCRAnX84Zoj2+
dukwAYDXaQPs/ZdtTpvvPxoJ2VheWo7NhAt5NM4CP5W9+m84/PR4GEaJUqeWHctG
eaCaTKcBfAwpXe9Lnbsr8to3t8H67azDq8SOt5WAmHm/EKzOjpWE8WW2eu9zuRGP
Zu6gtnGcTQ==
=KTPS
-----END PGP SIGNATURE-----

--ykwvdkugqkulwx5n--

