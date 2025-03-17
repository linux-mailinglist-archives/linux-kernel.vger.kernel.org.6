Return-Path: <linux-kernel+bounces-563804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8EEA648CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79834167A06
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490EB230BFD;
	Mon, 17 Mar 2025 10:08:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015CA230BDB;
	Mon, 17 Mar 2025 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206089; cv=none; b=hySssBZAQWMATmeFlRRu0ytoIIQXfUYYYDtC5aqOZZ1TarH6cv58kWF1VWiJm/GDcyV2R1jcTBUH1l+WJcbaqXL9uhhAWWl+EzEwBTfiFSarbO7ybmnuMkLqKG95v8503R/ZUa2rTJZjIoi30CNiH/PWdk56KnMdLK4yafQ08sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206089; c=relaxed/simple;
	bh=/a0FhVFZG9wWuI/osDIaEmYGVWYA6H7zYENYT75LbFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBOZSpQ6nYVS5afXAPV8V1mxsxsXgVZaufLSwao/GfpMveHgG90BT+nODeo3t0uLJADOcv9C3hvOI4Eo3pF2n8lC0cQKUwFYW+C2gYEj3tzeNjDp+a/zEfsa/TzQG+mCPBmUS29aajAGm5QsVpw5mmvSqbZoS7sOiIbC5RxI2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E3F313D5;
	Mon, 17 Mar 2025 03:08:15 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D944B3F673;
	Mon, 17 Mar 2025 03:08:04 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Jie Gan <quic_jiegan@quicinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] Coresight: Fix a NULL vs IS_ERR() bug in probe
Date: Mon, 17 Mar 2025 10:07:56 +0000
Message-ID: <174220604251.188899.14799232628969384481.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dab039b9-d58a-41be-92f0-ff209cfabfe2@stanley.mountain>
References: <dab039b9-d58a-41be-92f0-ff209cfabfe2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 14 Mar 2025 13:55:10 +0300, Dan Carpenter wrote:
> The devm_platform_get_and_ioremap_resource() function doesn't
> return NULL, it returns error pointers.  Update the checking to
> match.
> 
> 

Applied, thanks!

[1/1] Coresight: Fix a NULL vs IS_ERR() bug in probe
      (no commit info)

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

