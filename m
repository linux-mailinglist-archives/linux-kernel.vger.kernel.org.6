Return-Path: <linux-kernel+bounces-190742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27C88D01F0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825FE1F28E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E93D15ECC5;
	Mon, 27 May 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="VFUUUdy/"
Received: from out0-202.mail.aliyun.com (out0-202.mail.aliyun.com [140.205.0.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F62815EFA8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817249; cv=none; b=oCkg2FocK+x07/ly+6w3qf+QTF07cde4smpAjntJl6Ej1xrgMMdlzPCn3qXOqZ5aL2L7zz4/CLjVivwfvWgBbmgOQ+iQ0RX5qxra8zIHo9PZbTFRwEPCXZfIOqlQVDRfOPrTf7QYBib7zPYoz23kXLhL/JMMnsJN2FBPmLZDxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817249; c=relaxed/simple;
	bh=RYS+FgGO9UrWCqJu7HWZ9d2YKIT0iSXdUZ6GcTIo0vY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tBkuKj8rAnSpX0r4J8BQv9SKw9lKHg3aeHgPG7j0g4n3DF+qcg5Ev3yKM6/ZG4bDBgcGccsomT8VxhMipfUXkIRFnLGTwtfE0KCpg7g5wtXRQEnTA3gKvlnMW7C3H7cjPKG3tKmoz471ZUnC6wHYnT6wMWx87iG70HxZB8pPJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=VFUUUdy/; arc=none smtp.client-ip=140.205.0.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716817237; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aOG5sDL4+n/6vB0Gs1mPrD/Q3yrLIbZZVjloyGDfu8Q=;
	b=VFUUUdy/S30tc1RGf9/4lCPNmbd3CEuDoKSYeQVT4yMPBQu4vY1MbSyqjuAWVebguZ6nSWZkh9ydPhGamyNvi1qUafbcK7ZqfRNqevD6+SiC6/0D92FhjXXezE6NsQpOUX2r4T+mdfhRV5QLFjMZpfGJmkCr5pa+zgtxFU4T0K4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037135125;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XofsrFK_1716817231;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XofsrFK_1716817231)
          by smtp.aliyun-inc.com;
          Mon, 27 May 2024 21:40:37 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 0/2] um: Remove some dead code
Date: Mon, 27 May 2024 21:40:22 +0800
Message-Id: <20240527134024.1539848-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tiwei Bie (2):
  um: Remove unused ncpus variable
  um: Remove /proc/sysemu support code

 arch/um/include/shared/kern_util.h |  1 -
 arch/um/kernel/process.c           | 67 ------------------------------
 arch/um/kernel/um_arch.c           |  3 --
 3 files changed, 71 deletions(-)

-- 
2.34.1


