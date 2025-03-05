Return-Path: <linux-kernel+bounces-546817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1368BA4FF09
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CF23AD230
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3D5245029;
	Wed,  5 Mar 2025 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3qGgYXS6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qRd22s+T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0C2441A0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179275; cv=none; b=Ht5T406us9zmtDCZKZvB4PpLjGfY0kgiFAYAUHHE9TWQnldzU0u4ydsGdooUeaAfoibPgygnAbRDJUEfifiHQ8gw2GAYwkauS6F2U7grUUCMy1hp5X3s57RNYgIN7lrEtjrVgjD5UMqThcJ7BSEKCMrfrh5Q4XIxTHNapeWAYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179275; c=relaxed/simple;
	bh=1uHOtA+1x+X2/3JsOt1A7fS7NTRJcAIpEia1iDZCyII=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hevb9Ug8o6XZPH+yM0K22E6y8fqC/eP0al1fjbQ5hDe1WGEtvOLOuTXnd0lvsYjgHoEHOHGKGRlIuCuOQSsZWNpg3CbfWVSXIjQpwsFtfM0MOmLP9l5CS9tBD2op7rri3krXRTVWuSTm58u1/VrdDXKnRdXGTP6kh2gZzdDXl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3qGgYXS6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qRd22s+T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Mar 2025 13:54:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741179271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=NPyfm8At3FUwyGKhvUJnUfZWkt79ldnXvvjC3pefZf8=;
	b=3qGgYXS6ytQPd3y7JpSVzDj1HoyB8OxBFtuP6d3hoHLOo5zzks0hrEO8xu1fHRFsmWPkqq
	4t9+anFT7/zFGzQq1nRrfQoHwHR4/FsOKWeExMCm7RMs3AnS60pGb1oDGHfOMB+r4IxFeK
	XobigABNlurVzgkHpXzLOAwddxfmdLLk0mlHR613OcA1DEY4yegGTdN/V0ZN7r//Mu+Esq
	flDdiZrPYDuHCg0BkgANJ7Ym/oOBG/6kTcHeUC/rzWf0uziOvB56Ft3+cEvI7vs//QRMQU
	mzZrrzKbS5CAn4djY0mkJg6E+iA2syMUpoAwxtIokqMuJno3K+n9vujLtVsAFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741179271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=NPyfm8At3FUwyGKhvUJnUfZWkt79ldnXvvjC3pefZf8=;
	b=qRd22s+TdLo3Gtt0fAH+gF1q97osj9G5T0hk41hlxA8RCa/rBpm4em1uXeHF6GoLR9wn+k
	IiPnT2/5sJ5yRQAw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: x86-cpuid@lists.linux.dev, Borislav Petkov <bp@alien8.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Avadhut Naik <avadhut.naik@amd.com>, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] x86-cpuid-db: Release v2.1
Message-ID: <Z8hJhgGVduJWFqRE@lx-t490>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm happy to announce release 2.1 of the x86-cpuid-db project:

  https://gitlab.com/x86-cpuid.org/x86-cpuid-db
  https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/releases/v2.1

Changelog v2.1
--------------

- Add spellchecking and x86 terminology style enforcement for all CPUID
  bitfield descriptions in the XML database.  Build multiple x86
  specific hunspell(5) dictionary and affix files for such enforcement.

- Use such logic to standardize the style for x86 trademarks, registers,
  opcodes, byte units, hexadecimal digits, and x86 abbreviated and
  non-abbreviated technical terms.

- Similarly, refuse abbreviated terms that might be OK in code but not
  in official listings (e.g., "addr", "instr", "reg", "virt", etc.)

- Introduce scripts/spellcheck_xml.sh to automate the hunspell
  invocation, and add it to the project's CI pipeline.

- Update the CPUID database:

  - Leaf 0xd: Apply vendor fixes from Andrew Cooper (Xen / Citrix)

  - Leaf 0x80000020/0x80000021: Add new Zen5 SoC bits.  Thanks to
    Avadhut Naik (AMD).

  - Leaf 0x7: Add new NMI source reporting bit.  Thanks to Sohil
    Mehta (Intel).

  - All leaves: Fix all issues identified by the new hunspell(5)
    pipeline.

Release coverage
----------------

  CPUID leaves:        63 leaves
  CPUID bitfields:     918 entries

Artifacts
---------

The generated CSV and C header files can be quickly checked in full from
the release artifacts at:

  https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/releases/v2.1

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH

