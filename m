Return-Path: <linux-kernel+bounces-190416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAFE8CFDFF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5722838ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0624E13AD30;
	Mon, 27 May 2024 10:22:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DCB1327E5
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805370; cv=none; b=u7ngnBQMs7OkaLDmnOth3/TcujsKliiOQZ2+Wps7nUNpy3VC9jD94pRUV/2NYZVwXntzbKzvqrFz2xYjk+Vw2F5qraxUxQyXXnO9o/MF92DgJSQzORx8eg141GBSyTQuTE0ToER+Fj9vbMSk+jmiIB7UtFxFmdy8i6Ou4Gj7wws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805370; c=relaxed/simple;
	bh=FtDzif+OHKpF5SpOTyoYtdxwU3EKu9/WMmOgQ+TGsuM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SdsI/062POq1cbp7nEmktxhmzLirMEJbe2zL/fruPb05F6tHlDGjGJE9XmFkgPCUdR/CKVY8Fe0goR0QTT4OSmIJ3H459Q3UABHBrlnOpVd4b3MCZTdtEJrNRD2l8ZjT8JZyXbEhAky+y7uPg3xTdhFb0KQ0warOIeJF+BgPv4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0680FC2BBFC;
	Mon, 27 May 2024 10:22:50 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id A6FD0106134B; Mon, 27 May 2024 12:22:47 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sebastian Reichel <sre@kernel.org>
In-Reply-To: <20240508114150.958025-1-andriy.shevchenko@linux.intel.com>
References: <20240508114150.958025-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] HSI: ssi_protocol: Remove unused linux/gpio.h
Message-Id: <171680536766.234580.15044256450191135390.b4-ty@collabora.com>
Date: Mon, 27 May 2024 12:22:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 08 May 2024 14:41:49 +0300, Andy Shevchenko wrote:
> linux/gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> 

Applied, thanks!

[1/1] HSI: ssi_protocol: Remove unused linux/gpio.h
      commit: f02cfe6950479b04fb75cf8424a852af7c50d3ad

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


