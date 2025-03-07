Return-Path: <linux-kernel+bounces-551063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C7CA567B2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A041895825
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3501521883E;
	Fri,  7 Mar 2025 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiMFCUkt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E3149E0E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349892; cv=none; b=O468C6MT63xbMG0bYv9rgs/BoDkDTZySSqYEnwKs61KKKPjZt3RNt76muv+j1AEZpKrcNnuf9+iF62YEKdla6eDF8wc5WnqMZ9pew7fFgMppNFlVHz2CWunmHpHoPFseEgruvSKnOrSW7uyZ8XUN4S8vjowzaZR21B37sKPzGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349892; c=relaxed/simple;
	bh=jY1xvZzuil4vzXObEPsCVXmwTty736PivUpjFdzkZKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IzmSOVoUPo1dHzRTa1vZ6EzS7AoUTtfF+4hbdLPtlI88ASH+sccPX6zKs4Hvr8B1nGGT1PKvL6zhJQqXeT4Eif1cd2OdThTbpPuQj1l/8m3olFtD4ksIGLILJ4sBJryhJ1XYjPgZWP5lvvcaVJRTd59JpvTxMEb7/1Bp6JYv65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiMFCUkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD578C4CED1;
	Fri,  7 Mar 2025 12:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741349892;
	bh=jY1xvZzuil4vzXObEPsCVXmwTty736PivUpjFdzkZKQ=;
	h=Date:From:To:Cc:Subject:From;
	b=EiMFCUktA71+ckbTEkhhikZP8E6wDRjrxhy6QN0ZhH07Gb5JmOQ/7ZElwOGBzn9pb
	 ISdESALTODaP9aRf/Nl0NmvXDdhKRpOcKhyF1iiirWPPLtHGCcsUnjbqzBfRrov+L8
	 iJrdGi2QPjtA3yGo+0Ug/fn7ZZquZYNaxI4wxPqQdv1Rm3JCPEpLeeLw/wuZH8Wvt/
	 FJzo+9Mh1dEAeb62hgMlT/WI9KHBwqFspmz6a55QnhRV74V1V5egw01wxomovMPhSl
	 iFgyhkKNAFcCMwOtYNu2tgE9PIRTx/zz3hSqvXGAtQWwCmCGIaZs8sSUeSJG6ygYpX
	 oEj/rxPgbrW1w==
Date: Fri, 7 Mar 2025 13:18:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <Z8rj_-8dP8rH4-9r@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-03-07

   # HEAD: c00b413a96261faef4ce22329153c6abd4acef25 x86/boot: Sanitize boot params before parsing command line

Miscellaneous x86 fixes:

 - Fix CPUID leaf 0x2 parsing bugs
 - Sanitize very early boot parameters to avoid crash
 - Fix size overflows in the SGX code
 - Make CALL_NOSPEC use consistent

 Thanks,

	Ingo

------------------>
Ahmed S. Darwish (3):
      x86/cacheinfo: Validate CPUID leaf 0x2 EDX output
      x86/cpu: Validate CPUID leaf 0x2 EDX output
      x86/cpu: Properly parse CPUID leaf 0x2 TLB descriptor 0x63

Ard Biesheuvel (1):
      x86/boot: Sanitize boot params before parsing command line

Jarkko Sakkinen (1):
      x86/sgx: Fix size overflows in sgx_encl_create()

Pawan Gupta (2):
      x86/speculation: Simplify and make CALL_NOSPEC consistent
      x86/speculation: Add a conditional CS prefix to CALL_NOSPEC


 arch/x86/boot/compressed/pgtable_64.c |  2 ++
 arch/x86/include/asm/nospec-branch.h  | 32 ++++++++++++---------
 arch/x86/kernel/cpu/cacheinfo.c       |  2 +-
 arch/x86/kernel/cpu/intel.c           | 52 +++++++++++++++++++++++------------
 arch/x86/kernel/cpu/sgx/ioctl.c       |  7 +++++
 5 files changed, 64 insertions(+), 31 deletions(-)

