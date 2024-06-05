Return-Path: <linux-kernel+bounces-202808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7FA8FD170
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C36A1F25CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A52C3D548;
	Wed,  5 Jun 2024 15:15:55 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F817BCC;
	Wed,  5 Jun 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600554; cv=none; b=jp8pmtLZg4cvpXj6l4PWKBUykKmPQkF8+lnRzF4ftDx+ipmAXlvjezZjPWCHOBkWCXgwiI3SIAXwZwBn/XPson5NQmXkHd0yx3akoiEzfQbtzNdDyDbHxQn0U94r9p14//LUT9SSU5rWGGkTJ0M5TE3af3qvFzfsDuA0aC36DRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600554; c=relaxed/simple;
	bh=1zLA6mPxYnEPg/t/Lk/WBlBXqXpEMxnonQ2kaErlsns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLiQuQg7ugNHAT+rkneQvWaM5r1aP7FqAMOA4YtlXoD02kblyV+Utd3PQQVS43ycCYKfRCzfTHetj9SK6uIMx7u1FoJrABigySKYwtozvujgWVxq2zoyy6llkI8L2K1zS6muVIqhnM+yuavDRnD4TmBlAjx78sn0q+E6lCK77dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b65.versanet.de ([83.135.91.101] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sErwP-00012r-Mi; Wed, 05 Jun 2024 16:48:41 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
Subject:
 Re: [PATCH 13/14] drm/bridge: synopsys: Add DW HDMI QP TX controller driver
Date: Wed, 05 Jun 2024 16:48:40 +0200
Message-ID: <2554679.TLnPLrj5Ze@diego>
In-Reply-To:
 <20240601-b4-rk3588-bridge-upstream-v1-13-f6203753232b@collabora.com>
References:
 <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <20240601-b4-rk3588-bridge-upstream-v1-13-f6203753232b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Samstag, 1. Juni 2024, 15:12:35 CEST schrieb Cristian Ciocaltea:
> The Synopsys DesignWare HDMI 2.1 Quad-Pixel (QP) TX controller supports
> the following features, among others:
> 
> * Fixed Rate Link (FRL)
> * 4K@120Hz and 8K@60Hz video modes
> * Variable Refresh Rate (VRR) including Quick Media Switching (QMS), aka
>   Cinema VRR
> * Fast Vactive (FVA), aka Quick Frame Transport (QFT)
> * SCDC I2C DDC access
> * TMDS Scrambler enabling 2160p@60Hz with RGB/YCbCr4:4:4
> * YCbCr4:2:0 enabling 2160p@60Hz at lower HDMI link speeds
> * Multi-stream audio
> * Enhanced Audio Return Channel (EARC)
> 
> Add driver to enable basic support, i.e. RGB output up to 4K@60Hz,
> without audio, CEC or any HDMI 2.1 specific features.
> 
> Co-developed-by: Algea Cao <algea.cao@rock-chips.com>
> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/Makefile     |   2 +-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 787 +++++++++++++++++++++++++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h | 831 +++++++++++++++++++++++++++
>  include/drm/bridge/dw_hdmi.h                 |   8 +
>  4 files changed, 1627 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/Makefile b/drivers/gpu/drm/bridge/synopsys/Makefile
> index ce715562e9e5..8354e4879f70 100644
> --- a/drivers/gpu/drm/bridge/synopsys/Makefile
> +++ b/drivers/gpu/drm/bridge/synopsys/Makefile

> +static int dw_hdmi_qp_i2c_read(struct dw_hdmi *hdmi,
> +			       unsigned char *buf, unsigned int length)
> +{
> +	struct dw_hdmi_i2c *i2c = hdmi->i2c;
> +	int stat;
> +
> +	if (!i2c->is_regaddr) {
> +		dev_dbg(hdmi->dev, "set read register address to 0\n");
> +		i2c->slave_reg = 0x00;
> +		i2c->is_regaddr = true;
> +	}
> +
> +	while (length--) {
> +		reinit_completion(&i2c->cmp);
> +
> +		dw_hdmi_qp_mod(hdmi, i2c->slave_reg++ << 12, I2CM_ADDR,
> +			       I2CM_INTERFACE_CONTROL0);
> +
> +		dw_hdmi_qp_mod(hdmi, I2CM_FM_READ, I2CM_WR_MASK,
> +			       I2CM_INTERFACE_CONTROL0);

Somehow the segment handling is present in the rest of the i2c code here, but
not the actual handling for reads.

The vendor-kernel does:

-               dw_hdmi_qp_mod(hdmi, I2CM_FM_READ, I2CM_WR_MASK,
-                              I2CM_INTERFACE_CONTROL0);
+               if (i2c->is_segment)
+                       dw_hdmi_qp_mod(hdmi, I2CM_EXT_READ, I2CM_WR_MASK,
+                                      I2CM_INTERFACE_CONTROL0);
+               else
+                       dw_hdmi_qp_mod(hdmi, I2CM_FM_READ, I2CM_WR_MASK,
+                                      I2CM_INTERFACE_CONTROL0);

Without this change, connecting to a DVI display does not work, and
reading the EDID ends in the "i2c read error" below.

Adding the segment handling as above makes the DVI connection
work (as it does in the vendor-kernel).

So it would be nice if you could maybe incorporate this in the next version?


Thanks
Heiko


> +
> +		stat = wait_for_completion_timeout(&i2c->cmp, HZ / 10);
> +		if (!stat) {
> +			dev_err(hdmi->dev, "i2c read timed out\n");
> +			dw_hdmi_qp_write(hdmi, 0x01, I2CM_CONTROL0);
> +			return -EAGAIN;
> +		}
> +
> +		/* Check for error condition on the bus */
> +		if (i2c->stat & I2CM_NACK_RCVD_IRQ) {
> +			dev_err(hdmi->dev, "i2c read error\n");
> +			dw_hdmi_qp_write(hdmi, 0x01, I2CM_CONTROL0);
> +			return -EIO;
> +		}
> +
> +		*buf++ = dw_hdmi_qp_read(hdmi, I2CM_INTERFACE_RDDATA_0_3) & 0xff;
> +		dw_hdmi_qp_mod(hdmi, 0, I2CM_WR_MASK, I2CM_INTERFACE_CONTROL0);
> +	}
> +
> +	i2c->is_segment = false;
> +
> +	return 0;
> +}




