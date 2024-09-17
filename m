Return-Path: <linux-kernel+bounces-331339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DA297AB78
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CDC1F25478
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA2B15B57C;
	Tue, 17 Sep 2024 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crncEuml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AE4136E3B
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554946; cv=none; b=igbvMGeB9sTZauM3z0p+W+8WzjRlDxKwVJFisVYvHWjlQTPaB57qZpguTVlOdd+yuAB02MrTiRnMRRNSaluaYzwui4NbSUEwpPG6rSQcSo7RT8FpStaPsWVNDrAy78l+EI5m9UEGuxwOpIM3CfTOreegwrdFrTF1hCFqrZ65fWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554946; c=relaxed/simple;
	bh=oXyPasZHN23Xc+i5BhzJnHkbU5qH2od+9/zDpvJWDZ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NwIfgYX8wcbmUWhKEkA1tHDz33NkGoin8oBns0Wqqz8rPN8H4B+RnfSegxKgsI3IR9CaB2vcb9dWMxve0+8H4keTS1Q8iEhDjjhKg6REngxp6KbQnHyTbgypaHjp/08HoKbWD2nA2CjlY+2QknF9SrLbfWVRgc7f9E4kLcvsVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crncEuml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928D3C4CEC7;
	Tue, 17 Sep 2024 06:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726554946;
	bh=oXyPasZHN23Xc+i5BhzJnHkbU5qH2od+9/zDpvJWDZ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=crncEuml0+StBUN9ORp0DvehwFYXK+zDhX8t52X4QUMDJoBYZ0Cyk7TbOQj3f2+hz
	 friXZNJ/bWQAkSGWcJo4VQhsOPFxzqNK1/wVrqACBgNW9abiEeAwP/kc38WNxO0cTi
	 CxJg9YoD+t1CtxMTHrOz7j60gTq1lIuk+ONcl5x1NpFXtmOorA+buFUBkYj7Y2qJli
	 SXjL/U46lmfp6VCNpnCyLgxIrMgC7ixZVING59LPbovpDd6PbHlPs8OZWmYJr3jhwJ
	 ovQPfHr7M6WsrS55l2cgPAUW2ujKawWbjjTbnPK9OuTar8AKEVsFLpk3rzmpw0CsgI
	 XioS0w4WUX73w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB53809A80;
	Tue, 17 Sep 2024 06:35:49 +0000 (UTC)
Subject: Re: [GIT pull] timers/clocksource for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172647589402.2450257.6913545425550099726.tglx@xen13>
References: <172647588843.2450257.3544233832195550173.tglx@xen13> <172647589402.2450257.6913545425550099726.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172647589402.2450257.6913545425550099726.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-clocksource-2024-09-16
X-PR-Tracked-Commit-Id: 4ac1dd3245b9067f929ab30141bb0475e9e32fc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a64405b78be95d786e15b2fd0a12999240b28ea5
Message-Id: <172655494789.13787.9777815629304681633.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 06:35:47 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 10:38:39 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-clocksource-2024-09-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a64405b78be95d786e15b2fd0a12999240b28ea5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

