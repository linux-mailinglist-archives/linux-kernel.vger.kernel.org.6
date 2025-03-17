Return-Path: <linux-kernel+bounces-563848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F70A64999
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96ACF3B8C24
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DBF235BF8;
	Mon, 17 Mar 2025 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="LUPAC3mP";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="mx1B+dMY"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D60A2356D1;
	Mon, 17 Mar 2025 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206683; cv=none; b=bAiaMz7ceg3nA+m7M4l3Go366ejplLl8tg0fzIH1spZtYiUe6L53D/n2VsoYIMBSsQSRbMEY0kx35b6oMvW6YOhY8tsil1vBHH3x3kfodBrmE1OW+2JzGCiBJN4ArrnQrgW7pyKg1p4WvtNZwF/Z/KTkr9+R5mGY5BFVujuqSC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206683; c=relaxed/simple;
	bh=SC+1xziw5XXd+kvWuj4mIDXmIEY0sRJCuuMxVVRqfok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pJML7RqTn9T3j6GcE/SvgUNtOtuD1vw932k5dPSVGGSRhYEFWPEAUVvAglsHlPu0ZhI9iUkXro+Mz9wpxDjcCjwKO5VkTuNW5pjcQrPe1i3uBbQGP5BAhWa4Z/aHOv88kFvjOjOPK5jOyn3OndRByCE7x8WniVnfgcYo9VVsjDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=LUPAC3mP; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=mx1B+dMY; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1742206677;
	bh=i9tyr6WCYRQ+l29hhEBPu5UnDY7L1FYQX3MWucC2VnI=; l=551;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=LUPAC3mPpolEua23b03wca6obMNMhlAQ2Si62cWSUa42hNAY9ACMxEDgqrioqRnJJ
	 /SzDt6W4CpYJmfPnpLsLcI9pTAFB7v7+x4hxiJrVAz5W2OUbs5zTtEDsxJYubKb/4J
	 kuzIh//QgxqtIimwzC6lxfH9glJkLNuld5Ph8Qsw6vmxych9ZJxioRTRWTDnUGuT32
	 m+/kD1NXOOfxkHtq0XNcjz3hRsAEzj8/Lo0WiH+cNksAz+LA49yD3hppnTtUabPsw5
	 Nm9CWbWhzNcoNSrkNjO5k4ZjF9vYcY8hd48jJk/ESzTDG/AHC5ljmsrFzzLfyHrAe/
	 lgF6onLixQGMg==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128085:0:AUTH_RELAY)
	(envelope-from <prvs=1170D5C545=cy_huang@richtek.com>); Mon, 17 Mar 2025 18:17:55 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1742206675;
	bh=i9tyr6WCYRQ+l29hhEBPu5UnDY7L1FYQX3MWucC2VnI=; l=551;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mx1B+dMYOHtC3NHlOxYfK1Hsg/9a6uDZZcpRklXKq24kpluQMtgld/w5I7BIZ6vFe
	 UE6ojRWH3mjdC8RT27aZx3akXw5hODZTdgwY+jaU8P74Bjep1UZtySFSZZZDKBv8Ho
	 rl8QhrnyoF93c+xloByG25mIb8gfqFkgvXVY/R7xF3qFVheUc7szYPiKlpO+yonuIu
	 7btLC68+hAJXUOZYtxDRktaYoRgbolL0cROxfEq9rYd7rMucmXPhOyltH8chivdX9B
	 xdWuTD+WzrGexO34oYHG4nA+62SlwR6tZGyHzdqhBimR91RYE1HoZRuLnqQLdOgw0t
	 6oaIx0VPx5htQ==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3810286:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 17 Mar 2025 18:05:17 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Mar
 2025 18:05:17 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Mon, 17 Mar 2025 18:05:17 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	ChiYuan Huang <cy_huang@richtek.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH 0/3] regulator: rtq2208: Fix incorrect code section
Date: Mon, 17 Mar 2025 18:06:20 +0800
Message-ID: <cover.1742204502.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series is to fix
- buck converter phase mapping
- Correctly get LDO DVS capability

ChiYuan Huang (3):
  regulator: rtq2208: Fix incorrect buck converter phase mapping
  regulator: rtq2208: Fix the LDO DVS capability
  regulator: dt-bindings: rtq2208: Remove unnecessary property of fixed
    LDO VOUT

 .../bindings/regulator/richtek,rtq2208.yaml   |   8 +-
 drivers/regulator/rtq2208-regulator.c         | 216 ++++++++++--------
 2 files changed, 124 insertions(+), 100 deletions(-)

-- 
2.34.1


