Return-Path: <linux-kernel+bounces-402115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01DD9C2423
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7459D281687
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A81AA1F6;
	Fri,  8 Nov 2024 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKzNoGP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F621AA1F5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087549; cv=none; b=BIFycGaWRyB3o0oJYiU3COfwozskgsKnhWYplzfc3pDUSPorxt5pIjhjO+uU3g/G1t7GJZKcudu7TrrVd5UviZ1u0Ro0rPS5dK8vzSdes5QiFyGON+hftTuuIetDppf8qZON0S70QEhV3EmKtcTKnxvd6KrrtLJdiRiJOXLLldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087549; c=relaxed/simple;
	bh=dn3WLXb8oNPdnj0Z2mP10sw5XG0ZHNrq8jDqH+HA3BE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qLfP2do3G+9vkZqEiy2gfUM4asEyrFD0GVAOfw4V+bLtxZHtKbVoEms/wIrr5lTSB0vuKCQ3WJUfk7jw8T3lr+wtdwCZ6Iyegl7NFBce3u2TL9BUS9zpinSyo3Nyy0O35QdQ/VqCWM7TkceU/ZjLIhoSw7/qpUvDZcILaerpvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKzNoGP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BE0C4CECD;
	Fri,  8 Nov 2024 17:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731087549;
	bh=dn3WLXb8oNPdnj0Z2mP10sw5XG0ZHNrq8jDqH+HA3BE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gKzNoGP3lpzOomxV+R5eyM5MYFGWV67iYECfa7bkb77DDEHBcRVKtaK2qB5j0vnsy
	 P9fBnTCUDHhRjgBELgwIrdDZgPgfJ+gTr4G56D1pDWwdAn8XOwGh9pVhMdpj1tS1Tx
	 OJIXePj+evKBqicLfkEkgLKF3dXmJdrD3rlngK1uVikDa6+OTUFTvA2UGwZxsxX77U
	 wpPyirS9iDqZ0lvi4eVqr3TVhrVmYLUEX7OrAiCZaLDjzndHhijxIT6Sr8Rlus0a+R
	 JefW4ShBVLn3d+IdkBZ3YljERr3gfrf3Kh965Iz8NsgCs9S7Qj03cJcZ+dWMFXZKNV
	 opASx3KQdLnvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC33809A80;
	Fri,  8 Nov 2024 17:39:20 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241108115709.GA17107@willie-the-truck>
References: <20241108115709.GA17107@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20241108115709.GA17107@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 81235ae0c846e1fb46a2c6fe9283fe2b2b24f7dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ea7edac83630a9e8a05042b8750eaa10ecb6a38
Message-Id: <173108755865.2704280.16863022796715917075.pr-tracker-bot@kernel.org>
Date: Fri, 08 Nov 2024 17:39:18 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Nov 2024 11:57:11 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ea7edac83630a9e8a05042b8750eaa10ecb6a38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

