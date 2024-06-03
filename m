Return-Path: <linux-kernel+bounces-199229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D9F8D8428
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC69289C8A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4D512D76B;
	Mon,  3 Jun 2024 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ama7ZkBt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39415C3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421961; cv=none; b=h5CoNedWn3USmo8LdnEmwSXh1dm1BDC5grTVozipKh57LptVlXhJJFKTM5xnFjdKtzZeKl9+d52AR0fE08f3I01J2Hx+lhkd7Rhr9z8rQezaO6oRP0pYRoee+o+8fqBboxMmPWU3J1SoN0g2OzBoxkVKJvOuWXIyl3cDTZb5ceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421961; c=relaxed/simple;
	bh=8ok/B/SKwxnEVlrKgCfgnVlO1/oDKY2C3MJSaCwQaKI=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=iZjmpnmd0DyQR9w1zg1c38aDRMYksm3/GIwzUwQqlifY1EwAOaQ7TfkPDS04L87sD+vwtrNrDqsKgVFIQNYfiUwci8PkBjVW4z9tRJMTiFpllv8BenpZvVUBArdHJMSA/LEBaX38SRJc1Uq7bp1600RDHdgzKv+sdgR5/snlpMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ama7ZkBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D301DC2BD10;
	Mon,  3 Jun 2024 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717421961;
	bh=8ok/B/SKwxnEVlrKgCfgnVlO1/oDKY2C3MJSaCwQaKI=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
	b=Ama7ZkBt8NAD6lXZL1WZXHaVHX1FXYyXteTPQgQ492yUo7Jnvdn9tXJijBJ6dgO77
	 71G0wWAVFOzvHxksNLpWzqkwfV5n8xzv2LoOW0CNxq6jPy/ps7DVREjV+vZF7jcbZi
	 JwBBtLAKdZrhnwM+zVJgLFRIQMrTtL7XWx1AfpiljkJGUv3fkCUalwsm8rVn8SxwZ5
	 tdSdNWpTelTvyBLq8rZKmuv/UHHiW4NpV9MDkXJUxoiYF0VGPr1Vp4ATKhB++Vn9Xz
	 HQHGqT1D18+U+a7o9t4vnm1KXAfgKPsU4tknjGmC/QWkel4vQ8nOpihi33R6LVzevz
	 iG9GZKLMN1J6w==
Content-Type: multipart/signed;
 boundary=cf88f22391bd096e9bbbe91854ac9cb1367c0eed60ddb60b6fffffe02fdd;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 03 Jun 2024 15:39:17 +0200
Message-Id: <D1QF9V8N7C06.2SPVUO4K4IMQJ@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>, "Alexander Stein"
 <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 01/20] drm/bridge: add dsi_lp11_notify mechanism
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>, "Chun-Kuang
 Hu" <chunkuang.hu@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Sam Ravnborg"
 <sam@ravnborg.org>, "Vinay Simha BN" <simhavcs@gmail.com>, "Tony Lindgren"
 <tony@atomide.com>, <dri-devel@lists.freedesktop.org>, "Daniel Semkowicz"
 <dse@thaumatec.com>, <linux-kernel@vger.kernel.org>,
 <linux-mediatek@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, "Marek Vasut" <marex@denx.de>
X-Mailer: aerc 0.16.0
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
 <20240506-tc358775-fix-powerup-v1-1-545dcf00b8dd@kernel.org>
 <2189493.irdbgypaU6@steina-w>
 <577v55mspa672t2bqbwwvdtfdgtbj6mpejo3n56qk7bt2j6bt3@q54dfnupcvs4>
In-Reply-To: <577v55mspa672t2bqbwwvdtfdgtbj6mpejo3n56qk7bt2j6bt3@q54dfnupcvs4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--cf88f22391bd096e9bbbe91854ac9cb1367c0eed60ddb60b6fffffe02fdd
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

[+ Marek ]

Hi Dmitry,

> > > Some bridges have very strict power-up reqirements. In this case, the
> > > Toshiba TC358775. The reset has to be deasserted while *both* the DSI
> > > clock and DSI data lanes are in LP-11 mode. After the reset is relase=
d,
> > > the bridge needs the DSI clock to actually be able to process I2C
> > > access. This access will configure the DSI side of the bridge during
> > > which the DSI data lanes have to be in LP-11 mode.
> >=20
> > Apparently this is an issue for a lot of DSI bridges. But enabling LP-1=
1 for
> > a bridge is impossible with current documentation [1], which states "A =
DSI
> > host should keep the PHY powered down until the pre_enable operation is
> > called."
> > Additionally tc358767/tc9595 (DSI-DP bridge) needs LP-11 for AUX channe=
l
> > access to even get EDID. This is a requirement before pre_enable would
> > even be possible.
> >=20
> > So some changes to the current flow are needed. But I am not so sure
> > about LP-11 notification. IMHO a device request to the DSI host to
> > enable LP-11 seems more sensible.
>
> Granted that there can be several DSI devices sharing the DSI bus (aka
> split-link), I was toying with the idea of making the DSI host call
> attached DSI devices when the transition happens.

So almost the same, as this patch?

> I don't have a fully working PoC and I probably won't have it ready til
> the end of May because of the lack of time and different local
> priorities.

Any news regarding this?

-michael

> > Best regards,
> > Alexander
> >=20
> > [1] https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html#mip=
i-dsi-bridge-operation
> >=20
> > > After everything is
> > > configured the video stream can finally be enabled.
> > >=20
> > > This means:
> > >  (1) The bridge has to be configured completely in .pre_enable() op
> > >      (with the clock turned on and data lanes in LP-11 mode, thus
> > >      .pre_enable_prev_first has to be set).
> > >  (2) The bridge will enable its output in the .enable() op
> > >  (3) There must be some mechanism before (1) where the bridge can
> > >      release its reset while the clock lane is still in LP-11 mode.
> > >=20
> > > Unfortunately, (3) is crucial for a correct operation of the bridge.
> > > To satisfy this requriment, introduce a new callback .dsi_lp11_notify=
()
> > > which will be called by the DSI host driver.
> > >=20
> > > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > > ---
> > >  drivers/gpu/drm/drm_bridge.c | 16 ++++++++++++++++
> > >  include/drm/drm_bridge.h     | 12 ++++++++++++
> > >  2 files changed, 28 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridg=
e.c
> > > index 28abe9aa99ca..98cd6558aecb 100644
> > > --- a/drivers/gpu/drm/drm_bridge.c
> > > +++ b/drivers/gpu/drm/drm_bridge.c
> > > @@ -1339,6 +1339,22 @@ void drm_bridge_hpd_notify(struct drm_bridge *=
bridge,
> > >  }
> > >  EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
> > > =20
> > > +/**
> > > + * drm_bridge_dsi_lp11_notify - notify clock/data lanes LP-11 mode
> > > + * @bridge: bridge control structure
> > > + *
> > > + * DSI host drivers shall call this function while the clock and dat=
a lanes
> > > + * are still in LP-11 mode.
> > > + *
> > > + * This function shall be called in a context that can sleep.
> > > + */
> > > +void drm_bridge_dsi_lp11_notify(struct drm_bridge *bridge)
> > > +{
> > > +	if (bridge->funcs->dsi_lp11_notify)
> > > +		bridge->funcs->dsi_lp11_notify(bridge);
> > > +}
> > > +EXPORT_SYMBOL_GPL(drm_bridge_dsi_lp11_notify);
> > > +
> > >  #ifdef CONFIG_OF
> > >  /**
> > >   * of_drm_find_bridge - find the bridge corresponding to the device =
node in
> > > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > > index 4baca0d9107b..4ef61274e0a8 100644
> > > --- a/include/drm/drm_bridge.h
> > > +++ b/include/drm/drm_bridge.h
> > > @@ -630,6 +630,17 @@ struct drm_bridge_funcs {
> > >  	 */
> > >  	void (*hpd_disable)(struct drm_bridge *bridge);
> > > =20
> > > +	/**
> > > +	 * dsi_lp11_notify:
> > > +	 *
> > > +	 * Will be called by the DSI host driver while both the DSI clock
> > > +	 * lane as well as the DSI data lanes are in LP-11 mode. Some bridg=
es
> > > +	 * need this state while releasing the reset, for example.
> > > +	 * Not all DSI host drivers will support this. Therefore, the DSI
> > > +	 * bridge driver must not rely on this op to be called.
> > > +	 */
> > > +	void (*dsi_lp11_notify)(struct drm_bridge *bridge);
> > > +
> > >  	/**
> > >  	 * @debugfs_init:
> > >  	 *
> > > @@ -898,6 +909,7 @@ void drm_bridge_hpd_enable(struct drm_bridge *bri=
dge,
> > >  void drm_bridge_hpd_disable(struct drm_bridge *bridge);
> > >  void drm_bridge_hpd_notify(struct drm_bridge *bridge,
> > >  			   enum drm_connector_status status);
> > > +void drm_bridge_dsi_lp11_notify(struct drm_bridge *bridge);
> > > =20
> > >  #ifdef CONFIG_DRM_PANEL_BRIDGE
> > >  bool drm_bridge_is_panel(const struct drm_bridge *bridge);
> > >=20
> > >=20
> >=20
> >=20
> > --=20
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > http://www.tq-group.com/
> >=20
> >=20


--cf88f22391bd096e9bbbe91854ac9cb1367c0eed60ddb60b6fffffe02fdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZl3HhRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hJ/wGAw2m9ArER859FOX3/ufX868fxyr9c1boA
J86YUXL6ZuonhsRMn8ngQOdVuJ7y6utcAYCcUCASrAqhAH+4jYUtnCXxQuLuhf2/
ihY9uYV8vOVfpkcfMsUIIB3coGCTAA4a1ug=
=Dse2
-----END PGP SIGNATURE-----

--cf88f22391bd096e9bbbe91854ac9cb1367c0eed60ddb60b6fffffe02fdd--

