Return-Path: <linux-kernel+bounces-515258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBF3A3628F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D723B3132
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57716267F53;
	Fri, 14 Feb 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB8GSzH+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921DA267B93;
	Fri, 14 Feb 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548664; cv=none; b=fbvuY39/Fe1xUqrOHKPemqLREBcHnTapdg3TRBU9g4OdUSecun/ukRyFyH9HJwbETOlO0xzUacShi6my7pXdJGvefv3ctEtizoujaNJ4ivraTnOH3IuRkZr7mIeDOAZ3w9LQT2RZP+fIw+sojRtKaVX0KXHbsxGVvaaRJQP8npw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548664; c=relaxed/simple;
	bh=v1WR08AE5CQqOnR8ISmiWg8KMk9RyvrCOO0/gEgkyDE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NGgUewngBpP6Wki69nyQyWm68rZcoBhZH6jpkz6He8L1Eoe+itJlVcQjBL3qX9Y3PguqXjKgUo+CCYAbGQDd+tIbdg78gu6hGPeWgz8fyoCchVjI9JI1MBK5Pr+6BgpOQpvkLAbjNZgOG7XTA/IhbMSufwUu+dsLidWcVo9q2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB8GSzH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0137AC4CED1;
	Fri, 14 Feb 2025 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739548664;
	bh=v1WR08AE5CQqOnR8ISmiWg8KMk9RyvrCOO0/gEgkyDE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NB8GSzH+ONAH5lFdkG1Ty1rF+1xLzpdbZUXs78tiM1qvGHUrbRAA8h+ZdZtaI8hJ6
	 XSyAU2C2N06dYYPm/mnw1nbqHQWqqGTTom0Dd1Ox+GCDBafkygI84lCT0wraJKVH8v
	 1JtB/PFflu6Zn4YNyRkxR9eyXKQUyX2gZ53ZUDF6ogSQZEuYml7Frneeq8FaUTZ8Ux
	 CIO8WH8TaCZGR69BavP9rEFizRof3wrP7ciNpBE/nHOKETvJA1MVOGvoMBVIO4GvLv
	 WXb102YnjK33qcWnkyJI2ZoTEzy21RI7gxjMaZvZUaUutHC1AqqEc729FWUwlUzGWL
	 v3fgYZFW1c3Rg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0EFC02198;
	Fri, 14 Feb 2025 15:57:43 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Subject: [PATCH 0/2] arm64: dts: imx8m: Add pinctrl config definitions
Date: Fri, 14 Feb 2025 16:57:41 +0100
Message-Id: <20250214-pinctrl_defines-v1-0-fbc86a42ef3c@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVnr2cC/x2MQQqAIBAAvyJ7TlArhb4SEaZbLYSJRgTS35OOw
 zBTIGMizDCwAglvynSGCrJh4HYbNuTkK4MSqhdKdjxScFc6Zo8rBcxctQaNX7R02kKtYqri+Y/
 j9L4fbhIcqWEAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739548663; l=1365;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=v1WR08AE5CQqOnR8ISmiWg8KMk9RyvrCOO0/gEgkyDE=;
 b=PZmKXcESL9UNqXoct8RAJHd6TdzLVVn9O/CXE6fXNCm6ETGyIGhid8rlHWVZWigHGukjbfOXY
 +PilzN3VEcgBrxiR62CJ0Eyuhw8Tfr9yqxoFvcT8Oz7GPn6WhgMpQD9
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

At this point the patch is not complete, some pinctrl definitions set
bit 30 (0x40000000) but according to the reference manual this is a
reserved field, I currently have no way to identify what the meaning of
this bit is, I hope someone in this CC may be able to provide an answer
to this. It will then be fixed in the v2 of this patch.

It should also be done for the mn/mq but I currently do not have the
reference manuals for these to verify these fields, though I can only
assume that they would be the same.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
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



