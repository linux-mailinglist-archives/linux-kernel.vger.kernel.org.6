Return-Path: <linux-kernel+bounces-511254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C4A32860
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30E63A743E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF7221018D;
	Wed, 12 Feb 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OQolyUlq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6736207667;
	Wed, 12 Feb 2025 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370474; cv=none; b=M51P38mrq3bR94CCcAwG5C7iRWy+eYl/lwDNtOji5D96tXF7zC2xtDwTjGWow9D506qjC5XemlEbKQEs7JdGcSoyoto6Gp5YJC843dR7SxXg9I/LHb++oWaPHfKciuBrE6EEI2u84HMpdzIFMEt3L6zlnmRMEIeLoPxbZKMGXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370474; c=relaxed/simple;
	bh=7Onv8wCoFp82DoYKMFeqXuc971OxNeF9sQrYOQ5F6d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c76r6y2qa8yp1i6g9ODFcM0I7sq7MAl48HBGlM0ibBM+czWj9c/+2yP7W5/TcoiWy8R41VjYrnVq077kyj546cHaVV0sc9AlI9ECmJAP5KzhDaz/qLYG6LJwzA78+0+Zg6oXqqYMLMjR8IXzS3ME0tIdj9UUT0M7r3i7+OkCHuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OQolyUlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D00C4CEDF;
	Wed, 12 Feb 2025 14:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739370474;
	bh=7Onv8wCoFp82DoYKMFeqXuc971OxNeF9sQrYOQ5F6d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQolyUlqhdEcuF3NefxpXApUDXd3HRyCLlnyI1Cj5pDMBl6d9gATlzXF8sc40ShH3
	 H9/1Mg0uLn6fo2NmW+Rjsgny/IIQII0lqmZZPs4sGBiZo4hX05Zf9MBPD4D/gbxQ7c
	 qzb6UdhK2ITEYw8oiqpZspToqWF+GKrC6fMQGj6I=
Date: Wed, 12 Feb 2025 15:26:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: mathias.nyman@intel.com, WeitaoWang-oc@zhaoxin.com,
	Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	h10.kim@samsung.com, eomji.oh@samsung.com, alim.akhtar@samsung.com,
	thiagu.r@samsung.com, muhammed.ali@samsung.com,
	pritam.sutar@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH 0/2] Fix unassigned variables in xhci driver
Message-ID: <2025021234-reaction-womankind-1c0b@gregkh>
References: <CGME20250211115704epcas5p4140a490572fb9c4ac71a82abcb61f291@epcas5p4.samsung.com>
 <1296674576.21739322602698.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1296674576.21739322602698.JavaMail.epsvc@epcpadp1new>

On Tue, Feb 11, 2025 at 05:26:28PM +0530, Selvarasu Ganesan wrote:
> This series of patches to fix the following smatch errors from
> xhci driver:
> 
> drivers/usb/host/xhci-mem.c:2060 xhci_add_in_port() error: unassigned variable 'tmp_minor_revision'
> drivers/usb/host/xhci-hub.c:71 xhci_create_usb3x_bos_desc() error: unassigned variable 'bcdUSB'
> 
> ---
> Selvarasu Ganesan (2):
>   usb: xhci: Fix unassigned variable 'tmp_minor_revision' in
>     xhci_add_in_port()
>   usb: xhci: Fix unassigned variable 'bcdUSB' in
>     xhci_create_usb3x_bos_desc()
> 
>  drivers/usb/host/xhci-hub.c | 2 +-
>  drivers/usb/host/xhci-mem.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.17.1
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

