Return-Path: <linux-kernel+bounces-236656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5C891E56F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AB7285036
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B2916D9C9;
	Mon,  1 Jul 2024 16:34:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC716D9B9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851643; cv=none; b=D1PqN/hQwca0MDgbb6PQiyCVY0sOUua7DWJfalcBDnr49ZAKZaiYjMkxwYEw1nnxiQ5NEClcoIp02JkMiJrSFR/+v6DDsbLP7R+ljrhW1mRuX/PSxsCmacgklPzq+s+F0Luxzzig04rz+Sn5pSBGsONcasTBoGnn+qu3yoSw8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851643; c=relaxed/simple;
	bh=A5EK5ADDJtf/m9AC8Zq0tFJQ/q+jXyRw3I3TfBuAVlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nr0gvd0lGdK2cBwTQTeAms/352UP3R5OKWoVhpyZplIE/jzMyHT/gwTBsOy5vPzWTRY1E/7pmPw4W4JIvg/PKSXKluNJJFzUnQ7m21Ohqy1khqRgY2XRgXHVHEAkAnElp50VTvJONI5Ue/sBL4EQDHsC9GLvFOesbLdkj3ak8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85EAC2BD10;
	Mon,  1 Jul 2024 16:34:01 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>,
	Jonathan.Cameron@huawei.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH for-next/vcpu-hotplug] arm64: Kconfig: Fix dependencies to enable ACPI_HOTPLUG_CPU
Date: Mon,  1 Jul 2024 17:33:59 +0100
Message-Id: <171985163030.315467.4811657250595746324.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701001132.1585153-1-gshan@redhat.com>
References: <20240701001132.1585153-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 01 Jul 2024 10:11:32 +1000, Gavin Shan wrote:
> Both ACPI_PROCESSOR and HOTPLUG_CPU are needed by ACPI_HOTPLUG_CPU.
> Otherwise, we can have compiling error with the following configurations.
> 
>   CONFIG_HOTPLUG_CPU=n
>   CONFIG_ACPI_PROCESSOR=y
>   CONFIG_ACPI_HOTPLUG_CPU=y
> 
> [...]

Applied to arm64 (for-next/vcpu-hotplug), thanks!

[1/1] arm64: Kconfig: Fix dependencies to enable ACPI_HOTPLUG_CPU
      https://git.kernel.org/arm64/c/46800e38ef0e

-- 
Catalin


