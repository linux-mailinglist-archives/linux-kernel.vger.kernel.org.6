Return-Path: <linux-kernel+bounces-362587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3BC99B6AB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DE01F22338
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 18:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06974152160;
	Sat, 12 Oct 2024 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ff3iCAj3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF17084D2C
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728759428; cv=none; b=Df0U/bqs0XD98dQjsEcsvFJktLFxhqIRUnvlH2zGKOo1xmsZ7oA+6hgBCuE21dJs28lRorz/kc+NptylbcBjaZiBgQmZgwhyg3OVsK0mNICwljJ6hCPM3oNs58DP5LqAGZy3TUHb/baMJqj6Q163ECF+3l2hHW74JyBX82Y+TtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728759428; c=relaxed/simple;
	bh=a26KV8+2HQwbi3AQqCU9Ygdw0zExDcAK5X4BypWypEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+Y50e/IdFGro7WNCLc5vCeWw1RpEUFgvBzbM7kfrmIZQV3pAdxGuWUcGIio8TiYs04BrLmAT577k3iVTiLw0a+iIrYe+ZTK+iB7KQ1wYtKg+04uxfD7vN2JzgzHIwSIba6r5EM0bwBOs9hzGmIbX6ps3c/NJ01oUFZ3HMqFv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ff3iCAj3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BBF4F80A;
	Sat, 12 Oct 2024 20:55:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728759324;
	bh=a26KV8+2HQwbi3AQqCU9Ygdw0zExDcAK5X4BypWypEA=;
	h=From:To:Cc:Subject:Date:From;
	b=ff3iCAj3iBcuBzb49fz/K/1SxSX9LVT6QV5AAkKIu04ZHz/s48j71f/m+YIMuz1Er
	 U1yZmDSRcKAq/DkuFS5fwvn6mJAptRdzhMCFwtu/Ct59Evec2CD9GyE+ZYhyvSEIWl
	 +QbUSHkgJIVgyphEaacAR98BTE34yI29hc1IidQw=
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
Subject: [PATCH v3 0/6] staging: vchiq: Lower indentation at various places     
Date: Sun, 13 Oct 2024 00:26:46 +0530
Message-ID: <20241012185652.316172-1-umang.jain@ideasonboard.com>
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
                                                                                
Changes in v3:
- fix status (return value) in 4/6

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

 .../interface/vchiq_arm/vchiq_core.c          | 190 ++++++++++--------
 1 file changed, 105 insertions(+), 85 deletions(-)

-- 
2.45.2


