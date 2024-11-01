Return-Path: <linux-kernel+bounces-392737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A599B9B979D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AC21F23345
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FC31CEEAC;
	Fri,  1 Nov 2024 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk0YtDxq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844811CDFDE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486050; cv=none; b=LJ8+093wILWMTDY+om85DCRM3P8nQVJ1ik+Ldql53fivmpj4Dm3CCPOQYliYjLc/01Wny34x68eZ3yKbNUsYyCw5h1iuV/Y0v3EUvRy54M0xiH4q9u/CgMqLYbrXIjAyE3sy8YSOfCS2q9NPU60+PJSQ2qs5l76sY7M/4G3wedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486050; c=relaxed/simple;
	bh=MbhXJ6KigiiB9kcgFI8fxawUNj7X1a6YEFEE3dOg2HQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tzagkelTAg5oKmuabp/mK771bjzFtG79mBzqMqPZtDNxnfLGHUDtUNvVISVTmdTdvf9nUn6E1MDNOxgboIlgVRGOV5P4zfRPbs/rvWoauRknzVjvQIB25rtMoUbCnqQZsgZwX+wMYaO+5B3fFqR6nB9aLWZ+1ySIpgmwDt4DvQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk0YtDxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4BEC4CECD;
	Fri,  1 Nov 2024 18:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730486050;
	bh=MbhXJ6KigiiB9kcgFI8fxawUNj7X1a6YEFEE3dOg2HQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kk0YtDxqMd3WNWxBp2i3MJVWodInY/669lE4RSZSs5b3xWNjk6OZXYIRHi6CL4WD3
	 c/wwGOKYcuk+GN6RRALFt/lntkmFcj8KvSQaBgjKqOAHyLirXaUVSWqyx6ko3v+U1K
	 HflSBEIyGgUKDCMypj+jqjhPTfc8J9F77osBQscZVMO82OZ+bQtmMIYc6xNn/20gyi
	 my7fX6Vcih1ZwKFntiD8PrI/VZlZZqqmlGxC9eTsYaNvxRXJ5i8rHhv/DWmMu5U82n
	 eFAWDe9XukEgCY0G7/ZTgCl7k7t1iKrPrRWSF6JJHmRgsliYbVl+12CYE6l6HtpLj9
	 nwZDhrR1Fzhtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE323AB8A8B;
	Fri,  1 Nov 2024 18:34:19 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.11-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <mhng-26039e8c-5759-4214-aaaa-765d5736b6a4@palmer-ri-x1c9>
References: <mhng-26039e8c-5759-4214-aaaa-765d5736b6a4@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-26039e8c-5759-4214-aaaa-765d5736b6a4@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc6
X-PR-Tracked-Commit-Id: 5f153a692bacc295f213e2c632ca557979fad7be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a031e154043984cc5a073c1b7fe62abdbe25c0c6
Message-Id: <173048605836.2776063.5580936810338977798.pr-tracker-bot@kernel.org>
Date: Fri, 01 Nov 2024 18:34:18 +0000
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 01 Nov 2024 07:55:27 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a031e154043984cc5a073c1b7fe62abdbe25c0c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

