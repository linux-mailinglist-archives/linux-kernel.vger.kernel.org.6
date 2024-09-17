Return-Path: <linux-kernel+bounces-331751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCA497B0D8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC5AB29FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE00B174EF0;
	Tue, 17 Sep 2024 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2fdKcIS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4117ADFC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580391; cv=none; b=CX0jS3Ye+8/qViIbVkIZIRZ3wPqrgJdvkPJJ92YDAcWcVOnOyNdoRlbI2s61prCa80MyKyG0KHB3WabV33wktDZt66dCw8DVTuu9cDKUUSpLyaVzsRA/sfHn5JK8d8rvNhkNlSg7STPxdG8Ml9E7kTRWNTLfRGKltx3eev8wrBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580391; c=relaxed/simple;
	bh=p/om/+fqkgEvjskaIk30oVU7O8Fw7Gef1IaJERBgiY4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Cv9MsME0pozrlsMB2D71OLAElm4xK4GbxrVpF2iZU6+5bwYGJXZvJxMZktDPY2cZdDBcOb5wKKF0eRqwaNtOVysnldOO374L5hlhKubR84khtG+uSKV2FKXhRvy1PMVrOXG3YA8NHoChym0s1w5eNGN20Fp7btN+Yt1rkAz461A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2fdKcIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCD1C4CEC5;
	Tue, 17 Sep 2024 13:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726580391;
	bh=p/om/+fqkgEvjskaIk30oVU7O8Fw7Gef1IaJERBgiY4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o2fdKcISJpmoeQXUX4XrrAQ40LIiLMwUMjLAlAcATxxLmucstaU0rNVEXlj9XSiVa
	 bVoJhLVhIdO4i9oPQmrW9Ck4E4ebp5NcnvoWeHY3XE7S3GRTWfJyI7FEUYVHSIBJGr
	 89xv4e8eHuDOIP8+0zTQYFxC1imN+pXu9tkvbnv5ojt9GYVbTTic9GK6kwBC3qjQo1
	 /tR+rFLNGtqG8YlE57olT3PTsAPFJuM0Ybv9S2jVuBxSdbHaLxcheS1XEx60dQqZ9V
	 EmPHhsNcYh03DbkDZ91v6ONpv6tDYGP1yY7ziYeN0XvlkZMPi2l/BXRf1XXET5t01Q
	 Cspief3DFWbYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FB53809A80;
	Tue, 17 Sep 2024 13:39:54 +0000 (UTC)
Subject: Re: [GIT pull] x86/fpu for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172656198744.2471820.14081573146419941141.tglx@xen13>
References: <172656198112.2471820.6226852046770294674.tglx@xen13> <172656198744.2471820.14081573146419941141.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172656198744.2471820.14081573146419941141.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2024-09-17
X-PR-Tracked-Commit-Id: ba386777a30b38dabcc7fb8a89ec2869a09915f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3056a7d1494e9b5511e4dba358834c5ef68949a
Message-Id: <172658039281.145065.207048447059327605.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 13:39:52 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Sep 2024 10:54:10 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2024-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3056a7d1494e9b5511e4dba358834c5ef68949a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

