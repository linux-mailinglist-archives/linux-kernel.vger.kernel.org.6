Return-Path: <linux-kernel+bounces-368287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 708329A0DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B9EDB25D58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3E20E019;
	Wed, 16 Oct 2024 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RGcTtxZQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B254F95;
	Wed, 16 Oct 2024 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091463; cv=none; b=HEl3QWw31iM6+A88XUO7y+mGkxvQ3VbxBbFo4NhpitGGtDxdOisoxJSAm3FFQ8iNzRLNyHyjovMzFLGTiKveplbKEiAGLYcH49BSrr4uESHepE0/w2X4TEnEY9uH2TARJHaOggs6uB+k9eD9ygAZaf+d8ClTS+FO+r3edNLPlXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091463; c=relaxed/simple;
	bh=v04/kYKtJQtrsjHsyGjBFxXxzpNdJt5YRVCbs60TOTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFlx86hgih5X0Y2WLgrNEsH+rXXjw4acHmxM5DjF7yLnkldiqXoSUGrmEKqHTu8uHGK3cjR90YN6t8VN75nwS2pc+NzZMWvHNb86WZRl6kb+3YCMF1eso5XUBWr34aD4BA7bZ7pVlh6md2RIvZZ87ZmiztHVy6wcQH8elXTfxd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RGcTtxZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE5BC4CEC5;
	Wed, 16 Oct 2024 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729091462;
	bh=v04/kYKtJQtrsjHsyGjBFxXxzpNdJt5YRVCbs60TOTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGcTtxZQ11J8tP78zZSR3N3v84XKOKYipcMIxMKKr3PuaAQ3OZ7WDb2amQcJmOGR9
	 xTEL6lolQpkhWP1eK+wmZEH/NnxZq3S5FuKvzII5LeyEwFM79nZAHwXFz5qHsRjtAW
	 aauU37htlsp8RyzqNP9ZSR4LW3M+UzMuGi2fkPfo=
Date: Wed, 16 Oct 2024 17:10:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: dpenkler@gmail.com, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: gpib: Add TODO file
Message-ID: <2024101632-overreach-paradox-d31b@gregkh>
References: <20241015192838.16740-1-dominik.karol.piatkowski@protonmail.com>
 <2024101609-getaway-appendage-1f88@gregkh>
 <B28HXaYBd4-AP7g9jMpXgQEcJIzAQUsaUqMerdy_Hk0tR2Q9RKTAmcYbtq3LR06X3yHj0R6D4bLJHEHCYsszgjvnfhgZ7K5QwOzx5JLNI_A=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B28HXaYBd4-AP7g9jMpXgQEcJIzAQUsaUqMerdy_Hk0tR2Q9RKTAmcYbtq3LR06X3yHj0R6D4bLJHEHCYsszgjvnfhgZ7K5QwOzx5JLNI_A=@protonmail.com>

On Wed, Oct 16, 2024 at 01:34:07PM +0000, Dominik Karol Piątkowski wrote:
> On Wednesday, October 16th, 2024 at 07:33, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > 
> > 
> > On Tue, Oct 15, 2024 at 07:28:57PM +0000, Dominik Karol Piątkowski wrote:
> > 
> > > Add a TODO file stub for the gpib driver.
> > > 
> > > Signed-off-by: Dominik Karol Piątkowski dominik.karol.piatkowski@protonmail.com
> > > ---
> > > v2: Remove maintainers from TODO, as they can be found in MAINTAINERS file
> > > drivers/staging/gpib/TODO | 2 ++
> > > 1 file changed, 2 insertions(+)
> > > create mode 100644 drivers/staging/gpib/TODO
> > > 
> > > diff --git a/drivers/staging/gpib/TODO b/drivers/staging/gpib/TODO
> > > new file mode 100644
> > > index 000000000000..850dc1102e54
> > > --- /dev/null
> > > +++ b/drivers/staging/gpib/TODO
> > > @@ -0,0 +1,2 @@
> > > +TODO:
> > > +- checkpatch.pl fixes
> > > --
> > > 2.34.1
> > 
> > 
> > Hi,
> > 
> > This is the friendly patch-bot of Greg Kroah-Hartman. You have sent him
> > a patch that has triggered this response. He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created. Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> > 
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> > 
> > - This looks like a new version of a previously submitted patch, but you
> > did not list below the --- line any changes from the previous version.
> > Please read the section entitled "The canonical patch format" in the
> > kernel file, Documentation/process/submitting-patches.rst for what
> > needs to be done here to properly describe this.
> > 
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> > 
> > thanks,
> > 
> > greg k-h's patch email bot
> 
> Hi Greg,
> 
> I listed the changes below the --- line. Probably I should have added extra
> newline, or maybe even another --- line below the changes in order to not
> trigger the patch-bot message and make it more readable.

Ah, yes, that's why it missed it, sorry.

> Maybe I should also
> explicitly use "V1 -> V2" instead of "v2" when listing changes? I am trying
> to understand the filtering rules that are in use, in order to avoid this
> situation in the future.

Either is fine, but it was the blank line that caused this to be
triggered.

> I see that in Documentation/process/submitting-patches.rst there is an extra
> newline after listed changes, would it be enough?

Yes.

But before you resend this, you should come up with some more things
other than checkpatch for the TODO file, as that's just the base-minimum
here.  THere are other things that need to be done to get this out of
staging, take some time to look at the code to get an idea of what needs
to be done.

thanks,

greg k-h

