Return-Path: <linux-kernel+bounces-333105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC3997C3D7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF141C22F71
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86B122611;
	Thu, 19 Sep 2024 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrtjQnVD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59620DC3;
	Thu, 19 Sep 2024 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726723207; cv=none; b=VRrVfuiwLDPJb08opMJj2UTrn3X2G/CUZWpaQ6N6iHC7nbKtmGSVp1yf4vLoMWAG8DSE/cN14krldrYHGfLZs5ncycJSI96KxQU5NIUp7B4dxctMHXyDWUjWkCbieKBEs+87SVPX61/g5pH6V9kUKUpTpPKwlasRCM01qdxm9qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726723207; c=relaxed/simple;
	bh=3dBCnoo8xoMidFhLHa1R/3mGHDzudsxjfApLYuWSVDM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b4FJQjbCfG8aJ6+2kay69GwHslCAAPEKrWU9sZDgAgn6dE0MKJQLuXT7owONxUZy6UL6cps9Vj91PRpaFwYIQ2HtZzE94eqD8OKGYFKguOjoH4LkkUwa1Sc0yxxO+H9s/THF1OpXQFdlIUGTrWO0pieC6rJ/y1d5VqYtUTr/Rd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrtjQnVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AF0C4CEC7;
	Thu, 19 Sep 2024 05:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726723207;
	bh=3dBCnoo8xoMidFhLHa1R/3mGHDzudsxjfApLYuWSVDM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YrtjQnVDLwxRWo08yXfNdSbufkV+XcXLyJUJlPWbqkIcmgDED1PtpBiIOYjj5psHf
	 qDU9YW1qqTpnqI7y2OB/BmEbRXz4ryY8L16EIZ5BIMWCwG9Kc/0+nhnJ0DHlglFvQi
	 3b+UVMN7xr7jCGYCjKua4wLgLsVJzde3EL0pqkcsDL5zKD1oDYXuAPklDswDrmeLCy
	 Iswze6btLTSipIu/8rO3pshDX0yLpay7YIeScwQwQDBuXBGGemEhhA82D0ErX/hIPQ
	 EyP21/aE2GXuHIqVmsZoxi7IJUxEUdlaUIMjNSrLJDPsX8+zZVJE8bmhheFUNunzOL
	 7xomowYXro+Ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 26A9E3806651;
	Thu, 19 Sep 2024 05:20:10 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zum2QP7hS1mDzqBT@redhat.com>
References: <Zum2QP7hS1mDzqBT@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <Zum2QP7hS1mDzqBT@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.12
X-PR-Tracked-Commit-Id: 652b0ae675fede81420758e3af7c5174cdaa8404
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 932d2d1fcb2bbbc3cb30a762302a5d2eac7720bb
Message-Id: <172672320897.1036593.11926145104390807598.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 05:20:08 +0000
To: David Teigland <teigland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 12:05:50 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/932d2d1fcb2bbbc3cb30a762302a5d2eac7720bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

