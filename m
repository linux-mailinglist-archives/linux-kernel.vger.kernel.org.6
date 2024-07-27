Return-Path: <linux-kernel+bounces-264257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99CE93E0CE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1F51F218C5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D20187864;
	Sat, 27 Jul 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH2AoQBe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A86318756E
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110843; cv=none; b=pPksYbU0o9ARbY+2TnIOvUw355DHn8V9gf0SGQOsDOwi3MS54AiRqx47brSINR4SPxIl1qwZlN61rVTb/vGQR6LtRx7mEg4X+j7IKYkkQSo3czwfFSs4dWQcUnV6esG04uYD1S6iVt5G0YniBZ6xHwGisHSgCdu9+SPR5dltqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110843; c=relaxed/simple;
	bh=C/8YEuRrsgauE/kD/eWZfWMSykWgxPMxQvSL1l+F8SQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=frkUegJ4j5zBlFIhkDtpCJD0Hy6UotyMWIyamI0FhKQaGalEwtym06PXTE2TsvKc80Y+U4A330uiRMHZ/uNSL/iE313Wqbm06JwxBptDTCDfybCEELtGdR1I4qEOCrC9jK8CDAYA24LaErHowU5woMm/Ztr7JRBILnoGm/0MbrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH2AoQBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DCCEC4AF0B;
	Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722110843;
	bh=C/8YEuRrsgauE/kD/eWZfWMSykWgxPMxQvSL1l+F8SQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZH2AoQBeztMrVp5Q2t0XEXRn3N9Wl+KkPwMsgro8JePNevuJ1xqjhEA/sStjhgGW9
	 6wS4oWORA2XbwszoTgK/pCQHt7ucHbc51M0dXZWGFI6KFxlllHEk1RwbosmzyEZKgL
	 aXxQnbf0rumhz1tXYLLu3+3+Us3mqmMiPX86COtMVAc17dIktyMkVEsN+yKjnqwzN8
	 ZSWKpkWwjxkmeaBTsrWsD6gK38AaNSaJSJJ4hjwD2T4l70EkdECj7uDqey0j1icJ16
	 Q/mixLjMgrJMBGVkXS8/xd/EA9fCmVbf9uLLAL0XTovBgYdt5w/RVdc+dEuQVUENGG
	 jQTsKl7aIc0YQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66149C4333D;
	Sat, 27 Jul 2024 20:07:23 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: 
 <172199775390.111438.14770629919964816083.tglx@xen13.tec.linutronix.de>
References: 
 <172199775390.111438.14770629919964816083.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: 
 <172199775390.111438.14770629919964816083.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-07-26
X-PR-Tracked-Commit-Id: f004bf9de057004f7ccea4239317aec2fbd8240b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5256184b6119bd1da541d8deb487c2f9131a6c9f
Message-Id: <172211084341.16614.407752930562371677.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 20:07:23 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 14:50:16 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-07-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5256184b6119bd1da541d8deb487c2f9131a6c9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

