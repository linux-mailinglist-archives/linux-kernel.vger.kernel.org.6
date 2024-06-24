Return-Path: <linux-kernel+bounces-227755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568AC915647
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE891C21066
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51FC19FA98;
	Mon, 24 Jun 2024 18:12:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5719F464;
	Mon, 24 Jun 2024 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252721; cv=none; b=WCOGar/6VJ9gQIxbVkgKfSnADNM/Grec3wRPLe50/1JVxLnZM2aKg2j3gOLr0Q/ltL2/Am88G6r8EaFOP7XgHQnDYc2fhg0HXAVsC4YaNuxQ2sf8Mk49zQi0qHUgvf0mXCjLatey1VVgQTCidKmXkzR8fDuL4GcGey/8OZfK6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252721; c=relaxed/simple;
	bh=RQDbIYi19+Jky+cs770r4H1n1B1wGc0FyZDD4MnxZvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EodnsEae+dB3SjsE6r+24G5QnXwjahgzzYrsV+mU+0BBuN7P2LzbSvZOiU1U5aSdXXLuRA0r1gBoy/X6ue2nfkDQjBB55GxNzzurpJ4EpbBSvdSk3yrzffiIxQ6XcTalFwrtEaV3SuuhHHK3zOgtnhAQHLbDXop25WQ8+Md6YsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C51C2BBFC;
	Mon, 24 Jun 2024 18:11:58 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Youwan Wang <youwan@nfschina.com>
Cc: Will Deacon <will@kernel.org>,
	guohanjun@huawei.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	rafael@kernel.org,
	sudeep.holla@arm.com
Subject: Re: [PATCH v4] ACPI / amba: Drop unnecessary check for registered amba_dummy_clk
Date: Mon, 24 Jun 2024 19:11:56 +0100
Message-Id: <171925271239.3100160.14267274522294659491.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624023101.369633-1-youwan@nfschina.com>
References: <20240624023101.369633-1-youwan@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 24 Jun 2024 10:31:01 +0800, Youwan Wang wrote:
> amba_register_dummy_clk() is called only once from acpi_amba_init()
> and acpi_amba_init() itself is called once during the initialisation.
> amba_dummy_clk can't be initialised before this in any other code
> path and hence the check for already registered amba_dummy_clk is
> not necessary. Drop the same.
> 
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI / amba: Drop unnecessary check for registered amba_dummy_clk
      https://git.kernel.org/arm64/c/bfe3f0df3e3c

-- 
Catalin


