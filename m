Return-Path: <linux-kernel+bounces-526135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6680EA3FA72
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC49188F30F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B521765B;
	Fri, 21 Feb 2025 16:01:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC31F3D31;
	Fri, 21 Feb 2025 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153668; cv=none; b=NJ6FqmKmXxssh7nUr97tPI19G2t8oczFvWKjlAAw6SKeGim8Pzo7CH2NqBzgoAKujeWZk4HnXDhkz2MuPRAmb6eylCkFklpI163HgABgItVL4IA82d70msCsTtaXi9SrhGFwZevLYKZugWgjMhQPVxPtmB+pAiwJD3MCXMrNYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153668; c=relaxed/simple;
	bh=RMa4BUecR5GYwSWEYE3fngk+ccDPuCm2p2dZu8+mFPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKxJIb0LkQc1ujk1Jc2brHOu0ad7OObQTYmaisy9fk8S1Q2oN91speylizEsRb2eVqWqg5xZ9dexbSp+Uw3dznUplHDL921hBA7sTY3q2TFXjFx1We4Y3Goaz5Y5AI6iiYBn0B3sZR1ieZA3ELWJM5uIkdbuqFV6b1D2i8happE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D088168F;
	Fri, 21 Feb 2025 08:01:22 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C6093F5A1;
	Fri, 21 Feb 2025 08:00:55 -0800 (PST)
Date: Fri, 21 Feb 2025 16:00:49 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	tony.luck@intel.com, peternewman@google.com, x86@kernel.org,
	hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
	thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
	jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 22/23] x86/resctrl: Introduce interface to list
 assignment states of all the groups
Message-ID: <Z7ijCphcSM58AqA6@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <52c66bf98480c0ab6bb0f0762497e328fcbdeaac.1737577229.git.babu.moger@amd.com>
 <Z7XiQ+u3Pc+uvJCK@e133380.arm.com>
 <45a0a88a-b31e-447e-9d62-bc0cdedf06f7@amd.com>
 <Z7dN2KpsQjVUb3KR@e133380.arm.com>
 <7802f9e9-9a63-463d-a51e-e9ad0e60f77f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7802f9e9-9a63-463d-a51e-e9ad0e60f77f@amd.com>

On Thu, Feb 20, 2025 at 03:29:12PM -0600, Moger, Babu wrote:
> Hi Dave,
> 
> On 2/20/25 09:44, Dave Martin wrote:
> > Hi,
> > 
> > On Wed, Feb 19, 2025 at 03:09:51PM -0600, Moger, Babu wrote:

[...]

> >> Good catch.
> >>
> >> I see similar buffer overflow is handled by calling seq_buf_clear()
> >> (look at process_durations() or in show_user_instructions()).
> >>
> >> How about handling this by calling rdt_last_cmd_clear() before printing
> >> each group?
> > 
> > Does this work?
> > 
> > Once seq_buf_has_overflowed() returns nonzero, data has been lost, no?
> > So far as I can see, show_user_instructions() just gives up on printing
> > the affected line, while process_durations() tries to anticipate
> > overflow and prints out the accumulated text to dmesg before clearing
> > the buffer.
> 
> Yea. Agree,
> 
> > 
> > In our case, we cannot send more data to userspace than was requested
> > in the read() call, so we might have nowhere to drain the seq_buf
> > contents to in order to free up space.
> > 
> > sysfs "expects" userspace to do a big enough read() that this problem
> > doesn't happen.  In practice this is OK because people usually read
> > through a buffered I/O layer like stdio, and in realistic
> > implementations the user-side I/O buffer is large enough to hide this
> > issue.
> > 
> > But mbm_assign_control data is dynamically generated and potentially
> > much bigger than a typical sysfs file.
> 
> I have no idea how to handle this case. We may have to live with this
> problem. Let us know if there are any ideas.

I think the current implication is that this will work for now provided
that the generated text fits in a page.


Reinette, what's your view on accepting this limitation in the interest
of stabilising this series, and tidying up this corner case later?

As for writes to this file, we're unlikely to hit the limit unless
there are a lot of RMIDs available and many groups with excessively
long names.

This looks perfectly fixable, but it might be better to settle the
design of this series first before we worry too much about it.

[...]

Cheers
---Dave

