Return-Path: <linux-kernel+bounces-178773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0598C577B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF5C28273A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133191448FA;
	Tue, 14 May 2024 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flySvlIF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D013DDDD
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695242; cv=none; b=Xo+MCe3YR4vkIYSzLfgCq79fv6xVQZJF8vOaX0+ZtmGN/ee/A+ZbXh2QtHV5bns1fAJFnvpV2ylTv+3lsXhGci4ICBHuKu2B6N8M0dPwJyVf2ws/k0xTS0+uvAVwwqlRTze0BS/p9afyqnHyKUkHVZnyXYVcFwjBbA1ExPhV+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695242; c=relaxed/simple;
	bh=N8ye8kP7p0QXl90QBB1Ui1ORw3dVgGH0prC6aY8G1zI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IBnZ8SmRcPbl8v2Do8KmZUUNMxGXxiVa81hOBc8T+WMHfKnvLseWMJ1ke4zVUny4edFvfXFebqwapPSV6+zWolI0t0P+zVu2mXnaQMpFTPurUn1jEF+A03aQHxIEop40MT0Lf8aVqQI0mMARiuAbBMbZso01k22cH5HpST5vCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flySvlIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EE52C32781;
	Tue, 14 May 2024 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695242;
	bh=N8ye8kP7p0QXl90QBB1Ui1ORw3dVgGH0prC6aY8G1zI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=flySvlIFxx028oqiyNIAiWkTN29fVn1UrZVagDmGmXIh+kDwmFGPN1xYTtFfgNq0U
	 OnEiMqPKgiT7ing3LfQm0jBi2+vMyqtntWomEOs0oneNypxvK2jnDtk6Tedol8EJFC
	 jqXE5I5lfKZNOr+rBHh1BV4o5JmTiJOZ2gjMwmS3oDF20QY042UzmzJj+CK9xXl0Ix
	 vOh0tAXUIT6B06N2sl8pasATv+SozeVDHNYRBtW108K2oD0KSzY0bhOCg0uI0ktwWM
	 bA0pAZR6noCawMI41/ip2rPoEy8UNpwL8wlq1Jn5GOfk/bISfzlIL/KkQ4gcNqi7pd
	 WCfQ96XmYVeMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F5A4C43339;
	Tue, 14 May 2024 14:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 00/13] riscv: ASID-related and UP-related TLB flush
 enhancements
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171569524205.4793.10651789416740480698.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 14:00:42 +0000
References: <20240327045035.368512-1-samuel.holland@sifive.com>
In-Reply-To: <20240327045035.368512-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, alexghiti@rivosinc.com,
 jszhang@kernel.org, cuiyunhui@bytedance.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 26 Mar 2024 21:49:41 -0700 you wrote:
> This series converts uniprocessor kernel builds to use the same TLB
> flushing code as SMP builds, to take advantage of batching and existing
> range- and ASID-based TLB flush optimizations. It optimizes out IPIs and
> SBI calls based on the online CPU count, which also covers the scenario
> where SMP was enabled at build time but only one CPU is present/online.
> A final optimization is to use single-ASID flushes wherever possible, to
> avoid unnecessary TLB misses for kernel mappings.
> 
> [...]

Here is the summary with links:
  - [v6,01/13] riscv: Flush the instruction cache during SMP bringup
    https://git.kernel.org/riscv/c/58661a30f1bc
  - [v6,02/13] riscv: Factor out page table TLB synchronization
    https://git.kernel.org/riscv/c/aaa56c8f378d
  - [v6,03/13] riscv: Use IPIs for remote cache/TLB flushes by default
    https://git.kernel.org/riscv/c/dc892fb44322
  - [v6,04/13] riscv: mm: Broadcast kernel TLB flushes only when needed
    https://git.kernel.org/riscv/c/038ac18aae93
  - [v6,05/13] riscv: Only send remote fences when some other CPU is online
    https://git.kernel.org/riscv/c/9546f00410ed
  - [v6,06/13] riscv: mm: Combine the SMP and UP TLB flush code
    https://git.kernel.org/riscv/c/c6026d35b6ab
  - [v6,07/13] riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma
    https://git.kernel.org/riscv/c/20e03d702e00
  - [v6,08/13] riscv: Avoid TLB flush loops when affected by SiFive CIP-1200
    https://git.kernel.org/riscv/c/d6dcdabafcd7
  - [v6,09/13] riscv: mm: Introduce cntx2asid/cntx2version helper macros
    https://git.kernel.org/riscv/c/74cd17792d28
  - [v6,10/13] riscv: mm: Use a fixed layout for the MM context ID
    https://git.kernel.org/riscv/c/f58e5dc45fa9
  - [v6,11/13] riscv: mm: Make asid_bits a local variable
    https://git.kernel.org/riscv/c/8d3e7613f97e
  - [v6,12/13] riscv: mm: Preserve global TLB entries when switching contexts
    https://git.kernel.org/riscv/c/8fc21cc672e8
  - [v6,13/13] riscv: mm: Always use an ASID to flush mm contexts
    https://git.kernel.org/riscv/c/daef19263fc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



