Return-Path: <linux-kernel+bounces-525686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715A5A3F32B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590B542100F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D3920968E;
	Fri, 21 Feb 2025 11:41:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC920897E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138107; cv=none; b=YH8OHQkH7APRIYRQMmS0rd7WNeD7KU1thz/jvpKmAlPajUldc3ZRx6mMuFl9/eYE5wCA3jI2obzBtecN1C2BN49KEprlCEaZ9stNYbmuf5TpaUd5pC7BLoBWMsqyTznYluDNwmARFOCU/QvA60DWcT+ylLvV2QHm5PvqfYYMArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138107; c=relaxed/simple;
	bh=EU4gT+yWhR6POsKBTk7/pIXyLA6D5IYvs/INDP8N74E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSx+cNz2PNVqtUKcslI72FumI612rR8vmM9silKYloI7XhD268wNcQMHJvsy/zKzgnGqxvc9g/pyOezpomdKXlguYQN24fiBuPTyd8FKlsH7XfRqFIwAb1SuRDrMg2v81fni+pcWJW0zvCK/Jq1z3FH2cmtQXOlGxwEqPxolXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDED11516;
	Fri, 21 Feb 2025 03:42:01 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5096C3F59E;
	Fri, 21 Feb 2025 03:41:43 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 00/19] firmware: arm_ffa: Framework notification support + other updates and fixes
Date: Fri, 21 Feb 2025 11:41:40 +0000
Message-Id: <174013805847.529189.4816218083284057863.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 17 Feb 2025 15:38:41 +0000, Sudeep Holla wrote:
> This bundle of changes mainly have FF-A framework notification support
> along with other minor updates and fixes.
> 
> It adds support to allow multiple UUIDs per partition to register
> individual SRI callback, to handle Rx buffer full framework notification
> in particular and general framework/interface to extend in the future.
> 
> [...]

Applied to sudeep.holla/linux (for-next/ffa/updates), thanks!

[01/19] firmware: arm_ffa: Replace SCMI by FF-A in the macro
        https://git.kernel.org/sudeep.holla/c/1ed14652dc32
[02/19] firmware: arm_ffa: Replace UUID buffer to standard UUID format
        https://git.kernel.org/sudeep.holla/c/b7c9f32614f1
[03/19] firmware: arm_ffa: Align sync_send_receive{,2} function prototypes
        https://git.kernel.org/sudeep.holla/c/8768972cbbea
[04/19] firmware: arm_ffa: Fix big-endian support in __ffa_partition_info_get()
        https://git.kernel.org/sudeep.holla/c/f94ebb724067
[05/19] firmware: arm_ffa: Fix big-endian support in __ffa_partition_info_regs_get()
        https://git.kernel.org/sudeep.holla/c/7bc0f589c81d
[06/19] firmware: arm_ffa: Refactor addition of partition information into XArray
        https://git.kernel.org/sudeep.holla/c/3c3d6767466e
[07/19] firmware: arm_ffa: Handle the presence of host partition in the partition info
        https://git.kernel.org/sudeep.holla/c/2f622a8b0722
[08/19] firmware: arm_ffa: Unregister the FF-A devices when cleaning up the partitions
        https://git.kernel.org/sudeep.holla/c/46dcd68aacca
[09/19] firmware: arm_ffa: Helper to check if a partition can receive REQUEST2 messages
        https://git.kernel.org/sudeep.holla/c/84968e32d301
[10/19] firmware: arm_ffa: Add support for passing UUID in FFA_MSG_SEND2
        https://git.kernel.org/sudeep.holla/c/910cc1acc9b4
[11/19] firmware: arm_ffa: Upgrade FF-A version to v1.2 in the driver
        https://git.kernel.org/sudeep.holla/c/9fac08d9d985
[12/19] firmware: arm_ffa: Reject higher major version as incompatible
        https://git.kernel.org/sudeep.holla/c/efff6a7f16b3
[13/19] firmware: arm_ffa: Remove unnecessary declaration of ffa_partitions_cleanup()
        https://git.kernel.org/sudeep.holla/c/9982cabf403f
[14/19] firmware: arm_ffa: Refactoring to prepare for framework notification support
        https://git.kernel.org/sudeep.holla/c/07b760e71325
[15/19] firmware: arm_ffa: Stash ffa_device instead of notify_type in notifier_cb_info
        https://git.kernel.org/sudeep.holla/c/a3d73fe8ae5d
[16/19] firmware: arm_ffa: Add support for {un,}registration of framework notifications
        https://git.kernel.org/sudeep.holla/c/c10debfe7f02
[17/19] firmware: arm_ffa: Add support for handling framework notifications
        https://git.kernel.org/sudeep.holla/c/285a5ea0f542
[18/19] firmware: arm_ffa: Allow multiple UUIDs per partition to register SRI callback
        https://git.kernel.org/sudeep.holla/c/be61da938576
[19/19] firmware: arm_ffa: Handle ffa_notification_get correctly at virtual FF-A instance
        https://git.kernel.org/sudeep.holla/c/9472fe20d396
--
Regards,
Sudeep


