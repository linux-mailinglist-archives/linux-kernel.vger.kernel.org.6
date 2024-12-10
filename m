Return-Path: <linux-kernel+bounces-440066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B519EB83A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE15A1883DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F359E23ED5B;
	Tue, 10 Dec 2024 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VcaCLNHg"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198723ED42;
	Tue, 10 Dec 2024 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851705; cv=none; b=ohHRaY3p5CldcOWcJeB2JIR+JtlwRdMB8oRXunxqXkjSvx/bRCmH7CnzrAFkg6hQaWcdus0GbOWhrtacMBFAxN2P5loEKCFTgejO7/IducYkMpPF8c95vIkNEs3Z2we3qyge4jRiN4KrK5SkEEYGHqj1q/muGq2jl0kEw3xQlyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851705; c=relaxed/simple;
	bh=L6WG4spZ8FT3pGXZRfmizOkV+CwkthcP7mF0Kylh0HE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tScll7oxWwsDZIDCdLUf5IrtF8EF6nyFafRRrmiW90IKnT8rGpDDgQo5/rhJzXgT+z7B/hzxwl0EXafs3edD/tT8NFJC+s4/GVQZKbj4+6P1uvkpfwarUcYmbp8+sn3jThX87vItCaZfQWBkyzZVsjtCMsDwGhyOxemduWTXtX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VcaCLNHg; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C3A01C0003;
	Tue, 10 Dec 2024 17:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733851701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r/lwH/9FFZhCHPOhzFsV+WkNAhCphb56D0IaE/dZeYY=;
	b=VcaCLNHg5ogDTdxM7wRTzF5sqhLZpmb/8OsCRVj55l2ExpzcH/dEYfq7r6vXYHU5NRcEfS
	5p69xwYR/bchT9cmiuBvGYTrXGenQwcXIVkfY6BkfJ8DXO/gIigjHvn+6kSmdcpo7HRrGx
	Qu/5D7rDpOu5Ejfk2cqy++XwAnsgkLeF25bDojNUboNX7ltzVzRDpgmmPel+niLQe8Lbb8
	nwLZUMgxE3E/J5m1BDwXYRv4A9pP9wMuP8y+3xgXYaHKhzDvZoxWw47n6bmImO1BSIbGp7
	b0hCLTo0TOHMFdDgHuvUM2vbye8rTABEuMI5h54HC4pWGjUVEO1fyUvJmWkJMQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/2] drm/panel: simple: Add Tianma TM070JDHG34-00 DT
 bindings and driver support
Date: Tue, 10 Dec 2024 18:28:02 +0100
Message-Id: <20241210-tianma_tm070jdhg34-v1-0-9fb7fe6b6cf0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACJ6WGcC/x3M0QpAMBSA4VfRubY6mxPyKpKGg6OMtiUl7265/
 C7+/4HAXjhAkz3g+ZIgh0vQeQbjat3CSqZkMGhIG40qinW77eOOFW7TuhSkShyHmggHXRKk8PQ
 8y/1P2+59P+I8cvBkAAAA
X-Change-ID: 20241210-tianma_tm070jdhg34-60cb8440b164
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: luca.ceresoli@bootlin.com

This small series adds DT bindings and panel-simple implementation for the
Tianma TM070JDHG34-00 7" panel. Due to how the datasheet computes the
blanking time, a quirk is needed in the timing implementation. A comment
documents that in patch 2.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (2):
      dt-bindings: display: simple: Add Tianma TM070JDHG34-00 panel
      drm/panel: simple: Add Tianma TM070JDHG34-00 panel support

 .../bindings/display/panel/panel-simple.yaml       |  2 ++
 drivers/gpu/drm/panel/panel-simple.c               | 42 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)
---
base-commit: 2ade8304e5fce7b972ef46011946186f1466c9bf
change-id: 20241210-tianma_tm070jdhg34-60cb8440b164

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


