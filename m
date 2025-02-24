Return-Path: <linux-kernel+bounces-529643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F5FA42914
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A394188DD0C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F2726159A;
	Mon, 24 Feb 2025 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHiKVSf+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0CF146A6F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416944; cv=none; b=BGORwq3/9NqC2fKwSMlw198BxpPoZj41c/kJHPYat5YZRtnhsaCbOUPlVA1oG/cqIdmkpDJoGwstiRfNousJVcBFznuMMz8y7zGwiypvNGpXXz4KQBlDtI5h4n3zg3RckYdwU6SsNREFRGrzYEE+kKKAxx3qecJj/t8s5uu76fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416944; c=relaxed/simple;
	bh=f3FWAWqKObBU7iKw0nZ9RZrNN4S7jDVi0Qku/f/biv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ckiJiVE27Uiesb1WHJj9Q9vQW3ZkbQcefiquqoSWOZDkQmqMeGXuUW5kWGZdU/6HZmuALz9YJqWye932HIgtxPd/l5JAKjNEFQGdrLThaI1EOnnZp2YIatnp2GFTskaci6QtsDggLh+DwK86JUsWF4ACSIxubgqjsqD6OiMXFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHiKVSf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B77C4CED6;
	Mon, 24 Feb 2025 17:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740416944;
	bh=f3FWAWqKObBU7iKw0nZ9RZrNN4S7jDVi0Qku/f/biv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sHiKVSf+mE/PTtYlQ9mYjKF9Y0zbDlyq2ehTJ7Bk/U0WosG1elNo02pi4EYnUNz0t
	 AXYg1cON8o1ayNWx5+ffQqzEKUPkBvFJXnPY0n3fxun1IO6auYtyXYuygoswTBYaIp
	 +87bmcdw04lymq+RmN7dKhFCDOzxvVt+j6uoSuOYrZxySNPyw4G7GHiI4pna6gll3e
	 M3VOUbDj4gVCfRESrQsRwCVD7WpiSU0gKXiYn1Bze2UJk9Ga8e6vcg5uWEskd2FPo2
	 uG+UolnQMQ5k6R90HM06C07oloOcmB4WhS/U2qPqEVe+zPo5rv3UuJq64BxBDGK/dj
	 sJEMtl4C3Nefg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,  Richard
 Weinberger <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: explicitly include <linux/math64.h>
In-Reply-To: <20250223-snor-math64-v2-1-6f0313eea331@linaro.org> (Tudor
	Ambarus's message of "Sun, 23 Feb 2025 06:51:10 +0000")
References: <20250223-snor-math64-v2-1-6f0313eea331@linaro.org>
Date: Mon, 24 Feb 2025 17:09:01 +0000
Message-ID: <mafs0bjurl176.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Feb 23 2025, Tudor Ambarus wrote:

> swp and otp drivers use div_u64 and div64_u64 and rely on implicit
> inclusion of <linux/math64.h>.
>
> It is good practice to directly include all headers used, it avoids
> implicit dependencies and spurious breakage if someone rearranges
> headers and causes the implicit include to vanish.
>
> Include the missing header.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

