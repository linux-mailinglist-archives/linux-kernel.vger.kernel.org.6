Return-Path: <linux-kernel+bounces-253722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F439325E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21541C21D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBED4199EA9;
	Tue, 16 Jul 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYtZAzlS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15619923C;
	Tue, 16 Jul 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130600; cv=none; b=qf5njK0oHrTEi9gDRq8lAvTF8FG23KLq3OdOf4p92SypkfCAUlQUc0p2hQLk+qwbo0+cAxLSegxEdHOzmxtQ4Y53sorGh/xypBZCwIzSR5JnyFXXkpFA52JyrRV1YBGWYHBXihG0OFwKFpuDY0aejiUmFwhmbnZPhFvh4ZVfL7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130600; c=relaxed/simple;
	bh=4KobWHo0k49SwsqBfr87hnXmB1Gdn8DzYlrHyKptLB8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YzQV1USrSH3XvTjL5lxAN7C4OX+X2jJepjpRMdQbhhmB5lkjRLpjS4OvY6l8JrHa/QbIl72TrJcyvzuIBPNC6rrGMxlpdWmC5Ips8F00tk0yhrNTYw3pzuTNF55ka2UnZvcHC244PCCR3Q3KKz+beyBpQNVUGShP2re+ajqstk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYtZAzlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB36CC4AF09;
	Tue, 16 Jul 2024 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721130600;
	bh=4KobWHo0k49SwsqBfr87hnXmB1Gdn8DzYlrHyKptLB8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hYtZAzlSuzX/3WYrcCZXCH7d6rxWUGjsWcOKEyIW6EzUFoJaAdnRpqSh3rlLs5mpj
	 xXfnP09G/HHJQoSTJ2CK/JGKNEhgA3pe/PA2OV/EPg5qnAI41zeomaI6GF5wHQYbJA
	 QQQFyJqtSrwB+VKa8HThkJG3XuJgkaghRlh8sGVEvkQpyLDL8j1TS3Zaa0LALZ72R0
	 5Od22Us97Xe3Ztk9x1n3eRcjWubB3+ToWgKU1+B0WltoWhg4DSqZh90ZfxdjdTstIh
	 TCGLjz+pHbgZB3IqlTuOwruQnZlXTA3BrXFTh7DIKYQtL8+4LZcv5GDWq1TstmGA4L
	 gfl6CUiXEGJYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D882FC3DA59;
	Tue, 16 Jul 2024 11:49:59 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
Subject: [PATCH 0/2] hwmon: add GPD devices sensor driver
Date: Tue, 16 Jul 2024 19:49:52 +0800
Message-Id: <20240716-gpd_fan-v1-0-34051dd71a06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGBelmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0Mz3fSClPi0xDxdU/M0YwNLI+NkCwsTJaDqgqLUtMwKsEnRsbW1AJA
 bDxZZAAAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Cryolitia PukNgae <Cryolitia@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 =?utf-8?q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=Cryolitia@gmail.com;
 h=from:subject:message-id;
 bh=4KobWHo0k49SwsqBfr87hnXmB1Gdn8DzYlrHyKptLB8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFHUy9wQU5Bd0FJQVQ1ZEYzTDhpb
 zdkQWNzbVlnQm1sbDVqL3BKaS9EZk9pYlNzRXpvK01WZEFlanBHCks5WGF5QVo4a3NDb0tIRjJM
 NCtKQVRNRUFBRUlBQjBXSVFSME5XMHB5dmR3U0JGOENDWStYUmR5L0lxTzNRVUMKWnBaZVl3QUt
 DUkErWFJkeS9JcU8zVUIzQ0FDNG5pRVcxTnUzMG00am5idDBvRmtXTlBKdHdyNUJVY3lDS29uVQ
 pIcXhkSVlNYUNlL1RPQUJPRnE3eFNPSnl5MU8xRnFEbVYvQjJuQXBIWmxvdHRCWjh4RSsrMmNNb
 DZZR3FEZkx3ClIvOFEzVVo3ektqUnMxZml1T1lXcldPL0NUZVluNkJpaWZpK1FveVpObUZUK2w2
 Y1hudmZXUzVuOWI2NXp4TTIKSXNUalhhVW9qM2JraWFtM003emkwSnpPNlE3YmNsREJDaHZidXN
 xekg3VTE5TFJreTFZKzNRSXBnbThkc2NQMQpPSDUyRFgxYmp6MVFKNEZOSVVPRFJINjZVOXk0bj
 FrV3B1bEdWT3VYR1RlMFdFTnhRMzZDb0RsbjFzWGRLY21vCkJqY2pSN0ptWWwrSGtSdVF2d05Rb
 lVucHJvQXBwVWxXVXIwRWIxT2cybDNxdVJCUAo9K21haQotLS0tLUVORCBQR1AgTUVTU0FHRS0t
 LS0tCg==
X-Developer-Key: i=Cryolitia@gmail.com; a=openpgp;
 fpr=1C3C6547538D7152310C0EEA84DD0C0130A54DF7
X-Endpoint-Received: by B4 Relay for Cryolitia@gmail.com/default with
 auth_id=186
X-Original-From: Cryolitia PukNgae <Cryolitia@gmail.com>
Reply-To: Cryolitia@gmail.com

Sensors driver for GPD Handhelds that expose fan reading and control via
hwmon sysfs.

Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
devices. This driver implements these functions through x86 port-mapped IO.
I have tested it on my device.

Tested-by: Marcin Strągowski <marcin@stragowski.com>
Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>

---
Cryolitia PukNgae (2):
      hwmon: add GPD devices sensor driver
      hwmon: document: add gpd-fan

 Documentation/hwmon/gpd-fan.rst |  68 ++++
 Documentation/hwmon/index.rst   |   1 +
 MAINTAINERS                     |   7 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/gpd-fan.c         | 759 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 846 insertions(+)
---
base-commit: d67978318827d06f1c0fa4c31343a279e9df6fde
change-id: 20240716-gpd_fan-57f30923c884

Best regards,
-- 
Cryolitia PukNgae <Cryolitia@gmail.com>



