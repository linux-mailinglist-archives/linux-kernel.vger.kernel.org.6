Return-Path: <linux-kernel+bounces-364026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FC699CA09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2093A1C22842
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BBE1A0701;
	Mon, 14 Oct 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="KNSzbho3"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1D8F64
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908887; cv=none; b=ONLVKs6SymqRXqTFLSY/8H2Za88+qr8CqTYE2+M2qKHZC3Zhn3EspmRwnW8Jgx6T6JNVUViXg0rhAbAbqaabvZNy8Fq1aCsSLX+lttvIjmR28y01RSaM3RKIk6e0FSds4bmNUEIrkwLgkcyaz05leqxPvHWsk3tUsYPo35sxq2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908887; c=relaxed/simple;
	bh=SP/qoFw7eVmxJKuKGs2A0+VORBPFlBO3P3RLV7FVNgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q+2sNS9w7dar3RqpGxMn7F8Q51ON2v1IPww10vldBwVOc6ilYAw7dcFtr1KMJg+mqEZ5AeEd8Rdtn+Ki77bZ9c7I+jOjkwYlA2u1oA8fSVEKEVfHo/wyFBlTksROquXL/emWpDCRwRfEpORvpb7gzYpO4HecPs1w72OpjnctAfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=KNSzbho3; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id DE8E2120009;
	Mon, 14 Oct 2024 15:27:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DE8E2120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728908867;
	bh=Hm+XhRX4TIgzDknahBKuXWyWd5Q9+AsIAU5whoj+RvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=KNSzbho3rCQbwO2Frovwko8WO5o4sGngh1zAL313SYy3/ui6gZKFZBNLc6e5nk9at
	 2eWPFDbtV0LnGTCjTlWezWoPthRRhkFKxpvbgYIjPXNDpLaZiMTgIn4UwhGREpfVBt
	 rjHAfTF0l414Y6QDs59AtVqeW0XtLoXxWwmUoNZwNOJjBKhKfS2v5Dr57Fh+84NYqG
	 K7S+CFvGeT4tGUB1aGjeoiPvDEmvyjQa4bhE8wIqhUNIvor4YfGqw8TARuLCRipKah
	 LR8HAA3tGbdFEjKzO6GmQQNeIFLXeidOdcmiBYCkx/76DE+qu+WgNiCXV/ISqcgciZ
	 COUALLAp9L9sQ==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 14 Oct 2024 15:27:47 +0300 (MSK)
Message-ID: <4ddd0588-0ff5-4c31-94b0-c9f0e453d98f@salutedevices.com>
Date: Mon, 14 Oct 2024 15:27:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mtd: spinand: add OTP support
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
 <20240827174920.316756-3-mmkurbanov@salutedevices.com>
 <20241001111225.36cb9701@xps-13>
Content-Language: en-US
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
In-Reply-To: <20241001111225.36cb9701@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188416 [Oct 14 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/14 10:53:00 #26751613
X-KSMG-AntiVirus-Status: Clean, skipped


Hi Miquel,

On 10/1/24 12:12, Miquel Raynal wrote:

>> +/**
>> + * spinand_set_mtd_otp_ops() - Set up OTP methods
>> + * @spinand: the spinand device
>> + *
>> + * Set up OTP methods.
>> + */
>> +void spinand_set_mtd_otp_ops(struct spinand_device *spinand)
>> +{
>> +	struct mtd_info *mtd = spinand_to_mtd(spinand);
>> +
>> +	if (!spinand->otp->ops)
> 
> Could we use something else as check? It feels odd to check for otp ops
> and then just ignore the fact that they are here. Maybe check npages or
> otp_size() ?

A developer may not specify OTP callbacks:
SPINAND_OTP_INFO(otp_pages, NULL /* OTP ops */)

Or do you mean that it is better to check in each function
spinand_mtd_otp_{info,read,write,lock}? E.g.:
static int spinand_mtd_otp_erase(struct mtd_info *mtd, loff_t ofs, size_t len)
{
	struct spinand_device *spinand = mtd_to_spinand(mtd);
	const struct spinand_otp_ops *ops = spinand->otp->ops;
	int ret;

	if (!ops || !ops->erase)
		return -EOPNOTSUPP;


-- 
Best Regards,
Martin Kurbanov


