Return-Path: <linux-kernel+bounces-398294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CECA29BEF1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7A8285AB9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FCB1F9EA4;
	Wed,  6 Nov 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="LeRUpQNY"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F861F9AB5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730900021; cv=none; b=eHFbZOIFkdbE0ZamV7qywhwukAZ8uDiZfNE5b2bDsfAzgwfgkq4ntHwz10qsgP+XaGAp5CEto+PTtK9xTF7n7AbsfvlL7X7Orzw9ovHNhCJSABjZ96GTzT7ep6jYLvS1hdomAm49HBtQNkwGw9a9ajMXTV4MusQWKQao9lqStZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730900021; c=relaxed/simple;
	bh=MF0pU0dqP3hbd7ASdB38y5Fvfv6EH6Uu1HY6SriVAC4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oGzTRMT5/nK5cVi814A2SZIfuYUG3sOLwRIAtfUSiOG4GyvqLH5B/Dsu4LyXd3OxY+ZmMSLpZaeXUhiNbVxOuiwVRcyPI6RnKQ6g30QuF2aqhVlgB24J1dXyqNVlGO5vt15Xq7efTNuTpXZwOJoLX+35JZdWK8mm9FmjOo93x3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=LeRUpQNY; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1730900016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L0Hs6MfDCm9OBvKWZZJPXB/waj4QxbzOt9Cz60jbht4=;
	b=LeRUpQNYFntxZ+/Nas9OV9ZCgqsiaBopA9T6kwwlVsGNY7e1+NIIFQWDTdcaRDu9qyf6ih
	w32tggnc5H2JES/qBsegQYw7JjbB3qsl3Pe0ToX/p8Tk51LfXoFKVroIcwN2K0WOJY01lc
	a3wcNKIQxJ/IDoxtK2cYh3niQWjxQuwJiDsoQpY200HRyjoDOAseFIJppgiqyyQvI292e2
	FEOb/J/BnmRdoRGOt5AAZzBxBvHt1XW7HIJJtWjGVbXl4RwUZovFtWBGl7ppBcaBiaA7Ma
	28nvs1fC+duP1hADHeC1H/nebhqJRclV4Apz6f9D51wkHChYLzV2bzs0Vcgvkw==
Content-Type: multipart/signed;
 boundary=941c37924af32141fe5e0f79007b5e08666732b6921ee74e1ee56a0ed058;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 06 Nov 2024 14:33:25 +0100
Message-Id: <D5F4UD59MUJG.2HFCTRSPELO98@cknow.org>
Cc: <andy.yan@rock-chips.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <quentin.schulz@cherry.de>, "Heiko Stuebner" <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 3/3] drm/rockchip: Add MIPI DSI2 glue driver for RK3588
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Heiko Stuebner" <heiko@sntech.de>
References: <20241106123304.422854-1-heiko@sntech.de>
 <20241106123304.422854-4-heiko@sntech.de>
In-Reply-To: <20241106123304.422854-4-heiko@sntech.de>
X-Migadu-Flow: FLOW_OUT

--941c37924af32141fe5e0f79007b5e08666732b6921ee74e1ee56a0ed058
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Nov 6, 2024 at 1:33 PM CET, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>
> This adds the glue code for the MIPI DSI2 bridge on Rockchip SoCs and
> enables its use on the RK3588.
>
> Right now the DSI2 controller is always paired with a DC-phy based on a
> Samsung IP, so the interface values are set statically for now.
> This stays true for the upcoming RK3576 as well.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  drivers/gpu/drm/rockchip/Kconfig              |  10 +
>  drivers/gpu/drm/rockchip/Makefile             |   1 +
>  .../gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c  | 524 ++++++++++++++++++
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |   2 +
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |   1 +
>  5 files changed, 538 insertions(+)
>  create mode 100644 drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
>
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/=
Kconfig
> index 448fadd4ba15..99d4b260de85 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -10,6 +10,7 @@ config DRM_ROCKCHIP
>  	select DRM_DW_HDMI if ROCKCHIP_DW_HDMI
>  	select DRM_DW_HDMI_QP if ROCKCHIP_DW_HDMI_QP
>  	select DRM_DW_MIPI_DSI if ROCKCHIP_DW_MIPI_DSI
> +	select DRM_DW_MIPI_DSI2 if ROCKCHIP_DW_MIPI_DSI2
>  	select GENERIC_PHY if ROCKCHIP_DW_MIPI_DSI
>  	select GENERIC_PHY_MIPI_DPHY if ROCKCHIP_DW_MIPI_DSI
>  	select SND_SOC_HDMI_CODEC if ROCKCHIP_CDN_DP && SND_SOC
> @@ -81,6 +82,15 @@ config ROCKCHIP_DW_MIPI_DSI
>  	  enable MIPI DSI on RK3288 or RK3399 based SoC, you should
>  	  select this option.
> =20
> +config ROCKCHIP_DW_MIPI_DSI2
> +	bool "Rockchip specific extensions for Synopsys DW MIPI DSI"
> +	select GENERIC_PHY_MIPI_DPHY
> +	help
> +	  This selects support for Rockchip SoC specific extensions
> +	  for the Synopsys DesignWare dsi driver. If you want to
> +	  enable MIPI DSI on RK3288 or RK3399 based SoC, you should
> +	  select this option.

The commit message and the cover letter talk about RK3588 (and RK3576),
so this seems like a copy-n-paste error (from DSI '1')?
I'd also prefer 'dsi' to be in capitals (thus 'DSI').

> +
>  config ROCKCHIP_INNO_HDMI
>  	bool "Rockchip specific extensions for Innosilicon HDMI"
>  	select DRM_DISPLAY_HDMI_HELPER
> diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip=
/Makefile
> index 3eab662a5a1d..2b867cebbc12 100644
> --- a/drivers/gpu/drm/rockchip/Makefile
> +++ b/drivers/gpu/drm/rockchip/Makefile
> @@ -13,6 +13,7 @@ rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) +=3D cdn-dp-core.=
o cdn-dp-reg.o
>  rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) +=3D dw_hdmi-rockchip.o
>  rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI_QP) +=3D dw_hdmi_qp-rockchip.o
>  rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) +=3D dw-mipi-dsi-rockchip.o
> +rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI2) +=3D dw-mipi-dsi2-rockchip.o
>  rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) +=3D inno_hdmi.o
>  rockchipdrm-$(CONFIG_ROCKCHIP_LVDS) +=3D rockchip_lvds.o
>  rockchipdrm-$(CONFIG_ROCKCHIP_RGB) +=3D rockchip_rgb.o
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c b/drivers/g=
pu/drm/rockchip/dw-mipi-dsi2-rockchip.c
> new file mode 100644
> index 000000000000..42a7a80e2138
> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
> @@ -0,0 +1,524 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Rockchip Electronics Co.Ltd
> + * Author:
> + *      Guochun Huang <hero.huang@rock-chips.com>
> + *      Heiko Stuebner <heiko.stuebner@cherry.de>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +#include <linux/gpio.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_platform.h>

In commit 722d4f06e560 ("drm: Explicitly include correct DT includes")
several changes were made to header includes.
One of the things I noticed is that ``of_device.h`` often was removed
and ``of.h`` added.
Thus are the above headers as they should be or should they be updated
like was done in commit 722d4f06e560?

> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/phy/phy.h>
> +
> +#include <drm/bridge/dw_mipi_dsi2.h>
> +
> +#include <drm/display/drm_dsc.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
> +#include <video/mipi_display.h>
> +#include <video/videomode.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
> +
> +#include <uapi/linux/videodev2.h>
> +
> +#include "rockchip_drm_drv.h"
> +#include "rockchip_drm_vop.h"
> +
> +#define PSEC_PER_SEC			1000000000000LL
> +
> +struct dsigrf_reg {
> +	u16 offset;
> +	u16 lsb;
> +	u16 msb;
> +};
> +
> +enum grf_reg_fields {
> +	TXREQCLKHS_EN,
> +	GATING_EN,
> +	IPI_SHUTDN,
> +	IPI_COLORM,
> +	IPI_COLOR_DEPTH,
> +	IPI_FORMAT,
> +	MAX_FIELDS,
> +};
> +
> +#define IPI_DEPTH_5_6_5_BITS		0x02
> +#define IPI_DEPTH_6_BITS		0x03
> +#define IPI_DEPTH_8_BITS		0x05
> +#define IPI_DEPTH_10_BITS		0x06

Possibly dumb remark (sorry):
drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c also defines these
values, so wouldn't it be better if they're defined in 1 place?

Cheers,
  Diederik

--941c37924af32141fe5e0f79007b5e08666732b6921ee74e1ee56a0ed058
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZytwKgAKCRDXblvOeH7b
biV/AP4zAYHiHOY+G+ZWghI6d64xjETs3tPKgVHZL09dfdL/JwD/TSO6qqGeYLHi
B98Lhvs7MDrWNaq9pz6STkXM4wXDRQQ=
=9pLY
-----END PGP SIGNATURE-----

--941c37924af32141fe5e0f79007b5e08666732b6921ee74e1ee56a0ed058--

