Return-Path: <linux-kernel+bounces-517409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1DAA38067
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FD43AF613
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CC423CE;
	Mon, 17 Feb 2025 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rTfblvDO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB12135AF;
	Mon, 17 Feb 2025 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788662; cv=none; b=UCj9bK5hH2eigD8pFz4c8jL946cM8v2Ch5pXewp9WsRupG0XigkH4PcVP56rnRc2xB7GosTPh0sN+m2Jox0QLb9M0Q2zU5ay8UI8lgLxrCwCWZ7jD05IAZEdEUmLV6+Dtwch8Lelh0rkN060p+yFyQWgfs5MrV+aVdvx6/Ui4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788662; c=relaxed/simple;
	bh=iBLZunpQkV0eZdxdtQfqi1BGUSJgxcqK7ZA6bk5kouU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKhHjlp1IZcZ9NNy1hXeeWnu/zs6+xlZS3ZhfxzXQjxPp18yk9km48g08I8FWRfMw2xAX9NRQa3CkWx5AeVmR5h/5GonFUhQoS5OzUsUH4UyKIKp70LBPUiNON9F3TiwLwnrMce1pfU2+NLRxznQocaqfasiJzFPdj4pRgJose8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rTfblvDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CE6C4CED1;
	Mon, 17 Feb 2025 10:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739788662;
	bh=iBLZunpQkV0eZdxdtQfqi1BGUSJgxcqK7ZA6bk5kouU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rTfblvDOzgaTeG81ekV4S99YU+TvTo2R+fz49RpuptwKBb3cvBUZg1hVfq0oAdFkn
	 44sDsfwBZuJpO9omKEB5Fun91iemr6L6c8XjZMby6ThdYOUrv+57fpKlcsPQuSsljK
	 CclLKBmgOJBExu9FwJRysBxF5bx0CG1GkENthEcY=
Date: Mon, 17 Feb 2025 11:37:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kuba@kernel.org,
	dan.carpenter@linaro.org, rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH v3 0/4] staging:gpib:agilent_82350b: Code cleanup,
 spelling fixes
Message-ID: <2025021728-overboard-eloquence-f0fa@gregkh>
References: <20250217103046.54294-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217103046.54294-1-kumarkairiravi@gmail.com>

On Mon, Feb 17, 2025 at 04:00:34PM +0530, Ravi Kumar kairi wrote:
> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> 
> This patch series addresses the following changes:
> 1. Fixing spelling mistakes such as "havn't" → "haven't"
> 2. Removing unnecessary commented-out code
> 3. Cleaning up whitespace and formatting inconsistencies
> 4. Removing an empty line in if{} which was causing it to be read as a single line
> 
> These are minor changes aimed at improving code readability and maintainability.
> 
> I appreciate your time in reviewing this series. and I'm deeply sorry
> for the spam beacuse I messed up last time I sumbiited
> Thanks,
> Ravi Kumar Kairi (4):
>   staging:gpib:agilent_82350b: Fixed spelling error
>   staging:gpib:agilent_82350b: Removed commented out code
>   staging:gpib:agilent_82350b:Removed blank line
>   staging:gpib:agilent_82350b: Fix Indent issue with block
> 
>  .../staging/gpib/agilent_82350b/agilent_82350b.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> -- 
> 2.48.1
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

