Return-Path: <linux-kernel+bounces-269079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AFE942D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4919A286A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109341A71ED;
	Wed, 31 Jul 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mij+bQiF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE531A8C0C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425583; cv=none; b=J6/rTcvunmWc9dmKR6AHi5hMfSDonxz0XqY8jAtSnq4FancBIqWOLHHAq3GIi0B6BTn11vqxvtf71qDgB0YgeyW06NFjBcnRBSP2DHicE1ONCOUSVtSSPswjf6NNNdIQx2UkGgASaf0f5O3wgy78qS9imEMYaNYkvYI1KiTYBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425583; c=relaxed/simple;
	bh=8tsbYRihr8KVNvs5vMPfBU/ojKlZM+tdX5vMDX7JEGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f805VCJe/hikqCQ9zqPa7RF0SX3KsRjZCckzYJSCQMCZE+tfz/dmgFnMoZl01BgA1gFSgpzorcVu6/8WtQL3LIeCKFVli7ij+MhLKGSblYBH+UCxLjgusvCvGZTr/wk5Y2aQkK43RP2jPcw4iTtUnC80hkbK7+az5eheIPX70Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mij+bQiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7519CC116B1;
	Wed, 31 Jul 2024 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722425582;
	bh=8tsbYRihr8KVNvs5vMPfBU/ojKlZM+tdX5vMDX7JEGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mij+bQiF1pV2j+/L34/hOkVErPs5ZtdEnDPzS/pG7UrGvE6SfrOxdoYOQVLN+fNo9
	 4PSnZfi+IuY5IL01uAloXZ7lqRhtAHZ6uzxh+lBeI1Bs3skgZvWJga+29twtaiNqhR
	 Gqf31gGaTTvZ83dlgcqc5QuO4eQJebfK6nO00AQU=
Date: Wed, 31 Jul 2024 13:32:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alyssa Ross <hi@alyssa.is>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VMCI: fix reference to ioctl-number.rst
Message-ID: <2024073140-squabble-confront-3a58@gregkh>
References: <20240731111302.3072858-2-hi@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731111302.3072858-2-hi@alyssa.is>

On Wed, Jul 31, 2024 at 01:13:03PM +0200, Alyssa Ross wrote:
> Fixes: 20259849bb1a ("VMCI: Some header and config files.")
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

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

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

