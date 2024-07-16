Return-Path: <linux-kernel+bounces-253312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6EA931F67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D65282500
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B188D1CD2D;
	Tue, 16 Jul 2024 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcvgt02m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DE61862C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721101300; cv=none; b=QyG37A91LdHxqhmFkb/xKgwIQ3/80/Agaw52pbouFRLjlSEYgHoS3aefSbRoBvrt/gQqUaXtCL/q77zUyb1jpU0120zcHkZKYU7FOBEJIm9ElUoCH96D5d+vbAu1KjbvxT8BVNYM0SKmO8PdLZPth5Nkc69vS7gHGQ/s1V/KMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721101300; c=relaxed/simple;
	bh=SQtWum46g3JiZblCiJXjC0sDuOPFr43YmDX9GgvVIhA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q2Db7LXgE9PlCHCzCRwc7hvurfsfKOLuCkfMAj3MpgsGDyGKZAiJWEeL+yWy/ThH+JpWZKYUE2bL74OYTmUmpFI681e4Wbppf22wfZa+I9nVF349t5qDOAfZSddysx0ywzuRY1u4Eh0IWLGnrJW8q5FK72gWnIe2xcwc0cW/a4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcvgt02m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB5DBC4AF0F;
	Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721101299;
	bh=SQtWum46g3JiZblCiJXjC0sDuOPFr43YmDX9GgvVIhA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hcvgt02mXjuEVTKDk6+ymn8YqNnADkLm9Ty675WeqyJVJ+jL7OlSSpoGS3v6Edkrq
	 rtc4L6jlq7wqNwLSW0sSa/e4OIE6PzSQSdnPU5bhWkVeK9L9spYovn5LTMBfuHN/cz
	 tn9sIWz0+9f2S1uMvRY/99MUA/u/H2oVyQYwQTwxGEYqoQSiN5ymut34RVD0lsWDJg
	 Hl3JERk4hrCAMdBpA5JJHdVoZ1paRDxQYQWk0H+3xDJ8q6PcmmGKWkAszVqr9c5ile
	 j8kLQxcVRsDNgnci09AgBmq30+lIWTVrxRn3moqvFdkkRTG3Z182IcRdTyaMBg9OVh
	 GYpFhMX02eRng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7ACBC4332D;
	Tue, 16 Jul 2024 03:41:39 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cc for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715113637.GAZpUJxSbBiAhXSGPl@fat_crate.local>
References: <20240715113637.GAZpUJxSbBiAhXSGPl@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715113637.GAZpUJxSbBiAhXSGPl@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_cc_for_v6.11_rc1
X-PR-Tracked-Commit-Id: 16df35946120fca2346c415fae429c821391eef8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98896d8795d72acf166f83b06c2706effa019d92
Message-Id: <172110129968.18508.998958108701196516.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 03:41:39 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 13:36:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_cc_for_v6.11_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98896d8795d72acf166f83b06c2706effa019d92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

