Return-Path: <linux-kernel+bounces-446368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095759F2383
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF5D165162
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D1016F0E8;
	Sun, 15 Dec 2024 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gsz44Nu2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DCB149E13;
	Sun, 15 Dec 2024 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734263573; cv=none; b=ScEZKOdXcT3GA12g8Agy41EfzfbhKcEIHbykxemzJChGxW6yq2seBpxElTS3CygRIz5iZUUmVgl6MoBH4JZnnn7ozGCUSzcT7rz9nF3x6XPRb7xfJjvQAM3cFS6Pcf4lqL+yneKTpUDTNURU3T09d8oR4FqoSZaRHearhtI5OeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734263573; c=relaxed/simple;
	bh=JhV7KZ7SDsO91RGFiqURr/3YV124szYnmbfrwQhyWoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WECKCSRUYPG3b+W/O3pvUkBnii9KwAT5ga9TQIktcwnUUOxXjzTQQTuUOfaW55MHm0kkVj3rsNWhdxgPlZChDxZ+s1u1urniAGbA13T2QyEzBHeXGYigxLFXuc0UdH/iFgOx1c4OV6/NRRk01D2MFNgv9F9pyLaYgYSi/1IXFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gsz44Nu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799BDC4CECE;
	Sun, 15 Dec 2024 11:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734263573;
	bh=JhV7KZ7SDsO91RGFiqURr/3YV124szYnmbfrwQhyWoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gsz44Nu2U1f0lbknk5hvi4PQFjGu0NrZYmVrfDuGkfMdLBmcSukqijIa21pevX2ig
	 FpBifB+yiuD7yau3YeP5K6M+BE2XoBxIn6jcVdsjwKomLii7cgcezk4OqA1nYR42cT
	 jFDyQev9IXIvfnmK8dLkL1rUxYH7o4w30x8vF1KY=
Date: Sun, 15 Dec 2024 12:52:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Karol P <karprzy7@gmail.com>
Cc: paul@crapouillou.net, tudor.ambarus@linaro.org, Chris.Wulff@biamp.com,
	david.sands@biamp.com, viro@zeniv.linux.org.uk,
	m.grzeschik@pengutronix.de, peter@korsgaard.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] usb: gadget: f_fs: remove unused values and add
 immediate returns
Message-ID: <2024121557-alarm-devalue-c037@gregkh>
References: <20241106183032.80155-1-karprzy7@gmail.com>
 <2024110719-kennel-tiptoeing-3409@gregkh>
 <CAKwoAfpB-n8m7btodbH0zzTuEGiEQbDsC0aYuOfk8MSb+CFgLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwoAfpB-n8m7btodbH0zzTuEGiEQbDsC0aYuOfk8MSb+CFgLg@mail.gmail.com>

On Sun, Dec 15, 2024 at 12:41:03PM +0100, Karol P wrote:
> On Thu, 7 Nov 2024 at 06:15, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 06, 2024 at 07:30:32PM +0100, Karol Przybylski wrote:
> > > In case of faulty copy_from_user call inside ffs_epfile_ioctl, error code is
> > > saved in a variable. However, this variable is later overwritten in every possible
> > > path, which overshadows initial assignment.
> > >
> > > This patch fixes it by returning the error code immediately and exiting the function.
> > >
> > > Error discovered in coverity scan - CID 1583682
> > >
> > > Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
> > > ---
> > >  drivers/usb/gadget/function/f_fs.c | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > What commit id does this fix?
> 
> 7b07a2a7ca02a, usb: gadget: functionfs: Add DMABUF import interface

Then why not use the Fixes: tag?

> > How was this change tested?
> 
> I compiled the kernel and ran it on my machine.

Did you exercise this codepath?

> Are there other ways to reliably test such change?

Exercise the codepath by using the module and passing in a value to test
your change.

thanks,

greg k-h

