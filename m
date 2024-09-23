Return-Path: <linux-kernel+bounces-336357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B0A983A44
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808A21C21C17
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6EE14E2CC;
	Mon, 23 Sep 2024 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBvzvsr4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4314D457
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130881; cv=none; b=U2I2R8g2n789SHQJi/v9k598ixWn3noGAcpvaWRKlrEiQh3JfdUDfsQ+pP7jLKanAJbtLjDsoi718LrrxGozsafZtugygwEh3ZCN+HeEjqwLz0027Z8I7JElLvX8HUNjNIFq4FjD4M/XQ9v3iFOF/kJECNUWLAD1LCC4lb1sBJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130881; c=relaxed/simple;
	bh=xv6HwTqxycXd8mRod0H+eo6q9UcVH7SoIfhO6AsyA+Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Oe2u083hxsOooRBJDUOkoBHmxyF3AdX9sGRktM5xE1Or5MS0OxmsTKFqpqx5GQsLta9u8L7qD8jqtevNv1Y1OQBhhP/zlbO4ahiDmO/p1UdLZLhFLGFQFLytxXZzUz9z+8gyYlvAcAcly+hnLZbFuN4sHzIX+2vw0L3EvuhWwXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBvzvsr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE77C4CEC4;
	Mon, 23 Sep 2024 22:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727130881;
	bh=xv6HwTqxycXd8mRod0H+eo6q9UcVH7SoIfhO6AsyA+Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FBvzvsr4O4oGzDtg2eDDmDJsQ1QzqLox+BnQ/kt68opcVzOqD16Q28N5yqfl1yZ7G
	 e8T/jSeuEiWINSp69rnDs2Ng4xbeHmPh/q/sAzFRzzBj0ZtTUTohwygnRdMUS2gtdP
	 hKKTPKxjIMtwTo45MSoXe9X2MuuHVikBrUQGYySPfQdHPSdrCi1uLcUSSnq4Z1Wk5X
	 QV19EIWEK9FEqfBNRjY/WiiHRX+GeAkaCNaZt0IONHxIGlnmXDvkuuPne+SKv1A6UA
	 DyienCnwogBYD/clj1VBtBUP1uoEHnkOpAQ3HC9Js1evLwwS+3kZmUKbWWxhFhvx2e
	 LvOToF+no0Xlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECC473809A8F;
	Mon, 23 Sep 2024 22:34:44 +0000 (UTC)
Subject: Re: [GIT PULL]: soundwire subsystem updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zu/9/X5gRGMgbY+F@vaman>
References: <Zu/9/X5gRGMgbY+F@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zu/9/X5gRGMgbY+F@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.12-rc1
X-PR-Tracked-Commit-Id: 5aedb8d8336b0a0421b58ca27d1b572aa6695b5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7116747a686e3d5decc354e6812f078dd0c44c6e
Message-Id: <172713088368.3509221.13445879493436652302.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 22:34:43 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 22 Sep 2024 12:22:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7116747a686e3d5decc354e6812f078dd0c44c6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

