Return-Path: <linux-kernel+bounces-395159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3B19BB960
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E9D28274C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CF51C07F7;
	Mon,  4 Nov 2024 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lP7A4nP9"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E3A1B6D14;
	Mon,  4 Nov 2024 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735310; cv=none; b=BYzzePKMQOe2U7NsZ8YSwyP+hCtwLRB831F6wjikmgNDSpRBlmFxEr1g7PfFdt6IOt/2bpuuFU54ddgk0JtPee0ZZO/ldktqpmJ7l057hGCLH4D2Zr0hP0A0BiWc6bDh/+H1i/KYROQp5Bhlo7a3/C3h8gXmPqld/OxqsWn/wig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735310; c=relaxed/simple;
	bh=hQqSZ7cfwDEOEEaQ/NdKYXoQZOu7iupl3J11XYIqgew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cF7X3ZJaboSMiD5iHupvvV9T3HssGxCfoCWIPrJbvkDsVo2a8NgH7qxta0M3JD8GVgX1yZQzF2rDV94T/pKiWWMuFyd+jqIY+VKgxHEaiSlO8fkW3zp4uoMEZfqpQUpf9xRu+BlsNz6TSz4MBtmRoQlfpRwH5snDmdgnqw+nOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lP7A4nP9; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16FEA60003;
	Mon,  4 Nov 2024 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730735299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ldUcfsMlAUslWYr57Hg0qmqkNkmmS4wsI7qb1CM8FB8=;
	b=lP7A4nP9NeLGXcYbmk4LXtHE36j0zfESbglRs4QjIUFSVXLUPDTJFavJvXK1wUr6FIGoHZ
	6ziAgsuYQ/ahQuf2NIAuD25D6yXSlDyC00ydrq9JZ3aD5LI/KqSLwoUL7QpdOF4UiYskhw
	wrfcl38IdDqesRF7amBKsRcuPfVrAkJ9VV/2/V/obMpKgaBUtRI3ipImsHs5S1IsW5ZMva
	hJBM7saxTAHiR4qSpHx9+mBIrR0yHoN0+Qme1N1pzgE1hbDzmwp4ljzdMxPPYGovZ+Tw+Q
	b0Q19QiaHbtRU/2NDix8scRov7CuOXiKaHN9zRZQ638rFSMdvgvaLZNl8KcItg==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH 0/2] Enable sensors support for the Congatec Board
 Controller
Date: Mon, 04 Nov 2024 16:48:06 +0100
Message-Id: <20241104-congatec-board-controller-hwmon-v1-0-871e4cd59d8e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALbsKGcC/yWNyw6DIBBFf8XMuiQoitJfaVzgMCiJQgv0kRj/v
 bTu7rmLc3ZIFB0luFY7RHq55IIvUF8qwEX7mZgzhaHhTcsHrhgGP+tMyKago/lhjmFdKbLlvQX
 PSJEURnW9EQKK5R7Jus+/cBtPjvR4llA+T5h0ouLZNpdL2FpCPnSyt20jdY2dEsTFgNqgrCeDZ
 U6t7GE8ji8fLZQFvQAAAA==
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.richard@bootlin.com

The Congatec Board Controller has some voltage, current, temperature
and fan sensors.
This series adds an hwmon driver to enable the support.

This series is based on linux-next (commit
1ffec08567f426a1c593e038cadc61bdc38cb467) as the MFD driver is not yet
available in the main tree.

The sensors support has been tested on the conga-SA7 board with a
conga-SEVAL board.

Note that the Board Controller returns two unknown sensors, which causes
two warnings. These unknown sensors are not defined in the driver provided
by Congatec.

cgbc-hwmon cgbc-hwmon: Board Controller returned an unknown sensor (type=2, id=17), ignore it
cgbc-hwmon cgbc-hwmon: Board Controller returned an unknown sensor (type=1, id=10), ignore it

Best Regards,

Thomas

$ sensors
cgbc_hwmon-isa-0000
Adapter: ISA adapter
DC Runtime Voltage:    4.93 V
Chipset Temperature:  +48.0 C
Board Temperature:    +44.0 C

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Thomas Richard (2):
      hwmon: Add Congatec Board Controller monitoring driver
      mfd: cgbc: add a hwmon cell

 MAINTAINERS                |   1 +
 drivers/hwmon/Kconfig      |   9 ++
 drivers/hwmon/Makefile     |   1 +
 drivers/hwmon/cgbc-hwmon.c | 287 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/cgbc-core.c    |   1 +
 5 files changed, 299 insertions(+)
---
base-commit: 1ffec08567f426a1c593e038cadc61bdc38cb467
change-id: 20240809-congatec-board-controller-hwmon-e9e63d957d33

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


