Return-Path: <linux-kernel+bounces-430987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807C29E37D8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA23161F22
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC371AB507;
	Wed,  4 Dec 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="qLo3qT2+"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5C463D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309299; cv=none; b=RinCVJzl9N0akF/+L1gmB/eraA8BpJ/nr+twwmXlLRJvfgXXR1bGn+H+cF8b1+cbFysJsW6iB7EuEJdool3/fysjEzs9MYqgIGs2QbY9MPE33BUCmHcV+/ZaYSBg+DgQFpMLDeagfdxyGNI9c4H879DVfPxJF7dg1QT1UkRECrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309299; c=relaxed/simple;
	bh=nMKJotmOfJV34Qf8Uaok9S3w0cWQJ2lUaPe4ebMComY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Fcy2PJrcUgtBdjlkt2K6vXA4uMkBtRt7n17198lvtp8XZW08RErVfxt6yEoNarA+0e2r+iv+2sP+l3bhD7oblJIw+CgslU7d+ZyPsETlmVknjtITNGY0pFqUN5iJ0cHY22KFCiqip5IKS9il96gHpXKwHfd0paPjbHuyGBmsrbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=qLo3qT2+; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1733309293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O2UKodnZ8Rm7sgDDRiSGv7A9dpUqJ+j48TEG+riJO/c=;
	b=qLo3qT2+panflIVAmf4iYX0CPTVCzg9EkWVcKb7KeKgZnE+P9MMOqfsJ+LFr0ZL1GWnZSK
	R0habEwAovGA6gOKjDgW0+C6xVjiibx1RNax0qkInVOtt2NKjJomzme3h37i++IiO+TML3
	6oH0x6pXWYEdza9HGISMYaq0yPW8pF5oXpDuu4qyHAd33FR1/hCIhZwu89htbcM0LsV+Ux
	j0D01g+ub5DCmJSA2NSVja29btWrot8o6MN5pzSVlbNGukeKV7czBY0F7pksj+1yTEoxGv
	2+GedYEZFSrYlyePSSgQQzVY6tIzdBh599PkxfnPWGGiRAu3YFZwCSUMSmXMcQ==
Content-Type: multipart/signed;
 boundary=36be8bfcf2ccc3f593d537c5169e7561860be4acb341ccb6b71acfde7e94;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 04 Dec 2024 11:48:02 +0100
Message-Id: <D62UUZI7C1GD.1YSCGFIH9N60N@cknow.org>
Cc: <andy.yan@rock-chips.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <quentin.schulz@cherry.de>, "Kever Yang" <kever.yang@rock-chips.com>,
 "Heiko Stuebner" <heiko.stuebner@cherry.de>, "Daniel Semkowicz"
 <dse@thaumatec.com>
Subject: Re: [PATCH v3 3/3] drm/rockchip: Add MIPI DSI2 glue driver for
 RK3588
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Heiko Stuebner" <heiko@sntech.de>
References: <20241203165450.1501219-1-heiko@sntech.de>
 <20241203165450.1501219-4-heiko@sntech.de>
 <af1cce1a-c46d-470f-a1b9-bfbc90b46415@rock-chips.com>
In-Reply-To: <af1cce1a-c46d-470f-a1b9-bfbc90b46415@rock-chips.com>
X-Migadu-Flow: FLOW_OUT

--36be8bfcf2ccc3f593d537c5169e7561860be4acb341ccb6b71acfde7e94
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

If there's going to be another version (to fix this) ...

On Wed Dec 4, 2024 at 3:16 AM CET, Kever Yang wrote:
> On 2024/12/4 00:54, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> >
> > This adds the glue code for the MIPI DSI2 bridge on Rockchip SoCs and
> > enables its use on the RK3588.
> >
> > Right now the DSI2 controller is always paired with a DC-phy based on a
> > Samsung IP, so the interface values are set statically for now.
> > This stays true for the upcoming RK3576 as well.
> >
> > Tested-by: Daniel Semkowicz <dse@thaumatec.com>
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---
> >   drivers/gpu/drm/rockchip/Kconfig              |  10 +
> >   drivers/gpu/drm/rockchip/Makefile             |   1 +
> >   .../gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c  | 524 +++++++++++++++++=
+
> >   drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |   2 +
> >   drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |   1 +
> >   5 files changed, 538 insertions(+)
> >   create mode 100644 drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
> >
> > diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchi=
p/Kconfig
> > index 448fadd4ba15..84af423b7f90 100644
> > --- a/drivers/gpu/drm/rockchip/Kconfig
> > +++ b/drivers/gpu/drm/rockchip/Kconfig
> > @@ -10,6 +10,7 @@ config DRM_ROCKCHIP
> >   	select DRM_DW_HDMI if ROCKCHIP_DW_HDMI
> >   	select DRM_DW_HDMI_QP if ROCKCHIP_DW_HDMI_QP
> >   	select DRM_DW_MIPI_DSI if ROCKCHIP_DW_MIPI_DSI
> > +	select DRM_DW_MIPI_DSI2 if ROCKCHIP_DW_MIPI_DSI2
> >   	select GENERIC_PHY if ROCKCHIP_DW_MIPI_DSI
> >   	select GENERIC_PHY_MIPI_DPHY if ROCKCHIP_DW_MIPI_DSI
> >   	select SND_SOC_HDMI_CODEC if ROCKCHIP_CDN_DP && SND_SOC
> > @@ -81,6 +82,15 @@ config ROCKCHIP_DW_MIPI_DSI
> >   	  enable MIPI DSI on RK3288 or RK3399 based SoC, you should
> >   	  select this option.
> >  =20
> > +config ROCKCHIP_DW_MIPI_DSI2
> > +	bool "Rockchip specific extensions for Synopsys DW MIPI DSI2"
> > +	select GENERIC_PHY_MIPI_DPHY
> > +	help
> > +	  This selects support for Rockchip SoC specific extensions
> > +	  for the Synopsys DesignWare dsi driver. If you want to

... could you then also s/dsi/DSI/ ?

Cheers,
  Diederik

> > +	  enable MIPI DSI on RK3576 or RK3588 based SoC, you should
> > +	  select this option.
> > +
> >   config ROCKCHIP_INNO_HDMI
> >   	bool "Rockchip specific extensions for Innosilicon HDMI"
> >   	select DRM_DISPLAY_HDMI_HELPER
> > diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockch=
ip/Makefile
> > index 3eab662a5a1d..2b867cebbc12 100644
> > --- a/drivers/gpu/drm/rockchip/Makefile
> > +++ b/drivers/gpu/drm/rockchip/Makefile
> > @@ -13,6 +13,7 @@ rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) +=3D cdn-dp-cor=
e.o cdn-dp-reg.o
> >   rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) +=3D dw_hdmi-rockchip.o
> >   rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI_QP) +=3D dw_hdmi_qp-rockchip.o
> >   rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) +=3D dw-mipi-dsi-rockchip.=
o
> > +rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI2) +=3D dw-mipi-dsi2-rockchip=
.o
> >   rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) +=3D inno_hdmi.o
> >   rockchipdrm-$(CONFIG_ROCKCHIP_LVDS) +=3D rockchip_lvds.o
> >   rockchipdrm-$(CONFIG_ROCKCHIP_RGB) +=3D rockchip_rgb.o
> > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c b/drivers=
/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
> > new file mode 100644
> > index 000000000000..55eed4001634
> > --- /dev/null
> > +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
> > @@ -0,0 +1,524 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2024 Rockchip Electronics Co.Ltd
> This should be:
>
> Rockchip Electronics Co., Ltd.
>
> This typo is from vendor kernel, we will correct all this kind of issue l=
ocally,
> and Andy is going to correct other files in drm for mainline kernel.
>
> Thanks,
> - Kever

--36be8bfcf2ccc3f593d537c5169e7561860be4acb341ccb6b71acfde7e94
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ1AzZgAKCRDXblvOeH7b
bgWNAQC3fSnJVdLSgG4VTa6DlS3SopUVzVFSbfEGiC729h16vAEAwIBqQFd3xgCB
KHlaIkQrEF/mSaPEoy27gQHJra96XQU=
=cYSZ
-----END PGP SIGNATURE-----

--36be8bfcf2ccc3f593d537c5169e7561860be4acb341ccb6b71acfde7e94--

