Return-Path: <linux-kernel+bounces-525602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E5A3F1F3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA44F7A4C89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BD3205AA6;
	Fri, 21 Feb 2025 10:26:46 +0000 (UTC)
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6E19CC20;
	Fri, 21 Feb 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133606; cv=none; b=UhJVocsgzNf3tpFYjYz70FaGgs8abnoQnMk2pYvrV4Xqg/zOy4jZGpGKAPHXwwn+vUM9VAJGV0Af53FRJUTztelYxvzX2J9hfdfse0FhekODrqkjXkoAVFj4Ttrlr7hLoMdNNN0sU4ahrjlE66sqK84lqc4BqP7QicMT96KOj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133606; c=relaxed/simple;
	bh=hcojOVOlZteYvTqZoEhKcz1p/KBnRLCEoAM+7JodPXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZfMc7+9rDZF1BT8MWheInR8kegH8GYa6S2WjtPEw/n+FILNUbRWi4c8gYUkW3Go9A2pWPb2p8+D0DLsMa16Iqqq1YEi1kFYXTZW371PD20vrvCsPwSe8weGl+f2T6JZOMBIoLhr896S/JvPhRcEa4g2j5/BQojtRV6WaltGDMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.bYUQxFL_1740133585 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 18:26:30 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	rf@opensource.cirrus.com,
	jack.yu@realtek.com,
	ivprusov@salutedevices.com,
	zhoubinbin@loongson.cn,
	quic_pkumpatl@quicinc.com,
	paulha@opensource.cirrus.com,
	nuno.sa@analog.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V1 0/2] ASoC: codecs: Add aw88166 amplifier driver
Date: Fri, 21 Feb 2025 18:26:21 +0800
Message-ID: <20250221102623.369435-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

Add the awinic,aw88166 property to support the aw88166 chip.

The driver is for amplifiers aw88166 of Awinic Technology
Corporation. The AW88166 is a high efficiency digital
Smart K audio amplifier

Weidong Wang (2):
  ASoC: dt-bindings: Add schema for "awinic,aw88166"
  ASoC: codecs: Add aw88166 amplifier driver

 .../bindings/sound/awinic,aw88395.yaml        |    1 +
 sound/soc/codecs/Kconfig                      |   13 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/aw88166.c                    | 1937 +++++++++++++++++
 sound/soc/codecs/aw88166.h                    |  534 +++++
 5 files changed, 2487 insertions(+)
 create mode 100644 sound/soc/codecs/aw88166.c
 create mode 100644 sound/soc/codecs/aw88166.h


base-commit: 334426094588f8179fe175a09ecc887ff0c75758
-- 
2.47.0


