Return-Path: <linux-kernel+bounces-266870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF9E9408E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7718B240D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D28B16B3A3;
	Tue, 30 Jul 2024 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fs6jAsJs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34914A095;
	Tue, 30 Jul 2024 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322414; cv=none; b=ihhtWagP+KMNjYYVQFPtapsLamSwzLiV5K63ZNX7dzb7bOLV8p084j9SyBJuT1woMuajAxsTzmTwkt1jSAUSXSI2xUWORHr8rEQsltk2dHlQG2luN5EczvdTPoJ68qQFM9u2HW9jvANlU7+rU9oHjqrxGGBMhU0Ni2AHy9XbUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322414; c=relaxed/simple;
	bh=OMSeiT5CWRwogJLVFcMQhXyFBPaGZpMCxgSrN3QGXzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKWSWHLkged4cI2VK4cytBgptzM4Q3/s0ai93ZU/NUs4X/oVTsDFByC9qKkAwdbnL5VunA8ajuvD6gdCP+UFC+ETzXpcIIcxFt5OkD5tl4u4IawyB3Wh8ZCaLhZ/M84rc5z4JqeBvjxCqYuDX0zIAARBqmnECpvT0GWmBE1GTxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fs6jAsJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7ED5C32782;
	Tue, 30 Jul 2024 06:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722322414;
	bh=OMSeiT5CWRwogJLVFcMQhXyFBPaGZpMCxgSrN3QGXzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fs6jAsJstEgqF0/NtSG/HuOeNhN9gvHMdj27mjCiO3JPXL6IUwzT5HLfvt3CkJHZ7
	 /pr6mXlE0B3wLXzX3uE2Q/wq58vfWWRJOtn5LKsNQKHYc8cWZi5J16vCfVJ1EMAJqr
	 8ZGm55AAw0j5ASlW57zyBvNtT8KbJZwP6HToOR88=
Date: Tue, 30 Jul 2024 08:53:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com
Subject: Re: [PATCH v2] staging: rtl8723bs: style fix open brace on new line
Message-ID: <2024073021-unluckily-failing-1f60@gregkh>
References: <20240730064828.35207-1-sskartheekadivi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730064828.35207-1-sskartheekadivi@gmail.com>

On Tue, Jul 30, 2024 at 06:48:28AM +0000, Sai Sree Kartheek Adivi wrote:
> It fixes the following checkpatch.pl error
> "ERROR: that open brace { should be on the previous line" and avoids the
> warning "WARNING: braces {} are not necessary for single statement blocks".
> 
> Signed-off-by: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
> ---
> This is my first contribution. Hope I did everything right!
> 
>  drivers/staging/rtl8723bs/include/osdep_service.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
> index cf96b5f7a..5629123cd 100644
> --- a/drivers/staging/rtl8723bs/include/osdep_service.h
> +++ b/drivers/staging/rtl8723bs/include/osdep_service.h
> @@ -81,9 +81,7 @@ static inline void thread_enter(char *name)
>  static inline void flush_signals_thread(void)
>  {
>  	if (signal_pending(current))
> -	{
>  		flush_signals(current);
> -	}
>  }
>  
>  #define rtw_warn_on(condition) WARN_ON(condition)
> -- 
> 2.20.1
> 
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

