Return-Path: <linux-kernel+bounces-354394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D0993CF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0E91F25E47
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2F4125A9;
	Tue,  8 Oct 2024 02:37:31 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE7F9EC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728355051; cv=none; b=WrxeHqd2MXibrHpa70/2hk4UMgsjrINJKdCs3cxxE+C4y+E7gjFkY1QYlZt3ObZjJE3voiZCJDJ7g4lk2JTL/2xqwF4QucFvyuHSmj6PgwJ+2QXh/Gf4L0WUtCa43uQWWCuMcfP6nvymy/Y+T0u0Q+lWlJXTYKErM6dqdusmPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728355051; c=relaxed/simple;
	bh=rlSX251k/H4FTCdqtOQU+ZbgSjEQytPivCAuN6W22Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SdhXD4eIelIwfKVlhAPsQLPZiJPNYcQ54CQ5TaVLg+myWScKOM4Z/jur5RZ5WbEBcQr9+c0j6/xRU1xJ7zgpFkVJc6C8CSECVVuUfkibKNq8MyCy90rbnw3unxvJr1hxREhAW1wVeQwA1OWxH0mbZjyuHAsTrWr8dOKi4T50eHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XN0Y51C5Tz1ymps;
	Tue,  8 Oct 2024 10:37:29 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id F23981A0188;
	Tue,  8 Oct 2024 10:37:24 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Oct 2024 10:37:24 +0800
Message-ID: <0bcace87-6678-f84b-dd46-c88b33f67b73@huawei.com>
Date: Tue, 8 Oct 2024 10:37:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] misc: apds990x: Fix missing pm_runtime_disable()
Content-Language: en-US
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <samu.p.onkalo@nokia.com>,
	<jic23@cam.ac.uk>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
References: <20240923035556.3009105-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240923035556.3009105-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Ping.

On 2024/9/23 11:55, Jinjie Ruan wrote:
> The pm_runtime_disable() is missing in probe error path,
> so add it to fix it.
> 
> Fixes: 92b1f84d46b2 ("drivers/misc: driver for APDS990X ALS and proximity sensors")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/misc/apds990x.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
> index 6d4edd69db12..e7d73c972f65 100644
> --- a/drivers/misc/apds990x.c
> +++ b/drivers/misc/apds990x.c
> @@ -1147,7 +1147,7 @@ static int apds990x_probe(struct i2c_client *client)
>  		err = chip->pdata->setup_resources();
>  		if (err) {
>  			err = -EINVAL;
> -			goto fail3;
> +			goto fail4;
>  		}
>  	}
>  
> @@ -1155,7 +1155,7 @@ static int apds990x_probe(struct i2c_client *client)
>  				apds990x_attribute_group);
>  	if (err < 0) {
>  		dev_err(&chip->client->dev, "Sysfs registration failed\n");
> -		goto fail4;
> +		goto fail5;
>  	}
>  
>  	err = request_threaded_irq(client->irq, NULL,
> @@ -1166,15 +1166,17 @@ static int apds990x_probe(struct i2c_client *client)
>  	if (err) {
>  		dev_err(&client->dev, "could not get IRQ %d\n",
>  			client->irq);
> -		goto fail5;
> +		goto fail6;
>  	}
>  	return err;
> -fail5:
> +fail6:
>  	sysfs_remove_group(&chip->client->dev.kobj,
>  			&apds990x_attribute_group[0]);
> -fail4:
> +fail5:
>  	if (chip->pdata && chip->pdata->release_resources)
>  		chip->pdata->release_resources();
> +fail4:
> +	pm_runtime_disable(&client->dev);
>  fail3:
>  	regulator_bulk_disable(ARRAY_SIZE(chip->regs), chip->regs);
>  fail2:

