Return-Path: <linux-kernel+bounces-412736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF579D0E72
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30D81F21E26
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE0194A68;
	Mon, 18 Nov 2024 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOWCYQat"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45572193078
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925539; cv=none; b=Lcs9VNW1fXiLDtm3PsBC6lEd9wipny8VAxLnuFNrWjX7PISYDAfnNTLqyW3k0Bs1M+pkSzzdmwf7zpgVWtPstGWqXuO6EKMWUUGCdAPIT2IyfcpETsjxc+zLAPPY4U5BvPndCvn+hUHk8dUujqyYawVjgTmn9htbWYoP70XXnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925539; c=relaxed/simple;
	bh=8SJzgCI7iBeEsHGsbnAvN71Jw55kfk/vFvh5lJlZsLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G+hKp8fT+jE4/aOq1/Ft7ukpUrx+1rmUkVR8Lfm9wOSkDwmMJTq8XBmnW3eTxkruawx0atxkj5JgaPeObsvyf33gBpGI7L9UzShUmXFq4COe31l9gY4+BrapW5NVFYHjQzAXVe9l0Lj2qKlLmF6RoLxLytUT+6Wg7NRC4+4cudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOWCYQat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F3BC4CECC;
	Mon, 18 Nov 2024 10:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731925538;
	bh=8SJzgCI7iBeEsHGsbnAvN71Jw55kfk/vFvh5lJlZsLI=;
	h=Date:From:To:Cc:Subject:From;
	b=gOWCYQatbyGcx2nSSRRdcfXbQ3dJJ7g/WrPq4Goear3SypOXaG5qdyN70T87/5+Aa
	 5j/4ku1llIYZBW0NTuqlQn0qqSk466IsqQA/JnZynXO5vfWorsL5Tn+3dyxlu5xiiS
	 7UbdI2BabTIOfqGryXRwN2/Cx+TFWqJGS5NJ8cw5+N4O0zPd9U/b8FgKDPlFcOfhmM
	 FugRCiFDlukOyK2Sr8FluHUsTRpGNbR/7SHxJYd2Z7bvxNv96X/sb4kYMS27N2mI8V
	 6QZ6wWa/lmZd1Cxv5t2E5YkHqIL6GKbvHvoxcxECCbSCpX56Cn+Adb530Pa2egQN1A
	 wSLELMZFDpLkA==
Date: Mon, 18 Nov 2024 11:25:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool changes for v6.13
Message-ID: <ZzsWHrSROj-PyQOz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Linus,

Please pull the latest objtool/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2024-11-18

   # HEAD: d5173f7537505315557d8580e3a648f07f17deda objtool: Exclude __tracepoints data from ENDBR checks

Objtool changes for v6.13:

 - Detect non-relocated text references for more robust
   IBT sealing (Josh Poimboeuf)

 - Fix build error when building stripped down
   UAPI headers (HONG Yifan)

 - Exclude __tracepoints data from ENDBR checks to fix
   false positives on clang builds (Peter Zijlstra)

 - Fix ORC unwind for newly forked tasks (Zheng Yejian)

 - Fix readelf related faddr2line regression (Carlos Llamas)

 Thanks,

	Ingo

------------------>
Carlos Llamas (1):
      Revert "scripts/faddr2line: Check only two symbols when calculating symbol size"

HONG Yifan (1):
      objtool: Also include tools/include/uapi

Josh Poimboeuf (1):
      objtool: Detect non-relocated text references

Peter Zijlstra (1):
      objtool: Exclude __tracepoints data from ENDBR checks

Zheng Yejian (1):
      x86/unwind/orc: Fix unwind for newly forked tasks


 arch/x86/kernel/acpi/wakeup_64.S     |   1 +
 arch/x86/kernel/head_64.S            |   1 +
 arch/x86/kernel/unwind_orc.c         |   2 +-
 scripts/faddr2line                   |   2 +-
 tools/objtool/Makefile               |   1 +
 tools/objtool/arch/x86/decode.c      |  15 +++--
 tools/objtool/check.c                | 113 ++++++++++++++++++++---------------
 tools/objtool/include/objtool/arch.h |   1 +
 8 files changed, 81 insertions(+), 55 deletions(-)

