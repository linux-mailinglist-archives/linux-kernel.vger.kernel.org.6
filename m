Return-Path: <linux-kernel+bounces-332444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939097B9B4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1E52868D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B8817CA04;
	Wed, 18 Sep 2024 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMkY7ElT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7EE17839D
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649853; cv=none; b=WjzWUEKjF53DSbT4DdLcjusUFaWQi4AYXpncfkw50EotodM//l//6JhxWh9dDa1zbvi7N1JmoDZS0KSmaBGzmgjQhm7pdi8UcNjiMweUDpraEqgvUa0A3PILz0RRnonnYfkZr7X9PvfPejKMqjro0cI5sR4rZ4V51V2/Yjk3OOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649853; c=relaxed/simple;
	bh=qGCubwG5bC8Bi0bzJCZ1k1DyuKD5xsxENpIr4g0PADA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Nuwf2WORXTkGUpKHFZbaIvFcqyY29AmukPdi2vAeWSMYbLO6bhL0I+SBeB6/Y9Wl/t/ILb9bx00SqN4Njox7U7B6ZFA7Grmq0HUjQVtDH2/MedurdbZez6drt4ijWT+/pryqds9u8iIeXPxBf1La1yuMmkQwDp3wxvUpcXLduas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMkY7ElT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4303EC4CECE;
	Wed, 18 Sep 2024 08:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726649853;
	bh=qGCubwG5bC8Bi0bzJCZ1k1DyuKD5xsxENpIr4g0PADA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZMkY7ElTyIzNEzM1gcBlFvFjfON08H0yTdSQtUkag61WyaswwJ6FiRRDUxJgOzY3W
	 H95kiqDEQmMZzZ4WD0gW3ZcaBgJR8aFVO/QUscHY4o03XKJyqhjGoC2A1a2aQaD2/W
	 sjzVLECCsiRTgkVm8+M6NkJ2qTQPdqazF9XzSSshR8j2rTMhv1s5S2nyR5RtTNJraw
	 0QAP+CIlHbyUDXI17L6t7zwEY30X3kPkMSWvGqdKVhZPwkd4kI3ZQ0yYM/uTUin7qX
	 y3h50gYRCvTXVttLZ19MQ6/Mus3T+Cif8nh739A+8Jti1L9kApMRyHEEtPbEpb+8eU
	 uE/T0B6yREKRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C0C3806655;
	Wed, 18 Sep 2024 08:57:36 +0000 (UTC)
Subject: Re: [GIT PULL] hsi changes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <admkep5qycck3n6inbs52dytfojer5jddjjjzocxi25yirb246@33rwujlrfym5>
References: <admkep5qycck3n6inbs52dytfojer5jddjjjzocxi25yirb246@33rwujlrfym5>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <admkep5qycck3n6inbs52dytfojer5jddjjjzocxi25yirb246@33rwujlrfym5>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.12
X-PR-Tracked-Commit-Id: c3eddf5e8c30adb6f43fc0b149e88b9feb76f381
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfbb96324a4a8dfd44c88f64e4e0ef8ea4ab128b
Message-Id: <172664985463.725883.1310921313689854899.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:57:34 +0000
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 15 Sep 2024 22:40:57 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfbb96324a4a8dfd44c88f64e4e0ef8ea4ab128b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

