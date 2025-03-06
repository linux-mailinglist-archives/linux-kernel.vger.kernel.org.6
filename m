Return-Path: <linux-kernel+bounces-549799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DEDA55760
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7F21897A56
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7BB27700D;
	Thu,  6 Mar 2025 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="huKYhB1c"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166D2276034
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292467; cv=none; b=rRQh1c0i4TNmnIFQoRSSy9GvB7/JylIdZyW/couHGrNwH8x/6XR+weswjbgJbRO7ti6H5ydpsyXlA2Rf36XR9VxhLO5rplvpue0K6iHfhZCBBl8i6U6N+s+oeynwj54yLaYqVs0bONiAdUOgd4LGLjTIzIrXcgjErRn66r63xNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292467; c=relaxed/simple;
	bh=GxiDbWNKqgCU+Ke2LkaMoGFA8CQamRLz9lTuH/1CJBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrOGEGsXT2I8AP8psAzxSfsR5IbBmJWD4Fytp3gt5PAw36rspC89bimtCIAMn5WwMpygLgHyKoaZqMpCK6AnOsidMnBQBIrWHpq6RbUQbxDgg80mYm2MPDmdlpsRBXJRsS3EHWmpTFQGQOkku0NmZH+sSia2CZIIDOZfnX/r7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=huKYhB1c; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741292463;
	bh=GxiDbWNKqgCU+Ke2LkaMoGFA8CQamRLz9lTuH/1CJBM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=huKYhB1cXv9cYSWddmu4w08vq6rgbNjAoZOibXwlNZGjgw1NRnpTyWqL235l0T/ct
	 V+JIhNGe8HQs2Pzmk4ARs7Q/e93u6+eKqzbzjfBBB1WU/mne+BugeLhTbJ2TKW2DyP
	 IPVdTzUQI2BwT0lSR9Sc0uc06qY4apBllqOnxrG4Q+n1tQpCEw3b5V+ZEYufI/QQF9
	 Tlu+7BmdXH+N9LSp/fN6c0G+wwLssJAY7sq2+xuJy87/P8C4LPTEhkdqSeDNn8vuo8
	 xKTUZlrOz0LVJSVW8+ulTCi8mPPUqMG4xHBAAGfBXAKfD5BHvJzuZQo500vrz5rwRY
	 qqsos1Rw6j84Q==
Received: from [192.168.1.90] (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B4E1817E05C1;
	Thu,  6 Mar 2025 21:21:02 +0100 (CET)
Message-ID: <751f18a4-900b-4644-9ae7-d28fa44888da@collabora.com>
Date: Thu, 6 Mar 2025 22:21:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: phy-rockchip-samsung-hdptx: Add support for RK3576
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 kernel@collabora.com, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250306-rk3576-hdptx-phy-v1-1-288cc4b0611a@collabora.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20250306-rk3576-hdptx-phy-v1-1-288cc4b0611a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/6/25 9:29 PM, Nicolas Frattaroli wrote:
> Despite the compatible already being listed in the bindings, the PHY
> driver never gained explicit support for it. This is especially a
> problem because the explicitly listed PHY addresses need to be specified
> for each SoC.
> 
> To solve this, add the compatible, and a PHY config, with the address
> gleaned from rk3576.dtsi.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
> I thought this must've been already submitted somewhere, but it wasn't
> in linux-next and searching for the modified file on lore also didn't
> yield any results. I guess this slipped through the cracks, and
> torpedoes HDMI support for RK3576 entirely until merged, so it'd be
> great if this could be merged in time for 6.15.
> 
> Let me know if I'm just very confused and this is already handled in
> some other series that's about to be applied.

I'm not aware of this being submitted as part of another series, that's
probably because commit f08d1c085638 ("phy: phy-rockchip-samsung-hdptx:
Don't use dt aliases to determine phy-id"), which actually changed the
approach of mapping the PHY IDs, has been applied fairly recently.

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Cheers,
Cristian

