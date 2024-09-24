Return-Path: <linux-kernel+bounces-336783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD47E9840C3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7022C287583
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B743150994;
	Tue, 24 Sep 2024 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="P1MwDCGz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="iVAqqYQy"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF314F10F;
	Tue, 24 Sep 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167298; cv=none; b=Z7BxtVnnCwF83p3Xp+7etvAbFCr/Qe4M2YGhWFgNPXOlgUsO2Mb1s6w65+V7snWtaf6x93y+QB2+QYTZr9iXShiuf+hvLvpWPSTJryr+xOopdxn8Vf3kPiL0B+dT/MPWo1zO8u4sAh867NDtcKdQOU5e8CpJZxqipxYfujczUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167298; c=relaxed/simple;
	bh=7DdpWnQjXrKOgc3LpFHDzlOBfC8glK+aB0geVhDlsww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3gD9jE6x1MxZjk9Z6iRXdcQxkdrnBgE2zARjn20YD5K7urlmFRBQxFmwsQ+w3pngSuHo7zbHppenVfQq7xAQobiOZkFb/537nLafvWuJfS4uYWnWU0cNqR5gOxgQLgHQ2hLTYgxliJ/R6ZMVd6VS8qDDkAwukqdovKX4q+ARlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=P1MwDCGz; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=iVAqqYQy reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1727167294; x=1758703294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=94JhhSqRQRupCtsnu1jPyU8mbjFFU1ugSNyOVeLAgTU=;
  b=P1MwDCGzemC5BdkFGAdGAeu0eLbV7ttcJlH0WugLNSmUQ40XszuJrmYO
   qjV0MFMRaJ2U8GJJxOsUffkarPy4W81LoM8/2d51RyydU8QOkdYcf/6uj
   SpWMQn7Frn3qRaGlCDpPADdAq/ZgbNlRnIdcrIp6gKxQeVSY9ccZ08jF0
   nJOXAAraDRPOzd0UOqdiA/grEQCfBir8J3jnMoTC7TWw4nJKk7gMM28rH
   ZNNi4zNbt0+bHKCtIppggzgxd8HUbvsDOCOfjI09Gc9C3MmuM8qzMtq7I
   QUlw24H3HumWoLsSNultOgbnPWovD/J/qSQzCTqB0a96WFpLW0TxjycN3
   g==;
X-CSE-ConnectionGUID: HYHhDl3FRLe2UDLHD2H8Eg==
X-CSE-MsgGUID: lh+Hh1IZSMWCk0QEHSASpw==
X-IronPort-AV: E=Sophos;i="6.10,254,1719871200"; 
   d="scan'208";a="39088260"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Sep 2024 10:41:31 +0200
X-CheckPoint: {66F27B3B-6-B8661266-C8AC785A}
X-MAIL-CPID: ED0BAF8E49DE59BF9E9DC9356ED979B3_5
X-Control-Analysis: str=0001.0A682F1B.66F27B3B.011D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF5591634CC;
	Tue, 24 Sep 2024 10:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1727167286;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=94JhhSqRQRupCtsnu1jPyU8mbjFFU1ugSNyOVeLAgTU=;
	b=iVAqqYQyAW2GfXjszyBFCEiYNDxoY1nFVTFIhq6CqYbygQFwC3qMhMgPA5t+m5K55GhQKu
	XXi8eIcUlsvOhnTDmgzrrqeLcoQgVoObd/URVlSU7jiAYKljXWi58vypBIYYA83zBhHb7Y
	C0uyMVxWqSoIwflC3xnKrv3tJIsuw9Owb9Ep2xx4NPW7IhiPm8FxxFd8QSVdIyh1GdkJpx
	i5zu/GfQvZ0LnpQDTgPA7+S73mV3+8iCWKw8rAl5KpgImWw1nttPX6bqXu0GL56v510gy/
	5OQ6C787NJ9UdAbdeT3UQ+g10Oi5Ud+R9rPyzIHFxhc5cVAjmwW3XNHuc7FpaA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: dmitry.baryshkov@linaro.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, mripard@kernel.org, Sandor Yu <Sandor.yu@nxp.com>
Cc: kernel@pengutronix.de, linux-imx@nxp.com, Sandor.yu@nxp.com, oliver.brown@nxp.com, sam@ravnborg.org
Subject: Re: [PATCH v17 1/8] drm: bridge: Cadence: Create mhdp helper driver
Date: Tue, 24 Sep 2024 10:41:26 +0200
Message-ID: <2773403.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <6e2e4951aa4c69eed68af231c2b0b2ce302b2358.1727159906.git.Sandor.yu@nxp.com>
References: <cover.1727159906.git.Sandor.yu@nxp.com> <6e2e4951aa4c69eed68af231c2b0b2ce302b2358.1727159906.git.Sandor.yu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Sandor,

Am Dienstag, 24. September 2024, 09:36:46 CEST schrieb Sandor Yu:
> MHDP8546 mailbox access functions will be share to other mhdp driver
> and Cadence HDP-TX HDMI/DP PHY drivers.
> Create a new mhdp helper driver and move all those functions into.
>=20
> cdns_mhdp_reg_write() is renamed to cdns_mhdp_dp_reg_write(),
> because it use the DPTX command ID DPTX_WRITE_REGISTER.
>=20
> New cdns_mhdp_reg_write() is created with the general command ID
> GENERAL_REGISTER_WRITE.
>=20
> Rewrite cdns_mhdp_set_firmware_active() in mhdp8546 core driver,
> use cdns_mhdp_mailbox_send() to replace cdns_mhdp_mailbox_write()
> same as the other mailbox access functions.
>=20
> Replaces the local mutex mbox_mutex with a global mutex mhdp_mailbox_mutex
> to prevent race conditions in mailbox access by multi drivers.
>=20
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
> v16->v17:
> - Replaces the local mutex mbox_mutex with a global mutex mhdp_mailbox_mu=
tex
>=20
> v12->v16:
>  *No change.
>=20
> V11->v12:
> - Move status initialize out of mbox_mutex.
> - Reorder API functions in alphabetical.
> - Add notes for malibox access functions.
> - Add year 2024 to copyright.
>=20
>  drivers/gpu/drm/bridge/cadence/Kconfig        |   4 +
>  drivers/gpu/drm/bridge/cadence/Makefile       |   1 +
>  .../gpu/drm/bridge/cadence/cdns-mhdp-helper.c | 307 +++++++++++++
>  .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 425 ++++--------------
>  .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  47 +-
>  .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   |  36 +-
>  include/drm/bridge/cdns-mhdp-helper.h         |  94 ++++
>  7 files changed, 507 insertions(+), 407 deletions(-)
>  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp-helper.c
>  create mode 100644 include/drm/bridge/cdns-mhdp-helper.h
>=20
> diff --git a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bri=
dge/cadence/Kconfig
> index cced81633ddcd..e0973339e9e33 100644
> --- a/drivers/gpu/drm/bridge/cadence/Kconfig
> +++ b/drivers/gpu/drm/bridge/cadence/Kconfig
> @@ -21,6 +21,9 @@ config DRM_CDNS_DSI_J721E
>  	  the routing of the DSS DPI signal to the Cadence DSI.
>  endif
> =20
> +config CDNS_MHDP_HELPER
> +	tristate
> +
>  config DRM_CDNS_MHDP8546
>  	tristate "Cadence DPI/DP bridge"
>  	select DRM_DISPLAY_DP_HELPER
> @@ -28,6 +31,7 @@ config DRM_CDNS_MHDP8546
>  	select DRM_DISPLAY_HELPER
>  	select DRM_KMS_HELPER
>  	select DRM_PANEL_BRIDGE
> +	select CDNS_MHDP_HELPER
>  	depends on OF
>  	help
>  	  Support Cadence DPI to DP bridge. This is an internal
> diff --git a/drivers/gpu/drm/bridge/cadence/Makefile b/drivers/gpu/drm/br=
idge/cadence/Makefile
> index c95fd5b81d137..087dc074820d7 100644
> --- a/drivers/gpu/drm/bridge/cadence/Makefile
> +++ b/drivers/gpu/drm/bridge/cadence/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_DRM_CDNS_DSI) +=3D cdns-dsi.o
>  cdns-dsi-y :=3D cdns-dsi-core.o
>  cdns-dsi-$(CONFIG_DRM_CDNS_DSI_J721E) +=3D cdns-dsi-j721e.o
> +obj-$(CONFIG_CDNS_MHDP_HELPER) +=3D cdns-mhdp-helper.o
>  obj-$(CONFIG_DRM_CDNS_MHDP8546) +=3D cdns-mhdp8546.o
>  cdns-mhdp8546-y :=3D cdns-mhdp8546-core.o cdns-mhdp8546-hdcp.o
>  cdns-mhdp8546-$(CONFIG_DRM_CDNS_MHDP8546_J721E) +=3D cdns-mhdp8546-j721e=
=2Eo
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp-helper.c b/drivers/=
gpu/drm/bridge/cadence/cdns-mhdp-helper.c
> new file mode 100644
> index 0000000000000..c60a6b69a5343
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp-helper.c
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023, 2024 NXP Semiconductor, Inc.
> + *
> + */
> +#include <drm/bridge/cdns-mhdp-helper.h>
> +#include <linux/dev_printk.h>
> +#include <linux/module.h>
> +
> +/* Protects mailbox communications with the firmware */
> +DEFINE_MUTEX(mhdp_mailbox_mutex);

This is not enough if the driver is built as a module:

> ERROR: modpost: "mhdp_mailbox_mutex"
> [drivers/gpu/drm/bridge/cadence/cdns-mhdp8546.ko] undefined! ERROR:
> modpost: "mhdp_mailbox_mutex"
> [drivers/gpu/drm/bridge/cadence/cdns-mhdp8501.ko] undefined!

Not sure if EXPORT_SYMBOL_GPL() on a mutex is considered good style.

Best regards,
Alexander

> [snip]
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



