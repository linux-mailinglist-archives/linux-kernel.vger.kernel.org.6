Return-Path: <linux-kernel+bounces-234255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB58591C449
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9691B1F2430B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4F71CCCBF;
	Fri, 28 Jun 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uojczbuL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481C1C2324
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594067; cv=none; b=iLf0wmLTPJUxLnjISDicZO6lu/Whv6Y4WwlOps/06xOcUZRPt3k8XnNeS2OLIKlgacGTSmdwue5TDiHKRZs+xstSIi6412Ro/RngghYscb1ZKSABRx3Wzxavm+9lXh1O07zqUQkwuIH44YrP4CLAEnMenCEVWnJEG0x4XwDywws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594067; c=relaxed/simple;
	bh=u7+YQKrQWuj7Wk/dq2Y8BABQT8J4FlDst3Oa0hEMcpI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N8rnZyoVPdZrl8MtJUekShHok4aIyKTpXhyTsrAcEA5213MvDrCjMQ5s3MnWJlSuUTu01WGS5U16s73pddN4JYJHYZZ5/CS3pUqgtSO5ufk3ck8KIRZC/ersUBscaoeCRJdaidoN2afi+7kL0enM+uZLJFgesJJsv0eVZd+gWMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uojczbuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CC80C2BD10;
	Fri, 28 Jun 2024 17:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594067;
	bh=u7+YQKrQWuj7Wk/dq2Y8BABQT8J4FlDst3Oa0hEMcpI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uojczbuLiVfKb7Uekz9LdI1amzyzUz7qsv1c+njMxE3M6Spl7j+Pbo6odyfrF+qBt
	 YHyqj+IjVDxkasLtRD1Le8Z2K2ZFpu9qU2nqfqPYSDAbRpxtzDzM+lKPVE/iHLqRNz
	 JoUM+s6hJhSbYq7mSQ1Qh50Yc79PByeVaFOJpWTCpOOM98SUZfe07XPkL2zMeeiNK1
	 OCs45oHJHtlofsshNNJJj0htW8VpNa6cNqYlW8soRmvm7RubJXQ0FPrCnJo6XQGNmf
	 BS1g0vV+zAEbFSd0fATwgUimorWeiGPxV06YVZR6VryGBbeyjqSI4x2H0qS2rgJf8l
	 ctxZtJul9s6qA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 636C8C433A2;
	Fri, 28 Jun 2024 17:01:07 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240628085928.GA13251@willie-the-truck>
References: <20240628085928.GA13251@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240628085928.GA13251@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: ecc54006f158ae0245a13e59026da2f0239c1b86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9038455948b0abbe425831a56be574631ecb7b33
Message-Id: <171959406740.14402.6959503533854169693.pr-tracker-bot@kernel.org>
Date: Fri, 28 Jun 2024 17:01:07 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Jun 2024 09:59:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9038455948b0abbe425831a56be574631ecb7b33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

