Return-Path: <linux-kernel+bounces-540719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 778FAA4B42C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E87616BE1B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ACB1EB5DD;
	Sun,  2 Mar 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UOSYoFCl"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99412B93;
	Sun,  2 Mar 2025 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740941303; cv=none; b=NLB175kyMZvI4bo2F0arZHf9OGQj+k+nfNJiCYAxWUUTH6jackygaxifM84EUux93O60iT63uXqNL451UwoLAMKWiaGmjmIvyemNCusB2KjOAXg8HvaYt0K/fuiMg9lKyHdtEgxpJdOz5CHAvlH3D3wk7toOhN7SuqcrKfb4z8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740941303; c=relaxed/simple;
	bh=NcMqrBK+sAuTQH/6XuHuL+enLlKm5osmENyhl3lz37o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FcpXXjmYE1i4EQFp8ap71l86m19W7pR7zzb97+sgt6pOWz9Xz9zSrwL8Ptf6FXmMpBMkM3HM+q84jwL+TmYMSuyaBCbVSSFdmuah1TggHv6RJBNg1xh3bfmEJts8C2jCrXjzCMkrdIdpDjTk7iXmtS0keCpI4GdiaMKAYC/xqfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=UOSYoFCl; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1740941293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rQXew6m92deUN72dLBiwb/ih/m/f5d9GpQpBSeEN2Ro=;
	b=UOSYoFClTic2PbsC9ZKZ1fJwDcihUrGT2sSqx5TQYRRDjOkhAl6cWyeyGeYDyMbHqe9vet
	btRM9ugur0ouyrMDvvN2GvE9yZWSZfR51R1mhtxk+NkcUXMkYqof+fcghrOA5N9XLHsUsn
	BhOEsztZ1BpWPpwjnNY5ubwihMSFSWMqywSYz1eZaWrMF74RhRswq+wZ7lUa3NV+3yyZoz
	oVf+zkOEm4Whswh9i62CrOX+FysuxDrS+tdUdVzP5eOj6NlQjBqiyz/RP/ue/H7SY3LbCx
	bVOR5CJHdRQFkyDWDeGwstvcDsXeIXU29pa1RylRbiVoOVcBTVA2i/HuLPQ0zA==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	didi.debian@cknow.org,
	chris@z9.de
Subject: [PATCH v2 0/2] Slightly improve hardware description of Pine64 RockPro64
Date: Sun,  2 Mar 2025 19:48:02 +0100
Message-Id: <cover.1740941097.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This is a small series that introduces small improvements to the way
Pine64 RockPro64 [1] single-board-computer is described in the DT files.
This applies to both production-run revisions of the RockPro64.

The introduced improvements boil down to eliminating some warnings from
the kernel log, by adding a previously undefined regulator and by adding
some previously missing references to the regulators.

The patch 2/2 also results in reliability improvements, by reportedly
resolving (some of) the longstanding issues resulting from using certain
PCI Express cards with the Pine64 RockPro64.

Changes in v2:
  - Dissolved the patch 2/2 notes into its description, according to the
    numerous power cycling/rebooting tests performed on a Pine64 RockPro64
    by @ChriChri and reported in the #rock64 channel on irc.pine64.org
  - Adjusted the cover letter to match the latest test results
  - Added "Fixes" and "Cc: stable" tags to both patches in the series
  - Added "Tested-by" to the patch 2/2, thanks to Chris' testing [2]
  - Added a few "Cc" tags to the patch 2/2, to make sure people involved
    in the earlier related patch [3] are in the loop

Link to v1: https://lore.kernel.org/linux-rockchip/cover.1740748439.git.dsimic@manjaro.org/T/#u

[1] https://wiki.pine64.org/wiki/ROCKPro64
[2] https://z9.de/hedgedoc/s/nF4d5G7rg#reboot-tests-for-PCIe-improvements
[3] https://lore.kernel.org/lkml/20230509153912.515218-1-vincenzopalazzodev@gmail.com/T/#u

Dragan Simic (2):
  arm64: dts: rockchip: Add avdd HDMI supplies to RockPro64 board dtsi
  arm64: dts: rockchip: Add missing PCIe supplies to RockPro64 board
    dtsi

 .../boot/dts/rockchip/rk3399-rockpro64.dtsi      | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)


