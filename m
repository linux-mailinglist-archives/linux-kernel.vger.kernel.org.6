Return-Path: <linux-kernel+bounces-375889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C7B9A9C70
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751F91F230CC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA9116F85E;
	Tue, 22 Oct 2024 08:26:12 +0000 (UTC)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D88158D7B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585571; cv=none; b=lu3LDerl53suL/ToUMElGzjm7TXVtCFK/t3boLu5ZlA5u6p9n/45Hn3KD6V6z1GXtGexrgvTVjkGqXxKzR2wpA5UwOQU0BLxChulpOpWPvJh/zIPMBW0I3ahmWJMmYXibSMSvCLo0EHJ3tRSNAExctdwIzNbv61HsC5EvE4+GEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585571; c=relaxed/simple;
	bh=wFNU9gc6itmoel8kOvr/Q8E310AzuMPvxuprLzxxog4=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:In-Reply-To:Cc; b=bdNkrr2WTQYphcIn3CfzkNhsy3QOZqUO8zLjm+uk01xLPm6aDqeP8ynODdWHszK687xMaQ75S9/S/YDpzXRmeRnmSs8pPlyCBE3YJ87TyssFj3LddWyeK6n74qJx3DO+H1Yw4XDtMRGOwaWtn1HQPNwLv6Sh6TCbS1EKehKyvns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
	id 1t3A8R-0000UI-Px
	for linux-kernel@vger.kernel.org; Tue, 22 Oct 2024 10:20:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] hwmon: (it87) Add support for IT8625E
Date: Tue, 22 Oct 2024 10:20:52 +0200
Message-ID: <308caed5-5d58-4e6c-8bc8-82c34452bd72@wanadoo.fr>
References: <20241022081453.75253-1-aichao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-FR
In-Reply-To: <20241022081453.75253-1-aichao@kylinos.cn>
Cc: linux-hwmon@vger.kernel.org

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



