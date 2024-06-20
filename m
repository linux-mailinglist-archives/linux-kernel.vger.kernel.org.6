Return-Path: <linux-kernel+bounces-221967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B2E90FB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE80283072
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C11F18EB1;
	Thu, 20 Jun 2024 02:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=webcom.xion.oxcs.net header.i=@webcom.xion.oxcs.net header.b="VhlIIQWR"
Received: from nmtao201.oxsus-vadesecure.net (mta-231a.oxsus-vadesecure.net [15.204.3.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35EB17545
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=15.204.3.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718849461; cv=pass; b=OgX4AmvtNdgNzM2PYhBTe10CKmT83a33XovZ28nI1N1rMUqa7JSe+z02jXxdZNZar23yujejxMdC0YrCMU11gQYv2E+fgyPdw4z9b2RfalAUSbbCLjqGo1uSfslouQA/cDODksULOHvJvJi7ct58EwD+OT4DIzlHZ8vUv+ge8YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718849461; c=relaxed/simple;
	bh=BwtQiDMz9MFosvt47NC6Zsj4YvYLmQ9irMHS5OWjg2o=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KZU9jNJBTyhtl6sC+KT5BZQZu9yalNZYXMUmZa8n6mNy6Y5LGGuuCjc4xkcNJQninXA8l7CtLpIFo7kHjSvNyq6qQSLvwiUPYvxGGDyOPsoQdorFJ83Q/BEAk1oebLHEB3o1cJYIzEXQQc/zcoXaCaapst/AkfoUugQ3lD7gfy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=theviteks.com; spf=pass smtp.mailfrom=theviteks.com; dkim=pass (2048-bit key) header.d=webcom.xion.oxcs.net header.i=@webcom.xion.oxcs.net header.b=VhlIIQWR; arc=pass smtp.client-ip=15.204.3.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=theviteks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theviteks.com
Authentication-Results: oxsus-vadesecure.net;
 auth=pass smtp.auth=4@96739 smtp.mailfrom=clark@theviteks.com;
ARC-Seal: i=1; a=rsa-sha256; d=oxsus-vadesecure.net; s=arc-202309-rsa2048; t=1718849152; cv=none; b=FWgllaasMKSWP0zSz5gaPyHUwHr381JJR2JqQNzObkP+fQJJGIt59DmmA9P2jqRdxeFrT1j9QfVRNj4WaTpDEZSN9vnrLYc1EERmFU94/oug2RQ5HN7+FFX0WE2VE0MKOiLwgdBG2+J5ty7BvU4PIO6eIt26nTnU7Qa6R+QfGJLbiB93rmPysKul7VTzH8pCmXSilJQyDHLle4V9fZvvX/qne7y2hDqPkO7r7ZbDE031StBB1YnWOYY5q/OvHp7Cg0SGyf2cnlK854CULqCu40nrT6//Bx4ervdZNYJkmOLAOmB11CBQ2Oo3bSZWuIr2r2l+T6N4leBlr6NGFWybfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=oxsus-vadesecure.net; s=arc-202309-rsa2048; t=1718849152; c=relaxed/relaxed; h=from:reply-to:subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:list-subscribe:list-post:list-owner:list-archive; bh=/Bk+6rI9rVNbWpxqhHJviakAx6tPN3LLPYUnnykhthI=; b=b4mhixz1Zg9Ghq4bfZpIdpzEx/TzJTRa2HChffn33hwM7EpfEOUBWNStsan/andsNxw0ryyFIGjfPwryFgb3GJEEMMR0phgOHsN13wp7Y13LwQVhMteP1UNK68unF2LS+OERLaw5P4hy6YFLEjjsDPDPwJ+au32M+TvELg8jzlHmNlnMe681UGHQBX5Apv/A0SxWU31s6AoQZyghqEQeDSO/ai/V5i0cCNQl/KUty/CwMhrejq9TcAuoE/xKCPYEtOXenkibg6h34SOPoWbYtVGuNQmgQ+FnkQA6X3pGk2nN81FSOCzl104H/0oxcfoa3GusTYjK3uap5HIsC63B2w==
ARC-Authentication-Results: i=1;
DKIM-Signature: v=1; a=rsa-sha256; bh=/Bk+6rI9rVNbWpxqhHJviakAx6tPN3LLPYUnny
 khthI=; c=relaxed/relaxed; d=webcom.xion.oxcs.net; h=from:reply-to:
 subject:date:to:cc:resent-date:resent-from:resent-to:resent-cc:
 in-reply-to:references:list-id:list-help:list-unsubscribe:
 list-unsubscribe-post:list-subscribe:list-post:list-owner:list-archive;
 q=dns/txt; s=mail1; t=1718849152; x=1719453952; b=VhlIIQWR+/8gDvru2UO/3
 gvp5TT/MyFHPmbXKLCorGSF6XO7hxCM02mLxNzdGyTzPz06B3A00m8Ywm0sP8jIDPgn0dEw
 eJl2yuAP1r2zos8galO39hC2//wKTKQKJIEd3yCshKyNBntKsQ88y9WdHTHXz4BDkcPFC0d
 2cKD8CSaiUWvwIpYKjF/scNP+4JPpLoy92EFhOc5SdA/M085XweOGVJguZv6lCednSspvJ2
 7/zQO7XPKWcgv3P5IPcCdnsqgEAK+USYY9CXM8SYs017RMPVlfUE3jKUcEBKohcuERTl6QN
 1nNhnaRlXcZvHoHhKo/SU5VOdARzTdDwuiKaw==
Received: from proxy-10.proxy.cloudus.ewr.xion.oxcs.net ([50.53.0.108])
 by oxsus2nmtao01p.internal.vadesecure.com with ngmta
 id 086a251b-17da94326080934e; Thu, 20 Jun 2024 02:05:52 +0000
Message-ID: <14bade04-0d93-405c-8637-14e39defb3a8@theviteks.com>
Date: Wed, 19 Jun 2024 19:05:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: Clark Vitek <clark@theviteks.com>
Subject: IwlWiFi: Intel so firmware issue
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

FTM initiator appears to be functional up v79,

example working ucode (lshw): firmware=79.27f1c37b.0 so-a0-gf-a0-79.uc

Firmware v81 and above give not supported response to iw dev measurement 
command.

example not working ucode (lshw): firmware=81.31fc9ae6.0 so-a0-gf-a0-81.uc

testing with kernel 6.5.0-41-generic currently, have also backported and 
tested in 6.2 kernel and determined it is firmware only dependency.

To replicate just change firmware between v79 to v81 and higher in 
/lib/firmware and remove/reload iwlwifi. Example sequence as follows:

**** Working Example v79 ****

$ cat conf80
50:E4:E0:E0:D8:30 bw=80 cf=5600 cf1=5610 lci ftms_per_burst=8

$ sudo iw dev wlp0s20f3 measurement ftm_request conf80
wdev 0x1 (phy #0): Peer measurements (cookie 4):
   Peer 50:e4:e0:e0:d8:30: status=0 (SUCCESS) @833087291004 tsf=0
     FTM
       BURST_INDEX: 0
       NUM_BURSTS_EXP: 0
       BURST_DURATION: 0
       FTMS_PER_BURST: 0
       RSSI_AVG: 4294967249
       RSSI_SPREAD: 0
       RTT_AVG: 88982
       RTT_VARIANCE: 1763414
       RTT_SPREAD: 3523
       LCI: 04 00 08 00 10 00 00 00 00 00 00 00 00 00 00 00
       LCI: 00 00 00 00 40 04 06 00 00 00 00 00 00 06 01 01

wdev 0x1 (phy #0): peer measurement complete

****END Working Example v79****

****Not Working Example v89****

$ sudo iw dev wlp0s20f3 measurement ftm_request conf80
command failed: Operation not supported (-95)

**** END Not Working Example v89 ****

Full Details of the Device (lspci), identical output for both above 
examples in both lspci, lsmod, and lshw. Only difference is latest 
firmware placed in /lib/firmware and remove/load of iwlwifi

$ sudo lspci -vvvvv
0000:00:14.3 Network controller: Intel Corporation Alder Lake-P PCH CNVi 
WiFi (rev 01)
     Subsystem: Rivet Networks Dual Band Wi-Fi 6E(802.11ax) AX1675i 
160MHz 2x2 [Garfield Peak]
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 16
     IOMMU group: 11
     Region 0: Memory at 603c2b4000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [c8] Power Management version 3
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, 
MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag- RBE- FLReset+
         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FLReset-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
         DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
              10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- 
EETLPPrefix-
              EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
              FRS-
              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
         DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis- LTR+ 
OBFF Disabled,
              AtomicOpsCtl: ReqEn-
     Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
         Vector table: BAR=0 offset=00002000
         PBA: BAR=0 offset=00003000
     Capabilities: [100 v1] Latency Tolerance Reporting
         Max snoop latency: 0ns
         Max no snoop latency: 0ns
     Capabilities: [164 v1] Vendor Specific Information: ID=0010 Rev=0 
Len=014 <?>
     Kernel driver in use: iwlwifi
     Kernel modules: iwlwifi

thank you for any direction, suggestions, or assistance. I am an end 
user/test enthusiast of linux wireless on different devices. FTM to 
infrastructure responders (Access Points) with Android devices works 
very well in my test setup including range and LCI. I would love to get 
this functionality in mainline linux kernel working reliably.

thanks,

Clark






