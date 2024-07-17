Return-Path: <linux-kernel+bounces-254564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF7E9334CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6911B2154E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9599F7494;
	Wed, 17 Jul 2024 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMK6vyd/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD55661
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721177350; cv=none; b=CWYYSb73dDMt++8CHhorlXbQey6dkLmqSkSNAhJcgwqiiU34/uAGlTEd9vqaLnBl8sY/dSen8l/Rwtx09M2qK1WV6pBY+oEHiswqQEYnDFFNDYnoI6R0ELONb+1iHGJdwCJ7HDiujNfRXVNyF8L1QkoeRAQzDbRq6Vqz3oHyM7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721177350; c=relaxed/simple;
	bh=6FkPr4lbqXDUiOYfCtt07AiP8Kg4ZT04uY48cg3MCp0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Tbm6NLmZ3pJYrG9qP6HGuTrMa1BXFe/OdIDUd91omBE8/3XrbHAIP1tegOy6Jq/cGztL2dFbSPS+S8GRVkuPskM+Lg3iAYku+7+ACpgbUw7VztxSETB4OiulifRL10ljbIds2u3KWBuk/3QvXo9nEhmXowjYVttNL3cBHGQehPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMK6vyd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE8A1C116B1;
	Wed, 17 Jul 2024 00:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721177350;
	bh=6FkPr4lbqXDUiOYfCtt07AiP8Kg4ZT04uY48cg3MCp0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RMK6vyd/dHbo5EldCJ6GEiHiCrzdVz89oB7OmTkp5jKMWgXR8gedFjnUMzZnp6Y0N
	 01aXU0SM5ggHFvdis5ppnDFdxaKxc5cKhagAB6wa7bvbWCHk2zuxVhbvHm6fjm/bmm
	 n+bvrV2kGOgo7+q8GA2Aw0IYE9FVrDwT0aLhAYLD1wdbpOUQlZnpQ4LBvEjWFsPb3N
	 82LSqF2fRDVyqXY8MzjBOFRzupyvqd+MESFrbwNHU2lqDqhIvBqkSoU49jIfAQWmsJ
	 XwH4neHPHDqA7oNC5lUEVAsZ7pC1opvE/KaS75w+ganD8Z0IjDUL7sP20vwjmLD/8x
	 hbLnMoQpHavCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A48FDC43443;
	Wed, 17 Jul 2024 00:49:10 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpUSBpYTFbyHtQBv@gmail.com>
References: <ZpUSBpYTFbyHtQBv@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZpUSBpYTFbyHtQBv@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-07-15
X-PR-Tracked-Commit-Id: e81859fe64ad42dccefe134d1696e0635f78d763
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 151647ab581013b482893d4e2218cd29b005cd6b
Message-Id: <172117735066.30434.12719863289764468111.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 00:49:10 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 14:11:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2024-07-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/151647ab581013b482893d4e2218cd29b005cd6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

