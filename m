Return-Path: <linux-kernel+bounces-521687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C533A3C0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D249E16DD63
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7846D1F460B;
	Wed, 19 Feb 2025 13:53:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185B1EDA3E;
	Wed, 19 Feb 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973196; cv=none; b=LC4lY7oPzaTNXcjN+PZzLvdHOJyRpHG5j2Mv4BQQ2IBHUWvFyl0TlXiKA0KWAT3FYHiWrAB+0ZnL0oBwS4mt2YOR+fEi91D3agKDztghd8J94abMdp3LLxZZequbTIAlQhy5PY0PqcFpCouanFFjHsgOScsy9DTnFp9j9IkbLMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973196; c=relaxed/simple;
	bh=hed/3XtNqLZMF2TB+dNF2bvrISbRUf1HE0fX3n91muw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrCSHAK3KdJS5nyNYOfxYR/4PQhy8z/yp6feUfHYnqyS5iwLWzMXYh1K2jDrFeWMHt0gP4oXc+qbfWCMd9CqqHcVjZIrUxHBf4hrayBW18HHOiJktlE1S4wUygfYyz5niJuQwDRIzJrdd0zNQxIJPbRrQM3aWpApcraaatLAAg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBD2B1682;
	Wed, 19 Feb 2025 05:53:31 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7533C3F59E;
	Wed, 19 Feb 2025 05:53:09 -0800 (PST)
Date: Wed, 19 Feb 2025 13:53:07 +0000
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
Subject: Re: [PATCH v11 22/23] x86/resctrl: Introduce interface to list
 assignment states of all the groups
Message-ID: <Z7XiQ+u3Pc+uvJCK@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <52c66bf98480c0ab6bb0f0762497e328fcbdeaac.1737577229.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c66bf98480c0ab6bb0f0762497e328fcbdeaac.1737577229.git.babu.moger@amd.com>

On Wed, Jan 22, 2025 at 02:20:30PM -0600, Babu Moger wrote:
> Provide the interface to list the assignment states of all the resctrl
> groups in mbm_cntr_assign mode.

[...]

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5d305d0ac053..6e29827239e0 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -975,6 +975,81 @@ static ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of,

[...]

> +static int resctrl_mbm_assign_control_show(struct kernfs_open_file *of,
> +					   struct seq_file *s, void *v)
> +{

[...]

> +	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +		seq_printf(s, "%s//", rdtg->kn->name);
> +
> +		sep = false;
> +		list_for_each_entry(dom, &r->mon_domains, hdr.list) {
> +			if (sep)
> +				seq_puts(s, ";");
> +
> +			seq_printf(s, "%d=%s", dom->hdr.id,
> +				   rdtgroup_mon_state_to_str(r, dom, rdtg, str));
> +
> +			sep = true;
> +		}
> +		seq_putc(s, '\n');
> +
> +		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list, mon.crdtgrp_list) {
> +			seq_printf(s, "%s/%s/", rdtg->kn->name, crg->kn->name);
> +
> +			sep = false;
> +			list_for_each_entry(dom, &r->mon_domains, hdr.list) {
> +				if (sep)
> +					seq_puts(s, ";");
> +				seq_printf(s, "%d=%s", dom->hdr.id,
> +					   rdtgroup_mon_state_to_str(r, dom, crg, str));

Unlike the other resctrl files, it looks like the total size of this
data will scale up with the number of existing monitoring groups
and the lengths of the group names (in addition to the number of
monitoring domains).

So, this can easily be more than a page, overflowing internal limits
in the seq_file and kernfs code.

Do we need to track some state between read() calls?  This can be done
by overriding the kernfs .open() and .release() methods and hanging
some state data (or an rdtgroup_file pointer) on of->priv.

Also, if we allow the data to be read out in chunks, then we would
either have to snapshot all the data in one go and stash the unread
tail in the kernel, or we would need to move over to RCU-based
enumeration or similar -- otherwise releasing rdtgroup_mutex in the
middle of the enumeration in order to return data to userspace is going
to be a problem...

> +				sep = true;
> +			}
> +			seq_putc(s, '\n');
> +		}
> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +	return 0;
> +}

[...]

Cheers
---Dave

