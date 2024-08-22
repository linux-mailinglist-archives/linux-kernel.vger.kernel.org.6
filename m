Return-Path: <linux-kernel+bounces-296589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FD795AC7C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4975F1F21E64
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 04:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7BB38DC0;
	Thu, 22 Aug 2024 04:18:53 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75A54317C;
	Thu, 22 Aug 2024 04:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300333; cv=none; b=bCRLQ7XrI6WiLZ90A9uVi06sOkvbT8FJVNC0t/RpkXi5WKb4m7zZq/rPed/1rbrS1IRHJmJNu6nIEk36Mx2Iy6qfl6xUIntvb4oE2HjzmGCM9B526kPliRIwFZuzQ2LbSFyticXk50oH7JKgMBfwed+2f1mkJIf9JOVVRPGj1pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300333; c=relaxed/simple;
	bh=ItxjpvV6zOikKoHFC1FKdi042M9dRGlIWfRn4wMtupk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE5wIqhCRz5vvgzQNVdYotIzfPuhElD4uK3J+HAPme1H8YZzpaE+cISi8NsroSvBZCGhdhlq7KaHKdAFvYvEXntNRDOfZREkVuH0+qUm+5hxJHGrEqjKLAXWiSkgTPX7WajPfoZbKPrZ4FqZZ/p+3Ge0zV+i4wH/o1IoF7tKkMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A071227A8E; Thu, 22 Aug 2024 06:18:46 +0200 (CEST)
Date: Thu, 22 Aug 2024 06:18:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v6 RESED 0/2] dma: support DMA zone starting above 4GB
Message-ID: <20240822041846.GA856@lst.de>
References: <cover.1723359916.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723359916.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping tree for Linux 6.12.


