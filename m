Return-Path: <linux-kernel+bounces-186301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C416D8CC26F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECB82818DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A4214039E;
	Wed, 22 May 2024 13:50:00 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5BC8217FE
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385799; cv=none; b=S/GB3DYz46+idAi9TzUD0wgh2kniEw+zQNN7FIlGwN9GSNtW1RvGpiKfM5qaoVvjijGWaONgAyQKzOJKJ0gevQ51uX85SDcnXGGB2sWGr0JNMUmBjiHLV1QlvrBdp2ZNrx6tBBrCrnLkSenkFLGSmNifwFmX9vJcCXrCKfRSkek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385799; c=relaxed/simple;
	bh=78Q2CGlF7Kc7/HZA9H4BC5dum8xm9Ro2FY2sOfh2+Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqjZ3sOyaBWIbtZmUTa1n41VjYt0ANjg6t35SxcKmsbAB8ijXYUEnz4f3wdbouCQudoxk6yDfmP7ZpHiuq77aRdIhq8/4J/IjC+KBk5WdImv7EAh1gd5jbGXJAaA1UY9Y53dmjqei9ACsyvdYASbz0+rg3ohuWfbdOOHTuSLElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 497823 invoked by uid 1000); 22 May 2024 09:49:55 -0400
Date: Wed, 22 May 2024 09:49:55 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Shichao Lai <phyhac@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
  linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: divide error in alauda_transport
Message-ID: <b82e133a-62a3-4f23-9803-1af79b06b8f4@rowland.harvard.edu>
References: <CAEk6kZszgHVYN8r-AsPw9YtGGf459j0uDMYLdOoTixhE3YJCKw@mail.gmail.com>
 <2024052224-motion-perish-82cd@gregkh>
 <CAEk6kZt4qcV0xUxHFRp3DTdZ0f_3fLE0q4e_AWHGyjba=19g9g@mail.gmail.com>
 <CAEk6kZsgEJNSmFFe-tdA+RhM=+Pjm=JvHiNJ4QjZONPXHt-gjw@mail.gmail.com>
 <2024052242-hunter-exception-930c@gregkh>
 <CAEk6kZsLqJ5RbWYMrcbB+LkRq8jzRgTm3F8kq8FKB14y8ST2GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEk6kZsLqJ5RbWYMrcbB+LkRq8jzRgTm3F8kq8FKB14y8ST2GQ@mail.gmail.com>

On Wed, May 22, 2024 at 06:01:57PM +0800, Shichao Lai wrote:
> Thanks for your patience. I am a beginner and initially attempted to report
> errors to the community.
> However, I have just discovered that the issue mentioned above has already
> been proposed in the previous three months of the article, and there is an
> ongoing discussion.

To call the discussion "ongoing" is optimistic.  There hasn't been any 
reply to my last post, which was made on March 17, more than two months 
ago.

Maybe you can carry out the tests I described in that post.  That 
would be a big help.

Alan Stern

> I think this post can be closed later.
> 
> https://groups.google.com/g/syzkaller-bugs/c/m8CuxSpLKoQ/m/JfUy1xGnAwAJ
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> 于2024年5月22日周三 16:59写道：
> 
> > On Wed, May 22, 2024 at 04:22:18PM +0800, Shichao Lai wrote:
> > > patch like this:
> > > ```c
> > > while (sectors > 0) {
> > >     if (!uzonesize) {
> > >         return USB_STOR_TRANSPORT_ERROR;
> > >     }
> > >     unsigned int zone = lba / uzonesize; /* integer division */
> > >     unsigned int lba_offset = lba - (zone * uzonesize);
> > >     unsigned int pages;
> > > ```
> >
> > Please submit this properly and we will be glad to review it.
> >
> > thanks,
> >
> > greg k-h
> >

