Return-Path: <linux-kernel+bounces-262618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D1893C9AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322EF1C2204A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F37D143899;
	Thu, 25 Jul 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYXJ5pXw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CAB1422CA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939825; cv=none; b=aBbS9izLl9lc+1nRA1ot/TqWZAZKJtkVLYqkx20THQu4wHyEmdR3MWnnZvBz6dq0Ib5VT/cLtFVJFC+x2ERhD0XbvxwyV4ZyJc6VRbriObRxPO4s8ZqpCf6qxGdLFN3Yx++hLlEkXurVHc7f52SDgLhHLNYeMUqibLCi3BSD1cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939825; c=relaxed/simple;
	bh=D9RjB2jXGKqnWUMj3zxynbFufpuXvEAe+wy285cSBR8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IyvHxdXAC4ONiV8iqdYksTz04Y/Bgx5FeEqh9DzMHQ/W3vb/nKTGeQucWizzFoTWnOTvUwm9OKfTssonXKo3B1i5mZsQUGp3nV/iXBsyKdo29sCiDh/WE46LOgMzonbeboOyoJFJSetibnGIN7k39lH2rihrYIl3Q2QZwB8lxTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYXJ5pXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3891BC116B1;
	Thu, 25 Jul 2024 20:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721939825;
	bh=D9RjB2jXGKqnWUMj3zxynbFufpuXvEAe+wy285cSBR8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZYXJ5pXwE4+B3u1fKTQPHXLPtwWrtvZ7yGYwFes8SLDQC7hMBSSmHNPNxV9mQLPhT
	 Ip7O5AIqCYtTGVZUWTEEJWenlYCsgrtdcmvl8y4eOtZaMtdkRs9eR70Gx4oqK5MVSH
	 cmMQ4ScHZQGsmY18OYk4wUC3o7ElN9nBHjqoPYlohj76PtKKzXM4XAI0wMPtAXv/iy
	 TUhWmFOrSeX0sFkm12VqTN3MvCMvEtrkQAhR2TkkqSPW5XzmbsWa/7ypi1+D7UmWSE
	 ynBr4jan7cvjPpKOjHqP21JqHbKJW/ANd+dGBYzXdysXb4Wv/+ctSYjeHddcR+f1iO
	 LA71ub4e/pZpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D172C43445;
	Thu, 25 Jul 2024 20:37:05 +0000 (UTC)
Subject: Re: [GIT PULL] UML Changes for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <158184774.112608.1721836446346.JavaMail.zimbra@nod.at>
References: <158184774.112608.1721836446346.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158184774.112608.1721836446346.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.11-rc1
X-PR-Tracked-Commit-Id: 98ff534ec2cd02496c166614e6c1391d8e092e51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9bcc61ad1fbe7dbc6bdd71d31254e429100a009
Message-Id: <172193982517.17931.4930183829469370163.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jul 2024 20:37:05 +0000
To: Richard Weinberger <richard@nod.at>
Cc: torvalds <torvalds@linux-foundation.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jul 2024 17:54:06 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9bcc61ad1fbe7dbc6bdd71d31254e429100a009

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

