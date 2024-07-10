Return-Path: <linux-kernel+bounces-247740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85292D3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8990CB2578A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A02119408D;
	Wed, 10 Jul 2024 14:07:40 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AE4193464;
	Wed, 10 Jul 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620460; cv=none; b=WlHiFvQ63ZvOwkvN9Lz7SwA5l73weGKMoLluXIgnCX21RLuOR4G1DX2PAmLHQBt90Mq8W1HDXiZR6MOT34OtbqO10aDHxCcSr5UaypcFp/LNPKJ5jk6UR1W7FYaGeTcFN6rQuNVNj62LxaCExbEQFKnfZ31o/I84v86oHuCToGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620460; c=relaxed/simple;
	bh=nl4eLnKwkG4ZvQH0Ehrc9uMNGv95e9VFR1r8tFN0sdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SpfqoOqEcwrMiVsTibR9f2ZCqT3s8bMiLW+DzCis+XaPcuPcomRuk3t02Ewms6opdw/7Cg9pDvOw8QR54twDbrOOYZLo/OjLG5o/+bouXVC8MwHhRUygmCDjLiTXq8HPyQcuxc2IrPftNPotwPj6+DWi5l5N1JU2blvIuJSQSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:fb60:82c0:6879:f4d2:caf4])
	by smtp.qiye.163.com (Hmail) with ESMTPA id ABB257E0183;
	Wed, 10 Jul 2024 21:30:32 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: heiko@sntech.de
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org
Subject: Re: [PATCH v2 7/9] arm64: dts: rockchip: use generic Ethernet PHY reset bindings for Lunzn Fastrhino R68S
Date: Wed, 10 Jul 2024 21:30:29 +0800
Message-Id: <20240710133029.676677-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2210411.C4sosBPzcN@diego>
References: <2210411.C4sosBPzcN@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0NJVh5LHkJLSkMdSxhJGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQR0ZTUtBQ0kYS0FNQ0xCQR1PH0lBGBodT1lXWRYaDx
	IVHRRZQVlPS0hVSktJT09PS1VKS0tVS1kG
X-HM-Tid: 0a909cd6ac5203a2kunmabb257e0183
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mj46PTo5SDI5CDAzEEMOPwsZ
	ORcwCTNVSlVKTElLTUpDSUhISElCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBHRlNS0FDSRhLQU1DTEJBHU8fSUEYGh1PWVdZCAFZQUpNQ0M3Bg++

> what's the reason behind the changed timings?
>
> The original comment stated,
>	/* Reset time is 15ms, 50ms for rtl8211f */
> so that timing change needs an explanation please :-)

I don't know why this comment says that, but it's clearly wrong.
According to the PHY datasheet, the RTL8211F PHY needs a 10ms
assert delay and at least 72ms deassert delay. Considering the
possibility of mixed use of PHY chips, the reset time should be
further increased. 

Thanks,
Chukun

-- 
2.25.1


