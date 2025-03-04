Return-Path: <linux-kernel+bounces-543941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C2BA4DBB0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67C8189C42A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50943204592;
	Tue,  4 Mar 2025 10:58:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F13204582
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085910; cv=none; b=mp16oXODCIZ7YLSIE2l40jl1BO+U7CIONYQdsTyHR8AvdF57dvDjaDLpIYRTVamZTdbSCXxXFZy6H7spefM57iIlsKKbrNXs7z/ELI7n0Dm6fo+GA1DS5spRErZDrUiBXu6h7hsVhbOfqjLOLnwFVvvf+kuYmnMLBVbbqD5kjbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085910; c=relaxed/simple;
	bh=DCii+rnTvH4NBAmHMwhIHUi8ysLfX718DpGn3wLPEhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2N4kV/CBDlhCI7KbL7l96qG9cQND8aE1Ic5Iouu+JNzr0d3YAvGEGdNW/6J0iJzS/rbbr6kNNQokA8PlwunG9+Aw25mJEnOBMoWRYYnQ9irjBSl7ItsxyTvEDi05jl1rhn6miAUttybipTFHg6j66G+BYmVYxU0ERN9CEDxRYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04CF1FEC;
	Tue,  4 Mar 2025 02:58:42 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 186723F5A1;
	Tue,  4 Mar 2025 02:58:26 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	Paul Benoit <paul@os.amperecomputing.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] firmware: smccc: Support optional Arm SMC SOC_ID name
Date: Tue,  4 Mar 2025 10:58:24 +0000
Message-Id: <174108587625.432485.15057756163207597336.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219005932.3466-1-paul@os.amperecomputing.com>
References: <20241114030452.10149-1-paul@os.amperecomputing.com> <20250219005932.3466-1-paul@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 18 Feb 2025 16:59:32 -0800, Paul Benoit wrote:
> Issue Number 1.6 of the Arm SMC Calling Convention introduces an optional
> SOC_ID name string.  If implemented, point the 'machine' field of the SoC
> Device Attributes at this string so that it will appear under
> /sys/bus/soc/devices/soc0/machine.
>
> On Arm SMC compliant SoCs, this will allow things like 'lscpu' to
> eventually get a SoC provider model name from there rather than each
> tool/utility needing to get a possibly inconsistent, obsolete, or incorrect
> model/machine name from its own hardcoded model/machine name table.
>
> [...]

Applied to sudeep.holla/linux (for-linux-next), thanks!

[1/1] firmware: smccc: Support optional Arm SMC SOC_ID name
      https://git.kernel.org/sudeep.holla/c/5f9c23abc477
--
Regards,
Sudeep


