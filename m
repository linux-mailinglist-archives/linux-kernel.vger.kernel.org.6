Return-Path: <linux-kernel+bounces-225168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4376C912D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05972888BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F84E17B402;
	Fri, 21 Jun 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI8TW5qs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329B1607A4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993447; cv=none; b=Zrw2gtj7PAPARlGqNG+BKIoGmUCoTM+OhpORd4WfBhWnwbtsdL9zdtKBL/TBhiUPoDnSlew41op5VdpEmtu5kitS3GskDXfnzD3aOS5aBiWRaTUob98kBA9uQImBef7z1qAgNtSQFd/wkE4BMEYQ4Fr42TFAfjZmLhGPXD80l4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993447; c=relaxed/simple;
	bh=2i0NZ/wQGYInx1M1tydRlzU5vLu3M5ITH6G7gyveIB0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kMU3khNBa01/evlCUdcD3YV4MJXy2RVhfgnW2EqZ/6b75U+zl1lnzFOs501gwz2Nl7ApCiGzxnTmKe/snAehq2bwCZveVXUiCZo+u1238OfCjhIKDcnqoeRBmRLaGzzB0hhz0AjDzw39/PGSW09sBt7KEGbS3sKzmrS1GA8CgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI8TW5qs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BD45C2BBFC;
	Fri, 21 Jun 2024 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718993447;
	bh=2i0NZ/wQGYInx1M1tydRlzU5vLu3M5ITH6G7gyveIB0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qI8TW5qs91sufgRRNz2dN5tYb6/8qWBf5JH0IahP/KYe+LMGmzbHK2dRoWbMSwmQx
	 gxtCNJXavP7KbBYZ3KeiGzGMARB0QBHuAPGVkCZYtz9lks9ELLjFHu6lg2wThD+58C
	 pCe82lOv0hi1c5S0kcy/krWpqAOB6z3Wg12ZBZpvhdiwDyb5DD5UhgGIn3PT7W3k6r
	 OkOlF+hLysDybyXDMUSF58fwG7sWflXWjwlWlFeUOjOVFo0N5TjjMzbRdCfbglVP93
	 LGB7UncaHdgejSuPl4Vk6Y/xBcK1PHNNult2DcIEUIPlyT8oA01EMcKPQ1Xqxo/Gjz
	 ek91lPwCLVyig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AE6FE7C4C5;
	Fri, 21 Jun 2024 18:10:47 +0000 (UTC)
Subject: Re: [GIT PULL]: soundwire fixes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZnVMCAG3F5JLdl5I@matsya>
References: <ZnVMCAG3F5JLdl5I@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZnVMCAG3F5JLdl5I@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.10-fixes
X-PR-Tracked-Commit-Id: e2d8ea0a066a6db51f31efd2710057271d685d2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d512d025a1381b614d7634fdc37dfaba2e89e59a
Message-Id: <171899344723.17423.17840401373770873049.pr-tracker-bot@kernel.org>
Date: Fri, 21 Jun 2024 18:10:47 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Jun 2024 15:16:48 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.10-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d512d025a1381b614d7634fdc37dfaba2e89e59a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

