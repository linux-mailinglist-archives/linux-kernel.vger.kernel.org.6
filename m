Return-Path: <linux-kernel+bounces-333220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9CC97C582
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700E01C22950
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7658519B5AA;
	Thu, 19 Sep 2024 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPF2SV6T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66E71993BD
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732820; cv=none; b=IZFderkAjnZM7LqzPyBFns3Dq04CxK3Hwowq8yiW00gFjg3ch49MjsfFSSM9sxrv8G1qoVDr5lrBXO9D9U8g8ccrwugdeyzQG5wrJScHVwpTo1BG1oMNktpkGEcMavW9xwjGL76tkldTMC+SHSrEkKz4YZTR/r/6pLH+UKJiWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732820; c=relaxed/simple;
	bh=U2CFB8trHcXhiTfdE/8wRrzfnudCb/jRXfbvyMPvogc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qZTr2dXUlmVLNz+eAV6WSdaw69CkHjNbvGBL+HZTIgHswObVoiOb04ZyzQIgcSmPsk8zlI6uoSeVCjIhYPASAF9loctEpsQbGdRE8HH2WL/tjjs+HdlkLfqh0fgGgmkhzwSBmK0pyycdXR2iRwxCcS/Wvs91z0uL+vIgSE2Wqa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPF2SV6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEF5C4CECF;
	Thu, 19 Sep 2024 08:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726732820;
	bh=U2CFB8trHcXhiTfdE/8wRrzfnudCb/jRXfbvyMPvogc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UPF2SV6TZjQRRbZ9aKvzMeNysGlNtcVjhJq2mlXpO/MVyt7lINa3ebkInhvsH5Nu5
	 fNYKIvuiqpxrKIoiWbhYS9lCP0SQtu+Riic121rpdtjA2qmPt/Wts2ofab7qp7ppbI
	 9oCv4SJ/SJwtr0qup99RHzfMnm1da1TuiSn5IQ7Aj1KgbhSvaTPM+JdDywpDjgERT5
	 OFBiU7h1ZN3rNkHVm4zCj2jfOLAxhrFR+11F5th/UisbqjpL81MNl34l8YzqbR2LMH
	 H4klyJuSGjTcvlw9bB8mQy0m+h6ny+RUqRxuVruAcb+3+pca9GYE/Y/XMp/Xy1Sk1f
	 eviGEW8sFZTdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D25173809A81;
	Thu, 19 Sep 2024 08:00:23 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZutIwdh3ij-tx5kg@mail.minyard.net>
References: <ZutIwdh3ij-tx5kg@mail.minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZutIwdh3ij-tx5kg@mail.minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.12-1
X-PR-Tracked-Commit-Id: 64dce81f8c373c681e62d5ffe0397c45a35d48a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18aa0ddd4ca60571516ba7e41157c3f746e2036a
Message-Id: <172673282265.1388805.11045544112775825376.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 08:00:22 +0000
To: Corey Minyard <corey@minyard.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, openipmi-developer@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Sep 2024 16:40:17 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18aa0ddd4ca60571516ba7e41157c3f746e2036a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

