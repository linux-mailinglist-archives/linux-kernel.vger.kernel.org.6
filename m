Return-Path: <linux-kernel+bounces-273959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0D5947027
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E472C1F213AB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3FD132464;
	Sun,  4 Aug 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFH4Dlaw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B4379C2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793730; cv=none; b=nGmxTfOwr+Q72T9ZUDWdiXC3HRIQOKAat6xkO4W9OQQEumLdGXsaBKCr2Bt+xEoqGkFE+54NuGdpRL2nKNahb3M2FvQPHLvoHovL7Sm3rxkzT53a1bfs2/CjJO1ApNDDu0lZnv6nMErD9/pnvUTFrz80GEdCZfkS1hl2cmY2Z8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793730; c=relaxed/simple;
	bh=FrPc5WshtUFoBN134P94aXzwbHbSPUZvowqqzdnXDkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FM3XBkmqRGhEmrsy4+bzOo/Y7vi6o/8Su30V4uc6ize/FUTXwYhuq1RVbXd+n2TxN8YQ5btZNn9vvGNWBuDgF8YaA9cIFhl7v7IVWwhXDj5Vd+UbKXLtx/m6SPAhL5We58UhO0NbYhY9Jbt8eNMvGqt0XaERw8ZVm/T4PadggPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFH4Dlaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05784C32786;
	Sun,  4 Aug 2024 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722793729;
	bh=FrPc5WshtUFoBN134P94aXzwbHbSPUZvowqqzdnXDkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFH4DlawM6tIns8vplkW5u+MKPyqCgf2xI8bG0BFbhJXmU3SeiqwI/3Zx5yeZgF3X
	 hweXxmzd1KpKy9XFL8q1SVUmaWZe4Of4qHSc6aKAxRd2hg4T0hKhIjDNGnszJcNMRD
	 uPzpVd/q+j/CtIcsgUSp+k+nHOU1w/Iy8tQxD5VuN0bW2z0/09GbXFtrv2ydDndQUT
	 sWTKMU9BoK0gcs46F7LSfswCy+oknHmKMAvJMCOpW0f/WY20+4FiW1cPgK4NUX8viJ
	 deLYUtL+ut9cHh+2TOs2K2iCbaaSk/hfzDCFnFzLfph9hiW3egTRqs2f02azSuCP99
	 yWCzST0bQ2XOg==
Date: Sun, 4 Aug 2024 23:18:45 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: mvebu-cp110-utmi: support swapping d+/d- lanes by
 dts property
Message-ID: <Zq--_WIgaPXPiYRQ@matsya>
References: <20240704-mvebu-utmi-phy-v1-1-9d3c8eea46e5@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704-mvebu-utmi-phy-v1-1-9d3c8eea46e5@solid-run.com>

On 04-07-24, 16:57, Josua Mayer wrote:
> CP11x UTMI PHY supports swapping D+/D- signals via digital control
> register 1.
> 
> Add support for the "swap-dx-lanes" device-tree property, which lists
> the port-ids that should swap D+ and D-.
> The property is evaluated in probe and applied before power-on
> during mvebu_cp110_utmi_port_setup.

It fails my build tests

drivers/phy/marvell/phy-mvebu-cp110-utmi.c:
In function ‘mvebu_cp110_utmi_phy_probe’:
drivers/phy/marvell/phy-mvebu-cp110-utmi.c:361:89:
error: macro "of_property_for_each_u32" passed 5 arguments, but takes
just 3
  361 |                 of_property_for_each_u32(dev->of_node,
"swap-dx-lanes", prop, p, swap_dx)
      |
^
In file included from
drivers/phy/marvell/phy-mvebu-cp110-utmi.c:15:
include/linux/of.h:1432: note:
macro "of_property_for_each_u32" defined here
 1432 | #define of_property_for_each_u32(np, propname, u)
\
      | 
drivers/phy/marvell/phy-mvebu-cp110-utmi.c:361:17:
error: ‘of_property_for_each_u32’ undeclared (first use in this
function); did you mean ‘of_property_read_u32’?
  361 |                 of_property_for_each_u32(dev->of_node,
"swap-dx-lanes", prop, p, swap_dx)
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
      |                 of_property_read_u32
drivers/phy/marvell/phy-mvebu-cp110-utmi.c:361:17:
note: each undeclared identifier is reported only once for each function
it appears in
drivers/phy/marvell/phy-mvebu-cp110-utmi.c:361:41:
error: expected ‘;’ before ‘if’
  361 |                 of_property_for_each_u32(dev->of_node,
"swap-dx-lanes", prop, p, swap_dx)
      |                                         ^
      |                                         ;
  362 |                         if (swap_dx == port_id)
      |                         ~~               
drivers/phy/marvell/phy-mvebu-cp110-utmi.c:301:13:
error: unused variable ‘swap_dx’ [-Werror=unused-variable]
  301 |         u32 swap_dx = 0;
      |             ^~~~~~~
drivers/phy/marvell/phy-mvebu-cp110-utmi.c:299:23:
error: unused variable ‘p’ [-Werror=unused-variable]
  299 |         const __be32 *p;
      |                       ^
drivers/phy/marvell/phy-mvebu-cp110-utmi.c:298:26:
error: unused variable ‘prop’ [-Werror=unused-variable]
  298 |         struct property *prop;
      |                          ^~~~
cc1: all warnings being treated as errors


> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  drivers/phy/marvell/phy-mvebu-cp110-utmi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
> index 4922a5f3327d..5e403f842e9a 100644
> --- a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
> +++ b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
> @@ -62,6 +62,8 @@
>  #define   SQ_AMP_CAL_MASK			GENMASK(2, 0)
>  #define   SQ_AMP_CAL_VAL			1
>  #define   SQ_AMP_CAL_EN				BIT(3)
> +#define UTMI_DIG_CTRL1_REG			0x20
> +#define   SWAP_DPDM				BIT(15)
>  #define UTMI_CTRL_STATUS0_REG			0x24
>  #define   SUSPENDM				BIT(22)
>  #define   TEST_SEL				BIT(25)
> @@ -104,6 +106,7 @@ struct mvebu_cp110_utmi_port {
>  	struct mvebu_cp110_utmi *priv;
>  	u32 id;
>  	enum usb_dr_mode dr_mode;
> +	bool swap_dx;
>  };
>  
>  static void mvebu_cp110_utmi_port_setup(struct mvebu_cp110_utmi_port *port)
> @@ -159,6 +162,13 @@ static void mvebu_cp110_utmi_port_setup(struct mvebu_cp110_utmi_port *port)
>  	reg &= ~(VDAT_MASK | VSRC_MASK);
>  	reg |= (VDAT_VAL << VDAT_OFFSET) | (VSRC_VAL << VSRC_OFFSET);
>  	writel(reg, PORT_REGS(port) + UTMI_CHGDTC_CTRL_REG);
> +
> +	/* Swap D+/D- */
> +	reg = readl(PORT_REGS(port) + UTMI_DIG_CTRL1_REG);
> +	reg &= ~(SWAP_DPDM);
> +	if (port->swap_dx)
> +		reg |= SWAP_DPDM;
> +	writel(reg, PORT_REGS(port) + UTMI_DIG_CTRL1_REG);
>  }
>  
>  static int mvebu_cp110_utmi_phy_power_off(struct phy *phy)
> @@ -285,7 +295,10 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
>  	struct mvebu_cp110_utmi *utmi;
>  	struct phy_provider *provider;
>  	struct device_node *child;
> +	struct property *prop;
> +	const __be32 *p;
>  	u32 usb_devices = 0;
> +	u32 swap_dx = 0;
>  
>  	utmi = devm_kzalloc(dev, sizeof(*utmi), GFP_KERNEL);
>  	if (!utmi)
> @@ -345,6 +358,10 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
>  			}
>  		}
>  
> +		of_property_for_each_u32(dev->of_node, "swap-dx-lanes", prop, p, swap_dx)
> +			if (swap_dx == port_id)
> +				port->swap_dx = 1;
> +
>  		/* Retrieve PHY capabilities */
>  		utmi->ops = &mvebu_cp110_utmi_phy_ops;
>  
> 
> ---
> base-commit: 4de480264948cbf2b08a72c39ee122a9f9761e03
> change-id: 20240704-mvebu-utmi-phy-84aa3bf3957d
> 
> Sincerely,
> -- 
> Josua Mayer <josua@solid-run.com>

-- 
~Vinod

