Return-Path: <linux-kernel+bounces-550562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 229E8A5612A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FBB176E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3F11A01B9;
	Fri,  7 Mar 2025 06:50:26 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E381632D9;
	Fri,  7 Mar 2025 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330226; cv=none; b=ZQ0COv6SSJAQAoermX+SovrNSbJ+fR7aPwcg/t6y+y2GKNUhi8xNCasx9MvwijL6RKToxrTN1D8bdPDb6NaV8MtPu+b7EI3ePypejh+7qgA6TW6nRniOOBcZpw9BIPFpP6G9UVYuF+BriSBb2luW9xR4o2QVoEMTzl5d7wDHYFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330226; c=relaxed/simple;
	bh=654CtTZeddqqETFu/ZnAfcGbXdZy/aUh1qunbf6aBT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OIMIZqeTTO7Vn4Hm8RXKoHkh8BLcGzpl/bikdACqF3tj43wJjaIzPbPhOSJ5KmIl9KVxVsNBDN630MKNYFNVlt7CzD6SaXD10w5UoDrj9w0+S3HfXKkXOac/9joBGTnZsK/mbrYjoTtzP5RanN6pJH2SuDr6hw3hEeWcwkLtXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:3300:bb12:a0a3:40d:e82f])
	by smtp.qiye.163.com (Hmail) with ESMTP id d4e0a9b3;
	Fri, 7 Mar 2025 14:50:17 +0800 (GMT+08:00)
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
	robh@kernel.org,
	ziyao@disroot.org
Subject: Re: [PATCH v2 1/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Date: Fri,  7 Mar 2025 14:50:15 +0800
Message-Id: <20250307065015.697377-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <281b8025-8288-4274-b863-f091c05cbabe@kwiboo.se>
References: <281b8025-8288-4274-b863-f091c05cbabe@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHh1OVhpMTk9CSklCHk1PS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUhIS0tBGRlKSUEaSxpIQU9LH0EeQ0kdWVdZFhoPEh
	UdFFlBWU9LSFVKS0lIQktDVUpLS1VKQlkG
X-HM-Tid: 0a956f5e7a9803a2kunmd4e0a9b3
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MyI6Vhw4NDJWNjdCVh4tT0IO
	GDxPCRFVSlVKTE9KSEhLSUpDTkhNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBSEhLS0EZGUpJQRpLGkhBT0sfQR5DSR1ZV1kIAVlBT01PNwY+

Hi,

> This is new compared to v1, please add operating-points instead.
> cpu_pvtpll is already initialized to 1.2 GHz by firmware, see e.g. [1].
> 
> [1] https://lore.kernel.org/u-boot/20250123224844.3104592-5-jonas@kwiboo.se/

Thanks for this information, I will remove assigned-clocks.
However, due to unknown reasons, the cpu opp-table does not
match the actual frequency at all.
e.g. set 2016MHz, actual 1610MHz

Thanks,
Chukun

-- 
2.25.1


