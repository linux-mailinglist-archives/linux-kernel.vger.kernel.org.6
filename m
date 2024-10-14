Return-Path: <linux-kernel+bounces-363143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4BC99BE5E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 05:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9421CB22FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990FF12CD96;
	Mon, 14 Oct 2024 03:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oVuhKd7x"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBCD231CB1;
	Mon, 14 Oct 2024 03:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878140; cv=none; b=YdEd5BfRweWsNbbEndpm3wV+Vhtcjga70J3GG9ECvd7CiOjntW4y/VjDIU3D1Xo2IvrMwf7SF/F6sgXCXdqPH5iAMh/X0UfN7r6ptjkfgM8QLmp+zT1h0Xj6r+lPeRmI1VrU1PM27FPDrVrxCa7twvstHqZVNoIQGTYXIcXMiu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878140; c=relaxed/simple;
	bh=w1p2uLgiUd4HtJ8HdgsGpy7WhdCGBTblAt+eAztRw4I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=h0qiAgCdN6gww38JwavcA2234tlwNQiNQVEs3q6Ib72MHTaalS4qXRxR+j1Vv5rQDCX+/RLUutGCr2yCu+zCA/Hk2g3QCHhqS/h9dBWnuCy5s130HRr7GFmDG/GUFR+1ePNbX3zIAdV04CzE8Q6q1P9n+mlsTzSuLcGBcH0dvMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oVuhKd7x; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728878135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItMiZaVUJ0tYf4/40QYBAawzSkFPdziZo/qhFOBrpDo=;
	b=oVuhKd7xqOVNeJhH1Bo8XFhV3s8CO3nQZdTGL8ReHH6vPQn/dHnciebjLHtTjzCgBWgVWI
	wI0xPTd8Jti6jnaz8j4uPMdHndOB4ptvPqCs4Iie84E+G7y6TOC8o6LTuU2DuVUD0mepPZ
	q04IKUkfd7zALwYxT4ypRuNUV4F3aUStOUsroFAfv2Jt66oeDiIupOQCGL4Cw9Xb7pTL2g
	GCVA+NOxI4cjbTNE+5ecEmkf1NMxMIi4aPRXfU4ckX/bRQdKMNCroocu1ueR3KtYbGhyUS
	gRakWtvcRaGt320PFC4POraS2a/PvtgRLhrZlDaov8qtq3TH0zbjU+wCLqN2LQ==
Date: Mon, 14 Oct 2024 05:55:35 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Frank Wang <frawang.cn@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, yubing.zhang@rock-chips.com, Frank Wang
 <frank.wang@rock-chips.com>
Subject: Re: [PATCH 2/2] phy: rockchip: usbdp: add rk3576 device match data
In-Reply-To: <20241014020342.15974-2-frawang.cn@gmail.com>
References: <20241014020342.15974-1-frawang.cn@gmail.com>
 <20241014020342.15974-2-frawang.cn@gmail.com>
Message-ID: <127f7fb8d9608acb9541fc6c6dac2da9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Frank,

On 2024-10-14 04:03, Frank Wang wrote:
> From: Frank Wang <frank.wang@rock-chips.com>
> 
> This adds RK3576 device match data support.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

Looking good to me, thanks for the patch.  My focus was on
making sure there are no possible regressions.

Acked-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  drivers/phy/rockchip/phy-rockchip-usbdp.c | 41 +++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> index 2c51e5c62d3e..5b1e8a3806ed 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -1538,6 +1538,43 @@ static const char * const rk_udphy_rst_list[] = 
> {
>  	"init", "cmn", "lane", "pcs_apb", "pma_apb"
>  };
> 
> +static const struct rk_udphy_cfg rk3576_udphy_cfgs = {
> +	.num_phys = 1,
> +	.phy_ids = { 0x2b010000 },
> +	.num_rsts = ARRAY_SIZE(rk_udphy_rst_list),
> +	.rst_list = rk_udphy_rst_list,
> +	.grfcfg	= {
> +		/* u2phy-grf */
> +		.bvalid_phy_con		= RK_UDPHY_GEN_GRF_REG(0x0010, 1, 0, 0x2, 0x3),
> +		.bvalid_grf_con		= RK_UDPHY_GEN_GRF_REG(0x0000, 15, 14, 0x1, 0x3),
> +
> +		/* usb-grf */
> +		.usb3otg0_cfg		= RK_UDPHY_GEN_GRF_REG(0x0030, 15, 0, 0x1100, 
> 0x0188),
> +
> +		/* usbdpphy-grf */
> +		.low_pwrn		= RK_UDPHY_GEN_GRF_REG(0x0004, 13, 13, 0, 1),
> +		.rx_lfps		= RK_UDPHY_GEN_GRF_REG(0x0004, 14, 14, 0, 1),
> +	},
> +	.vogrfcfg = {
> +		{
> +			.hpd_trigger	= RK_UDPHY_GEN_GRF_REG(0x0000, 11, 10, 1, 3),
> +			.dp_lane_reg    = 0x0000,
> +		},
> +	},
> +	.dp_tx_ctrl_cfg = {
> +		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
> +		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
> +		rk3588_dp_tx_drv_ctrl_hbr2,
> +		rk3588_dp_tx_drv_ctrl_hbr3,
> +	},
> +	.dp_tx_ctrl_cfg_typec = {
> +		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
> +		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
> +		rk3588_dp_tx_drv_ctrl_hbr2,
> +		rk3588_dp_tx_drv_ctrl_hbr3,
> +	},
> +};
> +
>  static const struct rk_udphy_cfg rk3588_udphy_cfgs = {
>  	.num_phys = 2,
>  	.phy_ids = {
> @@ -1584,6 +1621,10 @@ static const struct rk_udphy_cfg 
> rk3588_udphy_cfgs = {
>  };
> 
>  static const struct of_device_id rk_udphy_dt_match[] = {
> +	{
> +		.compatible = "rockchip,rk3576-usbdp-phy",
> +		.data = &rk3576_udphy_cfgs
> +	},
>  	{
>  		.compatible = "rockchip,rk3588-usbdp-phy",
>  		.data = &rk3588_udphy_cfgs

