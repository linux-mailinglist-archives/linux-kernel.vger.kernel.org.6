Return-Path: <linux-kernel+bounces-178275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2C38C4B53
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86394285C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72D838F86;
	Tue, 14 May 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkxviAKc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E1822EFB
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655091; cv=none; b=i7ZRqnf5KyCs1mpyQJK4bX+TLl7ATTyJ+tw7t9kQ+YsFSaFWBNRouPxbjNFLZcL3oldWYYCY6mMPm/A78gEwGdbLVqzgh+87mIk7vq4gfZ3A5arZyhjBItmxT87ETLLS73xoVKgP04eiwFH2s1puwxMY3U6ARy/fCFEiSYYqzT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655091; c=relaxed/simple;
	bh=b+Hfo1JdZHjiBs0GAiMPq9NXBBaYMzepfG9heJMpMgU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=T9ob2th/iaTBAsCrI8RdZiMebZzK1N8b1zLXnN4w22PXsH8tp8HTKYD03mIJuo/fmiePnI+hkemElblq+20N9//ebxYrI2L2wawu/pg46GSnTpmGBnF8WPq8Ph0rH7wyq8x7KDjq+oi6P4Z07zGGJxKt5k1uHoajXko/62Ha284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkxviAKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B7EDC32782;
	Tue, 14 May 2024 02:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655091;
	bh=b+Hfo1JdZHjiBs0GAiMPq9NXBBaYMzepfG9heJMpMgU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VkxviAKc6zgK4fhWzaD9KN7m2CKrb80fD/4oQ6y0xs/ZPYm/S6+j/VQ9XHk8EJc+8
	 qw7iYa1ADECVSJwhxCi2XdzftwW2C4AmtVfUNCDqINNohj0FE3rOaa2HK9x5xoOcxi
	 JL9FD88poxvkwWltExRZuuusT2a0RlxSZ+9fohwZkKNIiMP4hRCFW7fgaeLh+kN6iR
	 uE0CdhGmF/oegT/J3iTwltk91WKpdZN1z1Jh/loZPnm4KOpWslmVy73/Rv70s2xmEi
	 QDA4mUUcA87uz4+/CefA1wXRAmNROiAuQa1t0rzDjm/VKCWm7Nc6aq/I9x/PcmVTeN
	 vM9dMkJ6xV4Tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 337E8C433E9;
	Tue, 14 May 2024 02:51:31 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation/maintainer-tip: Clarify merge window policy
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkHKKvyLJSy8FYoU@gmail.com>
References: <ZkHJRYpDIBpxWeyz@gmail.com> <ZkHKKvyLJSy8FYoU@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkHKKvyLJSy8FYoU@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2024-05-13
X-PR-Tracked-Commit-Id: bdc42c8b9befcef6368be345004cee3da1ace955
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 019040fb8144fd24097e8260ec0fe231634bfc81
Message-Id: <171565509120.649.9108329102955506702.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:31 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 10:07:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/019040fb8144fd24097e8260ec0fe231634bfc81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

