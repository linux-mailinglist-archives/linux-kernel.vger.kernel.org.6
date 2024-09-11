Return-Path: <linux-kernel+bounces-324424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9132974C48
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279E31C22047
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7824713D524;
	Wed, 11 Sep 2024 08:15:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A16813B7AE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042530; cv=none; b=R59AyNhLWwkFRjOOFpDnQVe9hOjJnuJDYh8EeJDFCcgXmIDMxlxNWIcV3sCQxSww8HsBjIAKh8oKOHbIz24KBhb7hQcNk1QFw4SP15u+ElWrPGWcsJ4IktpeA8iq35amNr/M1Qtmz2Tx5+yK/qrjtEAMP8voofeA672naN6710c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042530; c=relaxed/simple;
	bh=iqfPFe/4M5rHQHCFh6x3OrxC00dP11v4QtCNE39YNds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHE+25bQ4s6vYJ4DSgFmY40LVvbEG5jA2ElYFhzcWDHaDL9AoHXFfiZTjfb9M+G5MKlGcPoCIQA9OTM3cKfIDkVGcxR4y1isYQgR/8MukZ5BIy//nS4YWkaf87ubKjQJPhs6ylkAQ10qqQ8U8m6An1t1B6LNzpzSoYvUnSJk9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E7AE1007;
	Wed, 11 Sep 2024 01:15:57 -0700 (PDT)
Received: from [10.57.50.106] (unknown [10.57.50.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A83AF3F66E;
	Wed, 11 Sep 2024 01:15:26 -0700 (PDT)
Message-ID: <f9d838d5-6b3d-4e7c-9bf6-cb2935320467@arm.com>
Date: Wed, 11 Sep 2024 09:15:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:sched/core 69/70] drivers/cpufreq/cppc_cpufreq.c:227:20:
 error: use of undeclared identifier 'NSER_PER_MSEC'
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <202409110611.dmyDCkoe-lkp@intel.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <202409110611.dmyDCkoe-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 23:20, kernel test robot wrote:
> Hi Christian,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> head:   6cbbb91711c6b17da3802a3cf072d3311828ca33
> commit: b3a47ff095544af206b8885391a7bad662d06a57 [69/70] cpufreq/cppc: Use NSEC_PER_MSEC for deadline task
> config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20240911/202409110611.dmyDCkoe-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bf684034844c660b778f0eba103582f582b710c9)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240911/202409110611.dmyDCkoe-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409110611.dmyDCkoe-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/cpufreq/cppc_cpufreq.c:227:20: error: use of undeclared identifier 'NSER_PER_MSEC'
>      227 |                 .sched_runtime  = NSER_PER_MSEC,
>          |                                   ^
>>> drivers/cpufreq/cppc_cpufreq.c:229:3: error: member reference base type 'long' is not a structure or union
>      228 |                 .sched_deadline = 10 * NSEC_PER_MSEC
>          |                                        ~~~~~~~~~~~~~
>      229 |                 .sched_period   = 10 * NSEC_PER_MSEC,
>          |                 ^~~~~~~~~~~~~
>    2 errors generated.
> 
> 
> vim +/NSER_PER_MSEC +227 drivers/cpufreq/cppc_cpufreq.c
> 
>    215	
>    216	static void __init cppc_freq_invariance_init(void)
>    217	{
>    218		struct sched_attr attr = {
>    219			.size		= sizeof(struct sched_attr),
>    220			.sched_policy	= SCHED_DEADLINE,
>    221			.sched_nice	= 0,
>    222			.sched_priority	= 0,
>    223			/*
>    224			 * Fake (unused) bandwidth; workaround to "fix"
>    225			 * priority inheritance.
>    226			 */
>  > 227			.sched_runtime	= NSER_PER_MSEC,

Sorry, seems I enabled the module, but didn't actually build modules
before sending it out, anyway this should be s/NSER/NSEC

>    228			.sched_deadline = 10 * NSEC_PER_MSEC
and this is missing a comma.
Peter do you mind fixing that up for me?

-->8--

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index aff25b598ec4..1a5ad184d28f 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -224,8 +224,8 @@ static void __init cppc_freq_invariance_init(void)
                 * Fake (unused) bandwidth; workaround to "fix"
                 * priority inheritance.
                 */
-               .sched_runtime  = NSER_PER_MSEC,
-               .sched_deadline = 10 * NSEC_PER_MSEC
+               .sched_runtime  = NSEC_PER_MSEC,
+               .sched_deadline = 10 * NSEC_PER_MSEC,
                .sched_period   = 10 * NSEC_PER_MSEC,
        };
        int ret;


