Return-Path: <linux-kernel+bounces-263999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C7E93DDAF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 09:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03041F220AB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 07:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5043C08A;
	Sat, 27 Jul 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2KkYHBoh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C552629D;
	Sat, 27 Jul 2024 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722065662; cv=none; b=UVBeYgKWyKYy7kP6CyDTU089ig8DQ1PE3mNVY1qTeM3TP1K/wZIba457rYP0PNfMDPEpMkgI4hl7tK1iUEuyjP05ST/6LUG7qhL4+ZHpi2qekuS4ZEAO5gvyB++qtgpBxFek/cQVnqSnt4ryRs0QzEI/KhHhgQ/SiZ86vP7L44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722065662; c=relaxed/simple;
	bh=7r23hVigX5yYEuu+GOKoXtWqwDOor9/UcEPCOhiQUss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVMzjpRLPR/wscpwQqkmuBVRmh2BMMkTTE8kXQKfp9mGWlDrD0gTUHhVkRXjW07ClmbMxCT6296Tj0qgD/2cfpDDtT/ePXCQJ+YV/KjgNCSt9Mi+71ep98Hz0VbNmA1lW+gAbxa16OcXen4nw92PYRp0v/7N9t+RNYmrbFJUgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2KkYHBoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A975C32781;
	Sat, 27 Jul 2024 07:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722065661;
	bh=7r23hVigX5yYEuu+GOKoXtWqwDOor9/UcEPCOhiQUss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2KkYHBohmuoRZugp57DvOEnbklY0qtbptR/ZrFmcDmyH/eEV3/lClZTDv5IrsO0d8
	 qdo0EqqRWExCHCHM8NECbcROhJbBg4rzCgYgWqg3kRpYLQogSkVJBddvYq4uPnRyir
	 CTDh3QmYLBNcbP/lZc9OOqETuTbZksIRfWWk86ko=
Date: Sat, 27 Jul 2024 09:34:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: CVE-2024-35918: randomize_kstack: Improve entropy diffusion
Message-ID: <2024072746-ample-sponsor-bef6@gregkh>
References: <2024051912-CVE-2024-35918-3fed@gregkh>
 <lsh7xgorp67fplqey6evmukt66tbstbjob34bwyt7wiklkqu3n@6wftjk4z7xja>
 <2024072606-outlet-stuffy-259b@gregkh>
 <D4CED3E9-5E5F-4E94-AB59-3EA617213DA1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D4CED3E9-5E5F-4E94-AB59-3EA617213DA1@kernel.org>

On Fri, Jul 26, 2024 at 07:12:36AM -0700, Kees Cook wrote:
> 
> 
> On July 26, 2024 2:54:25 AM PDT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >On Fri, Jul 26, 2024 at 11:45:59AM +0200, Michal Koutný wrote:
> >> Hello.
> >> 
> >> On Sun, May 19, 2024 at 12:11:12PM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >> > Description
> >> > ===========
> >> > 
> >> > In the Linux kernel, the following vulnerability has been resolved:
> >> > 
> >> > randomize_kstack: Improve entropy diffusion
> >> > 
> >> > The kstack_offset variable was really only ever using the low bits for
> >> > kernel stack offset entropy. Add a ror32() to increase bit diffusion.
> >> > 
> >> > The Linux kernel CVE team has assigned CVE-2024-35918 to this issue.
> >> > 
> >> > 
> >> > Affected and fixed versions
> >> > ===========================
> >> > 
> >> > 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 5.15.155 with commit dfb2ce952143
> >> > 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 6.1.86 with commit e80b4980af26
> >> > 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 6.6.27 with commit 300a2b9c2b28
> >> > 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 6.8.6 with commit 6be74b1e21f8
> >> > 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 6.9 with commit 9c573cd31343
> >> 
> >> The commit
> >> 9c573cd313433 ("randomize_kstack: Improve entropy diffusion") v6.9-rc4~35^2
> >> adds ~2 bits of entropy to stack offsets (+the diffusion, x86_64)
> >> 
> >> The commit
> >> 39218ff4c625d ("stack: Optionally randomize kernel stack offset each syscall") v5.13-rc1~184^2~3
> >> adds ~8 bit of entropy to stack offsets (there was none before, x86_64)
> >> 
> >> Why the former commit has a CVE while the latter doesn't? (2 < 8)
> >> 
> >> I'd expect both to be treated equally or even inversely.
> >
> >If you wish for a CVE to be assigned to 39218ff4c625d, we will be glad
> >to do so, but it was not on our "old list" of GSD entries to backfill in
> >CVE entries for, which is why it was not assigned one.
> 
> I don't think either need a CVE. 39218ff4c625d added a new security
> flaw mitigation. 9c573cd313433 improved it. The original did what it
> said it did, so a CVE wouldn't seem to traditionally apply.

We assigned a CVE to 9c573cd313433 as it was implied by many that this
was "fixing a weakness" in the security feature in 39218ff4c625d.  If
this is not the case, then we can revoke this CVE.

> If adding a new mitigation feature (or improving an old one) means we
> need to issue CVEs against the earlier kernels, this would be a whole
> new class of CVE. (Though I would certainly support it: "your kernel
> is vulnerable because you're not using a new mitigation" is a message
> I've been trying to communicate forever.)

"improving an old one so it actually works" is fixing a vulnerability
(i.e. something that says it works but it wasn't), so those should be
getting a CVE if I am reading the requirements properly.

I too would love to assign CVEs to "a new mitigation feature was added
that you should be using", but I don't think that would fly :(

thanks,

greg k-h

