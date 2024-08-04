Return-Path: <linux-kernel+bounces-273938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF3F946FE6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 18:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF531C2093F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269D213AD39;
	Sun,  4 Aug 2024 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVqWFSnw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003813AA36
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722790465; cv=none; b=KtAUxLQJisUE4wmmzA9mlxnvl2gyZLaqcOQDL97ZryPeFM9OOd5JKSyQaJaKs38fl06spCpB573vnGPqUSUKrTob9/DnznsXx6qwswAUcjVJMvVICOsENCvDot0wQ6pu6I6xUrKGYTj6CKGT0KqYn8VcB8LJKUze3jV6go8Z2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722790465; c=relaxed/simple;
	bh=/bgoNk+uTDmwUCGpWU8OaZ13dvhvXEnl81hYV+JzvyM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RLQSb1imHq7Ro/JHUxSk8W/pgczA1ZOBzSZSFmOfF43dWSOl8aVkzwPQCr/bRnmK1O0IW5M9Otp4OBNQShl7TjlgRLky95b70FgRf8LaJSGijLCFr1hoOXR7FlUf8KbUFkRCrTc23KivK7yOdV22EXQrB82bufaDlPKNghx/yOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVqWFSnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09AC1C4AF0D;
	Sun,  4 Aug 2024 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722790465;
	bh=/bgoNk+uTDmwUCGpWU8OaZ13dvhvXEnl81hYV+JzvyM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YVqWFSnwo7X7kRGOZeykPAAY4b8PXbIdOTtrn/9kG6pkj8PHFGRxZ7dAG+xwAXUcq
	 S7RuY3UsD/Bk+15jV9KyIaYD0u00SVWB5kehawfVA7MDpsHbNGYdoineYXAnhfR9hz
	 oOkrRtgf9Kazos9m6UhzFpIPJRsf4ywgUOJ2TyxkjFNHS5Fjd2RB8/qLwMMn42pxhe
	 CSoG3TmSC3a5SDcJODl4QYn9FMwkzBqYSGleYrkGyzK7NvtxtoEP/tLs4vVha19kxU
	 i4tedR7FeeaDPU3Nt58BxVzXu+hYd6sGfR+0SNWBZ3ET6Ejkzu+/5tUWu1x+h3OBFq
	 tEWBZcHoAthdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2267C4332C;
	Sun,  4 Aug 2024 16:54:24 +0000 (UTC)
Subject: Re: [GIT pull] perf/urgent for v6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <172277654480.866296.3637204430767314679.tglx@xen13>
References: <172277654174.866296.10517632866315552419.tglx@xen13> <172277654480.866296.3637204430767314679.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172277654480.866296.3637204430767314679.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-08-04
X-PR-Tracked-Commit-Id: f73cefa3b72eaa90abfc43bf6d68137ba059d4b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ddeb0ef3cb724615d2d3aa8b35e5e241c474b51
Message-Id: <172279046498.9825.15312313247981161475.pr-tracker-bot@kernel.org>
Date: Sun, 04 Aug 2024 16:54:24 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  4 Aug 2024 15:02:55 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ddeb0ef3cb724615d2d3aa8b35e5e241c474b51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

