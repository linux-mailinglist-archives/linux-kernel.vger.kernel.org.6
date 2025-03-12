Return-Path: <linux-kernel+bounces-557101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E11A5D3B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73EA7AA5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512DB2D613;
	Wed, 12 Mar 2025 00:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="GPy0Rw7o"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87659182D7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741739187; cv=none; b=tHChZ5kfNFVeV7bd1t5A7OdlHHENRJ6FLMvKQjfbiZFGa9Uqwej6sKcUCtzMOYlYRIaDWVaQx455XGzIAXaOpf8RHjVAOV9v5aqfXRGAGDCAS/aXLaqTN3mItDkm07WUTgHaX0jaraohezWYTi16LUTFXH7M+CvN0ekEnD2uY80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741739187; c=relaxed/simple;
	bh=WjkxhI5adNGQowlOz1q0mlmIhVMAlcL3LLTNzdYhYV4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gY7NRYD5pZmN7754hclnJudS0Z6z0F1rxff7HlWI36++2SHLQ/LvdhDEap0KXDEnjR7OuHk0cZ8kCj7m+XZbL8cMULbok/mqi8QvuDPHdUabKIsVGVPkU8HilNklToB9hnENQqz+CREzk5vPQ0kq5g9vrPns4TC6r7SnheQ+mKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=GPy0Rw7o; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741739173; x=1742343973; i=spasswolf@web.de;
	bh=WWyJyx9sLN7Vyi1nj03VxfT5BDZRko4YCT7ijwJedB8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GPy0Rw7oKibtHaOeEZ5wdO+zwIzGK+hwuJJMFMT0mn7hXulbiUBrjeO3NkPb8ZeV
	 ksSWkbufYo5XQdvyL2LUSE6oJ9AzAe0KO8S+wWpP7A4QfqQdHK1ef89Bqih3rlcXy
	 8xSsPFxl0/2YOskMlog09BNC8U1URd9MLoNykcWkdSbZCSbZ7LufNjpI27MvkqRzc
	 Q0vkb2E8H8c95ZpQbRY1t3lp+yci77NlKUzzvRAi8T2oBfQRXflWldwkp49CPgqGM
	 7WwmAHsHUReaqFSWoL8cNh2ZBtvPGlTNErQYcbQhUh7XNkWxkul5BNcrFUlfxkPpE
	 2z68F7wfwMHHnZ2GlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKuOP-1te4W93b7V-00I1EL; Wed, 12
 Mar 2025 01:26:12 +0100
Message-ID: <cc1c59bba5b4e8b8afef14690f6c974e8bd814a3.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	spasswolf@web.de
Date: Wed, 12 Mar 2025 01:26:12 +0100
In-Reply-To: <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
References: <20250310112206.4168-1-spasswolf@web.de>
				 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
				 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
				 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
				 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
				 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
		 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.55.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wtc3tzP5BDqDtHhu6O0Z0WUr2D0tazLaTYizPWzZPFOrlpNl1L7
 E2nj3jO/HJZ75f+x/8+ZcuFBoDo8RFuv6uoyCHObtDXQrz5wviT6PXYRpsB7X4uzM4QQNmG
 6CwthjDrhN2Im/aDpa8VaADcxnZWeCMCLVKkqQ6OQzhGNoZ8qn47OzxvfN+hzFXTQyuvKNY
 CWc/WvyeEdWLGitUrmY2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X3aJwAJY6RQ=;WAIdkjv6Jy6kuux693W6disJL7r
 w0cAhdZdMmXz/k3Q9yfXBRSgDApbcbsFbHDC80VMmeBj1PyV9HsWm+5DeNUlE9A1w7ktAj5+Z
 Lh4ZNm4lKaFOGQUQg0egDHnbIacdi8ZgbqEo+LT6MDk6kZMn55oucrEgWXk+8bPO8luICOfqi
 pkO+0PXL/oXjPKKNlp4MsZ3oKqh1XgNrb4IrwJ8VGu3hQa7DVXXEUgvlqTAPkmalGaN6FjsqV
 l7Q9s2pvW/npE9gNqV5fVMqlMAhxZJClI+DqYj9lH/tL4gc8O8G6Ea5TJXw/HnpyoZ4kxoq+A
 dVy/6yYoGFD31m0KEoWcSH+7gN8PvKzUrus5gv0akZmSMWLLG9Xlx53srqzaPVHuOMcPwJyb7
 f17qDqatrO7SjsOIKE2FTCBeXn35vO+QzUsZUI/YvsNSw6eUGdy2UFGIIbxNhlxQqIe+tt21N
 2kdXDwgpLzTTASRvAsjtlVkjMZ1yujs7pl2su8dq2nJwMJkDgbYLiJs8mxSAqGI+DnRMq2fBC
 GvlBRdtKgPAGLjyRS4e8eGPX550wTyIuPhAAlfOCfcqSLatkM3K8XJa/swkUQ9aq0OQsmoLH4
 rm8k9ooyf5FUGOtqR47ZxjlljPn7HLsUiGmmk/Y25BHzKmYtvfVW0mhvjK3WzZ/DpbU818t6W
 pojtEo+ddB29yQF+OIae39kw77Njb58lMYiALkrqNP1A/kkJ3yYhGca+OuIJ39ePXJAoyKdt0
 kEunXzafL+fFpTcEda4CUL0458Catg34bXxYPgmjFaanEsNmFOFV+rWKMLLiKnfRMfDgFNNfa
 pgIUX4t3l254loSBjdi+mnQ2UTxsS6/Got6nVt+WZa6idydJx9mSYdKIXpKd8W6wdmMoveeDU
 KBmDRU9aFk35CKkqAs0M/FxeJpU2QdzTvUSh+iQ9voK2pqd/RJGpHmfQXgsf4vqrA/uInWIl9
 0HHMqt0EtkgRwBlPnrZfkAv9c5mXAvlF8c5thFZ3UBeA2Ax7D1ShLl8l+wJ37JkEKvDSkzZNA
 nF/PPV+dQJ2CY+68kYZRW2dWEeS+A9Ceec/3xjNWIx2d77kRNy/ePzZjZ0ZB+YpJoKCWK0Hp/
 1rUuU+uGijUVgflnCCI1/UzkwTXZRXEDrRdfbJN0foptknKH+qORfmglpmO0setwVBISe6VxZ
 FVFw56tzyL0UGcyuXM7W3J3yhkPAhVIh8MT+3Hepdwih7RA2ul9/DhQ1mKR7PZI42UtCktve3
 MMUpGwNdrI1la+OFgk0mhtQ5FtB/qicCbD/QQSMUFCP8QrXzffRQ8q/afBYsK3jB1Ka0giOch
 /hSrdcQ6imFyngpXdu6vgqCJwU8u5pC/iM99nTiDtZgSScueFSN3ynoPGSLHFUlqM9uJZfcbY
 1Ks6P/xr7fKwmM+d6rkCHmeMsBcckkn5hyNoa9fYlciAs3MiLPIEoA/a0YUCFsZUjc3AFKuHl
 sgKE5p42TVVJUuF3uHV9ywmf91Mw=

The combination

CONFIG_RANDOMIZE_BASE=3Dy
# CONFIG_RANDOMIZE_MEMORY is not set
# CONFIG_PCI_P2PDMA is not set

also shows the laggy input when running stellaris

here's lspci -vvv in that case

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Roo=
t
Complex
 Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root Complex
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 IOMMU group: 0

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
 Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
 Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0
 Interrupt: pin A routed to IRQ 255
 Capabilities: [40] Secure device <?>
 Capabilities: [64] MSI: Enable- Count=3D1/4 Maskable- 64bit+
 Address: 0000000000000000 Data: 0000
 Capabilities: [74] HyperTransport: MSI Mapping Enable+ Fixed+

00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy =
Host
Bridge
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 IOMMU group: 1

00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bri=
dge
(prog-if 00 [Normal decode])
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin ? routed to IRQ 43
 IOMMU group: 2
 Bus: primary=3D00, secondary=3D01, subordinate=3D03, sec-latency=3D0
 I/O behind bridge: 1000-1fff [size=3D4K] [16-bit]
 Memory behind bridge: fca00000-fccfffff [size=3D3M] [32-bit]
 Prefetchable memory behind bridge: fc00000000-fe0fffffff [size=3D8448M] [=
32-bit]
 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort+ <SERR- <PERR-
 BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
 DevCap: MaxPayload 512 bytes, PhantFunc 0
 ExtTag+ RBE+ TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #1, Speed 8GT/s, Width x8, ASPM L1, Exit Latency L1 <64us
 ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
 LnkSta: Speed 8GT/s, Width x8
 TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt+
 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
 Slot #0, PowerLimit 75W; Interlock- NoCompl+
 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
 Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 Changed: MRL- PresDet- LinkState-
 RootCap: CRSVisible+
 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
 DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
 AtomicOpsCtl: ReqEn- EgressBlck-
 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers-=
 DRS-
 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
EqualizationPhase1+
 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
 Address: 00000000fee00000 Data: 0000
 Capabilities: [c0] Subsystem: Micro-Star International Co., Ltd. [MSI] De=
vice
1313
 Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [270 v1] Secondary PCI Express
 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 LaneErrStat: 0
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans+
 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans-
 Capabilities: [370 v1] L1 PM Substates
 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates=
+
 PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D150us
 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
 T_CommonMode=3D0us LTR1.2_Threshold=3D32768ns
 L1SubCtl2: T_PwrOn=3D10us
 Kernel driver in use: pcieport

00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy =
Host
Bridge
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 IOMMU group: 3

00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe=
 GPP
Bridge (prog-if 00 [Normal decode])
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin ? routed to IRQ 44
 IOMMU group: 4
 Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D0
 I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
 Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
 Prefetchable memory behind bridge: fe30300000-fe304fffff [size=3D2M] [32-=
bit]
 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
 BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
 DevCap: MaxPayload 512 bytes, PhantFunc 0
 ExtTag+ RBE+ TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 128 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #3, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
 ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
 LnkSta: Speed 5GT/s, Width x1
 TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
 Slot #0, PowerLimit 75W; Interlock- NoCompl+
 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
 Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 Changed: MRL- PresDet- LinkState+
 RootCap: CRSVisible+
 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
 DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
 AtomicOpsCtl: ReqEn- EgressBlck-
 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers-=
 DRS-
 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
EqualizationPhase1-
 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
 Address: 00000000fee00000 Data: 0000
 Capabilities: [c0] Subsystem: Micro-Star International Co., Ltd. [MSI] De=
vice
1313
 Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [270 v1] Secondary PCI Express
 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 LaneErrStat: 0
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans+
 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans-
 Capabilities: [370 v1] L1 PM Substates
 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates=
+
 PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D150us
 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
 T_CommonMode=3D10us LTR1.2_Threshold=3D166912ns
 L1SubCtl2: T_PwrOn=3D150us
 Kernel driver in use: pcieport

00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe=
 GPP
Bridge (prog-if 00 [Normal decode])
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin ? routed to IRQ 45
 IOMMU group: 5
 Bus: primary=3D00, secondary=3D05, subordinate=3D05, sec-latency=3D0
 I/O behind bridge: f000-ffff [size=3D4K] [16-bit]
 Memory behind bridge: fcf00000-fcffffff [size=3D1M] [32-bit]
 Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [dis=
abled]
[64-bit]
 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
 BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
 DevCap: MaxPayload 512 bytes, PhantFunc 0
 ExtTag+ RBE+ TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 128 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #4, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
 ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
 LnkSta: Speed 2.5GT/s, Width x1
 TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
 Slot #0, PowerLimit 75W; Interlock- NoCompl+
 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
 Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 Changed: MRL- PresDet- LinkState+
 RootCap: CRSVisible+
 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
 DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
 AtomicOpsCtl: ReqEn- EgressBlck-
 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers-=
 DRS-
 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
EqualizationPhase1-
 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
 Address: 00000000fee00000 Data: 0000
 Capabilities: [c0] Subsystem: Micro-Star International Co., Ltd. [MSI] De=
vice
1313
 Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [270 v1] Secondary PCI Express
 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 LaneErrStat: 0
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans+
 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans-
 Capabilities: [370 v1] L1 PM Substates
 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates=
+
 PortCommonModeRestoreTime=3D150us PortTPowerOnTime=3D150us
 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
 T_CommonMode=3D150us LTR1.2_Threshold=3D306176ns
 L1SubCtl2: T_PwrOn=3D150us
 Kernel driver in use: pcieport

00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe=
 GPP
Bridge (prog-if 00 [Normal decode])
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin ? routed to IRQ 46
 IOMMU group: 6
 Bus: primary=3D00, secondary=3D06, subordinate=3D06, sec-latency=3D0
 I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
 Memory behind bridge: fce00000-fcefffff [size=3D1M] [32-bit]
 Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [dis=
abled]
[64-bit]
 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
 BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
 DevCap: MaxPayload 512 bytes, PhantFunc 0
 ExtTag+ RBE+ TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 512 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit Latency L1 <64us
 ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
 LnkSta: Speed 8GT/s, Width x4
 TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
 Slot #0, PowerLimit 75W; Interlock- NoCompl+
 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
 Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 Changed: MRL- PresDet- LinkState+
 RootCap: CRSVisible+
 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
 DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd+
 AtomicOpsCtl: ReqEn- EgressBlck-
 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers-=
 DRS-
 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
EqualizationPhase1+
 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
 Address: 00000000fee00000 Data: 0000
 Capabilities: [c0] Subsystem: Micro-Star International Co., Ltd. [MSI] De=
vice
1313
 Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [270 v1] Secondary PCI Express
 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 LaneErrStat: 0
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans+
 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans-
 Capabilities: [370 v1] L1 PM Substates
 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates=
+
 PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D150us
 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
 T_CommonMode=3D10us LTR1.2_Threshold=3D236544ns
 L1SubCtl2: T_PwrOn=3D220us
 Kernel driver in use: pcieport

00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe=
 GPP
Bridge (prog-if 00 [Normal decode])
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin ? routed to IRQ 47
 IOMMU group: 7
 Bus: primary=3D00, secondary=3D07, subordinate=3D07, sec-latency=3D0
 I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
 Memory behind bridge: fcd00000-fcdfffff [size=3D1M] [32-bit]
 Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [dis=
abled]
[64-bit]
 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
 BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
 DevCap: MaxPayload 512 bytes, PhantFunc 0
 ExtTag+ RBE+ TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 128 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #1, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
 ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
 LnkSta: Speed 8GT/s, Width x4
 TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
 Slot #0, PowerLimit 75W; Interlock- NoCompl+
 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
 Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
 Changed: MRL- PresDet- LinkState+
 RootCap: CRSVisible+
 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
 DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
 AtomicOpsCtl: ReqEn- EgressBlck-
 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers-=
 DRS-
 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
EqualizationPhase1+
 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
 Address: 00000000fee00000 Data: 0000
 Capabilities: [c0] Subsystem: Micro-Star International Co., Ltd. [MSI] De=
vice
1313
 Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [270 v1] Secondary PCI Express
 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 LaneErrStat: 0
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans+
 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans-
 Capabilities: [370 v1] L1 PM Substates
 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates=
+
 PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D150us
 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
 T_CommonMode=3D10us LTR1.2_Threshold=3D166912ns
 L1SubCtl2: T_PwrOn=3D150us
 Kernel driver in use: pcieport

00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy =
Host
Bridge
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 IOMMU group: 8

00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCI=
e GPP
Bridge to Bus (prog-if 00 [Normal decode])
 Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Br=
idge
to Bus
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin A routed to IRQ 48
 IOMMU group: 9
 Bus: primary=3D00, secondary=3D08, subordinate=3D08, sec-latency=3D0
 I/O behind bridge: e000-efff [size=3D4K] [16-bit]
 Memory behind bridge: fc500000-fc9fffff [size=3D5M] [32-bit]
 Prefetchable memory behind bridge: fe20000000-fe301fffff [size=3D258M] [3=
2-bit]
 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
 BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [58] Express (v2) Root Port (Slot-), IntMsgNum 0
 DevCap: MaxPayload 512 bytes, PhantFunc 0
 ExtTag+ RBE+ TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <6=
4ns,
L1 <1us
 ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
 LnkSta: Speed 8GT/s, Width x16
 TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
 RootCap: CRSVisible+
 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
 DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 4
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
 AtomicOpsCtl: ReqEn- EgressBlck-
 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers=
+ DRS-
 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
EqualizationPhase1+
 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
 Address: 00000000fee00000 Data: 0000
 Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir
Internal PCIe GPP Bridge to Bus
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [270 v1] Secondary PCI Express
 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 LaneErrStat: 0
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans+
 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans-
 Capabilities: [400 v1] Data Link Feature <?>
 Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
 Capabilities: [440 v1] Lane Margining at the Receiver
 PortCap: Uses Driver-
 PortSta: MargReady- MargSoftReady-
 Kernel driver in use: pcieport

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (re=
v 51)
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t-
<MAbort- >SERR- <PERR- INTx-
 IOMMU group: 10
 Kernel driver in use: piix4_smbus
 Kernel modules: i2c_piix4

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev=
 51)
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbor=
t-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0
 IOMMU group: 10

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 0
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 IOMMU group: 11

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 1
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 IOMMU group: 11

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 2
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 IOMMU group: 11

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 3
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 IOMMU group: 11
 Kernel driver in use: k10temp
 Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 4
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 IOMMU group: 11

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 5
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 IOMMU group: 11

00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 6
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 IOMMU group: 11

00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Cezanne Data Fabri=
c;
Function 7
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 IOMMU group: 11

01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Upst=
ream
Port of PCI Express Switch (rev c3) (prog-if 00 [Normal decode])
 Physical Slot: 0
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin A routed to IRQ 49
 IOMMU group: 12
 Region 0: Memory at fcc00000 (32-bit, non-prefetchable) [size=3D16K]
 Bus: primary=3D01, secondary=3D02, subordinate=3D03, sec-latency=3D0
 I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
 Memory behind bridge: fca00000-fcbfffff [size=3D2M] [32-bit]
 Prefetchable memory behind bridge: fc00000000-fe0fffffff [size=3D8448M] [=
32-bit]
 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
 BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [58] Express (v2) Upstream Port, IntMsgNum 0
 DevCap: MaxPayload 512 bytes, PhantFunc 0
 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 75W TEE-IO-
 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
 LnkCap: Port #1, Speed 16GT/s, Width x8, ASPM L1, Exit Latency L1 <64us
 ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM L1 Enabled; LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 8GT/s (downgraded), Width x8
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 4
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS-
 AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: EgressBlck-
 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers=
+ DRS-
 LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
EqualizationPhase1+
 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
 Address: 0000000000000000 Data: 0000
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [150 v2] Advanced Error Reporting
 UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
 ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrInt=
Err-
HeaderOF-
 CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrInt=
Err-
HeaderOF-
 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCC=
hkEn-
 MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 HeaderLog: 00000000 00000000 00000000 00000000
 Capabilities: [270 v1] Secondary PCI Express
 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 LaneErrStat: 0
 Capabilities: [320 v1] Latency Tolerance Reporting
 Max snoop latency: 0ns
 Max no snoop latency: 0ns
 Capabilities: [400 v1] Data Link Feature <?>
 Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
 Capabilities: [440 v1] Lane Margining at the Receiver
 PortCap: Uses Driver-
 PortSta: MargReady- MargSoftReady-
 Kernel driver in use: pcieport

02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Down=
stream
Port of PCI Express Switch (prog-if 00 [Normal decode])
 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL Downstream P=
ort of
PCI Express Switch
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin A routed to IRQ 50
 IOMMU group: 13
 Bus: primary=3D02, secondary=3D03, subordinate=3D03, sec-latency=3D0
 I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
 Memory behind bridge: fca00000-fcbfffff [size=3D2M] [32-bit]
 Prefetchable memory behind bridge: fc00000000-fe0fffffff [size=3D8448M] [=
32-bit]
 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- <SERR- <PERR-
 BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16+ MAbort- >Reset- FastB2B-
 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [58] Express (v2) Downstream Port (Slot-), IntMsgNum 0
 DevCap: MaxPayload 512 bytes, PhantFunc 0
 ExtTag+ RBE+ TEE-IO-
 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #0, Speed 16GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <=
64ns,
L1 <1us
 ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
 LnkCtl: ASPM L1 Enabled; LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
 LnkSta: Speed 16GT/s, Width x16
 TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+
 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 4
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- ARIFwd-
 AtomicOpsCap: Routing+
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
 AtomicOpsCtl: EgressBlck-
 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers=
+ DRS-
 LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-, Selectabl=
e De-
emphasis: -3.5dB
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
EqualizationPhase1+
 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
 Address: 00000000fee00000 Data: 0000
 Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Navi=
 10 XL
Downstream Port of PCI Express Switch
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [150 v2] Advanced Error Reporting
 UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
 ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrInt=
Err-
HeaderOF-
 CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrInt=
Err-
HeaderOF-
 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCC=
hkEn-
 MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 HeaderLog: 00000000 00000000 00000000 00000000
 Capabilities: [270 v1] Secondary PCI Express
 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 LaneErrStat: 0
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans+
 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl=
-
DirectTrans-
 Capabilities: [400 v1] Data Link Feature <?>
 Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
 Capabilities: [440 v1] Lane Margining at the Receiver
 PortCap: Uses Driver-
 PortSta: MargReady+ MargSoftReady-
 Kernel driver in use: pcieport

03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23
[Radeon RX 6600/6600 XT/6600M] (rev c3)
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin A routed to IRQ 107
 IOMMU group: 14
 Region 0: Memory at fc00000000 (64-bit, prefetchable) [size=3D8G]
 Region 2: Memory at fe00000000 (64-bit, prefetchable) [size=3D256M]
 Region 5: Memory at fca00000 (32-bit, non-prefetchable) [size=3D1M]
 Expansion ROM at fcb00000 [disabled] [size=3D128K]
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [64] Express (v2) Legacy Endpoint, IntMsgNum 0
 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- TEE-IO-
 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
 LnkCap: Port #0, Speed 16GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <=
64ns,
L1 <1us
 ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 16GT/s, Width x16
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Form Factor Dev Specific, EmergencyPowerReduction=
Init-
 FRS-
 AtomicOpsCap: 32bit+ 64bit+ 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn+
 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers=
+ DRS-
 LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
EqualizationPhase1+
 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
 Address: 00000000fee00000 Data: 0000
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [150 v2] Advanced Error Reporting
 UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
 ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrInt=
Err-
HeaderOF-
 CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrInt=
Err-
HeaderOF-
 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCC=
hkEn-
 MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 HeaderLog: 00000000 00000000 00000000 00000000
 Capabilities: [200 v1] Physical Resizable BAR
 BAR 0: current size: 8GB, supported: 256MB 512MB 1GB 2GB 4GB 8GB
 BAR 2: current size: 256MB, supported: 2MB 4MB 8MB 16MB 32MB 64MB 128MB 2=
56MB
 Capabilities: [240 v1] Power Budgeting <?>
 Capabilities: [270 v1] Secondary PCI Express
 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 LaneErrStat: 0
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 Capabilities: [2d0 v1] Process Address Space ID (PASID)
 PASIDCap: Exec+ Priv+, Max PASID Width: 10
 PASIDCtl: Enable+ Exec- Priv-
 Capabilities: [320 v1] Latency Tolerance Reporting
 Max snoop latency: 1048576ns
 Max no snoop latency: 1048576ns
 Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
 Capabilities: [440 v1] Lane Margining at the Receiver
 PortCap: Uses Driver-
 PortSta: MargReady+ MargSoftReady-
 Kernel driver in use: amdgpu
 Kernel modules: amdgpu

03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 21/23 HD=
MI/DP
Audio Controller
 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Navi 21/23 HDMI/DP Audi=
o
Controller
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin B routed to IRQ 129
 IOMMU group: 15
 Region 0: Memory at fcb20000 (32-bit, non-prefetchable) [size=3D16K]
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
 Status: D3 NoSoftRst+ PME-Enable+ DSel=3D0 DScale=3D0 PME-
 Capabilities: [64] Express (v2) Legacy Endpoint, IntMsgNum 0
 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- TEE-IO-
 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
 LnkCap: Port #0, Speed 16GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <=
64ns,
L1 <1us
 ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 16GT/s, Width x16
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Form Factor Dev Specific, EmergencyPowerReduction=
Init-
 FRS-
 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn-
 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
EqualizationPhase1-
 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
 Address: 00000000fee00000 Data: 0000
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [150 v2] Advanced Error Reporting
 UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
 ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrInt=
Err-
HeaderOF-
 CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrInt=
Err-
HeaderOF-
 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCC=
hkEn-
 MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 HeaderLog: 00000000 00000000 00000000 00000000
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 Kernel driver in use: snd_hda_intel
 Kernel modules: snd_hda_intel

04:00.0 Network controller: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
 Subsystem: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin A routed to IRQ 110
 IOMMU group: 16
 Region 0: Memory at fe30300000 (64-bit, prefetchable) [size=3D1M]
 Region 2: Memory at fe30400000 (64-bit, prefetchable) [size=3D16K]
 Region 4: Memory at fe30404000 (64-bit, prefetchable) [size=3D4K]
 Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unli=
mited
 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75W TEE-IO=
-
 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
 MaxPayload 128 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <2u=
s, L1
<8us
 ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 5GT/s, Width x1
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- TPHComp- ExtTPHComp-
 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn-
 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers-=
 DRS-
 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
EqualizationPhase1-
 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [e0] MSI: Enable+ Count=3D1/32 Maskable+ 64bit+
 Address: 00000000fee00000 Data: 0000
 Masking: fffffffe Pending: 00000000
 Capabilities: [f8] Power Management version 3
 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0+,D1+,D2+,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [100 v1] Vendor Specific Information: ID=3D1556 Rev=3D1 Len=
=3D008 <?>
 Capabilities: [108 v1] Latency Tolerance Reporting
 Max snoop latency: 1048576ns
 Max no snoop latency: 1048576ns
 Capabilities: [110 v1] L1 PM Substates
 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates=
+
 PortCommonModeRestoreTime=3D3us PortTPowerOnTime=3D28us
 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
 T_CommonMode=3D0us LTR1.2_Threshold=3D166912ns
 L1SubCtl2: T_PwrOn=3D150us
 Capabilities: [200 v2] Advanced Error Reporting
 UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP+
 ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrInt=
Err-
HeaderOF-
 CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrInt=
Err+
HeaderOF-
 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCC=
hkEn-
 MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 HeaderLog: 00000000 00000000 00000000 00000000
 Kernel driver in use: mt7921e
 Kernel modules: mt7921e

05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin A routed to IRQ 51
 IOMMU group: 17
 Region 0: I/O ports at f000 [size=3D256]
 Region 2: Memory at fcf04000 (64-bit, non-prefetchable) [size=3D4K]
 Region 4: Memory at fcf00000 (64-bit, non-prefetchable) [size=3D16K]
 Capabilities: [40] Power Management version 3
 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0+,D1+,D2+,D3hot+,D3c=
old+)
 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
 Address: 0000000000000000 Data: 0000
 Capabilities: [70] Express (v2) Endpoint, IntMsgNum 1
 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
 ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 75W TEE-IO=
-
 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
 MaxPayload 128 bytes, MaxReadReq 4096 bytes
 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
unlimited, L1 <64us
 ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 2.5GT/s, Width x1
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- EETLPPrefix-
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- TPHComp- ExtTPHComp-
 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn-
 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 2Retimers- D=
RS-
 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-
EqualizationPhase1-
 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [b0] MSI-X: Enable+ Count=3D4 Masked-
 Vector table: BAR=3D4 offset=3D00000000
 PBA: BAR=3D4 offset=3D00000800
 Capabilities: [100 v2] Advanced Error Reporting
 UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
 ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrInt=
Err-
HeaderOF-
 CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrInt=
Err+
HeaderOF-
 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCC=
hkEn-
 MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 HeaderLog: 00000000 00000000 00000000 00000000
 Capabilities: [140 v1] Virtual Channel
 Caps: LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
 Arb: Fixed- WRR32- WRR64- WRR128-
 Ctrl: ArbSelect=3DFixed
 Status: InProgress-
 VC0: Caps: PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopTrans-
 Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
 Ctrl: Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01
 Status: NegoPending- InProgress-
 Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
 Capabilities: [170 v1] Latency Tolerance Reporting
 Max snoop latency: 1048576ns
 Max no snoop latency: 1048576ns
 Capabilities: [178 v1] L1 PM Substates
 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates=
+
 PortCommonModeRestoreTime=3D150us PortTPowerOnTime=3D150us
 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
 T_CommonMode=3D0us LTR1.2_Threshold=3D306176ns
 L1SubCtl2: T_PwrOn=3D150us
 Kernel driver in use: r8169
 Kernel modules: r8169

06:00.0 Non-Volatile memory controller: Kingston Technology Company, Inc.
KC3000/FURY Renegade NVMe SSD [E18] (rev 01) (prog-if 02 [NVM Express])
 Subsystem: Kingston Technology Company, Inc. KC3000/FURY Renegade NVMe SS=
D
[E18]
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin A routed to IRQ 54
 IOMMU group: 18
 Region 0: Memory at fce00000 (64-bit, non-prefetchable) [size=3D16K]
 Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unli=
mited
 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75W TEE-IO=
-
 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
 MaxPayload 512 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
 LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
 ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 8GT/s (downgraded), Width x4
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- TPHComp- ExtTPHComp-
 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn-
 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers=
+ DRS-
 LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
EqualizationPhase1+
 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: Upstream Port
 Capabilities: [d0] MSI-X: Enable+ Count=3D33 Masked-
 Vector table: BAR=3D0 offset=3D00002000
 PBA: BAR=3D0 offset=3D00003000
 Capabilities: [e0] MSI: Enable- Count=3D1/8 Maskable- 64bit+
 Address: 0000000000000000 Data: 0000
 Capabilities: [f8] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [100 v1] Latency Tolerance Reporting
 Max snoop latency: 1048576ns
 Max no snoop latency: 1048576ns
 Capabilities: [110 v1] L1 PM Substates
 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates=
+
 PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D220us
 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
 T_CommonMode=3D0us LTR1.2_Threshold=3D236544ns
 L1SubCtl2: T_PwrOn=3D220us
 Capabilities: [128 v1] Alternative Routing-ID Interpretation (ARI)
 ARICap: MFVC- ACS-, Next Function: 0
 ARICtl: MFVC- ACS-, Function Group: 0
 Capabilities: [1e0 v1] Data Link Feature <?>
 Capabilities: [200 v2] Advanced Error Reporting
 UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
 ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrInt=
Err-
HeaderOF-
 CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrInt=
Err+
HeaderOF-
 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap+ ECRCC=
hkEn-
 MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 HeaderLog: 04000001 0000200f 06010000 dd80aa39
 Capabilities: [290 v1] Device Serial Number 00-00-00-00-00-00-00-00
 Capabilities: [2a0 v1] Power Budgeting <?>
 Capabilities: [300 v1] Secondary PCI Express
 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 LaneErrStat: 0
 Capabilities: [340 v1] Physical Layer 16.0 GT/s <?>
 Capabilities: [378 v1] Lane Margining at the Receiver
 PortCap: Uses Driver-
 PortSta: MargReady- MargSoftReady-
 Kernel driver in use: nvme
 Kernel modules: nvme

07:00.0 Non-Volatile memory controller: Micron/Crucial Technology P1 NVMe =
PCIe
SSD[Frampton] (rev 03) (prog-if 02 [NVM Express])
 Subsystem: Micron/Crucial Technology P1 NVMe PCIe SSD[Frampton]
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin A routed to IRQ 53
 IOMMU group: 19
 Region 0: Memory at fcd00000 (64-bit, non-prefetchable) [size=3D16K]
 Capabilities: [40] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [50] MSI: Enable- Count=3D1/8 Maskable+ 64bit+
 Address: 0000000000000000 Data: 0000
 Masking: 00000000 Pending: 00000000
 Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unli=
mited
 ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75W TEE-IO=
-
 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
 MaxPayload 128 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
 LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <8us
 ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 8GT/s, Width x4
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- TPHComp- ExtTPHComp-
 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn-
 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers-=
 DRS-
 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
EqualizationPhase1+
 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [b0] MSI-X: Enable+ Count=3D16 Masked-
 Vector table: BAR=3D0 offset=3D00002000
 PBA: BAR=3D0 offset=3D00002100
 Capabilities: [100 v2] Advanced Error Reporting
 UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
 ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
 ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked-
TLPBlockedErr-
 PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK-
TLPXlatBlocked-
 CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrInt=
Err-
HeaderOF-
 CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrInt=
Err+
HeaderOF+
 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCC=
hkEn-
 MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
 HeaderLog: 00000000 00000000 00000000 00000000
 Capabilities: [158 v1] Secondary PCI Express
 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 LaneErrStat: 0
 Capabilities: [178 v1] Latency Tolerance Reporting
 Max snoop latency: 1048576ns
 Max no snoop latency: 1048576ns
 Capabilities: [180 v1] L1 PM Substates
 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates=
+
 PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D10us
 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
 T_CommonMode=3D0us LTR1.2_Threshold=3D166912ns
 L1SubCtl2: T_PwrOn=3D150us
 Kernel driver in use: nvme
 Kernel modules: nvme

08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5) (prog-if=
 00
[VGA controller])
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort+ <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin A routed to IRQ 98
 IOMMU group: 20
 Region 0: Memory at fe20000000 (64-bit, prefetchable) [size=3D256M]
 Region 2: Memory at fe30000000 (64-bit, prefetchable) [size=3D2M]
 Region 4: I/O ports at e000 [size=3D256]
 Region 5: Memory at fc900000 (32-bit, non-prefetchable) [size=3D512K]
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [64] Express (v2) Legacy Endpoint, IntMsgNum 0
 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <6=
4ns,
L1 <1us
 ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 8GT/s, Width x16
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS-
 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn-
 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers=
+ DRS-
 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-
ComplianceSOS-
 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+
EqualizationPhase1+
 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable- Count=3D1/4 Maskable- 64bit+
 Address: 0000000000000000 Data: 0000
 Capabilities: [c0] MSI-X: Enable+ Count=3D4 Masked-
 Vector table: BAR=3D5 offset=3D00042000
 PBA: BAR=3D5 offset=3D00043000
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [270 v1] Secondary PCI Express
 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
 LaneErrStat: 0
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 Capabilities: [2b0 v1] Address Translation Service (ATS)
 ATSCap: Invalidate Queue Depth: 00
 ATSCtl: Enable+, Smallest Translation Unit: 00
 Capabilities: [2c0 v1] Page Request Interface (PRI)
 PRICtl: Enable+ Reset-
 PRISta: RF- UPRGI- Stopped+ PASID-
 Page Request Capacity: 00000100, Page Request Allocation: 00000020
 Capabilities: [2d0 v1] Process Address Space ID (PASID)
 PASIDCap: Exec+ Priv+, Max PASID Width: 10
 PASIDCtl: Enable+ Exec- Priv-
 Capabilities: [400 v1] Data Link Feature <?>
 Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
 Capabilities: [440 v1] Lane Margining at the Receiver
 PortCap: Uses Driver-
 PortSta: MargReady- MargSoftReady-
 Kernel driver in use: amdgpu
 Kernel modules: amdgpu

08:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon=
 High
Definition Audio Controller
 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon High Defi=
nition
Audio Controller
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin B routed to IRQ 128
 IOMMU group: 21
 Region 0: Memory at fc9c8000 (32-bit, non-prefetchable) [size=3D16K]
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d+)
 Status: D3 NoSoftRst- PME-Enable+ DSel=3D0 DScale=3D0 PME-
 Capabilities: [64] Express (v2) Legacy Endpoint, IntMsgNum 0
 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <6=
4ns,
L1 <1us
 ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 8GT/s, Width x16
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS-
 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn-
 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
EqualizationPhase1-
 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
 Address: 00000000fee00000 Data: 0000
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 Kernel driver in use: snd_hda_intel
 Kernel modules: snd_hda_intel

08:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 1=
7h
(Models 10h-1fh) Platform Security Processor
 Subsystem: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh)
Platform Security Processor
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin C routed to IRQ 109
 IOMMU group: 22
 Region 2: Memory at fc800000 (32-bit, non-prefetchable) [size=3D1M]
 Region 5: Memory at fc9ce000 (32-bit, non-prefetchable) [size=3D8K]
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [64] Express (v2) Endpoint, IntMsgNum 0
 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0W TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <6=
4ns,
L1 <1us
 ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 8GT/s, Width x16
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- TPHComp- ExtTPHComp-
 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn-
 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
EqualizationPhase1-
 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable- Count=3D1/2 Maskable- 64bit+
 Address: 0000000000000000 Data: 0000
 Capabilities: [c0] MSI-X: Enable+ Count=3D2 Masked-
 Vector table: BAR=3D5 offset=3D00000000
 PBA: BAR=3D5 offset=3D00001000
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 Kernel driver in use: ccp
 Kernel modules: ccp

08:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne =
USB
3.1 (prog-if 30 [XHCI])
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin D routed to IRQ 88
 IOMMU group: 23
 Region 0: Memory at fc700000 (64-bit, non-prefetchable) [size=3D1M]
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [64] Express (v2) Endpoint, IntMsgNum 0
 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0W TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <6=
4ns,
L1 <1us
 ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 8GT/s, Width x16
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- TPHComp- ExtTPHComp-
 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn-
 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
EqualizationPhase1-
 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable- Count=3D1/8 Maskable- 64bit+
 Address: 0000000000000000 Data: 0000
 Capabilities: [c0] MSI-X: Enable+ Count=3D8 Masked-
 Vector table: BAR=3D0 offset=3D000fe000
 PBA: BAR=3D0 offset=3D000ff000
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 Kernel driver in use: xhci_hcd
 Kernel modules: xhci_pci

08:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne =
USB
3.1 (prog-if 30 [XHCI])
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin A routed to IRQ 98
 IOMMU group: 24
 Region 0: Memory at fc600000 (64-bit, non-prefetchable) [size=3D1M]
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [64] Express (v2) Endpoint, IntMsgNum 0
 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0W TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <6=
4ns,
L1 <1us
 ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 8GT/s, Width x16
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- TPHComp- ExtTPHComp-
 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn-
 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
EqualizationPhase1-
 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable- Count=3D1/8 Maskable- 64bit+
 Address: 0000000000000000 Data: 0000
 Capabilities: [c0] MSI-X: Enable+ Count=3D8 Masked-
 Vector table: BAR=3D0 offset=3D000fe000
 PBA: BAR=3D0 offset=3D000ff000
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 Kernel driver in use: xhci_hcd
 Kernel modules: xhci_pci

08:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
ACP/ACP3X/ACP6x Audio Coprocessor (rev 01)
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin B routed to IRQ 126
 IOMMU group: 25
 Region 0: Memory at fc980000 (32-bit, non-prefetchable) [size=3D256K]
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
 Status: D3 NoSoftRst+ PME-Enable+ DSel=3D0 DScale=3D0 PME-
 Capabilities: [64] Express (v2) Endpoint, IntMsgNum 0
 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0W TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <6=
4ns,
L1 <1us
 ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 8GT/s, Width x16
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- TPHComp- ExtTPHComp-
 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn-
 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
EqualizationPhase1-
 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
 Address: 00000000fee00000 Data: 0000
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 Kernel driver in use: snd_rn_pci_acp3x
 Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x

08:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h/1a=
h HD
Audio Controller
 DeviceName: HD Audio Controller
 Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin C routed to IRQ 130
 IOMMU group: 26
 Region 0: Memory at fc9c0000 (32-bit, non-prefetchable) [size=3D32K]
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot+,D3col=
d+)
 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [64] Express (v2) Endpoint, IntMsgNum 0
 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0W TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <6=
4ns,
L1 <1us
 ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 8GT/s, Width x16
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- TPHComp- ExtTPHComp-
 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn-
 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
EqualizationPhase1-
 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
 Address: 00000000fee00000 Data: 0000
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 Kernel driver in use: snd_hda_intel
 Kernel modules: snd_hda_intel

08:00.7 Signal processing controller: Advanced Micro Devices, Inc. [AMD] S=
ensor
Fusion Hub
 Subsystem: Advanced Micro Devices, Inc. [AMD] Sensor Fusion Hub
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort+ <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
 Interrupt: pin D routed to IRQ 88
 IOMMU group: 27
 Region 2: Memory at fc500000 (32-bit, non-prefetchable) [size=3D1M]
 Region 5: Memory at fc9cc000 (32-bit, non-prefetchable) [size=3D8K]
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
 Capabilities: [50] Power Management version 3
 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3col=
d-)
 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
 Capabilities: [64] Express (v2) Endpoint, IntMsgNum 0
 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0W TEE-IO-
 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
 RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
 MaxPayload 256 bytes, MaxReadReq 512 bytes
 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
 LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s <6=
4ns,
L1 <1us
 ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 LnkSta: Speed 8GT/s, Width x16
 TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+,
MaxEETLPPrefixes 1
 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
 FRS- TPHComp- ExtTPHComp-
 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
 AtomicOpsCtl: ReqEn-
 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
 LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-
EqualizationPhase1-
 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
 Retimer- 2Retimers- CrosslinkRes: unsupported
 Capabilities: [a0] MSI: Enable- Count=3D1/2 Maskable- 64bit+
 Address: 0000000000000000 Data: 0000
 Capabilities: [c0] MSI-X: Enable- Count=3D2 Masked-
 Vector table: BAR=3D5 offset=3D00000000
 PBA: BAR=3D5 offset=3D00001000
 Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D010 <?>
 Capabilities: [2a0 v1] Access Control Services
 ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl=
-
DirectTrans-
 Kernel driver in use: pcie_mp2_amd
 Kernel modules: amd_sfh

In the
CONFIG_RANDOMIZE_BASE=3Dy
CONFIG_RANDOMIZE_MEMORY=3Dy
# CONFIG_PCI_P2PDMA is not set
lspci -vvv looks almost the same:
diff -u lspci-vvv.6.14.0-rc6-nop2pdma.txt lspci-vvv.6.14.0-rc6-
norandmemnop2p.txt
=2D-- lspci-vvv.6.14.0-rc6-nop2pdma.txt 2025-03-12 00:54:07.870822971 +010=
0
+++ lspci-vvv.6.14.0-rc6-norandmemnop2p.txt 2025-03-12 01:08:47.814831290 =
+0100
@@ -770,7 +770,7 @@
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
- Interrupt: pin B routed to IRQ 128
+ Interrupt: pin B routed to IRQ 129
 IOMMU group: 15
 Region 0: Memory at fcb20000 (32-bit, non-prefetchable) [size=3D16K]
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
@@ -988,7 +988,7 @@
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
- Interrupt: pin A routed to IRQ 55
+ Interrupt: pin A routed to IRQ 54
 IOMMU group: 18
 Region 0: Memory at fce00000 (64-bit, non-prefetchable) [size=3D16K]
 Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
@@ -1073,7 +1073,7 @@
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
- Interrupt: pin A routed to IRQ 56
+ Interrupt: pin A routed to IRQ 53
 IOMMU group: 19
 Region 0: Memory at fcd00000 (64-bit, non-prefetchable) [size=3D16K]
 Capabilities: [40] Power Management version 3
@@ -1223,7 +1223,7 @@
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
- Interrupt: pin B routed to IRQ 129
+ Interrupt: pin B routed to IRQ 128
 IOMMU group: 21
 Region 0: Memory at fc9c8000 (32-bit, non-prefetchable) [size=3D16K]
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
@@ -1319,7 +1319,7 @@
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx+
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
- Interrupt: pin D routed to IRQ 53
+ Interrupt: pin D routed to IRQ 88
 IOMMU group: 23
 Region 0: Memory at fc700000 (64-bit, non-prefetchable) [size=3D1M]
 Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
@@ -1510,7 +1510,7 @@
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepp=
ing-
SERR- FastB2B- DisINTx-
 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort+ <TAbort-
<MAbort- >SERR- <PERR- INTx-
 Latency: 0, Cache Line Size: 64 bytes
- Interrupt: pin D routed to IRQ 53
+ Interrupt: pin D routed to IRQ 88
 IOMMU group: 27
 Region 2: Memory at fc500000 (32-bit, non-prefetchable) [size=3D1M]
 Region 5: Memory at fc9cc000 (32-bit, non-prefetchable) [size=3D8K]

In the
CONFIG_RANDOMIZE_BASE=3Dy
# CONFIG_RANDOMIZE_MEMORY is not set
# CONFIG_PCI_P2PDMA is not set
case /proc/iomem looks like this:
00000000-00000fff : Reserved
00001000-0009ffff : System RAM
000a0000-000fffff : Reserved
  000a0000-000dffff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-09bfefff : System RAM
09bff000-0a000fff : Reserved
0a001000-0a1fffff : System RAM
0a200000-0a20efff : ACPI Non-volatile Storage
0a20f000-e5e58017 : System RAM
e5e58018-e5e65857 : System RAM
e5e65858-e62edfff : System RAM
e62ee000-e63e1fff : Reserved
e63e2000-e87cafff : System RAM
e87cb000-e87cbfff : Reserved
e87cc000-e9e1ffff : System RAM
e9e20000-eb33efff : Reserved
  eb31e000-eb321fff : MSFT0101:00
  eb322000-eb325fff : MSFT0101:00
eb33f000-eb39efff : ACPI Tables
eb39f000-eb556fff : ACPI Non-volatile Storage
eb557000-ed1fefff : Reserved
ed1ff000-edffffff : System RAM
ee000000-efffffff : Reserved
f0000000-fcffffff : PCI Bus 0000:00
  f0000000-f7ffffff : PCI ECAM 0000 [bus 00-7f]
    f0000000-f7ffffff : pnp 00:00
  fc500000-fc9fffff : PCI Bus 0000:08
    fc500000-fc5fffff : 0000:08:00.7
      fc500000-fc5fffff : pcie_mp2_amd
    fc600000-fc6fffff : 0000:08:00.4
      fc600000-fc6fffff : xhci-hcd
    fc700000-fc7fffff : 0000:08:00.3
      fc700000-fc7fffff : xhci-hcd
    fc800000-fc8fffff : 0000:08:00.2
      fc800000-fc8fffff : ccp
    fc900000-fc97ffff : 0000:08:00.0
    fc980000-fc9bffff : 0000:08:00.5
      fc980000-fc9bffff : AMD ACP3x audio
        fc980000-fc990200 : acp_pdm_iomem
    fc9c0000-fc9c7fff : 0000:08:00.6
      fc9c0000-fc9c7fff : ICH HD audio
    fc9c8000-fc9cbfff : 0000:08:00.1
      fc9c8000-fc9cbfff : ICH HD audio
    fc9cc000-fc9cdfff : 0000:08:00.7
    fc9ce000-fc9cffff : 0000:08:00.2
      fc9ce000-fc9cffff : ccp
  fca00000-fccfffff : PCI Bus 0000:01
    fca00000-fcbfffff : PCI Bus 0000:02
      fca00000-fcbfffff : PCI Bus 0000:03
        fca00000-fcafffff : 0000:03:00.0
        fcb00000-fcb1ffff : 0000:03:00.0
        fcb20000-fcb23fff : 0000:03:00.1
          fcb20000-fcb23fff : ICH HD audio
    fcc00000-fcc03fff : 0000:01:00.0
  fcd00000-fcdfffff : PCI Bus 0000:07
    fcd00000-fcd03fff : 0000:07:00.0
      fcd00000-fcd03fff : nvme
  fce00000-fcefffff : PCI Bus 0000:06
    fce00000-fce03fff : 0000:06:00.0
      fce00000-fce03fff : nvme
  fcf00000-fcffffff : PCI Bus 0000:05
    fcf00000-fcf03fff : 0000:05:00.0
    fcf04000-fcf04fff : 0000:05:00.0
      fcf04000-fcf04fff : r8169
fd300000-fd37ffff : amd_iommu
fec00000-fec003ff : IOAPIC 0
fec01000-fec013ff : IOAPIC 1
fec10000-fec10fff : Reserved
  fec10000-fec10fff : pnp 00:04
fed00000-fed00fff : Reserved
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
fed40000-fed44fff : Reserved
fed80000-fed8ffff : Reserved
  fed81200-fed812ff : AMDI0030:00
  fed81500-fed818ff : AMDI0030:00
    fed81500-fed818ff : AMDI0030:00 AMDI0030:00
fedc0000-fedc0fff : pnp 00:04
fedc4000-fedc9fff : Reserved
  fedc5000-fedc5fff : AMDI0010:03
    fedc5000-fedc5fff : AMDI0010:03 AMDI0010:03
fedcc000-fedcefff : Reserved
fedd5000-fedd5fff : Reserved
fee00000-fee00fff : pnp 00:04
ff000000-ffffffff : pnp 00:04
100000000-fee2fffff : System RAM
  3a7e00000-3a89d2f56 : Kernel code
  3a8a00000-3a8e31fff : Kernel rodata
  3a9000000-3a912a5ff : Kernel data
  3a969c000-3a97fffff : Kernel bss
fee300000-100fffffff : Reserved
1010000000-ffffffffff : PCI Bus 0000:00
  fc00000000-fe0fffffff : PCI Bus 0000:01
    fc00000000-fe0fffffff : PCI Bus 0000:02
      fc00000000-fe0fffffff : PCI Bus 0000:03
        fc00000000-fdffffffff : 0000:03:00.0
        fe00000000-fe0fffffff : 0000:03:00.0
  fe20000000-fe301fffff : PCI Bus 0000:08
    fe20000000-fe2fffffff : 0000:08:00.0
    fe30000000-fe301fffff : 0000:08:00.0
  fe30300000-fe304fffff : PCI Bus 0000:04
    fe30300000-fe303fffff : 0000:04:00.0
      fe30300000-fe303fffff : 0000:04:00.0
    fe30400000-fe30403fff : 0000:04:00.0
    fe30404000-fe30404fff : 0000:04:00.0
3ffe00000000-3fffffffffff : 0000:03:00.0

The diff to the other case
CONFIG_RANDOMIZE_BASE=3Dy
CONFIG_RANDOMIZE_MEMORY=3Dy
# CONFIG_PCI_P2PDMA is not set
is

# diff -u proc_iomme_6.14.0-rc6-norandmemnop2p.txt proc_iomme_6.14.0-rc6-
nop2pdma.txt
=2D-- proc_iomme_6.14.0-rc6-norandmemnop2p.txt	2025-03-12 01:18:33.0227906=
13
+0100
+++ proc_iomme_6.14.0-rc6-nop2pdma.txt	2025-03-12 01:19:36.000325778 +0100
@@ -85,10 +85,10 @@
 fee00000-fee00fff : pnp 00:04
 ff000000-ffffffff : pnp 00:04
 100000000-fee2fffff : System RAM
-  3a7e00000-3a89d2f56 : Kernel code
-  3a8a00000-3a8e31fff : Kernel rodata
-  3a9000000-3a912a5ff : Kernel data
-  3a969c000-3a97fffff : Kernel bss
+  d32200000-d32dd0f56 : Kernel code
+  d32e00000-d33231fff : Kernel rodata
+  d33400000-d3352a5ff : Kernel data
+  d33a9c000-d33bfffff : Kernel bss
 fee300000-100fffffff : Reserved
 1010000000-ffffffffff : PCI Bus 0000:00
   fc00000000-fe0fffffff : PCI Bus 0000:01
@@ -104,4 +104,4 @@
       fe30300000-fe303fffff : 0000:04:00.0
     fe30400000-fe30403fff : 0000:04:00.0
     fe30404000-fe30404fff : 0000:04:00.0
-3ffe00000000-3fffffffffff : 0000:03:00.0
+afe00000000-affffffffff : 0000:03:00.0


Bert Karwatzki

