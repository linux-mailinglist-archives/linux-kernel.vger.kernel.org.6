Return-Path: <linux-kernel+bounces-396486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E49BCDC9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013F6B21A7B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFC31D63C6;
	Tue,  5 Nov 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="EeX+x2dV"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E070837
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813355; cv=none; b=K8NuSnSYzuyg9ERvfSRMCLXIuY7KmBXdh50c9apCK2QeoRSHUXSpZCRjvgVlh69G7+8DmMdTCJm4Ae8bvq32uazBkKDgjyjv/sXeYCnPPsz8PDvPT/FJCov3dhfqhuzaMyUP+tiWxkJ7MHT3CecIM2LuW29Dr7TpdDVmzBycbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813355; c=relaxed/simple;
	bh=5vLq71bOa0uxuVJURMdZbx2xJiHa1oOApkUJu/UCOHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQz/kkLi06I9jS7f1GQCW8A21h1Xm6KhZp+tJLu+h1pOInXXrPFs3tp1XyO/BM7LN5cSGGMsGZhWod8p8Sj+p/ZQLzNYpHHTh8786v7yCIGTq/Kk7et795TBPno/IRKDoM2UYs8mjz4qVznmcbeBpEYxe+VAG/v8g4Xq72M+El0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=EeX+x2dV; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Rni1On+4mOltPkVhnP9DXSxhrFHE3c1gu9PqntacxGw=; b=EeX+x2dVtB5Y5gUz
	M57DLCynM4e4fGecj9gyPr31qs0VhBEkxm3oSlszwPnWdtN4jV4jU3EhGglkddUh/TkuOfOybpLrr
	kq2KR2h/TNshQIdstteci+vqCAa3HWx4BkkjRqw70LFnANzGtQBwucbp4zRsSXDutw6QGE1eyz6K4
	P3JgyKt4u6xLCm6qRcyQZs+kjpSHakN4fgVmJAfkhQZu7SKe2u6UHhRD/nlLhl1RDR9twty97izRd
	5YNi9CIf6BxzBZemqQxuXc6IPZwyM0fouFOl+kAUW/BlOySMIOxmBfRHaNZgu0Im+VX4vJrwqrEkE
	FIPX7T5Y3vkq0aMc5w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t8JcF-00FY1n-26;
	Tue, 05 Nov 2024 13:29:03 +0000
Date: Tue, 5 Nov 2024 13:29:03 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: cdn-dp: Remove unused functions
Message-ID: <Zyodn5bfqtqoMTJ3@gallifrey>
References: <20241005232551.307399-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241005232551.307399-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:28:51 up 181 days, 42 min,  1 user,  load average: 0.04, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> cdn_dp_get_event and cdn_dp_dpcd_write were added in 2017 by commit
> 1a0f7ed3abe2 ("drm/rockchip: cdn-dp: add cdn DP support for rk3399")
> 
> but unused.
> Remove them.
> (Build tested only on x86-64)
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping.

Dave

> ---
>  drivers/gpu/drm/rockchip/cdn-dp-reg.c | 39 ---------------------------
>  drivers/gpu/drm/rockchip/cdn-dp-reg.h |  2 --
>  2 files changed, 41 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> index 33fb4d05c506..a57cda971f20 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
> @@ -244,40 +244,6 @@ int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len)
>  	return ret;
>  }
>  
> -int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value)
> -{
> -	u8 msg[6], reg[5];
> -	int ret;
> -
> -	msg[0] = 0;
> -	msg[1] = 1;
> -	msg[2] = (addr >> 16) & 0xff;
> -	msg[3] = (addr >> 8) & 0xff;
> -	msg[4] = addr & 0xff;
> -	msg[5] = value;
> -	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_WRITE_DPCD,
> -				  sizeof(msg), msg);
> -	if (ret)
> -		goto err_dpcd_write;
> -
> -	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
> -					      DPTX_WRITE_DPCD, sizeof(reg));
> -	if (ret)
> -		goto err_dpcd_write;
> -
> -	ret = cdn_dp_mailbox_read_receive(dp, reg, sizeof(reg));
> -	if (ret)
> -		goto err_dpcd_write;
> -
> -	if (addr != (reg[2] << 16 | reg[3] << 8 | reg[4]))
> -		ret = -EINVAL;
> -
> -err_dpcd_write:
> -	if (ret)
> -		DRM_DEV_ERROR(dp->dev, "dpcd write failed: %d\n", ret);
> -	return ret;
> -}
> -
>  int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
>  			 u32 i_size, const u32 *d_mem, u32 d_size)
>  {
> @@ -400,11 +366,6 @@ int cdn_dp_event_config(struct cdn_dp_device *dp)
>  	return ret;
>  }
>  
> -u32 cdn_dp_get_event(struct cdn_dp_device *dp)
> -{
> -	return readl(dp->regs + SW_EVENTS0);
> -}
> -
>  int cdn_dp_get_hpd_status(struct cdn_dp_device *dp)
>  {
>  	u8 status;
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
> index 441248b7a79e..68c3dbff1123 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
> @@ -459,9 +459,7 @@ int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
>  int cdn_dp_set_firmware_active(struct cdn_dp_device *dp, bool enable);
>  int cdn_dp_set_host_cap(struct cdn_dp_device *dp, u8 lanes, bool flip);
>  int cdn_dp_event_config(struct cdn_dp_device *dp);
> -u32 cdn_dp_get_event(struct cdn_dp_device *dp);
>  int cdn_dp_get_hpd_status(struct cdn_dp_device *dp);
> -int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value);
>  int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len);
>  int cdn_dp_get_edid_block(void *dp, u8 *edid,
>  			  unsigned int block, size_t length);
> -- 
> 2.46.2
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

