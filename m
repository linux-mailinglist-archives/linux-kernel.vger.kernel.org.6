Return-Path: <linux-kernel+bounces-309337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D21966907
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FC61C234DC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8571BDAB8;
	Fri, 30 Aug 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfcK2lOc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B241BC085
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043060; cv=none; b=PHmvy5M8ZY6p5yOShzSMg4FX+FDH4a6bEBS8oANGAvyZMnbyv7nmjNFNjkIFYjOpTCCWOC2ZfGkvx7m98Aa6l5ASbwF4rj/tD+kP+xPDf0M3onAHpI9JCAwhEcOJsIucOX5fcB9NlrMk6q9vZ5BHMNJoi+rOzWrfiMvCFA01nQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043060; c=relaxed/simple;
	bh=cS+uwo1X4MSkGR4akUQdzj8l1jwkZIiiXeHFQ8cPFEs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FBsW1cxfoc1lfRzRLK1xWbczxJY51did3Aj+U48tkJFFLL3n14pX/kW0UolmXaLhYJBh5BcadrEAyK0lFnpgIU10v2VC3UozLvhIr2iA9Z1LHL3cHEJkdlDAlCfi8tMhYuVK+ZxTAl9l7Gr7sAQ8lc5KLRAau+jDZfklwDDjYws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfcK2lOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88160C4CEC7;
	Fri, 30 Aug 2024 18:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725043060;
	bh=cS+uwo1X4MSkGR4akUQdzj8l1jwkZIiiXeHFQ8cPFEs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kfcK2lOcixL7a2B/Mu5dao+w/Nfni6ZFRA4hTHPRuOapd08kOity/mNNyQ8jtnYmF
	 VBQjGdsfTffCQQZdUapXgjEM5Aqac5jjwxIDZyOU917N8B/ew7wAcANkR7JQ319DaG
	 tDWnNGhi67NeEffv7mF/oKD314Pa2EVD058AJRCoiuhgPCpv3XMar5SyjdOL7Ks91F
	 Gm7/vOr/1EEkXg/DWRlIT9E17KZCsdl9D5SmvLpgXSfTb4KeW/T3k6EYCJ5/UCnNFX
	 FIqkHLGokaIkfJCwySCg2RangKsCGWjsJaJflWnfsFsytedAh7BqzxYY+6Oh/hwoBP
	 bRC97H+UcUoQQ==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 401283809A81;
	Fri, 30 Aug 2024 18:37:42 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy fixes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZtHBRVSH6wyIvU+b@vaman>
References: <ZtHBRVSH6wyIvU+b@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZtHBRVSH6wyIvU+b@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.11
X-PR-Tracked-Commit-Id: 5af9b304bc6010723c02f74de0bfd24ff19b1a10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32fafaf2ab185d26337f79d3ae558b4cb2b4a5d4
Message-Id: <172504306225.2681732.17813278018636125340.pr-tracker-bot@kernel.org>
Date: Fri, 30 Aug 2024 18:37:42 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 Aug 2024 18:25:33 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32fafaf2ab185d26337f79d3ae558b4cb2b4a5d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

