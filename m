Return-Path: <linux-kernel+bounces-517023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEC1A37B10
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8A916AD1A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B89188587;
	Mon, 17 Feb 2025 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zjJHOKPe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E2A433A8;
	Mon, 17 Feb 2025 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739771441; cv=none; b=RwELQzcYzZYfnke5Bed+2BrmxaDRe3dzc3yNOKmdNit3AVyX711DM3U2NlIF9ISXewGBOT1kkFg6EOH7MC4xysrC1Zbi8/+9KuGFIKaxgnnrUmqy/7DHB0V2MP5OWvIOuiZ6ENBovwxRQNY3JFjjCzU0Uu5zqVKIuvp8ZMGCv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739771441; c=relaxed/simple;
	bh=0x0eX9X8wpF9d4eRlPfa++OBOHu2PnscMeF/oTLS/KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHXs8eIffiqQNQnHeDi3U0kqyzWat+atLhWLiTYOzzWjawqg+9C8okPfOSncmabPhLVFTY08ng+mxOadR0nHkeMTqzIqKPe2g7RjBf1ASW2mg1ZduLXNLkCY78lwixzSxtgrPO4HPCY30wjG8sQtfdSmPdK9xsCMgle98cVqkOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zjJHOKPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD144C4CED1;
	Mon, 17 Feb 2025 05:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739771440;
	bh=0x0eX9X8wpF9d4eRlPfa++OBOHu2PnscMeF/oTLS/KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zjJHOKPeTKAwIun98S1xjKWHkJmT3OxkfovfkPkgLeQjk8eRBvuN4z6jAUBoX9ei8
	 1/5WbvIa1ll+8bAOxxl/OTMz8ltRlmj3WplKmThjyo9V6uvNfn7NITMnXyU4UCtAUu
	 rpEt7NDUK7nNGFSazGmngMwXWiAMQme7huJp4Kdg=
Date: Mon, 17 Feb 2025 06:49:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, krzysztof.kozlowski@linaro.org, broonie@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:gpib:agilent_82350b: Fixed spelling errors
 removed commented code
Message-ID: <2025021712-clad-bootie-9a0f@gregkh>
References: <Z7JqjL_qGn8zEQXF@pronto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7JqjL_qGn8zEQXF@pronto>

On Mon, Feb 17, 2025 at 04:15:32AM +0530, Ravi Kumar Kairi wrote:
> Fixed spelling error from "havn't" to "haven't" and removed commented
> code which created empty lines removed them as well, removed few
> whitespaces and other empty lines. Removed braces from a single line.
> 
> Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> ---
>  .../gpib/agilent_82350b/agilent_82350b.c      | 29 ++++---------------
>  1 file changed, 6 insertions(+), 23 deletions(-)

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

