Return-Path: <linux-kernel+bounces-250897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36D192FE3B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76A01F2552F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1072D17B401;
	Fri, 12 Jul 2024 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt0aXckH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5390C178CCF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800350; cv=none; b=VtDIRGkvBWeunHMS5LADgx7a60zTdvgOsXD19zaY1cUdZfjdRd56dleLOFZa+VJkGtxB8TYQhzR5LV3UsXP29ooLurK/n3u0tLt4O0EL/rtig1LdFYjZI9w95H6KZD4ICQABfOsaW06MsTjQhGOpmNQwp4znHM+Dv/NExHlary8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800350; c=relaxed/simple;
	bh=j5LaFCQurqUsIRJcwQEnqiLDBqJmYmC+Mir2zy12asw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GiQpuJHwl53LfXLnqyrsl1Jw8MrXJOaAIVqnMcTbO0Hj2/ZGtt7hF+J6yWSbBaNFocj0xpyC0iJVyT1N95j7RoKbvFNq4mYgGoTfYZZuuiCfH9gJUPQ8FnMCgsHhiIxIncGisPFyYBABudR16VbmWKJIRM0JRTlsn9WccnSfLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt0aXckH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38FC1C32782;
	Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720800350;
	bh=j5LaFCQurqUsIRJcwQEnqiLDBqJmYmC+Mir2zy12asw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Yt0aXckHWKvsI6IQab0w10KCJYAURXUFjCCPMkYSCUSW9zvios+M3otkCc1U+EJzY
	 xHGLpNDyBTS1D7iGeAmHYeusn86THPdlhyXd6973a03LDrX3qOXeV/Xch9DSPD9Goe
	 h0+8sp2Heq5YQ9ObrrcJhuiBJgYiE9vH7LgDWCMTzNlLiPk5y3HWkZ5x3Ox0NhfCb9
	 xV70qdRQyqJcN++kWT15jsYms7XWZGoSPAbdbhyiqFeHol4nzr0b7rjFErBAg9/zI0
	 ALsDMahEQCdBPPgUpvzbPes9MKiDOcRYh8vwfBoMpcDFUK21OdlGM6lVsDu6iN/692
	 HZqUBLXcSWh+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32499C43468;
	Fri, 12 Jul 2024 16:05:50 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.10-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpEITX2fIM6KpL1h@kroah.com>
References: <ZpEITX2fIM6KpL1h@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZpEITX2fIM6KpL1h@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-final
X-PR-Tracked-Commit-Id: 389637d4fb5fee40e8a0f2bfd31583f6768ef792
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f469cf967b095ec2d001a712e8cdbf3b1f06912b
Message-Id: <172080035020.10368.1820688262236205361.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jul 2024 16:05:50 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 12:41:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f469cf967b095ec2d001a712e8cdbf3b1f06912b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

