Return-Path: <linux-kernel+bounces-275466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 158EC94860D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF56E1F21F80
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B68176231;
	Mon,  5 Aug 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YY8CiRt6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95716EB40
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900652; cv=none; b=JZbrUdSjdsbBbPbfQr/clE1abJkbdbtkKA3er6su5w2SZYCM6D8kIKCYZkfwWHZ0Onh3eVptBr2L35+XO71os4bRXUHSM38txJckDzZ9ythhH+HAbg1Q81UVd7V6Y/GZwjoE8N0bSpikjl9QJzZTRYwxNx2pRn2sFpThPH+ad9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900652; c=relaxed/simple;
	bh=FlTtLuEqcMWLyx/LMaFM9OOqSTon0XUUkMGVwH+Q/lM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SlZJg/OI7PGTOXQUoOOfOMoN/I5yMyG4PRtszoM8h2mUBM12XCECiczQqV8GbQvQEkC5uzxpbYdm8yji1LrgydEC8jrYi1mCTvGRHe2Bh1nHtKCcbZAyDQv0LbkqHrc+mAFCoKEMqR5+DInUdLPSjMWwsBWgQKZG9hYz3xFQ+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YY8CiRt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 322F0C4AF60;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900652;
	bh=FlTtLuEqcMWLyx/LMaFM9OOqSTon0XUUkMGVwH+Q/lM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YY8CiRt60T0or/xWTL0sQIBIKm5DiH/imjeVEOsEnwbFWZmRcoKUgKvFfpWobONZK
	 hYg4XKc5AAFNy/1j4UBF57vusTKD1UV9RguZgazUKJUcp8EA8RTMqVz7gUabchV17B
	 CPzzOdGjLQ0DxqJYXaoh8Kb6aKWV8xvaVEOErCfUbfNZu5wENBzLYiEEVTiBEH5/Tj
	 9Z8Rsxwgto57kqc1kZeWTDJl7UwUJo5742GgnihrP3aaOZ+aNisKkHgIeWapZh7p4p
	 gYHC5BSU7p6tXrtm8I4UN/LdhQ7nstMi1goR3lTyDU4+TUsIpD1lBTYjjIEk9AZbMC
	 kcBgj+ZGoIsYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29E3AC3274C;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: use flush command instead of FUA
 for zoned device"
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172290065216.2803.2204816071029078570.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:52 +0000
References: <20240614004841.103114-1-cwjhust@gmail.com>
In-Reply-To: <20240614004841.103114-1-cwjhust@gmail.com>
To: Wenjie Cheng <cwjhust@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, qwjhust@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 14 Jun 2024 00:48:41 +0000 you wrote:
> This reverts commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1.
> 
> Commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1 ("f2fs: use flush
> command instead of FUA for zoned device") used additional flush
> command to keep write order.
> 
> Since Commit dd291d77cc90eb6a86e9860ba8e6e38eebd57d12 ("block:
> Introduce zone write plugging") has enabled the block layer to
> handle this order issue, there is no need to use flush command.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] Revert "f2fs: use flush command instead of FUA for zoned device"
    https://git.kernel.org/jaegeuk/f2fs/c/2a331ab343ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



