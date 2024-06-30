Return-Path: <linux-kernel+bounces-235296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8B291D30E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F4A1C2091C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29314155A5D;
	Sun, 30 Jun 2024 17:27:33 +0000 (UTC)
Received: from mail-m17214.xmail.ntesmail.com (mail-m17214.xmail.ntesmail.com [45.195.17.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723AF13D242;
	Sun, 30 Jun 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719768452; cv=none; b=G8sLT1Cv5CS2b+N0Yw2CXcCQXzY/mHdlvWkqomN1+I++xdXmP2yz8XBd/djdfHr3MnZ5WQepR6W+rR6Nm/vYGDq3vQeeYTYV+c3wJKRotfdus8ooM1D+Oi2QzNqcpNbCpDKR90m10GLEQqIIqlnoxzNH1UcOD/4HZoHQ5aAZfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719768452; c=relaxed/simple;
	bh=A7lZXB+YNdmG407zrnZzFmINSND5c9ARdDF8hprFWWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hOLxGCPAyIrtepTUlSWftEpeck3EuPsGw75zRxOKDcjTLfQ1HMZuWPm8evCuFMi6hgeM8CTQGHK0ht/42Y8rG7Y+ZfUi2e0nKmXc0E47dHnonISR9VppgD31X6NHcVt9JAZ+lZ/4vd4C58Eh0P+OtwT+aDvb5VLwDAojyliWtSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.195.17.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:1720:3110:52ea:d52a:84f0])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 606D67E0129;
	Sun, 30 Jun 2024 23:00:14 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 0/9]  arm64: dts: rockchip: fixes support for Lunzn Fastrhino R6xS
Date: Sun, 30 Jun 2024 23:00:01 +0800
Message-Id: <20240630150010.55729-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSh8eVkwdQktCQ0tCHxlOSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtKQUpMSUtBSEpKS0FOSR4aQR9OSRpBQ08dS1lXWRYaDx
	IVHRRZQVlPS0hVSktJSEJLQ1VKS0tVSkJZBg++
X-HM-Tid: 0a9069a9329b03a2kunm606d67e0129
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OUk6MAw5GjNNIxwZLTBPSCsD
	TEMaFBFVSlVKTEpCTE5CTUpPQklCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBSkxJS0FISkpLQU5JHhpBH05JGkFDTx1LWVdZCAFZQUlJSEw3Bg++

Changes in v2:
  Separate commits for regulator and supply changes
  Separate commits for R68S Ethernet PHY changes

Chukun Pan (9):
  arm64: dts: rockchip: fix regulator name for Lunzn Fastrhino R6xS
  arm64: dts: rockchip: fix usb regulator for Lunzn Fastrhino R6xS
  arm64: dts: rockchip: fix pmu_io supply for Lunzn Fastrhino R6xS
  arm64: dts: rockchip: remove unused usb2 nodes for Lunzn Fastrhino
    R6xS
  arm64: dts: rockchip: disable display subsystem for Lunzn Fastrhino
    R6xS
  arm64: dts: rockchip: fixes PHY reset for Lunzn Fastrhino R68S
  arm64: dts: rockchip: use generic Ethernet PHY reset bindings for
    Lunzn Fastrhino R68S
  arm64: dts: rockchip: remove useless tx/rx_delay for Lunzn Fastrhino
    R68S
  arm64: dts: rockchip: Enable UHS-I SDR-50 for Lunzn FastRhino R66S

 .../dts/rockchip/rk3568-fastrhino-r66s.dts    |  6 ++-
 .../dts/rockchip/rk3568-fastrhino-r66s.dtsi   | 48 ++++++-------------
 .../dts/rockchip/rk3568-fastrhino-r68s.dts    | 30 ++++++------
 3 files changed, 33 insertions(+), 51 deletions(-)

-- 
2.25.1


