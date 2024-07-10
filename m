Return-Path: <linux-kernel+bounces-247786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6EB92D489
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395541C21402
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3E119309E;
	Wed, 10 Jul 2024 14:51:00 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454015E97;
	Wed, 10 Jul 2024 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720623059; cv=none; b=THmJHQ1DHr3q4wXBk1UAgOrQw+/aJ43pnjvR0p6uR7ztFfHvnGEXPSumF7/8K1luuO92eIk/AUtvhuQv7ublV+Ug2cR+B6jKY2eta4sNngd6iQ8db+x/ljschZ08AkANjYoDit+nhAovwsise2LbHDN5aChlDmdATAZMnkLe8yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720623059; c=relaxed/simple;
	bh=aIcQjENbMyNuWqzMtJ29qLel2RrxfyQIlKM05QX9NIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XhnjHoOeeJTwFecsQikkecTldqPDCUrxJ5V8FpNrk/bT9eOdLWRq2nbpn38vSJD3o4v0fxxSNZfVwoRrIqxv1edj9kMOAbVWL0ZvU4mzwbNpwLHok83cygXV7q/0Z2jT5fTiC7Q4NzgdoSaBebgwHPnZ67ERvShCP186b/8PSz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:fb60:82c0:6879:f4d2:caf4])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 6F3577E0166;
	Wed, 10 Jul 2024 22:50:13 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org
Subject: Re: [PATCH v2 7/9] arm64: dts: rockchip: use generic Ethernet PHY reset bindings for Lunzn Fastrhino R68S
Date: Wed, 10 Jul 2024 22:50:10 +0800
Message-Id: <20240710145010.688986-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <caf55fe6-4674-4c89-a94e-f4ad348e2ba0@kwiboo.se>
References: <caf55fe6-4674-4c89-a94e-f4ad348e2ba0@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQh1OVk5PGR1NHU1OHx1ISVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQR0ZTUtBQ0kYS0FNQ0xCQR1PH0lBGBodT1lXWRYaDx
	IVHRRZQVlPS0hVSktISUxCS1VKS0tVSkJLS1kG
X-HM-Tid: 0a909d1f9f3f03a2kunm6f3577e0166
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTI6Egw6GTIzDDAOIyIRPzAJ
	KwsKC1ZVSlVKTElLTUlIS0pPS0NCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBHRlNS0FDSRhLQU1DTEJBHU8fSUEYGh1PWVdZCAFZQUpDTU83Bg++

> Where do you find the 72ms in the datasheet?

I refer to this commit:
https://github.com/torvalds/linux/commit/1c7412530d5d0e0a0b27f1642f5c13c8b9f36f05
BTW I found that some boards use the RTL8211F-VD PHY,
but I can't find the datasheet.

> In RTL8211F-CG v1.1 I see 10ms and minimum of 30ms, in v1.2 and v1.4
> I see 10ms and minimum of 50ms.

> I have used 50ms on a few recently added boards and they seem to all
> work fine with 50ms, wonder if the deassert delay should be changed for
> those boards.

Thanks,
Chukun

-- 
2.25.1


