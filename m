Return-Path: <linux-kernel+bounces-524038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8516A3DE53
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11D518894AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84D41FCF7D;
	Thu, 20 Feb 2025 15:21:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994411D5CFB;
	Thu, 20 Feb 2025 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064904; cv=none; b=F6TVKWSpsZk7baisne5kYyCZCvZ5WkDB6TKGvfPPC7/ShGB7AZmZbGNPkoFvID31gwuXulQq3l5NiHQng7x8IQhsWW4mHuhmlIUEfvIJS0pveKWAqsVGJadGstUuCNhGxDUiSvQfrxcYFK4tCTD5rqWbG3QZxf4GBvKA08mR8SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064904; c=relaxed/simple;
	bh=1BJ3GLEeXmNh1bHUd2EtF6UaEHncLJ80UUAwqY7Rlz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRVwMgicGKB6Ky3iaJ4lTMGtxUwnPikh1STxJudbw13BLE/hluLBWL7xX912QpOuYQVAYuevVQfw2CMe2i/t9bvNxSuhcZn9n50v7reSPe1CrcEzurjKuhdMpLOTNujXvigLfCr2o+GuUxUFpN2Tcmm5QWargQwqe+iyfEMJoV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE06116F3;
	Thu, 20 Feb 2025 07:21:58 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14F8B3F59E;
	Thu, 20 Feb 2025 07:21:35 -0800 (PST)
Date: Thu, 20 Feb 2025 15:21:33 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <bmoger@amd.com>
Cc: Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
	reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, tony.luck@intel.com,
	peternewman@google.com, x86@kernel.org, hpa@zytor.com,
	paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
	rostedt@goodmis.org, xiongwei.song@windriver.com,
	pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
	jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
	kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
	xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
	mario.limonciello@amd.com, james.morse@arm.com,
	tan.shaopeng@fujitsu.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
	eranian@google.com
Subject: Re: [PATCH v11 23/23] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Message-ID: <Z7dIfWAk+f4Gc54X@e133380.arm.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <fe1c0c4cebd353ccb3e588d7ea2fe9ef3dff0ef2.1737577229.git.babu.moger@amd.com>
 <Z7YBxNIWb7dqOnfi@e133380.arm.com>
 <1ccb907b-e8c9-4997-bc45-4a457ee84494@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ccb907b-e8c9-4997-bc45-4a457ee84494@amd.com>

Hi,

On Wed, Feb 19, 2025 at 06:34:42PM -0600, Moger, Babu wrote:
> Hi Dave,
> 
> On 2/19/2025 10:07 AM, Dave Martin wrote:
> > Hi,
> > 
> > On Wed, Jan 22, 2025 at 02:20:31PM -0600, Babu Moger wrote:

> > [...]
> > 
> > > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > index 6e29827239e0..299839bcf23f 100644
> > > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > > @@ -1050,6 +1050,244 @@ static int resctrl_mbm_assign_control_show(struct kernfs_open_file *of,
> > 
> > [...]
> > 
> > > +static ssize_t resctrl_mbm_assign_control_write(struct kernfs_open_file *of,
> > > +						char *buf, size_t nbytes, loff_t off)
> > > +{

[...]

> > > +	while ((token = strsep(&buf, "\n")) != NULL) {
> > > +		/*
> > > +		 * The write command follows the following format:
> > > +		 * “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
> > > +		 * Extract the CTRL_MON group.
> > > +		 */
> > > +		cmon_grp = strsep(&token, "/");
> > > +
> > 
> > As when reading this file, I think that the data can grow larger than a
> > page and get split into multiple write() calls.
> > 
> > I don't currently think the file needs to be redesigned, but there are
> > some concerns about how userspace will work with it that need to be
> > sorted out.
> > 
> > Every monitoring group can contribute a line to this file:
> > 
> > 	CTRL_GROUP / MON_GROUP / DOMAIN = [t][l] [ ; DOMAIN = [t][l] ]* LF
> > 
> > so, 2 * (NAME_MAX + 1) + NUM_DOMAINS * 5 - 1 + 1
> > 
> > NAME_MAX on Linux is 255, so with, say, up to 16 domains, that's about
> > 600 bytes per monitoring group in the worst case.
> > 
> > We don't need to have many control and monitoring groups for this to
> > grow potentially over 4K.
> > 
> > 
> > We could simply place a limit on how much userspace is allowed to write
> > to this file in one go, although this restriction feels difficult for
> > userspace to follow -- but maybe this is workable in the short term, on
> > current systems (?)
> > 
> > Otherwise, since we expect this interface to be written using scripting
> > languages, I think we need to be prepared to accept fully-buffered
> > I/O.  That means that the data may be cut at random places, not
> > necessarily at newlines.  (For smaller files such as schemata this is
> > not such an issue, since the whole file is likely to be small enough to
> > fit into the default stdio buffers -- this is how sysfs gets away with
> > it IIUC.)
> > 
> > For fully-buffered I/O, we may have to cache an incomplete line in
> > between write() calls.  If there is a dangling incomplete line when the
> > file is closed then it is hard to tell userspace, because people often
> > don't bother to check the return value of close(), fclose() etc.
> > However, since it's an ABI violation for userspace to end this file
> > with a partial line, I think it's sufficient to report that via
> > last_cmd_status.  (Making close() return -EIO still seems a good idea
> > though, just in case userspace is listening.)
> 
> Seems like we can add a check in resctrl_mbm_assign_control_write() to
> compare nbytes > PAGE_SIZE.

This might be a reasonable stopgap approach, if we are confident that the
number of RMIDs and monitoring domains is small enough on known
platforms that the problem is unlikely to be hit.  I can't really judge
on this.

> But do we really need this? I have no way of testing this. Help me
> understand.

It's easy to demonatrate this using the schemata file (which works in a
similar way).  Open f in /sys/fs/resctrl/schemata, then:

	int n = 0;

	for (n = 0; n < 1000; n++)
		if (fputs("MB:0=100;1=100\n", f) == EOF)
			fprintf(stderr, "Failed on interation %d\n", n);

This will succeed a certain number of times (272, for me) and then fail
when the stdio buffer for f overflows, triggering a write().

Putting an explicit fflush() after every fputs() call (or doing a
setlinebuf(f) before the loop) makes it work.  But this is awkward and
unexpected for the user, and doing the right thing from a scripting
language may be tricky.

In this example I am doing something a bit artificial -- we don't
officially say what happens when a pre-opened schemata file handle is
reused in this way, AFAICT.  But for mbm_assign_control it is
legitimate to write many lines, and we can hit this kind of problem.


I'll leave it to others to judge whether we _need_ to fix this, but it
feels like a problem waiting to happen.


> All these file operations go thru generic call kernfs_fop_write_iter().
> Doesn't it take care of buffer check and overflow?

No, this is called for each iovec segment (where userspace used one of
the iovec based I/O syscalls).  But there is no buffering or
concatenation of the data read in: each segment gets passed down to the
individual kernfs_file_operations write method for the file:

	len = ops->write(of, buf, len, iocb->ki_pos)

calls down to

	resctrl_mbm_assign_control_write(of, buf, len, iocb->ki_pos).


I'll try to port my buffering hack on top of the series -- that should
help to illustrate what I mean.

Cheers
---Dave

