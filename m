Return-Path: <linux-kernel+bounces-199505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834138D87DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDD728543C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590BC136E1C;
	Mon,  3 Jun 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ewxxzmI2"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7034225622
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717435496; cv=none; b=NpOfRThhLKbYgGOdvPStgJU9Qlwlhs6XWa320bo3NGa+1yzMiCcO3YEDkFqsPfPKAFhUdBBdBqzJhavVIZPm5ewoZQxgGnlrQtZtw3JRq9jcDhS5rc7lxKamzyBWKdyzMJ/kEx20m94zg0+hb4ExleJuWH14p1XoXBMzPRmiUcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717435496; c=relaxed/simple;
	bh=xXRVFeBg/HCnPP+EMU2VyBEWFYJSrj6BdfkaWItyw8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biaMFfBQXedGkowj6dUW5ZFSADQTOi/JYNr2CulBaDh4HmKHVyvpo4TAm8elNhenaF0m23e9PTEs9D1mLtTgDLYj6hQtJX3ZpRhoYfRowc50PhrOaocsGCfRH5uvJyd7iiNV72S8iLs9aIZoHVfI8Pme2ZpInNkHl19vOmJTNAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ewxxzmI2; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=iwxVgDKgpII9YwB+g1rLq5aAZrKLOtuFQoD3t7nzPuk=; b=ewxxzmI2dZ1KiJRS
	YLOAoOTNEBjRnVpNLVkbJ8jiuJ1VYzqKuQaAFUvK0qw60+1dWHsFzsyvfiaSzMRh11srltfLzd/gi
	gu+2OPHm1HfV3Qotv2tKhTdpSw1LHoaOPHxOo6281klS9cJpM/43vC3LlBsyyBWhoitjYy0BSdlRS
	fYv21e+55BmIMBx/j6xbkLTXmO6wYS3LH5TzXelFhuiHMidVvXOF/SdDlP/P071DxDYD/+wQbcViE
	Unv8lGVCVPBx1/+bhL1/ELvg+2Q82nbguN8oYl56mjz8i/tqeDsPGoOHHU9ZSsqY5O9YbZuP/Jphf
	jfkKFZWwxWQmZkglxw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sEBQL-003zrJ-2E;
	Mon, 03 Jun 2024 17:24:45 +0000
Date: Mon, 3 Jun 2024 17:24:45 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de
Cc: daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] drm/vmwgfx: remove unused struct 'vmw_stdu_dma'
Message-ID: <Zl38XRm7TAfb3azW@gallifrey>
References: <20240517232858.230860-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240517232858.230860-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 17:21:53 up 26 days,  4:35,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'vmw_stdu_dma' is unused since
> commit 39985eea5a6d ("drm/vmwgfx: Abstract placement selection")
> Remove it.

Ping.

> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> index 2041c4d48daa..50022e9e3519 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> @@ -85,11 +85,6 @@ struct vmw_stdu_update {
>  	SVGA3dCmdUpdateGBScreenTarget body;
>  };
>  
> -struct vmw_stdu_dma {
> -	SVGA3dCmdHeader     header;
> -	SVGA3dCmdSurfaceDMA body;
> -};
> -
>  struct vmw_stdu_surface_copy {
>  	SVGA3dCmdHeader      header;
>  	SVGA3dCmdSurfaceCopy body;
> -- 
> 2.45.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

