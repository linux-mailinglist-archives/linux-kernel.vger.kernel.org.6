Return-Path: <linux-kernel+bounces-254765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C57693375D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8AA1C21FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C15B168C7;
	Wed, 17 Jul 2024 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bofsz193"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0682171A1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721198915; cv=none; b=RsJmK2d2BB9wvMTwvEXLJBPv9u4YIYX+QP+VR5O64KSnX7LgUz7qKqIyugDpXH2g2Clf6cTesbXcgzi5pehSfi9vFqcaE62F4t1OtluQvrPzABxqUpk/WBQBIks6GgDKvnpEnMeS8FOslzHr17GLIN5OpjmaHs544kqJiyYsc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721198915; c=relaxed/simple;
	bh=w4XR8BRwSgHXa89olywrbuqeWThrHXi1CuwMlk9O8AU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EWh6m4nt3/4UJgpY0KOrfLL5pMZKgX56NNy4wV4fu7eKvX+YmJzCSjsgcEXk0BvvM2zPeL7Fku9WEY0HyplU/TZQcqHJcqM1p5EzMhtzgRkKVSfwRFniMbcRWEXWsmUz8vcHRlhrwOJXtI9YgjHbsfguJBIr1AtzhJgX0plOCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bofsz193; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721198911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0yxmfGeSvbCAPTimmQtl4ygpw8Pr87mesFa5l5qKaI=;
	b=bofsz193UT+VApa96TwrGt5XwYoT6PzThAHm+/uMMozbo1WXWs8gl94f9UrYi1jJKhfnpb
	CkuBrjtDe3yOxLrLHYaEyxSHdZ9FbHZcjiC7DJeLHk7Fs9a6k1wQzGgO8Qg+a+nfkphmja
	9aHuzpgip6Z3Cdbqn+V22r6fgsg5A9hytqZmjGmQuxbOUo6tE2pJrUZMKoDmzFJsvijyVZ
	HrwhE7XrNjgV/qNr/UjKhscyf/sQXoYeEZh9JQbKR2/u//absegxiXDw9bpl4JYQNETj4L
	Zr3fVmP8+RKWChj4uBrL1P588mvVRCR5rR6wZTe0iw9+gpHDIolTJb+e4Yk5cA==
Date: Wed, 17 Jul 2024 08:48:29 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Cc: heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH] drm/rockchip: dsi: Reset ISP1 DPHY before powering it on
In-Reply-To: <6e0ce232acfe952970e9b37402fe08a3678aa43a.1721196758.git.dsimic@manjaro.org>
References: <6e0ce232acfe952970e9b37402fe08a3678aa43a.1721196758.git.dsimic@manjaro.org>
Message-ID: <e79cbc94804e93464be62e7731def4fa@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2024-07-17 08:29, Dragan Simic wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> After a suspend and resume cycle, ISP1 stops receiving data, as 
> observed
> on the Pine64 PinePhone Pro, which is based on the Rockchip RK3399 SoC.
> Re-initializing DPHY during the PHY power-on, if the SoC variant 
> supports
> initialization, fixes this issue.
> 
> [ dsimic: Added more details to the commit summary and description ]
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> index 4cc8ed8f4fbd..9ad48c6dfac3 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> @@ -1240,6 +1240,14 @@ static int dw_mipi_dsi_dphy_power_on(struct phy 
> *phy)
>  		goto err_phy_cfg_clk;
>  	}
> 
> +	if (dsi->cdata->dphy_rx_init) {
> +		ret = dsi->cdata->dphy_rx_init(phy);
> +		if (ret < 0) {
> +			DRM_DEV_ERROR(dsi->dev, "hardware-specific phy init failed: %d\n", 
> ret);
> +			goto err_pwr_on;
> +		}
> +	}
> +
>  	/* do soc-variant specific init */
>  	if (dsi->cdata->dphy_rx_power_on) {
>  		ret = dsi->cdata->dphy_rx_power_on(phy);

After thinking a bit more about this patch in its original form [1]
that's preserved above, I think it would be better to move the
additional DPHY initialization to dw_mipi_dsi_rockchip_resume(),
because that function seems to be the right place for such fixes.

Please, let me know your thoughts.

[1] 
https://megous.com/git/linux/commit/?h=orange-pi-6.9&id=ed7992f668a1e529719ee6847ca114f9b67efacb

