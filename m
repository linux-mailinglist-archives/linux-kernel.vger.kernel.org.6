Return-Path: <linux-kernel+bounces-306922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7938E96458A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E92A1F29923
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600AE1B29C9;
	Thu, 29 Aug 2024 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="JDcffAa8"
Received: from mr85p00im-ztdg06011101.me.com (mr85p00im-ztdg06011101.me.com [17.58.23.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7D1922EE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935960; cv=none; b=s7zpJ+j4ZjyYelTBpsJYb2ysMCNuETlZSma7pCbIkTftsVLRteW2Ei+SFW/YdG4hzKsYbF4x2RLk1T/t8oj4XIjGFyNql0wvrv/bIsSqxcHSE+TM5rJNfhdZ0APmhApYwe8JQSWDDHcs/gPC1HhbtLIg5IHKZkoe1Io+Bp0zosk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935960; c=relaxed/simple;
	bh=2cXhdJ3/UFWEPRmCi/i3aEfO8vHgg6Y/swisVUDxXtM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=el4V56Cl+ePXUM9bW0h9vq+u4d/vsgCjAdz6cZZ/7kQAMtscjkymfplXtnEkaIxZB+b8l5GHzHDq/WzA3qjRk2rDmOdppXPzQBmn4r6Q/ptOrwYlzrBNcaaqaL7VsNxmElBg+q7cjnKKz6Vdlati3hSwgZTZ8oX9LNNj0NUVqwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=JDcffAa8; arc=none smtp.client-ip=17.58.23.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724935957;
	bh=2cXhdJ3/UFWEPRmCi/i3aEfO8vHgg6Y/swisVUDxXtM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
	b=JDcffAa8BjoWlO7TdG5QEFOkZ2BqkZaRuOUiDE504OlKWhMgj5PfwWgPZ/jU0KAUn
	 zdW/FTJB7mckXXdh6JNKH/fcVz05bTw+D3Bi3sXGD66lReHo2nh7fsrzoJyNEPSEkv
	 +VbEVp7YdEsshCdFE/hhh66bEiG9gKZyobb6E4h7xL8TSXjrwGCxgMu0yGDw4aU75U
	 4laS0YVPjLwxCTSUl7G51CxWkwZ6NMZxN0pzk9nuffCNwBzHx7NdTyzGWrmeKzLZN4
	 eKzVTCSFQbKiP+Ji2HXc56bwcqXK7YISJ8d6mMI//n8zPwynK3NNZBdOIkXndUBPOD
	 gzusrwvIrglvQ==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011101.me.com (Postfix) with ESMTPSA id 75CF3DA0352;
	Thu, 29 Aug 2024 12:52:35 +0000 (UTC)
From: jonesthefox@icloud.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2 0/4] arm64: dts: rockchip: Add Hardkernel ODROID-M1S
Message-Id: <44115846-F7A9-47F5-899B-A8146E20BC31@icloud.com>
Date: Thu, 29 Aug 2024 14:52:21 +0200
Cc: linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
To: jonas@kwiboo.se
X-Mailer: Apple Mail (2.3776.700.51)
X-Proofpoint-GUID: 7gotTrT_7AE3shnOv2uvWMV9FhuA-3jx
X-Proofpoint-ORIG-GUID: 7gotTrT_7AE3shnOv2uvWMV9FhuA-3jx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408290088

Hi Jonas,

I applied your four patches for the Odroid M1S to the mainline kernel =
[1],=20
compiled it using the kernel configuration from the Hardkernel Ubuntu=20
Server Image [2], and then attempted to boot into the official Generic=20=

AArch64 image on mmcblk0 using a dtb file and an Arch Linux initrd by=20
manually copying the kernel and dtb file to the boot partition and=20
booting manually with the vendor's U-Boot [3].=20

The booting process was successful!

However, the network interface is not working. Here is the relevant=20
dmesg output:

----
[ 6.694455] rk_gmac-dwmac fe010000.ethernet: IRQ eth_lpi not found
[ 6.695030] rk_gmac-dwmac fe010000.ethernet: IRQ sfty not found
[ 6.702424] rk_gmac-dwmac fe010000.ethernet: clock input or output? =
(input).
[ 6.703064] rk_gmac-dwmac fe010000.ethernet: Can not read property: =
tx_delay.
[ 6.704461] rk_gmac-dwmac fe010000.ethernet: set tx_delay to 0x30
[ 6.705002] rk_gmac-dwmac fe010000.ethernet: Can not read property: =
rx_delay.
[ 6.709919] rk_gmac-dwmac fe010000.ethernet: set rx_delay to 0x10
[ 6.710579] rk_gmac-dwmac fe010000.ethernet: integrated PHY? (no).
[ 6.711180] rk_gmac-dwmac fe010000.ethernet: clock input from PHY
[ 6.716749] rk_gmac-dwmac fe010000.ethernet: init for RGMII_ID
[ 6.718117] rk_gmac-dwmac fe010000.ethernet: User ID: 0x30, Synopsys ID: =
0x51
[ 6.719022] rk_gmac-dwmac fe010000.ethernet: DWMAC4/5
[ 6.719540] rk_gmac-dwmac fe010000.ethernet: DMA HW capability register =
supported
[ 6.720204] rk_gmac-dwmac fe010000.ethernet: RX Checksum Offload Engine =
supported
[ 6.720864] rk_gmac-dwmac fe010000.ethernet: TX Checksum insertion =
supported
[ 6.721484] rk_gmac-dwmac fe010000.ethernet: Wake-Up On Lan supported
[ 6.722155] rk_gmac-dwmac fe010000.ethernet: TSO supported
[ 6.723019] rk_gmac-dwmac fe010000.ethernet: Enable RX Mitigation via HW =
Watchdog Timer
[ 6.723761] rk_gmac-dwmac fe010000.ethernet: device MAC address =
0e:c7:69:a9:f2:61
[ 6.724436] rk_gmac-dwmac fe010000.ethernet: Enabled RFS Flow TC =
(entries=3D10)
[ 6.725073] rk_gmac-dwmac fe010000.ethernet: TSO feature enabled
[ 6.725609] rk_gmac-dwmac fe010000.ethernet: Using 32/32 bits DMA =
host/device width
[ 6.998073] rk_gmac-dwmac fe010000.ethernet end0: renamed from eth0
[ 7.096335] rk_gmac-dwmac fe010000.ethernet end0: Register =
MEM_TYPE_PAGE_POOL RxQ-0
[ 7.097618] rk_gmac-dwmac fe010000.ethernet end0: __stmmac_open: Cannot =
attach to PHY (error: -19)
----

Does anyone have any idea what could be causing this issue, or if there=20=

is anything I could try to get the network interface up and running?

Thanks for your help!

Best regards,
Patrick

[1] Linux Kernel Repository: =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
Version: v6.11-rc5-50-g3ec3f5fc4a91

[2] Semi-official Hardkernel Ubuntu Server Preview Image for Odroid M1S:=20=

https://forum.odroid.com/viewtopic.php?t=3D48230

[3] U-Boot Version: U-Boot 2017.09-g97ab962d1ed-230719 #tobetter (Oct 27 =
2023 - 14:54:41 +0900)

