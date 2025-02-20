Return-Path: <linux-kernel+bounces-523749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 929F0A3DAAF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B26016C7FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D0F1F76C0;
	Thu, 20 Feb 2025 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I9rMGuZJ"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B71F561B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056532; cv=none; b=UM+mmxjHMemOG98eCpFcfOPmZxn0TaUstQ7EW8sd13qaBzrvjYa0pjqPUyHjN/dgMVNRHyBkFqO634RxGut8BY2ZgxV9MzP/Z6MqIgpIQiCOO5Ec2/Dd4GwSt/L1xL7J6E+BKf1qI1feyyPk7ukMB1zU+ygdT8CKSzfeK+zgnco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056532; c=relaxed/simple;
	bh=HoqQPl5WNh81ytcpLYsVJDOIdbPoM6Aw2o0cWqE6Wak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqOSggO/ieS9BT15o+jqPxz1iwkJkBami3VMOeqp39aJT7NwJCm8zTxiZD723Rr1N/UskpEOmyScmRmrmtbGfkvoInuUzwWbytcB63EKaoEBm9dXjcpCG4MCfavC5RHQElUe0CrQFE0c7NOtRtlWc2AF9PLLE8I5ye/6CFVb+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I9rMGuZJ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8f0f70de-d3cf-4956-a5aa-c5bed91a61cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740056518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tk2n0Y50QyFeoq+91cfSIBmVd1XuNHVLziM+sS8UnqY=;
	b=I9rMGuZJodAakZLt0rexMUIQxukTxb4990H9S4mWR0iRr2QNbvghIURwbNodL8vhgIIkIp
	h6DlCbtZ0SA1oAbR8BixlCtDucuBEjSLEU1Zb4mIlrKDlT9/ph+laXkkcyMKoni0r/ph2/
	3fIW0G3/en/JPsYwxekWSalgTBX0grk=
Date: Thu, 20 Feb 2025 07:01:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Add SDCA register map support
To: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org
Cc: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
 yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org
References: <20250217140159.2288784-1-ckeepax@opensource.cirrus.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20250217140159.2288784-1-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/17/25 08:01, Charles Keepax wrote:
> This series is the next step of adding SDCA support. Here we add
> helper functions to allow drivers to easily use the SDCA DisCo
> information to create a register map for the device.

Can you remind me where we ended-up in the discussion on one regmap per physical device or one regmap per function?

The DisCo definition are all function-centric, but the physical SoundWire bus access for all read/writes is shared by all functions so having a single regmap isn't silly either.

> The basic idea here is the code takes the list of SDCA controls parsed
> from DisCo and uses primarily the Access Mode to determine if the
> register should be marked as readable/writable etc. Further more
> some additional concepts such as DisCo Constants and Defaults are
> handled. There is some potential confusion, as DisCo Constants are
> handled as an entry in the regmap defaults table, whereas a DisCo
> Default is simply handled as a write to the register. Alas the naming
> confusion is an unavoidable result of the slight impedance mismatch
> between the two systems.
> 
> Thanks,
> Charles
> 
> Charles Keepax (4):
>   regcache: Add support for sorting defaults arrays
>   ASoC: SDCA: Add generic regmap SDCA helpers
>   ASoC: SDCA: Add regmap helpers for parsing for DisCo Constant values
>   ASoC: SDCA: Add helper to write out defaults and fixed values

The code looks fine, thanks!

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

> 
>  drivers/base/regmap/regcache.c |  31 ++++
>  include/linux/regmap.h         |   7 +
>  include/sound/sdca_regmap.h    |  31 ++++
>  sound/soc/sdca/Makefile        |   2 +-
>  sound/soc/sdca/sdca_regmap.c   | 321 +++++++++++++++++++++++++++++++++
>  5 files changed, 391 insertions(+), 1 deletion(-)
>  create mode 100644 include/sound/sdca_regmap.h
>  create mode 100644 sound/soc/sdca/sdca_regmap.c
> 


