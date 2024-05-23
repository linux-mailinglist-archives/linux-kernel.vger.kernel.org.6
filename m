Return-Path: <linux-kernel+bounces-187547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E800A8CD347
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F86A1C21A18
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062AD14A61E;
	Thu, 23 May 2024 13:10:19 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8278A14A0A7
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469818; cv=none; b=HzWpKiRMwRCOKFdI0ZVJu4rzqm812Dk+Mo3nIjrll7b7VAoDoH+6buBzheN5TEXENLzodIavrtWGxTKoP0rCp7/jRlgKKGHsadBKHHy4Ymk3GfGusA9gIQpC8rLtcTofYIiBf7ihaoxYpGut8YMPlhykLRWcE9tkhryIcEptDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469818; c=relaxed/simple;
	bh=OTN8OKUwUtgeS/b4hDd67/FdTa7TqUbmfFwTxWPmJ5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOb+6kDcrU0cZleLQUa/nRE1/xgsopotrtZTGtF215yaxvkSCloJbUjqGDLYskZjQHNtgHR+j5W6QsqEGwz0uhQR4POHQUEaHTA3rqulUL415jE9++31mm4SwF/7ijfkVesmU7qQE4JfXxFRJnjS47r6kVUDHceoHJCPQS8qkjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0895668CFE; Thu, 23 May 2024 15:10:09 +0200 (CEST)
Date: Thu, 23 May 2024 15:10:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Xiang Chen <chenxiang66@hisilicon.com>, Barry Song <21cnbao@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 0/4] dma-mapping: benchmark: fixes and error
 handling improvements
Message-ID: <20240523131007.GA23087@lst.de>
References: <20240504114713.567164-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504114713.567164-1-pchelkin@ispras.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping tree for 6.10.


