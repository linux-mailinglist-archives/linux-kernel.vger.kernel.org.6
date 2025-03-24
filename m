Return-Path: <linux-kernel+bounces-573807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E406EA6DCC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66FA8188A6F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A028C25F99B;
	Mon, 24 Mar 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S//D4shh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W7UhmJcU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD0F25F988
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826050; cv=none; b=Xzp8ZjJk5t8LFTSOpseqekDhtVrcY62EFnzoDVJLfmeBw6wk45Gcei9rnoaxB7TZH2utE8FtiqPl3Two9Y5I2v5ZBNSOd9WSS9XuZOWjV+yitAwBY675L3+zL5AIh+b+caz4QG8Yi1t5SZUoOPQWfytIQrhV9itnOPR+wmIOPkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826050; c=relaxed/simple;
	bh=8zRoZAXogwlBji/UWt4mMNr6Uvadh0VBi4dUWDajiYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dssgqp8LzQFDZq2RgB2ejG6WdHVJ8HmU76LJ2C7HIvFJ5kSdefO4xw0zWl3LLTNHbw8z2yJChUQ/RyYE4Lb+NSTP9QWj3TKeVR8JvZWhy6d5/GGanlYJ4f/IgMTZgbStAgUAFSkLV1K2mVlU/DYslcS+e1Wg0Q+VFZpvGDze8TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S//D4shh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W7UhmJcU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Grju03sx9orm1mTdTO1OhdyFiS7PDdSVqz0RDanZY50=;
	b=S//D4shhEB7abU7sf3jOOYz9Gm2VDvYc2pzwy1Tj0BdA+tHrvzRnIS2kFtWx9O4kLTXonQ
	BBYgVSyUbEBIsFTq7+c9XC0rC4BPannnNbtEK8YbQ9eLBHs1oQ1S4U78TJGsHARocg30n1
	E48NkbyB2ohfwlsG2Gq9GleR6JVsTTIwr7iYWpB31qj/Ti4V/4WhgveyKY6gUoVeJfYhav
	PZ6KkYQII8UJHigE30TdMJfyjY4GQeJX3xFqluRPQ3T/tNDm5Tmfj4rczijQgtIzs2578R
	IK4ZIcVT785lPk/fe5ayn3W5yTxJlE4SpDE/SXo6nAqXiIOdZ74KQBgkqlJlEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Grju03sx9orm1mTdTO1OhdyFiS7PDdSVqz0RDanZY50=;
	b=W7UhmJcUThHFs9FALyf/yrWmCGiqA/LUnQHPSdw2ZNAL8SVLVavuDTWlVS29fdoobmX5v/
	hnmlcXxMegNhhRCA==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v3 00/20] tools/x86/kcpuid: Update bitfields to x86-cpuid-db v2.3
Date: Mon, 24 Mar 2025 15:20:21 +0100
Message-ID: <20250324142042.29010-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Update kcpuid's CSV file to latest x86-cpuid-db release. [*]

Changelog v3
------------

* Fix a rebase issue that was detected here:

    https://lore.kernel.org/x86-cpuid/Z9GlyaR-oFEur1zy@lx-t490

  This is now fixed at:

    patch 13/20 ("tools/x86/kcpuid: Consolidate index validity checks")

* Answer HPA's review remark regarding PSN leaf 0x3:

    https://lore.kernel.org/x86-cpuid/Z9qwzVuvV1p6MjRw@lx-t490

Changelog v2
------------

https://lore.kernel.org/x86-cpuid/20250312143738.458507-1-darwi@linutronix.de

* Patches 2, 4->5, 8->10, 13, 14, and 18->19 are new in v2.

* More bug fixes: patches 2, 4-5.

* More refactorings over what's already there at v1, to make the code
  easier to work with.  Patches 8->10, 13.

* Apply Dave Hansen review remark by avoiding explicit vendor detection
  and just trying all CPUID ranges, and see if the CPU responds back with
  something sensible.  Patch 14.

* Apply HPA's review remark regarding Leaf 0x3 not being unique to
  Transmeta.  Patch 19 applies x86-cpuid-db v2.3 release, which has this
  leaf removed and explains why.

* Patches 16->19, apply x86-cpuid-db v2.0 -> v2.3 changes.  One release
  per commit to make the kcpuid CSV diffs more sensible.

Changelog v1
------------

https://lore.kernel.org/x86-cpuid/20250306205000.227399-1-darwi@linutronix.de

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

base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
--
2.48.1

