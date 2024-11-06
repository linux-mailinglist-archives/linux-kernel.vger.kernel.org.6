Return-Path: <linux-kernel+bounces-398701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7EF9BF4E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E491EB24F62
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36F4207A19;
	Wed,  6 Nov 2024 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKxP5D96"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C1166307
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916665; cv=none; b=YiYFUd3qafnPOXq8YfHXg2D2U5utLR80SFdUhkePAT0yEuMHm94SkqspBcht/AgmEBDYmBS9qlIT7iVtTc59SvuPq6b7hPPdC6PXp1Gb30xOKg6jHkAB93i1Dixu43IzM2+cubrYCrHoXw25NBPuaHx0342UaCi1rGql7asQAss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916665; c=relaxed/simple;
	bh=mYDqHqAsMPadJAL2zM5wa04C6ce8FvtP2OYEMyB2QsI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=suHiA5ruLklkFXQTbXmiH3fvTgaBNaYCxc2rOh+Rdx9VUECkjzmdkGByUb8ffsNeRk9vCJ1Lp+zwnYaXZVWytAdyDIEtF9zDq8Oy6wX3LYewNI1+3zevw7JbW3JGP4ANAqX1661ANlgC/EQPB7kibpCno47WaMmy0yyZ+W+53nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKxP5D96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B390FC4CEC6;
	Wed,  6 Nov 2024 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730916664;
	bh=mYDqHqAsMPadJAL2zM5wa04C6ce8FvtP2OYEMyB2QsI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SKxP5D96Xl4gZjcxUo5GKn0cc32CavHl8kfj03N0XfYux0tWaT7Qa0pRFoIbL7aNs
	 s1MBWaFSCWTUrEfVp7dI9sU1UK2KA+W9/WcthlJVo/HEl8HFMIx93rPF1Kj29kI8j6
	 TIebNzAH9/zv+HqJx70SPKVI7LfDBZBNYNqsYUHwYcSB7Xp66iwnnuawK4C4cPbsnb
	 Vk2D036rcYSFEtzP1dBI5E8mBv5R7JgSzeRyInzyns0Gohs7BA4s518pddabJlPgDE
	 Ku4RHNLqtdW8Pm/myFoK8D3//hseqAvOhfw/PMD1wGxFtonvtkq2QCZiE4Wa2wTy9K
	 0MuLeL0hW6UAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE863809A80;
	Wed,  6 Nov 2024 18:11:14 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2411051310180.20286@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2411051310180.20286@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2411051310180.20286@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-20241105
X-PR-Tracked-Commit-Id: 177f25d1292c7e16e1199b39c85480f7f8815552
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0951fede4e5215e4529a3b711ac94fc84f90eca8
Message-Id: <173091667345.1367622.12503665784707882117.pr-tracker-bot@kernel.org>
Date: Wed, 06 Nov 2024 18:11:13 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 5 Nov 2024 13:13:27 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-20241105

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0951fede4e5215e4529a3b711ac94fc84f90eca8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

