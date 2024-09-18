Return-Path: <linux-kernel+bounces-332380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5F497B908
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B72E280FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAE8189519;
	Wed, 18 Sep 2024 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSYsh1Lm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62A189500;
	Wed, 18 Sep 2024 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647014; cv=none; b=SByeV6q+GvWFbIRnunHVSrHZ6Sl6PnscfWc0PNPCwDbPEwo3QVf4KHBvP2TkRHMiOyqnpuFoEEcsasklzLNSr/k8/jOc7GM6oxTA41LbYQDEfsIs+NfnDI6qzJJMHi3foQaoEG/exLrJIx/NHvpvtCejeWRInqf+Jcseet21GE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647014; c=relaxed/simple;
	bh=NrOLT0gVNgllEfNFE5smZn3vmJrwduazNOsgOtf438E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hU6Oo9m5JYvhoMM1FbwTRwQT8yIIuN+I9R815MtK856o/cZjwcZQwMe2mwYQUbppmU8syy/oX/kvW78ymCC7tkdXD0pXNyZJ3HqBb7abVzqRFJeor6TKbIJ8Q2tWv1q0glXr3gxkz6ugY7qOplALq12d5fX8hXtS8QWg42ZTJGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSYsh1Lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8A1C4CECE;
	Wed, 18 Sep 2024 08:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647014;
	bh=NrOLT0gVNgllEfNFE5smZn3vmJrwduazNOsgOtf438E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oSYsh1LmNMVIaRSiUx31ZUuM2KCnQkcWho8/fXzCEu6X5ctBsidmfWkAiJXf4HSSX
	 I5iITDriTHr89TrGjB9NOV1/2A/xfA6q1U7TTIH5U8Vzi+U2WLZtibXYKlpF21Q1YS
	 NWM8mjgXh9hA0Vv2lXX3zHLGPnrN8MYt0BBtIN9qLqxovriIilqMfYdxZdg1O5GvrA
	 f7kdbc5sHt2EAqwVUoPF4nRjrlRzsRGeShQy3avSghQ4DzCU3t7CcJarFnRU/HdB59
	 kd7I/0+zvSZ5P1IjQihJIx6ZTrbSDr0XH8cyacbrdQgRti4a89Sp/8j8zsM5FpDZWS
	 TefkGW9FifL3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7167D3806655;
	Wed, 18 Sep 2024 08:10:17 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <acd68abf-715b-46b9-9e9b-818c40df1402@paulmck-laptop>
References: <acd68abf-715b-46b9-9e9b-818c40df1402@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <acd68abf-715b-46b9-9e9b-818c40df1402@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2024.09.14b
X-PR-Tracked-Commit-Id: a49f48cc7d26270bee727d30ce830d4129b33d4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efdfcd40ad5e14d66f2e66e1fbbfb375c26bd3d7
Message-Id: <172664701637.684502.12240844773410763536.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:10:16 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, parri.andrea@gmail.com, akiyks@gmail.com, boqun.feng@gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 06:49:05 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2024.09.14b

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efdfcd40ad5e14d66f2e66e1fbbfb375c26bd3d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

