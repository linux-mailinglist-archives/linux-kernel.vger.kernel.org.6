Return-Path: <linux-kernel+bounces-346632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73BA98C6F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E64B2814F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050121CB334;
	Tue,  1 Oct 2024 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ+fIPeO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5819AA6B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815558; cv=none; b=hTpEQbij5G9KzfVrHzUyDsufdGYRntBCi5picJnKRYIDYvM97zDxADvDc/PEOHFNojV80O3J2epfD2pP+/8wC5foO5uhnVzV1xbCarfccUBogDPsZz695wuF28rEhAAHFdMln8vIJfeVOGWgrZGT2SJ8bzIj409tSSXAk4zn+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815558; c=relaxed/simple;
	bh=PfKF2/5hBsM9be6pEZ9PVtcLyw3N+bJSOU3pavrh4Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1jRq50HlqJJQmvnjrIPq3j2cLyT8bk7jsLm2Tr1qjgk34fd0YGViZsTzJu+4zfbLYPI8y3Uh/ItAepAGOsTDahDRvDsUVJX2+iImEtvusrqAXrQaXyYd568/jzc7fbCAsFKDKDWQFErLcjlnoe6/q0mIFdbO3l7qco1iiFzEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ+fIPeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67EAC4CEC6;
	Tue,  1 Oct 2024 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727815557;
	bh=PfKF2/5hBsM9be6pEZ9PVtcLyw3N+bJSOU3pavrh4Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZ+fIPeOJYb504odN1q6PedN9LD1xDf416YXUAnZ5jygp9+jxUk8U5PlJhtIA1qYb
	 js9OgUeGwe4dl+TlyWGvB6dhyoUFe2B/ipZVhtTbTYNO4CppKcflwlc+kZSccFW3tj
	 N7AqVOXPhiE0Rb9VsFttmHqeQH0ieObmJE9VRKiVp9b9bo5mel6GpEtyYG1GMUjEei
	 CGAFYKYMU5ytwPD871LGiNUVslgQuM3l1a1YCov1fQcqTucjm76t7EAlrZVfs0yu0B
	 DtoDK5QpC6Kbok/3dZhsYsQAaswI57oG8RlfB0A4PaiqBxg++bV0hq79k0xA3a6oya
	 pZ3genRq9pBaA==
Date: Tue, 1 Oct 2024 10:45:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: David Vernet <void@manifault.com>, Josh Don <joshdon@google.com>,
	Hao Luo <haoluo@google.com>, Barret Rhoden <brho@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched_ext: build errors when building flatcg and qmap schedulers
Message-ID: <Zvxfg-Qpn_oO6qTh@slm.duckdns.org>
References: <ZvvfUqRNM4-jYQzH@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvvfUqRNM4-jYQzH@linux.ibm.com>

Hello, Vishal.

On Tue, Oct 01, 2024 at 05:08:58PM +0530, Vishal Chourasia wrote:
> Getting build error when trying to compile example schedulers in
> tools/sched_ext/* (logs shared in the end)
> 
> 
> tools/sched_ext # make -s -k
> 
> 
> git repo state
> $ git log --oneline
> e32cde8d2bd7d (HEAD -> master, origin/master, origin/HEAD) Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext
> 190ecde722dd0 Merge tag 'probes-fixes-v6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
> a5f24c795513f Merge tag 'vfs-6.12-rc2.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
> f801850bc263d netfs: Fix the netfs_folio tracepoint to handle NULL mapping
> 28e8c5c095ec2 netfs: Add folio_queue API documentation
> 2007d28ec0095 bcachefs: rename version -> bversion for big endian builds
> 34820304cc2cd uprobes: fix kernel info leak via "[uprobes]" vma
> 9852d85ec9d49 (tag: v6.12-rc1) Linux 6.12-rc1
> 
> 
> Adding __weak attribute seems to have fixed it and compilation completed
> with no errors.

Hmm... I don't see the failure here. Maybe toolchain difference? Anyways,
can you send the patch to add __weak?

Thanks.

-- 
tejun

