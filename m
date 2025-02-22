Return-Path: <linux-kernel+bounces-527312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C1BA40984
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05EE702039
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A821922F6;
	Sat, 22 Feb 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MOG+FDbt"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE12D05E;
	Sat, 22 Feb 2025 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740238443; cv=none; b=oPCR1PplZMihq+d2GyF18MMuk8OJ+8VsR9912ak/jwCejHeDpW8tJfR2t/LEKY6EjeNFJoTzB1M0VYLf2nnsMWDQD7IjuSNoh6Bruu5v22FuKqMg+jdOJsZMkG8JS9gf+1gdNqN+tIl0FWdzRdOGgWG9yFsMnU5QrUL5evpqjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740238443; c=relaxed/simple;
	bh=gselFHu7vsy5BNx95BjFIuNv6dddMJLzHfF5VzpKKco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mupnQuvItKuosIWN1d0oJzXK9ObU7VwhlZ4qNYBNu+T9+VyA5EvAyrawuRS3uEkl0VhCVar1P2+SXUNimfdarr/5CJppQL9S3TVPiMHkogmJdvzmptVByi5cBvqRgyx0TLXbVUxuhhnA+ZNhIl9zE3wnfxg6rjrJ3knikK3v4sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MOG+FDbt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740238438;
	bh=gselFHu7vsy5BNx95BjFIuNv6dddMJLzHfF5VzpKKco=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MOG+FDbtPgNtTCXWLsDR0WErdiDmJBrbvkPx/oyOxKBzM2BF1qO9GiVRudGyfGRrU
	 oVYvPqcOGoMlkz5kBl7m3K2ZR2Tl8wZTk4k8HztAxW/vT8bwGAsHBOQLU7dY11A+nx
	 nv/aG5trfKKT10BLAqG2abLALJSBSx6zosgUxWacb1xLvZJo2jkZkZn79xbj4lIVwc
	 drL8Rqp93ZwIsN1u7hSdIu1tqeE4FcYBQ40+cDSkX2XT3G28qAo8QdokB4BMRIqWY/
	 VrqEIxObqoN6Vit0/jkh7sdRcYdgWchQf+vxFijSCKwYdJYNqRMjqDGyQDw9dHJKFb
	 LAatvEy8LUP8w==
Received: from [192.168.1.90] (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9B3AA17E00BD;
	Sat, 22 Feb 2025 16:33:58 +0100 (CET)
Message-ID: <aca747a9-5244-4535-bc22-976ed4a1dc3b@collabora.com>
Date: Sat, 22 Feb 2025 17:33:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: check for disabled clock-provider in
 of_clk_get_hw_from_clkspec
To: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com,
 sboyd@kernel.org
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 liujianfeng1994@gmail.com, sebastian.reichel@collabora.com
References: <20250220225448.2763166-1-heiko@sntech.de>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20250220225448.2763166-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/21/25 12:54 AM, Heiko Stuebner wrote:
> of_clk_get_hw_from_clkspec checks all available clock-providers by
> compairing their of-nodes to the one from the clkspec. If no matching
> clock-provider is found, the function returns EPROBE_DEFER to cause a
> re-check at a later date.
> 
> If a matching clock-provider is found, a authoritative answer can be

Nit: s/a authoritative/an authoritative/

> retrieved from it whether the clock exists or not.
> 
> This does not take into account that the clock-provider may never appear,
> because it's node is disabled. This can happen for example when a clock
> is optional, provided by a separate block which just never gets enabled.
> 
> One example of this happening is the rk3588's VOP, which has optional
> additional display-clock-supplies coming from PLLs inside the hdmiphy
> blocks. These can be used for better rates, but the system will also
> work without them.
> 
> The problem around that is described in the followups to:
> https://lore.kernel.org/dri-devel/20250215-vop2-hdmi1-disp-modes-v1-3-81962a7151d6@collabora.com/
> 
> As we already know the of-node of the presumed clock-provider, just add
> a check via of_device_is_available whether this is a "valid" device node.
> This prevents ethernal defer-loops.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/clk.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index cf7720b9172f..50faafbf5dda 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -5258,6 +5258,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
>  	if (!clkspec)
>  		return ERR_PTR(-EINVAL);
>  
> +	/* Check if node in clkspec is in disabled/fail state */
> +	if (!of_device_is_available(clkspec->np))
> +		return ERR_PTR(-ENOENT);
> +
>  	mutex_lock(&of_clk_mutex);
>  	list_for_each_entry(provider, &of_clk_providers, link) {
>  		if (provider->node == clkspec->np) {

Without this patch applied, when disabling hdmi0 and hdptxphy0 nodes on
Rock5B, rockchip-drm module fails to probe and hdmi1 output cannot be
used anymore:

rockchip-drm display-subsystem: [drm] *ERROR* failed to get pll_hdmiphy0

After applying the patch, I confirm the error is gone and hdmi1 is
functional again.  Hence,

Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Thanks,
Cristian

