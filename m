Return-Path: <linux-kernel+bounces-207964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2277901E93
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB8EB26BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D5D768E7;
	Mon, 10 Jun 2024 09:47:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB416F2F6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012866; cv=none; b=nu3eYUhTnu8hwFKgnn1u6QIGaoFjR+jBSowof7BejvOcXwcTzpa04HmuAKIxgwm5hGt6e0JRIqBImLuljEO6mSLPMhCBV4axEEeD+2ZYnICyKImDWPDaC3obc0Hk4uKQMcCwZBGTxKVqX8d+LqZlaN+mAWXJXEGXyPjwWYhWzzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012866; c=relaxed/simple;
	bh=9IL3cQ5/zl/e0XV39fimsLW0cSRnQMIFA9WWBIkK854=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAGIXptbmOiX6p4gqLlwfetR7j0VtB8k/sRbqEaMKI+AkYYn/wPZSJ2WXkeS8FQQZop8xHcnE23OX8yVF1V8NrEXy5xYSjHda7/288jyDJepJgQbLBfxKXeGQB9bYZMPQHCy5NLz2QtLFIZ+TWUj7WZ3gczkinuf5tdWxKTXNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51EA71688;
	Mon, 10 Jun 2024 02:48:08 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9C4313F73B;
	Mon, 10 Jun 2024 02:47:42 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Yang Li <yang.lee@linux.alibaba.com>,
	mike.leach@linaro.org,
	james.clark@arm.com,
	alexander.shishkin@linux.intel.com
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] coresight: tmc: Remove duplicated include in coresight-tmc-core.c
Date: Mon, 10 Jun 2024 10:47:32 +0100
Message-Id: <171801275290.708723.17726295168762441849.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506011121.39179-1-yang.lee@linux.alibaba.com>
References: <20240506011121.39179-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 6 May 2024 09:11:21 +0800, Yang Li wrote:
> The header files linux/acpi.h is included twice in coresight-tmc-core.c,
> so one inclusion of each can be removed.
> 
> 

Applied, thanks!

[1/1] coresight: tmc: Remove duplicated include in coresight-tmc-core.c
      https://git.kernel.org/coresight/c/b9b25c8496019402ecd64ddc5ae56f9bd97b12b2

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

