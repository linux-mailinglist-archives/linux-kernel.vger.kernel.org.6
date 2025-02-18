Return-Path: <linux-kernel+bounces-518897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E5A395F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B590C174C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31AE23F275;
	Tue, 18 Feb 2025 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eshHsXGD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C5123C8D3;
	Tue, 18 Feb 2025 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867962; cv=none; b=P7ZIiv4hGbGVNN/rXyPkL/4elFEW/W0Lx6dStItjX5L7lSfDXYO3t1RWStNLtsGiI2vI9tiF7LBVcNHHgZ3Rv8J9f6SpfHKqOAbNt3uWZLwn/LcR7HCyfvUYZEcVCLLniYhvasR43kE8hmHjizk4IvfORzCdd+QDzHh3bIG1fhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867962; c=relaxed/simple;
	bh=SPcl/UOhW/cy7ZS6G7DShHFIAuQPHxxo6CaqutmigeY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MMgOQogKg7JM5CpXS95D/2KLowOgoiuZc/RlzwWxQvYleJSOjVJzOpbThxh1tfidhPUEPktVyXQXoIwtEnJ7cgt6LDgFrc5dW2hMXgSoysq3BV7Y7G3p/9owNZG33GesGjBpHGa3/6r/TFRnx2lNCMoFfqiWAT0kh5nDfu9N4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eshHsXGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DA3EC4CEE2;
	Tue, 18 Feb 2025 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739867961;
	bh=SPcl/UOhW/cy7ZS6G7DShHFIAuQPHxxo6CaqutmigeY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=eshHsXGDvwxrSHeRVtLo5ST1o2VIA+LPzeg+O23XxmbRPQaCqxz+dECGnfzd10GoT
	 VrGLz6yhKsbKKDyUO1toIM6l0sAMP2BuNkSRjXs1chd8KHT3OV1tj+Yd2ltVeX1vJk
	 agB8ZtSlxSseQLdPtOjWI+/V63wBOAFiu78ezmFP+AtEtRtFSC1hjlKMXptdzUZvYZ
	 fjXcdY9keTg2m6neiFESrVSGChyx6yBnsfBRLLJ4fbchv87RN//LvLLNej1AWaUnmb
	 9CzAGitAygkWr9qqHaA2U2dGtJz1o3XjtvS/1pErLvatCZ/zO+0qqmIFizhB2tFexn
	 ihbTCIOqHnhzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62117C021AA;
	Tue, 18 Feb 2025 08:39:21 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Subject: [PATCH v2 0/2] arm64: dts: imx8m: Add pinctrl config definitions
Date: Tue, 18 Feb 2025 09:39:15 +0100
Message-Id: <20250218-pinctrl_defines-v2-0-c554cad0e1d2@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADNHtGcC/3WNwQqDMBBEf0X23BQTbSw99T+KlLhudMEmkgRpk
 fx7U+89vhnmzQ6RAlOEW7VDoI0je1dAnSrA2biJBI+FQdXqUivZipUdprA8R7LsKArVdNSNg5a
 oDZTVGkrxPoyPvvDMMfnwOQ42+Uv/uzYpamEHvGrTKrIN3ieP3qXgl+WM/gV9zvkLPCtAqLMAA
 AA=
X-Change-ID: 20250214-pinctrl_defines-237e7db61c6a
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739867960; l=1173;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=SPcl/UOhW/cy7ZS6G7DShHFIAuQPHxxo6CaqutmigeY=;
 b=WjUzSixqXZo3HZ5py+rVjBFU2osjMWLtfUUHAw7i8UoIHjvmiDZBG7dchTMK6tDDJuAFt7mBp
 bdZCkawsCreCnrG+Jeq20itLp9IenEbjYO9c1fOUCt/qGdErcDKwJjs
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

Up untill now the extra function mux (pull resistor, etc) has been
defined as a raw hex value, this is difficult to interpret. Add
definitions for these parts of the pinctrl registers to allow for more
readable pinctrl definitions in devictree files.

It should also be done for the mn/mq but I currently do not have the
reference manuals for these to verify these fields, though I can only
assume that they would be the same.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
Changes in v2:
- Changed mystery bit to SION
- Link to v1: https://lore.kernel.org/r/20250214-pinctrl_defines-v1-0-fbc86a42ef3c@gocontroll.com

---
Maud Spierings (2):
      arm64: dts: imx8mm: Add pinctrl config definitions
      arm64: dts: imx8mp: Add pinctrl config definitions

 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 27 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h | 27 ++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
---
base-commit: 0ae0fa3bf0b44c8611d114a9f69985bf451010c3
change-id: 20250214-pinctrl_defines-237e7db61c6a

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>



