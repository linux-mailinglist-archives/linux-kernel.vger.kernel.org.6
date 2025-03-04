Return-Path: <linux-kernel+bounces-545543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584B7A4EE5B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB62A3A9317
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA00818CBE1;
	Tue,  4 Mar 2025 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jNP4ReSa"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BBA1F76A8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120227; cv=none; b=DsnuR+7rKWE09YnSI8xcRkbL0w/7QJVHhe32krQaXpe0z536yC5Fd6djL1rOe3HLloD6ey99YbFSrqgoTURHtwWKe/mupN/lGP0nKnompJ9U0wPNlMP/Fxfus0Egtqhnth9i8UGTrM3ocMMJ2eBvOY9w92QX9743PveRi6O9UQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120227; c=relaxed/simple;
	bh=Z7qAp8BgePLwDRIQEm4ooNb8/sKXNc9d4KVJ+VMNhBA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Z3MSJKQCGFuVA4BEhff62TNf5Vy0reFZSfqjWIa5lWPBANyi313ME+AwCqfWkixRKng0ny68n9+Wq+Ek1A1Eq67peXvkunIk4RADcC9Z3r63cf6otl4E3hlz0vCY6bLjCTOdyLbQ+CBdUV/R5qxB6Kl60OYcgHBUtmD7Oo5KB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jNP4ReSa; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741120223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6WzCje76QLUKJGbmYoeUe7d9zKFda9oGc8+kEK4a04=;
	b=jNP4ReSawiAxad9womJccr4tfSjzlhZUJA6DV3kWGJXSysytY4Z8oqIOu2KElbzgCtxThe
	Hb6obA+e0Qo/eYo2+zpV+mtx40sUxmEqUnAw4mQxJbez7q10pXKoybJIO9Uu2fYNmla3cE
	PDPzlUbH2X+2eWAHvki/b8nLITpLoAopv5K8ASny7u2n7w253EIR3hZZPTyz/t/zEY2hvK
	1h4mrF8gHB7qXOgkGIyyPIFUWoBghSgDu13Y9Jz18RqL63V6sJvR3FyqOKdUZrOXV6xRnT
	RG5VgCo8Voq1kDCl3iZs+gL4BxgzMADdzke5argxV/fGYQPeGQ58inZobpDDaQ==
Date: Tue, 04 Mar 2025 21:30:22 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, quentin.schulz@cherry.de, Heiko Stuebner
 <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v3 1/3] drm/rockchip: lvds: move pclk preparation in with
 clk_get
In-Reply-To: <20250304124418.111061-2-heiko@sntech.de>
References: <20250304124418.111061-1-heiko@sntech.de>
 <20250304124418.111061-2-heiko@sntech.de>
Message-ID: <041c5f0e2371817a27577bd0989b9dca@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2025-03-04 13:44, Heiko Stuebner wrote:
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 385cf6881504..ecfae8d5da89 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -448,15 +448,13 @@ struct drm_encoder_helper_funcs
> px30_lvds_encoder_helper_funcs = {
>  static int rk3288_lvds_probe(struct platform_device *pdev,
>  			     struct rockchip_lvds *lvds)
>  {
> -	int ret;
> -
>  	lvds->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(lvds->regs))
>  		return PTR_ERR(lvds->regs);
> 
> -	lvds->pclk = devm_clk_get(lvds->dev, "pclk_lvds");
> +	lvds->pclk = devm_clk_get_prepared(lvds->dev, "pclk_lvds");
>  	if (IS_ERR(lvds->pclk)) {
> -		DRM_DEV_ERROR(lvds->dev, "could not get pclk_lvds\n");
> +		DRM_DEV_ERROR(lvds->dev, "could not get or prepare pclk_lvds\n");

I'm wondering why this patch isn't replacing deprecated DRM
logging macros with their preferred successors in a couple of
places, just like what the patch 2/3 from this series does?

