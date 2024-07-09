Return-Path: <linux-kernel+bounces-245231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D872792B00C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE2E1C216F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221C2137776;
	Tue,  9 Jul 2024 06:26:02 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359981AB1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506361; cv=none; b=etZRUfDVBaWsXxxxLXgTvPl9yZgfdpkrNCTQRElFbzj8FR+8V+Txro62m1P50VanpYWvlOCTLdpppJNNrY0dxozQKKXtmudcpytQL35NKdQSPR4qknvj4Quhrxt0RplWf+xgmLVz9p9kFHpi63GmgEJghTtINglMPJ7W9p+KulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506361; c=relaxed/simple;
	bh=XgoseCHyKz0NRdxfn9kmxsw+OG86Cc5wMNV+bz0uwZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUy5WGiMvj6k9YJi/3EJVXGxxVHTw3jfsziPpnZkmOBQ3HyRmqS80yPoLCb3rjMoXnlRZoTpOlZQL2uqt4hVcUjsGYgpAlNqmUuq8X0mB1fNJUwJk3Gs5k8xCsW/8n/GWyaQw/ZL6OX1O8y9nFu9Wq4OinAvyLB2A2wAnGTvZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E823568AFE; Tue,  9 Jul 2024 08:25:55 +0200 (CEST)
Date: Tue, 9 Jul 2024 08:25:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: mhklinux@outlook.com
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, hch@lst.de,
	m.szyprowski@samsung.com, petr@tesarici.cz, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 1/1] swiotlb: Reduce swiotlb pool lookups
Message-ID: <20240709062555.GB16797@lst.de>
References: <20240708194100.1531-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708194100.1531-1-mhklinux@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Michael,

I've applied this, but I've made a few changes before that directly as
we're getting close to the end of the merge window.

Most of it is very slight formatting tweaks, but I've also kept the
dma_uses_io_tlb field under ifdef CONFIG_SWIOTLB_DYNAMIC as I
don't want to touch the device structure layout.

Let me me know if this is ok for you.  If I can get reviews today
or tomorrow I'd also love to add them, but given that all this has
been extensively discussed I went ahead with applying it.

Thanks for all your work!

