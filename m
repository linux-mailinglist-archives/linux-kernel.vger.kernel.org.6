Return-Path: <linux-kernel+bounces-288378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB6E953975
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E631F2424E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CEE558BC;
	Thu, 15 Aug 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJZyXac1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585315103F;
	Thu, 15 Aug 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744238; cv=none; b=ph+T+hpnxZnJuzmZy7NhIeK15QomzftXVXhVw/Z04WKuw80qaGPzuw7HL5ybAPoERHRqKFx4H03Q2++jUnMv0qvRF7giHGuKBS6ocqmF8VozpOMd+93QM0HbfA0YCuEcpXpHdgAfCYaHufs83x1UeT8votZQK07hYp7XpjhvgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744238; c=relaxed/simple;
	bh=yh77SP+oACYrB3sXOB80npZ0M/G33RPegdX00oDB2kc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QmTkDfo0n7nzuNCfAe0lO9z26H/31btw/Rb3f58vOQ5dtlxj3j/hldZRDG+UH96gpbC343DCbkbOMGnt8JqWNQo4e30lIbp4g1lZTQLWojo1VhCzI5dbDbZWvWm/CLOPXsZFHosx7SdsWukhyHY/V/Bnb/NVnamuT6yz942QvbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJZyXac1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF50FC4AF13;
	Thu, 15 Aug 2024 17:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723744237;
	bh=yh77SP+oACYrB3sXOB80npZ0M/G33RPegdX00oDB2kc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DJZyXac1dPBN1Z9PStXS0ak451BFCQbSNn7zYomPtk6i5HrTjoANn6Ubpki++v6lp
	 MiSUIUfzc6kbVPsqB8Orp3yYJuQlJmOC4hZTkG3gajzg4mPz7sIqTQyFRSbukaxKp5
	 4/ShCFk1anxwlj2n9nNVJjd0Mz4wXETxlJfukvqbf+q5bC55nMuyOSqCvoGy6IpSYg
	 LZX+L+F89exIIpjKGBEZN6FV5nMgalUZO+SkOc44lXyjg6gVB+DpcXEh4QgS4jCrul
	 vROWLbW8SMm7mcqtSynUwxZ2oFNtvdM6GW2gGNylLaGFaoqOiLPjuGPLyi/lMcrSlT
	 Q3309HuX6MSpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE03382327A;
	Thu, 15 Aug 2024 17:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] RISC-V: hwprobe: Misaligned scalar perf fix and rename
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172374423644.2967007.14196195556000349824.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 17:50:36 +0000
References: <20240809214444.3257596-1-evan@rivosinc.com>
In-Reply-To: <20240809214444.3257596-1-evan@rivosinc.com>
To: Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com, cyy@cyyself.name,
 aou@eecs.berkeley.edu, alexghiti@rivosinc.com, ajones@ventanamicro.com,
 andy.chiu@sifive.com, anup@brainfault.org, ben.dooks@codethink.co.uk,
 bjorn@rivosinc.com, charlie@rivosinc.com, cleger@rivosinc.com,
 conor.dooley@microchip.com, costa.shul@redhat.com, erick.archer@gmx.com,
 gustavoars@kernel.org, corbet@lwn.net, paul.walmsley@sifive.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  9 Aug 2024 14:44:42 -0700 you wrote:
> The CPUPERF0 hwprobe key was documented and identified in code as
> a bitmask value, but its contents were an enum. This produced
> incorrect behavior in conjunction with the WHICH_CPUS hwprobe flag.
> The first patch in this series fixes the bitmask/enum problem by
> creating a new hwprobe key that returns the same data, but is
> properly described as a value instead of a bitmask. The second patch
> renames the value definitions in preparation for adding vector misaligned
> access info. As of this version, the old defines are kept in place to
> maintain source compatibility with older userspace programs.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] RISC-V: hwprobe: Add MISALIGNED_PERF key
    https://git.kernel.org/riscv/c/c42e2f076769
  - [v4,2/2] RISC-V: hwprobe: Add SCALAR to misaligned perf defines
    https://git.kernel.org/riscv/c/1f5288874de7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



