Return-Path: <linux-kernel+bounces-199086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E888D81F6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E8D1F261B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56682128835;
	Mon,  3 Jun 2024 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn0sYgQ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C79012839D;
	Mon,  3 Jun 2024 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416683; cv=none; b=RrrfTZrxd8kU8QEZI2yjuAZ49HKZpyBKu+k4/fskECHfiNsFPNOIcjBKonte7X24oSaNAlwacfozPJRiG2+svjs9tdmOPFPJzfwx0K+u6DwhELHU2N9oKJV01b0iiv2lk34SF3zZG/7SUZEuqZov2VBvVEasQqkCfnfVDtWLhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416683; c=relaxed/simple;
	bh=Z1VQcOBfabeFNBfEE96dXjrYsDFp4g9Bz7gyu+XOLAM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XNEGPPzPiWC8ADpwNcz117Vrs54i3BrgMo9Mr6nuac6HjJzZZur36PY0oFd1I/JfrYAooGAwq86fDycbtgKw8n/+QIFZ3eGr8anPYhkHxAvBNuPEP1AksjoimC726ahscDSRxsCqhSKcGnaFRoLZBcSxo5xTETQ2AseyXaQXgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nn0sYgQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46E7C2BD10;
	Mon,  3 Jun 2024 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717416683;
	bh=Z1VQcOBfabeFNBfEE96dXjrYsDFp4g9Bz7gyu+XOLAM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nn0sYgQ31pMNGzTzXasWppWF4nBr/6FA+ZNYdtGfLWzWWnVHRnqY6UvdHorvqrzdO
	 tUlknxX5P+NKjxC1NhRp0LqjQIf6o2fSlPTH6W4nkS/NlU9tRxCodyGu+/+ABGmdJV
	 CHqRBnATkmFuHGt9wLquPUr8oHbKLa22A4FQB+7iK+hBlWCEhp4mmTn+gvbFOaNGVi
	 5pBIZRDLxszopBg6dg7nOU2w9TXmkQBsRF6m3GVAAJXMX38lZBi6MV4FQ1fbgcjQE9
	 D5nnB5V/ztamwclNQmrdxLV90g5Jo0yFqaP1fZ92Nj3Jpl6P2HJqClL7T9NFKUZaYg
	 BK4TNKlg3rzsA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240603070240.5165-1-yung-chuan.liao@linux.intel.com>
References: <20240603070240.5165-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: intel_ace2.x: add AC timing extensions for
 PantherLake
Message-Id: <171741668141.28073.5332128212277671708.b4-ty@kernel.org>
Date: Mon, 03 Jun 2024 17:41:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 03 Jun 2024 15:02:40 +0800, Bard Liao wrote:
> The ACE3 IP used in PantherLake exposes new bitfields in the ACTMCTL
> register to better control clocks/delays. These bitfields were
> reserved/zero in the ACE2.x IP, to simplify the integration the new
> bifields are added unconditionally. The behavior will only be impacted
> when the firmware exposes DSD properties to set non-zero values.
> 
> 
> [...]

Applied, thanks!

[1/1] soundwire: intel_ace2.x: add AC timing extensions for PantherLake
      commit: 9b5fd115e7d5a98b82054cff5c96f6768ee06845

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


