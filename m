Return-Path: <linux-kernel+bounces-527876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51692A410C4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C691893625
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A471624D2;
	Sun, 23 Feb 2025 18:21:19 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE35D8F0;
	Sun, 23 Feb 2025 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740334878; cv=none; b=mLXGdYs81B8TcmCm1mM/EJ8r3bGtuZwfhJaEqvYpXPb4Q01WqXYFOjCw4K/+wBPj0ZGcgz5AlnX2EK8wmdJeBHMsCA0WtsDm9Cst78ul+VE0KoXAOha2Zz2Qvd5K1LPTZ+ZQuebcLKbx4ce7VupoqABF5L+J3qMtCYKDYGOakWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740334878; c=relaxed/simple;
	bh=naByVkUiz/GQlhP55+XLPPUFw52CHqfSQjnK+2OSx2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HF0boOTZlfCuvC+mTWu+Kz7uTTsaBG9AN2RFZo+AFXHUBVOO0LJmut243ZgWDgpnctqmfAiVOiOZXpZ9vlz6HjWvewQXBF1e5FInsFvLFACmDppySQMMP18GWAfJpMjAaHhru5kONL7Iv4jokzHZHoax3sQ195PMZfBy6lwoi/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.151.162) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 23 Feb
 2025 21:05:49 +0300
Message-ID: <3315dad1-52a8-4ae7-be65-6b9ccf3dfbfe@omp.ru>
Date: Sun, 23 Feb 2025 21:05:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: olpi: Remove unused otg_ulpi_create
To: <linux@treblig.org>, <gregkh@linuxfoundation.org>,
	<linux-usb@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
References: <20250223160602.91916-1-linux@treblig.org>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20250223160602.91916-1-linux@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 02/23/2025 17:49:06
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 191206 [Feb 23 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 51 0.3.51
 68896fb0083a027476849bf400a331a2d5d94398
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.151.162 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.151.162
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/23/2025 17:52:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/23/2025 2:52:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/23/25 7:06 PM, linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> otg_ulpi_create() has been unused since 2022's
> commit 8ca79aaad8be ("ARM: pxa: remove unused pxa3xx-ulpi")
> 
> Remove it.
> 
> The devm_ variant is still used.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/usb/phy/phy-ulpi.c | 23 -----------------------

   Probably s/olpi/ulpi/ in the subject then?

>  include/linux/usb/ulpi.h   |  9 ---------
>  2 files changed, 32 deletions(-)
> [...]
MBR, Sergey


