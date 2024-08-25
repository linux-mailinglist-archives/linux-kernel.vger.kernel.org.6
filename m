Return-Path: <linux-kernel+bounces-300244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D4295E0F8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415661C20E12
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 03:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F28376E6;
	Sun, 25 Aug 2024 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=moabit.uno header.i=@moabit.uno header.b="JPAjAqxs"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8642BB1B
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724557788; cv=none; b=VqQCkYYra8bMnbOefVpKnZQrwns6FQIWMd7mEMnER8Dum/ss9Auhz70LH9uXM/g/J9dp31sObMXTc14JrYqw+gXt68I4yQggbVBckbMwBfGCFn51hKmeCGqZrMlBiKmroHqMhsn3ZcVmSuFM4W88SbhADtK3dl30G6hhLz68SLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724557788; c=relaxed/simple;
	bh=qeHwI3cQ5FPXVhaIUl4qEg8LEOCava/FxgpVruSNwWA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Hdhvq+bkay6j6hu5XBeKGV3rU0r6mQSD6A8x+NBBaKycx2ZwhqlGqxKGTuGFdTCtdrWuBVPbq6IbVZUlM7CvfURWo+xkZ3hKJQFqbkSQ6ydf+6TfK+Uvimim14ucQb54FVePv8LWz/QFSaduH1rrUhYdyLkCFMQAyDBTFPmDpcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moabit.uno; spf=pass smtp.mailfrom=moabit.uno; dkim=pass (2048-bit key) header.d=moabit.uno header.i=@moabit.uno header.b=JPAjAqxs; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moabit.uno
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moabit.uno
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=moabit.uno;
	s=ds202408; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JpjAX3fav2a4cCbqTCBnN/PcJhHByqtnClKKxBkFoz4=; b=JPAjAqxs6Il+TSUbYjO+pZUaWz
	64PxROQ56V9fkSUP66mcNW79QqH6HAL/6+4W+i9MshWy5qbHSobkg9x455I0ZTCNjllXVf7AiZXz7
	wDQCGCU8R3WoOwECPg46jngW9qRs2BMFEG9s+eaelXbWpZZzVvgd7Cw9Z+DAyU111aCWVRlpnJcx4
	Q7QZw+deGIDSD6ne61Y3oouCMMOvGDehWG6dEPLd5/Fm9Rrwiq2HIq3qUI9F2Rqsu3sdOplOSGmGj
	lDnOlcvFKjIcnJv/c2EMltjfVhmju/a2HQPJdW11kmAGyrT55wWa7JnhQZXgOnr1uAUab3gUbkXIS
	dB/nCOFA==;
Received: from [2a02:fe1:716d:5f00:f940:7ace:518d:8015] (port=50547)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ruhban@moabit.uno>)
	id 1si4G3-006u3N-4M
	for linux-kernel@vger.kernel.org;
	Sun, 25 Aug 2024 05:49:39 +0200
Message-ID: <eb2ebc0c-cd59-4cfe-b87a-0232e8232b9c@moabit.uno>
Date: Sun, 25 Aug 2024 05:49:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ruhban@moabit.uno>
Subject: Sin? (cont: Low Jitter, Philosophy, Fair Pay)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

There is some discussion on whether to use the concept Sin or not in 
electronics design.

I think the association to sinfulness is suboptimal here, and IT can 
actually be used for electronics design instead.

This unifies computer and electronics design, with fair pay background, 
something everybody wants.

IT short for The Initiator.

Read more about IT x philosophy background on https://moabit.uno/

Light.
Ywe.

