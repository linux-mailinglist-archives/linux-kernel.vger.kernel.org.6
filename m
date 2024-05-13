Return-Path: <linux-kernel+bounces-177944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE88C4686
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F74F1C21C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308582C19E;
	Mon, 13 May 2024 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wt0L0o9L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021017E;
	Mon, 13 May 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622889; cv=none; b=mJC3l6Uor0C58bvUOsz9Fyz+CRtXvZASVAMOw+0SNVwsoePlSY5+UcXARnU5587QqviOHeardJycmBHXw6mKe+EdK/epotKM9JSZkhPXc33qvbxMmrHI26DutuxNvV7nQ8njvStKpX9w/U+8XTK40bbD1fUQ8I87ys6tKbA5ius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622889; c=relaxed/simple;
	bh=BZlNGeF1vn7xIEY4fEeZ7yLGUllZWyfrhiPxgyW4Sic=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HJr8AxNAGFkieMeEAdfn1at9CYVTxm5EFxLafM4D9nBn9PqCXwJHwebwPPvPcorVCn5f5WfGp57XMhzbEWzci3ucpY9ea5/Irk5qzn21gPSePCNq7x45lRhhXKvUHZuBiMn3krWO7Qle4UBXAeu7378eeYIwU6ZJOG9rv9Vl2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wt0L0o9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52367C113CC;
	Mon, 13 May 2024 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715622889;
	bh=BZlNGeF1vn7xIEY4fEeZ7yLGUllZWyfrhiPxgyW4Sic=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Wt0L0o9LCrlOxPmSFuK06klcc+gEDqtpV0DPBQ4BSCkpm/2ipzQjwURw30RqsKNDN
	 gbnZMWJu2ep4FFYJSJM74WbUsnGAGZG+x2Vvt8PJ0tZz+2fkDSO3GS7Tnv7xgJPh4+
	 Czx2l2dCMMvOGa11Vmz1d0EbrLrSth/tnVBS1Cte6CmST8WLKREFEwPqiiZ62NElTv
	 cvBCXkT19fnEiGyTyreBvVRfsVRXU65ss9BbZQTcha/ZY1Fb/TOMDeApN1J5ROZCUw
	 jn8SkjR6BRsRb11vBDxiaoKpIR2UptcjHC+QXKWjMxpmnKdKra9rfBTrkgjgHvcVD5
	 eT56+AD6m0dlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4793FC433E9;
	Mon, 13 May 2024 17:54:49 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <87fruqc37u.fsf@meer.lwn.net>
References: <87fruqc37u.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fruqc37u.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.10
X-PR-Tracked-Commit-Id: db5b4f3253ff73bc2e926ec76e1c0f662b38d9a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8815da98e06a930ce7e6a1ffaf1b1590e79fd94f
Message-Id: <171562288927.13947.11408353660355777511.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 17:54:49 +0000
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 09 May 2024 11:19:49 -0600:

> git://git.lwn.net/linux.git tags/docs-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8815da98e06a930ce7e6a1ffaf1b1590e79fd94f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

