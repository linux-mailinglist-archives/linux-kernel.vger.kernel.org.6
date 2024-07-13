Return-Path: <linux-kernel+bounces-251345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3CE9303C8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 07:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254E61C2168A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 05:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A465E29D0C;
	Sat, 13 Jul 2024 05:30:15 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B920309
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720848615; cv=none; b=PWQ9WzFHqNzYo6eNnHSHk8zk0JiYeDqZDQems8j6AZi8njRQdw/LAynRQ52qg2mlr5ZBBB5O7VrKKSO4g2c+YDwaOGmh+JjjBy2TN4Bofjn/hmT+7b+fM8fkRrELgnZnRl+/WTHEg67MmFYOADA3s7/AdEjapvUo3mvKdN+LvKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720848615; c=relaxed/simple;
	bh=b01yVBw+udetAoG/aCH3HRhBW8NPgaY94KMsW51QUqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Suz8U0vTL5yVHQ9LE0ejFv5HHjoCTFKwiRSVVoC1gxiECUj+W+KvSx0qHQz6w6jlChY/fNXPbjHHtDgJZ/bHrnRFlxtpGAYBmzqdvYlvV6jsjDY7YlrV9msgaXFVqK+vO8QlggVnZdqC/ZgvrHN6jc8jsxlG7rg7bbVPTnCV3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F65768B05; Sat, 13 Jul 2024 07:30:08 +0200 (CEST)
Date: Sat, 13 Jul 2024 07:30:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] swiotlb: Add missing kernel-doc function
 comments for swiotlb_del_transient
Message-ID: <20240713053008.GA26013@lst.de>
References: <20240712073816.38772-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712073816.38772-1-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

The kernel-doc comment is not missing, the desctiption of the new
paramter is.  I've updated the commit log and dropped the pointless
closes.

Thanks for the patch!


