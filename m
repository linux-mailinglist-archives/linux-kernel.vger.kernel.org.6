Return-Path: <linux-kernel+bounces-286940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109AD9520A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EAB2B26643
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E11BB6BE;
	Wed, 14 Aug 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b="OaIJ1igW"
Received: from xn--80adja5bqm.su (xn--80adja5bqm.su [198.44.140.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDBF3FB3B;
	Wed, 14 Aug 2024 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.44.140.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654890; cv=none; b=qX0QmrvxIeFOpEMVNLjxPICgyCN7VX3LS+vc+DKazlvJjXAEyfzzuH2Yo2God5eH1VWaAgAc+pH3pVWsWLCE/whqTG3vlNd+HpPoRZDTkxxx2IhK4Pdnzs4GXP/Twb79yqqUUHCYqJjFTAz+s32SwTEBzBAL3T+gbatOPSQgs4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654890; c=relaxed/simple;
	bh=ud14CC+RqBs4Zw8LHMIZYXCYRKqTwhKHH/MGPrLQyV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TTMXRwkhp4ieTg172r4jPLVXw/Wet5xX4Jf+UtMZ2F8pTlQRGhtcLVAnQwwjGW11pmdc+8aJ7RUFuPrrbXCd0sq078FwvMuQe6pjRgm/1fq09arH6k3zc/yOvNz23cd4pae6IIrwToE8RQtbi+RW8Qb1Mb/HSqL7ncEe7UB3rS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc; spf=pass smtp.mailfrom=xn--80adja5bqm.su; dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b=OaIJ1igW; arc=none smtp.client-ip=198.44.140.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xn--80adja5bqm.su
Received: by xn--80adja5bqm.su (Postfix, from userid 1000)
	id E351940460CE; Wed, 14 Aug 2024 17:01:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 xn--80adja5bqm.su E351940460CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mediatomb.cc;
	s=default; t=1723654871;
	bh=ud14CC+RqBs4Zw8LHMIZYXCYRKqTwhKHH/MGPrLQyV4=;
	h=From:To:Cc:Subject:Date:From;
	b=OaIJ1igW9am9rTC5WUY7n8vcX5GGNl8lS0kNLCJGvL3lo0RFogqSFbhfigv5fSS+V
	 QUb/tOcehpKvu9yCJMITog6G7/a4diEkrhP4wTvcG1Uqh1fRwOtHsx5griDOzLo0bC
	 ekENEXgbHnNEFuWbmbV9DIZJPzAZx6yugDODxzagzrEOQ9JspVltuOORZXXI9vgG5M
	 Ik+mM813TGc0b2hIA60vwCnTon8kbEOmO4TXCJw4q0iHI2wFxrLeM49PZ9r9sYvj+5
	 ytM/uIcGTEh8fqZqeGyTh8KoBluYDetinghgU13zB4od1eVGhgXbV5PlAJs/m+CP1S
	 sI5RaDsy2mlmQ==
From: Sergey Bostandzhyan <jin@mediatomb.cc>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sergey Bostandzhyan <jin@mediatomb.cc>
Subject: [PATCH v3 0/3] Add DTS for NanoPi R2S Plus
Date: Wed, 14 Aug 2024 17:00:45 +0000
Message-Id: <20240814170048.23816-1-jin@mediatomb.cc>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,                                                                              
                                                                                 
here is version 3 of the NanoPi R2S Plus patchset.

* a commit which adds mmc-hs200-1_8v in order to improve eMMC performance has
  been included
* the licence header has been updated to the newer version, anw now includes
  optional MIT licensing


Sergey Bostandzhyan (3):
  arm64: dts: rockchip: Add DTS for FriendlyARM NanoPi R2S Plus
  dt-bindings: arm: rockchip: Add NanoPi R2S Plus
  arm64: dts: rockchip: improve eMMC speed on NanoPi R2S Plus

 .../devicetree/bindings/arm/rockchip.yaml     |  1 +
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/rk3328-nanopi-r2s-plus.dts   | 32 +++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts

-- 
2.20.1


