Return-Path: <linux-kernel+bounces-552936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CBDA58136
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E386A3AEF03
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE71115A87C;
	Sun,  9 Mar 2025 06:51:42 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0BC2FD
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741503102; cv=none; b=Co38XFaAQsu27shDvsekW5lY/C6XjFYYbdSXfxB92wdB0xBfPJfuTYeJhfdOpGtsrRyzn0bwdIn/j8OkbGZhcMeIEjMoswcW9ch8MVroH+27Z6pTPj0PcFH79/odHOHkzeA8n03UT0u5IvoWdBxKNPXN+zOleJQ04/BS5bTWrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741503102; c=relaxed/simple;
	bh=9i3kB0uiF+cAxVwrkkle2JYDjeoaYLOYGwAi2FgSGjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uyPQnZO0puGDqCzLXp+rik8rjRO5oJTCJ+fGe68SEmKaIy5zXhB4il7jC2gtZRQ+kNLTJxi2W4oBY39nZDNwS7VXDrgpySFmfbCqfIUjewL02hM9/IvIaJaAhpCOJWd6xYcj0FYhiOIGWrogIdiM0kVfmnf1jRU+rA6Cmo0lBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip2t1741503090t8sbs1w
X-QQ-Originating-IP: XwhKMfl3zf720/W1DEA9jiyONxzExdR32tccPWBx8ps=
Received: from [IPV6:240f:10b:7440:1:893e:bed3 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 09 Mar 2025 14:51:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12559739766669339929
Message-ID: <4F8F58DC9699ED12+95e301f9-a9f1-4f6b-8b8f-21c6c1df5cc2@radxa.com>
Date: Sun, 9 Mar 2025 15:51:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/bridge: synopsys: Add DW DPTX Controller support
 library
To: Andy Yan <andyshrk@163.com>, heiko@sntech.de
Cc: neil.armstrong@linaro.org, sebastian.reichel@collabora.com,
 devicetree@vger.kernel.org, hjc@rock-chips.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 yubing.zhang@rock-chips.com, dri-devel@lists.freedesktop.org,
 Andy Yan <andy.yan@rock-chips.com>, krzk+dt@kernel.org, robh@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250223113036.74252-1-andyshrk@163.com>
 <20250223113036.74252-3-andyshrk@163.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250223113036.74252-3-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M5aCtjAndv5OokQz5mw0F+SQ+D/l5D2NNfqPZVYKX93wjTmzB+AFoFEV
	Ohfl6sNQLzQ0HiUdq3DpzKjbyut/6tkLy/jRs+uOBwugpZtIDzuV4fGVMhk3KN+SznzwiPI
	0CGPowY+olt6vaoTvDgmQKdqoRVeWWOdiyNOabOPPLZNGqViFUW9JV6juCIozKCDz5g1h/6
	/Ev/tPvms3W6vGI9Qx9CY+FWvv1T6JP5R5x1UhOXIvREVV+ztf8zG0qEqCd5QY/2/rTlXCC
	Uyw5UDvKwO8h65HrgmpFVnWJpL1BQIKeIxQGzuCobUDbGcTK7/Z9EeHMxtKgXH+HLAHKwNQ
	DYqQSaOkt+8aut19IRVQt0p5hT1q8EP2Og6jqzw+esQ6qG2ACdnve6SAV+XzuF63SCrVVEZ
	lPNsgtKlsLOzPogwPGORpIL1/UVe1Ejv4cYUM9H+Wk6kXO50BrkxIJas5Y+9SeYHwuUMQrS
	vxeuWlEAxLprxykfq1CTknLr4vrcHPl8x26MDfsvh07m/oJkd6/QgGDV7x8OEV3IpSa44Tk
	cx7zzUL1rFCrWmwAbVdKa5zy46dFoAefirdpo64qtYOR11fD9Dis0E1uBKa4Ovycf+VBHjb
	7O0+4EMxuF6gVH6dVcBtg/JYRp1w3hdjdXL5oVBca2yYOSoGqh3vLi/d1k58GxewOBUFLBW
	pC0rkExJLQVENHzotiIak2JYU6hd6ZVY7vuauFGh2r3NrWPPqBB24PM59GbccLTHAD9vF+F
	4gpx304j3FsuxqJfNu+KMYWehi9nR4xwOYHCbA07kK8I1He1XJg9q8GSNyIQY3iDsnY1YT7
	hRuLiHob/wHx9WRwLt+CiuAnanhobe5SRFRxjsk/EQR58Yw2omBVjWvFTIXBre6hkHNhbsn
	dUV5o7NPD+GHQlNejae/Dn22cVhUZYaxC91mOlHe+z7VcgiNGtaR5g==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Hi Andy,

On 2/23/25 20:30, Andy Yan wrote:
(snip)
> +struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
> +			 const struct dw_dp_plat_data *plat_data)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct dw_dp *dp;
> +	struct drm_bridge *bridge;
> +	void __iomem *res;
> +	int ret;
> +
> +	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
> +	if (!dp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dp->dev = dev;
> +	dp->video.pixel_mode = DW_DP_MP_QUAD_PIXEL;
> +
> +	dp->plat_data = plat_data;
> +	bridge = &dp->bridge;
> +	mutex_init(&dp->irq_lock);
> +	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);
> +	init_completion(&dp->complete);
> +
> +	res = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(res))
> +		return ERR_CAST(res);
> +
> +	dp->regmap = devm_regmap_init_mmio(dev, res, &dw_dp_regmap_config);
> +	if (IS_ERR(dp->regmap)) {
> +		dev_err_probe(dev, PTR_ERR(dp->regmap), "failed to create regmap\n");
> +		return ERR_CAST(dp->regmap);
> +	}
> +
> +	dp->phy = devm_of_phy_get(dev, dev->of_node, NULL);
> +	if (IS_ERR(dp->phy)) {
> +		dev_err_probe(dev, PTR_ERR(dp->phy), "failed to get phy\n");
> +		return ERR_CAST(dp->phy);
> +	}
> +
> +	dp->apb_clk = devm_clk_get_enabled(dev, "apb");
> +	if (IS_ERR(dp->apb_clk)) {
> +		dev_err_probe(dev, PTR_ERR(dp->apb_clk), "failed to get apb clock\n");
> +		return ERR_CAST(dp->apb_clk);
> +	}
> +
> +	dp->aux_clk = devm_clk_get_enabled(dev, "aux");
> +	if (IS_ERR(dp->aux_clk)) {
> +		dev_err_probe(dev, PTR_ERR(dp->aux_clk), "failed to get aux clock\n");
> +		return ERR_CAST(dp->aux_clk);
> +	}
> +
> +	dp->i2s_clk = devm_clk_get(dev, "i2s");
> +	if (IS_ERR(dp->i2s_clk)) {
> +		dev_err_probe(dev, PTR_ERR(dp->i2s_clk), "failed to get i2s clock\n");
> +		return ERR_CAST(dp->i2s_clk);
> +	}
> +
> +	dp->spdif_clk = devm_clk_get(dev, "spdif");
> +	if (IS_ERR(dp->spdif_clk)) {
> +		dev_err_probe(dev, PTR_ERR(dp->spdif_clk), "failed to get spdif clock\n");
> +		return ERR_CAST(dp->spdif_clk);
> +	}
> +
> +	dp->hdcp_clk = devm_clk_get(dev, "hdcp");
> +	if (IS_ERR(dp->hdcp_clk)) {
> +		dev_err_probe(dev, PTR_ERR(dp->hdcp_clk), "failed to get hdcp clock\n");
> +		return ERR_CAST(dp->hdcp_clk);
> +	}
> +
> +	dp->rstc = devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(dp->rstc)) {
> +		dev_err_probe(dev, PTR_ERR(dp->rstc), "failed to get reset control\n");
> +		return ERR_CAST(dp->rstc);
> +	}
> +
> +	dp->irq = platform_get_irq(pdev, 0);
> +	if (dp->irq < 0)
> +		return ERR_PTR(ret);
> +
> +	ret = devm_request_threaded_irq(dev, dp->irq, NULL, dw_dp_irq,
> +					IRQF_ONESHOT, dev_name(dev), dp);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to request irq\n");
> +		return ERR_PTR(ret);
> +	}
> +
> +	bridge->of_node = dev->of_node;
> +	bridge->funcs = &dw_dp_bridge_funcs;
> +	bridge->ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
> +	bridge->type = DRM_MODE_CONNECTOR_DisplayPort;
> +	bridge->ycbcr_420_allowed = true;
> +	bridge->vendor = "Synopsys";
> +	bridge->product = "DW DP TX";
> +
> +	platform_set_drvdata(pdev, dp);
> +
> +	dp->aux.dev = dev;
> +	dp->aux.drm_dev = encoder->dev;
> +	dp->aux.name = dev_name(dev);
> +	dp->aux.transfer = dw_dp_aux_transfer;
> +	ret = drm_dp_aux_register(&dp->aux);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Aux register failed\n");
> +		return ERR_PTR(ret);
> +	}
> +
> +	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> +	if (ret)
> +		dev_err_probe(dev, ret, "Failed to attach bridge\n");
> +
> +	dw_dp_init_hw(dp);
> +
> +	return dp;
> +}

EXPORT_SYMBOL_GPL(dw_dp_bind);

is required to build it as a module.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

