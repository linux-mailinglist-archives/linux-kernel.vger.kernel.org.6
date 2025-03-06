Return-Path: <linux-kernel+bounces-548014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7253FA53ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B447A4280
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5C61853;
	Thu,  6 Mar 2025 00:03:57 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825B7376
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219437; cv=none; b=C4XJxV/qsDQc0mIRau06FudwlDFedLqfNZpO/E1XdNrav++/p64iq3cTIpkCvqSct4seHuOXmd6qcIDGWC/NcGs70qn5zeLknTA2Ccgv9XmXlZA/pLoQ1RK0vpLNOT3Euw2HTt9qqDd2xZ/w7NbpchotpQZozuwuUTOv3y9MlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219437; c=relaxed/simple;
	bh=kjp8x1ytnycfKo+KUkfRyVWWh0PRBeKDaQEeW9/9CJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLpm9Z1ts98ibUxNclZF4Ge/s4LFDaP4eiy84fje1rEGmYdgNd6VEQJU0PWzkbteU4LBPCqyqiXWRJperSQyitlhH/GlPGqWE42D9++97xY9RwbYXE6DHaPg9+PjKn7LaFm4O7oE7cjOV4Gz44K3SEjiWnYvy4RbFkbN/yeaueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 18EF568BEB; Thu,  6 Mar 2025 01:03:49 +0100 (CET)
Date: Thu, 6 Mar 2025 01:03:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <20250306000348.GA1233@lst.de>
References: <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com> <Z7TARX-tFY3mnuU7@kbusch-mbp> <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com> <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me> <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de> <20250305141554.GA18065@lst.de> <Z8hrJ5JVqi7TgFCn@kbusch-mbp> <20250305235119.GB896@lst.de> <Z8jk-D3EjEdyBIU5@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8jk-D3EjEdyBIU5@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 05, 2025 at 04:57:44PM -0700, Keith Busch wrote:
> > > Obviously he's not talking about multiported PCIe.
> > 
> > Why is that obvious?  
> 
> No one here would think a multiported device *wouldn't* report CMIC.

I hopes so.

> The
> fact Hannes thinks that's a questionable feature for his device gives
> away that it is single ported.

Well, his quote reads like he doesn't know about multiport PCIe devices.
But maybe he just meant to say "despite being single-ported"

> > At least based on the stated works he talks about
> > PCIe and not about multi-port.  The only not multiported devices I've
> > seen that report NMIC and CMIC are a specific firmware so that the
> > customer would get multipath behavior, which is a great workaround for
> > instable heavily switched fabrics.  Note that multiported isn't always
> > obvious as there are quite a few hacks using lane splitting around that
> > a normal host can't really see.
> 
> In my experience, it's left enabled because of SRIOV, which many of
> these devices end up shipping without supporting in PCI space anyway.

If a device supports SR-IO setting CMIC and NMIC is corret, but I've
actually seen surprisingly few production controllers actually supporting
SR-IOV despite what the datasheets say.

> 
> > > And he's right, the
> > > behavior of a PCIe hot plug is very different and often undesirable when
> > > it's under native multipath.
> > 
> > If you do actual hotplug and expect the device to go away it's indeed
> > not desirable.  If you want the same device to come back after switched
> > fabric issues it is so desirable that people hack to devices to get it.
> > People talked about adding a queue_if_no_path-like parameter to control
> > keeping the multipath node alive a lot, but no one has ever invested
> > work into actually implementing it.
> 
> Not quite the same thing, but kind of related: I proposed this device
> missing debounce thing about a year ago:
> 
> https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/

Yes, that somehow fell off the cliff.

