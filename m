Return-Path: <linux-kernel+bounces-549151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4710BA54E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99AD57A4854
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EA4188724;
	Thu,  6 Mar 2025 14:50:35 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E116DEB3;
	Thu,  6 Mar 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272635; cv=none; b=LUUUXxxTQMJv8mYIkXX/vaoQB0Yv8TQJonR5AvKE+bGuzgk0dnc80Rg+Cui7BYFVJHIqfxnVgCaJ0gagFt7TwxPXzBbNQOwvKsKtZyLHkdJT4oV2BCZRayXwJrnTG7lBK4yonxNrTdj2Kl0k7lmSm5doynlOkcuMqlVsFBD4+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272635; c=relaxed/simple;
	bh=j97JksIKx3BW75S25iH9OOG7m9btHK59Zoup7ZeDAvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQkRn4cDpAm5a7m/1UQuu2+G4UHBLA4pYiOYU8YpIM1KZCPzSYkQh8R0y8eH1psWY7SuYGKbLRkkjT/vb2CoGr5OiUzsXKVoYK/3XB2dZyie94zIKs7l0DtT6ek2YeZCxBkASjzU9wBZkN70YWIBhGprG8Eqt/iYHmOAiNufbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id d2dcd0ed;
	Thu, 6 Mar 2025 22:50:27 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: heiko@sntech.de
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Date: Thu,  6 Mar 2025 22:50:20 +0800
Message-Id: <20250306145020.485848-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <24848438.6Emhk5qWAg@diego>
References: <24848438.6Emhk5qWAg@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHxpIVk0aT0MfT0oZT0JIGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktJQk1KSlVKS0tVS1
	kG
X-HM-Tid: 0a956befb78e03a2kunmd2dcd0ed
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAg6Pzo5HjIDLjNOTAlJITAW
	TBlPCj1VSlVKTE9KSUxJTUlMQ0lDVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQU1CQjcG

Hi,

> are you really sure about that?
>
> Looking at Jonas' recent rk3528 u-boot series [0]
> 0x0 _to_ 0xfc000000 is the SDRAM memory area
> so 0x10f000 is a carveout of the main sdram.

Sorry, I was misled by the dtsi of rk3568.
Put it in reserved-memory works on rk3528:

~# dmesg | grep scmi
[    0.061452] scmi_core: SCMI protocol bus registered
[    0.125903] scmi_protocol scmi_dev.1: Enabled polling mode TX channel - prot_id:16
[    0.126763] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
[    0.127368] arm-scmi firmware:scmi: SCMI Protocol v2.0 'rockchip:' Firmware version 0x0

Should we change this for rk3568 as well?

Thanks,
Chukun

-- 
2.25.1


