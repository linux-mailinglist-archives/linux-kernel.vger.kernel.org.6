Return-Path: <linux-kernel+bounces-435294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9BB9E75C0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257F3170165
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF7D17B418;
	Fri,  6 Dec 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="r1Wwqp7g"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D32A13BAE4;
	Fri,  6 Dec 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501975; cv=none; b=h+xdXcwT/n9NiSaTIlytL6f5Dk6qmLPm+9QQw5oyye+qPzXPKbGeKfAOhzuHxjsOAk6fYqBxeNc6pA+L9HnTdAHU1MvM0vynVP3R+01wddWCthnA9/BTW4vSrpMQBtu7FfR3EG5DoGUjiAJ42ogNnqoX+6LneW8Tqob5ZK4ia+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501975; c=relaxed/simple;
	bh=N4qaEdmCT53YmA62NetAyt+upQ8j+mAcdltLZaThXAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BBUZekQFJnDP8AXOhAFhOVSnjPPSfD/APMB8/bmRugsRIPi2YzhbKP6w09Cm+ZiOxuc00k2FSKDY7/YiIKHkdvvylSif9aAr2Y/q1ZZ2y377p8dSE0muhYFk4x4EhskfkANwqbk79qff0q7RQ1NwZUCYL+yAYxnoaj0q6Bl/DDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=r1Wwqp7g; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 447F2403FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1733501972; bh=3fYOVGSLg9cOVmo6qsjMBrJi+o5GtuI3YW6NyYesVFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=r1Wwqp7gNThpgzpxxibyL7gdDPHVYA3pk0dz4V6VNinH4At1YhMGG4pU9Ngb4RWA2
	 ecPrbiUysrslG+PJDIVkWGX09uRjBiVHQLyX5d9XB8W8XgwD1L0pLqpWZW69DIblDz
	 s+qPJLMWscsLnajXx/MCOfmJ63jXqNUmSckrWhPGoLARVCSWf4g7j7xMwxcXy26u2m
	 zyy14WhvH08MWAhinSVEF2A/Ib9NOEZ1s/bP7GhBWsqNUmTgmbnNp0Xzppn1Ve0lL6
	 LCH4BOi9gr2rWpeiQOxSUXOXUKPc0MqJmHRLeSqQ0NRDMncnh81tgElbFS9tRXEI5H
	 2cRb7uKJP/oXQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 447F2403FB;
	Fri,  6 Dec 2024 16:19:32 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Cengiz Can <cengiz@kernel.wtf>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 cengiz.can@canonical.com
Subject: Re: [PATCH] Documentation: remove :kyb: tags
In-Reply-To: <20241202090514.1716-1-cengiz@kernel.wtf>
References: <20241202090514.1716-1-cengiz@kernel.wtf>
Date: Fri, 06 Dec 2024 09:19:31 -0700
Message-ID: <87y10su6lo.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cengiz Can <cengiz@kernel.wtf> writes:

> :kyb: is an extra markup that we should avoid when we can.
>
> It worsens the plain-text reading experience and adds very little value
> to rendered views.
>
> Remove all :kbd: tags from Documentation/*
>
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> ---
>  Documentation/admin-guide/braille-console.rst |  4 +-
>  Documentation/admin-guide/sysrq.rst           | 20 ++++----
>  Documentation/dev-tools/kgdb.rst              | 50 +++++++++----------
>  Documentation/process/email-clients.rst       |  8 +--
>  Documentation/scheduler/sched-ext.rst         |  6 +--
>  .../it_IT/process/email-clients.rst           |  8 +--
>  .../sp_SP/process/email-clients.rst           |  8 +--
>  .../translations/zh_CN/admin-guide/sysrq.rst  | 22 ++++----
>  .../zh_CN/process/email-clients.rst           |  8 +--
>  .../translations/zh_TW/admin-guide/sysrq.rst  | 22 ++++----
>  .../zh_TW/process/email-clients.rst           |  8 +--
>  11 files changed, 82 insertions(+), 82 deletions(-)

Makes sense to me ... applied, thanks.

jon

