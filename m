Return-Path: <linux-kernel+bounces-361101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E896699A36F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 270E5B24ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E98C216A36;
	Fri, 11 Oct 2024 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oBiHrpr6"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0516D212F13
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648623; cv=none; b=g8DA6/TYcqg0vWddEGWJZpTCrw6X6HnYrQK5PCyDRo+S/LtHnSLKUpb2eE2UPNgt4mMofcwdYoq4MaAK+Ka63TkmOZe+tbaKQB05JLoFcqlQPVhdlxJU2MhI/jd62cTvia2PKi+cRGbcFDNG6Ve8KWAOGU0rVIRzvcDd/8rCnQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648623; c=relaxed/simple;
	bh=vx4WR4R4LG+rd3IuLKKinXlGCHuqZugPdpVo1nLj4yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIkqApANrzV/7liJJIw1M3xwmmYhz0BpS0K9ay7tI44oQnT4MPnbHsi1NLrWC9lwdTqlv+l2yFXYy02lE4y82WwZ67Mn8QuIbjzGgGuXBKpM6WCS9sL5d+a7UwUNyf3FJkznbmOXj9ROdXeX9DliuXGWzAt34z/25IJ6Cq7Al5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=oBiHrpr6; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 469E78D4;
	Fri, 11 Oct 2024 14:08:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728648521;
	bh=vx4WR4R4LG+rd3IuLKKinXlGCHuqZugPdpVo1nLj4yk=;
	h=From:To:Cc:Subject:Date:From;
	b=oBiHrpr6GbtbQSdfgKQTEi9LXDB9gI9l96n77L893lDsRQpMQvkiAkBhkTcPdo2lc
	 PGoBFv6uM8bd7pvT0p4zo2KD7mVYZ0ggnLhkhzjCYw5lhoDsW/METjCZA1AU1XrizF
	 gdESlNQRkB6QLUh3d39fP/795JpRwOqL3Pk1y8pk=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 0/6] staging: vchiq: Lower indentation at various places 
Date: Fri, 11 Oct 2024 17:39:04 +0530
Message-ID: <20241011120910.74045-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Series is attempted to fix few alignments issues.
Also, it aims to lower indentation of various nested `if` conditional
blocks without introducing any functional changes.

Changes in v2:
- Assimilated fixes from v1 which can make independent progress
- drop following patches from v1:
  - [PATCH 2/8] staging: vchiq_core: Properly log dev_err()
  - [PATCH 6/8] staging: vchiq_arm: Lower indentation of a conditional block
  - Will be handled separately
- Rework 4/8 from v1
  - Now included as "staging: vchiq_core: Refactor notify_bulks()"

Link to v1:
https://lore.kernel.org/linux-staging/20241011072210.494672-1-umang.jain@ideasonboard.com/T/#t

Umang Jain (6):
  staging: vchiq_core: Locally cache cache_line_size information
  staging: vchiq_core: Do not log debug in a separate scope
  staging: vchiq_core: Indent copy_message_data() on a single line
  staging: vchiq_core: Refactor notify_bulks()
  staging: vchiq_core: Lower indentation in parse_open()
  staging: vchiq_core: Lower indentation in vchiq_close_service_internal

 .../interface/vchiq_arm/vchiq_core.c          | 189 ++++++++++--------
 1 file changed, 104 insertions(+), 85 deletions(-)

-- 
2.45.2


