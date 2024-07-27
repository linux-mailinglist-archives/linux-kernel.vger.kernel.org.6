Return-Path: <linux-kernel+bounces-264262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E6293E0D6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3FF1F21895
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA75188CDB;
	Sat, 27 Jul 2024 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtZV4kxs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2D187872
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722110844; cv=none; b=JZ8ZZ50BOJe0DNS1kzsnH30A4XBkzNg3+WVhNknZasDcIjzqT/9YHjn2FJIgLaTedj0CegTEzgBzF+ExG8EJ+tiZS6QGoEUZc7r5b5mDxS0dI6P/8kPKmJbw/wreeL3q49iCspXwOazN3hcTFjXmvww2ttT9TBvmUlhp37TmsUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722110844; c=relaxed/simple;
	bh=omTxJGhEIF6uR1A4MS3QSQAgtzouvNVGJN6mQIjRYac=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=vBLj39YXIpmWwEgVYb/Qv2dhNX4iPg/Blsw1VKy2BJekOqdN/wp4QQBLZ4x7e2pAyUFp3TsBA+eHYTjdU4xDMGs7H4rETMP9KgCSlpfAvNRK9/r1dU9e9OCvvH+xIFbs6i/cSh5UihvfKqFwMx+B2WeWFBEjksZwzvaFsUnxP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtZV4kxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C359C4AF0F;
	Sat, 27 Jul 2024 20:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722110844;
	bh=omTxJGhEIF6uR1A4MS3QSQAgtzouvNVGJN6mQIjRYac=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WtZV4kxsi2vHs7J1T0B33XV92gIbULuUx98qClwORmfm9aXA0kMS/LipytT6689lO
	 8BhGLOxSG/k3F1Iz/gnzFY37VS5ZMY30lJwOXkmYuUyrnYNjUhP2n55lrdilFNUDDS
	 h/t+xiP6kEp8uL3NuhqjAPxnXte5arZQwMv2Tz9hzW/ZTaT08DlvsWHuFQHAHucVdZ
	 xaamb//ku43ibMhfRYYe+IYcP5b8ZjZtc2tAhZ1g0ufzRmLZ7sBXHN6wKmyWyaIvsL
	 85iKlcsHmPLz74hRUBe7ZZ7MyFyPIato4hkhOxgWomBZeU4yfaz1Hmp5DivRzZ9V/1
	 DN+ZSyaRmIEWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4242BC43601;
	Sat, 27 Jul 2024 20:07:24 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240727015147.GA163457@workstation.local>
References: <20240727015147.GA163457@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240727015147.GA163457@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.11-rc1
X-PR-Tracked-Commit-Id: c1839501fe3e67d98635f159dba8b170d08f6521
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0421621158ed14d0e04321c445c770fc4e99ee59
Message-Id: <172211084426.16614.18287722492144576820.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jul 2024 20:07:24 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net, tiwai@suse.de, edmund.raile@proton.me
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jul 2024 10:51:47 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0421621158ed14d0e04321c445c770fc4e99ee59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

