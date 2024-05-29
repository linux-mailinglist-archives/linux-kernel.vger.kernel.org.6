Return-Path: <linux-kernel+bounces-194390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784478D3B77
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1832D1F25B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF86181CEF;
	Wed, 29 May 2024 15:53:46 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5121A19;
	Wed, 29 May 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998025; cv=none; b=iCG8wukJPOv+hLK4ZaKFSXZs+ATo5e2OiBCIdoAxMCpdGwiV5kHnmkK+HPUFRqJqqiT1vCQFW3agAAD55aSv8oygPFjPtytNpfO3F8sX3Bq4y0uw9xszP6AXZSn89LKZlmPa0voQWbPSwt6zqf3m1OCuD2/mtgct4Rgh+vtnPs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998025; c=relaxed/simple;
	bh=T1IyKKEBsRGAh8XXpBq024oPYQ8HRlkDsRSyUmnmfew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QRXPFcR9tlka9hPvHgxvJGvBU9gb+xY7QDTGpmsTWTb/1+L1T1lVxfqB62vb0/JIlgVhsgVA1QX+z3ZiUngR9g4RPRgEpMHIqQ30orLq4ETGIfCjIXh4AMPqn7/LmxaKW0TWnkPcQxWExhmMiL0wL5w5/Xn0deyimcxqUYFgbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4VqDSW0FVcz1qsPH;
	Wed, 29 May 2024 17:53:30 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4VqDSV6Gwqz1qqlc;
	Wed, 29 May 2024 17:53:30 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id KX2dlM8WheZz; Wed, 29 May 2024 17:53:30 +0200 (CEST)
X-Auth-Info: SJeIiO1rcsLcTt+IL1oruYTZ/1F0tXYKZQaoRKYEVhcZHeLOHoHmD6I7lXsiUoCl
Received: from igel.home (aftr-82-135-83-252.dynamic.mnet-online.de [82.135.83.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed, 29 May 2024 17:53:30 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id B9ED42C02CE; Wed, 29 May 2024 17:53:29 +0200 (CEST)
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
In-Reply-To: <CAJM55Z8Ce1i==pSUj0z4T2y71g713-675mAYQP5qSN5Euz=rLQ@mail.gmail.com>
	(Emil Renner Berthing's message of "Wed, 29 May 2024 04:49:03 -0400")
References: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
	<87wmo2nmee.fsf@linux-m68k.org>
	<CAJM55Z-F6N6ua5LoqyMFogDtLp=FaRPoDv4osXFDMjR1b8r9nw@mail.gmail.com>
	<87zfsy102h.fsf@igel.home>
	<CAJM55Z8Ce1i==pSUj0z4T2y71g713-675mAYQP5qSN5Euz=rLQ@mail.gmail.com>
X-Yow: ..  I think I'd better go back to my DESK and toy with
 a few common MISAPPREHENSIONS...
Date: Wed, 29 May 2024 17:53:29 +0200
Message-ID: <878qzsbona.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mai 29 2024, Emil Renner Berthing wrote:

> Oddly it doesn't work on my Starlight board either. I was thinking the firmware
> might set up pinconf differently, but comparing
>
>   /sys/kernel/debug/pinctrl/11910000.pinctrl-pinctrl-starfive/pinconf-pins
>
> on the two boards shows no differences. I've also not been able to spot any
> differences in how the AP6236 module is connected in the schematics for the two
> boards, so not really sure how to proceed.

I see no difference between Starlight and Visionfive boards, both fail
the same way.

I also see that sometimes the firmware greeting from brcmfmac occurs
_after_ the timeout error from hci0:

# journalctl -b -2 | grep -e brcmf_c_preinit_dcmds -e hci0:
May 16 12:01:54 beaglev kernel: Bluetooth: hci0: command 0x1001 tx timeout
May 16 12:01:54 beaglev kernel: Bluetooth: hci0: BCM: Reading local version info failed (-110)
May 16 12:01:54 beaglev kernel: brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/1 wl0: Mar 30 2021 01:12:21 version 7.45.98.118 (7d96287 CY) FWID 01-32059766

Is this perhaps a race with the firmware loading?

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

