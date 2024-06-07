Return-Path: <linux-kernel+bounces-205871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A69790019C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D02F1C20FF3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF62C188CC5;
	Fri,  7 Jun 2024 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="Gexfb3JH"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B2187347
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758478; cv=none; b=oZJmCjMy+wBqXFXBBbaanIpsbrkRo/cDCh874OIjtCegTfru3zgxITCCw5rUy9TrRwURcvnnpSDd5NzSzyueqs5SsVRhn8qiU1b3Gb8nKDeh82/3vcgtCF3WRd5BBfuu+lEDRSg0ADKode4SC8cc5n2/6Ut46g2ezNx+VgXO+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758478; c=relaxed/simple;
	bh=2YY9nJ9us6W8sg8R/K99i1gxDwm586BvWRkpL2Ei9Cc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bB0WDeXkTwPn6cvhuQzfMpXlsCTdhgxI4+e3x4vjt+GXYfT23+RzDpBL7FyuS3TzITKX6Wp1cZtk5D/48CpHcqWcETVNx4GCNhWYcEGIokluliqbvdI0loSXKWSSJ+Zt1QimJTLifs/t8W4bU0JPRQPoP0Lh1MCalniHsebQsNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=Gexfb3JH; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4XVwT+1xZpy/lG8yfKHYuh7fLl01Y2uuzW0Fd0rqGks=; b=Gexfb3JHbr4rq9nfeqnRQXNVaR
	S15amrB0CJg/G5eP+j3yNEMEGDP88sVz4c3OtlvAuiqJpE567QMoQ60GXqidS7ErSvHX84hGiAF+K
	qEs3y190mveyYXJTcVS+TPwDl+YFMbkdBp2IacX17rLK+PNMBLJtkOF3k9mOHpL+sDS30tqkPKL2M
	SwTIAclmQaxNfxVUprjtAMSZ150xe1YLbSTFTFPgaQZ6/JfxiOuClQNivj6HSysZXhb9mB7UA7L6J
	f9o4of9wiDxvUrXFsTZy/SAIySVU9P474afuk+nwIWMqTf3y1v/PKF4Q+spNP045zgdBVXxVkccdx
	uIicKWmg==;
Received: from [2a02:fe1:716d:5f00:20ea:232d:8efa:3ff6] (port=63347)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <BIT@malaika-12.net>)
	id 1sFXRk-00831Q-Iq
	for linux-kernel@vger.kernel.org;
	Fri, 07 Jun 2024 13:07:48 +0200
Message-ID: <a9f241ec-5885-456d-97cf-895c680abfce@malaika-12.net>
Date: Fri, 7 Jun 2024 13:07:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <BIT@malaika-12.net>
Subject: "Gay" vs(!?) Islam (The Vast X, was Fair Pay Philosophy, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The debate seems polarized on "Gay".

In Islam and The Quran, one may consider esoteric referances to Lut, a 
prophet of Sodom/Gomorrah, in modern times, 2nd millennium, where many 
people consider "gay" a normalicy.

There is indeed no conflict here.

More awareness to this please, on the topic.

The Light Be With You.



