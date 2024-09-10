Return-Path: <linux-kernel+bounces-323905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7259F9744EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD5C1F26CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C37C1AB52A;
	Tue, 10 Sep 2024 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="KFI/pRsi"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE33190047;
	Tue, 10 Sep 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004159; cv=none; b=Bnwjgmcocct/NSE5rau9oiOBP0xMtbGxB69EBONjgGP41uUJp0O/rH7S78vPFLmjh+HbTnZm4RmWuemTH9A9pALpLr0eofUVFxmZtwxCiKa4C1P64uJfGfUi4qLREbOeVAM6YKoYXsuU3KK2vq4D/f6+iCOD/ObYJJBmiN9eYMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004159; c=relaxed/simple;
	bh=bws4o5DOM/tkg6ppLh4AIu+Aat4KMPLUTu+k6AX+dxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=szjZeH6Tav3/gMzp2oMc3XBSxWkMgezzE0ctbZTVo9oRQTVk0FHtvs2g88LBt7bl8ssXobrvibZBitHnn3ajNr9TeYKbY0QDLK/fNPJRWKS6RAEmlrPw4lX5DZxgpBXsvrDT+/KOcdq9QbDWKlToqygWIUnpWnNdOLJe5fS1k04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=KFI/pRsi; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 642B94188E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726004157; bh=Y/wSXl9IdMANgBcjcupZbz98ye6ThJi+Q/kOnnfGkbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KFI/pRsi0DOO0y7sSbCxJyJfOXtrFKv2wy2Z2Fg3XsHD5H449LdCWrKfQ1/NGut1U
	 9QvfJHP8+BxJaj+niTV6qIFdipiEUa1yYPLHjHF+Ku3zkwvB4oxJLmfYA6kTTaH8nj
	 wP76mjAPEkd8GJHcOiciaUeQ8Cmm7x2Z/l1h5fb4aIYe8cFPQftKEnwFIr+wvCeXN8
	 ObVJifZoMbpq3ZcOIwYVukT+DYLUXUOGj6NPyYHXj5iwbJuRaZu0byh8vsA24YySlf
	 oLzqWJm4qwGiVhUgGCOvLdnILuD+PHltRj7NlXliiZnF8KgE8/7pzuJaw1jLzeY029
	 wawfAIbH+VkBw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 642B94188E;
	Tue, 10 Sep 2024 21:35:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dennis Lam <dennis.lamerice@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis Lam
 <dennis.lamerice@gmail.com>
Subject: Re: [PATCH] docs:filesystem: fix mispelled words on autofs page
In-Reply-To: <20240908183741.15352-2-dennis.lamerice@gmail.com>
References: <20240908183741.15352-2-dennis.lamerice@gmail.com>
Date: Tue, 10 Sep 2024 15:35:56 -0600
Message-ID: <871q1r6vk3.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dennis Lam <dennis.lamerice@gmail.com> writes:

> Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
> ---
>  Documentation/filesystems/autofs.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon

