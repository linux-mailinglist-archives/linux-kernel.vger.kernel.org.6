Return-Path: <linux-kernel+bounces-198366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6598D7731
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 18:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69234281A6B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 16:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BADD57C8A;
	Sun,  2 Jun 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL0LpSb/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD651C42
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717346474; cv=none; b=dor42PnLMbOwMv4b3EgSXov15QcCquh5Epy1OhmWYExRfdvStU78bKfR0oeZZWTWPpWuaBWmqNHqml+Yj4EmuvYQEX4poCPczaLgMeBYLi7xMNKLXjZOG/VME55GZeiYW68IJY7k4YJgd0HHnvRjDiVGTs6mtW8GzfB9+0f14I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717346474; c=relaxed/simple;
	bh=CindYV08YwNVlgv5Jkcxcl86mPBIYnSvQpQAFG6Pvc8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kJ+ak/0dADf73qrSybNwoe5oD+PF2aY9cqlHXZTLQcQgnKKQAejICQJPNRRQ/4SwIfrzD5iObv9yQPCcyfD++Up9wBGZR0uWc6oIeXeDuZh/bme5t9+h8Fu4bovvQ67/+2Wqph+ykhreZScSn7qyBgPArAWNAho1h5vJ86Q0STs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL0LpSb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38A54C32786;
	Sun,  2 Jun 2024 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717346474;
	bh=CindYV08YwNVlgv5Jkcxcl86mPBIYnSvQpQAFG6Pvc8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JL0LpSb/R8gqK61Hmc7YU7xKb98FfvNI4GfM4TQQcfroZMoZsw4kbwHZSsj3VH2Fm
	 0+isZ8kllrNAIa0s09ReP81EkmLGZcDXw9LsWLoI2k6PsukhkG8pTMxd6m65AKWNMX
	 brt7gqnHtrTBYxEOjsRIRB080TjfbuMVs45YU8MAkd+Hdcy5qlmQRbB73o8h6LYUu4
	 OMkPKqLFcmPJs5X6AALtas8Pdp8035kRUcCpwBh3ex8NlkbcSfCqvlGh3KlZFh6PNZ
	 vH7+3MnHKZzK7kwWEVIcYnV8eMfqu+ZbKYEvsk13CAkc69R3QQJfJJrH1n2YnBnMio
	 7G/l01+HMILAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25190C4361B;
	Sun,  2 Jun 2024 16:41:14 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZlwahYzxhwYTa7IP@gmail.com>
References: <ZlwahYzxhwYTa7IP@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZlwahYzxhwYTa7IP@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-06-02
X-PR-Tracked-Commit-Id: dc8e5dfb52d56e955ad09174330252710845b8d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efa8f11a7ebeb8758dcd847a4b9a0cdcb68d9d87
Message-Id: <171734647414.21593.17250070694542433855.pr-tracker-bot@kernel.org>
Date: Sun, 02 Jun 2024 16:41:14 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 2 Jun 2024 09:08:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efa8f11a7ebeb8758dcd847a4b9a0cdcb68d9d87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

