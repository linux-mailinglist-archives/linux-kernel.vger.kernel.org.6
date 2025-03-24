Return-Path: <linux-kernel+bounces-574177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A687A6E19F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE6F3B770F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAC5266B71;
	Mon, 24 Mar 2025 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YlS907EE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E9263C8A;
	Mon, 24 Mar 2025 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837982; cv=none; b=G0MhiFZN20ZSHJBfO6zrfJzdYEhJi0KV3PjL9l4pjxpi9iKwS4X+0/OBEzJub1WH5QmCTRQB0SSEfqJRMHYY4d1q1qVq1mc+m9bwFji+SrC0pIJXKa1hlsIgYWN3umK1mcFKzdUkz9t6jJEF4JhMzpelq13vE0wvznOfmtdDwA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837982; c=relaxed/simple;
	bh=TpBBvCJ5ZhLUY72PJ/tPDIoeVdpnOq59e3Sk63JXbz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxw6zboQFJeUwDc66JW0WxBOEmK7lWVezKwvxVdWI2fISnvD6HxiY10FaW0eT/tNr8wP2mzcY82kBGaYpDQxswg+ZnLRGQJEWzv+CakBGPoPLTjGZjIJrQIjPB7KmhBuZJNjslCc93UpzXVY592J79JorXHlanXYq6izWUoEfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YlS907EE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE38C4CEDD;
	Mon, 24 Mar 2025 17:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742837982;
	bh=TpBBvCJ5ZhLUY72PJ/tPDIoeVdpnOq59e3Sk63JXbz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YlS907EEgEzOO9RyiCaA1JjXWU9YxgwXxSFcoAckkje+zIdNuclrAT+2fx1M9FPyR
	 o2UtmQENlyQ1Z6S8HaEhSW0xYf0/RpqoeHokl5PQLHXQESQ47WX53yx2ounkjNq0Le
	 iVg3DaCLoURTWxzH5xy2BbqEri1VBi8MDiiF89o0=
Date: Mon, 24 Mar 2025 10:38:19 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: Code style cleanup
Message-ID: <2025032402-slideshow-storewide-2230@gregkh>
References: <20250324163358.134541-1-dominik.karol.piatkowski@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324163358.134541-1-dominik.karol.piatkowski@protonmail.com>

On Mon, Mar 24, 2025 at 04:34:50PM +0000, Dominik Karol Piątkowski wrote:
> Fix the following code style issues:
> - Space before comma
> - Missing blank line after declarations
> - Superfluous space before statement
> - Spaces used for indentation instead of tabs
> - Misaligned block comment
> - Space before tabs
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> ---
>  drivers/usb/serial/ftdi_sio.c     | 16 ++++++++++------
>  drivers/usb/serial/ftdi_sio.h     |  2 +-
>  drivers/usb/serial/ftdi_sio_ids.h |  4 ++--
>  3 files changed, 13 insertions(+), 9 deletions(-)

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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

