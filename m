Return-Path: <linux-kernel+bounces-441141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E219ECA3B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E986188C795
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1AA1EC4F4;
	Wed, 11 Dec 2024 10:22:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F511EC4DF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912570; cv=none; b=GASiddMPPHQSC/hBLExhwsUogJz9ZN7QHchlJOJaSXHpkcKjZ8s/yK7X0WPyfgFvokewDzbY/d9nSe3xY/kV5WDHmSHvIZvWdyG/s9yxdap7xzZXFYKuvjiat+JNqN/SDFRo3EsNlVTFjMK5CJgTpZVjSOdSpt1mu/Z2S20UWy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912570; c=relaxed/simple;
	bh=E9aXYKBZK9WUC8dvtyK5ZLTtyfqzv0Ndk5xM6XUt5dI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clzD/HkJToUgOnh5JzvRiJG9prcdHEb0OAaiZcUUc6XWw57OypvDZadheZKlyE2WbfEHf1gZOiARTOFgY5UEuAhz8yPBMtaB5+kVe1/g6Yp3zj00q6DX67wyajFcDJpI6m//oVn1c2dUSd0EwFK7lrKn/t5/yBDRUYta8vWKn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBA661063;
	Wed, 11 Dec 2024 02:23:15 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B60C3F720;
	Wed, 11 Dec 2024 02:22:46 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	alexander.shishkin@linux.intel.com,
	mike.leach@linaro.org,
	Pei Xiao <xiaopei01@kylinos.cn>,
	james.clark@linaro.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] coresight: Fix dsb_mode_store() unsigned val is never less than zero
Date: Wed, 11 Dec 2024 10:22:41 +0000
Message-Id: <173391254211.561817.4532591708453721807.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <122503017ada249fbf12be3fa4ee6ccb8f8c78cc.1732156624.git.xiaopei01@kylinos.cn>
References: <202410150702.UaZ7kvet-lkp@intel.com> <122503017ada249fbf12be3fa4ee6ccb8f8c78cc.1732156624.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 21 Nov 2024 10:40:03 +0800, Pei Xiao wrote:
> dsb_mode_store() warn: unsigned 'val' is never less than zero.
> 
> 

Applied, thanks!

[1/1] coresight: Fix dsb_mode_store() unsigned val is never less than zero
      https://git.kernel.org/coresight/c/d4276259f3a57131291d879b53fc05863c6b59fa

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

