Return-Path: <linux-kernel+bounces-181276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61458C79D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027B21C215D8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E93114EC65;
	Thu, 16 May 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfztTipR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC8514D6E7;
	Thu, 16 May 2024 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874791; cv=none; b=jcrGvKjNBEa3MXdaLBp4NfoULbBti56jvC0AJDoWJFash1ye+/hftoyEH1owrfY/jIAnE/U6fIyImIaAPDKAQQx55uNuMVA267ztyamcUGtH76bAI4soaErfq5kA9ythjI6Cvh9xPa4uqtIWJSQg+NpH6gUM6G2xTxmgkcgeEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874791; c=relaxed/simple;
	bh=GuDWyCnaOi1WEiC1cUG6rqNwJPCpE4OI8pmI7uobezs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q3dJnUTtOxce7fbBEpRORuU7X39Qy0bYoi6aQQb4iEhaFbh/FCZwCE4vj6kI91zjk4kEuQIB7ANpNUQCNHsCVkPvgDcisz6jgnOPqnuWgveuhVd1RmiJ+VJld7tqfSMAeZhRyoLafqPJgHs1w3dNj1mYjTUraBRMHCZbMARN/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfztTipR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41681C32789;
	Thu, 16 May 2024 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715874791;
	bh=GuDWyCnaOi1WEiC1cUG6rqNwJPCpE4OI8pmI7uobezs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PfztTipRbAHmsCtnV+FIiSzujgOyX0RseHZQt/nhQCWhp8pMUZYGx5QlGV4IVJvuV
	 1t+6KfxGyG3UYyplIrEe1TmSIUErL0g4XUEVFPsS67l4n/HjhkPFJ21DVzDEQkDGok
	 uAPRkXy/HHE3ike1bS/ctSo5OsMjTMqrcio90ACabvsNPsqX6VrNFMTNinRCfy2Eyd
	 Vj/0Z++aQqBPN60abTRVsN6D+Tma/c0jrbibKKDj3/0xEBLbpjAwk8OiLxGUUi4uuF
	 FL7Rgsi5s4ub1egh2nFhuEHl8KarcPW2N7HBZumpfkUbDvyDCkUuIACZlZmOiBahDK
	 lJUbWBOaEJzcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34620C43339;
	Thu, 16 May 2024 15:53:11 +0000 (UTC)
Subject: Re: [GIT PULL for v6.10-rc1] media updates
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240516080159.76e8b45d@sal.lan>
References: <20240516080159.76e8b45d@sal.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240516080159.76e8b45d@sal.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.10-1
X-PR-Tracked-Commit-Id: 8771b7f31b7fff91a998e6afdb60650d4bac59a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fd600d742744dc7ef7fc65ca26daa2b1163158a
Message-Id: <171587479120.7101.11901115041655560982.pr-tracker-bot@kernel.org>
Date: Thu, 16 May 2024 15:53:11 +0000
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 May 2024 08:01:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fd600d742744dc7ef7fc65ca26daa2b1163158a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

