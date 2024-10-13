Return-Path: <linux-kernel+bounces-362772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE3F99B92E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB6CB212C3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D48B13A3F4;
	Sun, 13 Oct 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TtoE8TDG"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEE713C8FF
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728818499; cv=none; b=QWGTiL53jhQDQlGOozn6njBDMyGFLkZFSB6GelPBT/W7AHj1bo4Ll1jmW74dgQOpnfiUZOmkkL9LzzDKtGAOp4IdR1r23YFZdmNOtcHN0MZUbVXHTBC5RqkHhnjx5kTpe3UT9QYeRvo0JgrraFkdJdqKd5J2mq4Xwh6QTI7x6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728818499; c=relaxed/simple;
	bh=aEqNrPaE63M64VMK/rPodTd8i4FSi7lNmVtMM001xQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyMVSc58alxpGe4hMdOKfZKX98HiWbdasHA1rjciD7WaAVJb7QrEHqMMTc683aBREpiizxOXTRLfCzA//jIj/QM76UC2jFhVyGK8kTwwSMeLtLwyQozpQIbBX+mOoxj0Nd02LVMmS1s2h/Z+QTtbBRpGYeWPlTJGYpRK9IEoB/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TtoE8TDG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B7E7582E;
	Sun, 13 Oct 2024 13:19:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728818395;
	bh=aEqNrPaE63M64VMK/rPodTd8i4FSi7lNmVtMM001xQ4=;
	h=From:To:Cc:Subject:Date:From;
	b=TtoE8TDGiwX5eaZl/D+kkfQIj9kkzX5cdEMoEEQtnbPF8FZh6bR6lD44CHaXW6Crs
	 rJcoZMEzFcy53qXgVoHvc/88bbWL7vxGILUTJxYKRzDJTlufPjyY8dZ4csZTdnH4wh
	 YOx77U7RdGk6mh1cOS+9aj4jf/Z4RBohpwepVBG4=
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
Subject: [PATCH v4 0/6] staging: vchiq: Lower indentation at various
Date: Sun, 13 Oct 2024 16:51:22 +0530
Message-ID: <20241013112128.397249-1-umang.jain@ideasonboard.com>
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
                                                                                
Changes in v4:
- Improve return value from service_notify_bulks(3/6)
- Drop 'service' and 'bulk' null check from 3/6 

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

 .../interface/vchiq_arm/vchiq_core.c          | 184 ++++++++++--------
 1 file changed, 99 insertions(+), 85 deletions(-)

-- 
2.45.2


