Return-Path: <linux-kernel+bounces-414912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6569D2F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645AB2817B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F271D63EC;
	Tue, 19 Nov 2024 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlBzBDR/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041BE1D357A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045968; cv=none; b=MlSCs3friRhJo3oYBTOA/a+cH5Kw1rAvedZpixR76h49Uw8lUNlIAZiK40NDrPTuMCjFesxhxcOfjl5ofD1iOlszx/MbMqLVFA/rxYTkhBsc1nBJ9Ucw4MSPiA8+fV81N7bj+2ZQPaJbYFm2UBO+Kuv6LhVtvlwaJnO3WRL2uJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045968; c=relaxed/simple;
	bh=P79a8Qp9G4Jry3Z1A20/T9f/ADxOf6Nd+L4dNmY2su4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o15oNcSjz6P2QggQQo4/hGVdEqBJNPzcfYFzcvwHfEVfs7ytQnAOJ1KWAG9aUpk+z+eqb/Vk4Cja/ngmzSY3zMrAC/x4ea7jopAVXIgg9v7ZSUhIwCLLceri7GBAQ8KLWFCVVR0PIOgI29VSalGRyECaKdcqIjmWEKKFLNep5Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlBzBDR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D941CC4CED1;
	Tue, 19 Nov 2024 19:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732045967;
	bh=P79a8Qp9G4Jry3Z1A20/T9f/ADxOf6Nd+L4dNmY2su4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hlBzBDR/Ls6g4axVbfDlAWjg9jiZuovDEDl0LtD0jV3Up2YZ1PZB7HxjUQUF5CNu0
	 6ZKl1p2zSr6QefwjrQn4pliZD1wGy9MpbPFp6Km8rxe3XlK3wmd1sWiiW2CKvvGFAw
	 /cEncRdiQPMA1CRma9D2CMyLk1gGd0qbtQ0TxVuyrmQ7thkJ83QNX/2zl/t/o/Eivf
	 UUQSGcDzNcxtMgjD0l2c+SVOO3bg5QrUQn1CNhPzcAXO0kpwQL/zemVJmH8WNyGoVW
	 6iLSBwb3hSGOOoUbYrerrUthxHUBV3aNM0CDrn8cWayWu+7Xtqe7PL1Y7Jq5StRVZI
	 +ZmaPnSMJdj6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC5A3809A80;
	Tue, 19 Nov 2024 19:53:00 +0000 (UTC)
Subject: Re: [GIT PULL] KCSAN updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzsHkNopkQpY2nwy@elver.google.com>
References: <ZzsHkNopkQpY2nwy@elver.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzsHkNopkQpY2nwy@elver.google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git tags/kcsan-20241112-v6.13-rc1
X-PR-Tracked-Commit-Id: b86f7c9fad06b960f3ac5594cb3838a7eaeb1892
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 769ca7d4d29748f1c95b4ae4ce325ba4ea8cd2b4
Message-Id: <173204597913.668199.11932969787943956858.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 19:52:59 +0000
To: Marco Elver <elver@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 10:23:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git tags/kcsan-20241112-v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/769ca7d4d29748f1c95b4ae4ce325ba4ea8cd2b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

