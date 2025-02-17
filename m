Return-Path: <linux-kernel+bounces-517410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E274A3805D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC551168CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BF115C0;
	Mon, 17 Feb 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w4WyOWBo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DDE18DB1C;
	Mon, 17 Feb 2025 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788702; cv=none; b=nMGhK5nrieFCZ+HkrCbbAkXBrAlhOz/QpP4WZ9kNNZ0+8SjZv7W2YGweDBtCf4zbZy0NM2YiOA/L7Dxj5mDwufcT/wif03czr55UNLN5aZDCHQiT5Ma9EkK3Sky1Rb8U+B66CM3BMwd/dFC7BE1UPI3pZVhhQYcxbm1bTntnQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788702; c=relaxed/simple;
	bh=P+H05808aiNqFsj5MnruhlOm4+JjX49IFRHjRCltGHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei4ZImkcEd3cvuBsuARNHnp9kI5PEZxknFdoQaA1S2dfgWWHR2VK5CfOGIuLBkascAYjqLsIZOs4RFt5p3U/tl8fcUePprcSNdy1Zl5r5ab/ExD29odL2SMw8sBzFtzYvlt8PjBf1Hh8Y39ZdBbIvIYwVsePx5TMQ4WrNgHP7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w4WyOWBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF4FC4CED1;
	Mon, 17 Feb 2025 10:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739788702;
	bh=P+H05808aiNqFsj5MnruhlOm4+JjX49IFRHjRCltGHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w4WyOWBogh31p7NN+1tV42XyGQsVLQrQwT+0NIQR8Cab7gFmM0q/p0ByvhZueX1Vm
	 Fsjv97RMMWIzoaEGN8L0A1gVi93AZ7WvJMm5HUBriMhfHHU6N9XRDXalFuW3vnRD4f
	 s/MEo9FobbUTitZ711zEY3XOGliAejS2mNtD1xnA=
Date: Mon, 17 Feb 2025 11:38:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kuba@kernel.org,
	dan.carpenter@linaro.org, rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH v3 3/4] [PATCH V2 3/4]
 staging:gpib:agilent_82350b:Removed blank line
Message-ID: <2025021751-keg-cackle-44b6@gregkh>
References: <20250217103046.54294-1-kumarkairiravi@gmail.com>
 <20250217103046.54294-4-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217103046.54294-4-kumarkairiravi@gmail.com>

On Mon, Feb 17, 2025 at 04:00:37PM +0530, Ravi Kumar kairi wrote:
> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> 
> removed few empty lines that were causing checkpatch script warnings
> 
> Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> ---
>  drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> index 7936c7285d..b6871eb3c8 100644
> --- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> +++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> @@ -176,7 +176,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  
>  	event_status = read_and_clear_event_status(board);
>  
> -
>  #ifdef EXPERIMENTAL
>  	pr_info("ag_ac_wr: wait for previous BO to complete if any\n");
>  	retval = wait_event_interruptible(board->wait,
> @@ -193,8 +192,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  	*bytes_written += num_bytes;
>  	if (retval < 0)
>  		return retval;
> -
> -

Why did you remove both lines here?  One is fine.

And your subject line needs an extra ' ' in it, right?

thanks,

greg k-h

