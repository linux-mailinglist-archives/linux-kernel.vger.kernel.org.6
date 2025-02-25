Return-Path: <linux-kernel+bounces-531767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B38A4448E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE2A3A9A58
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5387214A60A;
	Tue, 25 Feb 2025 15:37:23 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15172FB2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497843; cv=none; b=ZanPBwVB9qSvSfr/AuwTpI1cYsC9vXLdUYm3af92BGlt02rGK2uRtl67CiwEdCbqw/e7fq0Y1skZ2LxlWcfr839iMs6WuK5hQvUfEJrhztIkGlcy5xW5TZBsRMzhSqD++Thviws7xdR26H0qmoDK9yjUOiZAmkKety5gHQI3PA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497843; c=relaxed/simple;
	bh=5RsOOvv4/v4k8q1hK8YiYnK0f9T2HxNOpQanU6J/Cfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOjQIHXR+bhrFB2a9fEM8zhGejp1SaX5x7G99/RtF6UPMtM4EABhmUoRc98kj298UZGprUdZ9BjjQ+EOBowgz6eq2nm3HrmLSLZ7PZRi4UmxJNB4SpGEv8BtaOMmjVhckbApgcI69IrEXqe80jD/1ebrZh/sLvLylJLMgUF2Nz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BD3C4CEDD;
	Tue, 25 Feb 2025 15:37:19 +0000 (UTC)
Date: Tue, 25 Feb 2025 15:37:17 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/14] mm/vmalloc: Batch arch_sync_kernel_mappings()
 more efficiently
Message-ID: <Z73jrWlV5X9senZw@arm.com>
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-12-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217140809.1702789-12-ryan.roberts@arm.com>

On Mon, Feb 17, 2025 at 02:08:03PM +0000, Ryan Roberts wrote:
> When page_shift is greater than PAGE_SIZE, __vmap_pages_range_noflush()

s/PAGE_SIZE/PAGE_SHIFT/

Otherwise it looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

