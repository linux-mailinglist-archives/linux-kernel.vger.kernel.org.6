Return-Path: <linux-kernel+bounces-185323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487EB8CB37B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EBE1C2098D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B159148FE1;
	Tue, 21 May 2024 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3hWqRml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D5148302
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316050; cv=none; b=qqk3TTCXJpcBZJQzQgngtZZbpDzb6q3YZD1o5VtLFDQ3a2q5Nt5ZGLBOjCBPcAuyOI02OalROTL8F/vGSIRD6sENA5N1dKvUWuWDB7p+sot/9Q3DsCq7B9BvluAU0MruCHeTlM3K5lOdwsysbMT0goHAgazxOe1nHM07p4uu6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316050; c=relaxed/simple;
	bh=ATPrVgRfwrvx6lYfmOa2mFkeuSWLS6IiTfX2UhpRTFA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XmcOGwSUPlnBQx5NTskts8VLlXkavPVvuLF6MTSx+qmtYkNpVrevk8SKBMMWvI7qFrc7TZRaKhPKZBf0xkK4lT3J9g8JQCiIunCwwWGInyQSX8wanF5G9+F5lOwF+I0SbzttmbCNoyoHKVppejDnf2Poi9PfQI+L5fFt6mKgE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3hWqRml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85972C32789;
	Tue, 21 May 2024 18:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716316050;
	bh=ATPrVgRfwrvx6lYfmOa2mFkeuSWLS6IiTfX2UhpRTFA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e3hWqRmlKfmx/3seqozxsxkrpo8Ura4wFs9B5h086w0PKOAp+eGnph6iM+jRUiayj
	 +2I3I6K0HzNc0BQfGyTaBIufrmj6IXOwmKz6t+x37nyal4WVTbQMNnFQP7QByJklHE
	 4uSN+w0S4gcLDx/Rmxu+HDif/gKwxsKEjkwGUjSZmCtCaR00e8is5NBkk5L15dLJnL
	 njMMFtoa9jvJikFyCwfSIfJRLiIFTNTg0n48sFwsWNqaGJNklb9g5gHwH6/ovdFRj3
	 0oU8JSqa3HmIZ7/lFro2dU1idQ1pR6LyCgh0ne7cpsgrTCuGIpHnqx4xypseRs3BNk
	 EAW6+PbfjYgiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77FAEC4936D;
	Tue, 21 May 2024 18:27:30 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy updates for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkxPn_tmkPzo_T5c@matsya>
References: <ZkxPn_tmkPzo_T5c@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkxPn_tmkPzo_T5c@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.10
X-PR-Tracked-Commit-Id: 960b3f023d3bda0efd6e573a0647227d1115d266
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8053d2ffc4502bbb50a78c805d964e65a6de1803
Message-Id: <171631605048.31501.5022966189519276268.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 18:27:30 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 13:09:11 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8053d2ffc4502bbb50a78c805d964e65a6de1803

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

