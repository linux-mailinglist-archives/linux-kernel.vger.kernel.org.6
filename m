Return-Path: <linux-kernel+bounces-334489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87B97D7E6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA4A283B77
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377FF17BEC5;
	Fri, 20 Sep 2024 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rKApWm68"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382AD17B500
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726847525; cv=none; b=Z3ift/bSKgV0EO1vW97Vrg2ioc+mI5gTkc/UCt2V6VePU409WYMpr1wSshBQPLJ6LJR9cplo1bwc+vbPrlEeLDBitkfudc9/5sKJXKIEIGSsiN2y6pRCvuWhAS2gAOiK935uSyotTND3OngJZbRaBUcplb6OLbdsloFrSXN3cbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726847525; c=relaxed/simple;
	bh=T/4pn+cSl7tGAP+HD0Dh2nyIStNr6HnhwhEDKTr7Mgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gOL99ylj2E1QEdYFgh/XKRqYIsUj+99mLRBM9QpsIpIyTYQFZtkI8fAa0xsTZz0Sp6Gzceq1KAWssVJcmSDHRYurl3hFRQBmFthux8SA+J2XW+zpMPH3r++kstlPwETQpV/C9OZ3GREJhw+Rr3UUYefQn/BrJKtBPtuMtQPHpTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rKApWm68; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7D23D418B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726847523; bh=VGgrd1YPrBsSpusS+KkslGgX0KPfCWAE2Unzj7dx4YM=;
	h=From:To:Cc:Subject:Date:From;
	b=rKApWm68KneBr1s/BnUzoRwCO6j9mYlYpGGQZAjcP99GMiL5f0rapDeY3hiDzuymW
	 MJ/5UoS5mnLZ70sNUe+KNO3ywPiGqymEF/GEhW8dUXUI5Rq0MWjrCBNtmFBcL9MNv3
	 K8XJZI0g5WJtMauCXYyFM9knfZq0aAD5gXeLwLQ9fpngPsuZb4CKNmC8QZGN9RQpkG
	 dCT/vLS+24LNOIw0r6v1JARFi1ZtRYUKst3rEclBA8jDzzOQQD3/8722mWPlNzAD60
	 pcfueNklrT1Jp16sP2jBJhiC6BKyaGAIqtdd/ytPuZDBXuBCJmOY17ugqEgwioB64P
	 XphtM7PWzmtYg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7D23D418B6;
	Fri, 20 Sep 2024 15:52:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 tech-board-discuss@lists.linuxfoundation.org
Cc: tab-elections@lists.linux.dev
Subject: TAB election 2024 voting started
Date: Fri, 20 Sep 2024 09:51:59 -0600
Message-ID: <871q1enx0g.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

In the end, we had eleven nominations for this year's TAB election:

 - Amit Shaw
 - Dan Williams
 - Daniel Borkmann
 - Dave Hansen
 - Jakub Kicinski
 - Jiri Kosina
 - Kees Cook
 - Lorenzo Pieralisi
 - Miguel Ojeda
 - Ricardo Neri
 - Shuah Khan

Voting has begun, and everybody who is eligible for an automatic ballot,
or who has requested a ballot, should have received voting instructions
from the CIVS system.  If you were expecting a ballot and did not get
it, then:

- Perhaps it ended up in your spam folder?

- Have you enabled your email address in the CIVS system?  It will not
  send you anything until you have done that.  The place to enable an
  address is https://civs1.civs.us/cgi-bin/opt_in.pl

Please contact us at tab-elections@lists.linux.dev if you have
difficulties or questions.

Voting will remain open through September 27.

Thanks,

The TAB elections team

