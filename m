Return-Path: <linux-kernel+bounces-280956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D530D94D15C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF8F1F21AD3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB424197558;
	Fri,  9 Aug 2024 13:35:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DE219754D;
	Fri,  9 Aug 2024 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210506; cv=none; b=HNAD8cskgQY7y2MAiUcRYKwjHy4oD6V4lAxRhvH1CwSBpVQf3KozwbxXW3L4v3E32xX2tIbs3Lr+dSx5rvxe/6mAXhBUqG1U9sGF/YvIU5x+ICsjPQjV8YulJc01ZLkLF7nDDy9PWWTxVDbw63aYhQDyJfQTLESFlNVEm+XgAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210506; c=relaxed/simple;
	bh=dYj5SIz6WaJp/bbG92IXPT7wb7Ke399kGoA4RC4nPB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOvGQV2mbVJUQPOzGABVSpg84xi1Ob4vOmDooudC/mRXmfHJXvbH1ZgZ5aKrsnW7bizEEqGheYKz6HkmoHcvLtWR8R/LvFzzrphXDVlogdjxIB4F+RhoFjbIH2WE49eSc7VKTsRbdYgZshc2mzt8ZVgCm3/zDMtdShG2T4TSVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A6A813D5;
	Fri,  9 Aug 2024 06:35:30 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 615F83F86F;
	Fri,  9 Aug 2024 06:35:03 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v5 0/5] Add per-transport SCMI communication debug statistics
Date: Fri,  9 Aug 2024 14:34:59 +0100
Message-ID: <172321004444.1571940.3668638256438188452.b4-ty@arm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240805131013.587016-1-sudeep.holla@arm.com>
References: <20240805131013.587016-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 05 Aug 2024 14:10:07 +0100, Sudeep Holla wrote:
> This series adds support for SCMI communication debug metrict tracking.
> I am just sending on behalf of Luke with minor reworks in his absense.
>
> Cristian,
>
> I have retained your review tags, please shout if you disagree.
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/5] firmware: arm_scmi: Remove superfluous handle_to_scmi_info
      https://git.kernel.org/sudeep.holla/c/20c9234d623c
[2/5] firmware: arm_scmi: Add support for debug metrics at the interface
      https://git.kernel.org/sudeep.holla/c/1b18d4295f9d
[3/5] firmware: arm_scmi: Track basic SCMI communication debug metrics
      https://git.kernel.org/sudeep.holla/c/0b3d48c4726e
[4/5] firmware: arm_scmi: Create debugfs files for SCMI communication debug metrics
      https://git.kernel.org/sudeep.holla/c/f6a905eaf6bf
[5/5] firmware: arm_scmi: Add support to reset the debug metrics
      https://git.kernel.org/sudeep.holla/c/bd02b0737f38
--
Regards,
Sudeep


