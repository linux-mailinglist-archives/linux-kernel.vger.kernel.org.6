Return-Path: <linux-kernel+bounces-536339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF68A47E66
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B24D7A672E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015D22D7A3;
	Thu, 27 Feb 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnIpJX0d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B822D4F9;
	Thu, 27 Feb 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661075; cv=none; b=X31nP+GYVdJrPhatNUb0XDEEhFydxGGbMRASsse72SUKDQIrhKprGO2ulpijgDOA9GJH5DhCuLBxaz64wEZiTTOpX8phTfLeDhpIGwEQSYoquwV1SJqVrkhASBU6mpnNZlvcYF/2gp36hLNmCizg/Bbmp0TVJpYixtxwab49yZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661075; c=relaxed/simple;
	bh=fH4N0wG87WQDa0bhN9DzZrrecvbqHxRrAhkjPukdbA4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eguiWNA4wV60LfITsKThBgRKHHKrhgs4kIOLItXx7oRVIy8q0cc7yt8iaaFyKn/bUEvTRZb74v9xYm9JmQRktCoarY7SS/s1To7LepJ6kk82fzB6IvficvOfrp7RzMHQxCIuWKDuj0gYRoCSxKmMv+SpsTAZ9J5nRpXrwdmqdxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnIpJX0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2C6CC4CEDD;
	Thu, 27 Feb 2025 12:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740661075;
	bh=fH4N0wG87WQDa0bhN9DzZrrecvbqHxRrAhkjPukdbA4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gnIpJX0dh3WDZc/Rd5FHTYfXO9vldvvhXopix02G1cZjNqVib4JIhNJosr2gUpKnd
	 aOw7z1ghTewQyMGZoHtoZiHwMlgK86j7ywQsuc32TStlM1XEyaj3nTSt3Sw2tc/3kt
	 TZ5afx5lHsaI0XEd3NbLVmdf+mM4Egb+j+tS59nLDViOCC3H1HqPwoGGfuvhjYOqCc
	 ToGNt1jnFpzKwetHjuEiQQDDyFhLevfcswACXct69C5vpZ6RGDk8GM0/ipn5bzFk6m
	 mTZ0wOsnHdXGU8qa6eNvkEQFR9VKuVmBm0BIu7HJLZVk6aaLOILkeg+5ESSfqjVJrz
	 x4MxteRB3tAlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE1CC021BE;
	Thu, 27 Feb 2025 12:57:54 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Subject: [PATCH 0/3] hwmon: (ntc_thermistor) typo fixes and incorrect table
 fix
Date: Thu, 27 Feb 2025 13:57:50 +0100
Message-Id: <20250227-ntc_thermistor_fixes-v1-0-70fa73200b52@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE5hwGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNz3byS5PiSjNSi3Mzikvyi+LTMitRiXTMDE+NkCzMjS1OzRCWg1oK
 iVLAEUGd0bG0tAMKLl+lmAAAA
X-Change-ID: 20250227-ntc_thermistor_fixes-6043c862956a
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Joseph McNally <jmcna06@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740661074; l=882;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=fH4N0wG87WQDa0bhN9DzZrrecvbqHxRrAhkjPukdbA4=;
 b=dnRWEeSNNKaARGa6YQjxb6PbhJnpRMPY/d/CWj381ztZJmhOuOQ72cO44MAUmkPwFfptCwFCT
 dfiy+20BnjhDSy/LSMcwd4K8eb8dfkio4ndyeIVJdU4Epj1ODdMCRNx
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

Fix some small mistakes in the Kconfig and bindings yaml, also fix the
incorrect sensor table for the ncpXXxh103 sensor.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
Maud Spierings (3):
      hwmon: (ntc_thermistor) Fix module name in the Kconfig
      dt-bindings: hwmon: ntc-thermistor: fix typo regarding the deprecation of the ntc, compatibles
      hwmon: (ntc_thermistor) Fix the ncpXXxh103 sensor table

 .../devicetree/bindings/hwmon/ntc-thermistor.yaml  |  2 +-
 drivers/hwmon/Kconfig                              |  2 +-
 drivers/hwmon/ntc_thermistor.c                     | 66 +++++++++++-----------
 3 files changed, 35 insertions(+), 35 deletions(-)
---
base-commit: be5c7bbb3a64baf884481a1ba0c2f8fb2f93f7c3
change-id: 20250227-ntc_thermistor_fixes-6043c862956a

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>



