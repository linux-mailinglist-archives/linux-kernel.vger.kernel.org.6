Return-Path: <linux-kernel+bounces-232811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7815091AE89
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBF51F2587D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAB919B5BB;
	Thu, 27 Jun 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYAi0p2Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB3319AD54
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510656; cv=none; b=YnNyXdJqtm5d5qqbN9HP3rWXx2YBrO5Q5IEtzycjiKhTShHwUNwDPNIDIelA9/j9CNvIRUXyNpM+2nMBFLbul9U/sZou9HC6QQNl6ScTY1ok/9um5uWUG4O68TTG8N9EPMaQkrn+HszjrsSLGsc/kDov+0Nx4XHDuL7r1o8qJZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510656; c=relaxed/simple;
	bh=FhBU8A5+Q8J0OeOT+PjkesYLZH9n5p6zVNLOC80zmBw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QEezlp/btyxpulMlQqyouQLcCoVuavoAzjrJy4XxMtHdXLf5AXOrAfP0mlUwYebQ5VqfxtsfZIl7jeFyeCVJxZgyZxvgKrQO0kpHgXPXDAUIIoSZI1D8OZrH9eS8vnIdc4Oe+cqS0xQA/kXGM3HbDItKfcrFpx9nnO8EZAKgc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYAi0p2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C44CC4AF07;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719510656;
	bh=FhBU8A5+Q8J0OeOT+PjkesYLZH9n5p6zVNLOC80zmBw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CYAi0p2ZyCgc3Y/ccqYLug+F9ztYsbxWr9w6tr695saFcQn6YidUwXIq9K0ak9EJs
	 sk1lKUr5cTZvu27kL+fNxzb5Qy9/QclYZW3qiXhDFBS3YEgSgzOrPnXlnxeBrofhP2
	 at+jqHsN682VCLNaiPv3cQvb2ugk6DRlkH/0ceAOjETSb85P5DKXJUP3cGqpMTYXir
	 +ETVxwIBD5O16Ve54x/LvN5tBB6xToPZyGosRt4nz+/Wah2fD5Fl1L8I1/ZQTEnEKe
	 HzMCD9GQzDfNOZvkt3T+TosAQEGCbpNsFvr5eTd/7xXGx2wtLrXz7Vtt//bb+Zjefh
	 CJRGBd1/xNnbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DE1FC433A2;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 00/11] riscv: Memory Hot(Un)Plug support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171951065622.6762.1200021343450740838.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 17:50:56 +0000
References: <20240605114100.315918-1-bjorn@kernel.org>
In-Reply-To: <20240605114100.315918-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com,
 aou@eecs.berkeley.edu, david@redhat.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, osalvador@suse.de, lstoakes@gmail.com,
 Chethan.Seshadri@catalinasystems.io, linux-kernel@vger.kernel.org,
 abrestic@rivosinc.com, bjorn@rivosinc.com, santosh.mamila@catalinasystems.io,
 linux-mm@kvack.org, siva.munnangi@catalinasystems.io,
 virtualization@lists.linux-foundation.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  5 Jun 2024 13:40:43 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> ================================================================
> Memory Hot(Un)Plug support (and ZONE_DEVICE) for the RISC-V port
> ================================================================
> 
> (For the restless folks: change log in the bottom!)
> 
> [...]

Here is the summary with links:
  - [v4,01/11] riscv: mm: Properly forward vmemmap_populate() altmap parameter
    https://git.kernel.org/riscv/c/e3ecf2fdc8f3
  - [v4,02/11] riscv: mm: Pre-allocate vmemmap/direct map/kasan PGD entries
    https://git.kernel.org/riscv/c/66673099f734
  - [v4,03/11] riscv: mm: Change attribute from __init to __meminit for page functions
    https://git.kernel.org/riscv/c/fe122b89da67
  - [v4,04/11] riscv: mm: Refactor create_linear_mapping_range() for memory hot add
    https://git.kernel.org/riscv/c/007480fe84a9
  - [v4,05/11] riscv: mm: Add pfn_to_kaddr() implementation
    https://git.kernel.org/riscv/c/6e6c5e21b8cb
  - [v4,06/11] riscv: mm: Add memory hotplugging support
    https://git.kernel.org/riscv/c/c75a74f4ba19
  - [v4,07/11] riscv: mm: Take memory hotplug read-lock during kernel page table dump
    https://git.kernel.org/riscv/c/37992b7f1097
  - [v4,08/11] riscv: Enable memory hotplugging for RISC-V
    https://git.kernel.org/riscv/c/f8c2a240556e
  - [v4,09/11] virtio-mem: Enable virtio-mem for RISC-V
    https://git.kernel.org/riscv/c/0546d7043e55
  - [v4,10/11] riscv: mm: Add support for ZONE_DEVICE
    https://git.kernel.org/riscv/c/216e04bf1e4d
  - [v4,11/11] riscv: Enable DAX VMEMMAP optimization
    https://git.kernel.org/riscv/c/4705c1571ad3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



