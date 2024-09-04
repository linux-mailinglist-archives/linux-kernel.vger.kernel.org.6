Return-Path: <linux-kernel+bounces-315669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B5996C59B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F2F2881B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64E1E1330;
	Wed,  4 Sep 2024 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QBGUl/ZH"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B350B1E0B83
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471779; cv=none; b=rjjlajeEsvrJe4tgB/2GOFuD2yq71VruVOG8jNlRs7rYTnibuCz1KHABGJqfO5a4MCF1i0lqo1EtXearXjXjl9RYTcTllHakboch4JsBQvnFqZ7EoGoxKiEVWV7F5crsyhG5ahftMmQfJW2tIUVoOcJYinD96ZlM/fO0n8V0KP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471779; c=relaxed/simple;
	bh=dzCeXq4kJqd25q6AuofrZQokmYgnKGcqexMOo2JRw7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWbBpRxw5UtbMr7LPdexBYf5FAdU74KZNYrZqMLLGy2K6i8gb/Jlna5X7Y/5LjMMsk06U+t9C9du+01W36/nsncUm/SvG/cVP5Jb8DOGBOx6X0zOj7ohsRMny7UzhuHry3+LDcEg1qHbKepKFnFmMDq9227Gmp1jD8sJs/2XP24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QBGUl/ZH; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id lu0csB5zB6mdllu0csFqg9; Wed, 04 Sep 2024 19:41:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725471696;
	bh=Gz+G1UGhMXiakvwaWhmOVyl3J132p2bHqoWHWDx2Qww=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=QBGUl/ZHhQEHLosLTmJdHDNUIqTnoLpVsG1/hPb29kyyKTiQuzOxMEIjSkW/rkNEH
	 U5meYQS9qvUsZFfO6wc0+cZtbShNy/o08gMgjyZFgpl8wOZragFLylywGraCov03ei
	 7ySxakdvvGhgQ93/cQJ8g9PE6AeOii24W2vtODgQjVAyqOrvo2hQSw6ya8klRQiUbe
	 WKcLTbmaq/xFttFemH+HT3fIB9s8hgqDl4wWnaWlVikUyYTczajjT3Ykist6LaAqvt
	 r2R8LCztfWBUy7gumMrl9Ow0z2st3D+FLgM6Q1nvzpvmahqf3sSIfKujnn7uBaa01V
	 M+vPe+48hwuYA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 04 Sep 2024 19:41:36 +0200
X-ME-IP: 90.11.132.44
Message-ID: <004f59c4-7401-473f-b15f-02aa5151374b@wanadoo.fr>
Date: Wed, 4 Sep 2024 19:41:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipmi: Use devm_kasprintf
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 minyard@acm.org
References: <20240904041213.53052-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240904041213.53052-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/09/2024 à 06:12, zhangjiao2 a écrit :
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Use devm_kasprintf to simplify code.

Hi,

I don't think that it is correct because __ipmi_bmc_register() is not a 
probe function ans is not called from a probe function. So it is really 
unlikely that a devm_ function is correct.

The kasprintf() you are removing is balanced by a kfree() in 
__ipmi_bmc_unregister().
So you patch would lead to a potential double-free issue.

CJ

> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   drivers/char/ipmi/ipmi_msghandler.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index e12b531f5c2f..5d78b1fe49a8 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -3213,7 +3213,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
>   
>   	if (intf_num == -1)
>   		intf_num = intf->intf_num;
> -	intf->my_dev_name = kasprintf(GFP_KERNEL, "ipmi%d", intf_num);
> +	intf->my_dev_name = devm_kasprintf(intf->si_dev, GFP_KERNEL, "ipmi%d", intf_num);
>   	if (!intf->my_dev_name) {
>   		rv = -ENOMEM;
>   		dev_err(intf->si_dev, "Unable to allocate link from BMC: %d\n",
> @@ -3226,7 +3226,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
>   	if (rv) {
>   		dev_err(intf->si_dev, "Unable to create symlink to bmc: %d\n",
>   			rv);
> -		goto out_free_my_dev_name;
> +		goto out_unlink1;
>   	}
>   
>   	intf->bmc_registered = true;
> @@ -3237,11 +3237,6 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
>   	intf->in_bmc_register = false;
>   	return rv;
>   
> -
> -out_free_my_dev_name:
> -	kfree(intf->my_dev_name);
> -	intf->my_dev_name = NULL;
> -
>   out_unlink1:
>   	sysfs_remove_link(&intf->si_dev->kobj, "bmc");
>   


