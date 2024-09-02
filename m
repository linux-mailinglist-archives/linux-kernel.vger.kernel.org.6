Return-Path: <linux-kernel+bounces-310819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125069681A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C349C2828A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FF5186287;
	Mon,  2 Sep 2024 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d64tsKgi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D7C185B49;
	Mon,  2 Sep 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265428; cv=none; b=U5jheu6g8nAFcBgm8plx7fNFZbd/EMrJ9PSxJKTPVUT1zSEJfc/U7/i84T+OSYcxjIaB5YsxxnT7UyKeudlw0RnW8ucFEzwrXrww/Sa/NfRRdg5NkUWVOYn3dxngF4cfnmxEB4l7X20AO/vpT/ZvHzarPRz6wSN9izAgjeizC1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265428; c=relaxed/simple;
	bh=Vw8owfhCT5NXCuUPrz+ei1KCOX779W7JZ98MuG1X2W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7//hIuO8z7AgFpFkiDvGWYF0Mq7N0zeI8kbW5G+5VZr0y2inVUysLRQSOpfmq04Dvcv1OIQPe8+/9ClxvlB29c81cM/q3pMAev4qp8VoYizBxxJ7O8WYA/bQSbQlZrzQM9jSDsBJxaoYStx7x6n5p7n2nsn8kjxv7EML6XXtH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d64tsKgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBF9C4CEC2;
	Mon,  2 Sep 2024 08:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725265427;
	bh=Vw8owfhCT5NXCuUPrz+ei1KCOX779W7JZ98MuG1X2W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d64tsKgiZzjYTOkitlfnwrz3lEryc10shY3safBerLoybDvdJxIxZI6JfAePdfxFM
	 JkR/vZz0oZIPbL2ebh/dHJrK6NqC3nZCk0C2JM7E4m8Q4K20d/HjomMMc7cxcnAyWm
	 6yc/aQuDkvb/jGkwh5EcDtjAGkk6qY/XccGFxqtRTn52cDQd9bZMQLh+gdH5Z/olDa
	 I8d6qccvCjJQd+mNJL15Oxk1jVghce2qYb9Skawlk5p022ongUnqq3bcAQJV/AueKD
	 kfW0Lx7NvTFW3+iIIYMG3dAd64iTHRQgcEVwxHSPSqQxbS3OqqmdRS80V7vUPhwF2g
	 VHtYP5otX4KzQ==
Date: Mon, 2 Sep 2024 09:23:42 +0100
From: Simon Horman <horms@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, bhe@redhat.com,
	corbet@lwn.net, kernel@gpiccoli.net, linux-kernel@vger.kernel.org,
	stephen.s.brennan@oracle.com, kernel-dev@igalia.com,
	dyoung@redhat.com, vgoyal@redhat.com,
	linux-debuggers@vger.kernel.org
Subject: Re: [PATCH V2] Documentation: Improve crash_kexec_post_notifiers
 description
Message-ID: <20240902082342.GC23170@kernel.org>
References: <20240830182219.485065-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830182219.485065-1-gpiccoli@igalia.com>

On Fri, Aug 30, 2024 at 03:21:00PM -0300, Guilherme G. Piccoli wrote:
> Be more clear about the downsides, the upsides (yes, there are some!)
> and about code that unconditionally sets that.
> 
> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V2: Some wording improvements from Stephen, thanks!
> Also added his review tag.
> 
> V1 link: https://lore.kernel.org/r/20240830140401.458542-1-gpiccoli@igalia.com/
> 
> 
>  Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 

Hi Guilherme,

Some subjective grammar nits.

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index efc52ddc6864..351730108c58 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -913,12 +913,16 @@
>  			the parameter has no effect.
>  
>  	crash_kexec_post_notifiers
> -			Run kdump after running panic-notifiers and dumping
> -			kmsg. This only for the users who doubt kdump always
> -			succeeds in any situation.
> -			Note that this also increases risks of kdump failure,
> -			because some panic notifiers can make the crashed
> -			kernel more unstable.
> +			Only jump to kdump kernel after running the panic
> +			notifiers and dumping kmsg. This option increases the
> +			risks of a kdump failure, since some panic notifiers
> +			can make the crashed kernel more unstable. In the

nit: In the configurations -> In configurations

> +			configurations where kdump may not be reliable,
> +			running the panic notifiers can allow collecting more
> +			data on dmesg, like stack traces from other CPUS or
> +			extra data dumped by panic_print. Notice that some

nit: Notice that -> Note that

> +			code enables this option unconditionally, like

Maybe: some code enables -> some configurations enable

> +			Hyper-V, PowerPC (fadump) and AMD SEV.
>  
>  	crashkernel=size[KMG][@offset[KMG]]
>  			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
> -- 
> 2.46.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

