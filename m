Return-Path: <linux-kernel+bounces-421138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AD69D873D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB9BB2E8D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBDF1AE863;
	Mon, 25 Nov 2024 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4jYnK1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3821ADFF1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543175; cv=none; b=SYBOba9ti/vvJjD0lsSnMqRbu4rQSmU6JMe2UpJcbJdfT09i1L6jjRjdKTIYIfpx5JSXFvZ594fkdM1/POPVZAMq1nMMuiCc1US+IaQJ6Yv6Yto8ciY9+cMJSXEjN15oGCTqm//yqQ06LiTOXpdQDbIMzBeKkngCN0XnnLaSRZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543175; c=relaxed/simple;
	bh=ucAXv8kZ12VdJYQNdB6I+hwZKHGi3nJZiEs0F3G7qrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RrbEUx/JcrOPWQL76Mq2XLAws2cDwTLHSM95cucXKboOJo4Rthg2oX2dOYeSeXHYziO8D4ObRJWPUClPE/Mhph7ZCNTNf2OiujrQcYlvF+UptcXaqXQIEKkyOEGXVg9zL6f9au5iGEPib6SudjL2rG4HoPNFw4ddQCO0L//zVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4jYnK1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA9CC4CECE;
	Mon, 25 Nov 2024 13:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543174;
	bh=ucAXv8kZ12VdJYQNdB6I+hwZKHGi3nJZiEs0F3G7qrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=G4jYnK1HTsvPIfacNb/NJRXwWcl201z57V7DT9T4Ki7WUujm6XuQSSBmhaUymXY9O
	 eeM98xHpUdRW+5tbURoiWxFkkcSbOKl/niDgU+UjId6uaRdjrWz6gcO8MRFhXSRsrX
	 7jPR6uGgU7hbIeKahgJXxif3t+0hr7tk7SukGkaUXwPYJjE34pG72ST8wPpXPIqTQB
	 1lsTRmJfygwb5Rnev+HjbciFSzOwpOKpKzQ/kFTtVP56yr3r67VKktwf0MMX0WJbXG
	 jclfumjVCz9qDCKWkffMZdfdY5Hh+bwIaFdNa0ez8xDbaPy6NF9lb1+CCBhNIHL47R
	 1qpWjN2NIfSUA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Parth Pancholi <parth105105@gmail.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Parth Pancholi
 <parth.pancholi@toradex.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: remove mx25u25635f from
 parts list to enable SFDP
In-Reply-To: <0525af7c-f9a9-4dfc-9fed-97efc438b2b8@linaro.org> (Tudor
	Ambarus's message of "Mon, 11 Nov 2024 10:49:12 +0000")
References: <20241105105844.257676-1-parth105105@gmail.com>
	<0525af7c-f9a9-4dfc-9fed-97efc438b2b8@linaro.org>
Date: Mon, 25 Nov 2024 13:59:32 +0000
Message-ID: <mafs0iksb5s8r.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 11 2024, Tudor Ambarus wrote:

> On 11/5/24 10:58 AM, Parth Pancholi wrote:
>> From: Parth Pancholi <parth.pancholi@toradex.com>
>> 
>> The Macronix mx25u25635f flash device supports SFDP initialization.
>> This commit removes the specific mx25u25635f entry (NOR ID 0xc22539),
>> along with its size and flags, from the NOR parts list. By removing
>> this entry, both mx25u25635f and mx25u25645g (which share the same
>> NOR ID) will utilize the generic flash driver configuration.
>> 
>> This change allows both devices (mx25u25635f and mx25u25645g) to
>> leverage SFDP-defined parameters, enabling dual and quad read
>> operations without the need for manual adjustment of no_sfdp_flags.
>
> I'm fine with this. We may re-add an entry when BP is used or if someone
> reports there's a flash with this ID that doesn't support SFDP, which
> has a reasonable amount of probability for macronix flashes, but I'm ok
> taking the risk and fixing it afterwards if reported.

Sounds good. Would be a good idea to queue it early after -rc1 so it
gets some time to bake in linux-next.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

