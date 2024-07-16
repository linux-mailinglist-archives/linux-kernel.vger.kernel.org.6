Return-Path: <linux-kernel+bounces-254485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19299333BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB361F221DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6316143C57;
	Tue, 16 Jul 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB2As7k1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281BB14386B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166221; cv=none; b=pbMIkIPpE812iLqqxeDv9B9a0bJi1SKgZacehOaLHquvENkf2QSZnUkL9o6u5acJvpId5j+NRr9AyY1dJ/otbxWPI+7KlBnoaxFxIa/c+PNW1Vb3jLq9vLxjUhZQJnGOrakStZ69qBXS59tTqY6rgwWn3AtDhc3ZSEm7ny+/Gck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166221; c=relaxed/simple;
	bh=ozfCRrPav/Ge8FGaTOPcggBu+VGkBp8iMGsGBVruN3E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ec+nn7lTUow3APTpf7AVMO5ZjuxStOxkUqIy8TnShDS2HaSFOC3umNBcOkJtTyvtHPU8O2nUSN4MOq7TtYgtwRuArJuNaj5nrqFKluZBCph79EFY2dIy4G8HveSOiQV2rM87kNbJTeQHv27wC4x5CTzzfq/k0CAo+TyFiy05IO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB2As7k1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EB0AC4AF14;
	Tue, 16 Jul 2024 21:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721166220;
	bh=ozfCRrPav/Ge8FGaTOPcggBu+VGkBp8iMGsGBVruN3E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cB2As7k1E2CKl14llA4PFLFMHF0js4S4ef87NvTEozhV2woPPfDdHzzGHXBWGP69q
	 U8rNVqsbpCb6z+N3nG+hdQ7tHgany5ckRGt+w4pnzTj+CiAjp1wh75VIokoew+5mua
	 ETC117kPsTSnbw4geO+zy8pExnEqlQa94W71miIS986QSLysZv7fG1gZGL5dWcsrJT
	 PxFGkeJCH+vKYqBu/WYKyZ48nUKIhIo9rPxcDmlzb/8N5Jt5RRLpFH6NeTI/jCWJOC
	 YyRS8FuzqhtCvO4Ndo/qXRg+FnMFfZkCjM3Sg6wSoToVY/EKbJAI0zusgETPYjdTxB
	 q9ajZJ/txQUfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96295C43336;
	Tue, 16 Jul 2024 21:43:40 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp updates for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202407150923.7A3B3FD@keescook>
References: <202407150923.7A3B3FD@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202407150923.7A3B3FD@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.11-rc1
X-PR-Tracked-Commit-Id: f0c508faea645da58d6ae6b644a1b68020d5a9d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ca995edf838a70c7c0aba2de7fc6da57e22cbf3
Message-Id: <172116622061.23491.12063921967242935658.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 21:43:40 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>, Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tycho Andersen <tandersen@netflix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 09:23:54 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ca995edf838a70c7c0aba2de7fc6da57e22cbf3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

