Return-Path: <linux-kernel+bounces-168628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 986B78BBB02
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0D41C2107D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFCB208A1;
	Sat,  4 May 2024 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR3uaWJw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6C71CFAF
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714823944; cv=none; b=W3so5Q9S7ztXhJ+wqpcp7JNxFQNsn4NIcYu0rNls62H3U9LkS0I80VpDDmAxSSyFlWAHKgFU8WE1rBlY3ikhhEeZZzpYozX8TgCdDW72Z2FjnUFt9U+AKjsZXkZ6mSuxamgOITvUKXR6G+IwXJ16Be2E+ffq+rQsAsixWGUpEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714823944; c=relaxed/simple;
	bh=tHkDDYIJU8PS+ZwgvuIlZuzFtSgUX3xgqS/6qnXnSp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNDlGB/XrXh0hMNlZeIy7EDHbx9evaiDyerd3nk/hQINK5cBbyuxwduUXKt/yZuAopp8bSgWN32ciY8oXy17cw3WMgM173o3zt7fUn1xCXUKhqeDfLYCLRo+/w137AMAcjKKVuP0MTTJVbgy673rBXw3DgJ0/GfJrL8Fw5TW5OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR3uaWJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7278FC072AA;
	Sat,  4 May 2024 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714823944;
	bh=tHkDDYIJU8PS+ZwgvuIlZuzFtSgUX3xgqS/6qnXnSp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IR3uaWJwhf7qbZM6CQd1Id1zrPd6408b1hvcGk/k2JrQCIXAhZiI4R3sOu4icY4m9
	 bYtizQ42wkei0Kte3UNKXV1pfAxdykrxIO6C6EnLpVruCLvVAcRxkMYXwDN4JE+BuI
	 Lw6B86Wn2rt7bz+B2ZrzqLtCa21XLXUU37QPxIE4C9rYwv7iBG8uOoQruiFsOs1CuR
	 OPWfoZHIc63ZSl7rAyQuD8/HZY6uGTaGsYzSOCOxfLQJkzGd6miViOMGlcICGI1dBq
	 +bAIVE8r9qyte6nWLXdufrOw8ZNStRIGoLtXoMzSd/8pZCadggqdGjeoQ57TPfYu4N
	 3F6tXbHAOU11g==
Date: Sat, 4 May 2024 17:28:58 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH 3/3] phy: zynqmp: Add debugfs support
Message-ID: <ZjYjAjPlM5ClOGa4@matsya>
References: <20240422185803.3575319-1-sean.anderson@linux.dev>
 <20240422185803.3575319-4-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422185803.3575319-4-sean.anderson@linux.dev>

On 22-04-24, 14:58, Sean Anderson wrote:
> Add support for printing some basic status information to debugfs. This
> is helpful when debugging phy consumers to make sure they are configuring
> the phy appropriately.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  drivers/phy/xilinx/phy-zynqmp.c | 54 +++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> index 08c88dcd7799..e2e86943e9f3 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -122,6 +123,15 @@
>  #define ICM_PROTOCOL_DP			0x4
>  #define ICM_PROTOCOL_SGMII		0x5
>  
> +static const char *const xpsgtr_icm_str[] = {
> +	[ICM_PROTOCOL_PD] = "powered down",
> +	[ICM_PROTOCOL_PCIE] = "PCIe",
> +	[ICM_PROTOCOL_SATA] = "SATA",
> +	[ICM_PROTOCOL_USB] = "USB",
> +	[ICM_PROTOCOL_DP] = "DisplayPort",
> +	[ICM_PROTOCOL_SGMII] = "SGMII",
> +};
> +
>  /* Test Mode common reset control  parameters */
>  #define TM_CMN_RST			0x10018
>  #define TM_CMN_RST_EN			0x1
> @@ -768,6 +778,48 @@ static struct phy *xpsgtr_xlate(struct device *dev,
>  	return ERR_PTR(-EINVAL);
>  }
>  
> +/*
> + * DebugFS
> + */
> +
> +static int xpsgtr_status_read(struct seq_file *seq, void *data)
> +{
> +	struct xpsgtr_phy *gtr_phy = seq->private;
> +	struct clk *clk;
> +	u32 pll_status;
> +
> +	mutex_lock(&gtr_phy->phy->mutex);
> +	pll_status = xpsgtr_read_phy(gtr_phy, L0_PLL_STATUS_READ_1);
> +	clk = gtr_phy->dev->clk[gtr_phy->refclk];
> +
> +	seq_printf(seq, "Lane:            %u\n", gtr_phy->lane);
> +	seq_printf(seq, "Protocol:        %s\n",
> +		   xpsgtr_icm_str[gtr_phy->protocol]);
> +	seq_printf(seq, "Instance:        %u\n", gtr_phy->instance);
> +	seq_printf(seq, "Reference clock: %u (%pC)\n", gtr_phy->refclk, clk);
> +	seq_printf(seq, "Reference rate:  %lu\n", clk_get_rate(clk));
> +	seq_printf(seq, "PLL locked:      %s\n",
> +		   pll_status & PLL_STATUS_LOCKED ? "yes" : "no");
> +
> +	mutex_unlock(&gtr_phy->phy->mutex);
> +	return 0;
> +}
> +
> +static int xpsgtr_status_open(struct inode *inode, struct file *f)
> +{
> +	struct xpsgtr_phy *gtr_phy = inode->i_private;
> +
> +	return single_open(f, xpsgtr_status_read, gtr_phy);
> +}
> +
> +static const struct file_operations xpsgtr_status_ops = {
> +	.owner = THIS_MODULE,
> +	.open = xpsgtr_status_open,
> +	.release = single_release,
> +	.read = seq_read,
> +	.llseek = seq_lseek
> +};

There are debugfs simple helpers which should help you avoid all this
open coding and just have the read call

> +
>  /*
>   * Power Management
>   */
> @@ -917,6 +969,8 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  
>  		gtr_phy->phy = phy;
>  		phy_set_drvdata(phy, gtr_phy);
> +		debugfs_create_file("status", 0444, phy->debugfs, gtr_phy,
> +				    &xpsgtr_status_ops);

generic status does not make sense, how about device-name-status

-- 
~Vinod

