Return-Path: <linux-kernel+bounces-331111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0F397A896
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A88B21ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C88015D5B9;
	Mon, 16 Sep 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK5sE+r2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91D0241E7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726520987; cv=none; b=gxHbnFS9+EmhZgi1s0S+jXyMFzUnzcv68EmaygM0zjdpfYuaFNnTWRWTTSov/9g/FcyUTLB/BOcLvBCElLsVJ2Jw+Qr/DwmFYx7IyumafKpf6mIuBggflRLXoGAbXLncyNGL1fLBpKqKkImqGvPaZnnQSJd1nIDvN8jq0dXbWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726520987; c=relaxed/simple;
	bh=xLpYm/Rb1xCBeSImFbP0p3JrCkPA0Jclh/I1JB/dxSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6PvBqb4PXLkjNbOKDZU+cvkIlxSsbSUhSq1sA6007l7AoLpCc6QqRVMxPPHUE7OTolzoYHyTtNQN4IfVuPDSq6L6YWUAvLjSuzu4LOy9OBam3mwlpfQqwUymaiNCPwS9oBJGbVcpKarjmugvzE7kMpBZaAc5KliQKSK17i9Odc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK5sE+r2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8201C4CEC4;
	Mon, 16 Sep 2024 21:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726520986;
	bh=xLpYm/Rb1xCBeSImFbP0p3JrCkPA0Jclh/I1JB/dxSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FK5sE+r2gySnnrXf/sfxIG7dM7wtHRpf3BxaoO6TzH9dLsdQS22yTy2b4bUTVjtLm
	 5OZ1Aq6hvEuSLvrSW7wAA814u3+f0j0C5Tbu12N467kK1NRiZVx+P7L8muKZ/DEtbG
	 OQ0guaEoX/Uk9hkQEqPH/cBsYVZXjY2Oy64oEtUU/g2a1rwCynranEXyonPwLeFMIG
	 /q8l6HGmgHh8EB99NXeLzrWUB9UzKVDJUtuKxVXt15yxZla8lHtq1GIEF8lLUvuDJS
	 I4leuN5wOCkttpKzODVh6HJvUsMJFvUd5JRbBr0p3DeBfMgKzZblZ+dcJikq41s3RS
	 N5sPeK6ZO5qIg==
Date: Mon, 16 Sep 2024 23:09:41 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH] MAINTAINERS: drm/sched: Add new maintainers
Message-ID: <ZuielQSr-1zI-GhD@pollux>
References: <20240916185159.35727-3-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240916185159.35727-3-pstanner@redhat.com>

On Mon, Sep 16, 2024 at 08:52:00PM +0200, Philipp Stanner wrote:
> DRM's GPU scheduler is arguably in need of more intensive maintenance.
> Danilo and Philipp volunteer to help with the maintainership.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Luben Tuikov <ltuikov89@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Acked-by: Danilo Krummrich <dakr@kernel.org>

> 
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 10430778c998..fc2d8bf3ee74 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7710,6 +7710,8 @@ F:	drivers/gpu/drm/xlnx/
>  DRM GPU SCHEDULER
>  M:	Luben Tuikov <ltuikov89@gmail.com>
>  M:	Matthew Brost <matthew.brost@intel.com>
> +M:	Danilo Krummrich <dakr@kernel.org>
> +M:	Philipp Stanner <pstanner@redhat.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> -- 
> 2.46.0
> 

