Return-Path: <linux-kernel+bounces-528602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D79A41991
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8129216EB81
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEFE24A041;
	Mon, 24 Feb 2025 09:51:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73781A08C5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390697; cv=none; b=sJXrNVGCFsYBJYmsDcsjOnZ87PAwGKR/sGqwikSsx+HRpKI7hn6vjiqKP1lsH1Eyk1MIQ1H9dmtDrRHzVirUJThSczSvzRQ1Ru4A4aLNNbALBPHxJDqDxMhGczDdRHoTTVs3ggFMcsxMHzbEQTVDMWIws8HjaAjMJstYXQScDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390697; c=relaxed/simple;
	bh=oR/VCH37ylXMZC5ykHY0N18dLE/YaUj2dJ89LYjd11Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYIcj+5sB7UgfOIWfyAyUdxRVRK6DGbybbD6swI3bc6zwppHr3YpLZsm/voeWhgDaJxGuCMuJg7i0xyzxNgVbT2buX/Tv9PHpl8jscv9LMiIx2OWSUy5z5oGTSOhWBhWLpPE9aFLFS4iWjCivqxmCccobJXAYHdB2WgKCw0185k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E9A61FCD;
	Mon, 24 Feb 2025 01:51:51 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA6673F673;
	Mon, 24 Feb 2025 01:51:33 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] hwtracing: coresight: Minor const fixes
Date: Mon, 24 Feb 2025 09:51:26 +0000
Message-ID: <174039066430.1495447.13273959809148103257.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250222-coresight-const-arm-id-v1-0-69a377cd098b@linaro.org>
References: <20250222-coresight-const-arm-id-v1-0-69a377cd098b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 22 Feb 2025 12:38:56 +0100, Krzysztof Kozlowski wrote:
> Just few improvements.
> 
> Best regards,
> Krzysztof
> 

Applied, thanks!

[1/3] coresight: catu: Constify amba_id table
      https://git.kernel.org/coresight/c/2ecdbebe
[2/3] coresight: tpda: Constify amba_id table
      https://git.kernel.org/coresight/c/7b6d52e8
[3/3] coresight: tpdm: Constify amba_id table
      https://git.kernel.org/coresight/c/2197cbc2

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

