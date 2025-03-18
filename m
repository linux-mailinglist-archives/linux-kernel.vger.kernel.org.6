Return-Path: <linux-kernel+bounces-565622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3E1A66C30
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916D4421D26
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988A1EF373;
	Tue, 18 Mar 2025 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b="ZcjGD+P8"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC2175D47
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283520; cv=none; b=OUadMVBm5HgW9vBwtqEwlFUfWIgge5xQcFd812Iv2BcMTuB0SCVXwwAnVEkVBKqTFL8gy4alD84JhZdmpmerE0nrR4FwtzvDNSoLWQi+n3XAm5jogTtReOXooOoYgzpyrGWTpFPIsksJb+Rbu6kZgPJ1/sBiEgBZScgd6dD50T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283520; c=relaxed/simple;
	bh=yOqsahwi9xEJyXDz0jH5KHgGz0DCLz9KkYZ1CRmVPIU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=IAB/ojdVrYu/JCxGOKfKPhJLd2+KOZ7vmvR3LkXH/R8GCcEThBmznqLaOuHEPJOMAiY25XXpCm4EguZvA7zgsjKDoIyemI9gj8z1cAVK1hH5AbTxGOEgpLxImZaIPXlYoWQ0+hgLRE3BKXWpG0lS7YV35L7vWax0PLeIea66FK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net; spf=pass smtp.mailfrom=bit-philosophy.net; dkim=pass (2048-bit key) header.d=bit-philosophy.net header.i=@bit-philosophy.net header.b=ZcjGD+P8; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-philosophy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-philosophy.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bit-philosophy.net; s=ds202411; h=Content-Transfer-Encoding:Content-Type:
	Subject:From:To:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=juv+IG6N2YZx5QpGadFm+7WZC0jDB89Zz04meow6c20=; b=ZcjGD+P8MTbmPb6tIoFySVGXJH
	nUKGpHk9ODSW/kVN0E/zGxsO3FpAtpXIOvnBnLjFre9THP7PTeT7EJ07CJjW8BGigB3RipsKSXSri
	J/4mfuWb5Y0RGwSB2cRT4Tun3trq/kMp6pb81tbC4Hgmz6o0nNOHvu5tSQ8pJGGnGVmteIQ2QIct7
	qjIka9AkDQMhQH83J6/zjq+R+C0aZp7wb3JnOHlVL1Cct1RgPeMBaUcAFZ1TbnBRaShp3IIYv4EGp
	bKdZ0ktUhBpybmdJ5oOJdsA5fs1ThZJADTTpZpUn4j8glAwu/+vnr4H7VZNuwtuxzs+3t9nH60jaB
	qr2GM3fg==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1tuRWt-00BJOC-2g
	for linux-kernel@vger.kernel.org;
	Tue, 18 Mar 2025 08:38:27 +0100
Message-ID: <17341ea2-1279-4af0-b723-7582cacee852@bit-philosophy.net>
Date: Tue, 18 Mar 2025 08:38:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?Ywe_C=C3=A6rlyn?= <ywe@bit-philosophy.net>
Subject: Haci-Muslim: Philosophical background for Fair Pay, and referance
 concept Bit X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have tried to get the point through of a philosophical background 
needed for a quality better than windows in computing space. 
Christianity is already what "Windows" is about, and many are unhappy 
about this.

Instead I suggest Haci-Islam. Haci no doubt being a familiar word, and 
it is from Islam.

Here we also partition "God" into things like "The Good", "The Guide" 
(correct), and Syndrome, 2-gon, 3-gon, 4-gon etc. Defeating this 
concept, and correct to do.

Many want a more scientific wording on this, and listen to reason 
indeed. The ONE is just as much about this.

So please support my efforts on this. THIS IS WHAT IS NEEDED, for 
success other than the regressive window of oppourtunity of Bill Gates.

Light,
https://bit-philosophy.net/

