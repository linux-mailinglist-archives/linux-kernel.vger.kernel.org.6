Return-Path: <linux-kernel+bounces-198367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438C8D7732
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 18:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235591F20CCB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C185811A;
	Sun,  2 Jun 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpdN+cXJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E254656
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717346474; cv=none; b=fICxWk8P9jKEPHUhZrw6VJtzM7PAe21zdthw43+orbXYbbU/gt091EDjXTocHlMgABz1Oz2NERJY1boACHt3lso2Gf1KwB41N2xpQEZKn3heFQlV/Jn+x7T9JAIPffmLeXFF1Wca0Vn8aIUSEALk8ueraXbGwqghxavuVY6hnmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717346474; c=relaxed/simple;
	bh=LysSa9HPDqTq6yFrabmC++Ggr9y9UpNkiFGB8ZURzmw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=vCI8t0OX22pfXcxwU2cDL0fYIBjoH3xqwZnZ01B5ouGOncmtE8d7ne0puyaGLwt8kB9hatHihhKm9qsVR5XGsgkR6W7gqpFux+GISXWW4xVOzcIi0KtsapOhJ/EmygE+Sqvablr0g3MQx7zqZQoriug9yAYvwmRHyzBPmaWDyis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpdN+cXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 690BBC4AF0D;
	Sun,  2 Jun 2024 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717346474;
	bh=LysSa9HPDqTq6yFrabmC++Ggr9y9UpNkiFGB8ZURzmw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mpdN+cXJpAOlKWB+EtY/mkPd4yAmGCSVOSWXH6Av57XgPA5Bo1NO8YA82WSO0Ux/f
	 UVl2l64BtO9W8tujqRL/Nu6K2bXHvgr+hYO765uPNJZfHCxFcU7qKnqH9vaFu6lQZE
	 YmeWAbZRSMZaAFQkqzpCxz8WCbAljQ7vibGk4cli9r6gKgvPObZBdhfQ1196HfsJHz
	 uO7KIXYU3K0rZRfijDsHhN7Njun9B0YAK4+KaK3p8IG+/zAqrs0kcNQO7Mx55Bn+n7
	 Sjt1KC1jxkZ0iNLMgksgNRIZMVnwfEmBfmxVMjZFx9LFdeRQzNxkpIs/EYCWTcQVoP
	 cB0NdEP//hz8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E6F6C4361B;
	Sun,  2 Jun 2024 16:41:14 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZlweciPk77ra9W7H@gmail.com>
References: <ZlweciPk77ra9W7H@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZlweciPk77ra9W7H@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-06-02
X-PR-Tracked-Commit-Id: 0c2f6d04619ec2b53ad4b0b591eafc9389786e86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a693b9c95abd4947c2d06e05733de5d470ab6586
Message-Id: <171734647438.21593.10917621670013143458.pr-tracker-bot@kernel.org>
Date: Sun, 02 Jun 2024 16:41:14 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 2 Jun 2024 09:25:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a693b9c95abd4947c2d06e05733de5d470ab6586

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

