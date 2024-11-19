Return-Path: <linux-kernel+bounces-414948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC279D2F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394521F23B61
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E381D31B5;
	Tue, 19 Nov 2024 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqPz8Ldu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C721D6DA8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048531; cv=none; b=K+xiCVtSvO6a3rScrgGKCd+nl7d7yFzi92NLsmOK24ox511SQXSFHuc/IcIBDbIq01THxUD2cCSeT2o/idUnUKAWqrgSpjn3KVyhHJsSqWjhV3pka1mVwanj6CBCuVaSHQ69y+JId4Vq2jEB7/MlEKCRtbnjK0Ow/dLzOW/odXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048531; c=relaxed/simple;
	bh=TOQjc+SHFxFmYPSQCxqpzOf1S6hLNJ65zYpZPdVKbzA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aaH90dL//bXH1KcX4pInPp/1HjevNu+V0/GOjftA4j6PJUQYm9Dj8UGo9yCQrvN84dBGrvTFz3njGQt1+xnXUyIRK5V9p7HEpNZXEgNm4AQNUIZb2nTCOznUyzGopMliO8JuvVlrn5837UamjUXdGORrDFUhlXJFtOMZ1M9OFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqPz8Ldu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D54C4CED0;
	Tue, 19 Nov 2024 20:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732048530;
	bh=TOQjc+SHFxFmYPSQCxqpzOf1S6hLNJ65zYpZPdVKbzA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YqPz8LduerCvlpN9NGSJQ+W3r1r6I8bXe93asitsh/PQnEK1TJL67wj8FaKEzFne2
	 7poC5PrE3y2uJUE+rw01OGcoRgLXNy0Ok2WZaeC0iQM31moWT9P8olw681LrOokvhy
	 aLtfND2pcwEu4IePYzhxWqOWNNbeGOW5aoebPcLrYivO5WTY/hBFapbApqk4gdOKIm
	 7UaCTznivjJWCXhZJ6iuuelBr36T/B0bbiEWVGUt17tRjDqf/fih6qn2D0jfZyy9Ad
	 dSVPRL2FHw5QKNc/g11CLsD5owY9Q9XF3l1qGv6Yb3vOvOcitWMqZvbNhLaZccBV0m
	 zJhLYqHNFLEyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DE33809A80;
	Tue, 19 Nov 2024 20:35:43 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118160351.GAZztlZxg0V5LMzeUq@fat_crate.local>
References: <20241118160351.GAZztlZxg0V5LMzeUq@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118160351.GAZztlZxg0V5LMzeUq@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_sev_for_v6.13
X-PR-Tracked-Commit-Id: 8bca85cc1eb72e21a3544ab32e546a819d8674ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55db8eb4565f943dc0ebd1327cbe3d9d684f74e8
Message-Id: <173204854162.680579.7222366720312426456.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 20:35:41 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 17:03:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_sev_for_v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55db8eb4565f943dc0ebd1327cbe3d9d684f74e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

