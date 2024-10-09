Return-Path: <linux-kernel+bounces-356744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B20996611
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB81289650
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60620190074;
	Wed,  9 Oct 2024 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zjluipxj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25718E033;
	Wed,  9 Oct 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467617; cv=none; b=TwqLi98R/m09AGgjvRMDV80JHL5YtqBHz/mTcg/DVitNxDwGdhNVfqcrOH1KnnhGSFcm+ce3Yntw1uWv5jVFj4lPU3uGlmXW+4HremN5nA5Lh4lOrjZ+9AHZP1TqtPCDy0FNsB19LhX0vwJBQIIrcHZiXXIGjdyRVvwx3tuLsb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467617; c=relaxed/simple;
	bh=QkddTRldN7eFwMswfmDcM5kDdt3JQuBNZftn3Nd9/dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARUC3q8+LVlPUfU1/ZNNTtMnsSow38nMSwRGMNi+VAugu86jUyCZcCpFALgnITM72GhaT+rGA+Ix8Oy1vkYvSgvuR4cdD6jPohoyzbsqHq1CwjjeyIXOHs7QAg+h/zwsBG3bOmiCgO/huRNn5cDs1uoJUyPQnuaiOjJfJFR4ahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zjluipxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BDFC4CED1;
	Wed,  9 Oct 2024 09:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728467617;
	bh=QkddTRldN7eFwMswfmDcM5kDdt3JQuBNZftn3Nd9/dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zjluipxjj7haUcdANGBl4lU0DEM31b0XalutjpaWIUZBsz69vv5rcX7otFqkrK1q3
	 nzjhk0jyCGZclirY0Yk0MdyC/h1+LReBTeFXE0s3DYZxJPxLrQLlpNiyuoImhOJDLP
	 CDvf+kv0SeKPPhpea1dIGr0pkmRW8jUXs/JGahag=
Date: Wed, 9 Oct 2024 11:53:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: tdavies@darkphysics.net, philipp.g.hortmann@gmail.com,
	dan.carpenter@linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] staging: rtl8192e: Fix alignment to open
 parentheses
Message-ID: <2024100924-alabaster-exclude-2f02@gregkh>
References: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240920193356.32156-1-dominik.karol.piatkowski@protonmail.com>

On Fri, Sep 20, 2024 at 07:36:17PM +0000, Dominik Karol Piątkowski wrote:
> This series aligns the code to open parentheses to improve readability.
> 
> v2: Split patch into smaller patches and refine them, exclude files conflicting
>     with https://lore.kernel.org/linux-staging/Zung-0ClV_527-_e@kernel-710/T/#t
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>

Sorry, this driver is now deleted from the tree.

greg k-h

