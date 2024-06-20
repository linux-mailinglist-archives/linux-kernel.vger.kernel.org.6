Return-Path: <linux-kernel+bounces-223187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAEC910F73
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA63B227C1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F2A1CE085;
	Thu, 20 Jun 2024 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="LCHf4C89"
Received: from msa.smtpout.orange.fr (smtp-77.smtpout.orange.fr [80.12.242.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C61BA09A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904848; cv=none; b=tFRcSrrRGFoGhRZa/TLToWbIQOhePw0NXZVmIIQnwoD5m7u8ynzCDZTyw94R2HSQjsyTpBtoVfHN2jhKUkEEJYWA4ApLGQT+3UDYD9Lxke4JKUoYd4fDsvulybHehaHOdCdCWtHYydSOrHB/Dxghg6M5PhmfeW1saNP2N05ISKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904848; c=relaxed/simple;
	bh=glSNTHtUeLu/rcOgC88ua7XDaG1Mf2HXiQ2NF9aDl2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUqUyg93EmtvtCOe1TZzVSwZ1qeXs+big7/p32Rrd7X1AhDNEWOpZShRTe7lfLZEi6rKUrBslsNcORapWFPfEJB+8Ah1cwUjLymBgXhiQv0iYSxtigIM4YM5PFBVmIaUl8svUBC8bX+weOcgsUcyOuAg9L+Xj3Q+F7eUOpeDbWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=LCHf4C89; arc=none smtp.client-ip=80.12.242.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id KLWwsKMFAqHypKLWwsGfEA; Thu, 20 Jun 2024 19:25:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1718904306;
	bh=pGtxUi0q5KWmIR/HywCcJYufwKCE48nhOS8YwL6MY4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=LCHf4C89oYikuXb2G6s7kd2wUa1Ma61h/Ihh5IqXeuDm50Su7uf1qYCwPAxV2z/Y7
	 i51fac2YWe/dxNdwxuAedRCfan7Tr+ISOr4NzNxH0TbjKuw6hE7jQbNKhyQZZzygoR
	 IRc+gw3wQAhW6Z3ecfFZyDthu/JIqh4ptrEDwzHXnBmQYUar8fzz49MDpu4I/hzyki
	 CoPnP2NjaiPNYyuC+cT0/alwen8jcP8RxwWFkXtgKiGzJY5qtrc0j1QyfxSv5TEk/W
	 WdWqsygVNmD6hiF04ht5/N/syBu77fQPtiynsbKLWmq64ouXGvYebcTgxEig9wbSnZ
	 TnQfZMfliFJEQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 20 Jun 2024 19:25:06 +0200
X-ME-IP: 86.243.222.230
Message-ID: <50ae9a6f-309b-45ee-adf3-ced54e2cfe57@wanadoo.fr>
Date: Thu, 20 Jun 2024 19:25:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel-xinpeng-xpp055c272: add check for
 mipi_dsi_dcs_enter_sleep_mode
To: Chen Ni <nichen@iscas.ac.cn>, neil.armstrong@linaro.org,
 quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240620074802.852544-1-nichen@iscas.ac.cn>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240620074802.852544-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/06/2024 à 09:48, Chen Ni a écrit :
> Add check for the return value of mipi_dsi_dcs_enter_sleep_mode() and
> return the error if it fails in order to catch the error.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
> index 22a14006765e..d7c9df673f35 100644
> --- a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
> +++ b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
> @@ -139,7 +139,7 @@ static int xpp055c272_unprepare(struct drm_panel *panel)
>   	if (ret < 0)
>   		dev_err(ctx->dev, "failed to set display off: %d\n", ret);
>   
> -	mipi_dsi_dcs_enter_sleep_mode(dsi);
> +	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
>   	if (ret < 0) {
>   		dev_err(ctx->dev, "failed to enter sleep mode: %d\n", ret);
>   		return ret;

Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

See: 
https://lore.kernel.org/all/6e3a8cb3956fe94f1259c13053fddb378e7d0d82.1619878508.git.christophe.jaillet@wanadoo.fr/

which never got any feedback.

CJ

