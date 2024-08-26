Return-Path: <linux-kernel+bounces-302143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F285995FA7D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6CD1C212BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBDF199FA7;
	Mon, 26 Aug 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="i+06Vi7a"
Received: from msa.smtpout.orange.fr (smtp-67.smtpout.orange.fr [80.12.242.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F41990DD;
	Mon, 26 Aug 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703498; cv=none; b=XJ0E4Hjb6HA9eNSUrPQQXdarw43K0ylPXhkhjw2SGHvXBbc2UGgGkoaiLGmWMelC9sn6pzetOjYwoCUOvYYO90XDgS6vi0lGjRsz0JhwQvXD37g7wThWWNNmb8ESMYBrh8q+Eez8VeAqq5+BhirqP4OO5EpBvzAjr7emXn8yGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703498; c=relaxed/simple;
	bh=mqIxSbokUhUrlI4Z6Y4CAsDQwMenc+R201GB92WVd1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/oZU3nnbBAS0WEn8RQj509j8DEXJuLBrl7lPCg3Jszk2Z4NJVPc8snQ9SKgCmhQsT2NRwJPWE1Nsj9HbNm7TsevgZj6RdlzXm6Emn9XnTtpL1xpkIbS3u17bz7BB7rxUZCbNx3ZR7UB2/vArUZPi5jqai7ahwI6E5j5+gEhRyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=i+06Vi7a; arc=none smtp.client-ip=80.12.242.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ig97sRs1JZ40aig97sGefO; Mon, 26 Aug 2024 22:17:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724703423;
	bh=EEKBLA9s3IN9cMZguCu/lPHM1YzOcvBlnSShCcVLVxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=i+06Vi7agLuB4C3tck6+Jcx+dpa0G/saHvdaXqHqZS1fdb54+TJ5kj7KsfkRBo+Vv
	 xCStad/ZNz5MaxwvSEREwZQAa5JRbS17h4Ph1g9d5WsBv81m7pZcHr7WSUDHSyTgi+
	 iIKkyLjXB0jFFzoSId/CDe8gaRLrSv+MlLAqBvYShuXeP/1CsWFm91Q+lk3blje7r3
	 2NwftrvnLhz2MENP+g3hdoKoagEldDmBRakGVFBDWwxp6ALRofeW+AtscKqlFXz/0a
	 tjHZdIAxcz24mQJyXr7an442cAVqvkZLW6mW1qYLrOKUqnZO55DPACUpCOnKoe6r+e
	 PgATHL1bHX1ug==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 26 Aug 2024 22:17:03 +0200
X-ME-IP: 90.11.132.44
Message-ID: <a28990d9-1a3b-4368-bd08-9d3188f4817c@wanadoo.fr>
Date: Mon, 26 Aug 2024 22:17:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] usb: pxa27x_udc: Use devm_clk_get_enabled()
 helpers
To: liulei.rjpt@vivo.com
Cc: daniel@zonque.org, gregkh@linuxfoundation.org, haojian.zhuang@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, opensource.kernel@vivo.com, robert.jarzmik@free.fr
References: <20240826081900.2284-1-liulei.rjpt@vivo.com>
 <20240826082218.2331-1-liulei.rjpt@vivo.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240826082218.2331-1-liulei.rjpt@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/08/2024 à 10:22, Lei Liu a écrit :
> The devm_clk_get_enabled() helpers:
>      - call devm_clk_get()
>      - call clk_prepare_enable() and register what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids calls to clk_disable_unprepare().
> 

Hi,

The S-o-b should be here, above the first ---.

Same for patch 4 et 5.

> ---
> v2 -> v3
> Fix the email thread.
> 
> ---
> v1 -> v2
> Incorrect usage of clk_prepare_enable() should be
> corrected to devm_clk_get_enabled().
> 
> Signed-off-by: Lei Liu <liulei.rjpt-DGpbCiVdSXo@public.gmane.org>


> ---
>   drivers/usb/gadget/udc/pxa27x_udc.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
> index 1a6317e4b2a3..0619507d187e 100644
> --- a/drivers/usb/gadget/udc/pxa27x_udc.c
> +++ b/drivers/usb/gadget/udc/pxa27x_udc.c
> @@ -2398,14 +2398,10 @@ static int pxa_udc_probe(struct platform_device *pdev)
>   	if (udc->gpiod)
>   		gpiod_direction_output(udc->gpiod, 0);
>   
> -	udc->clk = devm_clk_get(&pdev->dev, NULL);
> +	udc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>   	if (IS_ERR(udc->clk))
>   		return PTR_ERR(udc->clk);
>   
> -	retval = clk_prepare(udc->clk);
> -	if (retval)
> -		return retval;

Also the patches looks truncated, but sometimes my mailer plays me some 
tricks, but it looks ok on lore. See [1].


The clk_unprepare() in the error handling in the probe and in the remove 
function should also be removed.


CJ

[1]: https://lore.kernel.org/all/20240826082218.2331-1-liulei.rjpt@vivo.com/

