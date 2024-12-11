Return-Path: <linux-kernel+bounces-440841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D379EC514
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A4218889CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763511C54A7;
	Wed, 11 Dec 2024 06:54:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8BD1C548E;
	Wed, 11 Dec 2024 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733900078; cv=none; b=g0sXV/tozGdAHvqssIh/Zq8OVUObAU4/JRCTSSsAet1dUnwvrd/ycGzU6W7ElpO/7brCZcHH3ovwy7zeQ/ea8DAUfT7HO/eNwIusmFDU8wl5f+aksoK7UUbsq4MestLSXYB9xfuoK6/dy1okChepD0PbDWU6mh0utPzWjSw1xqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733900078; c=relaxed/simple;
	bh=+huKEGhmVFS17Z3fkRfsaiBDXI4gpDpnaw2AxZa0sSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JngIOAT/VQ5PT6XwgtOvpHLo2fOdiVQ4hYDcn8iYoL8E8nIhiLHUSxja6KDYaLSGSDzF2x8GQWHQVFQon7+uTiyE3kZ3g393Y56ba2twiKGU6ildtBZsCDG+P+H+YyFORWtL3OoY8VkH1mRg88TRBdRcksejWIKJKQXQeeWWCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86D111063;
	Tue, 10 Dec 2024 22:55:01 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D341F3F720;
	Tue, 10 Dec 2024 22:54:30 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] docs: arm64: Document MDCR_EL3 boot requirements
Date: Wed, 11 Dec 2024 12:24:23 +0530
Message-Id: <20241211065425.1106683-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds missing MDCR_EL3 boot requirements for debug and pmu
registers that are currently being accessed in the kernel. Please refer
the following link for some earlier discussions on this.

https://lore.kernel.org/all/ZxfOeqyb3RvsdYbU@J2N7QTR9R3/

This series applies on v6.13-rc1

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  docs: arm64: Document EL3 requirements for cpu debug architecture
  docs: arm64: Document EL3 requirements for FEAT_PMUv3

 Documentation/arch/arm64/booting.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.30.2


