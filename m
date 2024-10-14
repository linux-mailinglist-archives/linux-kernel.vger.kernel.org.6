Return-Path: <linux-kernel+bounces-364059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3168299CAA7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3013C1C22601
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37261AB51B;
	Mon, 14 Oct 2024 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Py72VoAW"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE71AA7A3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910135; cv=none; b=FKLH59rjyXLHSz6k231zmS75ET6nC1B4LAlyGAXU+g99/Km19XCypQLeOa3Cf/08typrrooRXaWWXYBoZZ8+4shdwZAe3A7GeeIrMKdWNVvlBDqbzhE1ECWVvRLVuPmDop2tRcQxGG3AMh6dn6vEjQuA6GyvNK1P/Q1i2XnGJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910135; c=relaxed/simple;
	bh=7LhhhQRT2nyizYN7S+xOE5m9y1eRFjjIqVFqE564MIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kaZqJzXwzQgTsqZPQYwj6HQ3+yBLvxAe2SEpO7uOQwlQpHwcjq7vYVCvNQpoEhBLlM2j7VG/Dfa399em8dK+j19kSIK9BaeE0NJm7U9KbEYc9WcvNj6Yqm3UN3+Q0yJNlUTR1AbaXUxvCXnfqg8VBCyOBMZJXM2MdgynpLRU+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Py72VoAW; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id DB919120002;
	Mon, 14 Oct 2024 15:48:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DB919120002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728910127;
	bh=fVQkNp8dSUOXm1yK+m0qUmR2UNH6+5o94IDMSLhf9sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=Py72VoAWN2BnJvnMjcHil7KH6qNU5mVPuYINUUD08b6e/XCIGF33JUHag2ffnFPof
	 OeJG1UcbkpOcCMeQPvUBUb/QhYOrx17f+tRKlRpg7PR62QVe/JFKJYz+CeD6d0VcA6
	 BaiU798CoBm8H+uOlqKaGPp77iXURa/ao9TR6uIxmzmJ0oIkCjAVRt2qc4ira6yyLN
	 7c7RmJfOEb4TyeMHii8iu/lcLrGZgrWG6JHT0AzGK+YG0NyXZn/zoBALbvqLKIT43V
	 dJRLXFhQtQOIXyZcstEqMxHLJZ1/pYCxGzMJzlBCtCHwDrBu/hzUGnVE5r+SpiO+0t
	 89H0Lk3CUn+Ag==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 14 Oct 2024 15:48:47 +0300 (MSK)
Message-ID: <de27927d-ce37-4c0f-85d0-e32bae3f0ef9@salutedevices.com>
Date: Mon, 14 Oct 2024 15:48:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mtd: spinand: micron: OTP access for
 MT29F2G01ABAGD
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
	<vigneshr@ti.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Michael Walle" <michael@walle.cc>, Mark Brown <broonie@kernel.org>, Chia-Lin
 Kao <acelan.kao@canonical.com>, Md Sadre Alam <quic_mdalam@quicinc.com>,
	"Ezra Buehler" <ezra.buehler@husqvarnagroup.com>, Sridharan S N
	<quic_sridsn@quicinc.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
	Alexey Romanov <avromanov@salutedevices.com>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <kernel@salutedevices.com>
References: <20240827174920.316756-1-mmkurbanov@salutedevices.com>
 <20240827174920.316756-5-mmkurbanov@salutedevices.com>
 <20241001113108.4fdb6360@xps-13>
Content-Language: en-US
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
In-Reply-To: <20241001113108.4fdb6360@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188417 [Oct 14 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/14 10:53:00 #26751613
X-KSMG-AntiVirus-Status: Clean, skipped

Hi Miquel,

On 10/1/24 12:31, Miquel Raynal wrote:

>> +#define MICRON_MT29F2G01ABAGD_OTP_PAGES			12
>> +#define MICRON_MT29F2G01ABAGD_OTP_PAGE_SIZE		2176
> 
> In the core we did add the data size and the OOB size to get the OTP
> page size. I would prefer something dynamic here as well, otherwise the
> implementation is very device specific for now reason?

Do you mean:
otp_page_size = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand)

>> +		size_t i = 0;
>> +
>> +		/* If all zeros, then the OTP area is locked. */
>> +		while (i < buf_size && *(uint32_t *)(&buf[i]) == 0)
>> +			i += 4;
> 
> Shall we expect buf_size to always be a multiple of 4? (real question)

This function is only for the nand flash MT29F2G01ABAGD that has a page
size multiple of 4.

-- 
Best Regards,
Martin Kurbanov


