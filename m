Return-Path: <linux-kernel+bounces-169118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B177D8BC34E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 21:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24B81C20FCB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8AE74BF8;
	Sun,  5 May 2024 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ44mjAO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C996EB55
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714938237; cv=none; b=LK37SE22CQyJ0tUBE9N/uKmuAumETRbO1u/89RLU/NwcQ+FmicvIX0AV1CwI2QV4+PtZl/kYi2m1R8tHFln36n/NZl0mrCUAlBCQbRTMoMX9CSfYp4wAHngku0b5k4sGuT/7QJOnz7LtlT8TkwTbPLQgon0N7P7kW9VT7Hvql4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714938237; c=relaxed/simple;
	bh=TdsIQxKnlXPYkAhQk/li8KHm+xZCK6PAxEbxKktkoZ8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ueuMNJqGv5FN93y+D7K07aSRWbqzebBsgTcqfOv1wkXHFkjR9ZbS9ydVbz/w8gC2VV56ZvQjGouOesIea9JLa4gYVtSQ7ueb1Zbp74vBHTWpYnMWpyuz19MDpkQqLh8FUrRQFxh2qLAqaC1VBWbhWapavvz5AXiJEpbh3VXcKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ44mjAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAFFFC4AF68;
	Sun,  5 May 2024 19:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714938237;
	bh=TdsIQxKnlXPYkAhQk/li8KHm+xZCK6PAxEbxKktkoZ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YQ44mjAOiUkQ9C93yUxXuE81zhKrrLyvva+fvZfDwOE5SP3anRVj2SXPlqxoxcRfm
	 mNQgopKHk7iK37JinUESKv1NBcxVMN4IY5Gc3SPCO0TZ9EcqJOYFA/IQ+ASK4ffjnx
	 84o9KZoQiVZDRfJ0C9Ge456N6iQLQ4Jl3rQVku2Xr5YUrUTnfWWDTZOBi1e3VgoAE+
	 ELln76aUgacXWbA8FN/PcwLaDUaMIkKbYfLynGQfTebJEV19ysZMZVmPIXNWFFXbfV
	 i0Cv04Y7umllMWtbuL0yOQSaLBpMQh2IAz19mUoaDPo6aCugrmApl+ZHk5y+YYnYlE
	 7JORjqjB6SNng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCB4CC43336;
	Sun,  5 May 2024 19:43:56 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZjdN2w4vdyWsv3e7@gmail.com>
References: <ZjdN2w4vdyWsv3e7@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZjdN2w4vdyWsv3e7@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-05-05
X-PR-Tracked-Commit-Id: 02b670c1f88e78f42a6c5aee155c7b26960ca054
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d099637d074b9d8170b06365f575f6cf03d614f5
Message-Id: <171493823690.6787.3511068887163712416.pr-tracker-bot@kernel.org>
Date: Sun, 05 May 2024 19:43:56 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 5 May 2024 11:14:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-05-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d099637d074b9d8170b06365f575f6cf03d614f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

