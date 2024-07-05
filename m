Return-Path: <linux-kernel+bounces-241809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C0A927FCF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F491F24E09
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10A7EEDD;
	Fri,  5 Jul 2024 01:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="E4tBQQYo"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC4320E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720143396; cv=none; b=UEp935Kmvi75XHTX3sjynFgrmymlp55FAmkuCfs+cSZuj2M+lNwgB+iXt6j2Rx5VidKQ4NGF9acVk0wgkM6lGu5Aj3SUQJ6NAz7uFZRAsI7Uz4xlrfUATGd7dgUGgWEAY58pvht8OZcLHuGoStfQuVavQhPeDccclma2WX/XEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720143396; c=relaxed/simple;
	bh=g0J64IFCUepalmS25gCFEzy9g5XYD/RDb3yWNgLTxzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqk+W4533amXW1ScoRJelGudZ5f3IvoRRiQSZFXQf8/n/2B+kLvrRPXagFddd3S8bGH0/oUUnQk92c+psBksirxIKfxu1mhZzqeGGK91/IC5nRm2sITPUwCbpUmnX9Iu/wWn+4H66yRVBbDki5PhcNyh3eN19ZymQM+M70MpctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=E4tBQQYo; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=U/fSEFDhL867FmA5P4TRpE0BvznP9AMV6QFUlc6SsjI=; b=E4tBQQYoE7giVlwq
	zoPKww5Ep+92KkECGEBNhL67Ko+etSlt23ox/u9iNLN50XiP67dDTOAXc2hkEe8TKb04J3VmpVQ6x
	mXPwRdJAYSCNJYxmmvYMHq6covWRZJ6+2EY8aCC4HuMNiIFXi6X1j32atmcbbPDqTpj9Z3kVvDQWW
	UtxebIytThFxQsW/5sl3LQ/l2WLCcsAkzo9E190dIiBcUg1k5KyCa6wM8ue9syUVnZIVpoWhSeTx3
	fgw6jrJlD/RjRS8JJtyAxxa5suskIGEyFDuJeb2U4BI/LwEz+PNWGVs6u8+OQX44Wx75Pgv9Slyqk
	uNLHFjzHC5jo5KJ8vQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sPXsE-00A7BQ-0i;
	Fri, 05 Jul 2024 01:36:30 +0000
Date: Fri, 5 Jul 2024 01:36:30 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: mporter@kernel.crashing.org, alex.bou9@gmail.com
Cc: linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] rapidio: removse some dead defines
Message-ID: <ZodOHvh6tD9NN2f1@gallifrey>
References: <20240528002515.211366-1-linux@treblig.org>
 <ZmrzhW4_ANIfbOYk@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZmrzhW4_ANIfbOYk@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 01:35:59 up 57 days, 12:50,  1 user,  load average: 0.01, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dr. David Alan Gilbert (linux@treblig.org) wrote:
> * linux@treblig.org (linux@treblig.org) wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'mport_dma_buf', 'rio_mport_dma_map' and 'MPORT_MAX_DMA_BUFS' were
> > added in the original
> > commit e8de370188d0 ("rapidio: add mport char device driver")
> > but never used.
> > 
> > 'rio_cm_work' was unused since the original
> > commit b6e8d4aa1110 ("rapidio: add RapidIO channelized messaging
> > driver")
> > but never used.
> > 
> > Remove them.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Ping?

Ping^2

> Dave
> 
> > ---
> >  drivers/rapidio/devices/rio_mport_cdev.c | 20 --------------------
> >  drivers/rapidio/rio_cm.c                 |  6 ------
> >  2 files changed, 26 deletions(-)
> > 
> > diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> > index 27afbb9d544b..5c83741c3005 100644
> > --- a/drivers/rapidio/devices/rio_mport_cdev.c
> > +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> > @@ -97,18 +97,6 @@ module_param(dbg_level, uint, S_IWUSR | S_IWGRP | S_IRUGO);
> >  MODULE_PARM_DESC(dbg_level, "Debugging output level (default 0 = none)");
> >  #endif
> >  
> > -/*
> > - * An internal DMA coherent buffer
> > - */
> > -struct mport_dma_buf {
> > -	void		*ib_base;
> > -	dma_addr_t	ib_phys;
> > -	u32		ib_size;
> > -	u64		ib_rio_base;
> > -	bool		ib_map;
> > -	struct file	*filp;
> > -};
> > -
> >  /*
> >   * Internal memory mapping structure
> >   */
> > @@ -131,14 +119,6 @@ struct rio_mport_mapping {
> >  	struct file *filp;
> >  };
> >  
> > -struct rio_mport_dma_map {
> > -	int valid;
> > -	u64 length;
> > -	void *vaddr;
> > -	dma_addr_t paddr;
> > -};
> > -
> > -#define MPORT_MAX_DMA_BUFS	16
> >  #define MPORT_EVENT_DEPTH	10
> >  
> >  /*
> > diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
> > index 9135227301c8..97287e838ce1 100644
> > --- a/drivers/rapidio/rio_cm.c
> > +++ b/drivers/rapidio/rio_cm.c
> > @@ -198,12 +198,6 @@ struct cm_peer {
> >  	struct rio_dev *rdev;
> >  };
> >  
> > -struct rio_cm_work {
> > -	struct work_struct work;
> > -	struct cm_dev *cm;
> > -	void *data;
> > -};
> > -
> >  struct conn_req {
> >  	struct list_head node;
> >  	u32 destid;	/* requester destID */
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

