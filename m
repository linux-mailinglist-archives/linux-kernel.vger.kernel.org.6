Return-Path: <linux-kernel+bounces-432963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F729E526A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF8E1880A56
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659821D5AB9;
	Thu,  5 Dec 2024 10:35:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12EF2F56
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394934; cv=none; b=IT5gnxm0sB2HG5pASkyPzWwBlZ1S7Ipiq6Pxj9sv/oXI/RNQUpiYOLpFq0en5cPXXwRJDQyPryZJ3JADI2VPmxxQ1OWwU/wcGCVKa9rH7OxYjfz0QD5aq1s+xGEVi3pny4fEhK1e3KMFLZGQZ6nipkNqcUXsy1kEjIBfIlcxPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394934; c=relaxed/simple;
	bh=yMSma1kuP3fghAqZASxr8QrQFqpomxq2UBhGfC1pTvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhJi65d/eoZ6jjI6HaOwIZJEoZiv1ZwbMXfVmhErf8Oyk915BXUM91aa/QLwPu49Q+dS6gtNWSBQ3ys7qiIGqjtmXQsiiZGGP2lHYnP0bIX9NdkD5hQq8MI2NJzrcF4J2zdDmkFWyjz10eYxUNzAWQy8DEL7d5QXKcAOtfFlscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41174FEC;
	Thu,  5 Dec 2024 02:35:59 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 574A23F5A1;
	Thu,  5 Dec 2024 02:35:30 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com
Subject: Re: [PATCH v2 0/2] small fixes for arm_ffa driver
Date: Thu,  5 Dec 2024 10:35:03 +0000
Message-Id: <173339480142.692288.1444653013736952859.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203143109.1030514-1-yeoreum.yun@arm.com>
References: <20241203143109.1030514-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 03 Dec 2024 14:31:07 +0000, Yeoreum Yun wrote:
> This patchset small fixes for arm_ffa driver:
>     - change ffa_device_register()'s declaration and its return value.
>     - fix direct message request version 2 uuid setup.
>
>
> v1 -> v2:
>     - Restore error return in ffa_device_register().
>     - change type __be64 to unsigned long to suppress warning.
>
> [...]

Applied with some reformating/reworking of the commit messages including
$subject change to sudeep.holla/linux (for-next/ffa/fixes), thanks!

[1/2] firmware/arm_ffa: change ffa_device_register()'s parameters and return
      https://git.kernel.org/sudeep.holla/c/6fe437cfe2cd
[2/2] firmware/arm_ffa: remove __le64_to_cpu() when set uuid for direct msg v2
      https://git.kernel.org/sudeep.holla/c/81c8b1c2ef7a
--
Regards,
Sudeep


