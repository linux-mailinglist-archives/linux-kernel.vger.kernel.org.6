Return-Path: <linux-kernel+bounces-354791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB4A9942A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658881F200F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57131DF271;
	Tue,  8 Oct 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VomQgE23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F91F1DF721
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375739; cv=none; b=RRR67GIk0AmSqyec/S0N36gunsSJLwVh2Q9wVdce09YaqGWKG93Vr0l3+7u7UzkFxSXiOm32XzUpTdKIxjogIfVbgQMEJgBv/7tSOjV+QWwlpooE2TjkQyw6Fq5ihBrT9moez0RAjPWqaxWZUCNsDZkVxJtEN74GfpoYR3z/xIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375739; c=relaxed/simple;
	bh=krFwi8+SR0FJlSmyTOxjOZAAlb3g5ZBbrkyL3oqFPXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4tJy6gy/X9BD6HWUmcOsv5t4IuDnp1zLBFsI/2VuW6AF9k11zENE6/O1yNiYnnjU4Z+gz3YwCnyP6NM2E2rNsjM+zKMzGLjN9/oefOa1l2sP3bABHchj0eEFjBT6/6WivoYq7ZwpjjxhhJD/RNow4eRJc3HgKIHPE4mxWRGW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VomQgE23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2CEC4CEC7;
	Tue,  8 Oct 2024 08:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728375737;
	bh=krFwi8+SR0FJlSmyTOxjOZAAlb3g5ZBbrkyL3oqFPXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VomQgE23K1e3Cs8bB3hP7vzWfjWLiNru53jnpiVv13XaXNVGZJAZQd+X1upfaSWTX
	 cEOchPf7iUnZoMxWLl0JZnXXceSKrf14aLrWbsmARG+bZ9VUpANMthRlYJWX0lPMeq
	 VU6ddXvpagx6ULmLa+PmQ0wrhKWs+AJRH2j+s1os=
Date: Tue, 8 Oct 2024 10:22:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/applicom:Remove redundant ret variable in
 ac_read function
Message-ID: <2024100803-reshoot-reburial-a9eb@gregkh>
References: <20241008074818.13335-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008074818.13335-1-zhujun2@cmss.chinamobile.com>

On Tue, Oct 08, 2024 at 12:48:18AM -0700, Zhu Jun wrote:
> Removed the unused variable 'ret' from the ac_read function
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  drivers/char/applicom.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
> index ea25caf35346..ba512d8dffba 100644
> --- a/drivers/char/applicom.c
> +++ b/drivers/char/applicom.c
> @@ -536,7 +536,6 @@ static ssize_t ac_read (struct file *filp, char __user *buf, size_t count, loff_
>  	unsigned long flags;
>  	unsigned int i;
>  	unsigned char tmp;
> -	int ret = 0;
>  	DECLARE_WAITQUEUE(wait, current);
>  #ifdef DEBUG
>  	int loopcount=0;
> @@ -567,7 +566,7 @@ static ssize_t ac_read (struct file *filp, char __user *buf, size_t count, loff_
>  
>  				/* Got a packet for us */
>  				memset(&st_loc, 0, sizeof(st_loc));
> -				ret = do_ac_read(i, buf, &st_loc, &mailbox);
> +				do_ac_read(i, buf, &st_loc, &mailbox);

Why not check that this worked properly instead?  Can you test this
change?  Why make this change if you can not?

thanks,

greg k-h

