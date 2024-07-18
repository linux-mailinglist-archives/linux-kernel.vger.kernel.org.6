Return-Path: <linux-kernel+bounces-256226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68467934B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CF01C21BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CACB82866;
	Thu, 18 Jul 2024 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="dW4Kbg8L"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8798002E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721295568; cv=none; b=thDEz/tYJmi4uP1f61Us5tTQnQgnwF7Aszi7Rh/AWZpdc3w3v+DUM56wjtxgVOjB9PBFTGAN2pBV+SWXjslxKzBrArRyHQJsqWKU0koRowkrcBdNFIrTyADh9Gm7wzwEQNYnh/ny+p5vswASmlew/tfr1vRdVNi3VrJUxII3otQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721295568; c=relaxed/simple;
	bh=Qkdjuh70RCJPvujNbOCNmR9yHLaw3LN+OKruVzEdynk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=lcknqP5hnYojKB2VqEG1zAB5N+V0RKtbU12LC1p0Z5nFksU+XdEmcR8PRnB0wIKcfDAqPL4DlIbzeEzSs29q0FdHYUBp/HashcbKoFhshBftwVBzWrQ995uJr1Is1SxefyKW3RyDw4XW/cJkQ6geg2cFpa8bY04NSOZtASJ5WcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=dW4Kbg8L; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id E194542A6F;
	Thu, 18 Jul 2024 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1721295556;
	bh=Qkdjuh70RCJPvujNbOCNmR9yHLaw3LN+OKruVzEdynk=;
	h=Date:To:From:Subject:Cc;
	b=dW4Kbg8LSKomT59k3hq7rYttO0l+C30aNIAV4nLNUIuqzSwpQfDgG/6R2XDuJtkv0
	 mQ6ZjcmoKs5SgOIsYbTc0TZVgjaRVy62i0RVFCvSuOGZYlbwlngCfXyLHdwH9KgxQJ
	 bRyJUv2sJBPZGWizsfWwc2F8h/gBaJzp/kYHcmuLGeNd2CEJWLowrROcVJ4uAwzEQp
	 xx1yL6FdajGiB8bgTBysQdcwW5de7+WMTw3SGekkrUpjFydUnUCgWLv/MMxasTIn5a
	 ur0EAhuDbZFZ/Qu5d1YArjlGWSFAxphgV9Xq8cMx2rjqxwz9037e0ecXjZRqvu+/RZ
	 UABhrkNlEOknQ==
Message-ID: <50360968-13fb-4e6f-8f52-1725b3177215@asahilina.net>
Date: Thu, 18 Jul 2024 18:39:10 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
From: Asahi Lina <lina@asahilina.net>
Subject: LPA2 on non-LPA2 hardware broken with 16K pages
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I ran into this with the Asahi Linux downstream kernel, based on v6.9.9,
but I believe the problem is also still upstream. The issue seems to be
an interaction between folding one page table level at compile time and
another one at runtime.

With this config, we have:

CONFIG_PGTABLE_LEVELS=4
PAGE_SHIFT=14
PMD_SHIFT=25
PUD_SHIFT=36
PGDIR_SHIFT=47
pgtable_l5_enabled() == false (compile time)
pgtable_l4_enabled() == false (runtime, due to no LPA2)

With p4d folded at compile-time, and pud folded at runtime when LPA2 is
not supported.

With this setup, pgd_offset() is broken since the pgd is actually
supposed to become a pud but the shift is wrong, as it is set at compile
time:

#define pgd_index(a)  (((a) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))

static inline pgd_t *pgd_offset_pgd(pgd_t *pgd, unsigned long address)
{
        return (pgd + pgd_index(address));
};

Then we follow the gup logic (abbreviated):

gup_pgd_range:
    pgdp = pgd_offset(current->mm, addr);
    pgd_t pgd = READ_ONCE(*pgdp);

At this point, pgd is just the 0th entry of the top level page table
(since those extra address bits will always be 0 for valid 47-bit user
addresses).

p4d then gets folded via pgtable-nop4d.h:

gup_p4d_range:
    p4dp = p4d_offset_lockless(pgdp, pgd, addr);
         = p4d_offset(&(pgd), address)
         = &pgd
    p4d_t p4d = READ_ONCE(*p4dp);

Now we have p4dp = stack address of pgd, and p4d = pgd.

gup_pud_range:
    pudp = pud_offset_lockless(p4dp, p4d, addr);
         -> if (!pgtable_l4_enabled())
           = p4d_to_folded_pud(p4dp, addr);
           = (pud_t *)PTR_ALIGN_DOWN(p4dp, PAGE_SIZE) + pud_index(addr);
    pud_t pud = READ_ONCE(*pudp);

Which is bad pointer math because it only works if p4dp points to a real
page table entry inside a page table, not a single u64 stack address.

This causes random oopses in internal_get_user_pages_fast and related
codepaths.

~~ Lina

