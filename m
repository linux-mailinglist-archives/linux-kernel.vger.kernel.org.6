Return-Path: <linux-kernel+bounces-307393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5915D964CF1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106351F229EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7057C1B78E0;
	Thu, 29 Aug 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="pHRKvHEv"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3C4DA14;
	Thu, 29 Aug 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953097; cv=none; b=becWspkUof6NGWq1E4KxDKyly7vCG+x4zDABR4A56aKpffG0tAyKma6lPmqNFyQjwHP3yk8GkzmUGWZAckxwplFgF2lQQ2zMcnQBRjMbOiWoKxC/TgQU5x4bBqHs0ZuBKokXSZhZcubLTGVou+CX8rN2s7gPxg69VikXFuQ/ie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953097; c=relaxed/simple;
	bh=6wsCRnfRZhJ+fkgasXgWSMyOVhetWyJcHAvQJTTQa1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GK+D6tldzkHIENGD3FeauDzzIMt54WWALPkzfg3NWFroGvsqWAsj5fVL2XOQWYBAyARr/G6c5x+g2QtxQa6dAKbwMtK09FZytOSSqFMV3unOMtA083WuKzz6D0rmIrPrCEbrvyfIBsyFjKqZJYbgxSdu+MWO3Z1lVvqtdWMBF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=pHRKvHEv; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id jiZ0syH2EH7HIjiZ0saLgh; Thu, 29 Aug 2024 19:04:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724951044;
	bh=vFUq6Wkcy0AE5wCB1N8GYLdJGL7MAsf/gfEpaG3W36I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=pHRKvHEvZwtEjsH/h40qfU3O6PYuOu0xT/xB9uBmeB/WMTUz2/e/arWGDZUsvfmxv
	 UB3LBJLKSqtlcukPNWkPDe/7RkH+oGYa6PUggVX0JWPU+RhnJiJagfTmp4oplDutb7
	 geOevXBDxEkSYn43I6hjUmCwFkQbkTfN3kKaQcoPmfiUtA8wPsDp3oO9HGTpQww7xB
	 6yEYCymgByITWukMbJt4WeQW4+8fOpkvWukrR9D05n94s/NouoPEY1KpPUwXhl7vV3
	 HcGXSPUyG6VYmvFJGQhMjsqJWfblvY3tE0w5n/YovsxIc7lMtDw/fGlErkT4Qres93
	 /X7Ny1nJ6/Dng==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 29 Aug 2024 19:04:04 +0200
X-ME-IP: 90.11.132.44
Message-ID: <f3b78d27-9a10-44b8-977d-b19e35a1a64a@wanadoo.fr>
Date: Thu, 29 Aug 2024 19:04:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: gadget: udc: cdns2: Simplify with dev_err_probe()
To: "yanzhen@vivo.com >> Yan Zhen" <yanzhen@vivo.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, opensource.kernel@vivo.com, pawell@cadence.com
References: <20240829112822.3193428-1-yanzhen@vivo.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240829112822.3193428-1-yanzhen@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 29/08/2024 à 13:28, Yan Zhen a écrit :
> Use dev_err_probe() to simplify the error path and unify a
> message template.
> 
> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.
> 
> The benefit compared to a normal dev_err() is the standardized format
> of the error code, it being emitted symbolically and the fact that
> the error code is returned which allows more compact error paths.
> 
> Signed-off-by: Yan Zhen <yanzhen-DGpbCiVdSXo@public.gmane.org>
> ---
>   drivers/usb/gadget/udc/cdns2/cdns2-pci.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
> index 50c3d0974d9b..0e904085d968 100644
> --- a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
> +++ b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
> @@ -35,10 +35,8 @@ static int cdns2_pci_probe(struct pci_dev *pdev,
>   		return -EINVAL;
>   
>   	ret = pcim_enable_device(pdev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Enabling PCI device has failed\n");

Nitpick: 'dev' could also be used to be slightly less verbose (other 
opportunities exist in cdns2_pci_probe()).

CJ

>   
>   	pci_set_master(pdev);
>   


