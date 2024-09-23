Return-Path: <linux-kernel+bounces-336352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381DB983A35
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FAC1F229D3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146F413212B;
	Mon, 23 Sep 2024 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIDVRMrj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73251130ADA
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130875; cv=none; b=s+j6LSv2BGMvX7NHtd2/i3Gggk3pjJ4lau4vyfeP7FKoVxMieIMjlD814pNvDpdUfwpNqtt8IE8MyUw79T2Q8RSC6CTWJWEwGuZb23NsncTnNiDngT5sgxBordKbhCiqiAyD/FXPnwVeDQnUkeo2fAvumvWmi9WcHL7K9RJs15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130875; c=relaxed/simple;
	bh=MHI0iVieP78AOzIEMTgRZhEWF0/ZZbekU5lsPYEdYgc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rlAOBXkhy69aqt2AQ4jpx3MgVl1j48285nnUikn7IpWrIUEll5cqNsQFtF/N4GnaCaSy55yg+sIfY6I4ijjiZeYC0+7uqlYKcVcPrSY99vytsR9JrocCqkTEyn/aDzWQEjfuFZSbM+dLKHHO8DWr8wVfJsvgpadHsANwAEJN0Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIDVRMrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58967C4CEC7;
	Mon, 23 Sep 2024 22:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727130875;
	bh=MHI0iVieP78AOzIEMTgRZhEWF0/ZZbekU5lsPYEdYgc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aIDVRMrjkhxXCDjEaqV3lMoVdvwGNSZLI9o8Ci1jlM45fKYPNZ6zNGJoUCKBZQesz
	 TVLTVT65rorBTgOeg39dYL8ZKeVYcMFNTmJT5VIGwwVMInvvZAD89E/Z3Q3aIkmALK
	 Ru1UzyVIzj1KZwugO3rq/Pc4AuP+xieeEy+IBrvyfJe7NskQkVWaS7SZOXxuH0JUQ8
	 vqxvWOoHS4w6KWRzxcaklvciUMwp2DrmVrzcWYycMzfkgBZaLfumil8qAU8Lyw5pCY
	 TMRgS31K1F8JB9m1spdRMnJQs9CBsv1unjZEOUFIzECpST1N+XKKmJHRgUj6rCImHK
	 z7/RDDQFJorKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD3A3809A8F;
	Mon, 23 Sep 2024 22:34:38 +0000 (UTC)
Subject: Re: [GIT PULL] firewire updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240921031421.GA227826@workstation.local>
References: <20240921031421.GA227826@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240921031421.GA227826@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.12
X-PR-Tracked-Commit-Id: f1cba5212e252243a539e079813bc96fbf53e241
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7dfb07d4dacfc3d8fa553fe76f055724e2c7210
Message-Id: <172713087760.3509221.1216982463269803903.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 22:34:37 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net, tiwai@suse.de
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 21 Sep 2024 12:14:21 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7dfb07d4dacfc3d8fa553fe76f055724e2c7210

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

