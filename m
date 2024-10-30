Return-Path: <linux-kernel+bounces-388067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A0E9B5A15
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A51B22626
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232CF1C3F04;
	Wed, 30 Oct 2024 02:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ah4/ZJX2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D51C330C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256276; cv=none; b=HF7mEItlglwUgIcU4qrKhU1oItKot0mMpN+P0yYlwiYLenv9HXMmni9GpaE3lROFX+GdS9LjWdTAloWy3+8E/UNW+hFJUZlTrgCCaQ2XWBWfkxWU2GCvo8XF+nmApvqb4e3/DVmmZew+cOjRG/8hZhYzI0kOm3LQ+ELKozEWH+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256276; c=relaxed/simple;
	bh=I+YO0yvQCElpskopyGxYPjxJZGStiDlNLXEB37s1aHY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k5e2N/ZZIfzqY51I1T1RzsCLcejPhhqk/NvJm5VRloNuhAYQ63avpQAITwJEQGri8MGX0ltN8GLpuNsZvy4IaR1jv9ZAVQAufDHdUUIDUat2nAs97aqAiBSf/h3ZUislRBsLSNhPDo8C7tRAmFQVevMQJTLEKc1oJcatiIBy3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ah4/ZJX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3A9C4CECD;
	Wed, 30 Oct 2024 02:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730256276;
	bh=I+YO0yvQCElpskopyGxYPjxJZGStiDlNLXEB37s1aHY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ah4/ZJX2z+9eFZM72MgJ9d/oqFaN//+133GPS0ZVV8HZbp7G8+OsUKLQepr3TadFq
	 TYaHm1kQSpnjMvUpJjkytVDKmAB40qTQGUMlZvK4ia10tF4ifwO1+5mfFsO8vCnxUs
	 9bbmEDYon9aal69zyubM+UKOc8Icp0aCyLBqECQdj6CTB+BDcc/sR9s5mwP4Cx62ia
	 vIyqsEMoKTIWEGKEluz898NyoT6ExN0VPnypYUwCPOla82bvg8LTwf6cn4dOnq8jYo
	 6+FLw2/vB633pDP5kXP0yQ+kG3FIcOuiPAFWqYcvwCaMo7wJqF9vGiOsu+oh7X3E0g
	 QPDIdniQVatXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A77380AC00;
	Wed, 30 Oct 2024 02:44:45 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZyGAfCUwdSJysoB3@slm.duckdns.org>
References: <ZyGAfCUwdSJysoB3@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZyGAfCUwdSJysoB3@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc5-fixes
X-PR-Tracked-Commit-Id: c31f2ee5cd7da3086eb4fbeef9f3afdc8e01d36b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: daa9f66fe194f672d2c94d879b6dad7035e03ebe
Message-Id: <173025628389.893735.3618873137753178173.pr-tracker-bot@kernel.org>
Date: Wed, 30 Oct 2024 02:44:43 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, sched-ext@meta.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Oct 2024 14:40:28 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.12-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/daa9f66fe194f672d2c94d879b6dad7035e03ebe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

