Return-Path: <linux-kernel+bounces-548553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C06A54660
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DD61724CA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FEF20967A;
	Thu,  6 Mar 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXW+x91I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5FF20896C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253493; cv=none; b=Q9CsiEaprrTAhuIV4Tv/NrzoPsV2mNdTssZ08XkEp2QDBfKXK+A+1jPFpp5+MBbKuuG0rqxopIk7zA/4QKDIyajxCvsTrJvIw87JgaPsdGApu+JB+8TysgEkhwo6mj+O9HSLrMKd14bgAb4fnyLpLI877xKxPLXLvbxzkDFybSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253493; c=relaxed/simple;
	bh=RhcDDbYqlRBXEgeviCGhkae++jF6e3/y3yy+fAu92Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6U/WoE2WoZXZbUdGgSwhNkAbYR+YkhT6n6ZoUyCKp8X5MsjhPoPtK6abMKEvL/ciwBxRTIunkmkwQ5zupMMxU6zHHBef6CeMLxi9/mCUqze/B1/tR9M0p+SRVch8bXjZdo6FgrZtzUv9IjS8IOXEnofs7lapTpd5CtmX9sxFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXW+x91I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42121C4CEE0;
	Thu,  6 Mar 2025 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741253492;
	bh=RhcDDbYqlRBXEgeviCGhkae++jF6e3/y3yy+fAu92Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXW+x91IoVRFninODxYne2YbBmlqlsTHW3sGFyByZGaCeASs0ct6s8pk8I4s3wqsu
	 9XJZ3coGodUHS6w1BXRkc/cU8cMpQwaOLOZDFcGvWs79taEpdNQb8A/vq4ELQgDnKp
	 Fvs8BI8oRBb3uM40xJrFHgdpHeUACjhB04IjFi/wyGLafe1KXihv9/ISQQVsb+EdA+
	 xEFnEtvHCzTKj1EAQjwf5flOWbeSshoNuqTBdOWdxADodqALwP0QcBHp3P9HUChw/p
	 GauPOZUiD38NSzsYSJyFfUdvLjXP+D9iNCZ7TplkcWaE8NgX3xcBcUue/90OhfRzw9
	 ILtIzMRpQdwpg==
Date: Thu, 6 Mar 2025 10:31:29 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Tejas Vipin <tejasvipin76@gmail.com>, Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
Message-ID: <20250306-clever-lime-tanuki-e2fc43@houat>
References: <20250305-mipi-synaptic-1-v1-1-92017cd19ef6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="iwh2orhppfbbgi4c"
Content-Disposition: inline
In-Reply-To: <20250305-mipi-synaptic-1-v1-1-92017cd19ef6@redhat.com>


--iwh2orhppfbbgi4c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
MIME-Version: 1.0

Hi Anusha,

On Wed, Mar 05, 2025 at 07:01:41PM -0500, Anusha Srivatsa wrote:
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

The point of sending a single patch was to review the coccinelle script,
so you must put the entire script you used here.

> Cc: Maxime Ripard <maxime.ripard@bootlin.com>

That hasn't been my email address for 6 years :)

Maxime

--iwh2orhppfbbgi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8lrbAAKCRAnX84Zoj2+
dpoXAYCV7yoFxitIbgh6uFkLyZ4VLQvsKHGErE0qO7lLyAP6UpBiI05K1CHnneTr
hK5luskBgIRKzxdKeBfGYM99W/seenjHAXgFqBIfp/tOG+FtKuJ2lhIQbycDFiVd
H3tx2dKHIg==
=Ufys
-----END PGP SIGNATURE-----

--iwh2orhppfbbgi4c--

