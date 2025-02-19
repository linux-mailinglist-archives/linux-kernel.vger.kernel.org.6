Return-Path: <linux-kernel+bounces-521611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE47FA3BFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CAD1885A43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378D61E3DE4;
	Wed, 19 Feb 2025 13:28:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A701CAA95;
	Wed, 19 Feb 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971706; cv=none; b=ixjwraejhmcI7OZGIbxS+rQn7c3+76xPqHN25NOaUFAxsS2pHdSjzYLgLI/HBS4IGZq6BKQ0oL6u7WJljmZIcqO8WT2Ijl+eiv1gUihJQvZgk0laXPys9uJR2Aq+imtgLu+MmN0oskL8IntwYJnBfJlMzh/f+rZqC/fw8QsAR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971706; c=relaxed/simple;
	bh=lMdWoFAhhwD7FG5rhhx9X3bRO5vHcx7dvb5tK7w1qI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWgWosSj9Ye14mhFKG608pcC+t8ntw0ZbHvdvrFenHBUHweMQCwZtYrdmy4AIX9aP4pmEVgG9DSiy/glhHPP48XG7oV7yPjZesTSzFFW5jxMDDglE6NgLuGxm73AronI1futcQ5xhDByaWcWXsIFabCsJcnb+KwQdYR5ckIB+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D88541682;
	Wed, 19 Feb 2025 05:28:42 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DBDD3F59E;
	Wed, 19 Feb 2025 05:28:20 -0800 (PST)
Date: Wed, 19 Feb 2025 13:28:18 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	tony.luck@intel.com, peternewman@google.com, fenghua.yu@intel.com,
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
	daniel.sneddon@linux.intel.com, jpoimboe@kernel.org,
	perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
	xiaoyao.li@intel.com, seanjc@google.com, xin3.li@intel.com,
	andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 01/23] x86/resctrl: Add __init attribute to functions
 called from resctrl_late_init()
Message-ID: <Z7Xccob9B2IMiAXy@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <e946a96a5d161f7b32e84c23c1a0024a31db2898.1737577229.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e946a96a5d161f7b32e84c23c1a0024a31db2898.1737577229.git.babu.moger@amd.com>

Hi,

On Wed, Jan 22, 2025 at 02:20:09PM -0600, Babu Moger wrote:
> resctrl_late_init() has the __init attribute, but some of the functions
> called from it do not have the __init attribute.
> 
> Add the __init attribute to all the functions in the call sequences to
> maintain consistency throughout.

(BTW, did you just find these cases by inspection, or were you getting
build warnings?

Even with CONFIG_DEBUG_SECTION_MISMATCH=y, I struggle to get build
warnings about section mismatches on inlined functions.  Even building
with -fno-inline doesn't flag them all up (though I don't think this
suppresses all inlining).

If you have a way of tracking these cases down automatically, I'd be
interested to know so that I can apply it elsewhere.)

Cheers
---Dave


> 
> Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
> Fixes: def10853930a ("x86/intel_rdt: Add two new resources for L2 Code and Data Prioritization (CDP)")
> Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()")
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

[...]

> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 3d1735ed8d1f..f0a331287979 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -145,7 +145,7 @@ u32 resctrl_arch_system_num_rmid_idx(void)
>   * is always 20 on hsw server parts. The minimum cache bitmask length
>   * allowed for HSW server is always 2 bits. Hardcode all of them.
>   */
> -static inline void cache_alloc_hsw_probe(void)
> +static inline __init void cache_alloc_hsw_probe(void)
>  {
>  	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
>  	struct rdt_resource *r  = &hw_res->r_resctrl;
> @@ -277,7 +277,7 @@ static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)

[...]

