Return-Path: <linux-kernel+bounces-294143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C29589EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A1B286721
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEBD19309D;
	Tue, 20 Aug 2024 14:38:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B37191F7A;
	Tue, 20 Aug 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164709; cv=none; b=UZeMsYqQR+6J6AftMJ8U7tXk/F13A6B0NnMeLncFXleqb6e/nRvZhHNNRiBLa8lOF73QQX+QCnagJ0JSr9Mfc8awR1nnl8eXH9gFxEzDjStHLYT1FVRDOHFWQMZgth1BEjpNfIqiH1LzicZYq7XGuH/ijk9mARPP14Dv2vzmcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164709; c=relaxed/simple;
	bh=q5NVI4HAcQwtCLVA8/if75/0TS4Tp/ALcaFHLNqNDS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqtztPQ5EOZHXVp08Dl73JI8Vwdof2TBD8ZUocOvDuDVEcUSSSniqERcNx3GpCVOfIoyMnlrr5+PPEDk2E2m1bHZpVsEOa3KUkGjZnT/xbvrFxXDC+0b5CJ4gyymEgEFDxlLVjNm1TI7hNZk/EPS0kF7u5UPsn1k6oOUGmwfv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23C10DA7;
	Tue, 20 Aug 2024 07:38:52 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 105AD3F66E;
	Tue, 20 Aug 2024 07:38:24 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Simplify with scoped for each OF child loop
Date: Tue, 20 Aug 2024 15:38:11 +0100
Message-ID: <172416464915.3593062.5473582110150459312.b4-ty@arm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816151407.155034-1-krzysztof.kozlowski@linaro.org>
References: <20240816151407.155034-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 16 Aug 2024 17:14:07 +0200, Krzysztof Kozlowski wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
>
>

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: Simplify with scoped for each OF child loop
      https://git.kernel.org/sudeep.holla/c/a8bd37e64560
--
Regards,
Sudeep


