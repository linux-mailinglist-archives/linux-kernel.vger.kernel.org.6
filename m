Return-Path: <linux-kernel+bounces-334087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1A097D275
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4EEB2432F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B5C77102;
	Fri, 20 Sep 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF5kVU7L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3246F307
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820435; cv=none; b=lytoK76C9iBTKpqLL9W4WdoHdQAVFp406WSV/DDMCGWs6c4I30ZvmOnJuBFLJ6sQwEuLltwuaZMxmgv92B4SqpUFqG8+jVuY66kJ9I9k2jmk4I65UOmj3GDFLf9uHfvmBKm7QlUo8p1G8FXKxkFdAdqVGTS9KcZgHHe1MRRRsXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820435; c=relaxed/simple;
	bh=E1vOj1nILZ8LVtG0PKmz3Gx2hZPvwVT/rb0OTz7pKIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OGDYGQ76ZpOYSssFCtSxW05AB0hClE3xxy2UL4K/+c2E9aFGAXjwM6GrbaAwLr4HAKJlh8gTCanZpqVHAXvApnTedH3YsNwaRRlVTPFbx8GfOu3wubN3FQJz/jNl7ATQHAHq2OfpyeRizGQ/XD/ZVokCsQqXD8FM3/2R1ky+bhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aF5kVU7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1813C4CEC3;
	Fri, 20 Sep 2024 08:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820434;
	bh=E1vOj1nILZ8LVtG0PKmz3Gx2hZPvwVT/rb0OTz7pKIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aF5kVU7L+W9Aj18WQinqyIwdqPJa7iinovbJs+zB5oprh4KnDcrd+O7r1NaWiaror
	 q1sVo0GHUgWinGq3QiLu7Hj8N4FCWn0s+1PDi7qhEtzbHxUpgaoxSMCiz2i6Ait3JM
	 wpMG33NcTkxX4Xee955HCDvm7L7R2VVejZEl/LBppHR7mbAcvntfeh3RhZnsYlH1xB
	 qmINUYwomMRH47LcFXnFpwHU2742AcEA5Y6NjqsYRRwv2Ak1ssvBp/UgeRMcKlzBhW
	 HqyJzGIq0R1hgqNaGxqwmJi+ovWIU7INgYBmuo8cDYrFjhGL60f0AiKa9L2gW6d4mH
	 2Lktdr1L0GByw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEFB43806644;
	Fri, 20 Sep 2024 08:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] riscv: Improve KASAN coverage to fix unit tests
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172682043622.2112413.9572431906377753101.git-patchwork-notify@kernel.org>
Date: Fri, 20 Sep 2024 08:20:36 +0000
References: <20240801033725.28816-1-samuel.holland@sifive.com>
In-Reply-To: <20240801033725.28816-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com, yury.norov@gmail.com,
 linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 31 Jul 2024 20:36:58 -0700 you wrote:
> This series fixes two areas where uninstrumented assembly routines
> caused gaps in KASAN coverage on RISC-V, which were caught by KUnit
> tests. The KASAN KUnit test suite passes after applying this series.
> 
> This series fixes the following test failures:
>   # kasan_strings: EXPECTATION FAILED at mm/kasan/kasan_test.c:1520
>   KASAN failure expected in "kasan_int_result = strcmp(ptr, "2")", but none occurred
>   # kasan_strings: EXPECTATION FAILED at mm/kasan/kasan_test.c:1524
>   KASAN failure expected in "kasan_int_result = strlen(ptr)", but none occurred
>   not ok 60 kasan_strings
>   # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1531
>   KASAN failure expected in "set_bit(nr, addr)", but none occurred
>   # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1533
>   KASAN failure expected in "clear_bit(nr, addr)", but none occurred
>   # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1535
>   KASAN failure expected in "clear_bit_unlock(nr, addr)", but none occurred
>   # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1536
>   KASAN failure expected in "__clear_bit_unlock(nr, addr)", but none occurred
>   # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1537
>   KASAN failure expected in "change_bit(nr, addr)", but none occurred
>   # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1543
>   KASAN failure expected in "test_and_set_bit(nr, addr)", but none occurred
>   # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1545
>   KASAN failure expected in "test_and_set_bit_lock(nr, addr)", but none occurred
>   # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1546
>   KASAN failure expected in "test_and_clear_bit(nr, addr)", but none occurred
>   # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1548
>   KASAN failure expected in "test_and_change_bit(nr, addr)", but none occurred
>   not ok 61 kasan_bitops_generic
> 
> [...]

Here is the summary with links:
  - [1/2] riscv: Omit optimized string routines when using KASAN
    https://git.kernel.org/riscv/c/58ff537109ac
  - [2/2] riscv: Enable bitops instrumentation
    https://git.kernel.org/riscv/c/77514915b72c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



