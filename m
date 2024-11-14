Return-Path: <linux-kernel+bounces-408766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 048B29C834F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8A5281806
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4971E9098;
	Thu, 14 Nov 2024 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNO5ojrt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C470818;
	Thu, 14 Nov 2024 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731566535; cv=none; b=k+yABgnAmxnhoQgfs87AvKl/B0OENs7JflRlAsI8kBLmg7hdKPhCoFL6Q2a7LfZzT3dd8n5iAac9uwerLcgNW8XKZl1puPDaDEHjXwEMYJdDFfWzYevDB6rX35QDOY8RHPu1y3aco+Vl8fSAbJ1D2DYnPgqfAbcY3B7oVOUQkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731566535; c=relaxed/simple;
	bh=ZeHYBZ4Nery06bhN+Gy5knhveilAqTyywBrFkeUelnI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k+vcNZsBwzIB0fMtsvhHoyfaUDBjpFPK7cynKbXGbhc40Jpyx7eoHzJLXZ09izB/4w3jNx0NJf+asI8cVZJZu8NyZLSHw8YEya2voyVRFSRHsDM/L1x9/xrjowLP4jXu75F4dPH688wINqWa8+zJUAPF7GJyMQ+LV4VXLKS/45I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNO5ojrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D31C4CECF;
	Thu, 14 Nov 2024 06:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731566534;
	bh=ZeHYBZ4Nery06bhN+Gy5knhveilAqTyywBrFkeUelnI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RNO5ojrtLFVhvAIpVzHwQ4PbyHbUsdKtpRMee+zjpxOs1xScDZLGejFrxSPQu8wHM
	 OzQsYfPeamn/n1E3gZIR2z9x22ZMnKXlxx/MTvmWBc/4IagfDm7aRQkQY89VjDJqpa
	 iJgOSQCDnuFVDki/uY+p5CkDwahhJBZhMZVerapjmpwwIx+o9yDvZM8Ou1rp71AUlb
	 5x+A5IpP/diPJnXmFHGNoF4f5X8cvW9rUtP792c37PV4uGmhhreLzJ2EbjOcYcUd/7
	 af+DwzSmR1QIB4u020iAvazK+FOqBBMMu17oHt2BWWEEavWoizaHrG2VvVB0O8YGjU
	 U9kw0Yoen5Lmg==
From: Vinod Koul <vkoul@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
 sanyog.r.kale@intel.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20241112125646.590240-1-ckeepax@opensource.cirrus.com>
References: <20241112125646.590240-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH RESEND 1/2] soundwire: Update the includes on the sdw.h
 header
Message-Id: <173156653203.203801.13084267525490990874.b4-ty@kernel.org>
Date: Thu, 14 Nov 2024 12:12:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 12 Nov 2024 12:56:45 +0000, Charles Keepax wrote:
> There are quite a few things used in the sdw.h header that it relies on
> the consumer to include. If something is used directly in the header it
> should be included by the header. Update the includes to cover the
> missing items, or add forward declarations for things that are only used
> as pointers. Whilst making the change also alphabetise the list of
> includes.
> 
> [...]

Applied, thanks!

[1/2] soundwire: Update the includes on the sdw.h header
      commit: e311b04db66aaed1819bdd479d42c4f338f105b9
[2/2] soundwire: Minor formatting fixups in sdw.h header
      commit: dd690b31de0ed46adc5856698880560b900386ba

Best regards,
-- 
~Vinod



