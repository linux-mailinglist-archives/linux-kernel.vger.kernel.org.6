Return-Path: <linux-kernel+bounces-250350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB7592F6D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DA01F22B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D9E142631;
	Fri, 12 Jul 2024 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="D6UzQg9P"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF82E3E5;
	Fri, 12 Jul 2024 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720772472; cv=none; b=pbHbDJZWCFcsfTVhO9zo3wf1T/ahDYlj+xnwQEVyBBHvc4W3nSOwoqw2+RRI9D25qZf4i6HCU/egNxubvjxbFqb3ck9lGphpgdz6lCa2Er4k/HJpsg/0gTh6d762kD2oIRf32X8ydMX183Oy3cPblfFEgL1ygO8tSIS99ApoH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720772472; c=relaxed/simple;
	bh=lcIxnxTVnl7eemhsDeBtjmieMiTqljeGdfc5S4iHFWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NuG2VTfiw7qNw6bgMWvauFpW24ECTBvlG5Eg6umL1l0k5wGTYVuBBgcbBlyokL+/3IrychFj2DJ4JWalLlA1JCYHZ81GEppprZvG1WWfS2fkW1TW7Zaq5UC7/bzyO1/Xm4Cx6wDTnPWGYCjqG4w4UDQTXQ8TPNkHoWydFJyF4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=D6UzQg9P; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=lcIxnxTVnl7eemhsDeBtjmieMiTqljeGdfc5S4iHFWY=; b=D6UzQg9PXsMWYd67Vt5J9PuK0P
	1xQqh0XjxrgQYSaLeHw1dXhozg6f51dU3KeMOV/HzXN+rZhUlCpwah3Lx/MyZom2RsQY+eI6NLECY
	4vi2c9G7q+TbVu2ofATbYF1nhYnhnAhsUhy7PIBGjDeGx7VIHg6up+cINV1dOESIeoD55mOoRmeb+
	KVpC+9Bjzv0/b4UUSCSJFpVSIABLnnNYaQ1hOEUiElTSIKCH+P3S35GTvWVjC8yD53emrZBPqMkGW
	mSperykogVaW/4N8l3pYPrpSi1FMBjB46zbpRjGPnAGioY6BgXLUttvNCxgTeQKdR7Y2wYbE2LV/z
	AGINDtmQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sSBWT-0001oA-Qt; Fri, 12 Jul 2024 10:20:57 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sSBWS-000Q04-2s;
	Fri, 12 Jul 2024 10:20:56 +0200
From: Esben Haabendal <esben@geanix.com>
To: Erez <erezgeva2@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Jaime Liao <jaimeliao@mxic.com.tw>,
  leoyu@mxic.com.tw,  Alvin Zhou <alvinzhou@mxic.com.tw>,  Julien Su
 <juliensu@mxic.com.tw>,  Erez Geva <erezgeva@nwtime.org>,
  linux-mtd@lists.infradead.org,  Pratyush Yadav <pratyush@kernel.org>,
  linux-kernel@vger.kernel.org,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  devicetree@vger.kernel.org,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
In-Reply-To: <CANeKEMNtXb4ZV7kcLbHY+Mti6dPV9UZ2wTyUq5z0qtmtNNqSVA@mail.gmail.com>
	(Erez's message of "Fri, 12 Jul 2024 00:09:01 +0200")
References: <20240629103914.161530-1-erezgeva@nwtime.org>
	<20240629103914.161530-4-erezgeva@nwtime.org>
	<1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org>
	<CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
	<CANeKEMO42rJt5Ob4_HDcZ3eEMvuMOPvRaFaLwL8SA65NtxSV7A@mail.gmail.com>
	<1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org>
	<CANeKEMMe-Onpn7xWQHgWz1Ps_uQPEMa7HrKA00HpoKjG+DCJNQ@mail.gmail.com>
	<3bafcbea-6aa5-43ca-9d12-3916be3fe03d@linaro.org>
	<CANeKEMM02-Jvb8Pd0fZJFnRg-hsAW+hckYWm11tZZXNMPSPJ=w@mail.gmail.com>
	<9b45cc73-2251-4085-af95-7ccd00dd6d3b@linaro.org>
	<CANeKEMP+mRefYZNb+TuBmOD7dC6=7Rg7D1EcfnjJoiaeaV28SQ@mail.gmail.com>
	<875xtd48ps.fsf@geanix.com>
	<CANeKEMNJ3_ET5pQo2wg7_GSLX+vE+dqW-CV=v2DnG10xcgSdzQ@mail.gmail.com>
	<D2MZ405LVTN8.3LTVN3KTUD6A3@kernel.org>
	<CANeKEMNtXb4ZV7kcLbHY+Mti6dPV9UZ2wTyUq5z0qtmtNNqSVA@mail.gmail.com>
Date: Fri, 12 Jul 2024 10:20:56 +0200
Message-ID: <878qy7vx5j.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

Erez <erezgeva2@gmail.com> writes:

> On Thu, 11 Jul 2024 at 21:57, Michael Walle <mwalle@kernel.org> wrote:
>> On Thu Jul 11, 2024 at 8:57 PM CEST, Erez wrote:
>> > Yes, I think we should.
>> >
>> > Reading the specification provided publicly by Macronix.
>> > For all the JEDEC IDs with the no SFDP flag in drivers/mtd/spi-nor/macronix.c
>> > All of them have a new version or a new chip with the same JEDEC ID
>> > that supports SFDP.
>> > There are 2 chips that Macronix does not provide spec. in public.
>> > I can ask Macronix technical support on these 2 chips.
>>
>> We don't add flashes we cannot test.
>
> I did not suggest adding anything new.
> I refer to the list of chips we already have in drivers/mtd/spi-nor/macronix.c
> I presume someone tested them before adding them to the list in the past.
> And probably the old chip did not have the SFDP table back then.
>
> What I checked with the chip specifications is that all Macronix chips
> since 2010 have SFDP.
>
> The situation today is that all Macronix chips that are NOT in the
> Macronix table work based on the SFDP table.
> But new chips that use a JEDEC found in the Macronix table, skip the
> SFDP table and use the setting of the old chip.

Not entirely true.

Those that entries in the Macronix table that has SPI_NOR_DUAL_READ
and/or SPI_NOR_QUAD_READ in no_sfdp_flags is caught by
the magic flags matching in spi_nor_init_params_deprecated() and will
have spi_nor_parse_sfdp() called from
spi_nor_sfdp_init_params_deprecated(). So flashes reusing ID for these
will have the SFDP tables parsed.

The rest of the entries in the Macronix table is not so lucky. When a
replacement chip (with the same ID) is used, it will not be configured
with the values found in SFDP table.

> So I suggest we read the SFDP table for all Macronix chips.

Based on their strategy of re-using flash ID, I think this is a sane
approach.

> Old Macronix chips that do not have SFDP will use the setting from the
> Macronix table. i.e backward compatible.
> While new chips which do have an SFDP table will work with the new
> setting we find in the table.

Yes, if we apply the new SPI_NOR_TRY_SFDP flag to the matching table
entries.

> Of course, we might have issues in parsing the SFDP table itself.
> So we fix them as developers report and send chip ID and part number
> with the SFDP table content.
> I do not see the point of "hiding" with the old setting.
> Anyhow, as we do not like the IDs table and keep it for backward-compatible,
> so it only makes sense we should use the SFDP table as much as possible.
>
> My check was to ensure Tudor that all Macronix chips have SFDP whether
> they are in the IDs table or not and we are not wasting a no-op on a
> chip which can not have an SFDP table.
>
> All I suggest is we add the new 'SPI_NOR_TRY_SFDP' flag, to all
> Macronix chips.. Which will try to read the SFDP to any Macronix chip.

Makes sense. But obviously comes with a risk as we won't be able to
test all chips for regression when doing that.

/Esben

