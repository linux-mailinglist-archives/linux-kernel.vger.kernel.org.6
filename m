Return-Path: <linux-kernel+bounces-302154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256F995FAA3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2092827A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BE219B3C4;
	Mon, 26 Aug 2024 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="IjyR2HMR"
Received: from msa.smtpout.orange.fr (smtp-83.smtpout.orange.fr [80.12.242.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8874B19A298;
	Mon, 26 Aug 2024 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704080; cv=none; b=oxyo24PpA7xlAVWiPyTNqmLkQJEg9Y+irzGkYWhqaMB6brCueo2H3H2LUldxVG7SW8hVk8fdx3t9NJF9v4qPGoNnXIZMbg2aG0K3Z8Z0/l9JplMmDj30UYN0u13A27zi+DkVgmNgdULZ79c11VxAngCcdQUfvKfV9/FQJ85TBPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704080; c=relaxed/simple;
	bh=fsxxXapyT+kN9sqKbfBs4Ozj/9S7FVRHQDjVHvsXIUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ad5A0CBIyfpmQL4ImwGkJfTPx4lmurUNgvv9CShzjXL7Hn/H15q/og8GyyV91bcOZTUKkqLDmajm9VtsZSnthJ799SWqrxYv9qRc5T9JQOT2RiMt67NO4zfNmvdo70n4atLNA8kR97hc51Uxo/D5Us7+ziAup3Y/blJm7+a1wow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=IjyR2HMR; arc=none smtp.client-ip=80.12.242.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id igJYs8xhgQYYuigJYsIi3k; Mon, 26 Aug 2024 22:27:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724704070;
	bh=xTXKc9zNFiZkOYEs4rj07ohFdGVs1EqSkxzdXB/HFAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=IjyR2HMRJuSOw1YXGzf9JnsaiIgS6oYSDqlJhZ7WMUBn36/+PPhGwYwH9lDUOyotB
	 cOaX4+CSgHvjpKOstiGYjkxy+O88tzRaq4cZYDEW9EMs/pA/qbpzuVUJbwVN/pKfKA
	 Et9CUdL8CR9L8Ar5TvNib/qVLWps7/abkLr+E1w5RpC8kGfjSmvkBVWFr2U2UbcC1n
	 Y4f01nCib6wWX7ryhOkD23rtiONWS0vYeVk8EZiRDNKWyYrOLkzOpNkC7owJchjTJd
	 9JH5Yv5U5mHslxqtMDMote5gFnDyCkfpdaiKgE19Mjr/S/PgFN/1XGrGDmeUaX2gGv
	 Swhst51rMvQaw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 26 Aug 2024 22:27:50 +0200
X-ME-IP: 90.11.132.44
Message-ID: <b439b38a-a37a-4734-afd8-736ce047b5d7@wanadoo.fr>
Date: Mon, 26 Aug 2024 22:27:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] usb: r8a66597-udc: Use devm_clk_get_enabled()
 helpers
To: liulei.rjpt@vivo.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, opensource.kernel@vivo.com,
 u.kleine-koenig@pengutronix.de
References: <20240826081900.2284-1-liulei.rjpt@vivo.com>
 <20240826082334.2351-1-liulei.rjpt@vivo.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240826082334.2351-1-liulei.rjpt@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/08/2024 à 10:23, Lei Liu a écrit :
> The devm_clk_get_enabled() helpers:
>      - call devm_clk_get()
>      - call clk_prepare_enable() and register what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids calls to clk_disable_unprepare().
> 
> Signed-off-by: Lei Liu <liulei.rjpt-DGpbCiVdSXo@public.gmane.org>
> ---
>   drivers/usb/gadget/udc/r8a66597-udc.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
> index db4a10a979f9..bdbe5ead741e 100644
> --- a/drivers/usb/gadget/udc/r8a66597-udc.c
> +++ b/drivers/usb/gadget/udc/r8a66597-udc.c
> @@ -1812,10 +1812,6 @@ static void r8a66597_remove(struct platform_device *pdev)
>   	usb_del_gadget_udc(&r8a66597->gadget);
>   	del_timer_sync(&r8a66597->timer);
>   	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
> -
> -	if (r8a66597->pdata->on_chip) {
> -		clk_disable_unprepare(r8a66597->clk);
> -	}
>   }
>   
>   static void nop_completion(struct usb_ep *ep, struct usb_request *r)
> @@ -1876,18 +1872,17 @@ static int r8a66597_probe(struct platform_device *pdev)
>   
>   	if (r8a66597->pdata->on_chip) {
>   		snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
> -		r8a66597->clk = devm_clk_get(dev, clk_name);
> +		r8a66597->clk = devm_clk_get_enabled(dev, clk_name);
>   		if (IS_ERR(r8a66597->clk)) {
>   			dev_err(dev, "cannot get clock \"%s\"\n", clk_name);
>   			return PTR_ERR(r8a66597->clk);
>   		}
> -		clk_prepare_enable(r8a66597->clk);
>   	}
>   
>   	if (r8a66597->pdata->sudmac) {
>   		ret = r8a66597_sudmac_ioremap(r8a66597, pdev);
>   		if (ret < 0)
> -			goto clean_up2;
> +			goto err_add_udc;

Hi,

Here and below, now we have an additional r8a66597_free_request() in the 
error handling path, even if r8a66597_alloc_request() was not called 
yet. + see my other comment below.

>   	}
>   
>   	disable_controller(r8a66597); /* make sure controller is disabled */
> @@ -1896,7 +1891,7 @@ static int r8a66597_probe(struct platform_device *pdev)
>   			       udc_name, r8a66597);
>   	if (ret < 0) {
>   		dev_err(dev, "request_irq error (%d)\n", ret);
> -		goto clean_up2;
> +		goto err_add_udc;
>   	}
>   
>   	INIT_LIST_HEAD(&r8a66597->gadget.ep_list);
> @@ -1939,7 +1934,7 @@ static int r8a66597_probe(struct platform_device *pdev)
>   							GFP_KERNEL);
>   	if (r8a66597->ep0_req == NULL) {
>   		ret = -ENOMEM;
> -		goto clean_up2;
> +		goto err_add_udc;
>   	}
>   	r8a66597->ep0_req->complete = nop_completion;
>   
> @@ -1952,9 +1947,6 @@ static int r8a66597_probe(struct platform_device *pdev)
>   
>   err_add_udc:
>   	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
> -clean_up2:
> -	if (r8a66597->pdata->on_chip)
> -		clk_disable_unprepare(r8a66597->clk);
>   
>   	if (r8a66597->ep0_req)
>   		r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);

This error handling path looks broken.
r8a66597_free_request() is called twice with the same arguments.

CJ

