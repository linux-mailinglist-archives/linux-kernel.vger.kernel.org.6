Return-Path: <linux-kernel+bounces-557581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7AFA5DB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133D73B1C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FFC23E35A;
	Wed, 12 Mar 2025 11:05:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D427A15853B;
	Wed, 12 Mar 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741777501; cv=none; b=lZr4+tJRen9ygsZb3cgpMTjUr6cHZuh4DSRlARhUc4EP4Q0Y6yCDG34NodwQEFCOVzd+wN3C4lf96YIdOw9MxweQyTA+nw5BtXl4N+LPwWus5Amlf84iOZ0uGaWrNMgQBzzZOXWybRaPVJl5TAzXP2V3hd9BFXWj6Z53CNY8Dog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741777501; c=relaxed/simple;
	bh=7CUcSaO/tmNUNdsAI6cmtqududZJwgdush7gbYLKfrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2oz2utceo32R9JCqCeJG4K0w46Flezr/qMSpEWNnInYyQTMRiap71PDcbgWtjFuMaAGw3InBDiaGAC8HsCHHXKsPyQsA6u4OE+bmcIk6PnrCFWT5SctGO5FMyWatm1N/FcsS7Cwh14NfACYfYV+QsdR397CF2bqiBWsxNLVlv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E9D1516;
	Wed, 12 Mar 2025 04:05:09 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED5533F694;
	Wed, 12 Mar 2025 04:04:57 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: configfs: Constify struct config_item_type
Date: Wed, 12 Mar 2025 11:04:49 +0000
Message-ID: <174177747268.10135.1485424994901107067.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1011717e5ed35ec12113a0d8c233823e820fb524.1723368522.git.christophe.jaillet@wanadoo.fr>
References: <1011717e5ed35ec12113a0d8c233823e820fb524.1723368522.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 11 Aug 2024 11:30:20 +0200, Christophe JAILLET wrote:
> 'struct config_item_type' is not modified in this driver.
> 
> These structures are only used with config_group_init_type_name() which
> takes a "const struct config_item_type *" as a 3rd argument or with
> struct config_group.cg_item.ci_type which is also a "const struct
> config_item_type	*".
> 
> [...]

Applied, thanks!

[1/1] coresight: configfs: Constify struct config_item_type
      https://git.kernel.org/coresight/c/b5060c17

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

