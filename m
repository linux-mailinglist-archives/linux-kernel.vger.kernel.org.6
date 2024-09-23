Return-Path: <linux-kernel+bounces-336358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEE9983A49
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C6C1C21BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBA814F9EB;
	Mon, 23 Sep 2024 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYg+ZY7F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2F126BF7
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130883; cv=none; b=e4LKXbCXyIbZWSTpTcxkbwcFkB6pppbdyjCJvImppsS2aNeV+fkEjfZ+NKj2NkCEb9oLviRZ2IksdiM0U72Sb+Ld6AwZlno3FdNWVnVZXIgd23+qysIqeq2lLHh59AkcHE2aUNMFqUc5eTfUD/S3BtBO0kMKBh39FEKFbHX4MOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130883; c=relaxed/simple;
	bh=IQKZQnC22jpXffUcc4NXIH7mY8e1JatQggpbfhGIvmE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=peply8FZKkycrBj2n5uLDXKH78FjvLCcs6M+IPt/850vEJJL+fMzJpLkX2+HUyjgveXlNEY8jmNHHWBEkCESIq7sG1DHGGUud+zweBqlmqYVfnjrLyVGDmnzSXMuVOCQdK4hXzDQLC2yIxjlECr8rPsjeqXACfw5NG22n5tebco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYg+ZY7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1211C4CEC4;
	Mon, 23 Sep 2024 22:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727130882;
	bh=IQKZQnC22jpXffUcc4NXIH7mY8e1JatQggpbfhGIvmE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hYg+ZY7Fc2hASjqGIt4Z8Giz2sdhUtFvGcu0yy1kF2YxkB6DJDfxqK/zb3oVWHSJP
	 nKqCFJdqMS9qLjj7glDbLSfZ9vVSnCOh3YRYIucmgWR26FFWyv3T/nd3QRgWrVayQC
	 pZm3teK8vtVdlMy0qDkoxtw7egC/qhTO2qNbqYXCXswZucBhrx2LZoS1tUtjR3i34D
	 w8lX6iYbVQX8kUCY36V+VhVuntwnuiLu+y4aTSsHpisLzH3HYOBrtzwoYWkg/0B6Mp
	 CZE7HgF5CSPOglS+xz4g8BT3JHe+ok6npdv1Qxnz0O/EgoF99nEmnHIhMwx2H8wRdo
	 u7C1ANmZrHhqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B203809A8F;
	Mon, 23 Sep 2024 22:34:46 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy subsystem updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zu/+ht+m/BeAh17u@vaman>
References: <Zu/+ht+m/BeAh17u@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zu/+ht+m/BeAh17u@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.12
X-PR-Tracked-Commit-Id: 3c2ea12a625dbf5a864f4920235fa1c739d06e7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbb86b0d5f38184873772a84ae50d5edd6a8b046
Message-Id: <172713088516.3509221.17373189384090169850.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 22:34:45 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 22 Sep 2024 12:24:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbb86b0d5f38184873772a84ae50d5edd6a8b046

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

