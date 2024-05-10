Return-Path: <linux-kernel+bounces-175538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432AE8C210A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BB2280F39
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A681635A9;
	Fri, 10 May 2024 09:35:44 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F11581E3;
	Fri, 10 May 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333744; cv=none; b=bUPLjJKhxtQF1UNAksGhqz1T+VH2SZJWMSlDWN+AmpJ68kyYK+aw6dm0Z14rmKmOPNnEoi55oT1VV7F+vaTQgQyDDVolWPSGApvQBGDclHCxYvDDQdKvbU1eATaqLVHXtkzCnthLSCQq1rOX2DPXl8Kq1RwuVBVVhxhQIFcVsYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333744; c=relaxed/simple;
	bh=8wqtVcYbMxM5bvRCZaV7DkP2aZi8tfDZnLSnQu2l4SM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LFC4uFZn77hZhoXhEswcPwfHZfOztpZiRWudk5NCRTl47FGt4j2vUR+/vpRn0vv9QpcLB8bVD6vPVyGmkORLt6JVvck6mKQK6+0xes38RCbPMu4BilIAlgmdiP+hNF+0paimeuUsilv+axjHHe0ePE/BIKTckv6v0sp/PH+hiyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4VbNzD2CTxz1qsPQ;
	Fri, 10 May 2024 11:35:36 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4VbNzD0J3Sz1qqlW;
	Fri, 10 May 2024 11:35:36 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id W7SDgKtSIU0X; Fri, 10 May 2024 11:35:34 +0200 (CEST)
X-Auth-Info: WpkhOM/yLbHyYToGgYckJ3TxBRsGdMRWU+bfIT1zsPao++vXAB/KuQGIznDFs2yE
Received: from igel.home (aftr-82-135-83-249.dynamic.mnet-online.de [82.135.83.249])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri, 10 May 2024 11:35:34 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 5C89D2C1A3A; Fri, 10 May 2024 11:35:34 +0200 (CEST)
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
In-Reply-To: <CAJM55Z-F6N6ua5LoqyMFogDtLp=FaRPoDv4osXFDMjR1b8r9nw@mail.gmail.com>
	(Emil Renner Berthing's message of "Fri, 10 May 2024 04:02:58 -0500")
References: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
	<87wmo2nmee.fsf@linux-m68k.org>
	<CAJM55Z-F6N6ua5LoqyMFogDtLp=FaRPoDv4osXFDMjR1b8r9nw@mail.gmail.com>
X-Yow: Are you still SEXUALLY ACTIVE?  Did you BRING th' REINFORCEMENTS?
Date: Fri, 10 May 2024 11:35:34 +0200
Message-ID: <87zfsy102h.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mai 10 2024, Emil Renner Berthing wrote:

> You don't include any information useful for debugging this, but if it get's
> far enough to load the firmware could you at least make sure you run the
> version below, so that's at least the same.
>
> https://github.com/esmil/linux/blob/visionfive/firmware/brcm/BCM43430A1.hcd

That didn't change anything (and there are no messages related to
firmware loading from hci_uart).

[  +0.879623] Bluetooth: Core ver 2.22
[  +0.004843] NET: Registered PF_BLUETOOTH protocol family
[  +0.008787] Bluetooth: HCI device and connection manager initialized
[  +0.021944] Bluetooth: HCI socket layer initialized
[  +0.008488] Bluetooth: L2CAP socket layer initialized
[  +0.006333] Bluetooth: SCO socket layer initialized
[  +0.097478] Bluetooth: HCI UART driver ver 2.3
[  +0.007943] Bluetooth: HCI UART protocol H4 registered
[  +0.006066] Bluetooth: HCI UART protocol BCSP registered
[  +0.006962] Bluetooth: HCI UART protocol LL registered
[  +0.000015] Bluetooth: HCI UART protocol ATH3K registered
[  +0.000084] Bluetooth: HCI UART protocol Three-wire (H5) registered
[  +0.000247] Bluetooth: HCI UART protocol Intel registered
[  +0.000455] Bluetooth: HCI UART protocol Broadcom registered
[  +0.000084] Bluetooth: HCI UART protocol QCA registered
[  +0.000008] Bluetooth: HCI UART protocol AG6XX registered
[  +0.000057] Bluetooth: HCI UART protocol Marvell registered
[  +0.051854] hci_uart_bcm serial0-0: supply vbat not found, using dummy regulator
[  +0.000387] hci_uart_bcm serial0-0: supply vddio not found, using dummy regulator
[  +0.094658] hci_uart_bcm serial0-0: No reset resource, using default baud rate
[  +0.990297] Bluetooth: hci0: command 0x1001 tx timeout
[  +0.022893] Bluetooth: hci0: BCM: Reading local version info failed (-110)
[  +3.306159] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  +0.013336] Bluetooth: BNEP filters: protocol multicast
[  +0.124262] Bluetooth: BNEP socket layer initialized

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

