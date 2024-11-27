Return-Path: <linux-kernel+bounces-422978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC949DA0B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB4E162BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A329F13AA4C;
	Wed, 27 Nov 2024 02:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3j8n8Ha"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F3139D0B;
	Wed, 27 Nov 2024 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732675285; cv=none; b=aBGgmJKvInEb8m3gHUnkTEqqH1leDlfXND2wpajh8KkvU9w5lVxnu/S4Y+En6i18Jfq8o0IyMYC63WvxBDbH11zWYV8gpO7yX7rlv5V6qazKE0LcfQjRb3CCjhIZs6OdBFAFT3P92fm/1+rv9sJM0aLmET3GGpi5nXZy4P4edSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732675285; c=relaxed/simple;
	bh=494RsiVRf3iU/ZfCWzXRKc1RD9penUnrC1hw/2OgtSY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BxeMSosMD1N7NorX0PPw5JQnFALySnzTY6sz4TJQ3WWImKiwuA6TYQI4/YuD5+BU6LXQZtgQU9c911tOCVy76bLDEAtE/ezsg5K5Uo1tLdoIz9cPGqvlCN10QqVJeNUq3bhNlgIOQ7LO5kvHaOUD+XM3iylpcM2xIx4WMCK1ho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3j8n8Ha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BA8C4CECF;
	Wed, 27 Nov 2024 02:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732675284;
	bh=494RsiVRf3iU/ZfCWzXRKc1RD9penUnrC1hw/2OgtSY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I3j8n8HacpHFievEpuWvY4XaYmpiB5/NIinI3O+NtYCOuKUcA+aSv9cS+i5PDPfPj
	 gWVddhWeynNhc7Ahvz4r6rmdingQxbHfoMOxszhcuxaOer+WE5Bu7GlQdpnz48VN+i
	 2i749dTE0VSnidmVVGgBaVy097c6TwcKPZGiTFBBHbjyy3BYKZBSlWEGHVVoG7UwMx
	 GjDcRV9gq6qiWrZ59+Ma0XbnXQDhZLMfxJLk3yhuKIaDsBBvJzmG+ZYVj4qKpGyG6n
	 xUrYxnw15usoxCBEwA51lY4QYhA8ZTtK+5M00Kx+ZxQYGqU1jSZ4QRUJgLJYnG6RkA
	 LZy6ZmdTqFCsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF1ED3809A00;
	Wed, 27 Nov 2024 02:41:38 +0000 (UTC)
Subject: Re: [GIT PULL] rpmsg updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241126161007.3288016-1-andersson@kernel.org>
References: <20241126161007.3288016-1-andersson@kernel.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241126161007.3288016-1-andersson@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.13
X-PR-Tracked-Commit-Id: 06c59d97f63c1b8af521fa5aef8a716fb988b285
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aaf20f870da056752f6386693cc0d8e25421ef35
Message-Id: <173267529724.617991.12082805779663805811.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 02:41:37 +0000
To: Bjorn Andersson <andersson@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 26 Nov 2024 08:10:05 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aaf20f870da056752f6386693cc0d8e25421ef35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

