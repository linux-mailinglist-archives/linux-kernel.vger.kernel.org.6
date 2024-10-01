Return-Path: <linux-kernel+bounces-345503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB398B708
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14531F21ADE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657DC19AD5C;
	Tue,  1 Oct 2024 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="S1EnUpPX"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64AE19ABCB;
	Tue,  1 Oct 2024 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771669; cv=pass; b=sy6CrgVMM4odbrTkOAqLmRI2pd1Yh/t9L6Li1aVsm64jAyMqz6hlvFXymyHfDcXgkCVt0LJvkABSLZ0gsTXNR86w6pVNTgzaYsoGy5iS5Ot2jSJ7LZ8Pzhu0abJewnJgDR2GfiesT1Aw5Ersk2k2uMgM4qw6awG5oV9v5NUzVQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771669; c=relaxed/simple;
	bh=COUjciivA+IVoNjfW4vnbkb7bTXP/csoomqPsizQlOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dq72soPbu3T0nnxbRVKGoMOznpPVycAm9FhXAzEi/xVL9Z0FksucmbwewJUu4/ynneTBANYp+2uPIqsHL/3rvVH3tkvmC2wXn78MphiWXrc8iYRqkzFduy2EciyTImY42iORDatIpJuuBNIblQgMhf9BdK6C9SYWjDwmhSIh/T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=S1EnUpPX; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1727771662; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mDxg+ykHGEj+fqRqQL3N83E4T/J+r+/gK7HEl15BcEbCGxyai2GaKI5GJJ2o4sxNNdnJP7Lxa5xN0zK4gw2UAA3lCLlLWAQX3JMWi9qf37nwYHb8d7Zgw8qc3rUmx1BgDjJMmLdwnviTwv6FWU5Z6fjzVd0fZGZVc6i1DkgUKxc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727771662; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q9UHoLdIy5rG5Z5pAqci9yWxVboWvNcQRzZ7GwJCt0M=; 
	b=e8BULbvv1i6ElRi0QM82LSZsMX5E/3rFmhwOkPRGv2z8gSSH7R4uSSzKJj2JGUXYKq6GbN3qXPHXv/Ke93DYsWiIk06W3B0Qcgk9n2FnWaIsUM5UX5zCSaS5/imf0oHAZpUdgUJnU8J4vmLF1LGhAFr2meDUPLwu3UUWA1QDyYQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727771662;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=q9UHoLdIy5rG5Z5pAqci9yWxVboWvNcQRzZ7GwJCt0M=;
	b=S1EnUpPXrNFzI8qGeH5pTtdafVcjIgar3VL5RnjNZKhazCu5+gwRj6W9BQLgGpyB
	DilkWHpLn/B6cOfctj5ThCuZ2uv/A2W1LoAzvadgxJ+4qSQR9uD5gTNH3sMDzwZzRH0
	ZPnaegf7Vg65LS+N5x1NVWn7NEx7otR8yxLz+Kypt/5eMQL0VzQheCzmDBcI07plqhS
	4jSfogKNT84lkq6sXZFUOjdabWCT1UPcXHQQTSjFXejxPQU/k4LaV1LoQYPmB5azzFD
	c1UkFbPIQ7jCV1KlXo3QDJo0l/ZdnjzXU3JwVzzQuFd+mk2CoREVItoTurn6mi2PO/P
	btlooF8cuQ==
Received: by mx.zohomail.com with SMTPS id 17277716607841008.133023732441;
	Tue, 1 Oct 2024 01:34:20 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH] usb: storage: ignore bogus device raised by JieLi BR21 USB sound chip
Date: Tue,  1 Oct 2024 16:34:07 +0800
Message-ID: <20241001083407.8336-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

JieLi tends to use SCSI via USB Mass Storage to implement their own
proprietary commands instead of implementing another USB interface.
Enumerating it as a generic mass storage device will lead to a Hardware
Error sense key get reported.

Ignore this bogus device to prevent appearing a unusable sdX device
file.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/usb/storage/unusual_devs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index fd68204374f2c..e5ad23d86833d 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2423,6 +2423,17 @@ UNUSUAL_DEV(  0xc251, 0x4003, 0x0100, 0x0100,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NOT_LOCKABLE),
 
+/*
+ * Reported by Icenowy Zheng <uwu@icenowy.me>
+ * This is an interface for vendor-specific cryptic commands instead
+ * of real USB storage device.
+ */
+UNUSUAL_DEV(  0xe5b7, 0x0811, 0x0100, 0x0100,
+		"ZhuHai JieLi Technology",
+		"JieLi BR21",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_DEVICE),
+
 /* Reported by Andrew Simmons <andrew.simmons@gmail.com> */
 UNUSUAL_DEV(  0xed06, 0x4500, 0x0001, 0x0001,
 		"DataStor",
-- 
2.46.2


