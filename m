Return-Path: <linux-kernel+bounces-574658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2C1A6E82E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B890188C895
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0919CC39;
	Tue, 25 Mar 2025 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aefNs0bd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFACA19ABD8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742867881; cv=none; b=HVFpunJKb3pPr4WZATyMDRNUZDFc2uhl/DYgUoQpcP3UoSgoP9CRbN6GvukmuDNZ/uOi6UCg1jZHJLGpCkvXwh75XkuqJodwuA0dZAabDq2Xud3zU040RNTAOA8R83pi4Neqplw71SVU7sZ/Vne/cFc3bwR0XzvYnC0QUYDdKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742867881; c=relaxed/simple;
	bh=cHkG3G4QzYCbLbAs668q9TFf0D6Wde8ciw6S9K3C198=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lme6nFpKnE5m547+2VxZL17IQ3Ejb8gfe0ehVsjNxFBzFaJN2k14ahMogiSkIxkdWvEYr1ZV5W1hqLzs3MVVIpvhNu0f0xRqO6ahqK9fPpbHjU0kGoNrL1LKSFuEONbKwNNwQIxigqeuoPnb686gGG7UsHhxATNWOmqVhfriz1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aefNs0bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F1BC4CEDD;
	Tue, 25 Mar 2025 01:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742867881;
	bh=cHkG3G4QzYCbLbAs668q9TFf0D6Wde8ciw6S9K3C198=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aefNs0bd+bfUlc7qQaYJEHW2ZEacx7dwlzq4wKZ02psNp+HlV0950uMNCRPDH5hRH
	 Bjs/vC70JmDJOuZzPRgKI2oxHBBPsCW4S7jntqGKYbg2kM34/RPOi8W5E3KzxhRe61
	 xWqwuKVPmwW/Cf2aWoxGDBXdPzTwHsz24DCafagOWfwZ5LJhihB2c2W0VkzvvkDB87
	 6ga3HD78kk61EppmSOWJJYVJQ1mOIaLe7VzVKXR9boet2zKVN6O52EisXOkWjoM0tQ
	 zLuOcOVuZ3/qIRq5zEmOnU18KdaMfebkx0RuNbMR0MYxkx+nJ90A5eJFekJsFS5udN
	 6BpLjH4OJUwPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341E2380DBCD;
	Tue, 25 Mar 2025 01:58:39 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <bd17eb5b-bdd0-46cf-85fe-2c4f2aade82d@paulmck-laptop>
References: <bd17eb5b-bdd0-46cf-85fe-2c4f2aade82d@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bd17eb5b-bdd0-46cf-85fe-2c4f2aade82d@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu tags/nolibc-20250308-for-6.15-1
X-PR-Tracked-Commit-Id: bceb73904c855c78402dca94c82915f078f259dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 418becac37efeae6e3e422abff09e79addaef66b
Message-Id: <174286791778.53720.4535535461129577186.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 01:58:37 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, w@lwt.eu, linux@weissschuh.net, skhan@linuxfoundation.org, louis@kragniz.eu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Mar 2025 16:19:06 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu tags/nolibc-20250308-for-6.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/418becac37efeae6e3e422abff09e79addaef66b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

