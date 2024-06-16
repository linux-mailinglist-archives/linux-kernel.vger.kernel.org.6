Return-Path: <linux-kernel+bounces-216292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709E9909D96
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 15:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD8B281B20
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 13:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F147187320;
	Sun, 16 Jun 2024 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="F3/giR0m"
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806698F54
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718543243; cv=none; b=bzvEvzi7ilKsmcfJEf810UV7TK9RXUwpuZPcNJmxnYnmkyxFx6HHdaF5Fsf6+EcOW47+buiruTT2iaHUv5KRdGqsJv8wJOVLYMv5fV/nrNi1eTCFHFLb4u4G+H/tS/e+9dQjN2UANzYoOgxA0eRKam5xmva9crUmlGA6cZ+tW0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718543243; c=relaxed/simple;
	bh=RtK8lkG+CzAVuQbNuO78/UjV/0iLZU1KXkKgIkdC+Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xmm5/IHTeYn54bMYbojRkO2PSM4QCWorLbVEkaoBp64tFyg8lesvkrYQ6Y5OgQZHvCdVqj0sKFVfRHq59/W+wNNLUnLk0Oa1vI3GDExZwPdorotg4F5jKH3s2Tv2y++lPRPe2x+Eynfsa7SzqHJCBJg1AcTfy7lflC6d+cixDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=F3/giR0m; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id IpZzsNtLZ8F9jIpa0sICVA; Sun, 16 Jun 2024 15:06:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1718543161;
	bh=36x6lrBsmJp4BzTd1t9QLDw3txpJVclhha0kOPEOjXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=F3/giR0mGq2GiVT85xhn9y67C6GhOvUa93yWRGlG80DKz6+U2R31EET9pK8eevjH2
	 /4JDlrB0XyqBMVfixquBQgLKlIMx5o15m5JkWF2y9Ko/y6elhByiEhuv8cT2BnjzMa
	 53oLXXUx7aAomJo3G/2gI8pyghcZWF9fnzJD/RJU4b2n3MeBPO2dgRZumsvzVsQhf3
	 hcPUubeV6I0rhs/dO/VepExhGIw3AZRQn1reXiegUGNz2kDM9xdcrOW0rRZWmGt9ch
	 sW/hpBJ624qB0+Lz/yuA0httSUX3A5IecK4KHs+eMBQCVDCPkSWXYAzRXY/GP2FOIL
	 3nlDJ7yS8WwGg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Jun 2024 15:06:01 +0200
X-ME-IP: 86.243.222.230
Message-ID: <1a6fda13-3a06-420d-a62a-896a7f4866d9@wanadoo.fr>
Date: Sun, 16 Jun 2024 15:05:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI /amba: Fix meaningless code for
 amba_register_dummy_clk()
To: Youwan Wang <youwan@nfschina.com>, lpieralisi@kernel.org
Cc: guohanjun@huawei.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
References: <20240616100054.241482-1-youwan@nfschina.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240616100054.241482-1-youwan@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/06/2024 à 12:00, Youwan Wang a écrit :
> Defining `amba_dummy_clk` as static is meaningless.
> 
> The conditional check `if (amba_dummy_clk)` is intended to
> determine whether the clock has already been registered.
> However,in this function, the variable `amba_dummy_clk`
> will always be NULL.

Hi,

  can you elaborate on this "will always be NULL"?

I think that it is NULL on the first call of amba_register_dummy_clk(), 
but if it is called again, it will have the value of 
clk_register_fixed_rate() just a few lines after, doing exactly what the 
comment says.

CJ

> 
> Signed-off-by: Youwan Wang <youwan@nfschina.com>
> ---
>   drivers/acpi/arm64/amba.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
> index 60be8ee1dbdc..ef438417cc80 100644
> --- a/drivers/acpi/arm64/amba.c
> +++ b/drivers/acpi/arm64/amba.c
> @@ -35,11 +35,7 @@ static const struct acpi_device_id amba_id_list[] = {
>   
>   static void amba_register_dummy_clk(void)
>   {
> -	static struct clk *amba_dummy_clk;
> -
> -	/* If clock already registered */
> -	if (amba_dummy_clk)
> -		return;
> +	struct clk *amba_dummy_clk;
>   
>   	amba_dummy_clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, 0, 0);
>   	clk_register_clkdev(amba_dummy_clk, "apb_pclk", NULL);


