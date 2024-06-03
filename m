Return-Path: <linux-kernel+bounces-199511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C2A8D87F4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258461F2289C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147F612E1CE;
	Mon,  3 Jun 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="d/I1cH1f"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065992913
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717435841; cv=none; b=cxc5UCTx/IVZved3xqgKbDTUMl4fuUh9TkJ2ZAkk1pk9yHiH6gz1b5KR23ikKC72iLGeI2UFzqXSCG8CBySs4MrZPqpYbcnuAf6TQUWl6luMu0+Fl1LUXWYuDycl1/PpGHvxpc05uYiwgXu58tZvejOu0PIqiUCRuDWl39+YuUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717435841; c=relaxed/simple;
	bh=AH0ORQ2+FiOgmROqUAU5kSCSmx4ZC+ymAxvmuq/3NWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKIJz/TECBDSaDjX/MUrjNnFe7j54/zn/I2Lb3sW1niNIDCWUW3MKAQkrX2yeQez1aO2WBjsX/8oj5lDp1ycRGk/jsWFYCW7LS7YTrEwvmdqAaL4NcCcttPM4xej0BkAK4JWO03bASih0rCbCcz1GMfsDqGbbBHr5fPBYQSI/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=d/I1cH1f; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=N1rA3ay0tZG+PPeHYHe8unqz8YmRW6XYkHVM0lfB4Dw=; b=d/I1cH1fk5K56xrJ
	nJHlCjeC/Gt73oh4PlPiL3mfaYyOMq4eUTIJy6ZVuYB0zxtn/SGyPd39jH2VUhEsqNxzeNuOdGWaW
	NMS8WAATQNy4apezaQHsCPsHD3U0QvpHGLfhgI1mvhu+hkM33TALSVtwl74ZL0R2GmDTj3QMijweG
	Yrxm3q3Jjd2LqRBgxUIbKXYLOU0eJMaFG0s5njtZjgiS16KO5fNhxeuYVkPKkdCRIbS7d9C4e8aSk
	L/Ob5zua3j1qmS8RRJP7cS5KNxPw/hF+V0Tzg1XMTMHZ6l+1s+xI0LPdp1Vl8/Lz3s4SbZnIi3rzv
	zw49hFDcVq8D9Hz7Pw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sEBVz-003zuI-0j;
	Mon, 03 Jun 2024 17:30:35 +0000
Date: Mon, 3 Jun 2024 17:30:35 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com
Cc: bskeggs@redhat.com, daniel@ffwll.ch, nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] drm/nouveau: remove unused struct 'init_exec'
Message-ID: <Zl39u4zOif2Sw4Sa@gallifrey>
References: <20240517232617.230767-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240517232617.230767-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:29:59 up 26 days,  4:44,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'init_exec' is unused since
> commit cb75d97e9c77 ("drm/nouveau: implement devinit subdev, and new
> init table parser")
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping.


> ---
>  drivers/gpu/drm/nouveau/nouveau_bios.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
> index 79cfab53f80e..8c3c1f1e01c5 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bios.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
> @@ -43,11 +43,6 @@
>  #define BIOSLOG(sip, fmt, arg...) NV_DEBUG(sip->dev, fmt, ##arg)
>  #define LOG_OLD_VALUE(x)
>  
> -struct init_exec {
> -	bool execute;
> -	bool repeat;
> -};
> -
>  static bool nv_cksum(const uint8_t *data, unsigned int length)
>  {
>  	/*
> -- 
> 2.45.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

