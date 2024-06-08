Return-Path: <linux-kernel+bounces-207141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4013E9012D5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 18:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF6A1C2133F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39917B508;
	Sat,  8 Jun 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0xyOWof"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1F1E526
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717865423; cv=none; b=Z0GWXNjzcjydhXSvIgffGcQA+aGv78v1gVUUQOES167GzV26je7tyZFlkLim32jUxrySZJZJ2XOrxg9OWV5R6VkD0WzD/6F4gF2btlY6yvysB7RXAtFQU6nUI92mIfTNdtGe3arVXna7X6GUf5Xrps+7uGD6bIJ63XrqnV0qJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717865423; c=relaxed/simple;
	bh=KnH9Xw5h9ZtGQbDeFL7QY/IXwq44VIPWajxsPpL5018=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MVS8YhCrDQFCuWFRTjP+MMO1i/9jRk5bHVTh+EXkMCyxKgBxiy9eqRQUAPifPQFZcfSf8PQbRjNZTSZNAOuHQLDB6UraJLTvE/DNHb13pM6mPr3XD7RXdMzbHYIJ54s1l1U2pJ9tjOSaGlqJ/BxZ3uWjtnyGSvIaiOH9o9a2qXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0xyOWof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9026C2BD11;
	Sat,  8 Jun 2024 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717865422;
	bh=KnH9Xw5h9ZtGQbDeFL7QY/IXwq44VIPWajxsPpL5018=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i0xyOWofIZ3RiLYYsksQ+nOeRP9gcdgbFkENos/0rRuNAcIfWSrHM1Be4/hS6CEbf
	 yEOuQ4SryGb3ISYjtVKIAANysbBUu8PFDMXwtHT7OKSOMRgUtdIWgGYTinJb1WlEW6
	 JbFbXUvF1IS94WybJqJYtaDIu6NG20D0AmpKrg9/cNOzR0xBG5dTumE/kqJQOfClfT
	 Dn/dOEwN7wnMWtNSe2DUoLJz6LiZtbZETrJqnd/xM93bdCcbmIWCQrrIozxPRcd921
	 mbeeZ+WDY+Dzsj5/vz10MKbnpU0/DRz945f7FpmuJgw9qXXelqaXQFdJBGWhU6vv17
	 5CUQfOmSyGiCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B80CFC43168;
	Sat,  8 Jun 2024 16:50:22 +0000 (UTC)
Subject: Re: [GIT PULL] locking fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZmQJ13aFHTtl6CEj@gmail.com>
References: <ZmQJ13aFHTtl6CEj@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZmQJ13aFHTtl6CEj@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2024-06-08
X-PR-Tracked-Commit-Id: f92a59f6d12e31ead999fee9585471b95a8ae8a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbc5332b8cda95cd081cff9c405c1cfece872f20
Message-Id: <171786542274.29675.16902646050766636020.pr-tracker-bot@kernel.org>
Date: Sat, 08 Jun 2024 16:50:22 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Jun 2024 09:35:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2024-06-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbc5332b8cda95cd081cff9c405c1cfece872f20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

