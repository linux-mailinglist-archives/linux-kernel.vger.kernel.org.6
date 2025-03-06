Return-Path: <linux-kernel+bounces-549455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F05BA552D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AA53AD74B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1078625C709;
	Thu,  6 Mar 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2HQDWII"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AAE25A633
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281642; cv=none; b=YuMqOH4AlLgWHR4N9K6huQQymHj15VYFtfiI+cvc/dpuZ5SkFUJdOSrjefgAFjI5FuZRamLbeptzskvJQ6L173WI8I8ZKKa+44MKh3eTv3eL0ipxNNYEA1amaBfIuCL/DxSV/NeiP3amREpCs7qC2YE3hgZqNHZkGTbueWhXGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281642; c=relaxed/simple;
	bh=wBQrFkccoLNKzdS8ILzs3KY+o3I3a5Wty8xau+DEjDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvAj4bkvfpFb+wM0b2DV/Ll3uM/LbJPo80Ln7G65xWXpu/Hp+9MGY70/1AqL19niWorI/ZSANPhukixUvr6TEygAanpH3wHDbYAhSOk2JAekBt13EVtVAJLi2r1PfX1T1VG/51CBXFm74Xm1m+GSf7TuDGCtorvR/Zwn5e67GA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2HQDWII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FB6C4CEE0;
	Thu,  6 Mar 2025 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741281641;
	bh=wBQrFkccoLNKzdS8ILzs3KY+o3I3a5Wty8xau+DEjDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2HQDWIIdXthpvoBQc1ZnZ62bkc+zTsA3e76yUv0Ea7wxwAkj1KJ4K9i0nFRcx47o
	 eyUCexc61D7sfJceMNKXnol297ddZpBcMJQ4ZU9sJi8oQ0u4cQr+S/wqynLb8tSRbB
	 kfGs4gsrW4c4fyFCI5492lHNrAXBT0ZlS/XsfnSBn/eXB+M0620iPD7afqWTnSZMX8
	 fgbGNFXRRqB9vwXBvr8UsV+hSSgD7z7ZRnSExQdsXrK+72j2GkoaU0ccqg2MwBRQSL
	 G2W+YoxuaNoqsHG19AakiXF2tjitQZY7voXka5VduCAJWqa+vROeB34DsWsawxHovR
	 wiu7fD8VSBMSw==
Date: Thu, 6 Mar 2025 18:20:39 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Tejas Vipin <tejasvipin76@gmail.com>, Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
Message-ID: <20250306-brave-wonderful-sambar-3d0bc5@houat>
References: <20250305-mipi-synaptic-1-v1-1-92017cd19ef6@redhat.com>
 <20250306-clever-lime-tanuki-e2fc43@houat>
 <CAN9Xe3SDyC47HWww1eH63aZOiM-WF9BGxztM3yh9bf6ORuY7VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a2tzjc6usivaxcnz"
Content-Disposition: inline
In-Reply-To: <CAN9Xe3SDyC47HWww1eH63aZOiM-WF9BGxztM3yh9bf6ORuY7VA@mail.gmail.com>


--a2tzjc6usivaxcnz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
MIME-Version: 1.0

On Thu, Mar 06, 2025 at 10:08:24AM -0500, Anusha Srivatsa wrote:
> On Thu, Mar 6, 2025 at 4:31=E2=80=AFAM Maxime Ripard <mripard@kernel.org>=
 wrote:
>=20
> > Hi Anusha,
> >
> > On Wed, Mar 05, 2025 at 07:01:41PM -0500, Anusha Srivatsa wrote:
> > > Move away from using deprecated API and use _multi
> > > variants if available. Use mipi_dsi_msleep()
> > > and mipi_dsi_usleep_range() instead of msleep()
> > > and usleep_range() respectively.
> > >
> > > Used Coccinelle to find the multiple occurences.
> > > SmPl patch:
> > > @rule@
> > > identifier dsi_var;
> > > identifier r;
> > > identifier func;
> > > type t;
> > > position p;
> > > expression dsi_device;
> > > expression list es;
> > > @@
> > > t func(...) {
> > > ...
> > > struct mipi_dsi_device *dsi_var =3D dsi_device;
> > > +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> > > <+...
> > > (
> > > -mipi_dsi_dcs_write_seq(dsi_var,es)@p;
> > > +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
> > > |
> > > -mipi_dsi_generic_write_seq(dsi_var,es)@p;
> > > +mipi_dsi_generic_write_seq_multi(&dsi_ctx,es);
> > > |
> > > -mipi_dsi_generic_write(dsi_var,es)@p;
> > > +mipi_dsi_generic_write_multi(&dsi_ctx,es);
> > > |
> > > -r =3D mipi_dsi_dcs_nop(dsi_var)@p;
> > > +mipi_dsi_dcs_nop_multi(&dsi_ctx);
> > > |
> > > ....rest of API
> > > ..
> > > )
> > > -if(r < 0) {
> > > -...
> > > -}
> > > ...+>
> >
> > The point of sending a single patch was to review the coccinelle script,
> > so you must put the entire script you used here.
>
> I was actually thinking of sending patches per driver this time around
> since Tejas also seems to be looking into similar parts....Thoughts?

Not really?

The point of doing it with one driver was to make sure the coccinelle
script was fine before rolling it to other drivers. And actually, it
doesn't really matter: the whole point of putting the script in the
commit log is to be able to review and document the script you used. If
you're not going to put the one you used, it's kind of pointless.

And yeah, you should absolutely sync with Tejas, but it's unrelated to
coccinelle.

Maxime

--a2tzjc6usivaxcnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ8nZZgAKCRDj7w1vZxhR
xW3gAP90FBgkKfaIjre5FofZma/Apts2Ots6x06y7OCa4t1ZPgEAjoZOTj20Ifa1
NHwlSK9hDMf0DG8pbUsU6LwJaOaV9g8=
=WpR3
-----END PGP SIGNATURE-----

--a2tzjc6usivaxcnz--

