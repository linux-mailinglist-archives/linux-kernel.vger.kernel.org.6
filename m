Return-Path: <linux-kernel+bounces-420763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 616D59D8315
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E71B2E714
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E118191F7A;
	Mon, 25 Nov 2024 09:52:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CBB190067
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528376; cv=none; b=Kawo/dwTyDv+W+0fFdqoyrf2LxGHwXDc0fHStFpsdwSFkfIDZ9owdYg390y/6cpY5tioFek3IHwJVf9+77n3ekMEBvQaeYQTe+rZmepcYMiVTlA9GRI/UabSOBV66nzLwWYZqD6L23gw4B1mSupd/1vZ0Qo097mCRw/gkT67+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528376; c=relaxed/simple;
	bh=+e2sK3b2ZrGIZ7146JHoms4l1NTZw4VPh8lfGme3RjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XXsctGeMrmWaAOtXPWce+qe+w04p4/VDlJBxQJE7IBXmvgKSsM9FsE/NfI1R9zExLWEXzhoXfHhIMLG/RRw0LLUCPzNqFoKUpWckbbnfSiXeSQ0FHGVV7xpWCtxM1Olfa/y0inxoXg7upAaYC4iZISXzWlssD6CLpoPw/7ZHWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 016351692;
	Mon, 25 Nov 2024 01:53:25 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E11523F5A1;
	Mon, 25 Nov 2024 01:52:53 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sudeep.holla@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 0/3] small fixes for arm_ffa driver
Date: Mon, 25 Nov 2024 09:52:48 +0000
Message-Id: <20241125095251.366866-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset small fixes for arm_ffa driver:
    - change ffa_device_register()'s declaration and its return value.
    - add direct message version 2 related properties bits and some fix.

Levi Yun (3):
  firmware/arm_ffa: change ffa_device_register()'s parameters and return
  arm_ffa.h: add properties bit related direct msg version 2
  firmware/arm_ffa: remove __le64_to_cpu() when set uuid for direct msg
    v2

 drivers/firmware/arm_ffa/bus.c    | 22 +++++++++++++++-------
 drivers/firmware/arm_ffa/driver.c | 18 +++++++-----------
 include/linux/arm_ffa.h           | 16 ++++++++++++----
 3 files changed, 34 insertions(+), 22 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


