Return-Path: <linux-kernel+bounces-442168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C61B9ED8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DFB188EDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2E1EE014;
	Wed, 11 Dec 2024 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="KMdXaTrS"
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2661EC4DC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952907; cv=none; b=Cmejk4NsQX/8OiJMQosSqM+t/IszV3bTxFJifif3MNDkS98KcY5CJDfQXDCALQ3Q3eKCFxMjUP+WDYCt08QiLUWrpgplzhmOf6BgH5mECS635LrxTOF/UgtoYEi2AzrzEmVbAzqtATPSErafoieg+CwU1JJ62UZW4/weQv9QQKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952907; c=relaxed/simple;
	bh=jpWuQs4TCVzE3AWJX5bTnxbDG/l1C6uLoxMwR8YzVZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a3NV1qBQ12M75b2OIApYPWZJz/Jrf/ygL/x673bzs94EM5wWHCpYm4X0lGCB6ATd868WPpBiQQkc5ayyZ7tdZ6ZmSaOeESJ8/rRfXpd8MErSm/uKcE8HfTn3hbNc121XmeSvb5QtlFENTNHdiCLXY6viTZmvFAOH/dJjgD4mn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=KMdXaTrS; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1733952895; bh=jpWuQs4TCVzE3AWJX5bTnxbDG/l1C6uLoxMwR8YzVZM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=KMdXaTrS/PNMwJajihaMsUdoElDd8Fp9EoJpegg303HpDzViXoIp/vtjTA9gOgQi4
	 VUjjfPXBTYitdf8xALC1XkJsqQjFGirvO64dwgiw/fqbC3dk117wSN3aOGn+SAmjoq
	 srGanuO9UkjNr799xqwJoG0EbQq0uSdl+/RbLpqxzzkAJ9F+xVPcGGQIBKz7/OmrwR
	 3hYd8We1sUHpnQI/wnbX+Iy5ZmKvYeFuF0XFuV/M0z6hmoEaGg2GY/nwDg/K5YYhte
	 +7ashebrqG/ArBBnKajBdB2ngfE+ANUPREC/3qp9bpBuewMZqH/CJE0PmZULtBAExP
	 QrdZPQFpsgaXi33lJBlWCpxGnht7Ly3ErMr2oFAMs8mABEKLrvLwJN3gJy8EzjqKbm
	 85nQormRvgiWPyIm5cucegked5ELMzhLhqoAm+s/k4ss+sXhq1skZw5CtTPdSoYuKX
	 qoh+4vX6m+/fhkWSpG2UkjVB5C0NqWv7jev4u8ypkKBdoPzKVTVARBIl8vVOfgSYDF
	 +Oj721eFkmEBgzBhIjx6Jkuf9Pkk+hY/25kOFi977zr9Azib+a3T1z3fzoiEHABxSs
	 2fID3XWZcSkxkdKSCFqKSp2sSQsDlyRbZ1+Fq8V28LqrdeTXWxWhIX769JEXDwQ6TM
	 Py+O36oJIGc6xcIIC4t4CCBg=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 85B9E16013E;
	Wed, 11 Dec 2024 22:34:55 +0100 (CET)
Message-ID: <90c892fe-e56c-49b0-b8a3-8a7d6d18fb41@ijzerbout.nl>
Date: Wed, 11 Dec 2024 22:34:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v9,1/6] drm/panic: Move drawing functions to drm_draw
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly <caleb.connolly@linaro.org>,
 Petr Mladek <pmladek@suse.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241204160014.1171469-2-jfalempe@redhat.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20241204160014.1171469-2-jfalempe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 04-12-2024 om 16:45 schreef Jocelyn Falempe:
> Move the color conversions, blit and fill functions to drm_draw.c,
> so that they can be re-used by drm_log.
> drm_draw is internal to the drm subsystem, and shouldn't be used by
> gpu drivers.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>
> v5:
>   * Export drm_draw symbols, so they can be used if drm_client_lib is built as module.
>
> v6:
>   * rebase and solve conflict with "drm/panic: Add ABGR2101010 support"
>
> v9:
>   * Rename drm_draw.h to drm_draw_internal.h (Jani Nikula)
>
>   drivers/gpu/drm/Kconfig             |   5 +
>   drivers/gpu/drm/Makefile            |   1 +
>   drivers/gpu/drm/drm_draw.c          | 233 +++++++++++++++++++++++++
>   drivers/gpu/drm/drm_draw_internal.h |  56 ++++++
>   drivers/gpu/drm/drm_panic.c         | 257 +++-------------------------
>   5 files changed, 318 insertions(+), 234 deletions(-)
>   create mode 100644 drivers/gpu/drm/drm_draw.c
>   create mode 100644 drivers/gpu/drm/drm_draw_internal.h
>
> [...]
> diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
> new file mode 100644
> index 000000000000..cb2ad12bce57
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_draw.c
> @@ -0,0 +1,233 @@
> +[...]
> +void drm_draw_fill24(struct iosys_map *dmap, unsigned int dpitch,
> +		     unsigned int height, unsigned int width,
> +		     u16 color)
> +{
> +	unsigned int y, x;
> +
> +	for (y = 0; y < height; y++) {
> +		for (x = 0; x < width; x++) {
> +			unsigned int off = y * dpitch + x * 3;
> +
> +			/* write blue-green-red to output in little endianness */
> +			iosys_map_wr(dmap, off, u8, (color & 0x000000FF) >> 0);
> +			iosys_map_wr(dmap, off + 1, u8, (color & 0x0000FF00) >> 8);
> +			iosys_map_wr(dmap, off + 2, u8, (color & 0x00FF0000) >> 16);
> +		}
> +	}
> +}
>
u16 is not wide enough for a 24bit color
-- 
Kees

