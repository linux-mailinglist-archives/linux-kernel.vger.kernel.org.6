Return-Path: <linux-kernel+bounces-515091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A22DA35FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB9CC7A5205
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58DD264A91;
	Fri, 14 Feb 2025 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ96pBjj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF243AB7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541878; cv=none; b=pVx/z6TyNkJg1aN1SVgxyV/v8bgaDHK3O2FqLvcUIMpFcjJsdvelpRR9KrPzjukxt6X5OpjoKloXp20Csji9UBIegrvRyLFjd+1l57u+1Hy5YDhRN2wJydHcGL39By6YUEbSUJ7ddae1lPUBarJlEtDw9nZz0Q2s3KMHrOzfGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541878; c=relaxed/simple;
	bh=OAmsH9wXdR9cCoL774VIgncB0RHMbJP2b2IZgPv+F+8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fRBwIYgxwakw8JKm4dOrHCmH/CRbt+pzdWODU9aTrnkg1UV3FEYcLOrMQiHgHLwMlN7TuKknQJxfvspXlKCfm3jPFptv7RiMdp8ykPOxiO7msLQ8aNKTYIuSNCbQENglWtkoWnMKdtGkIaSIN7stUyMtfXqsxF1rup84I+SlGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQ96pBjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F99FC4CED1;
	Fri, 14 Feb 2025 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739541877;
	bh=OAmsH9wXdR9cCoL774VIgncB0RHMbJP2b2IZgPv+F+8=;
	h=Date:From:To:Cc:Subject:From;
	b=XQ96pBjjiIqxEgGDR75mtdrCy825EmAZajcvIuVyGCxcOQ4CtV3fGH7AvL6lHKtW8
	 lI10/7WXLRU6o4BBgdyaLBn1JIYwUC4JzBxyuI+3yUh5bXFpZbqaRP+TgPdsrgcA8K
	 7qV2TyImit40bF28WASYR3iR6381EokbZ2Z/Dt3rJxyTuK0RMpeZU4bk2w+2huVtV9
	 g9/gbGnjvYbE78600SQe6GaPrwboXfAxN7NvRQO+cGZYneAu0ts4gVBCoV0pgPOpUg
	 LE035uZnG0P+6+zdG28YdKaU9j2dQ+awZw0BLV1pETpJtUGld2TR0t6bMP05TDJNwa
	 K35braZjZaphg==
Date: Fri, 14 Feb 2025 14:04:32 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	ojeda@kernel.org
Subject: [GIT PULL] arm64 fixes for -rc3
Message-ID: <20250214140431.GA13374@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

Please pull this batch of arm64 fixes for -rc3. I've provided the usual
summary in the tag but there's nothing particularly major here.

Cheers,

Will

--->8

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 446a8351f160d65a1c5df7097f31c74102ed2bb1:

  arm64: rust: clean Rust 1.85.0 warning using softfloat target (2025-02-13 11:45:49 +0000)

----------------------------------------------------------------
arm64 fixes for -rc3

* Fix kexec and hibernation when using 5-level page-table configuration

* Remove references to non-existent SF8MM4 and SF8MM8 ID register
  fields, hooking up hwcaps for the FPRCVT, F8MM4 and F8MM8 fields
  instead

* Drop unused .ARM.attributes ELF sections

* Fix array indexing when probing CPU cache topology from firmware

* Fix potential use-after-free in AMU initialisation code

* Work around broken GTDT entries by tolerating excessively large timer
  arrays

* Force use of Rust's "softfloat" target to avoid a threatening warning
  about the NEON target feature

* Typo fix in GCS documentation and removal of duplicate Kconfig select

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: Fix 5-level paging support in kexec/hibernate trampoline

Beata Michalska (1):
      arm64: amu: Delay allocating cpumask for AMU FIE support

Lukas Bulwahn (1):
      arm64: Kconfig: Remove selecting replaced HAVE_FUNCTION_GRAPH_RETVAL

Mark Brown (3):
      arm64/gcs: Fix documentation for HWCAP
      arm64/hwcap: Remove stray references to SF8MMx
      arm64: Add missing registrations of hwcaps

Miguel Ojeda (1):
      arm64: rust: clean Rust 1.85.0 warning using softfloat target

Nathan Chancellor (1):
      arm64: Handle .ARM.attributes section in linker scripts

Oliver Upton (1):
      ACPI: GTDT: Relax sanity checking on Platform Timers array count

Radu Rendec (1):
      arm64: cacheinfo: Avoid out-of-bounds write to cacheinfo array

 Documentation/arch/arm64/gcs.rst  |  2 +-
 arch/arm64/Kconfig                |  1 -
 arch/arm64/Makefile               |  4 ++++
 arch/arm64/kernel/cacheinfo.c     | 12 +++++++-----
 arch/arm64/kernel/cpufeature.c    |  5 +++--
 arch/arm64/kernel/topology.c      | 22 ++++++++++------------
 arch/arm64/kernel/vdso/vdso.lds.S |  1 +
 arch/arm64/kernel/vmlinux.lds.S   |  1 +
 arch/arm64/mm/trans_pgd.c         |  7 +++++++
 drivers/acpi/arm64/gtdt.c         | 12 ++++++++----
 10 files changed, 42 insertions(+), 25 deletions(-)

