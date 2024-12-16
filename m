Return-Path: <linux-kernel+bounces-446838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F499F29CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685AE1668DC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96401C0DF0;
	Mon, 16 Dec 2024 06:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QQJNvZkX"
Received: from mail-m3285.qiye.163.com (mail-m3285.qiye.163.com [220.197.32.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329A322E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734328995; cv=none; b=AUC5KB8PBeirQZGgtFbhGqzyELzjCwJgnlNkq8m2gYyDzKPzk38YAlgLYG+jXenYhMFOU0SE/WvE1YfyDnIFcxMoqiF8IT/+zE5o4XvPP7cJxJcmUG6ddf3Cpm9Hdbzalz24dzSq0u/etxOoSaQxMr4vWQTO+0k90EmLf8U26YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734328995; c=relaxed/simple;
	bh=YnCePJWoz9FkSVTLpE3C9sEeuTuQrhRVU06qePhamQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T17o7oSiRD7dAJlJOJWCNHaMJEFCAauwNSOlLKlJ+z2OLO9X1150nPNeCfErhgCI0rLAgRPwqkQZx3LrAFT5Sh3f2ND83+AwXpBIUgqRI+KcLzGKFnZ6UEQ5yJgx6+5A/Al2SKThomy+jylFL21Df3qfw6kd9+v94/xsyn1GMF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QQJNvZkX; arc=none smtp.client-ip=220.197.32.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5d0822af;
	Mon, 16 Dec 2024 11:40:46 +0800 (GMT+08:00)
Message-ID: <69751cb9-006b-485b-b3da-b8d2788d519a@rock-chips.com>
Date: Mon, 16 Dec 2024 11:40:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: rockchip: phy-rockchip-typec: Fix Copyright
 description
To: Andy Yan <andyshrk@163.com>, kishon@kernel.org,
 linux-phy@lists.infradead.org, vkoul@kernel.org
Cc: heiko@sntech.de, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, sebastian.reichel@collabora.com,
 Andy Yan <andy.yan@rock-chips.com>
References: <20241215092441.3447155-1-andyshrk@163.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241215092441.3447155-1-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk1DT1ZJGUhLHR9IS0odSk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93cd8ddd4f03afkunm5d0822af
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODY6Fjo4QjIRKiFWCS0ZDkIc
	EDYwFClVSlVKTEhPSElLT09DSU5IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS09MNwY+
DKIM-Signature:a=rsa-sha256;
	b=QQJNvZkXkO4xuFK3Ssdr4t6ucRRATY442NcfcCZHa/oPkc1P0vGuqltjBsjzakKXb/VB0IMMzWWo8Ce/emekE7FNLYHtaQwsXGrPWHeap2sJ5GZOu7KwHDoDarleZyOz6m/jUzejrmQlvqpkV8hn+o7/VrnU2mIwAUFoSvvjnmA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Fx0nkf+AyUanISVWFcHsI/N1SR2FzzXYHeCfgWZJivE=;
	h=date:mime-version:subject:message-id:from;


On 2024/12/15 17:24, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
>
> The company name has update to Rockchip Electronics Co., Ltd.
> since 2021.
> And change Co.Ltd to Co., Ltd. to fix mail server warning:
> DBL_SPAM(6.50)[co.ltd:url];
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
>   drivers/phy/rockchip/phy-rockchip-typec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
> index 122ae0fdc785..7b1dba252ce9 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
> - * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + * Copyright (c) Rockchip Electronics Co., Ltd.
>    * Author: Chris Zhong <zyw@rock-chips.com>
>    *         Kever Yang <kever.yang@rock-chips.com>
>    *

