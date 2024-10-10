Return-Path: <linux-kernel+bounces-358770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C38998376
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85811B22484
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A9A1BF7F8;
	Thu, 10 Oct 2024 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ijTxbKUf"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A551BB6BF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555808; cv=none; b=RAr0wDJXm/AODyyJZLu4qNPS0WbeuXVBfP38rSz7kCaQNYEZazl0mYs3VNMvaINdhm2MW5hgtXpurlF0VJDXmq9ExYTuRHsKEoTgVIiUSBQRNB5SftM6Q5uR9wtGqCOnR7P/jyYyPZaxX23oz24IOZP3LA3WPDBPUkDGhIXlhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555808; c=relaxed/simple;
	bh=BTBxOvVuTM6WsUy711z6oEamya74MHIMHKK3ovmyR4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rVEbpsm6Rd5F6VHwi7fJ9Orl/hh35U5SKNmeMRTrtxUg/WG/cFwzH0GE5Yg4B4hZjTH3fHApdA2A003QnJm2kLkET7tg3QB3KO4fq71xs2R8kfzI2N5cz2W4rXaCy+tnX9B8Pe0KpIWYjvLYFw2eRGTt+bOxK7ICKvPJfAsfsFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ijTxbKUf; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6D6BF4D4;
	Thu, 10 Oct 2024 12:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728555698;
	bh=BTBxOvVuTM6WsUy711z6oEamya74MHIMHKK3ovmyR4U=;
	h=From:To:Cc:Subject:Date:From;
	b=ijTxbKUfolk9+TdYDRxKJfqsraL6NR9T44Q50tG6RBqO90JJXEG8oqaVAXlyqE4hH
	 5N0hbGmXngsuaNBkppBnVrD+obRaIAGNExoJrS8QFgTTgqBVnJIkAcAFWqS41QzxLe
	 0dD7I3zz6R7F5NcR/MFysQGwemEbROBxSILsI3Tg=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 0/5] staging: vchiq_core: Improve indentation
Date: Thu, 10 Oct 2024 15:52:44 +0530
Message-ID: <20241010102250.236545-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Small self-contained series to improve indentation on vchiq_core.c.
Mostly addressed by reflowing code long lines under 80 columns to adhere
to coding style guidelines.

The dev_dbg() statements are left untouched. Followed the principle
mentioned in the guidelines as:

```
However, never break user-visible strings such as printk messages,
because that breaks the ability to grep for them.
```


Hridesh MG (1):
  staging: vchiq_core: Fix white space indentation error

Umang Jain (4):
  staging: vchiq_core: Indent static_assert on single line
  staging: vchiq_core: Reflow long lines to 80 columns
  staging: vchiq_core: Macros indentation fix
  staging: vchiq_core: Locally cache cache_line_size information

 .../interface/vchiq_arm/vchiq_core.c          | 317 +++++++++++-------
 1 file changed, 194 insertions(+), 123 deletions(-)

-- 
2.45.2


