Return-Path: <linux-kernel+bounces-186842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 074648CC9E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5387CB2211E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6CB14D451;
	Wed, 22 May 2024 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5eVrd1Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8EC2E631
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421908; cv=none; b=nzIchyBKgjJAsvxnfMXSnuomvKxK1JiGJf/XGJ0SlXuEKV19zHF4AZTP3YPVpijzIHpl3T0yGT5Qy5CEzRReij5NY9ajSNAT/cyvZEW41WumP5rpzsPL9MSTNjVdYqn6JwiNjFf8wv8ykor47/IxkYac9qjGA3Nu2ZzcQVEYoVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421908; c=relaxed/simple;
	bh=wwQWVyKo3s0RyZje7mPn2Az2NQ1iII2+E9jwjUkfzqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A4iJMiUOghAyrLPT/njOgDx/VgspV9fQO3Vgeqa6Hvz4Me6d7NE+XEtJ8hoI8a7UOARaT8YhTPNfngzNaoxnaNiNOw6AJ5e90hzasm4W6bgvd7denVzDRq7DNUdw0/59tPEqkWN62ke4rX+/a8Ql/76M4V60jWHr5C+AkCl7mSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5eVrd1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E109C32782;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716421907;
	bh=wwQWVyKo3s0RyZje7mPn2Az2NQ1iII2+E9jwjUkfzqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q5eVrd1Zbaldkiu9+ZY2Mvu/D1XeC3lfRkJD2v8uGBoroEyY/DCJ+LZEYWLmylfI+
	 Ok19CtMyehWfQJE1+lDg4ns/xY/Epjz/mrwm7W3zWFyivwpUKRXnPlRhym+wI+QAqb
	 ScrV4Mn3/RfTt9XGtVX0UEll0Hb6gqkDtDzl+eR3MsletdHP1mtsp24VfwS9l9wiPy
	 4pvogjk/2ZcI8HeO/EYG4IvPGfmThluAWlA6PxEZalYH5rW7Criujx+DIp5C+kX4Sl
	 LHqPdVgNJ2gLsQEEIwC7CfldPQAor7Sg66o7ytWQAfZJAM0SKmpNs7KY2qgncdOwrA
	 jI5Kyf7g180Wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C540C54BA0;
	Wed, 22 May 2024 23:51:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] riscv: fix debug_pagealloc
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171642190757.9409.1091588685660821042.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 23:51:47 +0000
References: <cover.1715750938.git.namcao@linutronix.de>
In-Reply-To: <cover.1715750938.git.namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 15 May 2024 07:50:38 +0200 you wrote:
> The debug_pagealloc feature is not functional on RISCV. With this feature
> enabled (CONFIG_DEBUG_PAGEALLOC=y and debug_pagealloc=on), kernel crashes
> early during boot.
> 
> QEMU command that can reproduce this problem:
>    qemu-system-riscv64 -machine virt \
>    -kernel Image \
>    -append "console=ttyS0 root=/dev/vda debug_pagealloc=on" \
>    -nographic \
>    -drive "file=root.img,format=raw,id=hd0" \
>    -device virtio-blk-device,drive=hd0 \
>    -m 4G \
> 
> [...]

Here is the summary with links:
  - [1/2] riscv: force PAGE_SIZE linear mapping if debug_pagealloc is enabled
    https://git.kernel.org/riscv/c/c67ddf59ac44
  - [2/2] riscv: rewrite __kernel_map_pages() to fix sleeping in invalid context
    https://git.kernel.org/riscv/c/fb1cf0878328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



