Return-Path: <linux-kernel+bounces-290890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5855E955A9C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 04:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8040C1C20A7B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 02:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF94748F;
	Sun, 18 Aug 2024 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDmBO2v3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5620E6
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723949241; cv=none; b=qKBaMMxMl4g0gJ98cBv/T1356mQiwg9xdAOkLo8cZY9YvEB60S2wNUGEGTl3eUIkV54Y3Q7kxqKEZcOy5hz3IaMOcdwjEIYEGgKIJxQJAFoXDdRRHqpxJgzaOmR7LF6aWBae6rF6QJcAoRXcZOGn6M4hXFbYFLtO9xQ7z73PRck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723949241; c=relaxed/simple;
	bh=jLTUGh268GyPRXzru3Ic+w9Nl3CoqBEkyfUJNj3PR64=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jsDvpSvuHwhu8CZQnhZIXB2HQ3YSnIa/ihPSxyd/zm5VMcJQgHxNLu9ixwM1ERSA2Qm3t/4//fDqBxAXOxMz0Htbu6EdsyIkI1GHIgx+E4mfFpVmwDDywOwBEQTefwl5aoOx5yu+zME65rleW5LV9zN2cCm3NtYNfXKKltLxsbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDmBO2v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235F7C116B1;
	Sun, 18 Aug 2024 02:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723949241;
	bh=jLTUGh268GyPRXzru3Ic+w9Nl3CoqBEkyfUJNj3PR64=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HDmBO2v3IupITa3sfqS7FKiJLMamgc+4u86tytbEqqeUhxmdV+xZS/zMOk3+mY/6b
	 3Dcy0YT0DtnDnzus9jlVpzxCDPpCyQOlb7qWEXMp/2F7h+WYbmmSU855i93IGENqn6
	 KuoO/+BZ/cETW98C34LwnuNEdXFRpchwciw2HnUqtKO/Sdx6jPydTJE/hk4BXu5YTP
	 7XDvOvblA3T2fiR2J6PfVoC4TnBUwcWPqO1i8OFtJgFkwcYgsNXOj5bPV+LsnFvS0Y
	 L1dvC3kCKSGFWEj6x5aIJhizHUyxi6zP4lFFaPmVXrNyTZmtJ0LcXYeBkFgnc3STSg
	 QWTAVLRrP1THw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE32F38231F8;
	Sun, 18 Aug 2024 02:47:21 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.11-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87r0ampuio.fsf@mail.lhotse>
References: <87r0ampuio.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87r0ampuio.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.11-2
X-PR-Tracked-Commit-Id: 227bbaabe64b6f9cd98aa051454c1d4a194a8c6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 810996a36309a56a39b406d9ad2903115714228f
Message-Id: <172394924028.3858125.12681191271050391175.pr-tracker-bot@kernel.org>
Date: Sun, 18 Aug 2024 02:47:20 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, linux@treblig.org, linuxppc-dev@lists.ozlabs.org, nysal@linux.ibm.com, Thomas Gleixner <tglx@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Aug 2024 10:03:11 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/810996a36309a56a39b406d9ad2903115714228f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

