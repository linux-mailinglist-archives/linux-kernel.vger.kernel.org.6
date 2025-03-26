Return-Path: <linux-kernel+bounces-576785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE7A7146F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE863AD2A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5B41B0F0B;
	Wed, 26 Mar 2025 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="A6flIxTz"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255BF19DF66
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983663; cv=none; b=TdxKSDsp71n92hYVj3VCQxiv/VYA5FEYenuNly3pUqSIY08OdGjN039dea2DljIHySzZpUO8zPu5bFHKYDvrOVHxQIMOnbqAX1AkPB94T83464Le27GxRFcIHKQ8zolcEnw+G5sNq3672uuzC2hv/esHg/9MqcYVMlejaN5qRDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983663; c=relaxed/simple;
	bh=o1OW7eMPI7BT9Kuja4q/FC0vO0bwCYy1NuCvSDE5Qag=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=V5Ek0CouRswwWVNpmlCpR6l1+mH0Y1OBp7reZLolcYZrTLmkajB2yVH2ZWK0kDnL4QMTKJPxlEi1ckQOX6cpykS9EMPxv3+LGrYB6K5HHPPOGbyL39yuTYtMPoBHQQfUoaGHy8XgZQpgUQ7XUG1OfrRnEcdKIiMcyHrYnYtAJxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=A6flIxTz; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742983350; bh=11V6Ppzqx37uke9W1v3EMjT5frvAqdD1NpkPS7WBiS8=;
	h=From:To:Cc:Subject:Date;
	b=A6flIxTzH9Eg8+55wZ2eeyN1ffNQg/4IY8p5r3gM1FPVkVnXSdCb4ONgtfVNaCd+Y
	 lJ2ERtJNje4+6xTHC2XO4Fz8TY9UtS3wdl0MfbAoWke3NsJxGQXjTOrpoGfrwTQO9E
	 ftbU0YNOX6zA5ZiX/BTB6bz3qDkSGYK3LYi7aNQo=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 9CB1E93; Wed, 26 Mar 2025 18:02:28 +0800
X-QQ-mid: xmsmtpt1742983348tymg8gqam
Message-ID: <tencent_788D1D0B2D8FF4E718D8627502FE0A949C0A@qq.com>
X-QQ-XMAILINFO: MMvVzQSdFuTpw/8JYyJ3ooYbJzsFXNTv1AzBVLrEzcEDozd7Gi3pxJXXng3JTf
	 4EyF9cys7CNem1txEpdA0W/FqJcoHUOotZzyj9sjtBKblw0YDcUmBbddAjUXNzyClLjm+VSPPY0Z
	 H7xWsuMkfTmJ9lR0gclwtET0zyi2mTsXIQQPHjnQ/eAmMBxQseDA/EAgNB0S4gyxnKHz6zxToGlT
	 tjMe7224lEQuxLFAilMZ789i5APrAo0JxreeMeP+wodSLgLafET17iUlYIZz4ZCPJiQjeZ73mucp
	 +rkMoAUy/CBjbTSKMlc/aV4bPeRcHcIpkVAZdUcdbNQjW9m9d8KnGSLCPG9JcpqI2HQTGfWhAHxO
	 Npd+//ypEMa8h4R70oLh8htZi9GZ3nwj1cNEbRwcDVSMVcOBk/SY4AZjt8Iy0We2GgUzLeebRu/p
	 qBFuiYUp+xFNvt48laKMQ1J6Dr1n+9DonEz4wXFJNmqOfsjqFlC3/vErNAr6gWA0rx5DO5o2PIYp
	 vaog3W+fk7bfDs4U6+ijKX6F4uzGZc8psttgGXbTl30QYtyCCY2qsN6+fTOZj55cjpauP8zopAEw
	 XJmS43XMGNR2otxD5reKGKl6sucBOp77lGRnCSOMxgJTDNyxO/wL+gw3dB4QGlyr/sCE7YYZZz3/
	 CUmzUByLesj+q0wjY5DDMZGwnDes+ndQpZmt6YuiHVaKkwNX8yGCSl4kMC5eKzII09I4Q1mCcewT
	 n38w2IlxgZKp9wiA9RaC/buwz38BSmI0/dRFcs7csJMQzrnaK6nKlVqynXmR0BOFeY5wC6gtcPku
	 kjdADH9/q3d5EHjeWv0FvgC2XupewcexET9C1Lo/S6VdhGZMuUOFHJBSPD2deAjfpjkKE1US/Be/
	 qt8PVzA9rrS1l7N3VmgMZYacoxTAUbuMKK9DfR6SSSvvrOslsk1Txur/5CdU9yM6muEGXG476kk4
	 6RAb8+PoYJ1iUAJsnIOPPwdWYgxB6hAYQ4fHLTFojRgBrUp8w2tcAjgidERJ8NWDZJD/S0eMuXL2
	 bSmbDr+w==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 0/3] nvme: Add sysfs interface for APST configuration management
Date: Wed, 26 Mar 2025 18:02:24 +0800
X-OQ-MSGID: <20250326100227.1306684-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

This series enhances NVMe APST (Autonomous Power State Transition) support by:
1. Adding warnings for PST table allocation failures
2. Exposing APST tables via sysfs for runtime inspection
3. Providing per-controller sysfs interface for APST configuration

The changes allow better visibility and control of power management settings
through userspace tools while maintaining the existing functionality.

Yaxiong Tian (3):
  nvme: Add warning for PST table memory allocation failure in
    nvme_configure_apst
  nvme: add sysfs interface for APST table updates
  nvme: add per-controller sysfs interface for APST configuration

 drivers/nvme/host/core.c  | 24 ++++++++++------
 drivers/nvme/host/nvme.h  |  6 ++++
 drivers/nvme/host/sysfs.c | 59 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 8 deletions(-)

-- 
2.25.1


