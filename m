Return-Path: <linux-kernel+bounces-436562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB569E879A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 21:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0286C164455
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 20:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB4C19755B;
	Sun,  8 Dec 2024 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU93HPEr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E561953BB
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733688114; cv=none; b=Ex4SANgNmOOoHkQE1KizXOITpuXlJSg7PXL/nsozuRUpOwTUf+ukjcba1CiZ98I487jEQZX+u3B9SU5JPJdi957qs7FOLys2XP505+Xg1Jd77QcJyK3LjVcqo9RLztVZb7mWiWoe8/5A4/88Up9uHLD1GxaW3E8z55gqH7KZc1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733688114; c=relaxed/simple;
	bh=TEBaV3n/ep6PtqMVARGXBW4jlCUBLcEKXbWczRBOWFM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JjlGg69xyp0+h31oF3TwnThrhzRS1uIma390kqquzeC5SDKVOvWDGQh8WGH20BxOfS5NmCt8koBKljGmRXZydkQSjrgZWDZGGATvTocD3MLhu0q5aqbao7qmiQk+6n3Aw8YihjZtdn03UZalGi1Ue8aR+VB2P3o6P53iWn9/ZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU93HPEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF0FC4CED2;
	Sun,  8 Dec 2024 20:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733688113;
	bh=TEBaV3n/ep6PtqMVARGXBW4jlCUBLcEKXbWczRBOWFM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sU93HPErRz+1ciDWo3GoLdmwmawYQUFxfU4P5LrVTa14dwNMNYZu/YVJoYCYdadJC
	 6xyXfAivPUkDHwOrpzXj3MnTHw8L2rCchawMmrhZIcHgh3o5hCCjnkSN4EvRfh09pg
	 rj1Eis1ymyv+PoT7atY1ErfD5Nt1oTnewr5kI6VEppINEsbsjD3v2ti3SP2bRuzN3M
	 +bInkAefmITV0tNayD2D4I+rCRwD6EGwhOYcKAEExSS4AjxsdBfLz+HtUU9RB7McIm
	 IyZwlvjNiFDd25AV3BcY1aJTdlxaU2+V2z17KnP+VjBNvRmol1r8ESWaKn1BgbCj2S
	 m6aiGQyTYudNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C07380A95D;
	Sun,  8 Dec 2024 20:02:10 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241208104503.GAZ1V4ry-o8Pf3jrGR@fat_crate.local>
References: <20241208104503.GAZ1V4ry-o8Pf3jrGR@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241208104503.GAZ1V4ry-o8Pf3jrGR@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.13_rc2
X-PR-Tracked-Commit-Id: 9151299ee5101e03eeed544c1280b0e14b89a8a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eadaac4dd2e07292181d35858047bdb177d5194f
Message-Id: <173368812886.3330660.611819061692868107.pr-tracker-bot@kernel.org>
Date: Sun, 08 Dec 2024 20:02:08 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 8 Dec 2024 11:45:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.13_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eadaac4dd2e07292181d35858047bdb177d5194f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

