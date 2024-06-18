Return-Path: <linux-kernel+bounces-218998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6D190C898
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1C6280AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDFB209764;
	Tue, 18 Jun 2024 09:55:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0CC20974C;
	Tue, 18 Jun 2024 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704529; cv=none; b=tDz+vMIcqkn61ttVdnIOA2l+HEnOuzw/8z5+yPyy7++kWmLxxL/9B65RVxxH44rhF+Kvpd86p0QUXNN8CULZrcf0i8GFYHd3Gw6Q8jaBAPP8RT/uKWJMdHN9OZc2rNF4g5HfENHSv2OvWLMtqW6gvU+xXfJbcELE/1+PT35WmFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704529; c=relaxed/simple;
	bh=CUFBO/w85ZfNhHyUDj48ojyn4AZ07NGXPwsFh+G/1nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5I91X1KrPOisUWonHzeCnNZjDPLeJT/sK6JHA72J0akgQCMUKkdqBrxCkMbUfmhpnbsB49OxDmCZykA/RlZshk3SkKgg5tw5aPT/O3y9fCT5KLIqBZ2am6FvLkZAjj8qOWa2XM3Xl3FW6AtF8KvPZb3YuB5ZBJdEhQLAhqDz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3FFBDA7;
	Tue, 18 Jun 2024 02:55:50 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EB8B3F6A8;
	Tue, 18 Jun 2024 02:55:24 -0700 (PDT)
Date: Tue, 18 Jun 2024 10:55:21 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 6/6] firmware: imx: add i.MX95 MISC driver
Message-ID: <ZnFZiV9JzU_7agjW@pluto>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
 <20240524-imx95-bbm-misc-v2-v4-6-dc456995d590@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-imx95-bbm-misc-v2-v4-6-dc456995d590@nxp.com>

On Fri, May 24, 2024 at 04:56:48PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX95 System manager exports SCMI MISC protocol for linux to do
> various settings, such as set board gpio expander as wakeup source.
> 
> The driver is to add the support.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/Makefile   |   1 +
>  drivers/firmware/imx/sm-misc.c  | 108 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/firmware/imx/sm.h |  33 ++++++++++++
>  3 files changed, 142 insertions(+)
> 
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index fb20e22074e1..cb9c361d9b81 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -2,3 +2,4 @@
>  obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
>  obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
>  obj-${CONFIG_IMX_SCMI_BBM_EXT}	+= sm-bbm.o
> +obj-${CONFIG_IMX_SCMI_MISC_EXT}	+= sm-misc.o
> diff --git a/drivers/firmware/imx/sm-misc.c b/drivers/firmware/imx/sm-misc.c
> new file mode 100644
> index 000000000000..22c1a5819425
> --- /dev/null
> +++ b/drivers/firmware/imx/sm-misc.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP.
> + */
> +
> +#include <linux/firmware/imx/sm.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/scmi_imx_protocol.h>
> +
> +static const struct scmi_imx_misc_proto_ops *imx_misc_ctrl_ops;
> +static struct scmi_protocol_handle *ph;

Same comments as n V1 ... please have a look :P

Thanks,
Cristian

