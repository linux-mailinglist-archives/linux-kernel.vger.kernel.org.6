Return-Path: <linux-kernel+bounces-540129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4E6A4AE0F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 22:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB343AF0D7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 21:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318D11E9B0C;
	Sat,  1 Mar 2025 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDV5f1jw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2571E9B08
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740865662; cv=none; b=hut4joagzWDQ+gWkIWrkcHdB0byHiWUIroGl8vAVhRYrLdUj0u0jSqUZu6HJog6FtOZynyeD9o4qtvZSUClvDfgkXYZSATS9LFMl9JSyHam/RL+hK3TFyUoXgpGiG/U2hndapWXsJH+ENGCIe36yQB8H7ke5bSywdbwsTf7weKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740865662; c=relaxed/simple;
	bh=l96ouok4AKa5ZQjf0BolxTw7Xw4e3l8rGwWZlTIwOYM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y6JGy87Cd/o1QkfbBCzGA826AlWtf/oBOc4qkZn6y+B3YDz4Zr/YwgAbKYEXXLd9mc89+CuMXh0FBBywMfIuDlIg4UBYBlPVF80e2i+iMVoR4wJnMIMtHFcmEdAvDy1ZTg25TU76i5qAx3ZGKDvFVxpy4mLwkTcbJ9Ahfk6yybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDV5f1jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9C8C4CEE6;
	Sat,  1 Mar 2025 21:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740865661;
	bh=l96ouok4AKa5ZQjf0BolxTw7Xw4e3l8rGwWZlTIwOYM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aDV5f1jw9oeJflUiLb+X7EWn7fdM8suTkmRmidhEGDvjgZV0PSNSSJdttuIZ/FKk4
	 rvWZ0OFVyC3AHt5UmLIqvDaZjd2OwaDEca6AxXQAxrPR4fJnb/EZIsHf2tE4pEiehy
	 PUYxyU4YEsCaqMISY2x6+UHHsZ/7gixzGM0hOHeNpHgbI7guB4HmJllSD3AdtywBHw
	 /3zPs4JCNS+iHpE9cmS3tXbWSU/gYPoCvRg5bq9TArPinUz88n7JuNv4RxaRuhmKy6
	 htrYYG8jXi5XdynhkRqY5x5KB3iPmoK2nQCoV9jHeXD7exqoCoIjwPMvd947WpCNHa
	 e+R3znJBEaxEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE76D380AACF;
	Sat,  1 Mar 2025 21:48:14 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250301212116.GA29069@willie-the-truck>
References: <20250301212116.GA29069@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250301212116.GA29069@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: eed6bfa8b28230382b797a88569f2c7569a1a419
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d20040d71ede4c0e5fc6ae7aaa92788de1e713a
Message-Id: <174086569337.2508762.431455640708983782.pr-tracker-bot@kernel.org>
Date: Sat, 01 Mar 2025 21:48:13 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com, ryan.roberts@arm.com, akpm@linux-foundation.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 1 Mar 2025 21:21:16 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d20040d71ede4c0e5fc6ae7aaa92788de1e713a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

