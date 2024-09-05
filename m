Return-Path: <linux-kernel+bounces-316928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF4496D727
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE3328756F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23BC199252;
	Thu,  5 Sep 2024 11:32:04 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D0198A06
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535924; cv=none; b=i+BmLVUd51mF+gktbx99s0xiyz9WS8omXtD/tzEcDIZLXE6PeVgYWWiY/oPVF2RO+TnMdUb3Qmg2MLrcOgR0ib3+fsnE7EYI5D3IJtPW/VJHLvIAmmniGa/sm+UJs+Y6MNb8thK8RqUC99eGBCAF1ZJH9fQZ3F0FYJQRB711BRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535924; c=relaxed/simple;
	bh=T7WiwVoh2MQnzNFVZdq26Es8RT3gR+RuYUQYn6pY3dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAYAfk0b0aA9K0xlGqsHIgya6AklI0s1Mw3IyVn1wwm+8k2a9KvOTptONawCIDA7DM7DAckDt7msFhiIarviKqhryOaTpBF78ey88yMCY/zbF/3lWZuwbGlYJZoif24prtxi3pDwLtjbmYC/iC2HoZ09M84qR3RJQ6R3LwPGSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 18C5268AFE; Thu,  5 Sep 2024 13:31:52 +0200 (CEST)
Date: Thu, 5 Sep 2024 13:31:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH] dma-mapping: Use IOMMU DMA calls for common alloc/free
 page calls
Message-ID: <20240905113151.GA25243@lst.de>
References: <62ce544e41d233eb6f591514a53f2eaabf488a7b.1725519850.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ce544e41d233eb6f591514a53f2eaabf488a7b.1725519850.git.leonro@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks  applied.

I'm not entirely sure if simply duplicating the helper logic in dma-iommu
would be better, but unless Robin has a strong preference we can just
go with this version for now.


