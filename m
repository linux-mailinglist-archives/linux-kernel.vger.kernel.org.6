Return-Path: <linux-kernel+bounces-217074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1116C90AA42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F33F1C20860
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B27195B09;
	Mon, 17 Jun 2024 09:44:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F9C19581A;
	Mon, 17 Jun 2024 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617491; cv=none; b=DDy/JUyc6uC1t+nSk+Xnj7hU+ejf3YRyPgYeOvQDHW4KsG3h/GL6L5eUmOHMe3bYZZaEXMLxFqFC0oqMdeDAsDW91STGiavFgNonGFIEiZAwbdLgShrwTGPp91igWPZq0gsePBvSGW2zt/RtcEhYFbacMQx8JPpmL1STOYnvU6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617491; c=relaxed/simple;
	bh=qzWcrmVR9SF9WNBEBQYTWODTARg9fts7Iwv8F/4rErs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnABzFN37IeLBjPDnNNBZE8zycMuXI1NCDPBYvVAzszHtqC21sqvxBjtvzNa7fxi0xrYtXcHowqpWoNmZpQxgVnPLTlz5SwOpopsfqTx9UsEBTIPqd8FA4vpuyuqkIATAHo3QwCHQFFiHiwLpnqxV4uNxEHAASgo/jCveOy76MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C137DA7;
	Mon, 17 Jun 2024 02:45:13 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 925763F64C;
	Mon, 17 Jun 2024 02:44:47 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bus: vexpress-config: add missing MODULE_DESCRIPTION() macro
Date: Mon, 17 Jun 2024 10:44:38 +0100
Message-ID: <171861739736.3837092.17769464285114999756.b4-ty@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613-md-arm64-drivers-bus-v1-1-e8162434e0ca@quicinc.com>
References: <20240613-md-arm64-drivers-bus-v1-1-e8162434e0ca@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 13 Jun 2024 15:05:33 -0700, Jeff Johnson wrote:
> With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/bus/vexpress-config.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>

Applied to sudeep.holla/linux (for-next/vexpress/updates), thanks!

[1/1] bus: vexpress-config: add missing MODULE_DESCRIPTION() macro
      https://git.kernel.org/sudeep.holla/c/c12bb561df45
--
Regards,
Sudeep


