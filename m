Return-Path: <linux-kernel+bounces-266146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B9493FBAA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EA61C22A30
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DFC18C336;
	Mon, 29 Jul 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8O0SRMq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5A139CEF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271357; cv=none; b=PW60jhNCSbFipdFcDvAaa9EO9ti5t9bHkrPQrbmhQ15H0lmrxmT7D6dt0q9vd2fEzd+wfquSI1ReWIdZAXEeYXo0xOB9saOgKQtdHG8zSz6FLrryJkP+pUz8Hndw2hy9PMiiseipL+miHA1LJPO/933LCUtsE4lw3gcvPGZUjco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271357; c=relaxed/simple;
	bh=nCnPffQC0wgQl4iUSLFuXT0GVZKZigWkCmO8K+HKrV0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DTmU4HHHNGwdlA9JwlpKkgBhW1gZYfDL/1I03I+oRB8mall2DzyYXDz2ZzvhX/pJek2FPGeiFhH/hUPVPPo9gcogoyiigkalKR3oj3z7yh+K337b+ETm1atcmnWld0xj+LeLpi24ACT5g7wEnbVjU6ArheW7lB0JBCcFlXeXc1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8O0SRMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 147D5C4AF0A;
	Mon, 29 Jul 2024 16:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722271357;
	bh=nCnPffQC0wgQl4iUSLFuXT0GVZKZigWkCmO8K+HKrV0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J8O0SRMqSIldPgMelk9OHwXBycOQ4m+0kniUpxjRCPApfQlOmb/fQXwgyGTP+jEnx
	 oCnb7I2czDYO5X8g6yRNj17vWWgg2HTfpmsWlANAWF1amgJsNc1i189PwwnoyXgq9z
	 vfaE5e/SZ0b7i9bKXHmQ94bF4RulgtIO/G/8ErZr1Oh9g/vVZsBYnr2AUpEUnAlMuh
	 bZcpLTeuKFPSo0x0zbTaagjkmK0hiwnKHDqfAv8oIRXI75YRa26gqC6zGhU1DxJV1K
	 MGaTsQJDvWJKt2Tr53LdtC0Gzx3+08E1UTDzBlqNVsP1JNwFMlqEeafb0ELYqw07Bd
	 E4iAx6hEGQW7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3C34C43338;
	Mon, 29 Jul 2024 16:42:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RISC-V Patches for the 6.11 Merge Window, Part 2
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172227135699.3603.496634508586968231.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 16:42:36 +0000
References: <mhng-d1533559-79a3-401a-8eee-a743b80b3bb2@palmer-ri-x1c9>
In-Reply-To: <mhng-d1533559-79a3-401a-8eee-a743b80b3bb2@palmer-ri-x1c9>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (for-next)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Sat, 27 Jul 2024 06:29:14 -0700 (PDT) you wrote:
> merged tag 'riscv-for-linus-6.11-mw1'
> The following changes since commit f557af081de6b45a25e27d633b4d8d2dbc2f428e:
> 
>   Merge tag 'riscv-for-linus-6.11-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2024-07-20 09:11:27 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RISC-V Patches for the 6.11 Merge Window, Part 2
    https://git.kernel.org/riscv/c/c9f33436d85b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



