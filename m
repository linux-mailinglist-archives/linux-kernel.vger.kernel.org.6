Return-Path: <linux-kernel+bounces-557886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72641A5DF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C7117B5D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3024BC07;
	Wed, 12 Mar 2025 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AL8xrDbz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yZvOOULF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89AF23A563
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790270; cv=none; b=Dis8j/BZ5T4HpAsI5RHSf4jzXos/8uURdDp5EXJQlfAnbbuRopk5lbtsAMXh/Ovn31k0mcASLmB6jlBiQ2kiRzWUxQiKE6OUqq/K4uyqZQFoTloi9FJRSRdSRfk2KejTMQthVPzzNjpnJ6gejhO2SdFpXx8NEcMVXG10Y6uWuls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790270; c=relaxed/simple;
	bh=pWk1u6nktCDfsuDFB97iZv6hGxXdOmYdE5ZxIUKSv7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q0Xmi5vdgpIsUitUsmN7iIl2WW40ult+a5UJmUrOxWMoV3UiZy/SUQy2/NWk1O9jedrZAtwCevjE6ceqMWFmAoSZmFhRF6CXeWDY3w8t9Kz2HXURV/+ZuSPfnnn/tZiHYXghtO4uGX3HEprAxFMO9S10ApIgJWZizIRe8AYpozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AL8xrDbz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yZvOOULF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741790267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Br1G521yciEAO+u4JXUqFmzPNSVapf2vSvFO6Zzazfc=;
	b=AL8xrDbz9vji+yiS9C6ccFpA+RH0wKGUxYVlD7jv2JU0Q7qqyHtnhyw58BCkHQ/Bb1SlZe
	br5blCR5LKuxng8O9g5Py4r634E9mnwg5wjSQsq+C2o5t8n9fS7nqJjRgDk+65ty35Fw2O
	x3TNxuV5qxGiiKSm6iDlygj85RhS0KGD8ShHEFoGyA/AB6hgFEbBx0kb/SKm8f0q4pVN7F
	7zyegpSc/aXGs0oDeD2Aj9NqTytVDBD8K7S5blLeiO+Fi9UZ0cnUfII8ijYWZ6YcwwrTP+
	rgRjKux62lzHZgmW8C1A+gqZKUiHv45kzMGrUBLGHbBOtCQbYZHkeFmq36iETw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741790267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Br1G521yciEAO+u4JXUqFmzPNSVapf2vSvFO6Zzazfc=;
	b=yZvOOULFmfoAIreFmhxTT/6YpR7o/SamJVZLc3MSYn9+SsysjANLD3tXsxTnQoKXlg+BB+
	crrJ2bCyrA+J9yCw==
To: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 00/20] tools/x86/kcpuid: x86-cpuid-db v2.3 update
Date: Wed, 12 Mar 2025 15:37:17 +0100
Message-ID: <20250312143738.458507-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Update kcpuid's CSV file to latest x86-cpuid-db release. [*]

Changelog v2
------------

* Patches 2, 4->5, 8->10, 13, 14, and 18->19 are new in v2.

* More bug fixes: patches 2, 4-5.

* More refactorings over what's already there at v1, to make the code
  easier to work with.  Patches 8->10, 13.

* Apply Dave Hansen review remark by avoiding explicit vendor detection
  and just trying all CPUID ranges, and see if the CPU responds back with
  something sensible.  Patch 14.

* Apply H. Peter Anvin review remark regarding Leaf 0x3 not being unique
  to Transmeta.  Patch 19 applies x86-cpuid-db v2.3 release, which has
  this leaf removed and explains why.

* Patches 16->19, apply x86-cpuid-db v2.0 -> v2.3 changes.  One release
  per commit to make the kcpuid CSV diffs more sensible.

Thanks!

Changelog v1
------------

https://lkml.kernel.org/r/20250306205000.227399-1-darwi@linutronix.de

This series updates kcpuid's CSV file from v1.0 to v2.2, as generated by
the x86-cpuid-db project. [*]

The new CSV adds multiple new leaves for Transmeta and Centaur/Zhaoxin.
It also introduces new bitfields at leaves 0x7, 0x80000001, 0x80000020,
and 0x80000021.  More details about the CSV changes are at the actual
commit logs.

PQ Summary:

* Patch 1 is a generic kcpuid bugfix.

* Patches 2-4 are preparatory cleanups.

* Patches 5-9 add rudimentary x86 vendor detection and filtering to
  kcpuid, as the CSV file is updated with indices that are exclusive to
  certain CPU vendors.

* Patch 10 updates the CSV file to x86-cpuid-db v2.0.

* Patch 11 updates the CSV file to x86-cpuid-db v2.2.

  Patch 10 and 11 are separated on purpose, to make the CSV commit log
  diffs more sensible.

* Patch 12 puts the whole kcpuid tool under MAINTAINERS' X86 CPUID entry,
  since changes to the CSV file may require updates to the kcpuid code.
  This will also make myself and the x86-cpuid mailing list CCed for all
  future kcpuid patches.

[*] https://gitlab.com/x86-cpuid.org/x86-cpuid-db
    https://x86-cpuid.org

8<-----

Ahmed S. Darwish (20):
  tools/x86/kcpuid: Fix error handling
  tools/x86/kcpuid: Exit the program on invalid parameters
  tools/x86/kcpuid: Simplify usage() handling
  tools/x86/kcpuid: Save CPUID output in an array
  tools/x86/kcpuid: Print correct CPUID output register names
  tools/x86/kcpuid: Remove unused local variable
  tools/x86/kcpuid: Remove unused global variable
  tools/x86/kcpuid: Set function return type to void
  tools/x86/kcpuid: Use C99-style for loops
  tools/x86/kcpuid: Use <cpuid.h> intrinsics
  tools/x86/kcpuid: Refactor CPUID range handling for future expansion
  tools/x86/kcpuid: Extend CPUID index mask macro
  tools/x86/kcpuid: Consolidate index validity checks
  tools/x86/kcpuid: Filter valid CPUID ranges
  tools/x86/kcpuid: Define Transmeta and Centaur index ranges
  tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.0
  tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.1
  tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.2
  tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.3
  MAINTAINERS: Include kcpuid under X86 CPUID DATABASE

 MAINTAINERS                     |   2 +-
 tools/arch/x86/kcpuid/cpuid.csv | 791 ++++++++++++++++++--------------
 tools/arch/x86/kcpuid/kcpuid.c  | 375 ++++++++-------
 3 files changed, 636 insertions(+), 532 deletions(-)

base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
--
2.48.1

