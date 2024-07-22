Return-Path: <linux-kernel+bounces-259479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D349396D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDDF2823F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E66481B1;
	Mon, 22 Jul 2024 23:16:38 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC13CF74
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721690198; cv=none; b=XYaFWfxKmH+pqUeQjgQT0YlLjqsmQ3jU5RQk8G8c/htj7KkiIUroEgqqZzIbPulvn62CwYusGldnlniHZsuvwIhpbHM1zE4fisXNTZmZw4iMV2Tp8hlCBW5hgtyvq3/BFG43q0NNhV/Z4AYq+nByf18eJekcRg++lheio/BzXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721690198; c=relaxed/simple;
	bh=TcvdJXVJKv7io3GIC8QJ7ec05t1nrM9xp5W9TPsqRRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKxbuvNayU1t9R8rSZ0617XuHNKYrhtVFXs5XGSZlBDN9D15dl83v+vFMkFSRzf7DKoW/Hd/nwlSQKw3oSw+5fnFtoMuG6xptni5BZgjkAGXXJeZZS8zJzAQW3RPDCEwc9yQVEwNeZ9CBc3ekLFFxKZ6hjpv/f1iUegrnEf5U/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D340F68CFE; Tue, 23 Jul 2024 01:16:30 +0200 (CEST)
Date: Tue, 23 Jul 2024 01:16:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 2/2] dma: add IOMMU static calls with clear default
 ops
Message-ID: <20240722231630.GA3184@lst.de>
References: <cover.1721547902.git.leon@kernel.org> <bf0b200d4600edd9d6d12168e89f9f3abd6b9789.1721547902.git.leon@kernel.org> <20240722151037.GA25001@lst.de> <20240722154458.GA7022@unreal> <20240722154929.GA26317@lst.de> <20240722160555.GB7022@unreal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722160555.GB7022@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 22, 2024 at 07:05:55PM +0300, Leon Romanovsky wrote:
> Should I need to reformat the code to your preferred style?
> I can do it, but it will be manual work :(.

Just keep it as it was. And preferably also follow the style in
dma-iommu.h.  In the worst case I can just fix it up when applying
the patch.


