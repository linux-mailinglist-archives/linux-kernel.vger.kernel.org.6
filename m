Return-Path: <linux-kernel+bounces-434953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEB59E6D62
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168D5286344
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FB91FCFC3;
	Fri,  6 Dec 2024 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FNf7w7i0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C79F1FCF77
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484400; cv=none; b=rLrsi0j64IHr4Gu4qe0zP3ec19lSrA7UfnpxiZml5HcUmHU0sCHyx7WZQQxh8c4Hxgb33r6UjrFSUJpbpYrGQy+dF0dQDbEtqS8OqXas9NsoT/j+TLkEZJ4vlJqavRk45WxY96wplCBVO+XynGds/lihdYFAzFYvPdOUlcxrGG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484400; c=relaxed/simple;
	bh=92LOd4MVW8Q5TbMDOf61nL89xm4rnQFTUKQsD73JLss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9+IrKWTGhPf7fD0B4AviCYAUo6GSIZGYNP8c2wI6SS4AK5qzYT+SnOa5m80TQ+FVWtgW2JH9HZ74ULJK9yX2n1NsGTOj8Qz3U26zaD4mjAhl3iCoRh+lCkmLY2mHZpEum2imQVB06iS+OFYUguGaByA+rmP/4ZqYtG6DC8I+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FNf7w7i0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733484396;
	bh=92LOd4MVW8Q5TbMDOf61nL89xm4rnQFTUKQsD73JLss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FNf7w7i0c3cowGaiFG8pUSh1g1UNSADZB4AaL/dDcWwsOrivA21zTi/NBBqTuXE8f
	 MvT0q5EJ7owzF/J4OzM36JE9qEZUegyzP+s4diMmg0PR+qgrO+Z/W4FDy8998ZVUJ6
	 APbPjeFis4XgoJtt+J+KZCLs+X00bvtOD1hLcApU5pGWNv834fCj6aG8t+GV0CQ2Ui
	 iJuGN+hLeitnRl7Ccfr4GGnziJlzwqdex129nUVsKcmKI6DYUVIyIxZAnfDANJm9QC
	 p6dnvJzX1U1xtiIiBB0zmC3+WEH3FTW48CwAGih+WiO974m2sgsDUxyl/NSgmdoTs2
	 0i/xIgiWn1VKQ==
Received: from [192.168.1.90] (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 57DB417E3614;
	Fri,  6 Dec 2024 12:26:36 +0100 (CET)
Message-ID: <87273a36-07f9-4224-bfff-63e905be9b0a@collabora.com>
Date: Fri, 6 Dec 2024 13:26:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: phy-rockchip-samsung-hdptx: Don't use dt aliases
 to determine phy-id
To: Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 quentin.schulz@cherry.de, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20241206103401.1780416-1-heiko@sntech.de>
 <20241206103401.1780416-3-heiko@sntech.de>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20241206103401.1780416-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 12:34 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The phy needs to know its identity in the system (phy0 or phy1 on rk3588)
> for some actions and the driver currently contains code abusing of_alias
> for that.
> 
> Devicetree aliases are always optional and should not be used for core
> device functionality, so instead keep a list of phys on a soc in the
> of_device_data and find the phy-id by comparing against the mapped
> register-base.
> 
> Fixes: c4b09c562086 ("phy: phy-rockchip-samsung-hdptx: Add clock provider support")
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 50 ++++++++++++++++---
>  1 file changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> index c5c64c209e96..b137f8c4d157 100644
> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> @@ -385,11 +385,22 @@ enum rk_hdptx_reset {
>  	RST_MAX
>  };

[...]

> +
> +	/* find the phy-id from the io address */
> +	hdptx->phy_id = -ENODEV;
> +	for (id = 0; id < hdptx->cfgs->num_phys; id++) {
> +		if (res->start == hdptx->cfgs->phy_ids[id]) {
> +			hdptx->phy_id = id;
> +			break;
> +		}
> +	}
> +
> +	if (hdptx->phy_id < 0)
> +		return dev_err_probe(dev, -ENODEV, "no matching device found\n");

Maybe we could simply fallback to assume phy1 doesn't exist in this
case, which avoids the need to provide a match data with a single entry.

Regardless,

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

