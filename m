Return-Path: <linux-kernel+bounces-576137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351CFA70B81
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9216519A0958
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB71266597;
	Tue, 25 Mar 2025 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j58msUpu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768E266596
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934592; cv=none; b=MZmscN2KL+h/L4rX3zL2kqGxXi2yguZIvL9EpwNyXyFSrnYon9YNqCzThxSofw7NO+QqWwHX3uJkLeFDRkMBHzrT4XlqradS21HSznUCQCmw5+DL2+tfD82T1CFvT5KdytnEbr2k4NYJY2dxrgqe8BSF6aKwzV1AosjzVBp1KIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934592; c=relaxed/simple;
	bh=8QjXegMWX+AmAtmqZTgk3EVoNpjgmWvsqxJ1UW3Q2Y8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Xzwfc74KwR1GLIcZwbz0wWluYeQ7qxMl3bTRbFH3049xwXAQ/78z39YFjirhZpwF0KCj4TP/9lxfLhgetA3FGgOfF6ZtJ1w2Q6cOjTNiJOqD8uiujC1rOqVo2J87D/S+H/QCm8A24o/ambuhuVZlsHRIlczSbqH9xrzNDZPgvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j58msUpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E220EC4CEE4;
	Tue, 25 Mar 2025 20:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742934592;
	bh=8QjXegMWX+AmAtmqZTgk3EVoNpjgmWvsqxJ1UW3Q2Y8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j58msUpuXE5fBr2XVtFZJqKcBoThVG2KDVBOq0b4+BhGXhpnP8iofAhQBUN3WQbub
	 w1B7Vwi8dVuMTHPjBfZ78GCCsnDBqKbsvyBDnwx9lzJbo/fiVvPTrp11BZYYU5gLEV
	 O6i9HOmxjfTKVsutW7d967SgHQ4leuu+BDTbPvKOwUgnLJrnHvEvHcM9PwoHw6ML+i
	 darRnuMynOh1ZhK9ZH26yhOemeJoBOX2pPGAEDIqkEMQr/4xz5E8Umu8TPSNS7PdHK
	 dOjBb/ZVsngvEP+IJPrH9FdxrWXnhcXVQQOzGDLBWsy86j2E8X/QLNkF62vBC9tQRF
	 sOTGMxRpJd2YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71254380DBFC;
	Tue, 25 Mar 2025 20:30:29 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates 6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250325195322.3243734-1-catalin.marinas@arm.com>
References: <20250325195322.3243734-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20250325195322.3243734-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: 64fa6b9322a904198589c0479dca6f2ed7f2eb04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d09a9449ecd9a2b9fdac62408c12ee20b6307d2
Message-Id: <174293462817.715410.15472239124104431811.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 20:30:28 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Mar 2025 19:53:22 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d09a9449ecd9a2b9fdac62408c12ee20b6307d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

