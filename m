Return-Path: <linux-kernel+bounces-362573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E799B68B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9858E283281
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A6824A0;
	Sat, 12 Oct 2024 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbrU/VqF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501A11185
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728756527; cv=none; b=HDYSx+NVAw5uxbvMd3MdJZLukdl72ExOpkqR/529fSBb/IkYc2g5bZt2ycn5bK1d0lJsDyzPOapvxvVyS3aNd/pYUjzUjHuyuw73+CEBhoE8Mn7DqsTu+aA1kThzo+rzsfvUDWkC2kscWY+zMtGC3zrA8yX1cXIzLXDXb1aqRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728756527; c=relaxed/simple;
	bh=AbCbiG6B6HNcCSYqIhI8JlrrmfKWI1KJvGC0RqWMjGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKqLVlGRsVf41+Le3SqwwWzFEJoh3YCNN+R4jZ0O31TmK0bDPeuFx402QvjaxUbadeqgobudCuJFiJ8GBDpepaXyRbkbrPlufuY0r3ZM4UJtH6QzESQyzwJP+orEbB9+s0+C9OAYmJOJiiddUDveh8DB4Ds01dDGFEaZBUyJECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbrU/VqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A028C4CEC6;
	Sat, 12 Oct 2024 18:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728756526;
	bh=AbCbiG6B6HNcCSYqIhI8JlrrmfKWI1KJvGC0RqWMjGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FbrU/VqFvVwK9zytz9QHDRYePcXCHZ1Pkbxv3FiTTQK3Y3lYuvGHZpJjbWOtR5BjV
	 6nVDe3wmmwp2UcGHCyLpGNJSXaqE11RoiuIvYSJkwYQq/zAFZjMIx2w1hwA1fr9Dj4
	 LXdxegt/ChocYm7BT1TLHamGBRP+eaWIqyaeXJTAVkhg1Ej8ON9YbgFp+jx+YIt8o/
	 CCx9rrRC2fFMOpQUFtMf3IAJh+SZyas+bf9x3A6zDdRMkiguddQ2PVSsQdXu+/XdB8
	 S/SJ+FImf2tbMQV8VGVZqhTh5EVul1lY7GWru/m8bBqELe9P+9o8qFsJpXApZMQmFe
	 1hO7teChOp3EA==
Date: Sat, 12 Oct 2024 11:08:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 1/1 fyi] tools headers UAPI: Sync linux/const.h with the
 kernel headers
Message-ID: <Zwq7LEbCluu3caLN@google.com>
References: <ZwltGNJwujKu1Fgn@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwltGNJwujKu1Fgn@x1>

On Fri, Oct 11, 2024 at 03:23:20PM -0300, Arnaldo Carvalho de Melo wrote:
> tldr; Just FYI, I'm carrying this on the perf tools tree.
> 
> Full explanation:
> 
> There used to be no copies, with tools/ code using kernel headers
> directly. From time to time tools/perf/ broke due to legitimate kernel
> hacking. At some point Linus complained about such direct usage. Then we
> adopted the current model.
> 
> The way these headers are used in perf are not restricted to just
> including them to compile something.
> 
> There are sometimes used in scripts that convert defines into string
> tables, etc, so some change may break one of these scripts, or new MSRs
> may use some different #define pattern, etc.
> 
> E.g.:
> 
>   $ ls -1 tools/perf/trace/beauty/*.sh | head -5
>   tools/perf/trace/beauty/arch_errno_names.sh
>   tools/perf/trace/beauty/drm_ioctl.sh
>   tools/perf/trace/beauty/fadvise.sh
>   tools/perf/trace/beauty/fsconfig.sh
>   tools/perf/trace/beauty/fsmount.sh
>   $
>   $ tools/perf/trace/beauty/fadvise.sh
>   static const char *fadvise_advices[] = {
>         [0] = "NORMAL",
>         [1] = "RANDOM",
>         [2] = "SEQUENTIAL",
>         [3] = "WILLNEED",
>         [4] = "DONTNEED",
>         [5] = "NOREUSE",
>   };
>   $
> 
> The tools/perf/check-headers.sh script, part of the tools/ build
> process, points out changes in the original files.
> 
> So its important not to touch the copies in tools/ when doing changes in
> the original kernel headers, that will be done later, when
> check-headers.sh inform about the change to the perf tools hackers.

I think you can mention tools/include/uapi/README. :)

Thanks,
Namhyung

> 
> To pick up the changes in:
> 
>   947697c6f0f75f98 ("uapi: Define GENMASK_U128")
> 
> That causes no changes in tooling, just addresses this perf build
> warning:
> 
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/uapi/linux/const.h include/uapi/linux/const.h
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Yury Norov <yury.norov@gmail.com>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/include/uapi/linux/const.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/include/uapi/linux/const.h b/tools/include/uapi/linux/const.h
> index a429381e7ca507fe..e16be0d37746e14b 100644
> --- a/tools/include/uapi/linux/const.h
> +++ b/tools/include/uapi/linux/const.h
> @@ -28,6 +28,23 @@
>  #define _BITUL(x)	(_UL(1) << (x))
>  #define _BITULL(x)	(_ULL(1) << (x))
>  
> +#if !defined(__ASSEMBLY__)
> +/*
> + * Missing asm support
> + *
> + * __BIT128() would not work in the asm code, as it shifts an
> + * 'unsigned __init128' data type as direct representation of
> + * 128 bit constants is not supported in the gcc compiler, as
> + * they get silently truncated.
> + *
> + * TODO: Please revisit this implementation when gcc compiler
> + * starts representing 128 bit constants directly like long
> + * and unsigned long etc. Subsequently drop the comment for
> + * GENMASK_U128() which would then start supporting asm code.
> + */
> +#define _BIT128(x)	((unsigned __int128)(1) << (x))
> +#endif
> +
>  #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
>  #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
>  
> -- 
> 2.47.0
> 

