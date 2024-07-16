Return-Path: <linux-kernel+bounces-253974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE44932989
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D17B22850
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F5919EEB3;
	Tue, 16 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXFKDoNn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FD25761
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140831; cv=none; b=rAopo1RlROfeeVGuJT5J2MSjmiO9X0ghdjgC+NtUdhkmU4XEaJruAmhQTqdvCyalgyHFHf8n09kiImIMXEo2cLx7f61enwYsxxSAJXJijM1+XCXJl569iUp9iig0oXMqIYNJGIAlDgaBB/GjLAMHeZi5Ko4CALEwvWiL9VWUK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140831; c=relaxed/simple;
	bh=PBO2ewmeUiu1P2OlbjXR95+ysrCUmj5kcHJz80vh+z0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SDaLE6wqPQjWWGfidoS+CvUC22phQtYPgFOAu6RbhHJXDQ/XUApQG4s6H7L8QaQZtzfA4aFdv50IrdANkTjm8Nq/k0DRQ0vjcA0WLVRT230aZy9fZOU7dkOpVWKKMRfRiAkUIqQzseRQuRVBj+EnmcC9xYhmL8t2E4ryWl7A5SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXFKDoNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1678BC4AF09;
	Tue, 16 Jul 2024 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140831;
	bh=PBO2ewmeUiu1P2OlbjXR95+ysrCUmj5kcHJz80vh+z0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iXFKDoNnFuP665VsBRXxF8xlf376tP8d2FC5GrxB23OTheD3tfNcfcLHUDfzY0FH6
	 ++59NLPgiZsm3sXbj3UGZ4TsXvFRM8PzlDP1PSdqt84zwt7kBu3sZkzekAzoweXfEB
	 CNyuJh7QPGgT4xeCevJ2Hff1BUXLbWdLz5GyXG/tQCZ6z5TuMLcxlbutA5vKgMEd2D
	 VadDONiLvVkHpAzi1MalVTEXAecJ/cw+4G7bjubytFy7FkVNQOzwakTiGGrlihQ78Z
	 aFy+e/qY7tbYWHZZqCqdzVUqBYmut9Om5+6KUKrFZIY8ezVa47sFUOr8T5t4CfP/kW
	 gsNm4Y+bSe3Tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02CB0C4332E;
	Tue, 16 Jul 2024 14:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: lib: relax assembly constraints in hweight
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172114083100.24303.3143384859191995319.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jul 2024 14:40:31 +0000
References: <20240527092405.134967-1-dqfext@gmail.com>
In-Reply-To: <20240527092405.134967-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 27 May 2024 17:24:04 +0800 you wrote:
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> 
> rd and rs don't have to be the same. In some cases where rs needs to be
> saved for later usage, this will save us some mv instructions.
> 
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> 
> [...]

Here is the summary with links:
  - [v2] riscv: lib: relax assembly constraints in hweight
    https://git.kernel.org/riscv/c/93b63f68d00a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



