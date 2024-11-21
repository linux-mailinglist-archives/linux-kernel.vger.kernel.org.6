Return-Path: <linux-kernel+bounces-417309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB489D5251
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336212815D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C051A1A0BF2;
	Thu, 21 Nov 2024 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyF9FxdA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251386CDBA;
	Thu, 21 Nov 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212322; cv=none; b=XfZjvtJOGyYIq+vm0by/LJcG51JMJLWise2DZ/rWBmnF0XY9V8Ka3cRQHUm0idi78Ly4z98/twwr17MExxd49Y/LI7za+I/7dzR2OBYhjG/9cXpBtD6piFez2AqWOTHDDA6r9bqGoPSlh27TKk2VTM7bvEv2CDGoZ5hPqLkR7UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212322; c=relaxed/simple;
	bh=APuefoTykwddKXr/l4AfnPznJ6xTnjqoNmkxh3HvPfs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mr1T1o1wn+d3uqybY7BDCP+0/yW1maBWNpJ8UZXhCrrRla6LnAB2z0LhzBm9rge2mHQPHjFh7vlcAA5odPNxjIXawgC9gQ0K5WFUwlSyNgobyQzmqNIUkXCFafDOcq49SF/MLMB4jqjqSlk6VrxHvyhZUp1AQ4Kjn16/wRbTzjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyF9FxdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFD1C4CECC;
	Thu, 21 Nov 2024 18:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732212321;
	bh=APuefoTykwddKXr/l4AfnPznJ6xTnjqoNmkxh3HvPfs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LyF9FxdAPU1bgx7RG3iScyBe6VQfj/cY6PCV+9PEDMJxVQQcnB6L4yWgiux5WlZYK
	 3L2injduz1loRbK8amWM69nM6Uf+cr8Qk4O/UHqemzN+I7qwfFfhMo5arUKjcihaM9
	 4+e/hmARjXW55p7IL+LqJ/PZ5uLiT9rOmXtZbi0Iq9i2BM3t1iRNvcUrah65zpSxiJ
	 Z7YaBckwFGorKrS7gU/7Rqpj8j9oBcVakRfn0aXmEoHFmR90eLR+cWpkOCYU21DEKC
	 rLrdrGQIFgRRwMmcvHij6MUrNBhJnYIiYVo/vHfb+9z6ixyTRu+qQ/K07IflkewPZP
	 +P9K9g1T5qCvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE83809A00;
	Thu, 21 Nov 2024 18:05:34 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zz9Zyoho_wbCImkJ@redhat.com>
References: <Zz9Zyoho_wbCImkJ@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zz9Zyoho_wbCImkJ@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.13
X-PR-Tracked-Commit-Id: 200b977ebbc313a59174ba971006a231b3533dc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a550ae5560f7237c82dc9c0c128ba1d593c4dde
Message-Id: <173221233364.2032550.7279137346088342561.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 18:05:33 +0000
To: David Teigland <teigland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 10:03:22 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a550ae5560f7237c82dc9c0c128ba1d593c4dde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

