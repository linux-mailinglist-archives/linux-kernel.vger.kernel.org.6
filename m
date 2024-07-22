Return-Path: <linux-kernel+bounces-259199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D062F939285
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F771F232B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD7A16EB6A;
	Mon, 22 Jul 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nJESXwDS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93BC2907;
	Mon, 22 Jul 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665738; cv=none; b=YkRnkuix0JGeylQ4+anvP1JJQchJBYEh+d9oLw6Lz6ZHwUC+rYn2hDQHYZkdxGxFs5/bKWKhKYbaG8J/KiIAXcSSQ7XPz423CFLZYMJv0Qz4557TSgzuYy5JskP7Vx9HBsXw1mdt2UlwIu5tPMQ9UzsJRdQtq8o1C89FYn03Lws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665738; c=relaxed/simple;
	bh=aRxkrr1hchobGn5jkuGOn9aNROWqwxpHRv1LjvFX83k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUh4qHLxhX7Pd3llI6Ehi328e0txyp6gfqf6ik6xU9b2bHW3xYEbxzunO3wFXPyQKfyqU9cl3ivAyz0GEvJxsSNknn6LQ3JXXZEOVuNqpToU+UIXt7hUUvAdNsj/yNe0nW+3nqYvpiCl9idI9KufOhl9mYGepkAZt2deCKrpF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nJESXwDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C10CC4AF0B;
	Mon, 22 Jul 2024 16:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721665737;
	bh=aRxkrr1hchobGn5jkuGOn9aNROWqwxpHRv1LjvFX83k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJESXwDS2LYppANglIUusnzlYoU3UmGIvBPd0fv5f4Xqm4Dpj+gsuqPIsFeZCBzjl
	 3PgUQNsRV4edr+Fl0PakQcBiLcxIuybam8UxQ6f2BPpzIH48U7Xq0/TqMBN/97sYqy
	 cS0tB1WqZMZdqVhXXyloOr2Tdiz6DIayDEdZq/+Y=
Date: Mon, 22 Jul 2024 18:28:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Steven Davis <goldside000@outlook.com>
Cc: christian.gromm@microchip.com, parthiban.veerasooran@microchip.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Made the error messages a tad easier to read
Message-ID: <2024072227-persecute-sweat-4534@gregkh>
References: <SJ2P223MB1026A88F6556E5CCEAE52065F7A82@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2P223MB1026A88F6556E5CCEAE52065F7A82@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>

On Mon, Jul 22, 2024 at 12:23:37PM -0400, Steven Davis wrote:
> I realized I forgot to add a description in the previous version. Whoopsie!
> Anyway, this patch makes three error messages in the driver easier to read by capitalizing the first letters properly.
> For example, "channel already linked" became "Channel already linked".
> In addition, "expect" becomes "expected", as you would typically find in an error message.
> My hopes are that this patch makes the errors slightly clearer.
> 
> Signed-off-by: Steven Davis <goldside000@outlook.com>
> ---
>  drivers/staging/most/video/video.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

