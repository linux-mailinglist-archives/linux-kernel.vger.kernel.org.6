Return-Path: <linux-kernel+bounces-367296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4B19A0093
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416C5284E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA6418BB9F;
	Wed, 16 Oct 2024 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz/IpAon"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC51171D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056475; cv=none; b=QFnkhI+uuVjYR0JK8gizQtTEY2fa96ZE2FnCq77wHNAXGRZ+ikFXVjAIwtb2VnLL7EKYejWtHejWPNzONtYty228YPRms8Bh+D7ZioNhVfzQvYwqa8duSmVFFoqGJPywudNCAWal8SeD733rdCOtOW4EMHyQDQHqVeEYLXeJm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056475; c=relaxed/simple;
	bh=k/9QINLSbdSjYGrTTg5WRlQWOp49gEYmT3PRfFhXFD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rZkdZ2WuXTeKF8DRFTEn/YFcNvxNnLXWx1xUZDvozQNF+w6Hqld9v/19iJAXIhbZWLYGGrIJa92wuk/dHzf5bYsHW+Hy8Q4YWyhJBsvHnNWK/s2VmFy5RL7a3C90shYdncwlydbCVzjzdY6onPjiojBeWZfA9rMJpm5h3XvJjZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz/IpAon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22623C4CEC5;
	Wed, 16 Oct 2024 05:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729056475;
	bh=k/9QINLSbdSjYGrTTg5WRlQWOp49gEYmT3PRfFhXFD4=;
	h=From:To:Cc:Subject:Date:From;
	b=nz/IpAonenIaXRj+4TWKuXrAb57EJQi+QOtzqQD2G/38WyjXq5VK6xJ6nWH+J7Sdd
	 MEfkX09gLyZaxvz8tVheHl9cafN7msMO/rog9KhGVEbwPAKjGP3uDJe2SmCyE/uQmz
	 pbK8Zk2bibUwX7OoV+CwOKqOiHJ9XURABPV5KHbDI2Wr6NQpFNp4YduMmth68KwXCr
	 JyfLmGTB3itlc6G1ErbdtBBQAyPFvleQnUQHhOXDuugTfFdtilNX+jSnerh5ITjn8s
	 Bv1H/SgG/0j8WRNDCE4v109BkOyaU2asICX/+acIrftHF7vuDXqlcfipLqFcaqwYt2
	 WCvNCX6ndXBRg==
From: Vineet Gupta <vgupta@kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 0/3] ARC fixes for 6.12
Date: Tue, 15 Oct 2024 22:27:46 -0700
Message-ID: <20241016052749.1640081-1-vgupta@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Changes slated for a near future rc.

Thx,
-Vineet

Benjamin Szőke (1):
  arc: rename aux.h to arc_aux.h

Paul E. McKenney (1):
  ARC: build: Use __force to suppress per-CPU cmpxchg warnings

Vineet Gupta (1):
  ARC: build: disallow invalid PAE40 + 4K page config

 arch/arc/Kconfig                     | 4 ++--
 arch/arc/include/asm/arcregs.h       | 2 +-
 arch/arc/include/asm/cmpxchg.h       | 2 +-
 arch/arc/include/asm/mmu-arcv2.h     | 2 +-
 include/soc/arc/{aux.h => arc_aux.h} | 0
 include/soc/arc/mcip.h               | 2 +-
 include/soc/arc/timers.h             | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)
 rename include/soc/arc/{aux.h => arc_aux.h} (100%)

-- 
2.43.0


