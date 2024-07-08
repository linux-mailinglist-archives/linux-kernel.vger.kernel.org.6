Return-Path: <linux-kernel+bounces-244699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A189F92A811
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4A6B21781
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6AD14BF87;
	Mon,  8 Jul 2024 17:10:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870C148FE0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458607; cv=none; b=nIINzgf6UGcTTYDzRapCq1HzCE5I1LwuHMeWebG5Od1et1EZ4jmhQlQ97t3Y423g07do4TZOsTE08SUdMkVbzuCn/S0cGoA4X/BCER9aBjiaPlqARnEwE98pCNO1sOewxJOPGwwacsCELy9sdu5f8D7/EHAPwC5DDTNdMlIKUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458607; c=relaxed/simple;
	bh=EGd2yo27txc8dxln05GNOEN8Bez164dZrryvSFcCD1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd2cBMPd3qxCwq8H1OpV935SCRclI4iTGJR3TASmxZwSHzkv1W4qqCiYCx0Zrovie8kH2brz8EuRUyVNWeRtEMF4lyUBO21xL4EMhMPbTyEQEbpx4LlCpTonAvAL9vkovf+T/3JPyKHjU8Z38jWZxnAcLgRA6c5Z8e5gwuGwP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA491C4AF0A;
	Mon,  8 Jul 2024 17:10:04 +0000 (UTC)
Date: Mon, 8 Jul 2024 18:10:02 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	vincent.guittot@linaro.org, vanshikonda@os.amperecomputing.com,
	sumitg@nvidia.com, yang@os.amperecomputing.com,
	lihuisong@huawei.com, viresh.kumar@linaro.org, rafael@kernel.org
Subject: Re: [PATCH v6 0/4] Add support for AArch64 AMUv1-based
 arch_freq_get_on_cpu
Message-ID: <ZowdalL3DfkHtaCg@arm.com>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603082154.3830591-1-beata.michalska@arm.com>

Hi Beata,

On Mon, Jun 03, 2024 at 09:21:50AM +0100, Beata Michalska wrote:
> Introducing arm64 specific version of arch_freq_get_on_cpu, cashing on
> existing implementation for FIE and AMUv1 support: the frequency scale
> factor, updated on each sched tick, serves as a base for retrieving
> the frequency for a given CPU, representing an average frequency
> reported between the ticks - thus its accuracy is limited.
> 
> The changes have been rather lightly (due to some limitations) tested on
> an FVP model. Note that some small discrepancies have been observed while
> testing (on the model) and this is currently being investigated, though it
> should not have any significant impact on the overall results.

What's the plan with this series? Are you still investigating those
discrepancies or is it good to go?

-- 
Catalin

