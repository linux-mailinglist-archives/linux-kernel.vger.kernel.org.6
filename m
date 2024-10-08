Return-Path: <linux-kernel+bounces-354694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EED99412A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275C31C249B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692D61DFDB5;
	Tue,  8 Oct 2024 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Htyk5Z6S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966191DFDAA
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373680; cv=none; b=LrWJpPBJRzSxqD8iO1kRY7gGh7i6b5jsAbY84Lh0WlJEKDHQOh4xBvR9cE6bL8p9GsgWuaXTmfyTHixihi5us5fdirxjVw0YUhufFosZgyWlGWZ8FdbSmS1HQPlBCK91xTsqmMMy0uxGwZtxZLZo0MIH9vQN5/zMlkv8r9OW+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373680; c=relaxed/simple;
	bh=oI/ExXzCsmA18wz2FVgUQW94yhN9PUIWsaB4gHo3Miw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGmpwwGoTo94QxyzkGCL25LDuUODUgtwiV8Oj6xgzhT0wpKDbxs3DQr3uB5IV9MHP/xIDgclIjH3F0j9Gmf41NJckFd/R9dcfxnVAce7oBpUmQpRu7ycwcTcM3bd6kRCkgMwwdKSmUrZCUJBv8kVS1kGD6GssNQ0P9pj65axwgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Htyk5Z6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3A9C4CEC7;
	Tue,  8 Oct 2024 07:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728373679;
	bh=oI/ExXzCsmA18wz2FVgUQW94yhN9PUIWsaB4gHo3Miw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Htyk5Z6SnDSk8k+GHZIu1k5h4uUmqmRHgrqED0oOdfFYG/JvAE8Y3cX587fuv3oQi
	 U4FiJwWaS8AcHVpNfbDynRVpSmrP+2GZhtbhSjD/BRdfqygi4uq560FSiB46zpg4MP
	 FQM9qm7d26JbzeH34/AYngi2HQJ185e7pDgbtgV4=
Date: Tue, 8 Oct 2024 09:47:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/applicom:Removed the unused variable
 byte_reset_it
Message-ID: <2024100808-antarctic-matching-9be0@gregkh>
References: <20241008072825.12937-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008072825.12937-1-zhujun2@cmss.chinamobile.com>

On Tue, Oct 08, 2024 at 12:28:25AM -0700, Zhu Jun wrote:
> Remove unused variable and redundant readb in ac_register_board
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  drivers/char/applicom.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
> index 9fed9706d9cd..ea25caf35346 100644
> --- a/drivers/char/applicom.c
> +++ b/drivers/char/applicom.c
> @@ -127,8 +127,6 @@ static int dummy;	/* dev_id for request_irq() */
>  static int ac_register_board(unsigned long physloc, void __iomem *loc, 
>  		      unsigned char boardno)
>  {
> -	volatile unsigned char byte_reset_it;
> -
>  	if((readb(loc + CONF_END_TEST)     != 0x00) ||
>  	   (readb(loc + CONF_END_TEST + 1) != 0x55) ||
>  	   (readb(loc + CONF_END_TEST + 2) != 0xAA) ||
> @@ -156,7 +154,6 @@ static int ac_register_board(unsigned long physloc, void __iomem *loc,
>  	apbs[boardno].RamIO = loc;
>  	init_waitqueue_head(&apbs[boardno].FlagSleepSend);
>  	spin_lock_init(&apbs[boardno].mutex);
> -	byte_reset_it = readb(loc + RAM_IT_TO_PC);

As Arnd said, this is doing something, please be more familiar with
hardware types (i.e. reads are required to ensure a write happens),
before removing lines that feel they are not needed, unless you can test
the driver change yourself.

thanks,

greg k-h

