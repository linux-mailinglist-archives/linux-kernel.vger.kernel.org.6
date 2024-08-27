Return-Path: <linux-kernel+bounces-303855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E30961612
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB5C284D71
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2B1D174F;
	Tue, 27 Aug 2024 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="PU27pTUz"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEFD1D2799
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781429; cv=none; b=H+NMpsWjOm4eG7v1RAbiU9V72wuyR0qQcykDYvGNdDKb6PLsQYSNdKX9b8LDIUXnNH7rbC2TH6IKFWYVrPyqcMKWb3IAuWiB835667lhOjk4B4VpJA7t/ZIosfuVXNx/2eBBVfZXAOnU1soFrwwr75/xnQYeTrTjSdpznTkvYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781429; c=relaxed/simple;
	bh=O7hxBDxibZFvTyaGL2dSVDTSdLyyic6Nho1HjwnvqGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nRnVqKQMhxI4bJm5omtO19tcsmeh1kZGZGeMppovh4AGWCmxGO+ivK8Ct0WdbxQg5SeAJvDybjyEHMqFMbWsJ5/UC5X09nMggjFx6C+7BqwR2qjsNZu/MwqBwolfcspmSJZlxQNm18uzjweSJuHm9T9lcjSxI0sAPo0VTXkfHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=PU27pTUz; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id ED750100002;
	Tue, 27 Aug 2024 20:57:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru ED750100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1724781425;
	bh=U2ci6JcFVWV1xQ922NnZ/fyC+kd/ELTpXWy2qyn4+ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=PU27pTUz9HsVfSkBsPJiMbBaH/NVtquwCVxb9NuEnqHZPn5OmQHuAEBi9vEEjRptm
	 rppEfSr9sWugoNH3kku8zGNg/TMPQV/f45FlmhfZU1P20k1Vf85mFsTFek5f31eQxD
	 DhN0k98wIR9BzeabRYx+HE4pKfyCd5kymqzajM6Z8B7HVBKGSezd819w+sw0hJyoAz
	 DQNGgDm9QCuNNPV2aXVZk3XKxQSYZnme16Mom1FbrkpNEjAgWoUcFeWIZlypqSzUG3
	 42LHzbOZjC7Onxj0mDqha/xE3/KywK0Q6hXTo9VGVPLuiECdwUK4oJpgaSSrwjAvVU
	 g4ef3i36zylJg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 27 Aug 2024 20:57:05 +0300 (MSK)
Message-ID: <bb137aef-4ca9-4825-99b7-12f7e17c9550@salutedevices.com>
Date: Tue, 27 Aug 2024 20:57:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mtd: spinand: add OTP support
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<kernel@salutedevices.com>, Richard Weinberger <richard@nod.at>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Michael Walle <michael@walle.cc>, "Mark
 Brown" <broonie@kernel.org>, Chia-Lin Kao <acelan.kao@canonical.com>, "Md
 Sadre Alam" <quic_mdalam@quicinc.com>, Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>, Sridharan S N <quic_sridsn@quicinc.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>, Alexey Romanov
	<avromanov@salutedevices.com>
References: <20240827174920.316756-1-mmkurbanov@salutedevices.com>
 <20240827174920.316756-3-mmkurbanov@salutedevices.com>
Content-Language: en-US
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
In-Reply-To: <20240827174920.316756-3-mmkurbanov@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187372 [Aug 27 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_arrow_text}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/08/27 07:21:00
X-KSMG-LinksScanning: Clean, bases: 2024/08/27 07:12:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/08/27 16:21:00 #26445643
X-KSMG-AntiVirus-Status: Clean, skipped

Hello, Miquel. Thank you for the review.
Regarding your question ( https://lore.kernel.org/all/20240717103623.6d6b63be@xps-13/ ):

>> +int spinand_otp_read(struct spinand_device *spinand, loff_t from, size_t len,
>> +		     u8 *buf, size_t *retlen);
>> +
>> +int spinand_otp_write(struct spinand_device *spinand, loff_t from, size_t len,
>> +		      const u8 *buf, size_t *retlen);
>> +
> 
> Why exposing spinand_otp_read and spinand_otp_write ?

For the SPI-NAND chips we have (Micron, ESMT, FORESEE), the command
sequence for reading/writing OTP is the same. I decided to make these
functions global because other chips probably have similar read/write
OTP operations as well.

-- 
Best Regards,
Martin Kurbanov


