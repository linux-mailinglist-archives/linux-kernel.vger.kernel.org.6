Return-Path: <linux-kernel+bounces-325245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBC49756D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B731C22848
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70801A304E;
	Wed, 11 Sep 2024 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="juRBtldq"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876B1188A05
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067984; cv=none; b=AH6pdoCdF7GrFMeGaOMX3EsYc3bWdLBZoW2M4sYQDG3i+3rNe+Eej6M1Qe01+qiy/YxvXK+uRXgp9+58R2wOWnn3DHWa8XvEu6MJuVLBsysFnkMyIaamxOLdBGMc4DddTJxfAs76NVOL4+0u+jFAHzo85ZrUv7iAxUKKY+BBzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067984; c=relaxed/simple;
	bh=eQVX/HvNAdH7ieNGqoe48A/iLANp6NUz/OVkfqmJaG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZ66PttTRCAxfEFsLr8MgJosVHMz97CotDT5cWvQ1HD1OYbkG0V2+IhSq/1mwtYc7bt2/tty9sBfniItD05czM11uTLbpq/0+1+YtEe5wzuPDafM8jkITk4/yTIBS9ipoDFoOxsD/8qyRrpuWuB6C40Pmy/4b0IZgiE5dAnOGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=juRBtldq; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4X3kl12syTzDr7Z;
	Wed, 11 Sep 2024 15:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1726067981; bh=eQVX/HvNAdH7ieNGqoe48A/iLANp6NUz/OVkfqmJaG0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=juRBtldqFJKpicpKyNTwaBFOH9eZeUVcwlumYmL0KVl0XOoTKIXDU+RYNQiJF1qrI
	 VTcrdWt0opM+6ekd1l4/dkTMzRod6NjoYxRkr0QwLheVXu312VYknuQYv1yN3dOtwD
	 YVv/4HuJE4ouhcZDO+12ZowgirEv8lssisxP8tpY=
X-Riseup-User-ID: C6F5CEFAD191BE4B1604FD126C732D41621C173EFC061F1032B4AE7545711846
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4X3kkx37K5zJrdB;
	Wed, 11 Sep 2024 15:19:37 +0000 (UTC)
Message-ID: <cf699ab0-8daf-4a1c-b195-0ebe01efa7d7@riseup.net>
Date: Wed, 11 Sep 2024 12:19:34 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: remove myself as a VKMS maintainer
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240911135051.44579-1-rodrigosiqueiramelo@gmail.com>
Content-Language: en-US
From: Maira Canal <mairacanal@riseup.net>
In-Reply-To: <20240911135051.44579-1-rodrigosiqueiramelo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/24 10:50, Rodrigo Siqueira wrote:
> I haven't been able to follow or review the work on the driver for a
> long time and I don't see the situation improving anytime soon. Hence,
> this commit removes me from the maintainers list.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

Acked-by: Maíra Canal <mairacanal@riseup.net>

Thanks for all your work on VKMS, Rodrigo! Would you mind applying this
patch on drm-misc? I'm a bit on a hurry this week.

Best Regards,
- Maíra

> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 333ed0718175..1e6356a1b6c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7346,7 +7346,6 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	drivers/gpu/drm/udl/
>   
>   DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
> -M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
>   M:	Maíra Canal <mairacanal@riseup.net>
>   R:	Haneen Mohammed <hamohammed.sa@gmail.com>
>   R:	Simona Vetter <simona@ffwll.ch>

