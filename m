Return-Path: <linux-kernel+bounces-217090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B436E90AA6C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A99028D311
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E1195B04;
	Mon, 17 Jun 2024 09:54:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EBD1802A3;
	Mon, 17 Jun 2024 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618093; cv=none; b=dujkOQSZjI6vy/Yq0Dm9C0/f+nv3azJYCt7Vq+L9N1Dwi6neS+p4MK6Bg/YDqgw2jofsMdtdqEFtptcHUnX7O3M12mDOeanEpFYoL90yDplknpcZTOlRKh+ag5hu9yTerBO2azTaMPbqH40e1TVbsab+qJt4PK8jTOBT9uj3NIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618093; c=relaxed/simple;
	bh=zbqPG0gp5ZxU5141BT5BxHItrND+hYbekrBPwdjSQew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YeKHHswp3hXjbBzFRF5c7KkGJ5y9Vx+NF85ZAfG/OJb+I5/pm36s2VlbQisspNg754cc0xwz/Evsi8kcIAZOkLMIlpyKPg9st2RM57E+mIqgR80vXgb4yVAu2U3S7ijKDsdtRIIgzp+MKqZY4nvPAjQVEewag3racX4MFbG/UwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED07EDA7;
	Mon, 17 Jun 2024 02:55:15 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 020DA3F6A8;
	Mon, 17 Jun 2024 02:54:49 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 0/2] firmware: arm_scmi: add notification completion channel
Date: Mon, 17 Jun 2024 10:54:41 +0100
Message-ID: <171861803257.3838611.17861617197615227720.b4-ty@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240510-scmi-notify-v2-0-e994cf14ef86@nxp.com>
References: <20240510-scmi-notify-v2-0-e994cf14ef86@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 10 May 2024 11:19:46 +0800, Peng Fan (OSS) wrote:
> Per spec:
> Completion interrupts This transport supports polling or interrupt driven
> modes of communication. In interrupt mode, when the callee completes
> processing a message, it raises an interrupt to the caller. Hardware
> support for completion interrupts is optional.
>
> i.MX95 SCMI firmware is fully interrupt driven, so Platform expects
> completion interrupt for Platform to Agent(P2A) notifictions.
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/2] dt-bindings: firmware: arm,scmi: Support notification completion channel
      https://git.kernel.org/sudeep.holla/c/d0398f51ffb3
[2/2] firmware: arm_scmi: mailbox: support P2A channel completion
      https://git.kernel.org/sudeep.holla/c/fa8b28ba22d9
--
Regards,
Sudeep


