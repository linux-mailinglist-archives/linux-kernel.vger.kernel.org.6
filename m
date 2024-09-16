Return-Path: <linux-kernel+bounces-330142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E38979A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A0E1F21F69
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABE7208CA;
	Mon, 16 Sep 2024 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DLMrBsdc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38ED512;
	Mon, 16 Sep 2024 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726459857; cv=none; b=CizppyroD4XdvODQ63ZhDitTaLPP1RYIwLpNjTSYFQM9CEdTJcHdaKSJl0qtKzOpNxlXfRvKjStzMFlmPfmSqbCg9tAdZCFS8EWLLHpHTDAUEIkkpPuP+Tx7Yc1Nn3jIy3I/bJtTfJe1EHWow3J6jNDiU/HmMYDzhl1tXxuIgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726459857; c=relaxed/simple;
	bh=skaSjrQte9QkLMaHVEB+X8SEX7fHer1lJcQUP/59WIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSrcYdj2qn9KT/405h84EgjGQQOQSBQTQ96np08Se3RII0RfgI4DyiJ/1K8ka1bc3MWa/beCb8MjSWc6xQyaLHBEYqWBw8gp4oDn5MOqAbBarQmCAieCBKQFOCa/HIzc9caf3yLYPI0xX54ov77D9F4aWEkCMhrSAT2K4Toqfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DLMrBsdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7710EC4CEC4;
	Mon, 16 Sep 2024 04:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726459856;
	bh=skaSjrQte9QkLMaHVEB+X8SEX7fHer1lJcQUP/59WIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLMrBsdcsp4bKsPbK6JO8b089wiQR7rmlmSwPx+C+/eKR8l0JKQOFjvRbkOdl2dii
	 tNiP0q7yOqhzHpCX7aEuZtu2xqRJY4W7URVXIxgUmV7FXbL5QVdmFyoo8L7Ow3CveP
	 y5aIpYXwa7iJ5dFNGoYRxFBqmOxao/epUaw/p23A=
Date: Mon, 16 Sep 2024 06:10:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: u.kleine-koenig@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix spelling errors and codestyle in file
 drivers/usb/gadget/udc/m66592-udc.c
Message-ID: <2024091626-trailside-grandkid-5f86@gregkh>
References: <20240916014509.5871-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916014509.5871-1-everestkc@everestkc.com.np>

On Sun, Sep 15, 2024 at 07:45:07PM -0600, Everest K.C. wrote:
> Fixed spelling errors in error message and comments that
> were reported by codespell as follows:
> 	unexpect  --> unexpected
> 	workaound --> workaround
> Also, fixed codestyle error and  replaced a hardcoded function
> name in a pr_err statement with __func__.
> 
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
>  drivers/usb/gadget/udc/m66592-udc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
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

