Return-Path: <linux-kernel+bounces-546993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89579A50190
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2A4171C07
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405E816D9DF;
	Wed,  5 Mar 2025 14:16:11 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B9F2746B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184170; cv=none; b=VvkiCWm7S3hCLHtIiPTcErt/SPzPbC1yanDelDVvLET9R60TYW5rBAmPVV4bc2AXDBVbGhFs6N1DPTM47sixjZfTMFTrY9GaLoZaGQbfOBl8Ji3IhD/sXIeX9X+kucGHYy4yrRIpy3s0QkDTuv2eZiwPjNHhxSHxZvIozaY972g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184170; c=relaxed/simple;
	bh=FBv1QUY/lHLjbA+rsuiORjOR203GJbiRUvrA3sQD3yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR12OLP7aXikn86a9E+jbKqR3S3MyX5W1C2jRcB46h2GtxfMLekQSKSF+rhFXEkRn6R/7hxMJ6NNCXVHwcNdCVK3zUyHt0zMhId+dzfTMGwEjiAIjP/SkKQJ402XeLEE2Bd4byuwG9k/mEd7N4tNOTdZy2Y2ncrgi1dCRPyX10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D80E868AFE; Wed,  5 Mar 2025 15:15:54 +0100 (CET)
Date: Wed, 5 Mar 2025 15:15:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, hch@lst.de,
	bmarzins@redhat.com, Bryan Gurney <bgurney@redhat.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marco Patalano <mpatalan@redhat.com>, axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <20250305141554.GA18065@lst.de>
References: <20250204211158.43126-1-bgurney@redhat.com> <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com> <Z7Sh-3yHbXVmRbNL@kbusch-mbp> <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com> <Z7TARX-tFY3mnuU7@kbusch-mbp> <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com> <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me> <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 26, 2025 at 10:55:21AM +0100, Hannes Reinecke wrote:
> Plus there are some NVMe devices out there which _despite_ being PCIe do 
> report NMIC and CMIC set (I won't name names, if you came across them 
> you'll know)

?????

NMIC and CMIC is perfectly normal and expected for multiported PCIe.
WTF are you talking about?


