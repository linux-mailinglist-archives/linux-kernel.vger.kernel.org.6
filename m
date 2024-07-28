Return-Path: <linux-kernel+bounces-264468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C42893E3AA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 07:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8F11C211A1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 05:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEA78F6C;
	Sun, 28 Jul 2024 05:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBDm/HZP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00CB8BEE
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722146311; cv=none; b=pLGgP0dimy8Df77HhLwEEchBnWlT2jC1+tOnl3NNbT/mgJRxSymMSmoHkbasVYqhPGXcMKMRgaHLeKCJpWOE3/pg/mCSH2Fz8AKuuhIqtUghKGh7OVQ83cT5Qwcu4krSQZA/JX3OBO7Bb/bk5tmdpTWblUh5zft8zb75PWDEG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722146311; c=relaxed/simple;
	bh=l4fu/VPqBqd4Eg9e7FeLjCWuP5UxNhkqO9sBMyflRuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4zdgB0+wrjZWLH5568aaGc1Aic51L7DwmvAcpm8aHMMlT881yvPFBDWd/TyzR+mJK4FSuRD5+rBsQkZtbveM6ZcZSkeRIW4qq/s+MILUP7earn+wCN7V7J/xfXkAqyiiz/QqZKxSWeg2+jzVgYqN2wBwwjRYL0KhGvji+UW7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBDm/HZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E79C116B1;
	Sun, 28 Jul 2024 05:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722146310;
	bh=l4fu/VPqBqd4Eg9e7FeLjCWuP5UxNhkqO9sBMyflRuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBDm/HZPOUk6QT+whxR2HASSWZsYcwowzAU2jhucW/jOLLgn7SMSk7BGYjw2UiCKI
	 nHl6l3rEwvu7E/xJB+qdNfCKjD5LchvHe50NSsBc5nqrXRBEhsdYbUg0YVDIWMsaQk
	 XZUYNSK2bRszX78oPIhaaalvWl2YNQfOvASVpK2elDxy2h0z7cVHNQ7VsUEKxYidO1
	 myeewff7UXt0POGGxxiBN+/FnXSqpBtC90zrN3hjqasMCNjrHZ6Sq8gS1fkwkNRrni
	 v+oapMye9DrzaCCh6HWgReiOwkt8HBvV4r6JxdbJ7u5ve/3+nKNmUIKakMQHH+TDV9
	 z6urPxOcLvtuA==
Date: Sun, 28 Jul 2024 08:58:14 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/5] memblock test: fix implicit declaration of function
 'isspace'
Message-ID: <ZqXd9vgalOSI_j3S@kernel.org>
References: <20240725014157.17707-1-richard.weiyang@gmail.com>
 <20240725014157.17707-4-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725014157.17707-4-richard.weiyang@gmail.com>

On Thu, Jul 25, 2024 at 01:41:56AM +0000, Wei Yang wrote:
> Commit 1e4c64b71c9b ("mm/memblock: Add "reserve_mem" to reserved named
> memory at boot up") introduce usage of isspace().
> 
> In kernel source code, memblock.c include the definition by
> debugfs.h/seq_file.h/string_helpers.h/ctype.h. Since it already has
> ctype.h in tools, let complete the include chain to fix the build error.

I think it's enough to include ctype.h in
tools/testing/memblock/linux/kernel.h 

> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  tools/include/linux/debugfs.h        | 2 ++
>  tools/include/linux/seq_file.h       | 2 ++
>  tools/include/linux/string_helpers.h | 8 ++++++++
>  3 files changed, 12 insertions(+)
>  create mode 100644 tools/include/linux/string_helpers.h
> 
> diff --git a/tools/include/linux/debugfs.h b/tools/include/linux/debugfs.h
> index 4ba06140b1be..a99b0e0c5414 100644
> --- a/tools/include/linux/debugfs.h
> +++ b/tools/include/linux/debugfs.h
> @@ -2,4 +2,6 @@
>  #ifndef _TOOLS_DEBUGFS_H
>  #define _TOOLS_DEBUGFS_H
>  
> +#include <linux/seq_file.h>
> +
>  #endif
> diff --git a/tools/include/linux/seq_file.h b/tools/include/linux/seq_file.h
> index f6bc226af0c1..8614fc2ca695 100644
> --- a/tools/include/linux/seq_file.h
> +++ b/tools/include/linux/seq_file.h
> @@ -1,6 +1,8 @@
>  #ifndef _TOOLS_INCLUDE_LINUX_SEQ_FILE_H
>  #define _TOOLS_INCLUDE_LINUX_SEQ_FILE_H
>  
> +#include <linux/string_helpers.h>
> +
>  struct seq_file;
>  
>  #endif /* _TOOLS_INCLUDE_LINUX_SEQ_FILE_H */
> diff --git a/tools/include/linux/string_helpers.h b/tools/include/linux/string_helpers.h
> new file mode 100644
> index 000000000000..bc11a762be8c
> --- /dev/null
> +++ b/tools/include/linux/string_helpers.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TOOLS_INCLUDE_LINUX_STRING_HELPERS_H
> +#define _TOOLS_INCLUDE_LINUX_STRING_HELPERS_H
> +
> +#include <linux/ctype.h>
> +
> +#endif /* _TOOLS_INCLUDE_LINUX_STRING_HELPERS_H */
> +
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

