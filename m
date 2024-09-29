Return-Path: <linux-kernel+bounces-342909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A172C9894A5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 11:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E33D28322C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F7114B970;
	Sun, 29 Sep 2024 09:55:53 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA4184D;
	Sun, 29 Sep 2024 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727603753; cv=none; b=oDDgEcgHO0yYksHTKkmzNYqKX7x4arQxDY7XD5UmZHLdsX2xbLj4eZ5S4aCXEFIy3hjFNUOwdx41ht/KZbybA5QZ3OvczW1AQ5GUB07MEUN9ZxRWYDEAQpexqHelJgCKG0yThgwjfepi8uQlsWJFxRNst5cI20WiJ4iRR6i1YtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727603753; c=relaxed/simple;
	bh=O/2rmvKR+5NtdVY6ebVwSsa91Od+zulBtCCMr/wTOAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VDj6Pt1RE2hGlZyU08cqlOv3+4XwenC6W7rRqYKn2TkLZdtvrtQswjmwpFvpyfI20r+UzcN3aYPUwgmgecZp8ZhQ8KD8VUk1l7G+BTtlgOajz3WhoAOY7sg7GFpt55puGgPXKF2QNqSD13V3BWTnajPoKE9u7AbwIQ4wWt47pIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.100] (213.87.160.79) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 29 Sep
 2024 12:40:27 +0300
Message-ID: <6591a368-e2aa-fa8b-c3d0-2a438f52c126@omp.ru>
Date: Sun, 29 Sep 2024 12:40:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] usb: dwc3: Correct some typos in comments
Content-Language: en-US
To: Shen Lichuan <shenlichuan@vivo.com>, <Thinh.Nguyen@synopsys.com>,
	<gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<opensource.kernel@vivo.com>
References: <20240929075856.11516-1-shenlichuan@vivo.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20240929075856.11516-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 09/29/2024 09:26:41
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 188067 [Sep 29 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.160.79 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.160.79
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/29/2024 09:31:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/29/2024 7:05:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/29/24 10:58, Shen Lichuan wrote:

> Fixed some confusing typos that were currently identified with codespell,
> the details are as follows:
> 
> -in the code comments:
> drivers/usb/dwc3/core.c:1406: feild ==> field
> drivers/usb/dwc3/core.h:84: boundries ==> boundaries
> drivers/usb/dwc3/ep0.c:148: issueing ==> issuing
> drivers/usb/dwc3/host.c:38: temperary ==> temporary
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
[...]

> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index e0533cee6870..60f7a55e1ea3 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -35,7 +35,7 @@ static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
>  	u32 reg;
>  	int i;
>  
> -	/* xhci regs is not mapped yet, do it temperary here */
> +	/* xhci regs is not mapped yet, do it temporary here */

   s/is/are/. And maybe "temporarily"? :-)

>  	if (dwc->xhci_resources[0].start) {
>  		xhci_regs = ioremap(dwc->xhci_resources[0].start, DWC3_XHCI_REGS_END);
>  		if (!xhci_regs) {

MBR, Sergey


