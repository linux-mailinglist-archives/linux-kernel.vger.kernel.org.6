Return-Path: <linux-kernel+bounces-414867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9341C9D2E93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8A0B25AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A63E1D2B0C;
	Tue, 19 Nov 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdQLS0uj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB21D2784;
	Tue, 19 Nov 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043182; cv=none; b=WH/HW8uJTamJ7cGXaank44TVvUPM8sM+HhplSDYIWp7dK1vB0I94h64c/3XUPUiWCvV5UmX9HueX9EY7CSO82cHhiVQaPsPnQuugtxhaVc0aTozc4N1YS8lwvnI6A/ZjY68W0AZf9CFRdtyknvIq6NNp1wu3/Rad7i6d9/4ult8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043182; c=relaxed/simple;
	bh=CzEft+ZmYYxALvBFMC2t0UyGNGa9dAFmsPsKpkUovcg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tnWwnhgm6eselCgTRPMYJvCHEWVxCW3Y2qj5Ad0l8qqalOFZKgJMhN1nTmaGUVPLWyrJ83eaDsD+8WxwTdJLu2phD0dIc98/a+46PF6BGWXvoCI9Eq/4K9e/oPWgXJscMRiPSy0dBIZxjniLxUwbPUCw/O37BO7yRqx5yZDTA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdQLS0uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8453C4CECF;
	Tue, 19 Nov 2024 19:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732043182;
	bh=CzEft+ZmYYxALvBFMC2t0UyGNGa9dAFmsPsKpkUovcg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LdQLS0uj1XKMroBukxiPdl8jA1DLq8EVrwxIkQSfREBvxmhs0k0S90v4atDt3GSM6
	 L5/F8UFjI7SaQN6U/QFiRn6C9W0kxOjBvM92Hbv5YG3TARzSvE52JM1rwNVS2T3UKF
	 3dIM6CUhAbSQDqVZCsXjcyAsI+ZeQYbS3Y4YPcO9IXjfYHQwc/0OoRCG6jIefo3hRX
	 NG50b3hx0RcmHbB6O4OMrqchL0JWitFZFdGKMiZhhY+77XjDpzU3VsLEXRzhIA+MFi
	 s1TrgY6shh4n9eN0CJELfOtHSNnLrzFtmcm7UjUS9aOA+zxtuOCL5Acf932i9WkSXy
	 JCtnvX0W35INg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AA23809A80;
	Tue, 19 Nov 2024 19:06:35 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform-firmware changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzqLJjQwz0adE120@google.com>
References: <ZzqLJjQwz0adE120@google.com>
X-PR-Tracked-List-Id: <chrome-platform.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZzqLJjQwz0adE120@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/chrome-platform-firmware-for-6.13
X-PR-Tracked-Commit-Id: 32b0901e141f6d4cf49d820b53eb09b88b1f72f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1af29b34ea7f63c3e7225c324ffa86c9748874e4
Message-Id: <173204319393.653509.1459088463985292830.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 19:06:33 +0000
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: torvalds@linux-foundation.org, briannorris@chromium.org, jwerner@chromium.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 00:32:38 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/chrome-platform-firmware-for-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1af29b34ea7f63c3e7225c324ffa86c9748874e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

