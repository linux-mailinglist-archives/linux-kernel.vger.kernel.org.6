Return-Path: <linux-kernel+bounces-576142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE93A70B88
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498C617491F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34564266EF3;
	Tue, 25 Mar 2025 20:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFSMXoKK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1E266EE5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934655; cv=none; b=uCtK07L5/HYp/84qVSUvSkbgRPvs+wj6oIS4ST6IuTm9jAK6DqSSdLg/Ov/0cek79a0G3cDL8Nt18OBtcG4x/QryMLhIVXPBM6dbCOEQpiaL+Wx0iu8iOcXlSS79W4gTDu+dtDxulLz308kJ9dRO9EAHmmmA3j6zGw/Qf+g9CQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934655; c=relaxed/simple;
	bh=h6v3fxJTgtd26k1sBHVmA8IyYqDfUAFZzWTL6geGeho=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nH3WAhTkA0P/R9C68ILLrvGE2BSNCza+tASUgYCpI076118Kka38isoD0KksyohJ9pN7mLwJApfFd8UkeGPRWBsJm0QzCTaWsxmznhGbTSnjjNVeAdVkuVQoXzbMCPs49obWKu82YONpqQSLkoSJITjkmmTGc08AE4KVFZz1htM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFSMXoKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADEFC4CEE4;
	Tue, 25 Mar 2025 20:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742934655;
	bh=h6v3fxJTgtd26k1sBHVmA8IyYqDfUAFZzWTL6geGeho=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JFSMXoKKLr7T4oPtfVxK07nPYqbN/Ym69xWODBIaZTyu5JFVkKAoVNwzAocqQgMgF
	 meSxx+8BZm6od+gRTlN0P4k+YtDVk4BxlzlJ4d+4AP/ebragHuyOpi9WTbVT6pQU66
	 y8r6V1g06WvlCGcR5SwZxH/0eLAZTs/VVWgKsyTgGqqkUrthUSUqkR8YQW1vUuHvyf
	 dRvkSlcsjhe6NTKhH++OfwXOusQgHW6XH/km2A0RF0Bnvt3Zu9Bf+uMIM38Dp8MBaf
	 aBY7XOdMpCRIX63zAztveSYj+rpVzmrkXkr/owR24oIxc8EvosSu66rnhZLBjc9xQG
	 qn6NbhtTIHDmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFC1380DBFB;
	Tue, 25 Mar 2025 20:31:32 +0000 (UTC)
Subject: Re: [GIT pull] irq/drivers for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <174275225728.1561082.5792124494264581151.tglx@xen13>
References: <174275225552.1561082.4969731002775597670.tglx@xen13> <174275225728.1561082.5792124494264581151.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <174275225728.1561082.5792124494264581151.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-drivers-2025-03-23
X-PR-Tracked-Commit-Id: 7db5fd6b751fbcaca253efc4de68f4346299948f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f40464674504f98514abc10418c0e03fc91ab90
Message-Id: <174293469154.715410.10917405672949236987.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 20:31:31 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Mar 2025 18:51:34 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-drivers-2025-03-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f40464674504f98514abc10418c0e03fc91ab90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

