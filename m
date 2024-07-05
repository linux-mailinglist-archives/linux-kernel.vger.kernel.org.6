Return-Path: <linux-kernel+bounces-241822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0ED927FF7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017B71F23595
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511BF12B87;
	Fri,  5 Jul 2024 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="boSIrp0j"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B9D634
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144674; cv=none; b=bk6mYbQ8Xbl0l2+eem7j5J/60Rc8YBylfP6hf+hWwo2szP2mTAC7AAhPhpZsa/JYrOQq0UkRHaJOazsHrQJgpyuRGu0GrMv/mgELXwYrLzAopInQeLbj9RMUoUonnqhY08Dg0ON/Bh1OudPVU/oNqG8Q+e17TxaHM6JGUiVYNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144674; c=relaxed/simple;
	bh=gzm09+Hms/HlJOhtQ3OuBQp/2ViO/rBhTfvoKv1YULA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyoF34SBJie3xop+WDlVQWtYCujuTOwfsYOpv1biwl6exqho8FHCJ/MAAlsSrDc8gDSuiYqeF5740CearVLeeJ91AcCNo0o0oJZpBt8r7Q6AQi+ZIo4AdwZ3enoOHpFLBTiz3jo8LwQBUQn9I45754wfXsfKOJhgFr2EBT+eKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=boSIrp0j; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=jHvlEXaRyA3bpgUlkw1AFojmqIyREXUTTF5JQR72VEw=; b=boSIrp0jsZKUDH4Q
	UYfjpoVGX9wtBTFsDfrslweT3vAP4T/r9wcec0Rd5uPBgsTzMKEvAZ2Z+mKZfWLznbTofvfoGALoF
	v3UlPYkcvCS1FGADu1T9ZoMi/pFJEZnjq9QYgir2sbAqpbpXmXKO0qtOXao1SYQQ/YcNr6hkliyqq
	Xcli8hpzDG+QX2jgxHxyLxAWmNnn5/VGay5w3ME1Eop+NmqsR+wTR0xy1IsssZUuJFS/0GVjAC2tF
	2p9va1lATSfpwaKBbyRnOdIuD/gNBSM47zWb7zK+yQlvjt7WoWFgMssDvRvfqFstR89fCisoJ/Nkx
	HN7gVhPQF3PIq7ao7g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sPXh0-00A76q-0X;
	Fri, 05 Jul 2024 01:24:54 +0000
Date: Fri, 5 Jul 2024 01:24:54 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: jassisinghbrar@gmail.com, rrice@broadcom.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: bcm-pdc: remove unused struct 'pdc_dma_map'
Message-ID: <ZodLZl8oQSmsUoN2@gallifrey>
References: <20240523203741.201099-1-linux@treblig.org>
 <ZmTEqs2PKZZW_mYT@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZmTEqs2PKZZW_mYT@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 01:24:39 up 57 days, 12:38,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dr. David Alan Gilbert (linux@treblig.org) wrote:
> * linux@treblig.org (linux@treblig.org) wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'pdf_dma_map' has been unused since the original
> > commit a24532f8d17b ("mailbox: Add Broadcom PDC mailbox driver").
> > 
> > Remove it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Ping

Ping^2

> 
> > ---
> >  drivers/mailbox/bcm-pdc-mailbox.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
> > index 242e7504a628..a873672a9082 100644
> > --- a/drivers/mailbox/bcm-pdc-mailbox.c
> > +++ b/drivers/mailbox/bcm-pdc-mailbox.c
> > @@ -158,10 +158,6 @@ enum pdc_hw {
> >  	PDC_HW		/* PDC/MDE hardware (i.e. Northstar 2, Pegasus) */
> >  };
> >  
> > -struct pdc_dma_map {
> > -	void *ctx;          /* opaque context associated with frame */
> > -};
> > -
> >  /* dma descriptor */
> >  struct dma64dd {
> >  	u32 ctrl1;      /* misc control bits */
> > -- 
> > 2.45.1
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

