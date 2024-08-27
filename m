Return-Path: <linux-kernel+bounces-303267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CBA9609F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04DB1B22C27
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8A01A0AE6;
	Tue, 27 Aug 2024 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HMOVsftv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826C1A073A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761236; cv=none; b=u2sTrsCmwuVelnOg69hCakd9GwvFkjBatY9WjOsVtAik5arJA1Qe7W7RRjzl08f0D5GOQ+0oYlImH7W7b0VhdRCXBqpr0AY7FOQEX0rH8ycklRFCSnpc/ltpWJXStJQVbjpjh2Py82vNA4zi+3RzSDqkGVNBoT4BCzs+qFi1iu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761236; c=relaxed/simple;
	bh=KO5csV46Nt28bnHBSkrHMfRzRDtcg0hu9PvkUVkd2zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeumihbtuL8FNIJR7pfBTo0JB33vqV4w4m/Ab9Gg/L2YFdCHmed80m1qqKUurqXbtWHxgzk15CuxUSRHpDd+jGHPncz/52gSKCB+Q3iBzWft7kJXXv/qxGM4LISEZ+zS2o+Ag1+sG/VRCf5fJtX88Xki2KMyVV6lrIK6Lftx42I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HMOVsftv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278F2C61041;
	Tue, 27 Aug 2024 12:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724761235;
	bh=KO5csV46Nt28bnHBSkrHMfRzRDtcg0hu9PvkUVkd2zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMOVsftv1cZKjSU7DnA1wJ8o1ZOeXPD4kqI6QRcv/FsHTs2eed3UbsNIIlt3S5cTN
	 EtaVhSLdcuF6uBzTJT2PWCBaU0zJ/8Kd1xI7ICPLsDPXlkZRyG6qaX3o8L/4AFZDHN
	 r4YFnFqEtaDn8Dsd9wkc8NDiGSns2Oy0UW3gfXqA=
Date: Tue, 27 Aug 2024 14:20:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: kees@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
	tianxianting.txt@alibaba-inc.com
Subject: Re: [PATCH v2] lkdtm: mark lkdtm_kprobe_handler for kprobe
 unavailable
Message-ID: <2024082709-tacky-playmaker-0ceb@gregkh>
References: <20240827120736.32434-1-xianting.tian@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827120736.32434-1-xianting.tian@linux.alibaba.com>

On Tue, Aug 27, 2024 at 08:07:36PM +0800, Xianting Tian wrote:
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  drivers/misc/lkdtm/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index 5732fd59a227..b32b18f498ea 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -223,6 +223,7 @@ static int lkdtm_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
>  
>  	return 0;
>  }
> +NOKPROBE_SYMBOL(lkdtm_kprobe_handler);
>  
>  static ssize_t lkdtm_debugfs_entry(struct file *f,
>  				   const char __user *user_buf,
> -- 
> 2.43.5
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch contains warnings and/or errors noticed by the
  scripts/checkpatch.pl tool.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

