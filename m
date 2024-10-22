Return-Path: <linux-kernel+bounces-375882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 817659A9C40
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E891C21976
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB8C15B11D;
	Tue, 22 Oct 2024 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Nrph9NcI"
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BD815539D;
	Tue, 22 Oct 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585260; cv=none; b=YHwmx71p1XzJ8Fn10laqVIyqC9P1MuO+EJwcBhlDjyrA3yyo00JmRc5spwFEJdB/sZniI/SDLPJeiDwdv7rW6mL9QiibPl8EoWnRtRdZOTBWtL/GPmqlS9uFeLXH5nXbXxX5cpfib1XhMp/3l7lxjtT3+R7TKwu1jTRSM3l1Ye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585260; c=relaxed/simple;
	bh=wFNU9gc6itmoel8kOvr/Q8E310AzuMPvxuprLzxxog4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pco44Ei6TX9ni8NceFjcIq0V6q9D4uuB0rybSDzSUB5+FgX1jhR8I5qETN5xKKI5pNREVqXPU4GFiwAq5pIhSaEXPReyZi7mKyULSVgHr+UJ/QDsStrrvmER/Jxc6T4jrRF6B7NKeQN5BkG/9whCtt6ipmEyzK19Srze0QdFQdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Nrph9NcI; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 3A8MthiEoQI3S3A8MtBiL2; Tue, 22 Oct 2024 10:20:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1729585255;
	bh=+UHtMM+mktPErr3gqyJcQJ6mFPLimyEdmUfJrpTeVyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Nrph9NcIG7spGvHLD+l/n6pm8ap6yFyF/ChPQczqkyoY8p+tV3lzFb4RYIrNjT2vz
	 D3IdawWXWyiOQ05zisvxSK0RCH0GxZSIYgOXJSrH2TrClyK/7pTk2ae+cE29RGcTDZ
	 UHhtvhE27jSK3eagtPSsXwpZoOspMc3BysHfh3Gwpl9l2eJITRrN3DxVmKXr3oGaBP
	 EQgfc1ZXS8GxrpbEDKRQDQcwsZpQghFoD7mSavkS+y3IMK/O92NyKI4nsrkN0yntYw
	 bmWuhYluIOQMoaAu53eJ5Ucb4QK9qun+yzpA+2SVSdKy3Pgm5TSmCebXM2UPjG616O
	 FHWTy0okuaQMw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 22 Oct 2024 10:20:55 +0200
X-ME-IP: 90.11.132.44
Message-ID: <308caed5-5d58-4e6c-8bc8-82c34452bd72@wanadoo.fr>
Date: Tue, 22 Oct 2024 10:20:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (it87) Add support for IT8625E
To: Ai Chao <aichao@kylinos.cn>, jdelvare@suse.com, linux@roeck-us.net,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Newsgroups: gmane.linux.kernel.hwmon,gmane.linux.kernel
References: <20241022081453.75253-1-aichao@kylinos.cn>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241022081453.75253-1-aichao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/10/2024 à 10:14, Ai Chao a écrit :
> Add support for IT8625E on Centerm P410.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>   drivers/hwmon/it87.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index e233aafa8856..fac7b10d51bc 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -15,6 +15,7 @@
>    *            IT8620E  Super I/O chip w/LPC interface
>    *            IT8622E  Super I/O chip w/LPC interface
>    *            IT8623E  Super I/O chip w/LPC interface
> + *            IT8625E  Super I/O chip w/LPC interface
>    *            IT8628E  Super I/O chip w/LPC interface
>    *            IT8705F  Super I/O chip w/LPC interface
>    *            IT8712F  Super I/O chip w/LPC interface
> @@ -163,6 +164,7 @@ static inline void superio_exit(int ioreg, bool noexit)
>   #define IT8623E_DEVID 0x8623
>   #define IT8628E_DEVID 0x8628
>   #define IT87952E_DEVID 0x8695
> +#define IT8625E_DEVID 0x8625

Maybe also keep things ordered here and add the #define after IT8623E_DEVID?

CJ

>   
>   /* Logical device 4 (Environmental Monitor) registers */
>   #define IT87_ACT_REG	0x30
> @@ -2782,6 +2784,7 @@ static int __init it87_find(int sioaddr, unsigned short *address,
>   	case IT8622E_DEVID:
>   		sio_data->type = it8622;
>   		break;
> +	case IT8625E_DEVID:
>   	case IT8628E_DEVID:
>   		sio_data->type = it8628;
>   		break;


