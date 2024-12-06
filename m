Return-Path: <linux-kernel+bounces-434939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FEC9E6D2F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D132827C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A91FA27E;
	Fri,  6 Dec 2024 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L41VGT5F"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451BD1D5171
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483942; cv=none; b=plw8qAQ2y8f3NBP+kJg9oZYlGopHGaM0h6gU3fRB/4NhLuQyX8Tp7uHXdQkYHtCpFOpy/vfiFu4WEJb7d0kxi2FnO0KD8NtdDa55onO5lLTtXxfXo/cS6KuP7OKNhf/a8VaVDYyLzTMnHcf/R6yoMexCi/8gnF2OcWU2ODkH1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483942; c=relaxed/simple;
	bh=febNccnQ8RS5XqmrWaBISIo5m25NOTjYjc5TdIMoPfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IV6UpJq2NvdPrzE3xDXOSKTgABNoi/yx66mKlxPqwOOTliPmrcjmMOQClm9H9mUvaWP6gc8Ia24Y1V7y7zXEQ5yXmpgiLO+LsY6GgJzghQxi8081Zx/BLSIYjtBDkrjLWLJt3mrCQbcUR8pDTQJt0HiY0f4q14m8RfZijiNu9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L41VGT5F; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733483937;
	bh=febNccnQ8RS5XqmrWaBISIo5m25NOTjYjc5TdIMoPfA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L41VGT5FtAoj+V8dV/MdyYwwwGpY8uG+Xq+sc+GsYpYTor4ZXKf37LSBrLo0gHG55
	 luGesglz/Qw4rszdWkRLoMYtquLUV+r8tw3xBZCWXmm4uI/sP0WyBudHKgEbUTxPF5
	 oFxtvcsE9uFxxjgnhTbIwQAcqTnsnur1tyrRyAr7y+3FNC2K7ySKTMXztZIoEnGGIF
	 +yyNXronPYeFfRe1M2H60bNjm3JUuHDBz9Md91nVk2ni63DEu1fkL5GoBVvGeca0J+
	 VRBXE+7WsimNnV/uzggEutqBgI2Q446hp+cmkCk+1otGKv6e8NRXyxTJx80+EYWzoq
	 riOeZ2uWHj/nw==
Received: from [192.168.1.90] (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C13B717E362F;
	Fri,  6 Dec 2024 12:18:56 +0100 (CET)
Message-ID: <e6172204-2f3f-4a9c-892c-be85d19ad031@collabora.com>
Date: Fri, 6 Dec 2024 13:18:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] phy: phy-rockchip-samsung-hdptx: annotate regmap
 register-callback
To: Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 quentin.schulz@cherry.de, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20241206103401.1780416-1-heiko@sntech.de>
 <20241206103401.1780416-2-heiko@sntech.de>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20241206103401.1780416-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 12:34 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The variant of the driver in the vendor-tree contained those handy
> comments in the regmap register callback. Having the different ranges
> describe what they are looks helpful.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> index 4ced1479e2dc..c5c64c209e96 100644
> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> @@ -766,13 +766,13 @@ static struct tx_drv_ctrl tx_drv_ctrl_hbr2[4][4] = {
>  static bool rk_hdptx_phy_is_rw_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> -	case 0x0000 ... 0x029c:
> -	case 0x0400 ... 0x04a4:
> -	case 0x0800 ... 0x08a4:
> -	case 0x0c00 ... 0x0cb4:
> -	case 0x1000 ... 0x10b4:
> -	case 0x1400 ... 0x14b4:
> -	case 0x1800 ... 0x18b4:
> +	case 0x0000 ... 0x029c: /* CMN Register */
> +	case 0x0400 ... 0x04a4: /* Sideband Register */
> +	case 0x0800 ... 0x08a4: /* Lane Top Register */
> +	case 0x0c00 ... 0x0cb4: /* Lane 0 Register */
> +	case 0x1000 ... 0x10b4: /* Lane 1 Register */
> +	case 0x1400 ... 0x14b4: /* Lane 2 Register */
> +	case 0x1800 ... 0x18b4: /* Lane 3 Register */
>  		return true;
>  	}
>  

Nice finding!  The HDMI variant of the driver which I used as an
implementation reference (i.e. phy-rockchip-samsung-hdptx-hdmi.c)
doesn't provide these comments.

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

