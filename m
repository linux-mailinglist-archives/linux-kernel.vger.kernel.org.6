Return-Path: <linux-kernel+bounces-562730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B206A63202
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 19:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916911896E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E4199FC9;
	Sat, 15 Mar 2025 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b="TRmcVoeZ"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B95B199252
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742065002; cv=none; b=GubYQkPIc60pjkRbiS8/z1rLsRSEmav0FbcWQjtNRZjknVm2FPxw2LNsNGSEtChg1MGfmjJE6q+btsZGuW8TwbxttdwB3/mSdoDZWqqaLfY/EO++E9KH/69C+FlQlvYJe95dvlTcPum8Z2Zw2H7r3iJi7JJzUQahl/6NT41jlnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742065002; c=relaxed/simple;
	bh=mL2SYqeLHUm5sCNL8wFlBB+rXIhuww8xWvBcMByz9Uk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Ct/aml+xP51fO0uUAeLomIft+UjjNGklNSvuJc2EhUG7QzS6OoZsEFiuicwzv7+4LtTG1g8otXXctly71rl0MKlHhArwi/95Lak03Kq3bgb5pVsVGUVEikOHzo+xEsNIXVB0zlkT4wqwngexEaj1ODcqASAE/ZUMsIujOMNBU6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net; spf=pass smtp.mailfrom=bit-philosophy.net; dkim=pass (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b=TRmcVoeZ; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-philosophy.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bit-philosophy.net; s=ds202411; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h/B0oURU7Y4M1byTzKNAIfa2LcnSkvfO2XmWhy6tJL0=; b=TRmcVoeZyyFCvKe1GnRGAJwLZM
	MO0pPdNIwf4MgOW3DSY/NFYBXGVlaM1W9lYNRGXiw6/JrFuAsd8uWPyafmep8jOV4dA2JQjp/oFI4
	72VGMOPHTRVFvWlD0VRn5ryfjoTw7eFETfkKxP6XcCCtiz+EGLH7396vdMkiJhLIpM95yCxJxyXv1
	IWh9gy9WRcOqWxcOwGiNjNZnzqoYg37FEda1SZm56q/oVJaclAddR1MVjEiMZku9JG1ZXwL3FtUun
	bao+JETvubPlPZc987B3PMkbStGaB02h6ijqzvEWQdWiL0W1JgoiqNvOWKHUgrvXbZ8RK54kKRs4a
	rLqzRCTQ==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1ttWgT-00Clzg-3u
	for linux-kernel@vger.kernel.org;
	Sat, 15 Mar 2025 19:56:33 +0100
Message-ID: <2a3ca0fa-9f6a-4c24-bdaa-229afe2093ee@bit-philosophy.net>
Date: Sat, 15 Mar 2025 19:56:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe@bit-philosophy.net>
Subject: Low JItter, Cache, Fair Pay & Philosophy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I made some final decisions on Cache. I think L1 cache seems good 
enough, and does not need to be that high. Maybe even 256KB. Togheter 
with a 200uS jitter target, the commonly used instructions will 
alleviate standard RAM where neccesary. A good CPU with an optimized 
instruction set for good use of cache and low jitter at 5ghz will be 
enough for most. Doing more pr. clock where optimal.

This will give good bus timing. Meaning good GFX and Serving.
Near realtime audio for audio also, that really with such a low-jitter 
setup safely can run realtime, avoiding audio dropouts.

More of my philosophy on https://bit-philosophy.net/

LIGHT!

