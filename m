Return-Path: <linux-kernel+bounces-539232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05372A4A246
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC0A3B917E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89761BD01D;
	Fri, 28 Feb 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceuIJu0H"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365927700E;
	Fri, 28 Feb 2025 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769112; cv=none; b=pZse+273Zpc4gs1tgfGE6AvLONBuAMIHPCDsA/67MyX9YG+5zcVS/9L/Dwj0a403+y4w+Oe+AMsRdb4izO3OG6kji6k7N7ugj753T+5Q34vBvViUlHHpdq6zRk1+YldIrcNAc6nkOvLb7cPFH/1KIOCkMRHXPdP54HW+II0pAq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769112; c=relaxed/simple;
	bh=2nqJSYMYL6IRbNwKn2YP04n/nAut2dmHZYUAr64V1hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upBDOeAX5lPtMup0VPNjAA7j1IsZrjZJ3JUnrdSka5+D14MzCxC+AuTx0OmZGjSE3nfADVYnRTFMZ+HrRQvaYujLllCUmcxbuhFKRgh4HZSyuYv2fitLqMNPKF/9upuc7cVnI0gAg6Ajq+OYFhyoYOWMlmWUcTIhS9gOkV40kwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceuIJu0H; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c07b65efeeso228134685a.2;
        Fri, 28 Feb 2025 10:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740769109; x=1741373909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilObZRbvteJemQZcnMxdr4aMyL6PQe/hOyslC6CC6IU=;
        b=ceuIJu0Hi89LFvqg0XpxCXb3juHXzJxe+y3kWx4HDz7HYP2ZDbRpOoQ/1sj847/Clr
         H4BQyfDPBjOtJf4n9qsawXWfvszhqVsbxRdSdml8JJTBVt6Fl2aflTzKAIiVERKk5m7Y
         9bpVckkbmPNW2GKFi4msSFEMWo65E5H7QRM3WRldpdi52+KrRQe78NhWNilR5Vkl8mn9
         Gt36+U5p/PWZXDMteETCVpMhfl7ps2/2HYAx5lrNlsWM0LkyT7Sos6Ugbh0Uc2Rvzl+Q
         sgVfWwuIqAY9Ov/0o29KXSAuDeOOKsJey1gA84msSMbvCqxl4Yp6fNsnfVoxxMEmqvUr
         Fvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740769109; x=1741373909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilObZRbvteJemQZcnMxdr4aMyL6PQe/hOyslC6CC6IU=;
        b=aCokHtDbDcdZaDWy4xzMKRStplp0L5jGeM7bo+XMNMPNF8YBFjSsEktPrrK8ba+I6+
         c105hJdBvVlrBeExX6qDVP3HtYenfvgyKkzaB+VCfD1VM+YrOyNa/Yd0xgnn1Uxrp1CU
         sivjL6ZmiIBAp809qw3rfIeRDlsFcHm4FXSXhLM9x2QErFbF/uqh3qeSBUAicnToWqhL
         ErAXTp8bz81SxEAO4sgumV8vouRgje62iFmPyqtrpu4DjcMMmGldaMZS3Ni7J0H7Mian
         kimtDlYmQnv2n9QGdrbFKDPrlPTknPQg2ajQtmDv8g73GVeVJCBFTI/HW+H5xzaf+wxL
         1AhA==
X-Forwarded-Encrypted: i=1; AJvYcCWQy8JczklURNnTHhKacdgJZqhGw8D8lNBfB59/+YLYOEcoST6TsG5ZxPi/hDvXeoxAbLt89Lc4dL3WKEbiB+U=@vger.kernel.org, AJvYcCXxRF53qF8Fjf1Buf0ALPWK/XxReaFJXUlGijKECANZShcq1yjzEVQM1NMUzFBs02gVCMIDnuPLhox/hDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV6YNrjnAF2BJoI+EXYhEPMI+cMLhaGmurLxE/jRvISLWOxndj
	+WExshuUhdxlkBC/p5g9/bvW8fwmA5dV4839rq0ce5i20usjNGXB
X-Gm-Gg: ASbGncu2MKOTZWA+9Zk9eMd4Rb91aA5MGAcUPpN0k7MoSiLbeP96Qe4YWwgUxV6bOdw
	kJ3NR8LZRGi5C5ik38vD4+4UG9Rgag58KjXLdNlpAMBdLWycYMb6vUFTC+Vi2G3yACO19WPwXW+
	mISWVOkhzi+4VZdl3EoYNxBlGuJJQ8gWLMLDgX+RSbvaeQcLnFqhyDJ2AqRRhn+3CB4/0cnaFwa
	MIsapTqCJcmQgZbFrhWEqpj13rqwHZVtj0e+74kC9d33guHLg4fMVNEu/uO56hSNOehnL/xFtCL
	4zPx1oKYRPOR3+BiCzpcB7Bk7VUXONyf/jP4b0PWf0xpEgTiJAaJ9NDFwwFLBWYq7Sa3EtQwW2g
	o9XRwqvVHSboeH6WJ
X-Google-Smtp-Source: AGHT+IFKyLQ71P/msOTVg2CRZph/67VSs3yjF9OaJDIq2AQmb8zUnEfWVYHQyQUBr+rAheEmG8AviQ==
X-Received: by 2002:a05:6214:2462:b0:6e4:4484:f354 with SMTP id 6a1803df08f44-6e8a0d9747amr77480336d6.38.1740769109013;
        Fri, 28 Feb 2025 10:58:29 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47472432d52sm27466091cf.79.2025.02.28.10.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:58:28 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id E042C1200068;
	Fri, 28 Feb 2025 13:58:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 28 Feb 2025 13:58:27 -0500
X-ME-Sender: <xms:UwfCZ_OiE3sUqQpCPxA0KU2IjvmtgPOfQpV8qRcbmj5FQvZX-JZcKA>
    <xme:UwfCZ5_PvEXTR-RMAlMtTJkrDOVjRi5qZn_R3AzLKbwavTcoBIGS593qDFEm3qxti
    R1qE6yLj-y10vtarQ>
X-ME-Received: <xmr:UwfCZ-SY4ZPzbuNg4eM0AxbreFtf4S1P52zWD8mUxZaamYk_EEQvrJOSxG8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeluddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghho
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepoh
    hjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprh
    gtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:UwfCZztdfpVvECfTrPE0FDEwsUIUyjK7Wj7C-AmOHfK0c13G1ZwpaA>
    <xmx:UwfCZ3d4OIe73dUVrzjrNaS5TYgR3EEwPtJCE9e1MFOHjtwFOXgMQQ>
    <xmx:UwfCZ_3Q4A-Jo7xyYVGCP6YXZ6_4FUjnAnMXOGnvVDmm9iilMqux2A>
    <xmx:UwfCZz_bVUCtEp7WweQcjaetrJKM0sCR58Qt7pXCAunJuCfZqqzzIA>
    <xmx:UwfCZ6_ATVBCOMvlEfa0slaPpTAiNSAJRQaAJ2Fw3eEWWA90mh69iO6x>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 13:58:27 -0500 (EST)
Date: Fri, 28 Feb 2025 10:57:37 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com
Cc: Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: Re: [GIT PULL] LOCKDEP and Rust locking changes for v6.15
Message-ID: <Z8IHIYOnI-DMHlC8@boqun-archlinux>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z76Uk1d4SHPwVD6n@Mac.home>

On Tue, Feb 25, 2025 at 08:12:03PM -0800, Boqun Feng wrote:
> Hi Peter & Ingo,
> 

Ping ;-)

Regards,
Boqun

> Please pull the changes of lockdep and Rust locking for v6.15 into tip.
> 
> The following changes since commit 337369f8ce9e20226402cf139c4f0d3ada7d1705:
> 
>   locking/mutex: Add MUTEX_WARN_ON() into fast path (2025-02-21 20:19:12 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git tags/lockdep-for-tip.2025.02.25
> 
> for you to fetch changes up to 3b5b307cf84ca3a73abe797df31e0efe897411a9:
> 
>   rust: lockdep: Use Pin for all LockClassKey usages (2025-02-25 08:53:08 -0800)
> 
> 
> Regards,
> Boqun
> 
> ----------------------------------------------------------------
> Lockdep changes for v6.15:
> 
> - Fix kernel-doc for rtmutex.
> - Fix lock wait context check on softirq for PREEMPT_RT.
> - Disable KASAN for lockdep to improve debug kernel performance.
> 
> Miscellaneous locking changes for v6.15:
> 
> - Use wake_q for semaphore to avoid wake-up in lock critical sections.
> 
> Rust locking changes for v6.15:
> 
> - Fix the soundness issue around dynamically allocated lock class keys.
> - Add CondVar::wait_interruptible_freezable() to allow freezable waits.
> - Add Guard::lock_ref() to access the lock reference behind a lock
>   guard.
> 
> ----------------------------------------------------------------
> Alice Ryhl (2):
>       rust: sync: Add accessor for the lock behind a given guard
>       rust: sync: condvar: Add wait_interruptible_freezable()
> 
> Boqun Feng (1):
>       rust: sync: lock: Add an example for Guard::lock_ref()
> 
> Mitchell Levy (2):
>       rust: lockdep: Remove support for dynamically allocated LockClassKeys
>       rust: lockdep: Use Pin for all LockClassKey usages
> 
> Randy Dunlap (1):
>       locking/rtmutex: Use struct keyword in kernel-doc comment
> 
> Ryo Takakura (1):
>       lockdep: Fix wait context check on softirq for PREEMPT_RT
> 
> Waiman Long (5):
>       locking/semaphore: Use wake_q to wake up processes outside lock critical section
>       locking/lock_events: Add locking events for rtmutex slow paths
>       locking/lock_events: Add locking events for lockdep
>       locking/lockdep: Disable KASAN instrumentation of lockdep.c
>       locking/lockdep: Add kasan_check_byte() check in lock_acquire()
> 
>  include/linux/bottom_half.h       |  8 +++++
>  kernel/locking/Makefile           |  3 +-
>  kernel/locking/lock_events_list.h | 28 +++++++++++++++++
>  kernel/locking/lockdep.c          | 17 ++++++++++-
>  kernel/locking/rtmutex.c          | 29 ++++++++++++++----
>  kernel/locking/rtmutex_common.h   |  4 +--
>  kernel/locking/semaphore.c        | 13 +++++---
>  kernel/softirq.c                  | 12 ++++++++
>  rust/helpers/helpers.c            |  1 +
>  rust/helpers/sync.c               | 13 ++++++++
>  rust/kernel/sync.rs               | 63 ++++++++++++++++++++++++++++++++-------
>  rust/kernel/sync/condvar.rs       | 28 ++++++++++++++---
>  rust/kernel/sync/lock.rs          | 35 ++++++++++++++++++++--
>  rust/kernel/sync/lock/global.rs   |  5 ++--
>  rust/kernel/sync/poll.rs          |  2 +-
>  rust/kernel/task.rs               |  2 ++
>  rust/kernel/workqueue.rs          |  2 +-
>  17 files changed, 231 insertions(+), 34 deletions(-)
>  create mode 100644 rust/helpers/sync.c

