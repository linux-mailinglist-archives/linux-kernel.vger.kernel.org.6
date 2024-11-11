Return-Path: <linux-kernel+bounces-403709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0855C9C395D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8721C21AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED050158536;
	Mon, 11 Nov 2024 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhFzXOBa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F418E1F;
	Mon, 11 Nov 2024 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731312236; cv=none; b=X1W5k+7y+2Hyx4+YZbp3ZqIh36Ep6BA3kSAtXbNEbiSSVPhJ5ky6fUM3IWrRTh0KKj6sBqHG3QZOazmikLlRK0ltl3hIONCtGCJreCDcBuW2AHXsUOgTCuuNnLBgr5pkvSfcBzmaL2ZMDZvPTNOJ8Yn5hKV1/vevnLUQDr26HT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731312236; c=relaxed/simple;
	bh=7MlwKss6b3p5r1xejKaf/UfkY318rQWtxrOA8QDekhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLgzsupQwQrLG33azdEw9CHYIQoAurT0N6r3m7E+V2ui3hIiZLvYS+RiB3NXh8buHnhJRoMeUiDbbXBgzTbDLuNc6Yz1Bbo01XmahAGrRHdYRoL4lbCfQwMnwq/Ced1Oez1zc/E8E85HXZbL9fIXFDPPPQ4cIY660EoXd5LgpXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhFzXOBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313BEC4CED0;
	Mon, 11 Nov 2024 08:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731312235;
	bh=7MlwKss6b3p5r1xejKaf/UfkY318rQWtxrOA8QDekhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PhFzXOBaBPGnsFKyQ2cFFwHX8xothbWKWwJ2i0ZBV19g84ZIysym0DfwGUNuzRDco
	 PC6XmR7LChqhpXRMacD0WxCuuG7RgT/otUrKHEOJLUSZYdLomx4kSc3qAEpbSQBJnY
	 cJ7cMw3m591MBXToYRycqnj2wmSyBxqfpIbK6AdhXOt+LpdN5WQZ/V2YJ8BiV1PsIo
	 2ujyFIj9LGSp22K2yd4mnhYJ4wPb0x9/XWAXfCuGfSSSxC5s+ekRX66XbCjF0RGyPb
	 BLUYkRR4ZZ5RKEuxvMFm1zj55hX9YN1Z8Z9+vpHFlprJD3ssVzpx3FjyTcJTD0ttfd
	 U+OYxr02ttcCw==
Date: Mon, 11 Nov 2024 10:03:39 +0200
From: Mike Rapoport <rppt@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] MAINTAINERS/MEMORY MANAGEMENT: add document files for mm
Message-ID: <ZzG6W5ApOnzwpCP0@kernel.org>
References: <20241101202311.53935-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101202311.53935-1-sj@kernel.org>

On Fri, Nov 01, 2024 at 01:23:10PM -0700, SeongJae Park wrote:
> Memory managment subsystem documents ('admin-guide/mm/' and 'mm/' under
> 'Documentation/') are not marked as managed under memory management
> subsystem.  This makes 'get_maintainer.pl' for changes to the documents
> sub-optimal.  Mark the documents as part of mm subsystem on MAINTAINERS
> file.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a18c2e135cd..2a2e92129646 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14794,6 +14794,8 @@ S:	Maintained
>  W:	http://www.linux-mm.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>  T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
> +F:	Documentation/admin-guide/mm/
> +F:	Documentation/mm/
>  F:	include/linux/gfp.h
>  F:	include/linux/gfp_types.h
>  F:	include/linux/memfd.h
> -- 
> 2.39.5
> 
> 

-- 
Sincerely yours,
Mike.

