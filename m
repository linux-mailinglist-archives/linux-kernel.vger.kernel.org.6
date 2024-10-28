Return-Path: <linux-kernel+bounces-384937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095749B3060
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B91D1C2137F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7316C1DB55D;
	Mon, 28 Oct 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OeRpjGEB"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C7F1D966A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118927; cv=none; b=GhJf+p9OlCNgztWCWA9OeyNqZnNeVW94iy+nn2w49cW0cbu6w/nMKb79iyOJMwhAzZ0dqmsrLNidyQt8mSJCgf2A9n5AM0dSEEfTfXDHYG0WDoofi1fUtOXB4RQGCQ6UwnDeK4R5CF4niS+sZGNG0PDibAp+zNu1YzQKLBlDuVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118927; c=relaxed/simple;
	bh=hnHtnu64NmHXiEn8Fqe0ut5ecbpWZwO5a4imoWDO+5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mClJlOxlWRrtnqkKo2dfDtVKyGTdPKeYW4FYnOTU8Hm95m/Sv5Z9QUXHWs7MyHMFWMXXHXVORQQkX6Ydx6ULjoulxNFMwOwjXOuUccNFQ1dqk0neDVcpZGRmmXfz9vnRsttaZYCAllrW683Nqpdk7dgSNN/iOeR2xA0JvOvWTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OeRpjGEB; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=06mJV
	PJym0SyHcFccgWpKccgGv9LEF4FLJZs0IEec+Q=; b=OeRpjGEB8g1dhDGftQnCV
	e0FHTp2fBxnmuQS5j6Xky+9ZNOJqi/YFVYeXcQaZLtg1qGvr+WqkO30cFeXFpJB6
	4zR/9+1USs8OvcCZqdRPrBSsIU108r584rVX12sr1z0utuT++Ec0brgciEtOMd3I
	3DeVbc3l3IIshgkwgL3KPI=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3f+b5hB9nytgkBw--.9113S2;
	Mon, 28 Oct 2024 20:35:08 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 0/3] Enable hdmi for rk3588 based Cool Pi
Date: Mon, 28 Oct 2024 20:34:55 +0800
Message-ID: <20241028123503.384866-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f+b5hB9nytgkBw--.9113S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr13Zw17JrW5Jw1kXw1UJrb_yoWxZwbEya
	47ur9rZa1rZ3Z5JF9xt3WUWa9ak3y5W34UJayUtFy7tF97J3ZrX3WrGw4DZ3Z8AF17Zr4x
	AayUArZ7Ww13CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRAqXlUUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRKGXmcffS5+5gAAsQ

As the hdmi-qp controller recently get merged, we can enable hdmi
display out on these boards now.

Changes in v2:
- Remove enable-gpios as it is unevaluated
- Remove pinctrl setting as it use the default

Andy Yan (3):
  arm64: dts: rockchip: Enable HDMI0 for rk3588 Cool Pi CM5 EVB
  arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi 4B
  arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi GenBook

 .../dts/rockchip/rk3588-coolpi-cm5-evb.dts    | 47 +++++++++++++++++
 .../rockchip/rk3588-coolpi-cm5-genbook.dts    | 50 +++++++++++++++++++
 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 47 +++++++++++++++++
 3 files changed, 144 insertions(+)

-- 
2.43.0


