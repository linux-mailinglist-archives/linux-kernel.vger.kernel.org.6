Return-Path: <linux-kernel+bounces-296839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E711695AFA5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47C0283084
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1191C16B750;
	Thu, 22 Aug 2024 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qyGwtGtM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580EE1607A5;
	Thu, 22 Aug 2024 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313057; cv=none; b=aXO/bAeuv8+Gw6HMgWu67vSiHA912YXZN23lcSg1UOcKmC7DX8/gzFfbPo9TYurxl1YQQJBnanpkgQyziKKTzoHAIsLLQS0i7/DhZlIOWGueDGdKCn2iRrrDQM8EzcB+H46QKcDJQ54lvIMO6B/KYkxfAMF5HOB1+5ceRDE3gSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313057; c=relaxed/simple;
	bh=KA6hQm0YgPj4GRFDVAXg8NfmueK02XGghRKHiTysFEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxJJDFXvwQYpWIKoGznTJ0NUm4KpypMyhDnW2IcfAYN4OwJacxWILYi3/T+1RRnEt2P4EjxaO17IdyM8GVXzP3x0uBUIH86e1qdjDX8NIex7otmY2pgVA1t+nlpAczH+1HBTzOn3z6KWc1mbdsWCv3I64GjVWKWTJThhVXd+yZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qyGwtGtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834DBC4AF09;
	Thu, 22 Aug 2024 07:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724313056;
	bh=KA6hQm0YgPj4GRFDVAXg8NfmueK02XGghRKHiTysFEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyGwtGtMLGphi07QG0mEl2LDrVYVn1oLoMhNIuyIWmqLelLa9DcnUajP683HCvXch
	 BAP0c190exFDy6mgFRJVjmJb3CrqLi+qOBSsKLqpky6PoI7K4zQmdmUzUmaUotf6Os
	 wnQBo/gAdHHnNSO6NJHFERaQIcRR9g1M/OGKZM4U=
Date: Thu, 22 Aug 2024 15:50:54 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Renan M. S. Florencio" <renanm.florencio@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: rtl8192e: Fix indentation in r8192E_dev.c
Message-ID: <2024082226-yin-tug-eca5@gregkh>
References: <20240822002526.19757-1-renanm.florencio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822002526.19757-1-renanm.florencio@gmail.com>

On Wed, Aug 21, 2024 at 09:25:26PM -0300, Renan M. S. Florencio wrote:
> Fix indentation in r8192E_dev.c to silence checkpatch warnings:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Renan M. S. Florencio <renanm.florencio@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index b3d4b3394284..ec867801bfbd 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -1741,7 +1741,7 @@ void rtl92e_update_ratr_table(struct net_device *dev)
>  	    ieee->ht_info->cur_short_gi_40mhz)
>  		ratr_value |= 0x80000000;
>  	else if (!ieee->ht_info->cur_tx_bw40mhz &&
> -		  ieee->ht_info->cur_short_gi_20mhz)
> +			ieee->ht_info->cur_short_gi_20mhz)

But the alignment does not now match, are you sure you ran your change
through checkpatch to verify it did what you thought it did?

thanks,

greg k-h

