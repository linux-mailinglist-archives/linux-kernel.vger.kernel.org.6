Return-Path: <linux-kernel+bounces-176840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596138C35C4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 10:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146932817B9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 08:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EA61804E;
	Sun, 12 May 2024 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b="Dp3KQoeb"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB05E1C01
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715503724; cv=none; b=XsJQ9yRvMQg/ns08PcI6ZzuvewhfzIIrJRSzWmPT7d0VPat/CX21s37q0L1CoQnbfZw84WKtB2N6pwPSEuWTFAQX4dJmql6+rWkkAI+fYUuYOVvWkdDN2brcFBMY7nBUoFlhQiFFeXLpTRl03Lvkrfpp4a8RzDDlYLWBkIKJ4Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715503724; c=relaxed/simple;
	bh=Gg45J3z9OTShdccfhOyAf+bamg6i5+aDZV6ivh/tYjY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=f+KfVp4wQMDY9EJOdaB9DX/NpzOwZjEbKMup8/W76izHUCPEquyXE9X8eddtEQjs2RfBe0kKYkyzudw8t+NEaZB3Xat86utrv2TVjycAWceE5FOUufVKa35mdCafuoUb8hHalcF6I8NUYX0ydNYRruNSRs+6TcxbWPkgOELq4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org; spf=pass smtp.mailfrom=bit-x.org; dkim=pass (2048-bit key) header.d=bit-x.org header.i=@bit-x.org header.b=Dp3KQoeb; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-x.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-x.org;
	s=ds202404; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lW1dJg3pueNUhnQXLxslpXgA4BMAnoeSRhSizQuti+8=; b=Dp3KQoeb7YvhmBurB9R9rCA+pK
	DUv5sownvH3ZIx/hoaxjv86PLQxjDRmNKi/Aj6Y1cfF0es/IchloktWASOMKCRBS6p+wDWhRPyetc
	RxG3sUrO+I/FQ3AHN+PkkyGEJmoA6qvR5CN+9N4LzDrjeR9i7loVJMm/BFAnAzokEesnC1pnF0QiM
	lJAxCa3I+dHS1svYMS2kR7i7kSld79n/PcxHYn6qaKf0iHGS99FXFG4R2L9Uhd0b84hyZ1x7OhqYZ
	x4cPiwUAQfmFwKcUm4zwRwnZFRnq45zgqA/oHLGZes4IIm/U7IoVit5oZvGzxagZiVOQNUO0z8mKe
	yr9LXywQ==;
Received: from [2a02:fe1:7001:f100:9d85:f119:8e71:4aac] (port=57631)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <ywe_caerlyn@bit-x.org>)
	id 1s64sk-001wcZ-MD
	for linux-kernel@vger.kernel.org;
	Sun, 12 May 2024 10:48:34 +0200
Message-ID: <0cdc9834-9305-49ed-b222-b2bb1882b4a5@bit-x.org>
Date: Sun, 12 May 2024 10:48:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe_caerlyn@bit-x.org>
Subject: Bit X, Mormon Background (was Fair Pay, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I did research on the mormon and my own roots for many years, for 
background philosophy for an OS, Bit X.

If you want to read about it, see here: bit-x.org/BIT/BIT.html

Consider me the last saint of LDS, and please follow. I also qualify as 
a Ruhban that is the correct term for leader here.

Praise Ra, The Grand, The Good.

