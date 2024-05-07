Return-Path: <linux-kernel+bounces-170881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6A78BDD3C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7620E1C211FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C9014D2B3;
	Tue,  7 May 2024 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="CbKJNRCU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="QPZnrgN6"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F314D2A8
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071091; cv=none; b=fXo4Jkv1VqvG4SjszeKYoH8Z+Bc4pvXUQIjVkMGb1AOgDAMvkyDL7Y+Ap1tTP7gJzKomggSWVOHd4m6kjvfvxyjEd/NevfiRaCy1UGDo8QT00iVH+uYH4AEVUDJSThYdQV1gnKVC2M6wFgEyTwE4og86/FfZR0wq3TKP4Xj9+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071091; c=relaxed/simple;
	bh=fzRaJfp8JIxCQg7TmCn8IaPbJLJAHwv7IzgeRHqcbQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5D6oCCi2G76bQZ2RoMnmxhKgisuTTIeC5cdfMBdgAqqL+nHkKAESj+iU8X0rFzQgM0Prywi77LSMgmQgRjvB8IT/eBTcA1yp7Xk+bRSedUPJZoojy3+c227OnLLTNwt2iXHJA2RYIBS7lKXKaoiPeY2j6DKdvY/gAZaCAOitBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=CbKJNRCU; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=QPZnrgN6 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1715071088; x=1746607088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kCgSfPagde6d/ABPspOMI3lsg3aDrKX9SBMWiVfXbrc=;
  b=CbKJNRCUv1yfRewP1qvUhWIsUjogdXN6oLYE+a30SxGOJN/G4L0sGgm9
   ixnY9tj4Ny0d9WorMwemO0FfoqBpYPrXu+vSpNfVm9smmn0Lm80Cjs+KB
   0BIf3WF98fCgJPpk37UTYsIlta+B+5B5h825J5d5j9339TXm8eMlAUib/
   vkLWr4ryTgsJNINuBP2O678E2zCn8E6E4ZFSNwkUsV/iRmfh4g9Q+4WPi
   9hxEcRO9Z5OtOZL+GJ1UiwR3NIig3VqoqqByVpmiKDspXiNzqI9MJhrzB
   rwKKCbypjClxQ9CsO/l+KQueEcy9yIgn+s2xeLG5hwyzt6EQre6t/rEh/
   w==;
X-CSE-ConnectionGUID: Svc8qAVLTSiOeuN7nyehnw==
X-CSE-MsgGUID: 2I61W6DfS5iDfT/LbGMx+A==
X-IronPort-AV: E=Sophos;i="6.07,260,1708383600"; 
   d="scan'208";a="36780743"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 May 2024 10:37:59 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DEE5D176472;
	Tue,  7 May 2024 10:37:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1715071075;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kCgSfPagde6d/ABPspOMI3lsg3aDrKX9SBMWiVfXbrc=;
	b=QPZnrgN6o+h3vyUvwj0wVo0UJUUiAfyFAdHT8nXdQARRbD1/AQQiMaWv0HDsoNBFU5vZjG
	nYWxaj4Vez9+E8JSKgUhbSG0VdkE2LUrGCrv4RVUkR2xXf3HE7/zjdAHdV8gBsixT2+JUF
	9jEl6x11SaXvMgiRVfxKDyscOmjcJAgVVL3lsyNrwPmvo8ZF+HRF4lzq2WX1eJxacxiFXF
	hDmzArHEU3NCrhtti+I/ZT7hxC9ZY76n9F0mRkuDpXA0CABTRLgYVWMpi51wx19+Hs5xNq
	lW3wq92IuckX2fFQaO5zs4Q6Ys4Ux5UN+Ia2VwfB/yeifesQ4q9efaWFv5dlxw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sam Ravnborg <sam@ravnborg.org>, Vinay Simha BN <simhavcs@gmail.com>, Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org, Michael Walle <mwalle@kernel.org>
Cc: Daniel Semkowicz <dse@thaumatec.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH 01/20] drm/bridge: add dsi_lp11_notify mechanism
Date: Tue, 07 May 2024 10:37:54 +0200
Message-ID: <2189493.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240506-tc358775-fix-powerup-v1-1-545dcf00b8dd@kernel.org>
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org> <20240506-tc358775-fix-powerup-v1-1-545dcf00b8dd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Michael,

Am Montag, 6. Mai 2024, 15:34:30 CEST schrieb Michael Walle:
> Some bridges have very strict power-up reqirements. In this case, the
> Toshiba TC358775. The reset has to be deasserted while *both* the DSI
> clock and DSI data lanes are in LP-11 mode. After the reset is relased,
> the bridge needs the DSI clock to actually be able to process I2C
> access. This access will configure the DSI side of the bridge during
> which the DSI data lanes have to be in LP-11 mode.

Apparently this is an issue for a lot of DSI bridges. But enabling LP-11 for
a bridge is impossible with current documentation [1], which states "A DSI
host should keep the PHY powered down until the pre_enable operation is
called."
Additionally tc358767/tc9595 (DSI-DP bridge) needs LP-11 for AUX channel
access to even get EDID. This is a requirement before pre_enable would
even be possible.

So some changes to the current flow are needed. But I am not so sure
about LP-11 notification. IMHO a device request to the DSI host to
enable LP-11 seems more sensible.

Best regards,
Alexander

[1] https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html#mipi-ds=
i-bridge-operation

> After everything is
> configured the video stream can finally be enabled.
>=20
> This means:
>  (1) The bridge has to be configured completely in .pre_enable() op
>      (with the clock turned on and data lanes in LP-11 mode, thus
>      .pre_enable_prev_first has to be set).
>  (2) The bridge will enable its output in the .enable() op
>  (3) There must be some mechanism before (1) where the bridge can
>      release its reset while the clock lane is still in LP-11 mode.
>=20
> Unfortunately, (3) is crucial for a correct operation of the bridge.
> To satisfy this requriment, introduce a new callback .dsi_lp11_notify()
> which will be called by the DSI host driver.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/gpu/drm/drm_bridge.c | 16 ++++++++++++++++
>  include/drm/drm_bridge.h     | 12 ++++++++++++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 28abe9aa99ca..98cd6558aecb 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1339,6 +1339,22 @@ void drm_bridge_hpd_notify(struct drm_bridge *brid=
ge,
>  }
>  EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
> =20
> +/**
> + * drm_bridge_dsi_lp11_notify - notify clock/data lanes LP-11 mode
> + * @bridge: bridge control structure
> + *
> + * DSI host drivers shall call this function while the clock and data la=
nes
> + * are still in LP-11 mode.
> + *
> + * This function shall be called in a context that can sleep.
> + */
> +void drm_bridge_dsi_lp11_notify(struct drm_bridge *bridge)
> +{
> +	if (bridge->funcs->dsi_lp11_notify)
> +		bridge->funcs->dsi_lp11_notify(bridge);
> +}
> +EXPORT_SYMBOL_GPL(drm_bridge_dsi_lp11_notify);
> +
>  #ifdef CONFIG_OF
>  /**
>   * of_drm_find_bridge - find the bridge corresponding to the device node=
 in
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 4baca0d9107b..4ef61274e0a8 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -630,6 +630,17 @@ struct drm_bridge_funcs {
>  	 */
>  	void (*hpd_disable)(struct drm_bridge *bridge);
> =20
> +	/**
> +	 * dsi_lp11_notify:
> +	 *
> +	 * Will be called by the DSI host driver while both the DSI clock
> +	 * lane as well as the DSI data lanes are in LP-11 mode. Some bridges
> +	 * need this state while releasing the reset, for example.
> +	 * Not all DSI host drivers will support this. Therefore, the DSI
> +	 * bridge driver must not rely on this op to be called.
> +	 */
> +	void (*dsi_lp11_notify)(struct drm_bridge *bridge);
> +
>  	/**
>  	 * @debugfs_init:
>  	 *
> @@ -898,6 +909,7 @@ void drm_bridge_hpd_enable(struct drm_bridge *bridge,
>  void drm_bridge_hpd_disable(struct drm_bridge *bridge);
>  void drm_bridge_hpd_notify(struct drm_bridge *bridge,
>  			   enum drm_connector_status status);
> +void drm_bridge_dsi_lp11_notify(struct drm_bridge *bridge);
> =20
>  #ifdef CONFIG_DRM_PANEL_BRIDGE
>  bool drm_bridge_is_panel(const struct drm_bridge *bridge);
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



