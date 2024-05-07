Return-Path: <linux-kernel+bounces-171824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DDD8BE98B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B0EB26D0D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D0816DEDF;
	Tue,  7 May 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Fgw9Q1BU"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC34216DEA1;
	Tue,  7 May 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099374; cv=none; b=Y8aQhZcxdXm7nqAcrl691bFelFEDawqGZIaE8Fs7LmpFvu8C68TlnClJWJ2Kk2tM4LXC7M9pBPK+tNf1xQZ90AoOv12o0GGP0i1Ycg35A7iqAvTzhcbYf+HYIisaDJTso5GA9KeZlYssx1G2ijOffNORJDwsxZoBJSbkJY+eiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099374; c=relaxed/simple;
	bh=9sfwyDKRmxF+pTpkLlzmOLefQHCjWWc7iSr3ec30vOg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bap+8Gpe9X0cQVjAXAItW0RWXIIYgdfOx3TpO45E5kdRocOOJ69O17KDDtNaYjFPRaHt+071QfdaxPXgi0RtNISS7nG3kTjKl7OvVE4n2NVlLjZLUZHfn7Ijy0Rqlsfp9UksJxT/E0+LD0kvvMChUmgGgcBYCMJ8aypwFYcY86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Fgw9Q1BU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715099369;
	bh=9sfwyDKRmxF+pTpkLlzmOLefQHCjWWc7iSr3ec30vOg=;
	h=From:Subject:Date:To:Cc:From;
	b=Fgw9Q1BUCCXQzKX/Seupbc5VGQQWavr9E/i4o4Sa0P9+hEHwIIxDi+GeNPZFsQGEj
	 8IAu55TMPO7SqlUGnvfA6UCZM1Tfiy2ffshhesQs/GpLusdwv6O+WoXEjd1EB7DZNR
	 XoFj0Gvyq7/GKHU/Rk+QupTdkFmKejX8vNAlGdJ4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/2] ChromeOS Embedded controller hwmon driver
Date: Tue, 07 May 2024 18:29:21 +0200
Message-Id: <20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOFWOmYC/13MQQrCMBCF4auUWRtJY5oWV95Diug4MbMwkUxtl
 dK7GwtuXP4P3jeDUGYS2FczZBpZOMUSZlMBhnO8keJraTDaWN1opzAnORGqMN1TVMa6nb3oFr3
 zUD6PTJ5fq3fsSweWIeX3yo/1d/1J7Z801korg7bFBqmjrjlMxCKC4Rm2kQbol2X5AI2pjkivA
 AAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Moritz Fischer <mdf@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715099369; l=2085;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9sfwyDKRmxF+pTpkLlzmOLefQHCjWWc7iSr3ec30vOg=;
 b=0jCWjX9D/3fVSGdqPDZs149i5r21UtsarpozrO7JFeoruZq/fCNZkhnpnnrRBiADSkfxKWazT
 pVhhpWhIkscBKc73KVRaeZoWQkuBZJ2NuaOqlQjfHYHIkGHHDRGaDnD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add a hwmon driver that reports fan and temperature readings from the
ChromeOS Embedded controller.

There was an earlier effort in 2017 to add such a driver [0], but there
was no followup after v1.
The new driver is complete reimplementation based on newer APIs and with
more features (temp sensor names).

It only works on LPC-connected ECs, as only those implement direct
memory-map access.
For other busses the data would need to be read with a command.
Adding some helpers was discussed in the previous patchset [1].

The EC protocols also support reading and writing fan curves but that is
not implemented.

Tested on a Framework 13 AMD, Firmware 3.05.

[0] https://lore.kernel.org/all/1491602410-31518-1-git-send-email-moritz.fischer@ettus.com/
[1] https://lore.kernel.org/all/ac61bfca-bfa0-143b-c9ca-365b8026ce8d@roeck-us.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- drop unnecessary range checks (Guenter)
- only validate thermal_version during probing
- reorder some variable declarations
- validate thermal_version directly in cros_ec_hwmon_probe (Mario)
- drop return value from probe_temp_sensors as it can't fail anymore
- fail with -ENODEV if cmd_readmem is missing to avoid spurious warnings
- Link to v1: https://lore.kernel.org/r/20240507-cros_ec-hwmon-v1-0-2c47c5ce8e85@weissschuh.net

---
Thomas Weißschuh (2):
      hwmon: add ChromeOS EC driver
      mfd: cros_ec: Register hardware monitoring subdevice

 Documentation/hwmon/cros_ec_hwmon.rst |  26 ++++
 Documentation/hwmon/index.rst         |   1 +
 MAINTAINERS                           |   8 +
 drivers/hwmon/Kconfig                 |  11 ++
 drivers/hwmon/Makefile                |   1 +
 drivers/hwmon/cros_ec_hwmon.c         | 269 ++++++++++++++++++++++++++++++++++
 drivers/mfd/cros_ec_dev.c             |   1 +
 7 files changed, 317 insertions(+)
---
base-commit: 2fbe479c0024e1c6b992184a799055e19932aa48
change-id: 20240506-cros_ec-hwmon-24634b07cf6f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


