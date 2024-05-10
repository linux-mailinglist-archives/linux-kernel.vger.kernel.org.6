Return-Path: <linux-kernel+bounces-175415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D1A8C1F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FE1283094
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962E015EFBF;
	Fri, 10 May 2024 07:52:16 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13A12AAE5;
	Fri, 10 May 2024 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327536; cv=none; b=QDCzjGm1K9tp4NnpwnW3w3CM0FFpFpjgx4HDogonbAV9EJuAPGUPJ+vxzRfbPMm5MhCd8EcU4DqmZiQSSgvXOjc6udX0WIEFWUNLIr68HwWYMENh30Ui8OA8P3qREhB+MsA6kU9umc7D6Z3Iu1Rbb53j2KexSj+y+JRE9qJCb4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327536; c=relaxed/simple;
	bh=bUEgRZl42yYM5CkRO8kZ6mVRnWV+1pva2VNMuUhhmQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UF4GaqYI0K+K7bkjAcMWOyBEotCAQN9Uky1K0nawCFJnpQJfPV1LYdQQA6GpOnmvZ8EHa38mUfSSzCdKj1A89le0rWfhwxMG3Jt0A+Pulb1J+WsIblJngvic8peMFtgFWBE/2MSRQww0KW2I+BSIaSdqdp8ID9Pk6QxZAERVDhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4VbLSW1sm4z1qsNr;
	Fri, 10 May 2024 09:42:19 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4VbLSW0D2Cz1qqlW;
	Fri, 10 May 2024 09:42:19 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id wa_-KpXdVV1E; Fri, 10 May 2024 09:42:17 +0200 (CEST)
X-Auth-Info: 1/I9WN7qMx6nrIhu6olAZ98FEHY/laUt2/c9CUhT5UGbjjWI2SaIBfGedJ1Wq8gx
Received: from tiger.home (aftr-82-135-83-234.dynamic.mnet-online.de [82.135.83.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri, 10 May 2024 09:42:17 +0200 (CEST)
Received: by tiger.home (Postfix, from userid 1000)
	id 8CAA528726F; Fri, 10 May 2024 09:42:17 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: devicetree@vger.kernel.org,  linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Emil Renner Berthing <kernel@esmil.dk>,
  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Paul Walmsley
 <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Albert
 Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 0/2] riscv: dts: starfive: Enable Bluetooth on JH7100
 boards
In-Reply-To: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
	(Emil Renner Berthing's message of "Wed, 8 May 2024 13:15:53 +0200")
References: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
X-Yow: Yow!
Date: Fri, 10 May 2024 09:42:17 +0200
Message-ID: <87wmo2nmee.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mai 08 2024, Emil Renner Berthing wrote:

> This series enables the in-kernel Bluetooth driver to work with the
> Broadcom Wifi/Bluetooth module on the BeagleV Starlight and StarFive
> VisionFive V1 boards.

That does not work for me:

[  +0.369276] Bluetooth: hci0: command 0x1001 tx timeout
[  +0.025545] Bluetooth: hci0: BCM: Reading local version info failed (-110)

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

