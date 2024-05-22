Return-Path: <linux-kernel+bounces-186591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 891328CC608
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09DA0B21B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C663146A76;
	Wed, 22 May 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnrOufbT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE4014601A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716401120; cv=none; b=ZzGtkYApFbO+DsTq/+qyce28ciAp6/fLVArXnRt5a6iuPzpiCXwGjww09GDbPt60Fhv5zlxg+KtCNx18JNKDqaFEl5C/GkJBsVACkqYOeLtOMOfeYRzQ5+QLayhMprI/rDpvC8wFRGv6oznnQ14hPWWqxSYj+3u1TwGZASksObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716401120; c=relaxed/simple;
	bh=bU97e7Vy5iitnWpzph+dGqVzwWoda9nNQFXivO2GZuM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JlgczIqiRXYqn7juHnKeVREpD7iDn4rwsNnSysm53mFyiG/jIDphmeX7KnBxtr06udvCmChAh7YhH3EM5jqWvpqc6B0Uh4DiMmqS1WxYDxhCpcrdHfAbn5MQYkbEzyu7NOMe5/NUcMdmqkfZrMYQfwa+KcwP5LgXRmuKyoKBiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnrOufbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFE2EC4AF07;
	Wed, 22 May 2024 18:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716401119;
	bh=bU97e7Vy5iitnWpzph+dGqVzwWoda9nNQFXivO2GZuM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nnrOufbTWsX2EH/lhc5ZFpDFU41p7caImus1hwt+0zUdIOeo8x4eimsZVEYzKZflu
	 EuFTKFhfhRo5EbeB0pB7DX+wrxNjtSlC+pVRGT6bcRjedvGYT0RP/7d5n8/qMtm1Jd
	 qVfMYQKRJXKU9nlR/gXydRm2GgTy7Af+fafJ4XNE7r5U1nB38FKXYJIeABmHVcVmub
	 sUnBQlkeQFo/zGCi+HIUyNfaPRk2qq+KepfnqK7UmTtizwEEuoZl1GZtHzBnWLvSqU
	 9h2eJyzP+yuRXQHC5W2Gvs1Lale0gBHO60VmTNfDgEUTFQci2Yw3aR3/DMtWS2UlHc
	 MR+Qo9wpxKX9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7A88C43619;
	Wed, 22 May 2024 18:05:19 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240522100550.GD6035@google.com>
References: <20240522100550.GD6035@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240522100550.GD6035@google.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/leds tags/leds-next-6.10
X-PR-Tracked-Commit-Id: f2994f5341e03b8680a88abc5f1dee950033c3a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3033eb79136dd27b17e7a192fac0155ceab5eb8
Message-Id: <171640111981.25247.16308194098781195355.pr-tracker-bot@kernel.org>
Date: Wed, 22 May 2024 18:05:19 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 May 2024 11:05:50 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/leds tags/leds-next-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3033eb79136dd27b17e7a192fac0155ceab5eb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

