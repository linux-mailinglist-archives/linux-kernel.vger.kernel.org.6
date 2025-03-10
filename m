Return-Path: <linux-kernel+bounces-554956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45017A5A3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D908C1892044
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6782F236428;
	Mon, 10 Mar 2025 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g3laBx+O"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD6235C04;
	Mon, 10 Mar 2025 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634892; cv=none; b=qZc5TRWLA/41DXdpUrWe5qVcfRhgB7LHCGkIQRYHKvJor3DGAkdGF8Ppqj2+jtNKSKaLs8jojg4eJ17yuIpY1rbDSpISHwAUs179J4WgRfrHY8sKoQjnTIRLsVnwNEA6vKvAWXQAR0t1AH7CH1Xihwx5ZIBDFSyNz/2js0j0j+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634892; c=relaxed/simple;
	bh=qiEz4wXFKhuDCoZ/JWv3WXxSepSmO09MsuLs9ZdNhZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV3Nrn8Ffp6ShOm88THbrdoDp+ui/zRlQ/za23i7TT9YyXRTdN68XED90Seg0njONXVv/xa0b35VqGxDW+dvuz1a6UGyLN91CNNcxJ+kA7/Bd/fum/NxyRSpYMknZ6cItvwn5KDusXUtRnfBsFWnIsbslm1N3KLMPKXlKwv+WZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g3laBx+O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vPfN21NRmpQesCJZ8FUWTpIRNYjQP0B32oYDjnXqSnw=; b=g3laBx+O1d+D+vj+9BZHWkp2DN
	lknyUmGlGhbtW0PjoZ2zLU8cEKltFX4QWUnzAxfc5HQtB/bHH1u10ojqI/a+paXbEpv7XStyxe1YV
	ReZ9Upq8M9AzZH78VVPKE3Q7wIvnhg2W/SuI4RbzYhkDhFhIQ6fZgo8xUhAtJaxM7WdtzsARUlUGV
	XCUvO3F/Vy3xaLSnS/RmRVWTXdul6StxsycrRoHb8U3G8opLlSz+WVZC2IvJ44uV6Hosj++oiiTFs
	7agTPPThBupqJBZzHEG+uZ+m+plIO7FIEM+Jw8Ky9Z3xkSXc/lOiK01Cy3NmZEpcDESmdqDLdmbN4
	IjOpx82g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1trinF-00000009G1a-2WUe;
	Mon, 10 Mar 2025 19:28:05 +0000
Date: Mon, 10 Mar 2025 19:28:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: kth <kangtaeho2456@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Fix typo from smpfs to smbfs in filesystem
 documentation
Message-ID: <Z889RfnudqMc5r_e@casper.infradead.org>
References: <20250310184129.328482-1-kangtaeho2456@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310184129.328482-1-kangtaeho2456@gmail.com>

On Tue, Mar 11, 2025 at 02:41:29AM +0800, kth wrote:
> The documentation incorrectly referred to 'smbfs' as 'smpfs'. This change corrects that typo to ensure the documentation is accurate and not misleading.
> 
> Signed-off-by: Kang Taeho <kangtaeho2456@gmail.com>
> ---
>  Documentation/admin-guide/highuid.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/highuid.rst b/Documentation/admin-guide/highuid.rst
> index 6ee70465c0ea..9239067563a1 100644
> --- a/Documentation/admin-guide/highuid.rst
> +++ b/Documentation/admin-guide/highuid.rst
> @@ -64,7 +64,7 @@ What's left to be done for 32-bit UIDs on all Linux architectures:
>  
>    Other filesystems have not been checked yet.
>  
> -- The ncpfs and smpfs filesystems cannot presently use 32-bit UIDs in
> +- The ncpfs and smbfs filesystems cannot presently use 32-bit UIDs in

ncpfs doesn't exist any more; it was removed many years ago.  And the
smbfs that is referred to here was replaced by cifs many years ago.

I have a feeling the entire highuid document should be deleted.  It
describes a transition that happened 25 years ago.

