Return-Path: <linux-kernel+bounces-332568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A914797BB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F163287603
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83308189502;
	Wed, 18 Sep 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuUIHQ3t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E5188CD1;
	Wed, 18 Sep 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657808; cv=none; b=e4qO+8A4AmuCkfxRmCC6fK0b+e3qtdRsvKrclj9kEYYmINsnZkhtRlj9r0zC0o8ShNLx1n6HaYYdjrEySCZyJvbZg1voHrT3qB/tChTzeHAHO3tAZywf7PtTKlwJoOWUYJ46cS0F5/APXEBQT1nh81+aEEYtajxXynq4dbCFxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657808; c=relaxed/simple;
	bh=rtPRlkdGorwDPZzWdgarBSx3bWJ59nx3suyVU27QaGo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pD2Bydqv4bQnNKyTMa9A64xpy4+rjsk9jB8B91a2cTyOPmChQy0kSxJwvUunjsnLHMdCtidX2yqh1dlQOkQOq7+VxJ3sdJdkRkTMOyN+pdjtz8e8rw3B8ZNEEl/5z6ljwrE48X5fcteVnHBFvV884dMhBR2E7oJAiHSuv/VqrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuUIHQ3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8375C4CECE;
	Wed, 18 Sep 2024 11:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726657808;
	bh=rtPRlkdGorwDPZzWdgarBSx3bWJ59nx3suyVU27QaGo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IuUIHQ3ttj3V5Q+h2d4BlYzWPMSGMemFIkR0g07YXKzELtEZT5IkRtt4GJzw24gMg
	 FcBlQngAxlyTKU78Ba3sWovSnCYQk6FUXcCmXUfPCTMc+xHqtYpYuLydXh0x7KttJn
	 kQFlA1IiT93Fq/HySaCIYw2BL+Yoxt42a7whKYEq3Wz3llcRpPHbhQcf7EI1GwDqj4
	 xSOylgKbDruZMLR44+k7o0xqFi7D/uD9W/ObDgM++RldS55QOsNfXveTzXCxF6aORL
	 MncIwAZbD3DKuGn4wvhL57Jj6D0ALR+nuNwj59J18JjsulZkggAQCSfFKTSlFqXxPM
	 vhvLcig310J/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AFC343806655;
	Wed, 18 Sep 2024 11:10:11 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZugbipY0rOAd-y4D@google.com>
References: <ZugbipY0rOAd-y4D@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZugbipY0rOAd-y4D@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/chrome-platform-for-6.12
X-PR-Tracked-Commit-Id: d1b35e6d34e9b46fbf98444dd7aa114c032e9ac0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f39757957c11677ceb4600c81888db12b2fef5d
Message-Id: <172665781064.783948.5077859419862391817.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 11:10:10 +0000
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: torvalds@linux-foundation.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 11:50:34 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/chrome-platform-for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f39757957c11677ceb4600c81888db12b2fef5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

