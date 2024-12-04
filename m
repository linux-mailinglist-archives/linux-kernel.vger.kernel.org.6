Return-Path: <linux-kernel+bounces-431964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ABE9E4339
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FDE2827CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332A71A8F75;
	Wed,  4 Dec 2024 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b="e7uin2Gn"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98F23918A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336532; cv=none; b=JbcOwg2SMOVN4tfsdIKJiUibjORmnMG2yqZHwVE+FijRAI9I//xYBdA7LT2QDqRsn3rA/fuXGyoOx/GTleMIghbyRxbP7J40ag/BiKDFDkBvyJU4l2dRKo6vuRx00yX1r3uVcqQvO+5bXiWAwDrHmE0bNbrgfPi8PnsB9KHq6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336532; c=relaxed/simple;
	bh=0PS+l/hB2jnbGoDrk5etGwhRAJ8YKF2cGbjfq7Basok=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qsCRZCiAqaFrZ632lk7KvJui1FSDtvRQNBMDVbPthJKkqCo9UGsHOB8b85GP00LoNDsIvBXJKlDgw3ntnqwHC/5u6voOLtskxcpa+3fMvPgxatxh/h3NoLW4jT/Y8HS3dzlk8touVXUKMOB9t/xum3/sP+1b3SrvAGg2zHLvq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net; spf=pass smtp.mailfrom=bit-philosophy.net; dkim=pass (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b=e7uin2Gn; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-philosophy.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bit-philosophy.net; s=ds202411; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zUTi04IOU2Opx/NpmqVoRnLl6cyWEf3V6giQ812XL1o=; b=e7uin2Gn4VabDyJ7+lTbXXdQnc
	WFvCMmWlG0Iq55WWjWpX7HcenkfpPqTrTsWKMXb3GIAUi0KRSNXp3/FadwZ6qZ1ZZAH3Y9iQcRI7J
	WkULglMAUgCYY6/NZnr9d4n2VhkcUQuqdDcWtHVxj36X7ZwytFjRVA0287tTlyUBQSrKcsOO5mMlt
	92cW6YCfRNg+U5XT6hxj4phW3r5VJYIfnjjVxrZAUUjzFaSLtscyknrZb74CIHcmWshWZZKYfDSe/
	AHu7OnPsIK6WA7TBcVAQ9HKMVsADpRTyP0vGxTiy6cs1PeSQMmnZ0A1Ant/tsgcCeUYa1H135YmnP
	5Mv3WnVg==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1tIth9-00Eoje-1v
	for linux-kernel@vger.kernel.org;
	Wed, 04 Dec 2024 19:01:51 +0100
Message-ID: <232aa250-6076-42bd-9fc9-119c4faf6ce3@bit-philosophy.net>
Date: Wed, 4 Dec 2024 19:01:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <abbed@bit-philosophy.net>
Subject: Philosophy Perfections for Bit X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, I have written a few emails over the course of the years.

I think philosophy perfections are now of a high degree, and invite 
again to see my webpage, https://bit-philosophy.net/

This was the project that inspired Mandrake (Bit rewritten), Gentoo 
(reflecting the intent to have a pure philosophy), Bitstream and 
Bitcoin. We also use the @ symbol, that also is similar to Debian!

For mainstream aooption one needs such a philosophy, and do not be 
concerned that concepts are not known, even though based in Islam. In 
semicursive script, MANY of the concepts are known, and in use.

Light,
Ywe Cærlyn
Abbed.




