Return-Path: <linux-kernel+bounces-541629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1A4A4BF64
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68B23B4CAA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33020C001;
	Mon,  3 Mar 2025 11:49:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B4420B7E6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002543; cv=none; b=C8IQITl0o+OTyUgu9lG2Xn/L/H6AXBTj9HADReC46xOQnZgoyhxdAM+zIDgtMhXUqryiLMEBldwnUqBdd/5wartYktTn71HIzJI0I1UZNxhI4B2+HKullVhvB9AJZwYxcrYLTJC6k2A5H132FA3jcmhS0U9+qnJ/u8ipJ/a/2jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002543; c=relaxed/simple;
	bh=9s6g6Db4LACTEFBTUnj4MQyh/l8NCZzFTDha+qRJRhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rc41IPzMQdMMwnbtA+jBuJl0cg1B9qAW5yc/T+o3bpKnKRbYoVPK+bxhLdfelY+ANcLxGgSIwQB1lN1XsPNhkxVrLIYvMUYjnCAApOj5/dK0DifJXrWRanwYHRS5FIGkPrK19k+czAf5XJ1r/kstXRsv2oLW9c+t61mjXux7MtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D6781063;
	Mon,  3 Mar 2025 03:49:13 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A6FC83F673;
	Mon,  3 Mar 2025 03:48:57 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_ffa: Set dma_mask for ffa devices
Date: Mon,  3 Mar 2025 11:48:45 +0000
Message-Id: <174100249569.1456.13505107409018325740.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e3dd8042ac680bd74b6580c25df855d092079c18.1737107520.git.viresh.kumar@linaro.org>
References: <e3dd8042ac680bd74b6580c25df855d092079c18.1737107520.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 17 Jan 2025 15:35:52 +0530, Viresh Kumar wrote:
> Set dma_mask for FFA devices, otherwise DMA allocation using the device pointer
> lead to following warning:
>
> WARNING: CPU: 1 PID: 1 at kernel/dma/mapping.c:597 dma_alloc_attrs+0xe0/0x124
>
>
Applied to sudeep.holla/linux (for-next/ffa/updates), thanks!

[1/1] firmware: arm_ffa: Set dma_mask for ffa devices
      https://git.kernel.org/sudeep.holla/c/cc0aac7ca17e
--
Regards,
Sudeep


