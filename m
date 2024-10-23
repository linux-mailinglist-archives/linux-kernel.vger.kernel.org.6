Return-Path: <linux-kernel+bounces-377361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7EF9ABDC8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2604A1C2285C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FC1145348;
	Wed, 23 Oct 2024 05:25:43 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9828A142623
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661142; cv=none; b=sdQhLJQeFoG//9Ndj0hIiUqbn4HQixR8EAwoQ72LnIO3FS/YluVvzs3MT8GjqeNgo/Gf0p6jMkhuNiE3E8vn7ocUuZaeMJZBjUVI+jRlf+lg0MpARpUrziAESzjVofIGPS/SKF0xV168+LijKCp1L/IdZK2d3W8GIuRng6mE01I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661142; c=relaxed/simple;
	bh=VOvN/FQxVKnUdi33a/GqqCR6ueaVuPg/Ymi165Pd0hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETVptya1N9Dxh0V+z1R9x2Y9DRhrVzSr+iBkA3jpQoa1zNvtHv6atKukPNxn++leNGuVQwhCAn4GR3u4F/vrmqQrcvoUrakAv35fDwu1LILsAQmgB3hTHNf+v36GWjuM6u5YW54nt8rhyFHBtEdMvGVhztyp8ZFJymaq6FZR/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8736D227A87; Wed, 23 Oct 2024 07:25:38 +0200 (CEST)
Date: Wed, 23 Oct 2024 07:25:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: dma-map-ops.h: Remove an outdated comment
Message-ID: <20241023052538.GA1561@lst.de>
References: <20241023032544.2809331-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023032544.2809331-1-sui.jingfeng@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks Sui,

I'll queue it up for Linux 6.13.


