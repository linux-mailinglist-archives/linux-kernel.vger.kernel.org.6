Return-Path: <linux-kernel+bounces-213315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 788309073A9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A78C1C249D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29211448E0;
	Thu, 13 Jun 2024 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="e/MGrL8+"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F91C144313
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285194; cv=none; b=GUczNivAR5UDDzVLxo+QrTsGN1SYfvATb0whW3IF2xBrsC5TczzBtZeJXrxFDBRnXIl0L3UDxTZzffJ/V/DBvfXgJvfWJgIVyvhGR7sU7BGGbEy9UdpgVtl+iTeeSA3+qduurpkDahzj0yGlMITVMuYXZhpwtUyp4cY/9Ogcxkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285194; c=relaxed/simple;
	bh=+VJMgZQRZcXY+XqqyBb10ftV5KWKVE4YsJ45Lh+jfBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R48ydtKre5uZWWIaJ9iqk+czwJT7ebT0nbgbbjuMjCyqT41WPqNHQI92VeHFxYcWsNNinCsq7lXQin9IUVEL+KIoiEn8vws0CQE5JiqQ3812eyeODJ7bfB2iahvw6xZ/aOylx5rxlP3dEWEILKX82hl00kz02ZrdvHD92h/Y8N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=e/MGrL8+; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=tUprEpyoXgVVP7tdG+ofk5Qz4PEKJ2KarjlpvuZlTsU=; b=e/MGrL8+xOYhZEXU
	bmEvKC514mfD+U+3XRIXF569y37YutTiVhEOg8p6h115ixYV6uZdmCsZtuszpJjN0sziy9pbWN0s/
	wcQx89bg0OnQNex673O8qlJvQ6g2xS4humZ6OkaCQKDhGY0kCPWK5FD46TlnGJ6+6vvo6ByA9fEvi
	P8GI28DtZdAxnH3Cz/9tLHOet7go5MDPscy7I1YYu9WIdHVGtV4fZ2UzdHExXUlXyIlvL02f6+4yy
	CQqGtjocTPHpKXxjz3p6+Sj/zbWphw/eiqhnL/A+nO1bxfFeA8jVayDa52VnT1W0VV5zSuYCDf2Ga
	iQHHfxRWbElGyBO6pQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sHkTF-0062MC-0W;
	Thu, 13 Jun 2024 13:26:29 +0000
Date: Thu, 13 Jun 2024 13:26:29 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: mporter@kernel.crashing.org, alex.bou9@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rapidio: removse some dead defines
Message-ID: <ZmrzhW4_ANIfbOYk@gallifrey>
References: <20240528002515.211366-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240528002515.211366-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:25:16 up 36 days, 39 min,  1 user,  load average: 0.03, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'mport_dma_buf', 'rio_mport_dma_map' and 'MPORT_MAX_DMA_BUFS' were
> added in the original
> commit e8de370188d0 ("rapidio: add mport char device driver")
> but never used.
> 
> 'rio_cm_work' was unused since the original
> commit b6e8d4aa1110 ("rapidio: add RapidIO channelized messaging
> driver")
> but never used.
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping?

Dave

> ---
>  drivers/rapidio/devices/rio_mport_cdev.c | 20 --------------------
>  drivers/rapidio/rio_cm.c                 |  6 ------
>  2 files changed, 26 deletions(-)
> 
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index 27afbb9d544b..5c83741c3005 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -97,18 +97,6 @@ module_param(dbg_level, uint, S_IWUSR | S_IWGRP | S_IRUGO);
>  MODULE_PARM_DESC(dbg_level, "Debugging output level (default 0 = none)");
>  #endif
>  
> -/*
> - * An internal DMA coherent buffer
> - */
> -struct mport_dma_buf {
> -	void		*ib_base;
> -	dma_addr_t	ib_phys;
> -	u32		ib_size;
> -	u64		ib_rio_base;
> -	bool		ib_map;
> -	struct file	*filp;
> -};
> -
>  /*
>   * Internal memory mapping structure
>   */
> @@ -131,14 +119,6 @@ struct rio_mport_mapping {
>  	struct file *filp;
>  };
>  
> -struct rio_mport_dma_map {
> -	int valid;
> -	u64 length;
> -	void *vaddr;
> -	dma_addr_t paddr;
> -};
> -
> -#define MPORT_MAX_DMA_BUFS	16
>  #define MPORT_EVENT_DEPTH	10
>  
>  /*
> diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
> index 9135227301c8..97287e838ce1 100644
> --- a/drivers/rapidio/rio_cm.c
> +++ b/drivers/rapidio/rio_cm.c
> @@ -198,12 +198,6 @@ struct cm_peer {
>  	struct rio_dev *rdev;
>  };
>  
> -struct rio_cm_work {
> -	struct work_struct work;
> -	struct cm_dev *cm;
> -	void *data;
> -};
> -
>  struct conn_req {
>  	struct list_head node;
>  	u32 destid;	/* requester destID */
> -- 
> 2.45.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

