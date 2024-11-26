Return-Path: <linux-kernel+bounces-422085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 125439D94AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27817B2B9EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505911C0DF3;
	Tue, 26 Nov 2024 09:22:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EADCA6F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612942; cv=none; b=keViUttROlG+GbVOEPTufkriQcJoERGJ4znC5mgGT15p4XNsWpl3y4sNCukUYTXdXw6RSIuCYdnXB1Igc96LgEZfyEmoh9+y1DQwsHaGexCMA4sbVMAjKjfr8NmnqmxCtkztd2NLtOieEIV5ak0AbA/yjMwJviEDdo1XfRfH/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612942; c=relaxed/simple;
	bh=tbNO8qwwTMQ8v0nEBu+LUXPeItxjOx76oDm+Y6OPnR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LEa6FijR0Z51rizW35WkdQ5DD7FppcVZ/U2Aau3hF0I0zXwTUIlsOqAul51/HdD/enHVF+1ksJNgiomnsa/nUAhWrrnFM3fosncx9FJvGAMRcZWjWLAsGy4a3zwKV1QfBcJec46YeTg1ystOjdocvYX4+IGcdTVtZjbIlI9JoR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1tFrlu-0005u8-Fj; Tue, 26 Nov 2024 10:22:14 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1tFrlt-000DzI-1Y;
	Tue, 26 Nov 2024 10:22:14 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1tFrlt-00B5zE-1s;
	Tue, 26 Nov 2024 10:22:14 +0100
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Subject: [PATCH 0/3] ARM: dts: imx: add phy-3p0-supply for i.MX6 series
Date: Tue, 26 Nov 2024 10:22:12 +0100
Message-Id: <20241126-v6-12-topic-imx-3p0-regulator-v1-0-c618ed111c75@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAESTRWcC/x3MQQqEMAwAwK9IzhtoYxX1K8seikYNqC2pK4L4d
 4vHucwFiVU4QVdcoHxIkrBl2E8B/ey3iVGGbCBDzlqq8ajREu4hSo+ynlhGg8rTf/F7UHTODJW
 nyreNgXxE5VHO9//+7vsBKs15XW8AAAA=
X-Change-ID: 20241126-v6-12-topic-imx-3p0-regulator-440d5a25a980
To: Shawn Guo <shawnguo@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Stefan Kerkmann <s.kerkmann@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The integrated usb phys are supplied by the 3p0 regulator, which has a
voltage range of 2.625V to 3.4V. Thus the min and max values are
corrected and the regulator added as a proper supply for the usb phys.

This fixes the following warnings during the probe of the mxs_phy
driver:

mxs_phy 20c9000.usbphy: supply phy-3p0 not found, using dummy regulator
mxs_phy 20ca000.usbphy: supply phy-3p0 not found, using dummy regulator

The regulator handling was introduced by commit `966d73152078 (usb: phy:
mxs: enable regulator phy-3p0 to improve signal qualilty, 2024-07-26)`.

I have consulted the reference manuals for the affected SoCs but only
tested the changes on an actual i.MX6Q SoC.

Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
---
Stefan Kerkmann (3):
      ARM: dts: imx6qdl: add phy-3p0-supply to usb phys
      ARM: dts: imx6sl: add phy-3p0-supply to usb phys
      ARM: dts: imx6sx: add phy-3p0-supply to usb phys

 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi | 6 ++++--
 arch/arm/boot/dts/nxp/imx/imx6sl.dtsi  | 6 ++++--
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi  | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)
---
base-commit: 7eef7e306d3c40a0c5b9ff6adc9b273cc894dbd5
change-id: 20241126-v6-12-topic-imx-3p0-regulator-440d5a25a980

Best regards,
-- 
Stefan Kerkmann <s.kerkmann@pengutronix.de>


