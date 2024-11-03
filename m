Return-Path: <linux-kernel+bounces-393912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB38E9BA764
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156C81C21BD5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 18:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11534189B82;
	Sun,  3 Nov 2024 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDz/ljh0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C48F1865FC
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730658557; cv=none; b=El2SrMoZPIx23+efSNqvP633nR+LBurkXBYJNS4Jn0sTMVI5Hfcsw8sVf8GfmD42c0xKpeefzexcH9OTUB8wUi9OTBeBghnKpmc7IOeRPM1Xt0dSorSn5gk2g0m/IsWCOdjheOQ5akgF2NSiFHADagcsDZz/vlvALW/YUCFSAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730658557; c=relaxed/simple;
	bh=QvQ6Unim3yhmfeL/UG/mIECQmPXZZS82j3JuWlckRqY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DFEKV5gsdGg2mrockAStLzvBA1cxggWPPyzRC8AasUyrzLYJ6biVng2Vzu4JwT4aGahuEHZ8gj8tW42SAuAN/O+u9HOlZgpQrgm6wkCKo+gV2WIstJ6YnfmZxZb6NCMdjmhb/jB3KBqp9p3X+S8VGjnC6JirO0azPrKxFJK/abA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDz/ljh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E01EC4CED5;
	Sun,  3 Nov 2024 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730658557;
	bh=QvQ6Unim3yhmfeL/UG/mIECQmPXZZS82j3JuWlckRqY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pDz/ljh0Jj5CgD5k1CDM0e2Sx8hTs02UfJA5A5LXt6uYaKHVwX7N4USBVpaUQDDOK
	 SHMxP7atsuCP/+fd4cpMtgCVwO+HAtPajTu898TWQ9XuagJICf3jfz4x8gn+Ci6Hv/
	 sYmh1IdI3dayFnghf4t1UZykA97RS6XV2ray6Q4RKwxiTAGhH81AC6wYInCHrMiRha
	 m3pAeSvnv/DgVzlKvhtuSiKFTotZK0rGStEITnaDYzh4Vh+g5tQUF7AcdnkKDp9oRu
	 +J+qBs2tfANktvu6Pofd60ie1gZStFdWLR/s6orx+FjYkIX4JRNZcAOmLO2Bm3rTsi
	 Z5uw3zsCi4mEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACAA38363C3;
	Sun,  3 Nov 2024 18:29:26 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <173062983493.1467946.4360836633216822317.tglx@xen13>
References: <173062982864.1467946.2540622433845043721.tglx@xen13> <173062983493.1467946.4360836633216822317.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <173062983493.1467946.4360836633216822317.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-11-03
X-PR-Tracked-Commit-Id: fce9642c765a18abd1db0339a7d832c29b68456a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9021de3ec2f39074aae92ed69c3823e30cd8cdb
Message-Id: <173065856568.3226528.7679001559664545576.pr-tracker-bot@kernel.org>
Date: Sun, 03 Nov 2024 18:29:25 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  3 Nov 2024 11:31:05 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-11-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9021de3ec2f39074aae92ed69c3823e30cd8cdb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

