Return-Path: <linux-kernel+bounces-414947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 957FE9D2F92
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D15B277ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A22E1D5CF9;
	Tue, 19 Nov 2024 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2/axOol"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE461D4325
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048528; cv=none; b=BUaMEWww3Xtl3uQ+iCrgKmW2njHVi+EoJqxHk9Ga07xMjaQR9BzbS6bGHdlYPkcyITRE5coVqDj5g1OQPR7qRlxeGnTh8/XkGV5/C9vpReTjelma6/7DLTO3NigrtWQ+vGdjSlFbzDBKPvcmmn5YadmgGihvlCdlaaW/vh/lpPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048528; c=relaxed/simple;
	bh=CRMZvB+rTuii0v5piZYk7dj+pT0NxaaT242lqSpTvuA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SUAc7LXzaQK2kC3cGaUzx0S4EyzzU0JsVc9YBvHRSJ1+uMj0zqjVHFEB3HYKdfXgE0KcjHBvoqFbGccK0TgsNULrC0eKVHu4Yiw8nf4Fccqhqh41YoP5lKn3SOLUcQ0YohoPokoA6ri8lzAmVt+C/gUPlpIzCdMXAiypyLC6FHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2/axOol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62268C4CED0;
	Tue, 19 Nov 2024 20:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732048528;
	bh=CRMZvB+rTuii0v5piZYk7dj+pT0NxaaT242lqSpTvuA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q2/axOolbPQy6Z8jW207URSGXFqu3VRsn3bL++DjOWQyzer2k8KDwfMy7Laj6QCr+
	 zgXiAwq9nuUdgLFeuPtC6qAVT3KbIbPKvN5DPY8CpsP4gRoSsgnaonDk45zLR3BTgh
	 G5QHItjveWbEq73epuUR6yhe3SDKyEaKgAMGoNKO9sy1aOzRKXbp1UJHZb1Fb7uCLM
	 VWLSAoolNiXPqMvx9x0WoEYii1Z26QYGgGmiwtAN3IY6vsxBNP+SGeAhjG515Bwxf1
	 eJbuEcyZ61Fa5LgV40lNNJhHKlYK+K6+7Gzl96uhrpnyOuBTdoKmt8BqZ7vylYl5DR
	 ubGZNb3pSw+kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A3C3809A80;
	Tue, 19 Nov 2024 20:35:41 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118152204.GAZztbnHMPrcQOkacl@fat_crate.local>
References: <20241118152204.GAZztbnHMPrcQOkacl@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118152204.GAZztbnHMPrcQOkacl@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_platform_for_v6.13
X-PR-Tracked-Commit-Id: 90f1b42b179487ee77d182893408cc1c40d50b13
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9db8b240704cf66b8c9caaad586034399ac39641
Message-Id: <173204853976.680579.11617951808287726342.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 20:35:39 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 16:22:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_platform_for_v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9db8b240704cf66b8c9caaad586034399ac39641

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

