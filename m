Return-Path: <linux-kernel+bounces-515549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0305FA36628
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9355E171EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BAE1C84AC;
	Fri, 14 Feb 2025 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPYNfd9O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2DE2AF16
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561335; cv=none; b=N08R+JZLUNE4LxhSd6TZ9MC2gBOJZJgpClWIeHjwxJlTOiSFwnzdWtMFCqa87M0+WYmsHMpdXIoCZsWOSPtL3lkLmtb36GAZRn8R8tWZSmA4Ij4ahgPy6YOr5QJjSHij2YJ/gO0L8nKFfcVcsNeSSrizo4Dnfhy7CUBn6oIx088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561335; c=relaxed/simple;
	bh=t9EkPDT36vEYRvlk4JqknyHm+B0lAvXvrkbVcUsqtRE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PSPxnDTHYRX2XXeNy8x2r6T1zI3MqmBO4xDFMfW9YqdGQ1Va7Vsqki55l2ygeDKjnso1p/uaAMBcWj+rr4xWPg3C/kpvWXZq68z36YsIIa7F2uQohbYk7Et9rKvSqw3vc0u+szj+6g8TKQvYgdmlVyNOTJTaeKTVZJznQSFYNyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPYNfd9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BAFC4CED1;
	Fri, 14 Feb 2025 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739561335;
	bh=t9EkPDT36vEYRvlk4JqknyHm+B0lAvXvrkbVcUsqtRE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kPYNfd9OnJambKVJisEXQUjCrktfh5E1344Rm8akgdm9kB+ZSgnv1QxoMQU28na+W
	 wg0pfnSwWNFq5xo9PnqHmoY8xBUatHGfeGUeLu/CbRQRV/R8xgK0HwzGHfWXu1A6S/
	 PX6jHct/MxC8pYy54+RMXnJnQEOMC/8UXOFCFgojJQNhxZz8ifKeby5n5goOwKApES
	 3Q66VKKZ7hscLhgHGeSyd/k1tjrV51QGKNLUD+VnxbeVZc+aK9Y0DWRW4b0W6F7J5L
	 FQijzKx+1MXzsZNXgesgRtxRNlYet2TYWPD6NgFGhSWHvNAjDNcJjIFR2T+FZaSf1H
	 M0ZVloWBa/VvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC11380CEE8;
	Fri, 14 Feb 2025 19:29:25 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250214140431.GA13374@willie-the-truck>
References: <20250214140431.GA13374@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20250214140431.GA13374@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 446a8351f160d65a1c5df7097f31c74102ed2bb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 111b29599c189247919a514b6c3a93e828db27c2
Message-Id: <173956136427.2081923.9703476748325422748.pr-tracker-bot@kernel.org>
Date: Fri, 14 Feb 2025 19:29:24 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com, ojeda@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Feb 2025 14:04:32 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/111b29599c189247919a514b6c3a93e828db27c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

