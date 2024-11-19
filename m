Return-Path: <linux-kernel+bounces-414870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6150B9D2E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F2E6B3367C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614461D364C;
	Tue, 19 Nov 2024 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkKZFa/t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B991D172E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043190; cv=none; b=swHEA2/qAUXcO0p/19/5FIPHfdvKUDJ7ByIO1voFIuIym4T2wqVYWw+j/QJPSwZyN4K/wbc+Hj+7W7veDQw5g10hsKD0O3WTf95j2JMZyg/Ueu/MAd6+jeRa7/UAQEsQdj3lUfUACrbArkur+EPm+6IMidm8Sk0gS5b/m8kLy8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043190; c=relaxed/simple;
	bh=OSMKY1jWR7Y4IsCkAhtfHpI/zCLOe+u6HkODx2ZaEI4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UKbCHOgSGPXvthO4QVQC9kOTUH0YCYKhpAX8WqNME3kRfmzWCRwYMn33CP2WRR1gtLynaGKRb1tPGuhaiuHDYrR9RIjlcMcS9vl1STWmjwD49pi91ns7DKpwvERD+bAi9FL+hNKYOIuP/9+bZ8GoQmUkc5cMMOMb8MMOlYLQxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkKZFa/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6F3C4CED2;
	Tue, 19 Nov 2024 19:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732043190;
	bh=OSMKY1jWR7Y4IsCkAhtfHpI/zCLOe+u6HkODx2ZaEI4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bkKZFa/tf6gdk6ti6+MXl/Pw2pb8H1gSp3L22qAuuYshb+L9CdkkUdjOSd8Ij2814
	 ZIGkag059y1vTlEIYL9XjRWXvFVEpHtB8+rdEsIIVsAwgbXuPsX6oigCSx78aUHC9w
	 l2NQw2BAGnyMcuTEAGc9ElwFo3gHSfeqer0WF5P3TADW67kGhISeYlD/ZJ+OjHjRjs
	 V0z7fiPCOGpROyEEOSepA+SYpnuOBSj5/ywhWgeMeTvwL9lkN1kmuYqs7U1Pjs+FZ7
	 kveX4OjKueRjtwdLlWYRvcHq0xvbUzd/RzSCKyzNX41oQzl4c8mxzboCk0PtXe8p3a
	 mEFnRxcEzycGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B863809A80;
	Tue, 19 Nov 2024 19:06:43 +0000 (UTC)
Subject: Re: [GIT PULL] scftorture changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <e7f3c085-674b-4e5a-a97b-fbc70ce20b9c@paulmck-laptop>
References: <e7f3c085-674b-4e5a-a97b-fbc70ce20b9c@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e7f3c085-674b-4e5a-a97b-fbc70ce20b9c@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/scftorture.2024.11.16a
X-PR-Tracked-Commit-Id: f946cae86d088d02a2f9c0ae0bf8a80359d3f454
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7d4102f0a4a015528c0be61688bf6edf72f81f4
Message-Id: <173204320191.653509.4263124825151748652.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 19:06:41 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, bigeasy@linutronix.de, dan.carpenter@linaro.org, boqun.feng@gmail.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Nov 2024 10:44:48 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/scftorture.2024.11.16a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7d4102f0a4a015528c0be61688bf6edf72f81f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

