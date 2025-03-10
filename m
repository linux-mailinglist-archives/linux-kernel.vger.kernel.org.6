Return-Path: <linux-kernel+bounces-553732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1CDA58E34
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9693188E9CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6783D2222DC;
	Mon, 10 Mar 2025 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ikXX1Iyt"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB15617BA6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595510; cv=none; b=Rqe8d/6EEvPxKO1XoziAcmoLxmUDnBVTi3xFCykhoyNPaHpDoD9rxhodDz3fX+hI794st/paEfaaotUMpdMOdhfYyQw/ulVBufmMoyQxtVdLw4UbBzCsf9B81r0o3x5z5JzmaTcdeGxmA9Ehx7hNyIwXwNWWYxhudAqTOMWmtv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595510; c=relaxed/simple;
	bh=3vl10KU33CDG6uF+Ma1XE6fxWf0kXpX43klRjqGvjF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqF/K967w+sBwwFA0AXMQJfZ7U7MqBsbZPrqCBRB9LaVoa937T19r++NE+kintq3CSFzJbDs0taWb8FXTeI7knSEbt0c456szxOQQXIcINol1DzzyGVIcouPZp3UxCqzoJaq0gwTYNx3Sf6p1hGuG7AElR0ypuHpBufk+2aZCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=ikXX1Iyt; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3ACA144C5C;
	Mon, 10 Mar 2025 09:31:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741595507;
	bh=3vl10KU33CDG6uF+Ma1XE6fxWf0kXpX43klRjqGvjF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikXX1Iyti49HeA5hJ4hkLsG11glf2mTTE7Ixs3lnPZEcgpgUO2ac4yC/SdgZa2YYr
	 VGWTrtotRfrEZMZ4lTjMkO138ke6bSjgm6y0PFtrNhtl694qotEDm9qTihXGcJnwBc
	 viuR+D+csfcsnnNrPg4N69DPgxhmvXg7WCjvT0usF61AtxHrB6zuMxkgTQdHA67WVO
	 A/EW1TB6vZylRm4h5SLUUsh9Ntp/UKtN8L/tCxMtezrfVV7Tmjy52/420kkGpJsYLB
	 lQuWNxCl0dHs806ODt5BMv8GvIKpnn//Q7UlGYd2VunlVEm/gm4NkzJVojENPis2i2
	 Nzgh0vq79DoCQ==
Date: Mon, 10 Mar 2025 09:31:46 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for v6.15
Message-ID: <Z86jcijk6U-3Li5G@8bytes.org>
References: <20250310024749.3702681-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310024749.3702681-1-baolu.lu@linux.intel.com>

On Mon, Mar 10, 2025 at 10:47:43AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> The following changes have been queued for v6.15-rc1. They are about new
> features and code refactoring, including:
> 
>  - Checking for SVA support in domain allocation and attach paths
>  - Move PCI ATS and PRI configuration into probe paths
>  - Fix a pentential hang on reboot -f
>  - Miscellaneous cleanups
> 
> These patches are based on v6.14-rc6. Please consider them for the
> iommu/vt-d branch.
> 
> Best regards,
> baolu
> 
> Jason Gunthorpe (2):
>   iommu/vt-d: Use virt_to_phys()
>   iommu/vt-d: Check if SVA is supported when attaching the SVA domain
> 
> Lu Baolu (3):
>   iommu/vt-d: Move scalable mode ATS enablement to probe path
>   iommu/vt-d: Move PRI enablement in probe path
>   iommu/vt-d: Cleanup intel_context_flush_present()
> 
> Yunhui Cui (1):
>   iommu/vt-d: Fix system hang on reboot -f
> 
>  drivers/iommu/intel/iommu.c | 237 +++++++++++++-----------------------
>  drivers/iommu/intel/iommu.h |  28 +----
>  drivers/iommu/intel/pasid.c |  43 ++-----
>  drivers/iommu/intel/prq.c   |   2 +-
>  drivers/iommu/intel/svm.c   |  43 +++++++
>  5 files changed, 143 insertions(+), 210 deletions(-)

Applied, thanks Baolu.

