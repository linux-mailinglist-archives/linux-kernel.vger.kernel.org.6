Return-Path: <linux-kernel+bounces-319786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FA8970233
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5561F21699
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5444815B548;
	Sat,  7 Sep 2024 12:47:43 +0000 (UTC)
Received: from mail-m1284.netease.com (mail-m1284.netease.com [103.209.128.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B33C482;
	Sat,  7 Sep 2024 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725713263; cv=none; b=H8S6GiNnBdUDMonXJxPoALDXKDerfZVrSl6ASg1xYnxarH4jQlMx9Qh3701OBWCOqV1Dci1qY0e3B1bKvGeXKh7gBXwBSN+7yS3GVZdi5mr6X2TCKSBjO8KpSEN8Si7k26eV1JkTjpGtLau01zg3kozUyEf7La/joNtNp7IB6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725713263; c=relaxed/simple;
	bh=SqFGQgEg86V7I2yxkuckwxd4tP/EO5C7CjTnPMiXDSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAyKrWn3Nb1fRibBfkdMRao0DdYQM15ZHywRnRbnbnOLiXHxnKMIPVksaJSvYdwx9WV5dno9P0kn4zcS1mXXn/hQ6jSvZ69fd9+sILkrsBbmvQL7SFYXvT13rpF5wohijlOLy3BagbL96Q+HCkqg5dAlxPfFZFRtcQl+1MWlJVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=103.209.128.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:9f80::1])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 50E737E01EB;
	Sat,  7 Sep 2024 16:00:05 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: bigfoot@classfun.cn
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568
Date: Sat,  7 Sep 2024 16:00:02 +0800
Message-Id: <20240907080002.16427-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <53784a02-087b-4912-94a9-aead49d7abea@classfun.cn>
References: <53784a02-087b-4912-94a9-aead49d7abea@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTk1MVkpOQx9LQxhLGhgaSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtKQUIdQ0tBQUpZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
X-HM-Tid: 0a91cb7f55ea03a2kunm50e737e01eb
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Njo6ASo4SDIwTjM5OUM4FgsW
	PiwwCRxVSlVKTElOTUJNS0tNS05KVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBQh1DS0FBSllXWQgBWUFKT0NDNwY+

Hi Junhao,

> Is vccin_5v a new regulator or is it actually vcc_sysin?

VCCIN_5V (type-c power or battery) -> VCC_SYSIN

VCC_SYSIN -> MCU -> VCC_SYSON

-- 
2.25.1


