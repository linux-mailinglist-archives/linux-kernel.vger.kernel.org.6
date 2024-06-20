Return-Path: <linux-kernel+bounces-222496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38510910271
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5054D1C21091
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DA61AB539;
	Thu, 20 Jun 2024 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b="Qwz4o8kD"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89827481D1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882622; cv=none; b=K9vvjnSeo17Z3uEtslFdclfKYayQZlYcHyqe8pWfoHcLE8v6MmfE+EJ5KbH1UHfaz0387b+BzZ9FIcXbGhNmo+aY20gZDEseIaybdYFkWTo2RFWnr6p7cWnCcCEzIgcb6PdSK7t4NKDFjqvdvx21axarmNzbtZZ1Ti1z2rS9iyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882622; c=relaxed/simple;
	bh=oXO8U2Kzh0z3jDGLNeY6Xs2ZRJBD8X9o+PeKIh0KrNs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HLQWHH0pOkJy+4DebmBQjchzg8JCjb/m1od93BkFGN/zJm7phJZVMpSGU9ha3E6UWkVmyRdHYcRHeRcnhixd/E2B9RWfuC3FSy3GNWcdrSHQ3loMywt5H0WzxhFMQULPbvmvUlWiydrPkRcwllvvjl6ehxoa2Mb9j3YAlam8e2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net; spf=pass smtp.mailfrom=malaika-12.net; dkim=pass (2048-bit key) header.d=malaika-12.net header.i=@malaika-12.net header.b=Qwz4o8kD; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=malaika-12.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malaika-12.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=malaika-12.net; s=ds202404; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8d9q/z5w4z5XBryY6cnAxgKRJxXIq1G88eKXmbhfT18=; b=Qwz4o8kDt1EWD0QdlPfbq3doQl
	MOi9ztF8OlZ8mhts1G8rY5BW89MNMe7Pn8rrscwubJKzq403kZO1zbXNyeX9Pt1xU2FS3cmaEXQbB
	p4qBZElCX0z5j4BDuHFwW7SBtWNnvNsaSSc0Gtw4ZHXzKUIigjD0dz87XGHIJ3wY1J4DD9X9Xij4B
	taPJvCqKzhZJQMtqEDov/ZYZwEYUEjFFxzJM90Tor0j+EK2X7naD0eJ+2nAXphczz8fey6hU+pFsp
	aXeSypoAcHZMBs1OL4n11U9mjo4wXkh4irDM24sVkjToO7KU9UToDxB4fMUvSWVibKCdFALEQ+BRV
	yWAMBp+w==;
Received: from [2a02:fe1:716d:5f00:f940:7ace:518d:8015] (port=61434)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <BIT@malaika-12.net>)
	id 1sKFt7-000gjS-1o
	for linux-kernel@vger.kernel.org;
	Thu, 20 Jun 2024 13:23:33 +0200
Message-ID: <1be39d2e-4d68-4c5f-9a7c-a9d468589a56@malaika-12.net>
Date: Thu, 20 Jun 2024 13:23:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <BIT@malaika-12.net>
Subject: Freedom Software
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

There has been a debate on the meaning of Free. I do agree that it 
should be about Freedom. Freedom to modify source, according to ones 
needs. And furthermore freedom to make an income based on ones skills.

The Statue of Liberty could already be an icon on this.

So I suggest so, and continue my work and research on related topics, 
for The Vast X.

The Light Be With You,
Ywe.
https://the-vast-x.net/Ruhban/Ruhban.html

