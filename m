Return-Path: <linux-kernel+bounces-576017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9425A709FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3A11883B79
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4BA1C84A4;
	Tue, 25 Mar 2025 19:04:38 +0000 (UTC)
Received: from mail.hows.id.au (125-63-26-112.ip4.superloop.au [125.63.26.112])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C552E337C;
	Tue, 25 Mar 2025 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.63.26.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929477; cv=none; b=KlAETmcO6t+LUHLUgicFjJ1jQ5H2K2K19z1hEI1BlkH8L75ypRReE2VvhJTx5KEQbhYpJcd+3sd5peFYBxpZ8C8E782HUOw3nTAT1TTDYDg4DXOqcpghZULAoW2uyZsxJ+YknVW3P8+NwUWTruKtVzpzkS5CkEWIGu1vHHXKXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929477; c=relaxed/simple;
	bh=C7fdbGqOm8KeNvzziFzVaKjZtGQFX0Zz6r2W7/9j4YU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=SLQGjGR9BD19l8I64tSJLT6DyXEsdSWe7aatGP8dZWLTpBH/Coj09u6hbjArEeEG9R6pojGR+O8MOb4fmB/QVt5tSYpxi4Z+0N2+VpQE7dIBOULOPl3OXu9PPfXhfDSrxOLH/u3zyHNy14p+XJXrjTArquoqKlx6zELJyuBFJKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hows.id.au; spf=pass smtp.mailfrom=hows.id.au; arc=none smtp.client-ip=125.63.26.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hows.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hows.id.au
Received: by mail.hows.id.au (Postfix, from userid 113)
	id 4D7CE22F1B; Wed, 26 Mar 2025 06:04:31 +1100 (AEDT)
X-Spam-Level: 
Received: from smtpclient.apple (unknown [192.168.0.125])
	by mail.hows.id.au (Postfix) with ESMTPSA id CD821229F9;
	Wed, 26 Mar 2025 06:04:28 +1100 (AEDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: David Hows <david@hows.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Add support for CCD temperatures in AMD 1Ah CPUs model 0x40..0x4f
Date: Wed, 26 Mar 2025 06:04:17 +1100
Message-Id: <AB8136A4-472C-47E4-A783-3C1CBD67D869@hows.id.au>
References: <78352732-6494-4c29-a79b-879a8898bac5@roeck-us.net>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jean Delvare <jdelvare@suse.com>,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <78352732-6494-4c29-a79b-879a8898bac5@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
X-Mailer: iPhone Mail (22D82)

Thank you.=20

Should i make changes and re-submit?

> On 25 Mar 2025, at 11:46=E2=80=AFpm, Guenter Roeck <linux@roeck-us.net> wr=
ote:
>=20
> =EF=BB=BFHi,
>=20
>> On 3/25/25 04:14, David Hows wrote:
>> ---
>=20
> The subject should start with "hwmon: (k10temp)". Also, it should really s=
ay
> something like "Add support for Zen5 Ryzen Desktop" or similar to better
> describe what it actually does.
>=20
> Every patch needs a description. Please see
> Documentation/process/submitting-patches.rst for guidance.
>=20
> Thanks,
> Guenter
>=20
>>  drivers/hwmon/k10temp.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>> index d0b4cc9a5011..cc2ad7a324f9 100644
>> --- a/drivers/hwmon/k10temp.c
>> +++ b/drivers/hwmon/k10temp.c
>> @@ -502,6 +502,13 @@ static int k10temp_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>>              k10temp_get_ccd_support(data, 12);
>>              break;
>>          }
>> +    } else if (boot_cpu_data.x86 =3D=3D 0x1a) {
>> +        switch (boot_cpu_data.x86_model) {
>> +        case 0x40 ... 0x4f:    /* Zen5 Ryzen Desktop*/
>> +            data->ccd_offset =3D 0x308;
>> +            k10temp_get_ccd_support(data, 8);
>> +            break;
>> +        }
>>      }
>>        for (i =3D 0; i < ARRAY_SIZE(tctl_offset_table); i++) {

