Return-Path: <linux-kernel+bounces-224313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E8912096
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9FD1B23384
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E185116C856;
	Fri, 21 Jun 2024 09:30:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF8B74416
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962251; cv=none; b=lna4VeEuFnm4Mb0BMiIH+tZTVDKFTtnpDt/hOBkuGESHgaMN2RQxjzF6I5P7FE2ROEBfTZFXQgddYPlRAHs9HnCoG9mgU8lle9b/tUCuXL0KGIKgizkDlambEMZMgE1EE41j2Pnak7xsFfcSciiGDHMjBkA7qoA0oQfKKQgx7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962251; c=relaxed/simple;
	bh=WWAQ4GNvq+NKBwplU/KGHnEWsVWR7AkhF/LbXL2GU9g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9x/YTebFc7xwbM2e1XwdDjmqrS48ryNrYbhh1I+1msZgttJ97eo8kmaS2LpaDctvkwd4V39W1A2DNFLiNap0S3whfTDAC1r1G9RyXwYZgfo9xUibrj+PRxVtObgLX4RVuwqPDKsJ6UJYEMKvjCfdyl64dUhsFpZm6tbxpUNWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7EB4DA7;
	Fri, 21 Jun 2024 02:31:06 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E13F93F73B;
	Fri, 21 Jun 2024 02:30:40 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
	James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: constify the struct device_type usage
Date: Fri, 21 Jun 2024 10:30:31 +0100
Message-Id: <171896220490.1280825.11225025335339899792.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219-device_cleanup-coresight-v1-1-4a8a0b816183@marliere.net>
References: <20240219-device_cleanup-coresight-v1-1-4a8a0b816183@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 19 Feb 2024 10:43:05 -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> coresight_dev_type variable to be a constant structure as well, placing it
> into read-only memory which can not be modified at runtime.
> 
> 

Applied, thanks!

[1/1] coresight: constify the struct device_type usage
      https://git.kernel.org/coresight/c/4dcc0f95ca2a9738e5e4e3bd7571fd95a9cbf272

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

