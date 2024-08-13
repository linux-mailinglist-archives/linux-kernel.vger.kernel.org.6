Return-Path: <linux-kernel+bounces-285153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A998B9509E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17011C2259F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7276E1A0AF3;
	Tue, 13 Aug 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X5Pyu/5D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA11A0709;
	Tue, 13 Aug 2024 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565530; cv=none; b=kxlX8jh2JUdZHcPOT2vZ2pBuyP7KOvpZASFTq6Kng/rzZ/UDhOqa3zwwJV48iAk2Ju9uNx41q2KOqgudqCBrtWZeimlK+/J5X34Yv1A8e0k/g6hvm2X2Afw4KmEPWaCOs4GKh7jZJ9zvqA9vsuTHRfLJiYHZMykRYe55HAOovCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565530; c=relaxed/simple;
	bh=OT1jMBEIYbcJ4ISbVWZe5XVYi/0pcQuZSkg7Dpj36hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN+EJOYAmYXZZnDk6J0sDHo+GMshluefzP6gO6ywDzudT3i+TgQUJIF1te0a48NgGxgkpejC4quR4GNG1487cBLrx6YwdqLzDzsPDCJ28ReaVeOhsRAqVS2IhhxjrqkkCAFOX5k7ChGPVYsDWYq3dDND9LclUN0YWZyanJkx7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X5Pyu/5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A30FC4AF0B;
	Tue, 13 Aug 2024 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723565530;
	bh=OT1jMBEIYbcJ4ISbVWZe5XVYi/0pcQuZSkg7Dpj36hI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5Pyu/5DS3i3+P352b3/TudoHJl3Gy9i0L9Wv5WPSmRm5mgoalV6H82adKYic3G0N
	 orrvGmbqA8NRVWsFOQ/4hoUFHQx7oGvJRTJ8NrvVsJBrt/7n/oGV5csJmhgZwX9vuy
	 5dBd0MJkVqMENHar9HP3/WNldyU+oaJ6gQ/jJkvg=
Date: Tue, 13 Aug 2024 18:12:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Wulff <crwulff@gmail.com>
Cc: linux-usb@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Perr Zhang <perr@usb7.net>, Pavel Hofman <pavel.hofman@ivitera.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: f_uac1: Change volume name and remove
 alt names
Message-ID: <2024081348-muskiness-fountain-7e75@gregkh>
References: <20240804002912.3293177-2-crwulff@gmail.com>
 <2024081335-wrist-earpiece-a738@gregkh>
 <CAB0kiB+ONUpx9Ozg9x836BEdCtSSm-J+jpy2BKoDgVF1CP9O9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB0kiB+ONUpx9Ozg9x836BEdCtSSm-J+jpy2BKoDgVF1CP9O9Q@mail.gmail.com>

On Tue, Aug 13, 2024 at 08:56:26AM -0400, Chris Wulff wrote:
> On Tue, Aug 13, 2024 at 4:34 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Aug 03, 2024 at 08:29:13PM -0400, crwulff@gmail.com wrote:
> > > From: Chris Wulff <crwulff@gmail.com>
> > >
> > > This changes the UAPI to align with disussion of alt settings work.
> > >
> > > fu_name is renamed to fu_vol_name, and alt settings mode names
> > > are removed for now in favor of future work where they will be
> > > settable in subdirectories for each alt mode.
> > >
> > > discussion thread for api changes for alt mode settings:
> > > https://lore.kernel.org/linux-usb/35be4668-58d3-894a-72cf-de1afaacae45@ivitera.com/T/
> >
> > What is now going to break due to this change?  What userspace tools use
> > the old names that need to be changed?
> >
> > Are you _SURE_ that you can rename external files like this and
> > everything will keep on working?
> 
> Nothing is using them, since they were just introduced. I wanted to get
> the API changed before they make it to mainline and somebody starts
> using them.
> 
> You just applied the patch that introduced them into usb-next on 7/31/2024,
> just after v6.11-rc1 so they haven't yet made it to the mainline kernel.
> 
> This is the patch that introduces them:
> 
> https://lore.kernel.org/all/CO1PR17MB541911B0C80D21E4B575E48CE1112@CO1PR17MB5419.namprd17.prod.outlook.com/

Ah, thanks, I totally forgot that.  Remember, I deal with about 1000+
patches a week...

thanks,

greg k-h

