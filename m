Return-Path: <linux-kernel+bounces-294149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2594C9589F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581A01C20EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E28019753F;
	Tue, 20 Aug 2024 14:39:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F2191F60;
	Tue, 20 Aug 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164786; cv=none; b=qHCRNhmg8pWxlo26TY6fTQfAaipNf2Q3kR3JiJ9jSgZ56t4v4zXsednuFLBo91NhmDR7ro1lWzkSUa0IUwQ3v/0f7+cjMFZHeH0w3TNpiw0RrMJcDxYW/ajP7CkhRNahVZ49CrSKWXxDmwvLGfD7DaFdn4gEzPpgiCyj+9+lj6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164786; c=relaxed/simple;
	bh=89RIhsW4nTga9NWGWnqZi1F3DOcM2Qxzirqp1rQ77XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFn4dXocLUyNXBqRkpd8/BR62n6gT//mtzktJo5CZKXKnvmpMsonSBwfx71GOkpq1Ys3MjVhyCcnCWteSt0zeuHdN1cceSu2zrPIlh6gxfIa9LGPfw6mzDJKh3kyx4voLjRdrDd/s1ClLV9gdktFH6W6rIGdfZ8SFdQrYIb3lL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79603DA7;
	Tue, 20 Aug 2024 07:40:09 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E0E0F3F66E;
	Tue, 20 Aug 2024 07:39:40 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	devicetree@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH v1 0/6] Add SCMI transport descriptors
Date: Tue, 20 Aug 2024 15:39:35 +0100
Message-ID: <172416453556.3592662.3061783820427391222.b4-ty@arm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240730144707.1647025-1-cristian.marussi@arm.com>
References: <20240730144707.1647025-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 30 Jul 2024 15:47:01 +0100, Cristian Marussi wrote:
> this small series is an extended version of this recent, already reviewed,
> series [1] posted by Peng to add a new arm,scmi property to describe some
> platform-specific SCMI timeout constraints.
> 
> On top of that, this adds 2 more properties to describe a couple more
> platform-specific transport characteristics.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/6] firmware: arm_scmi: Remove const from transport descriptors
      https://git.kernel.org/sudeep.holla/c/668f0cb2337f
[2/6] dt-bindings: firmware: arm,scmi: Introduce property max-rx-timeout-ms
      https://git.kernel.org/sudeep.holla/c/3a5e6ab06eab
[3/6] firmware: arm_scmi: Use max-rx-timeout-ms from devicetree
      https://git.kernel.org/sudeep.holla/c/1780e411ef94

--
Regards,
Sudeep


