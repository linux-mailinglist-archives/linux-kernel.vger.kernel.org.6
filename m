Return-Path: <linux-kernel+bounces-555575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA21A5B9D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FDD1894304
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3322222CD;
	Tue, 11 Mar 2025 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm9JOtjc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D11F874E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678259; cv=none; b=XUiIGpralCI7Yx/W8zvZol6Ak7r+Zxjxd6xKqmDEd53c5CC1qIGQof5quxgDXDfNjwUCy0md42AzGUMIRJz1qA01LE4dDNyQ6/1IcqSIPD7Bw3uxPnhbczEGhap99MxD/rgBT2EUMCFvp/EbGnK+vrAM0wFtLzT0NEn4bF+IIiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678259; c=relaxed/simple;
	bh=6ptZt8W9PzGYxBsoNW9hgth6W4PsnPj1HOAvttTz8uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCOTSzu4BgVoryDZ6K0HUHbnw5Vt5HTUvvkP8uUYig6tSBQ1NYgNwgYXDZtoAj43eGJ3vWduq8tLIIikCzWis2j5rINor/guMpVng2ycFIewhk6wnvtkSwzHICOJMd2vIA+lGbJVTw7W+3Ztrad9hEvIte6JaFldatyowppUto8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm9JOtjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF120C4CEE9;
	Tue, 11 Mar 2025 07:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741678259;
	bh=6ptZt8W9PzGYxBsoNW9hgth6W4PsnPj1HOAvttTz8uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hm9JOtjcqc1SNJz4wc5g8742zi6JTP1ZsA53aqShmsFgc/9mO5aPMDhxqpEI9ZYN4
	 7/W5iMWLwSEbqzmC0fjowOo2zu3JC3mlslxTCFRflQV3VV1X+QAtcaegD9kftiZaSL
	 fM4atI9YqgbPAkiLOm7kVAp+Ax/JnsZaB+fYNVw6vL7koJkEzFB8yRLm+fVXNROOdD
	 j9b2VFGqt3C7xVjj07QRIXrSZN/WdH7rkJbige+2IldRf5KwxkE7GhjjHx4XSsKa9N
	 mOypXMkv90n66EbgpXGMj2txElg1PnkxDQSaJqyjC76Y78PUWSbvGfAJdOP+r7A5UY
	 e/YV7JXHBdxrQ==
Date: Tue, 11 Mar 2025 08:30:56 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Tejas Vipin <tejasvipin76@gmail.com>, Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] drm/panel/synaptics-r63353: Use _multi variants
Message-ID: <20250311-warm-icy-rottweiler-cefcdd@houat>
References: <20250310-mipi-synaptic-1-v2-1-20ee4397c670@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3msoj54ufxrpizvm"
Content-Disposition: inline
In-Reply-To: <20250310-mipi-synaptic-1-v2-1-20ee4397c670@redhat.com>


--3msoj54ufxrpizvm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] drm/panel/synaptics-r63353: Use _multi variants
MIME-Version: 1.0

On Mon, Mar 10, 2025 at 04:58:22PM -0400, Anusha Srivatsa wrote:
> Move away from using deprecated API and use _multi
> variants if available. Use mipi_dsi_msleep()
> and mipi_dsi_usleep_range() instead of msleep()
> and usleep_range() respectively.
>=20
> Used Coccinelle to find the multiple occurences.
> SmPl patch:
> @rule@
> identifier dsi_var;
> identifier r;
> identifier func;
> type t;
> position p;
> expression dsi_device;
> expression list es;
> @@
> t func(...) {
> ...
> struct mipi_dsi_device *dsi_var =3D dsi_device;
> +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> <+...
> (
> -mipi_dsi_dcs_write_seq(dsi_var,es)@p;
> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
> |
> -mipi_dsi_generic_write_seq(dsi_var,es)@p;
> +mipi_dsi_generic_write_seq_multi(&dsi_ctx,es);
> |
> -mipi_dsi_generic_write(dsi_var,es)@p;
> +mipi_dsi_generic_write_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_nop(dsi_var)@p;
> +mipi_dsi_dcs_nop_multi(&dsi_ctx);
> |
> ....rest of API
> ..
> )
> -if(r < 0) {
> -...
> -}
> ...+>

Again, you need to provide the full coccinelle script here otherwise
it's useless. And I have serious doubts that it's actually the script
you used, because ...

> @@ -106,53 +107,46 @@ static int r63353_panel_power_off(struct r63353_pan=
el *rpanel)
>  static int r63353_panel_activate(struct r63353_panel *rpanel)
>  {
>  	struct mipi_dsi_device *dsi =3D rpanel->dsi;
> -	struct device *dev =3D &dsi->dev;
> -	int i, ret;
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
> +	int i;
> =20
> -	ret =3D mipi_dsi_dcs_soft_reset(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to do Software Reset (%d)\n", ret);
> +	mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
> +	if (dsi_ctx.accum_err)
>  		goto fail;
> -	}

This changes was definitely not what the script is doing.

Maxime

--3msoj54ufxrpizvm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ8/mrwAKCRDj7w1vZxhR
xaVXAP98kanq9Agy3UxY4yV8gi6eRHDpADPZ362A29nVqTaqDQD/bSjaKpH9TL2w
y3HcrZBloZtnBL7lnxKDIKDEJT3cjws=
=aG2R
-----END PGP SIGNATURE-----

--3msoj54ufxrpizvm--

