Return-Path: <linux-kernel+bounces-526335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2D6A3FD59
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2EBE7AD187
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119F62505A0;
	Fri, 21 Feb 2025 17:24:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAC62500B4;
	Fri, 21 Feb 2025 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158650; cv=none; b=opBPjHEkR/MH9+BbTC0HOCX8RCy+NdDC3Ium2nPVFOQUQIJj9TbMdkPkt9N+1TtTD+E6PoazPyuZQ+cZ+6cnq/OgpuDmGY0O54/6R64LNiG6QsWrwnVjfYC41tpPqWtcQ8IUyKUJGwosAcJrsLYz9ptbFSxIIFwl+m8OCiTtVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158650; c=relaxed/simple;
	bh=j7DFQPotp4Vqr2JBZ7TyctB+9WYJfxxMmaYhACfvQ2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfHNLahKUu5ObnxLsXDBlHYhcaDCYkwXL9P+dPbf/jlrywnAfHxeBlCYJI+PRq/X6hnyZOJJv40okacNyOA7jrINZwCPSROjEO5yUOfqp2hh9N0yxC9dEFxO6d6j7NjBQEDXJdHDRltcH9kZPV748bz5IAeBCx6nBRFU28VBmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF2A0168F;
	Fri, 21 Feb 2025 09:24:25 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67E243F5A1;
	Fri, 21 Feb 2025 09:24:06 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: mike.leach@linaro.org,
	James Clark <james.clark@linaro.org>,
	Linu Cherian <lcherian@marvell.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	devicetree@vger.kernel.org,
	sgoutham@marvell.com,
	gcherian@marvell.com
Subject: Re: [PATCH v14 0/8] Coresight for Kernel panic and watchdog reset
Date: Fri, 21 Feb 2025 17:23:44 +0000
Message-ID: <174015834099.1418247.14151654370992096221.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212114918.548431-1-lcherian@marvell.com>
References: <20250212114918.548431-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 12 Feb 2025 17:19:10 +0530, Linu Cherian wrote:
> This patch series is rebased on coresight-next-v6.13.rc2
> 
> * Patches 1 & 2 adds support for allocation of trace buffer pages from
>   reserved RAM
> * Patches 3 & 4 adds support for saving metadata at the time of kernel panic
> * Patch 5 adds support for reading trace data captured at the time of panic
> * Patches 6 & 7 adds support for disabling coresight blocks at the time of
>   panic
> * Patch 8: Gives the full description about this feature as part of
>   documentation
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: arm: coresight-tmc: Add "memory-region" property
      https://git.kernel.org/coresight/c/87b8166a
[2/8] coresight: tmc-etr: Add support to use reserved trace memory
      https://git.kernel.org/coresight/c/91a2086a
[3/8] coresight: core: Add provision for panic callbacks
      https://git.kernel.org/coresight/c/46006ceb
[4/8] coresight: tmc: Enable panic sync handling
      https://git.kernel.org/coresight/c/6dbcbcfc
[5/8] coresight: tmc: Add support for reading crash data
      https://git.kernel.org/coresight/c/d58a70bd
[6/8] coresight: tmc: Stop trace capture on FlIn
      https://git.kernel.org/coresight/c/942bbeea
[7/8] coresight: config: Add preloaded configuration
      https://git.kernel.org/coresight/c/4b7e6262
[8/8] Documentation: coresight: Panic support
      https://git.kernel.org/coresight/c/b47d1fcd

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

