Return-Path: <linux-kernel+bounces-206796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE30900DE2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570691C214AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB412B93;
	Fri,  7 Jun 2024 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IimaSftL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F429153517
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717798079; cv=none; b=MRNL/OTu+jGYHLWmNLe+J+Zw0qkaUioQDsdRwn5h+azmpOO9uF0WoEI+INawnzYXdo4MOn8NSq2YvfZAZ4dtz0yfrYHyAQUr1KgLCfwP/xWre1j5K2gwMAw4Y2oiF/G0DLOEif4P4x9oJvSJxCmAjUcoFRq1GE5aGzCDY6m95ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717798079; c=relaxed/simple;
	bh=AZ1vhb2af1+fN7W4NSr5qNC3pBWBZaWqJyoAwPXHPHA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OKIHyMT3h7Pu2/ibXUyHIHq/Und+yafWf6/Xbl6MDxsSKBmsiP6sEXvMb+fS3UV9yu9xHiBLh5lA73j6egWs1rQldiSfSsHB8uqglL873M3KN5TZ5G6mLRj6hIZb5nlob21taexspzd1iNaMr97gqf2FBr3X2dER39KcMbScDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IimaSftL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD60AC32781;
	Fri,  7 Jun 2024 22:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717798078;
	bh=AZ1vhb2af1+fN7W4NSr5qNC3pBWBZaWqJyoAwPXHPHA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IimaSftLWr3qBzshEUaxqyABAPR1n5hTfvAa0L0eCHbkS8w9J2vmCA6kWDn8hlOpx
	 7pBMvnw4e0Dg8PIFJ/keNPLJ/JRDVWqe64exYAl1cLZH8R4QVX67/1tSfaZCS2IRNM
	 1OvPJw758Uk+fBi0vl2Ri2wQmk/4Ung0hVijOSO7ZfR3DF6B1uec/GIm3FHer6MKyc
	 NlgxamQoalIDt+Jl9c1cBC5GmBjsgIrioZ4Zu8vsWV/T6q0Yvp78XbZI1KNHKZIZBC
	 VgMjfgGPomCH9YEQnNvYp0WsOgBUXyB1rJ6sIMVygLRWVVRdcZYqSKcdgrE4yT7514
	 /enLU33or7OQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97E6FC43168;
	Fri,  7 Jun 2024 22:07:58 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240607113018.GA24475@willie-the-truck>
References: <20240607113018.GA24475@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240607113018.GA24475@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 5c40e428aea644c9d924e491b1bc22fa9f272bcc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d437867bafd8b5cfd209bdedddf1ca065f04a96
Message-Id: <171779807861.32288.2317406245865793825.pr-tracker-bot@kernel.org>
Date: Fri, 07 Jun 2024 22:07:58 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Jun 2024 12:30:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d437867bafd8b5cfd209bdedddf1ca065f04a96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

