Return-Path: <linux-kernel+bounces-403268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B55169C3356
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 16:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC68B20C37
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E2D54670;
	Sun, 10 Nov 2024 15:46:11 +0000 (UTC)
Received: from mail-m1830.xmail.ntesmail.com (mail-m1830.xmail.ntesmail.com [45.195.18.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A36322B;
	Sun, 10 Nov 2024 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.18.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731253570; cv=none; b=Li7P7+j7AEqPESQQ52X1+kgcxmwvc7m6YIqfLijC+xe6cJAAXhhMhZkW50x96sN1mKawKaV2ZXVqnK0c/vt1dXIT9VW63+5a8Uk1R+gPrKkhe0pECFgR2GxdWmoDJSSJmfPsQxjKR5DqRxh/qEKeIDILThsoTMyvj0BoYD466uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731253570; c=relaxed/simple;
	bh=k1Hhej6l5Fpa3I12mAgfU1Noe7pDSVEuEzsa03YYJx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tLBvWRjfvb9/pyJ7MELmHyBKZeVGCfAMLfe+Z99sAkid829XssEyTYNFFlBhAVPq/x/A63p4mfFMLS0Jz5k/gwH04KDv1AavFqKGWG4ouCW727HFwHrxUijVcbHQM2ZLu2FdtWURd+a9/dmmufBB9RqYviGwFzgNLBLhQ0zwUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.195.18.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c03:51e0::1])
	by smtp.qiye.163.com (Hmail) with ESMTP id 250d5e7b;
	Sun, 10 Nov 2024 23:30:39 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: amadeus@jmu.edu.cn
Cc: andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] arm64: dts: qcom: ipq6018: rework CPU Frequency
Date: Sun, 10 Nov 2024 23:30:35 +0800
Message-Id: <20241110153036.3645169-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241110140019.3426181-1-amadeus@jmu.edu.cn>
References: <20241110140019.3426181-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSh5DVkNCSB4ZSktNTkkeTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtIQU5KHktBQUpZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	1VSktLVUtZBg++
X-HM-Tid: 0a9316b2d82503a2kunm250d5e7b
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAg6ODo5CTIaEi0PMwkDAkwu
	ME8wCgNVSlVKTEhKSU5JTU9LSE5MVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0hBTkoeS0FBSllXWQgBWUFPSUs3Bg++

0003-arm64-dts-qcom-ipq6018-move-mp5496-regulator-out-of-.patch
missing, so I resent.

 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts |  2 +-
 arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi | 44 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi        | 28 ++++++-------
 3 files changed, 59 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq6018-mp5496.dtsi

-- 
2.25.1


