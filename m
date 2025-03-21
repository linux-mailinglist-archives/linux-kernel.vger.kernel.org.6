Return-Path: <linux-kernel+bounces-571753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 996B6A6C1BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818FB483346
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0382622F389;
	Fri, 21 Mar 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsDxvCCs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428622F16F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578754; cv=none; b=oFRDmMkpeCYwLIAoktpFzRX+iCCfyRzHBdocJFvwc3OtFWFzVkDUOUqTscvm5Xrr4Z8k7+I0MGAWhZoiGK/IYufXRlc1j6QO119PO+qbKB+11TJoHgnYQt7eRGIwAwk8LNv+t1gkf7BmatX1rkZKOwcNcF9VL+uRiRJHv2mXFqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578754; c=relaxed/simple;
	bh=pLb7+YPMuCyTjvWl9uPCaisWXl8mmNw/U/u0RPKhX7g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RMSjJXqM5nprR5OJT8LNl2PpilfEgv2TUsHdQ2e+H49N9Esx3bmWEslX6Suy8VHJmq1WMlKfpjZydf0ER/W8Zk0hzxb3nhkyV1njMozP+sM2eQR0tBsYhbLCB94M6JRN0yt2Fhh46NBdcH/SPQIser+4F0n52fx9WPRYwkrdjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsDxvCCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44850C4CEE3;
	Fri, 21 Mar 2025 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578754;
	bh=pLb7+YPMuCyTjvWl9uPCaisWXl8mmNw/U/u0RPKhX7g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JsDxvCCsUNQTC4dzPzCJg5MlRrZJMl3sp4mSFqYXs6KdkRHTrmYLcUn3c9VdVkKg4
	 OMo0fRrBKSWV75dn+fR3M+SWeIswPFdfsilGyC5MIfkWR2Iv6EhCX7NfXUvpRuDg2j
	 mkgI7TxWUskY8y7asVtmpY5NXJJWzuRvCQNZsZsL0gDxELO+bFiMNm1PpKXkhvjZXM
	 ig+JwiX43ky14t7FEMjih4VSfGYN6b1sOXdfd9dxRaB1wNeEaGfCpq+Olsipxwlgnm
	 q+Sd1nQp/qR3BmDo6rB4rMDZbfFjnbdr6Wa3fYoaLf/oJM4xTsNIsXajFjn928Jbx+
	 af+KLQC5Umbiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FE73806659;
	Fri, 21 Mar 2025 17:39:51 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z91B8ILV-cXRUULf@gmail.com>
References: <Z91B8ILV-cXRUULf@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z91B8ILV-cXRUULf@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-03-21
X-PR-Tracked-Commit-Id: 7e512f5ad24458e2c930b5be5d96ddf9e176e05d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c7474b5449ccda2f0139e87425845baa2dae15a
Message-Id: <174257878994.2568142.12500563567789188752.pr-tracker-bot@kernel.org>
Date: Fri, 21 Mar 2025 17:39:49 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kan Liang <kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Mar 2025 11:39:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c7474b5449ccda2f0139e87425845baa2dae15a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

