Return-Path: <linux-kernel+bounces-232958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 668D891B07A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C98B1F22AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3FE19E827;
	Thu, 27 Jun 2024 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=the-vast-x.net header.i=@the-vast-x.net header.b="pSc1o4pq"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18C319B591
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520439; cv=none; b=MG/WT+wd5yIx0KAsXI5mTJpm7VHe/AvpXgEebNIshuzpzyiQajesbwiJpJWxSaoO6VFfxoKNBlh0I6vLTthmT1RlACyqNGhs/ZkvP9ELcbFsJWH0k/Kb/r+bjdOnHpG/nrFqAPJwghJrBiSQkbnddLpHEJIlO7suxBWWt3JynnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520439; c=relaxed/simple;
	bh=5mKk8FZwF6BBTbx0rOs2LKDnTeK8W6Jy4xnfGc2uXYc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=YQwa6bVyGcrWe9zKe486cOmZnoVX6fFMAggbrDsNn2mOLyEuimmGW7Xr2ZJcWPpoTInvknFERYRzQXZ/1dBFYz77v/VfuQ+mKhmtXzLxqjzsgK69vxikrNy0cpEK7zdWlawycYltprJu5+Exw7qI63sAuEOks5oFFlMEfH/mM14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=the-vast-x.net; spf=pass smtp.mailfrom=the-vast-x.net; dkim=pass (2048-bit key) header.d=the-vast-x.net header.i=@the-vast-x.net header.b=pSc1o4pq; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=the-vast-x.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=the-vast-x.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=the-vast-x.net; s=ds202405; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4APdmSHP7GddI8txPjGLnS5J77i/Y+XETblcBDp1mzk=; b=pSc1o4pqIcMbSG6Kmi7FUZUIVf
	On6xRB2k751idFPyrmlRdJVpa91tnFLazaYg+VsjdJSmEUC7n+whYofA7+bLCdu1gsgB6bDVOvcOM
	qNydZuPHAr3JfxAa1QiE1Vkx67Bhs+Zyu5pZi2eSdrpXjJWqUYNuSuJooUz+BbjtaLlfmvCH/emEx
	JiFz85wSW09VI0hk/YCFPGsb3ivvaaycjPbq2VbAUPGTY/bqVb0Hvp16YwT80oyTvzCihUIuaG8lN
	r2eq9Qe560EPJ6FiHSy6TL4mm6ProzwECvPKmf5LsHsRpLkjyeVR4FTen3SFiw1y6HShTeRPcOd4M
	sfgLrU0w==;
Received: from [2a02:fe1:716d:5f00:ad1e:3449:fb:6118] (port=51721)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@the-vast-x.net>)
	id 1sMvoU-0059Xj-3g
	for linux-kernel@vger.kernel.org;
	Thu, 27 Jun 2024 22:33:50 +0200
Message-ID: <d47bd774-b628-47e5-aa59-e4e5c6259e9b@the-vast-x.net>
Date: Thu, 27 Jun 2024 22:33:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@the-vast-x.net>
Subject: A suggestion for Standard Config
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The Standard Config seems a bit odd.

I would suggest a low-jitter config (preempt), not quite realtime (that 
is for special cases).

General Low-Jitter Config, 90 Hz Timer, XFS Filesystem (good a long time 
ago, would be wrong to deny that).

Good for Games, good for Server. ~200uS peak jitter not uncommon.

Ready for Renicing X/other for full desktop features, without 
performance issues. And realtime audio threads.

Ywe.




