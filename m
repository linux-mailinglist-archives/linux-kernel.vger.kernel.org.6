Return-Path: <linux-kernel+bounces-554489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF25A59892
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5227F188E599
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DFD234971;
	Mon, 10 Mar 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QztsViFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A22343C2;
	Mon, 10 Mar 2025 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618387; cv=none; b=nhWLIXk238IM3usQyOsEIoCJA4rHTCtFXxg0gPzPO6yYeW09Rvi34IVvi53SRLBhEjqm5rdkTqjs74nb9iCDxom7KALn81L1eLpNsp445QOZaf1ujJ64Qo7IIoHLgMVR8UwEWa4ThC7P+O04S7wCEbn4+EQFRcDrhaVMNhhjOIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618387; c=relaxed/simple;
	bh=D3WRzyViP5CwXWPVNCkRgWmmTl0fcipekqVEQBW/ONc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2A0EmC8wmayc3mWTtwvJBfggUe3p393yyVOh/K8bDoi9Pg0N3whfvOvewGs0SZ3j4eZUybjs+58zSk5LIwu6Kn9mJfePrzUYSKASzl68TmdTidKQCtkYhS/83YpRiuAjA0/XIB9QgC5TIg4RO9LuKa0ERHezjd5MFSq4KgV3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QztsViFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B874C4CEFD;
	Mon, 10 Mar 2025 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741618387;
	bh=D3WRzyViP5CwXWPVNCkRgWmmTl0fcipekqVEQBW/ONc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QztsViFE6EE/c4uYNqxmeRiOe2taN8KHza+9hsI3T4CWm1AqFlx//Jcl39OVJZyf9
	 zoPCAXKOiomZTyKSRrORbtYdMThU2/KhF4at0OkzufHLA/VOh3T4xgLYqjckwfPFhH
	 UsCrWf2CujzLkEVkzBSUqKIBCDAY+Q0BmA9Db1gUpqj30muu6N/De2UC3fjLcNggkm
	 nxWtjxrCosa81MZLtxu+i8YdplF34XKszReFnqu2xb9EFImkrfhNwcMqox0R1dufCL
	 MFwbzYDODWi4f5033F1CalleV9tatoDKUgFFJGQJu9Usfo+xV+lSFw0XLJcYTfdq17
	 UFtM4r+odhLgA==
Date: Mon, 10 Mar 2025 15:53:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Yury Norov
 <yury.norov@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, Akira
 Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
Message-ID: <20250310155301.6db5033c@foz.lan>
In-Reply-To: <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
	<f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri,  7 Mar 2025 13:04:51 +0530
Viresh Kumar <viresh.kumar@linaro.org> escreveu:

> This fixes various kernel-doc formatting errors in cpumask.h:
> 
> - WARNING: Inline literal start-string without end-string.
> - ERROR: Unexpected indentation.
> - ERROR: Unknown target name: "gfp".
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/cpumask.h | 65 +++++++++++++++++++++--------------------
>  1 file changed, 34 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 36a890d0dd57..8b53e01dbd97 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -20,7 +20,7 @@
>   * cpumask_pr_args - printf args to output a cpumask
>   * @maskp: cpumask to be printed
>   *
> - * Can be used to provide arguments for '%*pb[l]' when printing a cpumask.
> + * Can be used to provide arguments for '%*pb [l]' when printing a cpumask.


The best here would be to use, instead:

	 * Can be used to provide arguments for ``*pb[l]`` when printing a cpumask.

Which would be converted to this ReST notation:

	    Can be used to provide arguments for ``*pb[l]`` when printing a cpumask.

which is what it would be expected when converted to html/pdf.



>   */
>  #define cpumask_pr_args(maskp)		nr_cpu_ids, cpumask_bits(maskp)
>  
> @@ -166,7 +166,7 @@ static __always_inline unsigned int cpumask_first_zero(const struct cpumask *src
>  }
>  
>  /**
> - * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
> + * cpumask_first_and - return the first cpu from *@srcp1 & *@srcp2

I don't think this would produce the right output. See my other comment.

See, if I add this there:

	 * cpumask_first_and - return the first cpu from ``*srcp1`` & @srcp2 & *@srp3

The kernel-doc output is:

	.. c:function:: unsigned int cpumask_first_and (const struct cpumask *srcp1, const struct cpumask *srcp2)

	   return the first cpu from ``*srcp1`` & **srcp2** & ***srp3**

e.g.:

- srcp1: will not be bold, but it will use a monospaced font and will have 
	 an asterisk;

- srcp2: will be bold, without asterisk;

- srcp3: violates ReST spec: different versions may show it different
         and warnings may be issued.


Thanks,
Mauro

