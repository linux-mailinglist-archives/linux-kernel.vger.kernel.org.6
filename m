Return-Path: <linux-kernel+bounces-560895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9640BA60AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CC916CFC2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF1F193436;
	Fri, 14 Mar 2025 08:03:11 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3A89A1531C4;
	Fri, 14 Mar 2025 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939391; cv=none; b=iZ/10yg8dricqAks0CLriXhFKoGchGt2ABIbUqNS6dXIYZxaCWvggbO/oj3MTmSNqc0qDq2FW3Qra2zUzCqepmxUm4jSvQMRfFvvdKeK2f8EtJjHRvwqHGNAc8UhoWjJsdrrtyobhAY3SUwO+uqP8vtrwLt01BOOGqlYZZJUJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939391; c=relaxed/simple;
	bh=VeTroO5Nyk85K7mCtGdJSJF15GYwdgFSLlY7rwuPX+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=XQATFTj82l5bt/1iFNrOjvliAdaqb2c60LvAiR6j2s9pwvm9O8ZrSOkvjlMWxJ7ttz9WC1EpW30mq0MFLfp63KkLHRUxZwwqgGkQQp1jmhulM/kCz04DuQCaGIGWkrms9C3OzKja1jRV7WmWCfS9s16oTyu5W0Dx+k4/x+RGX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from liqiong-suma.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 81287606B2728;
	Fri, 14 Mar 2025 16:03:05 +0800 (CST)
X-MD-Sfrom: liqiong@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Li Qiong <liqiong@nfschina.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>
Cc: Li Qiong <liqiong@nfschina.com>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] usb: gadget: udc-xilinx: Remove the invalid comment
Date: Fri, 14 Mar 2025 16:02:49 +0800
Message-Id: <20250314080249.469307-2-liqiong@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250314080249.469307-1-liqiong@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function don't return value, remove the invalid comment.

Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index ae2aeb271897..fa94cc065274 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -2178,8 +2178,6 @@ static int xudc_probe(struct platform_device *pdev)
 /**
  * xudc_remove - Releases the resources allocated during the initialization.
  * @pdev: pointer to the platform device structure.
- *
- * Return: 0 always
  */
 static void xudc_remove(struct platform_device *pdev)
 {
-- 
2.30.2


