Return-Path: <linux-kernel+bounces-574659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D3EA6E830
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E37E188C48C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F6319E98B;
	Tue, 25 Mar 2025 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a66hl6Gd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF419D88F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867883; cv=none; b=Av3Y8EL+rI0sCEXJGAMeJfpT7IFKK59d7U3toWMWMDIod6DdaBhlbUXOupSPyaS/EHyKMqkOr/C+IUIrrphXrniOTIv3uqI77/fIr5Vb3jgV1z+Z4xnmn1JfpcFAyU7DAUPIcTpTccVr57OBcsDi4mBXXYk8ftaFo3SLtX5crm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867883; c=relaxed/simple;
	bh=3y5WpF7lNXilRICp3VdO/ZVTWMQ3jk7HoGus36DCtuo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pfZTVkyCdA/XT10Ep+kJVAZ9spCuNaCGUgukxOTOdHWG9koTD8gwIBhlB23ay5dTqg3Fs6Vahma3nW1qOoRx13+2rMp71TH02dh0WxGtZTqW82RdLXBtF3YuCGAobEPnhCSlRE4BUjM+YW2Uq88QISF4/lxdGn9RhcPTZxC6WN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a66hl6Gd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751EAC4CEE9;
	Tue, 25 Mar 2025 01:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742867883;
	bh=3y5WpF7lNXilRICp3VdO/ZVTWMQ3jk7HoGus36DCtuo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a66hl6GdHdQZ+R/8eL6IbWMsVwqeribMg59yFI0QnKZLbeN02r0oRVZfEhI0qRujQ
	 uukqO2c8Rm1DA4GAQS+VjJ1YLScDF0XpxPx1t9gLvggokAGyWkYhHQWHA25LMAbmiD
	 5D0q75MYqntRqQdQFS+dBJ4UkelrKgchz0dBV4LliL9aJajWGwkYieMvA6kKECV7uS
	 F1nO0234o5iMiF8gNpTRlhzkR/vo1fCtwIRku2MA+1Y68YqQJVAtN7ySc+MR2K0kBU
	 lhtajxPyXtZb9jyWW+pumSP7I4v8r5bc0ps0fyqpg1BoCgmYuoEtjD5pTlUdxxwqb1
	 xEWe2LS/nmbKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB560380DBCD;
	Tue, 25 Mar 2025 01:58:40 +0000 (UTC)
Subject: Re: [GIT PULL] Stop-machine change for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <a64ef1d7-95c3-487d-8c72-2343580bad95@paulmck-laptop>
References: <a64ef1d7-95c3-487d-8c72-2343580bad95@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a64ef1d7-95c3-487d-8c72-2343580bad95@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu tags/stop-machine.2025.03.21a
X-PR-Tracked-Commit-Id: 2af8780d6c8addecda5a0f624c4f084a3a9578fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8541bc1a52e7e8facd67cef1e659f5714abc95ab
Message-Id: <174286791952.53720.15844161425385341251.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 01:58:39 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, tglx@linutronix.de, vschneid@redhat.com, neeraj.upadhyay@kernel.org, frederic@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Mar 2025 16:33:09 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu tags/stop-machine.2025.03.21a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8541bc1a52e7e8facd67cef1e659f5714abc95ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

