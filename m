Return-Path: <linux-kernel+bounces-360667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F56999DED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2D4B21C49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9AE20A5C1;
	Fri, 11 Oct 2024 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZVl1pSq8"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0004F209F32
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631824; cv=none; b=EB3CnZrDNV8AVo7zyX7C7HpUOyLdLawqSJKISuYyravoSUsRax4p4nhJFA2KjdBCHNRGp6yM+drX1X21muSA37nYc18rc7JeFPniPVBA0dImTVtK/H6r5Nwl9tyRlE2S8d2+8lSQHJePlgPVngYUyrzknRY41Lv32R/+VyRv1zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631824; c=relaxed/simple;
	bh=o34aJKY2qFL66oB9ISEsPLxD0VohBKTCN1NagdkXBac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PMXL2kGPfqfmPEDDpu0s55PL/7YRV+HmPkpVwiKMrbTJrcRPSJwr7hOueIFNknq0hHaaRDQIrI1a9xlq3aVosCVUI76h4WIl9Xvmt77UZ5gcVLbkoxEy05i+FpDGmtsYhvgu54DInAJDj4MD6QL4IBF0PlQM5t+vWYaqKnlD+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZVl1pSq8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D634A220;
	Fri, 11 Oct 2024 09:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728631259;
	bh=o34aJKY2qFL66oB9ISEsPLxD0VohBKTCN1NagdkXBac=;
	h=From:To:Cc:Subject:Date:From;
	b=ZVl1pSq8bVb7SMj7dITdlXsO8GPbYOEiyjfrxURSmBaWn/Miujt0LmPh1ueqtlex4
	 Lj44I88aeClIWor35oNfHe8FrDgAL3ETmOSG4YojzAOANFBJVN4mejCQG50nulG2hK
	 tolq6fFwXbX5aBZRsJiSKbMWMamBvEOUTtA+LE2k=
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
Subject: [PATCH 0/8] staging: vchiq: Lower indentation at various places
Date: Fri, 11 Oct 2024 12:52:02 +0530
Message-ID: <20241011072210.494672-1-umang.jain@ideasonboard.com>
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

Umang Jain (8):
  staging: vchiq_core: Locally cache cache_line_size information
  staging: vchiq_core: Properly log dev_err()
  staging: vchiq_core: Do not log debug in a separate scope
  staging: vchiq_core: Lower indentation of a conditional block
  staging: vchiq_core: Indent copy_message_data() on a single line
  staging: vchiq_arm: Lower indentation of a conditional block
  staging: vchiq_core: Lower indentation in parse_open()
  staging: vchiq_core: Lower indentation in vchiq_close_service_internal

 .../interface/vchiq_arm/vchiq_arm.c           |  34 ++--
 .../interface/vchiq_arm/vchiq_core.c          | 185 +++++++++---------
 2 files changed, 111 insertions(+), 108 deletions(-)

-- 
2.45.2


