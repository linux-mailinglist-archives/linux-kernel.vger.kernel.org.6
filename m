Return-Path: <linux-kernel+bounces-397712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4047D9BDF65
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045AD28146A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296851CC8BA;
	Wed,  6 Nov 2024 07:26:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2D3192580;
	Wed,  6 Nov 2024 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730877990; cv=none; b=LCUEm0uhVPDWvy4t7NNlKzti+H9KHpBFRyz0A1fcLAw2hlax/NzYFnhckkjn5DpLHHkrSI5lTEbwDQyMM2AqpkAKdsyZzWaf4S87H3v+RDNP9cRJGreRCN0dMEfEesT365Bq47D4esisUYul6OP54/1qsPsSCNAhjJpfNxeaAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730877990; c=relaxed/simple;
	bh=agWYiCuHzgWc5vrawK4mbYjZ0dJtAHhRDMutt9drTh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kD1cOi8NYffpjC3XUESJjuq+3AXM+I+QlOnandA5M3sxSlScr9uBp1pJzhHlnZjuJRHMKV3XIDzyafTX+xV+OO3GF8Vp126rJ94+lHu5389GViaNQ+JgXzAlyKV+yX1MKZ0ABmnZqPWwcjMLRaNy2H3ucfEuSQazUoyomlAX8hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD9681063;
	Tue,  5 Nov 2024 23:26:56 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D06E83F66E;
	Tue,  5 Nov 2024 23:26:24 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
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
	dan.carpenter@linaro.org
Subject: Re: [PATCH v3 0/7] Expose SCMI Transport properties
Date: Wed,  6 Nov 2024 07:26:21 +0000
Message-Id: <173087788054.3975719.458271006715771508.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028120151.1301177-1-cristian.marussi@arm.com>
References: <20241028120151.1301177-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 28 Oct 2024 12:01:44 +0000, Cristian Marussi wrote:
> SCMI transports are characterized by a number of properties: the values
> assumed by some of them tightly depend on the choices taken at design
> time and on the overall archiecture of the specific platform: things like
> timeouts, maximum message size and number of in-flight messages are closely
> tied to the architecture of the platform like number of SCMI agents on the
> system, physical memory available to the SCMI server...so on and so forth.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/7] firmware: arm_scmi: Account for SHMEM memory overhead
      https://git.kernel.org/sudeep.holla/c/5c14f38893d0
[2/7] firmware: arm_scmi: Calculate virtio PDU max size dynamically
      https://git.kernel.org/sudeep.holla/c/3229e33311f8
[3/7] dt-bindings: firmware: arm,scmi: Introduce more transport properties
      https://git.kernel.org/sudeep.holla/c/5654d37268bc
[4/7] firmware: arm_scmi: Use max_msg and max_msg_size devicetree properties
      https://git.kernel.org/sudeep.holla/c/c091de2d383a
[5/7] firmware: arm_scmi: Relocate atomic_threshold to scmi_desc
      https://git.kernel.org/sudeep.holla/c/112ffc78dc8f

(The below 2 were applied as fixes and sent for v6.12, sorry I missed
to send confirmation earlier)

[6/7] dt-bindings: firmware: arm,scmi: Add missing vendor string
      https://git.kernel.org/sudeep.holla/c/7bf46ec090b9
[7/7] firmware: arm_scmi: Use vendor string in max-rx-timeout-ms
      https://git.kernel.org/sudeep.holla/c/54962707f8b8

--
Regards,
Sudeep


