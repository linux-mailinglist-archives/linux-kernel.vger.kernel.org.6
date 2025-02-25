Return-Path: <linux-kernel+bounces-532017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D53AA447EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425CF882A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BB519ABC6;
	Tue, 25 Feb 2025 17:10:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72D8198831
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503402; cv=none; b=cPkQ0ZyVLWmV+1PO/58AYpiPbkaPZ/U9bSvD46rgIQimZAF+kNPcWaOalfoEuLbm3zZSAiOAfz7MRsSZKYaP4a1fiaph7MhpynDQ9Bqw5wOZZJ6Js/TYwsXJP90Y6MLaEMJDC59uPr9Z5dSwUQOvS0bAjwpL8sjvalbtJQxbGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503402; c=relaxed/simple;
	bh=kxGP3K4mdd11/lyrRm5yjaOJQ5oMDjJcHnMsobaoZO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kf7bAwnIdx/Dw44Nbzqzrp8aq18PmYDZELhbv7m4b6OPbMSRtqBGvwPni0mKemYDxPXSb0PHejuCkEfrt9DFvfnc9J3VWdxYG9Wapc/G+Pwh9HPqzXZ/BfJbtU9sfgCRRsptZGPI9leDRYoiliMQu5Vz9i1jeglEAGZzs9dMvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D6D51BCB;
	Tue, 25 Feb 2025 09:10:16 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B1B23F5A1;
	Tue, 25 Feb 2025 09:09:58 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND] coresight: etm4x: don't include '<linux/pm_wakeup.h>' directly
Date: Tue, 25 Feb 2025 17:09:50 +0000
Message-ID: <174050337860.1543266.5427475115330100876.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250210113635.51935-2-wsa+renesas@sang-engineering.com>
References: <20250210113635.51935-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 10 Feb 2025 12:36:36 +0100, Wolfram Sang wrote:
> The header clearly states that it does not want to be included directly,
> only via '<linux/(platform_)?device.h>'. Which is already present, so
> delete the superfluous include.
> 
> 

Applied, thanks!

[1/1] coresight: etm4x: don't include '<linux/pm_wakeup.h>' directly
      commit: b2d67616fcf9f0a21940b2ba8d80af2fb0c81bc1

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

