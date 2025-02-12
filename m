Return-Path: <linux-kernel+bounces-512018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73025A332C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA7C167F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C01FFC59;
	Wed, 12 Feb 2025 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHKwP67y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8023B202C38
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399831; cv=none; b=ft1gqZmBfO9cgSMutg3IOvg23TJe4lkdfw7ZOpoAeCiwG2DXIE4sZ+BJAOL2i+WOGn1O8UM6Jir2zVsJlO/aI92i8oyeJ+0AYg023ifMgGKBaP/2sNzqRTw3devywAV7dlOMr1doRRZiRoy06n6J29//0GQeBZN20uPJzAv+7a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399831; c=relaxed/simple;
	bh=kn/LR6jgW0gGhmeVUKCzWBbTc/kA9Ur+AVjsC8c5KJ0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IsZ/i05eDGlS81JrnorWbaU3aszQyAYX0+sz5h25u12+Aon0cYE+/umYs75sOio8KzAf4M34re2rB+RS56Kc1VDQGzVtuFTc5V76UVe0weNv7S2WP5QIJgIc+fZDkuYAmnzq8Y3a4AZiSpSlJnuiAVzx2B17FZffYg/J9WzkwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHKwP67y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE26C4CEDF;
	Wed, 12 Feb 2025 22:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739399831;
	bh=kn/LR6jgW0gGhmeVUKCzWBbTc/kA9Ur+AVjsC8c5KJ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lHKwP67yb5jyk5mgUUxc0R2mMPBjx9e/BBXwPR6fcPnPCx2K7O6jHTTpUuxArhuMi
	 FaQraGobIWKwFSrlbBNu0f+RKSLk1v8nYFJ+X+pIWO8Mf09pjzgNPxgBCnVRDJ6+95
	 ef4xbcguFZL745X/fE6MdoH2Y1ExyveXLZO48IxBHBZDRLTMVF5WCxUOKc0m0WohEJ
	 wSKXv1B65pyGX3Wxl2PtdVMg4pPlNuQjco2JxxsNZi/UeazU+Tl5oWVGHjFgL8Kme4
	 iOfI9OZqvcOXr9maqa5UCSk9qGKQnrOlm+RhSkiF3LM2Q67F3KRXe26BqNzPw8zQlV
	 ItwtPddHn/lFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E44380CEDA;
	Wed, 12 Feb 2025 22:37:41 +0000 (UTC)
Subject: Re: [GIT PULL] MFD fixes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250212153810.GB2274105@google.com>
References: <20250212153810.GB2274105@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250212153810.GB2274105@google.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-6.14
X-PR-Tracked-Commit-Id: 5728c92ae112301936006c5e305677beb1a7f578
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4dc1d1bec89864d8076e5ab314f86f46442bfb02
Message-Id: <173939985974.683951.16384556570423270507.pr-tracker-bot@kernel.org>
Date: Wed, 12 Feb 2025 22:37:39 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 12 Feb 2025 15:38:10 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4dc1d1bec89864d8076e5ab314f86f46442bfb02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

