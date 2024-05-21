Return-Path: <linux-kernel+bounces-185028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A508A8CAF90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425F51F23A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8E57EEFD;
	Tue, 21 May 2024 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HekusvH9"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62E7E573
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298969; cv=none; b=HBYHY8AaELxAXn7APjzF1F/gJKofFEZmHUMBZNukvEbkcIgyUSlelpIB9+6VLQLhxt5gZFXEtewt7bx049EBbMcvm9HXMEf8SjzQZAVhbSL37DLLmrSOegwEaF0pqL55RJ9sBELMjcYmK4T7lWVf+yNbyjoIu+DYd0MU7l/+PAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298969; c=relaxed/simple;
	bh=nskXoVH0tSdwHwBT5lpfPvxc/GCyARcFwFwmmtGRg6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7SZ2mfpJLa+PnctSEPYtAIKrigNWcPdB+ay98C35stKAEuuM7vSLc4M+dTg+zE2fvE7OzYSStsQnSn98aYOLvvAM5QHVlUKM94Tetp1HOyFUrFKZYOvsDYwuwV2xonJQx+ezogqv+KC9kvAC1nl/PQjJzLgpsxwG4sv2ym8cYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HekusvH9; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: visitorckw@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716298964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kmyyYf/FNg0lJsmtTVqGM2lJeyBvXRDagDqrypf1zFs=;
	b=HekusvH9FhSlsL2OyjT4vkM4ik7uEwHkVk8gsvKfpd8/M5RpCJQmDraUJy1+MaAxgXr2QI
	e0R0rRKH/vHme7hLcBDbhROJv+giXL8hrerLAMoVHQYkmKxSIJ8V/AGxs1HHYdvjB77CR1
	FhNqpeRhk6/HUwh6bR4QEZONdydGonM=
X-Envelope-To: sfr@canb.auug.org.au
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: colyli@suse.de
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-next@vger.kernel.org
X-Envelope-To: matthew@mm12.xyz
X-Envelope-To: bagasdotme@gmail.com
Date: Tue, 21 May 2024 09:42:40 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jens Axboe <axboe@kernel.dk>, 
	Coly Li <colyli@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Matthew Mirvish <matthew@mm12.xyz>, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: linux-next: manual merge of the refactor-heap tree with the
 block tree
Message-ID: <qqdgvzivlg7uapdv6vkpqsodonzlvptrqn4h4sgyhtrqlfggej@zaudibjtmylj>
References: <20240509152745.08af752f@canb.auug.org.au>
 <20240521121803.399705b0@canb.auug.org.au>
 <ZkwKe15cyhgRP4Qy@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkwKe15cyhgRP4Qy@visitorckw-System-Product-Name>
X-Migadu-Flow: FLOW_OUT

On Tue, May 21, 2024 at 10:44:11AM +0800, Kuan-Wei Chiu wrote:
> On Tue, May 21, 2024 at 12:18:03PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > On Thu, 9 May 2024 15:27:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > 
> > > Today's linux-next merge of the refactor-heap tree got conflicts in:
> > > 
> > >   drivers/md/bcache/bset.c
> > >   drivers/md/bcache/bset.h
> > >   drivers/md/bcache/btree.c
> > >   drivers/md/bcache/writeback.c
> > > 
> > > between commit:
> > > 
> > >   3a861560ccb3 ("bcache: fix variable length array abuse in btree_iter")
> > > 
> > > from the block tree and commit:
> > > 
> > >   afa5721abaaa ("bcache: Remove heap-related macros and switch to generic min_heap")
> > > 
> > > from the refactor-heap tree.
> > > 
> > > Ok, these conflicts are too extensive, so I am dropping the refactor-heap
> > > tree for today.  I suggest you all get together and sort something out.
> > 
> > I am still dropping the refactor-heap tree ...
> 
> Hi Kent,
> 
> Are you still planning to send the pull request in this merge window?
> I've sent the v5 patch series [1] to resolve the conflicts some time ago.
> Is there anything missing from my side?

Unfortunately it's going to have to wait until next merge window, all
the conferences the past week have meant I've been pretty distracted,
still not fully caught back up.

