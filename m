Return-Path: <linux-kernel+bounces-215986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F51090999D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 20:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224DC1C2104D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 18:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2B660269;
	Sat, 15 Jun 2024 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5PVHDhf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739CA3F9CC
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718476698; cv=none; b=ef7+iTCwGMq0uF3EmS3UvD4/Rpv1cT+kYvrcgl8rZZ66vHStUCplXxq0bE+jlfm7dRog8V540rPs0E+/qLBmt8pQs/S0epTC+puFVXhNRLOEqFGquO2lEUmoUg5FoWV+Pym7EaBh/tpRygofRhFldkXegbg6swU/c3YBVFInzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718476698; c=relaxed/simple;
	bh=GLUndVoMcceQWHbxO17kz0xuVAhrXmKeQLVainaCHFE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SNa6VVV1oWAOHkOFXyveg/c47UGJ6WcfliJ0RrvUxj1oxYnOnUjV4tnlshAdMCAyUvaEa5g84ZNJFeX6Cv2Vd6n0KSklLAmv5yem9g2E3VOBMEcuxbnv51oHyfZ9fDa73pEyj6VM+PoPMFri55myZGzJkNtMBAIFG6iVRjj8F9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5PVHDhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04684C4AF1C;
	Sat, 15 Jun 2024 18:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718476698;
	bh=GLUndVoMcceQWHbxO17kz0xuVAhrXmKeQLVainaCHFE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=T5PVHDhfKvd8nl8/HxXAgwFqCkGvlRJdxsoKSm9HHfMejowKygBOs4qIblV9Y5ds5
	 YUKQ/WzIrDpR1AI2YO1h5GFMAfeADFIk70z7bpd+OtSXUTQG5BEq5DdxbLDpO1nihp
	 9k7tgvplT8laLrsUut6XJRdYDyO/ffJ+mvGW9j17VkYUasqIaNMOGeDW/f0t3BygXB
	 5hT4g8OBLW2B3iiF2Ywo2zNExgeZwaAwQLTmqX4RnxxMJQ6wKHHWvwbH1UXsNSeOfz
	 IBpEM2sHERDQUGvzayL1FcwABglwyddtpcohnBDErM6OQVess5/1Sg2EcQTmvXQ/qV
	 ZhWlVQIniNHlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6454C4332D;
	Sat, 15 Jun 2024 18:38:17 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zm1NIOnj0NR3U8om@gmail.com>
References: <Zm1NIOnj0NR3U8om@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zm1NIOnj0NR3U8om@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-06-15
X-PR-Tracked-Commit-Id: b2747f108b8034271fd5289bd8f3a7003e0775a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08a6b55aa0c66b1c4f6ff35402c971420335b11c
Message-Id: <171847669793.27128.17906362481210444161.pr-tracker-bot@kernel.org>
Date: Sat, 15 Jun 2024 18:38:17 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 15 Jun 2024 10:13:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-06-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08a6b55aa0c66b1c4f6ff35402c971420335b11c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

