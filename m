Return-Path: <linux-kernel+bounces-535213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF35A47036
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB451646AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4427004D;
	Thu, 27 Feb 2025 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXgHgaqn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE54270042
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616342; cv=none; b=WOtjdbhr186xaV8UqbvwNjSI7F8Q+0x7H2bXkH9JaNpCSbCQ0xgLC3D6z7GW+H1fyMaXedfPWY+k5Vba78Ig/tP+tIVDV1XklkhfEAlK3wHALl9w9bbJ83rsCM+LyLq/DETfKlvMwZS3dHwUPC67gNZIoykC3Ykxvu2ajP/B/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616342; c=relaxed/simple;
	bh=nCr6Ek4/31gn3Vg3fyHay+1KEzWWUzi367J1Ea1oAtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwKoT864Vair5Zya0IDtbfSnvzP/n+SbiMzDfZCDNg+w7s6sqKKYbuvW7zczxETLLmA5CaskSZq9GW9nuv/aC/Hn5JyLCa5R6I/GJ2L2q5OnOlFRQ5/e1E1l9RnkBBbIt9eMPgrS+VHeiiQTYul3NatxlIqeT+cdm/0UA4foKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXgHgaqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A87C4CED6;
	Thu, 27 Feb 2025 00:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740616341;
	bh=nCr6Ek4/31gn3Vg3fyHay+1KEzWWUzi367J1Ea1oAtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXgHgaqnX2vdl0tWNNVXEB7AHnwHuKMbIpCe+C5Gy8Jh2HANj2g1TyeBJP/X/O4D9
	 bB9yHovxJ6+eNjzlTnbTkesYvmhJoMiD/ve8uhjBFd/0UdDYYikxDqktEeRSo+hNMv
	 Quv1N2v1b7zGmJHvYcve2oVo96Gg1djBIiWL3xBlJJK62CgzR2XuO5OOLbeA9e9c1z
	 h9zJDCSNv2mN5EobcLmwA2LBOXDItNaaImvUjQtgbvF4cqYpevN4EJa1ps4T1YgyCL
	 O13YQhWTZqniirz+tNGVxcQjNVfkmgpxzsT1AQvzMSmYrxlb4ZELyQzeTQCO3X6g8/
	 Fd70fvzNMDEYw==
Date: Wed, 26 Feb 2025 16:32:20 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v1] x86/insn: Fix linux/unaligned.h include path
Message-ID: <Z7-ylCsV43noci77@google.com>
References: <20250225193600.90037-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225193600.90037-1-irogers@google.com>

On Tue, Feb 25, 2025 at 11:36:00AM -0800, Ian Rogers wrote:
> tools/arch/x86/include/linux doesn't exist but building is working by
> virtue of a -I. Building using bazel this fails. Use angle brackets to
> include unaligned.h so there isn't an invalid relative include.

Right, it's using tools/include/linux/unaligned.h.

Thanks,
Namhyung

> 
> Fixes: 5f60d5f6bbc1 ("move asm/unaligned.h to linux/unaligned.h")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/arch/x86/lib/insn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> index ab5cdc3337da..e91d4c4e1c16 100644
> --- a/tools/arch/x86/lib/insn.c
> +++ b/tools/arch/x86/lib/insn.c
> @@ -13,7 +13,7 @@
>  #endif
>  #include "../include/asm/inat.h" /* __ignore_sync_check__ */
>  #include "../include/asm/insn.h" /* __ignore_sync_check__ */
> -#include "../include/linux/unaligned.h" /* __ignore_sync_check__ */
> +#include <linux/unaligned.h> /* __ignore_sync_check__ */
>  
>  #include <linux/errno.h>
>  #include <linux/kconfig.h>
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

