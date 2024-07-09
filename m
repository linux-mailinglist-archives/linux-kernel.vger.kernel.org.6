Return-Path: <linux-kernel+bounces-245608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE48B92B4E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973B2283ADB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC8015664C;
	Tue,  9 Jul 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGCWcnbP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF6E155CAF;
	Tue,  9 Jul 2024 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519958; cv=none; b=bE0/bWyun5BKEHAlyW+nPBqF6cZNZHnB3kHWjYQnJsqncv7cDxCONzxNENn6NqZPioNX798jXejB8mVHbEi9og+Ww0bmuN7wUK7uzKBBz2mr7YjsDCKRI7WBMl/D0C2yslKyf0fvA6BgmkYnV83sNJ9XF3KbCFA1STH1IZveYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519958; c=relaxed/simple;
	bh=IgWdstICSsXjuEa4YtQAmHX5uWikGdJsKamOFEMzRLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyWIebQIpbUudTZ3aRt2I5ovFuH2bzCOJJ7ZbwLMWq9fnOcEJaOybhPTb3Yl6YwUKX9fvi606ci7fr7V2E1PFPUQYhphF9cE6KpuZMcluwYWnDRAe3LHppNkbzFZeLkVbH147TzjW0iLD9bg7s9m4opm+TWRIqNUUzc0qNEI+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGCWcnbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B39AC32786;
	Tue,  9 Jul 2024 10:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720519957;
	bh=IgWdstICSsXjuEa4YtQAmHX5uWikGdJsKamOFEMzRLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGCWcnbPQ4ga/kvvoYn4vXbbjufVmKRYpBD3UG4sajUHKazgZJEKqWPKMeAS1+sUG
	 //n0MeOMOQp42aEyQWTZ8KLxZkE+99QMs9DVAyaKp+P1ib4MIjX70CzaIjA69KUGq0
	 k87CvL11YqfX0UmKgbZSLcPWcnER+UK4EAwSbRWK7mY9GZARiRvFNVBCGgzPpuKtC2
	 vLsh9UqxFEjD+qP4iAL8+vaf1E9xHhe0SzciEjZliOcEyYJZeZLVEV/BaYYICTMnUT
	 y+628Z/b2yEu0QVkq590Qb1SjUO0cw5t28oAfWstLWZxrOqrCkVc5VjyYgTcuv2Jd7
	 WTm9miuYLhGeA==
Date: Tue, 9 Jul 2024 11:12:31 +0100
From: Will Deacon <will@kernel.org>
To: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Xu <jeffxu@chromium.org>, Leo Yan <leo.yan@linux.dev>,
	Daniel Stone <daniels@collabora.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] docs: iommu: Drop the stale entry in documentation TOC
Message-ID: <20240709101231.GD12978@willie-the-truck>
References: <20240709101055.27178-1-mark-pk.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709101055.27178-1-mark-pk.tsai@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 09, 2024 at 06:10:30PM +0800, Mark-PK Tsai wrote:
> The Documentation/userspace-api/iommu.rst had been removed,
> so should TOC entry.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20240709190613.3fd8b7ea@canb.auug.org.au/
> Fixes: d926e7c04843 ("docs: iommu: Remove outdated Documentation/userspace-api/iommu.rst") on linux-next
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  Documentation/userspace-api/index.rst | 1 -
>  1 file changed, 1 deletion(-)

No need, I just fixed this as your original change was on top of the
branch. Thanks for the quick response, though!

Will

