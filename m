Return-Path: <linux-kernel+bounces-554180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DFEA59414
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B5C16780B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3733C22171A;
	Mon, 10 Mar 2025 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TZ+MqTOP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F4114F11E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609181; cv=none; b=HWlWClnAbDsaC2ydHp5upw3akcJBLCGJXm+GuI9rqGxXUTbBfxQHa3r2tINqx7g90ESP7Sifh9qiOkVOscpnUgDdFmeD+55VYlSVVKHA1N9+Ksl+7gYIvwAJrxjeaaRYVeuU+GVpsJfhtNLVlRiy8QpYW+V7Nrr3cnxVHYl9rF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609181; c=relaxed/simple;
	bh=PoOj+vZroaEYQzcVfLHjjBM/oMbNxPsFZdXJ2HsjyBU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KD6ck0srU4LFqI6BBabNIM9up9+FsPhURRERGya8tP0Vyj+kexXHfs1p7pmRxjlMe3R9TCgkcNFC2GDyEX5y2Rogtf6x5QIM8juaVJcArgP947v5C6uGw2x/RfML93NOvpO+HILNJGvc8Q4kZTp7gAafR+jG6kVvfpdEwL4SBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TZ+MqTOP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741609171;
	bh=PoOj+vZroaEYQzcVfLHjjBM/oMbNxPsFZdXJ2HsjyBU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=TZ+MqTOPq3ASPEY5z5UfJ5INMJ655YshSCVf2ImRwnnlSfaJcHmisEbSdtnxj9bTx
	 2DoNJ9W7jSoSBHOid9VXeoua7W2+wDOqeMbu9c0EHS6IHgWU/dTaLOBPzbN5xKQgNN
	 fpDezVtdlUSQQX+kcBL8744G2++DG2oKvwDGc0QG7bTshjSmrxI/WQ72sv2nf0D0r5
	 5HwkN3YwGGa6jKscyVLk40X/1vvBJlfZm9dMnL6SiDNnDOGErEqCKK143cuXu5jhak
	 012G6pmB3o1fXeGA5jZoljFWlRZceHDK3dB7ScJvwv9TIz1/4MJ+OrnZV4Zu4205Pb
	 PsJAiFfYDMX+Q==
Received: from [192.168.50.250] (unknown [171.76.87.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 771DF17E0E8D;
	Mon, 10 Mar 2025 13:19:29 +0100 (CET)
Message-ID: <b6e09b4d-0718-4318-b666-0be405a77b86@collabora.com>
Date: Mon, 10 Mar 2025 17:49:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] MAINTAINERS: Update drm/ci maintainers
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, helen.koike@collabora.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, robdclark@gmail.com, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, valentine.burley@collabora.com,
 jani.nikula@linux.intel.com, dmitry.baryshkov@linaro.org,
 mripard@kernel.org, linux-kernel@vger.kernel.org
References: <20250205134811.2002718-1-vignesh.raman@collabora.com>
Content-Language: en-US
In-Reply-To: <20250205134811.2002718-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/02/25 19:17, Vignesh Raman wrote:
> Update drm/ci maintainer entries:
> 
> * Add myself as drm/ci maintainer.
> * Update Helen's email address.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b256bb4f6d3f..2b4e08c7e119 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7940,7 +7940,8 @@ F:	drivers/gpu/drm/ttm/
>   F:	include/drm/ttm/
>   
>   DRM AUTOMATED TESTING
> -M:	Helen Koike <helen.koike@collabora.com>
> +M:	Helen Koike <helen.fornazier@gmail.com>
> +M:	Vignesh Raman <vignesh.raman@collabora.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

applied to drm-misc-next

Regards,
Vignesh


