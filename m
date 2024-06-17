Return-Path: <linux-kernel+bounces-217081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABCB90AA52
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FFA1C25141
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AE21940BD;
	Mon, 17 Jun 2024 09:51:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81830374D9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617866; cv=none; b=RnV1Sreny+Ld9gNwgTpS7mc49lL6Eu3nRY2loiE61rlA+/YIndYhsAp8GhVA+vPMGgJocFC95qAJdjOCGwx0Z2WolhKSToDYvGxxTBHThdf6g4hKxK68hXfgQuf1bSC+g/eTGhkOrom2iQQv6SRFgwf3cUykPcyCosi8Hu9WUaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617866; c=relaxed/simple;
	bh=3R0nTs6O5PhndHMcTpE37d0XDdK277N2G4j0rNnP+a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdkKbbLRmoXbBxhj1gM7JhIr0lpAQsRbJ10TMnaGvilUrK7QJ17XFFAgqFiJJOtTRwENAoPjsbCIgTYNoi5Zlyf1ZcEMjSqXSD6/nB/CvIGF20qrWH2oYL6WDPFGYOJdkNfs+mP9rweUOb+np6xXWKTJ2JpUEiU5f+IX+Zym6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1A89DA7;
	Mon, 17 Jun 2024 02:51:28 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1EFCF3F6A8;
	Mon, 17 Jun 2024 02:51:03 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: cristian.marussi@arm.com,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] firmware: arm_scmi: power_control: support suspend command
Date: Mon, 17 Jun 2024 10:50:59 +0100
Message-ID: <171861779718.3838118.16128730459518862706.b4-ty@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240428075105.2187837-1-peng.fan@oss.nxp.com>
References: <20240428075105.2187837-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 28 Apr 2024 15:51:05 +0800, Peng Fan (OSS) wrote:
> Support System suspend notification. Using a work struct to call
> pm_suspend. There is no way to pass suspend level to pm_suspend,
> so use MEM as of now.
>
> - The choice of S2R(MEM) by default. The userspace can configure whatever
>   default behaviour expected as S2R, if issuing suspend from userspace.
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: power_control: support suspend command
      https://git.kernel.org/sudeep.holla/c/dd22cc907a74
--
Regards,
Sudeep


