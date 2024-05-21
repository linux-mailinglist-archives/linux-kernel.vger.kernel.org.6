Return-Path: <linux-kernel+bounces-185371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0328CB417
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1871C23485
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1D81494A8;
	Tue, 21 May 2024 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2Ft+py8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429D6149016;
	Tue, 21 May 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318870; cv=none; b=dGlczDXBpXZCagsTXy88Vnk8O0f9JtaieEcYBLzRClYcfbKPUQyQJJRBDgmqUp4DjM+hL0u6wam7qeJ4fFruG59ZNsm3YPzmWHX7RW0IRWGWlXs+v/r+q+QJZkqGqEQZyki8NALMbQF5SCYZxVb1mH4KE9k4dmSLj85FDD83fEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318870; c=relaxed/simple;
	bh=n4ImbX4WmiCDl4/B2ryN6QxGxS8LlPk12sw7txqt4Dc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A48DcdmgX9RDecE+oI438TUNT7MK5cEjmVSHO+hzVeB024iVx1w1+brqj0wvwVHnGQ2XZYD66rfGA0lhb8U7VUuQ2K1W/43RGtF+bCDY8/qaA4el7wuIwDYCqHPUjnMRafz9gFWYJFt1IcKv+cN4xr3/nLy6PDXG7YstJRXBtHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2Ft+py8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF05DC2BD11;
	Tue, 21 May 2024 19:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716318869;
	bh=n4ImbX4WmiCDl4/B2ryN6QxGxS8LlPk12sw7txqt4Dc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y2Ft+py8Cp6oDfDX0xnKMSyJimhi6kvLQJ1v/VDeH+ZJCwagApnkYXWdtZoCatUj0
	 6IcxlJpvnglZ4bZ//9rOPbGKKt2/jNL2jFBp0ILJ3k1mXFGa/qS4mGp1PoDRJzOJgj
	 1s5YSmnD5vTgSPlxu8wE6Gv+sjsTDb5mCk6InxLsaKZJbHofwsAunTL3YjbxkohAHX
	 VZbZjmivI7Ysu3QqyD/qwLoeBiINqu+vG9PqRPnvc9RUgg3wQLrm7fQH9Rt1myfNg+
	 +y7iV6gN9MWpPszYbP4AKa4DXZSju289m5walir1z4e6SNS4HgS63/lhr0mDOnrtxr
	 biosolggVVqRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFF6BC54BB2;
	Tue, 21 May 2024 19:14:29 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <f797b514-239b-43a8-8ad3-7fa67ebdcb28@linux-m68k.org>
References: <f797b514-239b-43a8-8ad3-7fa67ebdcb28@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f797b514-239b-43a8-8ad3-7fa67ebdcb28@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.10
X-PR-Tracked-Commit-Id: a5044ce7d1d94cd37be99e86964aa054f7e5564c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 334e5639fc4e20752d46552abefc5311351e3bee
Message-Id: <171631886978.10007.3233889065935980735.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 19:14:29 +0000
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: torvalds@linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 13:46:48 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/334e5639fc4e20752d46552abefc5311351e3bee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

