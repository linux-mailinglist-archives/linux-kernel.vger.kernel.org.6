Return-Path: <linux-kernel+bounces-284396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D3295007F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1A41F23D17
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA537187FFA;
	Tue, 13 Aug 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="IbQYqljO"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7680917D340
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539267; cv=none; b=cfr4a7tPybk3bLqmmgkR6OIbSGH37Q9LFaBOoxSupqol6uWqZ5Uce0VDlf5cnLwbrIV+zS7+tCwRNFrMVNGkXyCfRWrF0DKgAXTYBudGs3isq11T7Yym4stECJAn89NJhvcjTwb/42MLv7FgsQRSri05DrOp08RhBkrNQJ51zew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539267; c=relaxed/simple;
	bh=t9aWOiMm1M33jne9m0z4C1coYRIC28sw855e4mBAgkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UX7rMDWr7sNvZOPlyc3WfLzW8+xSC2CWynE8OV5Qol+BUWEb5xjiAdUVeeaATolIYXcFCaERqIOvdhhE5CmjXxHadBoIjUfMnRr0JxvptkrmccWVZbZX+k6AX7KEJ8jbia4F2iphl58f3CwV/wy3e3Am4G2ktFon62p6SqOa8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=IbQYqljO; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4EA3E2A50EF;
	Tue, 13 Aug 2024 10:54:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1723539263;
	bh=t9aWOiMm1M33jne9m0z4C1coYRIC28sw855e4mBAgkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbQYqljOnMMeSZpJ8g1vJ8b+VAQOyyumaH0ARBY1/iqaTc/ha1F03eD1BOoqweZNb
	 +H0CvWrXvDzYM0Nwpx6FntWfpaIKVq796miFMqyyzTB2qAQbBAwb+aji/rIw4u4QIm
	 E0vrgCN95JMUsef4/TrXKZtihQgFq5pT58/TP/Dv2IM9Z1+tNlQBgMbSEBuhc+qxWV
	 qwfa9pmdWqi8a/k2XQzN4JOpHVYs7hifwt3SARooaPRLjUGCp8bTGeKz/kxO3HpXc/
	 W2CmHuSVNiuDNIAqoSoA1siGplxJZw0jvUGY0HCmJxU8FJkOeStFFMvLyLaMwWw3fv
	 YqoylyTuAWSFQ==
Date: Tue, 13 Aug 2024 10:54:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@ziepe.ca,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu: Remove unused declaration
 iommu_sva_unbind_gpasid()
Message-ID: <ZrsfPf2XvAZhzIXb@8bytes.org>
References: <20240808140619.2498535-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808140619.2498535-1-yuehaibing@huawei.com>

On Thu, Aug 08, 2024 at 10:06:19PM +0800, Yue Haibing wrote:
> Commit 0c9f17877891 ("iommu: Remove guest pasid related interfaces and definitions")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/iommu.h | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

