Return-Path: <linux-kernel+bounces-539702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED1DA4A792
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38EF189CB6E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA8613AD3F;
	Sat,  1 Mar 2025 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9wTFVV2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06D48528E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793228; cv=none; b=dloWl+K1nVlckDYij/79mq9hTjVQko0ecgXhmgDFZ7Uirg0OFsTl/0RvUSaSeSjusYNGevT38JIdmmYBwpOsAtnV8VzD8LZcLlfboJ4Ei6xf7mTzR6usLRjEUliZZTkgjy/wQOCoriMobLqpwi+a/AFdjVX8LJVrSp/EQ7vMXik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793228; c=relaxed/simple;
	bh=ZPI/a+j/Uy0nzq+bLR4kQZsRtFUKydYQDhucbBS45tg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tZVMQ/DaNlfPw1pA6e3aPa18VGjdlIPUWz7Ri5pmoUvmCiq1onhMVLgO1mN8SVDusd6RFXqXVEbU0ekknyAF9ondxufv166apPvUnSsVRYQwVtrJ2WdbU/YL1sxzElJzgYH2iBeSE06ZXI3fQV8D47BRctaRQxiwfOLjeuPMBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9wTFVV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFD5C4CEE5;
	Sat,  1 Mar 2025 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740793228;
	bh=ZPI/a+j/Uy0nzq+bLR4kQZsRtFUKydYQDhucbBS45tg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=A9wTFVV2JZqi8tL7I4MGNXBnhMV+2Z/cc9nJ4vTew+3XmcW/AWExOuHu8xsWrET8a
	 IiDb1aZTnTIlI0ecFvY7gsTjeRrgNF6D0pA6DmnGojiszp5Z9AmYoXe8B70HKt1+tv
	 eOP44uTfa08BoQtjCuV9o7eUIB0stAt4/dV7JSjAi11MHSM/BEnb2L8d3MkCKzjlXV
	 PpfK60dMEP/+qCjaCFZKFAveKQHD5SZCVEteIcd1F41bDhNpfGK7j3Fw8jjW/O4yiO
	 Kwb7LtfvzuhfmyNmnXMkkf+BPAWB12nN2wdcoRmo9ZgZ5zmbsx8jiXr4p8gQ0xdQ9s
	 IBAiDss0ly96Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A88380CFF1;
	Sat,  1 Mar 2025 01:41:02 +0000 (UTC)
Subject: Re: [GIT PULL] objtool fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z8IJuFbHZVoe8joF@gmail.com>
References: <Z8IJuFbHZVoe8joF@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z8IJuFbHZVoe8joF@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2025-02-28
X-PR-Tracked-Commit-Id: b4ae43b053537ec28f430c0ddb9b916ab296dbe5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad69e021288d04f297c097985513306cbd304be3
Message-Id: <174079326082.2333772.14710142557193710124.pr-tracker-bot@kernel.org>
Date: Sat, 01 Mar 2025 01:41:00 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Feb 2025 20:08:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2025-02-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad69e021288d04f297c097985513306cbd304be3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

