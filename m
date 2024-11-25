Return-Path: <linux-kernel+bounces-421545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 592AF9D8CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18922864E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD371BC9F6;
	Mon, 25 Nov 2024 19:12:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D939B1BBBDD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732561974; cv=none; b=L7VEuV4MoeD+0d5rw85WfYrWs88jXyUl1FW5UIq0UQgNXv3MCp66A6g2r9okp/GdA9ns20bs8lnnJOtv2UlqQESKKxyQKp6snxltRzubKwHZQYtKDsHkpgWhbqrQOoEvws/kqjqc7L0jIm2nmRb5h3eM2QcDVIO+Ea5GXWegqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732561974; c=relaxed/simple;
	bh=EgdOC8+q+Gfz9CllZJ6ClBHaXjnR2BX6q7DE2CzdoGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWiFhVxiH9MYY4LSFkAC9+WXnOdSsYZmcgeJaY1OOe4NoHvlTAY9Rf9UI3PESfFmYvatGGB1elozZJVEpKeSQSp4+sv8xoUvqHPvZeImQFUUlDyuYGOSoYazYKrhmh8gJkwOV5x+zZmv8u0v4Pi039Lc4YhORP72ZW803zqCebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85486C4CED2;
	Mon, 25 Nov 2024 19:12:51 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-kernel@vger.kernel.org,
	Chun-Tse Shao <ctshao@google.com>
Cc: Will Deacon <will@kernel.org>,
	Greg Thelen <gthelen@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tuan Phan <tuanphan@os.amperecomputing.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf/arm-smmuv3: Fix lockdep assert in ->event_init()
Date: Mon, 25 Nov 2024 19:12:49 +0000
Message-Id: <173256196647.1188888.266499753445785167.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108050806.3730811-1-ctshao@google.com>
References: <20241108050806.3730811-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 08 Nov 2024 05:08:05 +0000, Chun-Tse Shao wrote:
> Same as
> https://lore.kernel.org/all/20240514180050.182454-1-namhyung@kernel.org/,
> we should skip `for_each_sibling_event()` for group leader since it
> doesn't have the ctx yet.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf/arm-smmuv3: Fix lockdep assert in ->event_init()
      https://git.kernel.org/arm64/c/02a55f274301

-- 
Catalin


