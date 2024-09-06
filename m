Return-Path: <linux-kernel+bounces-319451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E99A496FCB7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3031F21E95
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C821DC1BC;
	Fri,  6 Sep 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTEYStIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A63B1DB539
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654504; cv=none; b=VS0+bzh4UrMNdEvSCsjTwFyYklxT67YFCMpDFQsNo3fUiKmP4llu79ceES1XzfKn6UrMGlZiR5wXYWav7edXiRmDjR77wY6W1FFT2n6fXjOR8pLNYZkOPxhPpCnX4z8QB+fxlfbzM6uuCcm1/lxSUvL/vciAaJVeqkedjpE9Hhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654504; c=relaxed/simple;
	bh=OedAZd7MMqmFKHSV85Hc0CUKP6HtFLFUqdbtGyoNx6w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FwaaffP4zkeu5dnchKIC+3Is406N5ceg7e6QN9iyaz65IrfZLutVNvrOpxM7G2h8ulEqqNVbAhYajefUA7wFwo/NY0t6Bse9V7JQFK/accOV9+V1wy3PBx5B7kH7vPxZPbus0kMeM74s5ZF7lc8X4GROA/wF2m2NWpiWPo0i10A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTEYStIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FEAC4CECA;
	Fri,  6 Sep 2024 20:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725654504;
	bh=OedAZd7MMqmFKHSV85Hc0CUKP6HtFLFUqdbtGyoNx6w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KTEYStIZQl8hrcH0YdXYsH9CU4Xdy9oU4sZH3Bzj5W4my2uTyJ4YmNUwdn3O8ki2n
	 2kgaLohRIPWklPfG7+7FqhDq7yDjx/V9ICjhDvsDioOV9CxL4Y098tDK53a5yM9xjR
	 b/yEeoCQL0Dmuaz/hgLezZD7gV2kKzGnwZR/tGLF6S+hD+M2/jmUmbDciv1gKKF4l9
	 o1fEPO5BxZ05ybI3g49U/ytN4vSlHxFAzubdOI9obf9VQLuKfz8BtTz3gS+OQ8Y30J
	 L8KFw0cgUgCfOIvtITyq2l0TwWpTA0VYKO9l3Az5SGyKC10OxSF9hIhJKJf1zemwFV
	 alr+VHgNXB1WQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343473806644;
	Fri,  6 Sep 2024 20:28:26 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zts3ECHu-7nucQHp@arm.com>
References: <Zts3ECHu-7nucQHp@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zts3ECHu-7nucQHp@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: c060f93253cad63ea9d41b5b1186a1da32541dec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b8ff511e412af4a367a8d3d4f323715a9357aa0
Message-Id: <172565450495.2515438.2346612428582734391.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 20:28:24 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Sep 2024 18:08:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b8ff511e412af4a367a8d3d4f323715a9357aa0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

