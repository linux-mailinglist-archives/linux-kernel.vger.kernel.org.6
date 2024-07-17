Return-Path: <linux-kernel+bounces-254762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F21933757
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502E51F24CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3271802E;
	Wed, 17 Jul 2024 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8w08Aol"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225C33D8;
	Wed, 17 Jul 2024 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721198794; cv=none; b=Wt1KbCs87wYnZCW+UnFHC6ZZu8CHYwkRF53HG50UX+AK9QXfFlmzzkMpGMiC/R6ETujRpG1ChvEnuv7bSOutvBKd3VZPgC2b/yE5arupZBPUcmIX2lv5e6gF5dDEijtrh4OOtRA9GPCuCE2Nnjl9TP/EbaY18gkgk1WoIPC01pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721198794; c=relaxed/simple;
	bh=uMqIIpyBOEqt0CJmGAlMj+e7wF3ct3u+0A8IBPGTYoU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W87FyNN3tjI7D5rOab5TzkNBLbe/xZIhUcE3lppwgdE9IqvJDjbkCYDheZ8wa7hduu582o/E2NkQHuLvRVZsjFi2GEh5230PYLb3jOSSzljnS0/WeyGUF7jxIGysEpNX3TK6Aw6QDAvWoONagdPZ8OlFoot1g1Mu0a1JmzMtoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8w08Aol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E9D6C4AF09;
	Wed, 17 Jul 2024 06:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721198794;
	bh=uMqIIpyBOEqt0CJmGAlMj+e7wF3ct3u+0A8IBPGTYoU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=A8w08Aol4NsvGHucRsXWDe35HVmylrYgdApVMyGZM+l9fZTx15gq377yjJd+0Cn01
	 ygFI3mE3ed7h6IWg8AZdoMWy0FzZc+26D5cignaMx/cSRsPZO0U90DsYEh3yGCZOR/
	 nDiQn4DavEJ5x5P8NVtziGmTIa7HOL4V6gVKLXbY90ZeRd+KsttVP8AWtmogF96WLI
	 2J5OnQYbcZNJ5zWlb+7F3Ip0z5vC8ibLzwd2TWg4bf+xsTmw8XoWbNE8Bo0jeN7Pvp
	 UV3fDvxncuNFsGiejFTchBJ/IQWYfLrvri+uYbYX0Sek6Njz93ByV+To3CHD1rE7nk
	 VTGNGk4JxXAGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BBCC3DA4B;
	Wed, 17 Jul 2024 06:46:34 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+Cryolitia.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] hwmon: add GPD devices sensor driver
Date: Wed, 17 Jul 2024 14:46:25 +0800
Message-Id: <20240717-gpd_fan-v3-0-8d7efb1263b7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMFol2YC/2WMyQqDMBRFf0XeuikZNNGu+h+llGgGH9SBpIQW8
 d8b3VTo8lzuOQtEG9BGuBQLBJsw4jRmEKcCul6P3hI0mYFTXlLFJPGzeTg9kko5QRsuurouIb/
 nYB2+99LtnrnH+JrCZw8ntq3/jcQIJaKkFTNGMU3l1Q8an+duGmBrJH701M/j2XOqVVa2jeOsP
 Xrrun4BYCwYZtYAAAA=
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Cryolitia PukNgae <Cryolitia@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>, 
 Yao Zi <ziyao@disroot.org>, 
 =?utf-8?q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1328;
 i=Cryolitia@gmail.com; h=from:subject:message-id;
 bh=uMqIIpyBOEqt0CJmGAlMj+e7wF3ct3u+0A8IBPGTYoU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFHUy9wQU5Bd0FJQVQ1ZEYzTDhpb
 zdkQWNzbVlnQm1sMmpGNjY3UjRtOGNzS1BDOXJxOXRzeU1sVXVwCkVpVzlYQnhLRWlpQTRwcVR1
 M0tKQVRNRUFBRUlBQjBXSVFSME5XMHB5dmR3U0JGOENDWStYUmR5L0lxTzNRVUMKWnBkb3hRQUt
 DUkErWFJkeS9JcU8zVC9HQi85a0l3eitoUEE3NXd3V3ZrWUdSTjYzQXJkQW1hNDRoeHExS2JuZQ
 ppNjFxS0k4RWs2M20xbCt5ZXlrQ29HczZ3SFZRZVI2UjQ3Q2kvTDFhcUUzSFVFalRubW1vc2E1R
 UFTNitPenhUCi9qNU1OWG11QlY5WVdmZDl4U0lGNmQyY2JFOEw1NkZaK0U5cU9NUmFjWmxaSUlS
 UGFPUU1EdEFKbHcreUE4S0UKT0hxYjBTVStQSW9Oc0FwbVlsamNmdlhkWXh0MlV0dDlSSEpZZ3E
 zZUJNMGttY2ZSUm9Dd0NCVDhTVDVCejhCbgpWVCtuV08vc1lUOVFwdXZodDhiNUozcFl5anRDZl
 JyZy8xYkNxNmprUm1NdnZVTEt3NGl6Q1U2Y1ZJYUZxbEd6CjZ5cXQ1SmZQM1JGY05YQzUzcjRUc
 0phbVArajAwSjNIQkVEbTZYS2hFb0J3TDk2WAo9dzdnUQotLS0tLUVORCBQR1AgTUVTU0FHRS0t
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
Changes in v3:
- Re-arrange code, thanks to Krzysztof Kozlowski, Guenter Roeck, Yao Zi!
- Link to v2: https://lore.kernel.org/r/20240717-gpd_fan-v2-0-f7b7e6b9f21b@gmail.com

Changes in v2:
- Improved documentation, thanks to Randy Dunlap!
- Link to v1: https://lore.kernel.org/r/20240716-gpd_fan-v1-0-34051dd71a06@gmail.com

---
Cryolitia PukNgae (2):
      hwmon: add GPD devices sensor driver
      hwmon: document: add gpd-fan

 Documentation/hwmon/gpd-fan.rst |  63 ++++
 Documentation/hwmon/index.rst   |   1 +
 MAINTAINERS                     |   7 +
 drivers/hwmon/Kconfig           |  10 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/gpd-fan.c         | 674 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 756 insertions(+)
---
base-commit: d67978318827d06f1c0fa4c31343a279e9df6fde
change-id: 20240716-gpd_fan-57f30923c884

Best regards,
-- 
Cryolitia PukNgae <Cryolitia@gmail.com>



